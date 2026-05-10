CREATE DATABASE IF NOT EXISTS konekta;
USE konekta;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS payments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  amount DECIMAL(15,2) NOT NULL DEFAULT 0,
  status ENUM('paid','pending') DEFAULT 'pending',
  month TINYINT NOT NULL,
  year SMALLINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS stats (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  views INT DEFAULT 0,
  engagement INT DEFAULT 0,
  recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS campaigns (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  progress TINYINT DEFAULT 0,
  target_views INT DEFAULT 0,
  target_engagement INT DEFAULT 0,
  status ENUM('IN PROGRESS','PENDING','COMPLETED') DEFAULT 'IN PROGRESS',
  end_date DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS campaign_influencers (
  campaign_id INT NOT NULL,
  user_id INT NOT NULL,
  PRIMARY KEY (campaign_id, user_id),
  FOREIGN KEY (campaign_id) REFERENCES campaigns(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Seed data
INSERT INTO users (username, email) VALUES ('Amna', 'amna@konekta.id');

INSERT INTO payments (user_id, amount, status, month, year) VALUES
  (1, 3467420, 'paid', MONTH(NOW()), YEAR(NOW())),
  (1, 1250000, 'pending', MONTH(NOW()), YEAR(NOW()));

INSERT INTO stats (user_id, views, engagement, recorded_at) VALUES
  (1, 24800, 2300, NOW());

INSERT INTO campaigns (title, progress, target_views, target_engagement, status, end_date) VALUES
  ('Kopi Susu', 75, 50000, 5000, 'IN PROGRESS', DATE_ADD(NOW(), INTERVAL 5 DAY)),
  ('Skincare Glow', 40, 30000, 3000, 'IN PROGRESS', DATE_ADD(NOW(), INTERVAL 10 DAY));

INSERT INTO campaign_influencers (campaign_id, user_id) VALUES (1, 1), (2, 1);
