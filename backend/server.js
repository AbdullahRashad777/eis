/**
 * Emerald International School (EIS) — Smart Behavioral & Timetable Backend API
 * Node.js + Express REST API ready for GitHub deployment, Render, Railway, or Supabase
 */
const express = require('express');
const cors = require('cors');
const path = require('path');

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, '..')));

// In-memory / JSON-backed store (plug in pg / supabase-js for cloud persistence)
let dbState = {
  teachers: [],
  students: [],
  materials: [],
  timetable: {},
  substitutions: [],
  notifications: []
};

app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', school: 'Emerald International School (EIS)', timestamp: new Date().toISOString() });
});

app.get('/api/state', (req, res) => {
  res.json(dbState);
});

app.post('/api/state/sync', (req, res) => {
  dbState = Object.assign(dbState, req.body || {});
  res.json({ synced: true, updatedAt: new Date().toISOString() });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`EIS Smart Portal Backend running on http://localhost:${PORT}`);
});
