USE konekta;

-- Brands table
CREATE TABLE IF NOT EXISTS brands (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(150) NOT NULL,
  category    VARCHAR(100) NOT NULL,
  logo_url    VARCHAR(500) DEFAULT NULL,
  verified    TINYINT(1)   DEFAULT 0,
  created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- Extend campaigns table
ALTER TABLE campaigns
  ADD COLUMN IF NOT EXISTS brand_id         INT          DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS description      TEXT         DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS budget           DECIMAL(15,2) DEFAULT 0,
  ADD COLUMN IF NOT EXISTS deadline_days    INT          DEFAULT 0,
  ADD COLUMN IF NOT EXISTS min_followers    INT          DEFAULT 0,
  ADD COLUMN IF NOT EXISTS content_type     VARCHAR(100) DEFAULT 'Video',
  ADD COLUMN IF NOT EXISTS target_audience  VARCHAR(200) DEFAULT NULL,
  ADD FOREIGN KEY (brand_id) REFERENCES brands(id);

-- Platforms per campaign (many-to-many)
CREATE TABLE IF NOT EXISTS campaign_platforms (
  campaign_id INT NOT NULL,
  platform    VARCHAR(50) NOT NULL,
  PRIMARY KEY (campaign_id, platform),
  FOREIGN KEY (campaign_id) REFERENCES campaigns(id)
);

-- Deliverables per campaign
CREATE TABLE IF NOT EXISTS campaign_deliverables (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  campaign_id INT NOT NULL,
  description VARCHAR(300) NOT NULL,
  FOREIGN KEY (campaign_id) REFERENCES campaigns(id)
);

-- Applications (track if influencer already applied)
CREATE TABLE IF NOT EXISTS campaign_applications (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  campaign_id INT NOT NULL,
  user_id     INT NOT NULL,
  status      ENUM('pending','accepted','rejected') DEFAULT 'pending',
  applied_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_application (campaign_id, user_id),
  FOREIGN KEY (campaign_id) REFERENCES campaigns(id),
  FOREIGN KEY (user_id)     REFERENCES users(id)
);

-- ── Seed ─────────────────────────────────────────────────────────────────────
INSERT INTO brands (name, category, logo_url, verified) VALUES
  ('NutriBox',       'Food & Health', NULL, 1),
  ('Glow Skincare',  'Beauty',        NULL, 1),
  ('TechGear ID',    'Technology',    NULL, 0),
  ('UrbanWear',      'Fashion',       NULL, 1),
  ('Kopi Nusantara', 'F&B',           NULL, 1);

-- Update existing campaigns with brand + detail data
UPDATE campaigns SET
  brand_id        = 1,
  description     = 'Create an authentic unboxing video of our weekly meal kit. Show the ingredients, preparation steps, and your honest reaction. We want real, relatable content that resonates with health-conscious audiences.',
  budget          = 1800000,
  deadline_days   = 10,
  min_followers   = 15000,
  content_type    = 'Video',
  target_audience = 'Food / Lifestyle',
  status          = 'IN PROGRESS'
WHERE id = 1;

UPDATE campaigns SET
  brand_id        = 2,
  description     = 'Review our new vitamin C serum line. Share your skincare routine and honest before/after results. Target Gen Z audience who care about clean beauty.',
  budget          = 1500000,
  deadline_days   = 7,
  min_followers   = 5000,
  content_type    = 'Video + Photo',
  target_audience = 'Beauty / Skincare',
  status          = 'IN PROGRESS'
WHERE id = 2;

-- Platforms
INSERT IGNORE INTO campaign_platforms (campaign_id, platform) VALUES
  (1, 'TikTok'), (1, 'Instagram'),
  (2, 'Instagram');

-- Deliverables
INSERT INTO campaign_deliverables (campaign_id, description) VALUES
  (1, '1 TikTok video (min. 60 seconds)'),
  (1, '1 Instagram Reel'),
  (1, '3 Instagram Stories with swipe-up link'),
  (2, '1 Instagram Reel (before/after)'),
  (2, '1 TikTok review video'),
  (2, '5 Instagram Stories');
