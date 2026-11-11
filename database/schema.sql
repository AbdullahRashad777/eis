-- ============================================================================
-- Emerald International School (EIS) — Smart Behavioral & Academic Database
-- Compatible with PostgreSQL / Supabase / SQLite
-- ============================================================================

CREATE TABLE IF NOT EXISTS teachers (
  id VARCHAR(32) PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  phone VARCHAR(30) NOT NULL,
  division VARCHAR(20) NOT NULL CHECK (division IN ('National', 'American')),
  stage VARCHAR(80) NOT NULL,
  subject VARCHAR(60) NOT NULL,
  max_periods_per_day INT DEFAULT 6,
  emerald_gems INT DEFAULT 180,
  status VARCHAR(20) DEFAULT 'Present',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS students (
  id VARCHAR(32) PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  division VARCHAR(20) NOT NULL CHECK (division IN ('National', 'American')),
  class_id VARCHAR(32) NOT NULL,
  learning_style VARCHAR(80) NOT NULL,
  emerald_gems INT DEFAULT 150,
  mastery_pct INT DEFAULT 84,
  rank_title VARCHAR(60) DEFAULT 'Rising Explorer',
  parent_name VARCHAR(120) NOT NULL,
  parent_phone VARCHAR(30) NOT NULL,
  parent_email VARCHAR(150) NOT NULL,
  parent_link_code VARCHAR(32) UNIQUE NOT NULL,
  wellbeing_status VARCHAR(80) DEFAULT 'Thriving & Engaged',
  pulse_note TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS timetable_slots (
  id SERIAL PRIMARY KEY,
  class_id VARCHAR(32) NOT NULL,
  division VARCHAR(20) NOT NULL,
  day_of_week VARCHAR(16) NOT NULL,
  period_index INT NOT NULL CHECK (period_index BETWEEN 1 AND 9),
  subject VARCHAR(60) NOT NULL,
  teacher_id VARCHAR(32) REFERENCES teachers(id),
  original_teacher_id VARCHAR(32) REFERENCES teachers(id),
  room VARCHAR(32) NOT NULL,
  status VARCHAR(24) DEFAULT 'Regular',
  note TEXT
);

CREATE TABLE IF NOT EXISTS substitutions_log (
  id VARCHAR(32) PRIMARY KEY,
  division VARCHAR(20) NOT NULL,
  absent_teacher_id VARCHAR(32) REFERENCES teachers(id),
  day_of_week VARCHAR(16) NOT NULL,
  reason VARCHAR(120),
  resolution_json TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS educational_materials (
  id VARCHAR(32) PRIMARY KEY,
  division VARCHAR(20) NOT NULL,
  class_id VARCHAR(32) NOT NULL,
  subject VARCHAR(60) NOT NULL,
  teacher_id VARCHAR(32) REFERENCES teachers(id),
  material_type VARCHAR(60) NOT NULL,
  title VARCHAR(200) NOT NULL,
  description TEXT,
  gems_reward INT DEFAULT 50,
  cognitive_pacing VARCHAR(60),
  completions_count INT DEFAULT 0,
  mastery_pct INT DEFAULT 80,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS notifications_log (
  id VARCHAR(32) PRIMARY KEY,
  division VARCHAR(20) NOT NULL,
  alert_type VARCHAR(60) NOT NULL,
  title VARCHAR(200) NOT NULL,
  message TEXT NOT NULL,
  affected_teacher_ids TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
