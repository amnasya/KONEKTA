export interface CampaignDetailResponse {
  id: number;
  title: string;
  description: string;
  budget: number;
  deadline: number;
  status: 'OPEN' | 'CLOSED' | 'IN PROGRESS' | 'COMPLETED';
  brand: {
    name: string;
    category: string;
    logo: string | null;
    verified: boolean;
  };
  requirements: {
    minFollowers: number;
    platforms: string[];
    contentType: string;
    audience: string;
  };
  details: {
    deliverables: string[];
  };
  alreadyApplied: boolean;
}

// Raw DB rows
export interface CampaignRow {
  id: number;
  title: string;
  description: string | null;
  budget: string | number;
  deadline_days: number;
  status: string;
  brand_name: string;
  brand_category: string;
  brand_logo: string | null;
  brand_verified: number;
  min_followers: number;
  content_type: string;
  target_audience: string | null;
}
