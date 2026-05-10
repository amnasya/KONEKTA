import { Router, Request, Response } from 'express';
import { RowDataPacket } from 'mysql2';
import pool from '../db';
import { CampaignRow, CampaignDetailResponse } from '../types/campaign.types';

const router = Router();

// ── GET /api/campaign/:id ─────────────────────────────────────────────────────
router.get('/:id', async (req: Request, res: Response): Promise<void> => {
  const campaignId = Number(req.params.id);
  const userId     = Number(req.query.userId ?? 0); // optional: check if applied

  if (isNaN(campaignId) || campaignId <= 0) {
    res.status(400).json({ error: 'Invalid campaign id' });
    return;
  }

  try {
    // ── Main campaign row ────────────────────────────────────────────────────
    const [rows] = await pool.query<RowDataPacket[]>(
      `SELECT
         c.id,
         c.title,
         c.description,
         c.budget,
         c.deadline_days,
         c.status,
         c.min_followers,
         c.content_type,
         c.target_audience,
         b.name        AS brand_name,
         b.category    AS brand_category,
         b.logo_url    AS brand_logo,
         b.verified    AS brand_verified
       FROM campaigns c
       LEFT JOIN brands b ON b.id = c.brand_id
       WHERE c.id = ?`,
      [campaignId]
    );

    if (rows.length === 0) {
      res.status(404).json({ error: 'Campaign not found' });
      return;
    }

    const row = rows[0] as CampaignRow;

    // ── Platforms ────────────────────────────────────────────────────────────
    const [platformRows] = await pool.query<RowDataPacket[]>(
      `SELECT platform FROM campaign_platforms WHERE campaign_id = ?`,
      [campaignId]
    );
    const platforms = (platformRows as { platform: string }[]).map(
      (p) => p.platform
    );

    // ── Deliverables ─────────────────────────────────────────────────────────
    const [deliverableRows] = await pool.query<RowDataPacket[]>(
      `SELECT description FROM campaign_deliverables WHERE campaign_id = ? ORDER BY id`,
      [campaignId]
    );
    const deliverables = (deliverableRows as { description: string }[]).map(
      (d) => d.description
    );

    // ── Already applied? ─────────────────────────────────────────────────────
    let alreadyApplied = false;
    if (userId > 0) {
      const [appRows] = await pool.query<RowDataPacket[]>(
        `SELECT id FROM campaign_applications WHERE campaign_id = ? AND user_id = ?`,
        [campaignId, userId]
      );
      alreadyApplied = appRows.length > 0;
    }

    // ── Map status ───────────────────────────────────────────────────────────
    const rawStatus = row.status?.toUpperCase() ?? '';
    const status: CampaignDetailResponse['status'] =
      rawStatus === 'COMPLETED' ? 'CLOSED'
      : rawStatus === 'IN PROGRESS' ? 'OPEN'
      : rawStatus === 'PENDING' ? 'OPEN'
      : 'CLOSED';

    const response: CampaignDetailResponse = {
      id:          row.id,
      title:       row.title,
      description: row.description ?? '',
      budget:      Number(row.budget),
      deadline:    row.deadline_days,
      status,
      brand: {
        name:     row.brand_name  ?? 'Unknown Brand',
        category: row.brand_category ?? '',
        logo:     row.brand_logo  ?? null,
        verified: Boolean(row.brand_verified),
      },
      requirements: {
        minFollowers: row.min_followers,
        platforms,
        contentType:  row.content_type ?? 'Video',
        audience:     row.target_audience ?? '',
      },
      details: { deliverables },
      alreadyApplied,
    };

    res.json(response);
  } catch (err) {
    const message = err instanceof Error ? err.message : 'Unknown error';
    console.error('[Campaign Detail Error]', message);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// ── POST /api/campaign/:id/apply ─────────────────────────────────────────────
router.post('/:id/apply', async (req: Request, res: Response): Promise<void> => {
  const campaignId = Number(req.params.id);
  const { userId } = req.body as { userId: number };

  if (!userId || isNaN(campaignId)) {
    res.status(400).json({ error: 'campaignId and userId are required' });
    return;
  }

  try {
    await pool.query(
      `INSERT IGNORE INTO campaign_applications (campaign_id, user_id) VALUES (?, ?)`,
      [campaignId, userId]
    );
    res.json({ success: true, message: 'Application submitted' });
  } catch (err) {
    const message = err instanceof Error ? err.message : 'Unknown error';
    console.error('[Apply Error]', message);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
