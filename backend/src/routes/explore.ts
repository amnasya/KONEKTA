import { Router, Request, Response } from 'express';
import { RowDataPacket } from 'mysql2';
import pool from '../db';

const router = Router();

// ── GET /api/explore ──────────────────────────────────────────────────────────
// Returns campaigns + brands for the explore screen
router.get('/', async (_req: Request, res: Response): Promise<void> => {
  try {
    // ── Campaigns ─────────────────────────────────────────────────────────────
    const [campaignRows] = await pool.query<RowDataPacket[]>(
      `SELECT
         c.id,
         c.title,
         c.description,
         c.budget,
         c.deadline_days,
         c.min_followers,
         c.content_type,
         c.status,
         b.name     AS brand_name,
         b.category AS brand_category
       FROM campaigns c
       LEFT JOIN brands b ON b.id = c.brand_id
       ORDER BY c.id ASC`
    );

    // Platforms per campaign
    const [platformRows] = await pool.query<RowDataPacket[]>(
      `SELECT campaign_id, platform FROM campaign_platforms`
    );
    const platformMap: Record<number, string[]> = {};
    for (const p of platformRows as { campaign_id: number; platform: string }[]) {
      if (!platformMap[p.campaign_id]) platformMap[p.campaign_id] = [];
      platformMap[p.campaign_id].push(p.platform);
    }

    const campaigns = (campaignRows as any[]).map((c) => {
      const rawStatus = (c.status ?? '').toUpperCase();
      const isOpen = rawStatus === 'IN PROGRESS' || rawStatus === 'PENDING';
      const platforms: string[] = platformMap[c.id] ?? [];
      return {
        id:           c.id,
        title:        c.title,
        brand:        c.brand_name   ?? 'Unknown Brand',
        category:     c.brand_category ?? 'Other',
        description:  c.description  ?? '',
        budget:       Number(c.budget),
        deadlineDays: c.deadline_days,
        minFollowers: c.min_followers,
        platforms,
        isOpen,
      };
    });

    // ── Brands ────────────────────────────────────────────────────────────────
    const [brandRows] = await pool.query<RowDataPacket[]>(
      `SELECT id, name, category, verified FROM brands ORDER BY id ASC`
    );

    const brands = (brandRows as any[]).map((b) => ({
      id:       b.id,
      name:     b.name,
      category: b.category,
      verified: Boolean(b.verified),
    }));

    res.json({ campaigns, brands });
  } catch (err) {
    const message = err instanceof Error ? err.message : 'Unknown error';
    console.error('[Explore Error]', message);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
