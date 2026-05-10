export interface UserStats {
  username: string;
  thisMonthEarnings: number;
  pendingBalance: number;
  totalViews: number;
  engagement: number;
}

export interface Campaign {
  id: number;
  title: string;
  daysLeft: number;
  progress: number;
  targetViews: number;
  targetEngagement: number;
  status: 'IN PROGRESS' | 'PENDING' | 'COMPLETED';
}

export interface DashboardResponse {
  user: UserStats;
  campaigns: Campaign[];
}

// Raw rows returned from MySQL queries
export interface UserStatsRow {
  id: number;
  username: string;
  thisMonthEarnings: string | number;
  pendingBalance: string | number;
  totalViews: string | number;
  engagement: string | number;
}

export interface CampaignRow {
  id: number;
  title: string;
  daysLeft: string | number;
  progress: number;
  targetViews: number;
  targetEngagement: number;
  status: 'IN PROGRESS' | 'PENDING' | 'COMPLETED';
}
