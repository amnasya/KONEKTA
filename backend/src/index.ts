import express, { Application, Request, Response } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import dashboardRouter from './routes/dashboard';
import campaignRouter  from './routes/campaign';
import exploreRouter   from './routes/explore';

dotenv.config();

const app: Application = express();
const PORT = Number(process.env.PORT ?? 3000);

// ── Middleware ────────────────────────────────────────────────────────────────
app.use(cors());
app.use(express.json());

// ── Routes ────────────────────────────────────────────────────────────────────
app.use('/api/dashboard', dashboardRouter);
app.use('/api/campaign',  campaignRouter);
app.use('/api/explore',   exploreRouter);

app.get('/health', (_req: Request, res: Response) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// ── Start ─────────────────────────────────────────────────────────────────────
app.listen(PORT, () => {
  console.log(`✅  Konekta API running → http://localhost:${PORT}`);
});
