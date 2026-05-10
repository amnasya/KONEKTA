import { Router, Request, Response } from 'express';
import { ResultSetHeader, RowDataPacket } from 'mysql2';
import pool from '../db';
import {
  UserStatsRow,
  CampaignRow,
  DashboardResponse,
} from '../types/dashboard.types';

const router = Router();

// GET /api/dashboard/:userId
router.get('/:userId', async (req: Request, res: Response): Promise<void> => {
  const userId = Number(req.params.userId);

  if (isNaN(userId) || userId <= 0) {
    res.status(400).json({ error: 'Invalid userId' });
    return;
  }

  try {
    // ── User stats ────────────────────────────────────────────────────────────
    const [userRows] = await pool.query<RowDataPacket[]>(
      `SELECT
         u.id,
         u.username,
         COALESCE(SUM(
           CASE WHEN p.month = MONTH(NOW()) AND p.year = YEAR(NOW())
                AND p.status = 'paid'
                THEN p.amount ELSE 0 END
         ), 0) AS thisMonthEarnings,
         COALESCE(SUM(
           CASE WHEN p.status = 'pending' THEN p.amount ELSE 0 END
         ), 0) AS pendingBalance,
         COALESCE(SUM(s.views), 0)      AS totalViews,
         COALESCE(SUM(s.engagement), 0) AS engagement
       FROM users u
       LEFT JOIN payments p ON p.user_id = u.id
       LEFT JOIN stats s
         ON s.user_id = u.id
        AND s.recorded_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)
       WHERE u.id = ?
       GROUP BY u.id`,
      [userId]
    );

    if (userRows.length === 0) {
      res.status(404).json({ error: 'User not found' });
      return;
    }

    const row = userRows[0] as UserStatsRow;

    // ── Campaigns ─────────────────────────────────────────────────────────────
    const [campaignRows] = await pool.query<RowDataPacket[]>(
      `SELECT
         c.id,
         c.title,
         GREATEST(0, DATEDIFF(c.end_date, NOW())) AS daysLeft,
         c.progress,
         c.target_views       AS targetViews,
         c.target_engagement  AS targetEngagement,
         c.status
       FROM campaigns c
       INNER JOIN campaign_influencers ci ON ci.campaign_id = c.id
       WHERE ci.user_id = ?
         AND c.status IN ('IN PROGRESS', 'PENDING')
       ORDER BY c.end_date ASC`,
      [userId]
    );

    const campaigns = (campaignRows as CampaignRow[]).map((c) => ({
      id: c.id,
      title: c.title,
      daysLeft: Number(c.daysLeft),
      progress: c.progress,
      targetViews: c.targetViews,
      targetEngagement: c.targetEngagement,
      status: c.status,
    }));

    const response: DashboardResponse = {
      user: {
        username: row.username,
        thisMonthEarnings: Number(row.thisMonthEarnings),
        pendingBalance: Number(row.pendingBalance),
        totalViews: Number(row.totalViews),
        engagement: Number(row.engagement),
      },
      campaigns,
    };

    res.json(response);
  } catch (err) {
    const message = err instanceof Error ? err.message : 'Unknown error';
    console.error('[Dashboard Error]', message);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
