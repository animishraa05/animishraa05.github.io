# Proxima SaaS — Architecture and Implementation Plan

## Overview

Proxima evolves from a single-instance WebRTC classroom tool into a multi-tenant SaaS platform. Schools, colleges, and coaching centres register their institution, create classes, enroll students via unique keys, and get a persistent Google Classroom-style feed with integrated live sessions powered by WebRTC.

---

## Core Concept

```
Institution registers on Proxima
        ↓
Admin creates classes and teachers
        ↓
Teacher creates a class, gets a unique enrollment key
        ↓
Students join the class using that key and their username
        ↓
Inside the class: feed with notes, files, announcements
        ↓
Teacher schedules or starts a live session from the class page
        ↓
Students join the live meet directly from the class feed
        ↓
WebRTC session runs with all existing Proxima features
(reactions, attention detection, annotation, multi-session)
```

---

## Tenant Model

```
Proxima Platform (super_admin)
│
├── Institution A (institution_admin)
│   ├── Teachers
│   └── Classes
│       ├── Class Feed (materials, announcements)
│       └── Live Sessions (WebRTC meets)
│
├── Institution B (institution_admin)
│   └── ...
│
└── Institution C
    └── ...
```

Every piece of data belongs to an institution. Tenant isolation is enforced at the database query level on every single request.

---

## Roles

|Role|Who|What they can do|
|---|---|---|
|super_admin|Proxima team|Manage all institutions|
|institution_admin|Principal, coaching owner|Create classes, manage teachers and students|
|teacher|Subject teacher|Create class content, schedule meets, start live sessions|
|student|Enrolled student|View feed, join live sessions, send reactions|

---

## Database Schema

### Switch from SQLite to PostgreSQL

SQLite was correct for the hackathon single-instance setup. PostgreSQL is required for multi-tenant because of concurrent writes, proper foreign key enforcement, and row-level security.

### Tables

```sql
-- Each registered institution
CREATE TABLE institutions (
  id            SERIAL PRIMARY KEY,
  name          TEXT NOT NULL,
  slug          TEXT NOT NULL UNIQUE,  -- dps, aakash, iit-coaching
  admin_email   TEXT NOT NULL,
  plan          TEXT DEFAULT 'free',   -- free, pro, enterprise
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- Users (all roles in one table, role column differentiates)
CREATE TABLE users (
  id              SERIAL PRIMARY KEY,
  institution_id  INT REFERENCES institutions(id) ON DELETE CASCADE,
  name            TEXT NOT NULL,
  email           TEXT NOT NULL,
  password        TEXT NOT NULL,
  role            TEXT NOT NULL CHECK(role IN ('super_admin','institution_admin','teacher','student')),
  username        TEXT,                -- unique per institution for students
  created_at      TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(institution_id, email),
  UNIQUE(institution_id, username)
);

-- Classes within an institution
CREATE TABLE classes (
  id              SERIAL PRIMARY KEY,
  institution_id  INT REFERENCES institutions(id) ON DELETE CASCADE,
  teacher_id      INT REFERENCES users(id),
  name            TEXT NOT NULL,
  subject         TEXT,
  description     TEXT,
  join_key        TEXT NOT NULL UNIQUE,  -- unique alphanumeric key to enroll
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- Students enrolled in classes
CREATE TABLE enrollments (
  id          SERIAL PRIMARY KEY,
  class_id    INT REFERENCES classes(id) ON DELETE CASCADE,
  student_id  INT REFERENCES users(id) ON DELETE CASCADE,
  joined_at   TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(class_id, student_id)
);

-- Feed items: announcements, notes, files posted by teacher
CREATE TABLE feed_items (
  id           SERIAL PRIMARY KEY,
  class_id     INT REFERENCES classes(id) ON DELETE CASCADE,
  author_id    INT REFERENCES users(id),
  type         TEXT NOT NULL CHECK(type IN ('announcement','note','file','session_recap')),
  title        TEXT,
  body         TEXT,
  file_url     TEXT,   -- path to uploaded file if type is file
  file_name    TEXT,
  created_at   TIMESTAMPTZ DEFAULT NOW()
);

-- Scheduled and past live sessions
CREATE TABLE live_sessions (
  id              SERIAL PRIMARY KEY,
  class_id        INT REFERENCES classes(id) ON DELETE CASCADE,
  teacher_id      INT REFERENCES users(id),
  title           TEXT NOT NULL,
  scheduled_at    TIMESTAMPTZ,
  started_at      TIMESTAMPTZ,
  ended_at        TIMESTAMPTZ,
  livekit_room_id TEXT,             -- the actual Livekit room name
  status          TEXT DEFAULT 'scheduled' CHECK(status IN ('scheduled','live','ended')),
  created_at      TIMESTAMPTZ DEFAULT NOW()
);
```

---

## What Changes in Current Architecture

### Backend changes

#### 1. Replace better-sqlite3 with PostgreSQL

```
npm remove better-sqlite3
npm install pg prisma @prisma/client
```

Use Prisma as the ORM. Schema maps directly to the tables above. All existing store functions (createRoom, getRoom etc) remain as in-memory for live session state. PostgreSQL stores persistent data.

#### 2. New route files to add

```
server/src/routes/institutions.js   — register, get info
server/src/routes/classes.js        — create, list, get by join key
server/src/routes/feed.js           — post and get feed items
server/src/routes/sessions.js       — schedule, start, end sessions
server/src/routes/enroll.js         — student joins via unique key
server/src/routes/upload.js         — file upload handler
```

#### 3. Middleware update

Current authenticate.js checks JWT and sets req.user. Add tenant isolation middleware:

```js
// server/src/middleware/tenantScope.js
module.exports = function tenantScope(req, res, next) {
  if (!req.user?.institution_id) {
    return res.status(403).json({ error: 'No institution scope' });
  }
  req.institutionId = req.user.institution_id;
  next();
};
```

Every route that touches classes, feed, or sessions uses this middleware. It guarantees every query is scoped to the right institution.

#### 4. Token endpoint gets class context

Current token endpoint takes room, name, role. Update it to also accept session_id so the Livekit room name is tied to a real session in the database:

```
GET /token?session_id=X&name=Y&role=Z
```

Backend looks up the session, verifies the user is enrolled in that class, generates the Livekit token scoped to that session's room ID.

#### 5. File upload

```
npm install multer
```

Add upload route that saves files to server/uploads/ locally. In production this becomes an S3 presigned URL upload.

---

### Frontend changes

#### New pages to add

```
/register-institution       — institution onboarding form
/admin                      — institution admin dashboard
/admin/classes              — list all classes, create new
/admin/classes/:id          — manage one class, see students
/classes                    — student and teacher class list
/classes/:id                — class feed page (Google Classroom style)
/classes/:id/session/:sid   — live session page (current TeacherRoom/StudentRoom)
```

#### Class feed page structure

```
ProximaNav
│
├── Class header
│   ├── Class name and subject
│   ├── Join key display (teacher only, copy button)
│   └── Start Live Session button (teacher only)
│
├── Feed column (left, wider)
│   ├── Create post box (teacher only)
│   │   ├── Announcement text area
│   │   ├── File upload button
│   │   └── Post button
│   └── Feed items (newest first)
│       ├── Announcement card
│       ├── File card (with download button)
│       ├── Note card
│       └── Session card (with Join button if live)
│
└── Class info column (right, narrower)
    ├── Upcoming sessions list
    ├── Students list (teacher only)
    └── Class details
```

#### Student join flow

```
Student receives a join key from teacher (e.g. MAT-2026-XK9)
        ↓
Student goes to proxima.app/join
        ↓
Enters join key + creates username + password
        ↓
Account created, enrolled in that class automatically
        ↓
Redirected to class feed page
```

---

## New API Endpoints

### Institution

```
POST /institutions/register
Body: { name, slug, adminName, adminEmail, adminPassword }
Returns: { institution, user, token }

GET /institutions/:slug
Returns: { institution } — public info for login page branding
```

### Classes

```
POST /classes
Auth: teacher or institution_admin
Body: { name, subject, description }
Returns: { class } — includes generated join_key

GET /classes
Auth: any authenticated user
Returns: classes the user teaches or is enrolled in

GET /classes/:classId
Auth: enrolled student or teacher
Returns: { class, teacher, studentCount }

GET /classes/join/:joinKey
Auth: none — public lookup
Returns: { className, institutionName, teacherName }
— used to show preview before student creates account
```

### Enrollment

```
POST /enroll
Auth: none — student creating account via join key
Body: { joinKey, name, username, password }
Returns: { user, token, class }
```

### Feed

```
GET /classes/:classId/feed
Auth: enrolled student or teacher
Query: ?page=1&limit=20
Returns: { items: [...], total, page }

POST /classes/:classId/feed
Auth: teacher only
Body: { type, title, body, file_url, file_name }
Returns: { item }

DELETE /feed/:itemId
Auth: author only
```

### Live Sessions

```
POST /classes/:classId/sessions
Auth: teacher only
Body: { title, scheduled_at }
Returns: { session }

POST /sessions/:sessionId/start
Auth: teacher only
Sets status to live, records started_at, creates Livekit room
Returns: { session, livekitRoomId }

POST /sessions/:sessionId/end
Auth: teacher only
Sets status to ended, records ended_at
Returns: { session }

GET /classes/:classId/sessions
Auth: enrolled student or teacher
Returns: { sessions: [...] }

GET /token?session_id=X&role=Y
Auth: JWT required, enrollment verified
Returns: { token, serverUrl }
```

### File Upload

```
POST /upload
Auth: teacher only
Content-Type: multipart/form-data
Body: file field
Returns: { url, fileName, fileSize }
```

---

## Unique Join Key System

When a teacher creates a class, the backend generates a unique key:

```js
const generateJoinKey = (subject) => {
  const prefix = subject.substring(0, 3).toUpperCase();
  const year   = new Date().getFullYear();
  const random = Math.random().toString(36).substring(2, 6).toUpperCase();
  return `${prefix}-${year}-${random}`;
  // Example: MAT-2026-XK9P
};
```

Teacher shares this key with students via WhatsApp, email, or written on a board. Student goes to the join page, enters the key, creates a username and password, and is automatically enrolled.

The key never expires unless the teacher explicitly resets it. This means a teacher can share the key at the start of a semester and students can join throughout the year.

---

## Live Session Flow (updated)

```
Teacher opens class feed page
        ↓
Clicks Start Live Session
        ↓
POST /sessions/:id/start
Backend sets status=live, creates Livekit room
        ↓
All enrolled students see a LIVE banner on the class card
in their class list and inside the feed
        ↓
Students click Join
        ↓
GET /token?session_id=X&role=student
Backend verifies enrollment, returns Livekit token
        ↓
Student enters the live session page
All existing Proxima WebRTC features work here:
reactions, attention detection, annotation, raise hand
        ↓
Teacher clicks End Session
POST /sessions/:id/end
Livekit room closes, status=ended
A session recap item is posted automatically to the class feed
```

---

## What Stays the Same

```
Livekit SFU setup           — no changes needed
WebRTC Data Channels        — no changes needed
Socket.io event handlers    — no changes needed
face-api.js pipeline        — no changes needed
Annotation canvas           — no changes needed
Reaction bar                — no changes needed
Engagement panel            — no changes needed
JWT signing in token route  — minor update only (add session lookup)
Docker compose              — add PostgreSQL service only
```

---

## What Changes Summary

|Area|Change|
|---|---|
|Database|SQLite → PostgreSQL, 6 new tables|
|Auth|Add institution_id to JWT payload, add tenant middleware|
|Backend routes|6 new route files|
|Token endpoint|Accepts session_id instead of raw room name|
|Frontend pages|5 new pages|
|Frontend components|Class feed, feed item, file upload, session card|
|File storage|Add multer, local uploads folder|
|Student join|New flow via join key instead of manual room code|

---

## Implementation Order

```
Phase 1 — Foundation (do this first)
  Set up PostgreSQL with Docker
  Run Prisma migrations for all 6 tables
  Update auth routes to include institution_id
  Institution registration endpoint

Phase 2 — Class management
  Class creation with join key generation
  Student enrollment via join key
  Class list and detail endpoints

Phase 3 — Feed
  Feed POST and GET endpoints
  File upload with multer
  Feed page UI

Phase 4 — Live sessions
  Session creation and scheduling
  Start and end session endpoints
  Update token endpoint to use session_id
  Join session from feed UI

Phase 5 — Polish
  Student join key flow UI
  Admin dashboard
  Upcoming sessions widget
  Session recap auto-post
```

---

## Docker Compose Update

Add PostgreSQL to docker-compose.yml:

```yaml
services:
  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: proxima
      POSTGRES_USER: proxima
      POSTGRES_PASSWORD: proxima_secret
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  livekit:
    image: livekit/livekit-server:latest
    ports:
      - "7880:7880"
      - "7881:7881"
      - "7882:7882/udp"
    volumes:
      - ./livekit.yaml:/livekit.yaml
    command: --config /livekit.yaml

  backend:
    build: ./server
    ports:
      - "3001:3001"
    depends_on:
      - postgres
      - livekit
    environment:
      DATABASE_URL: postgresql://proxima:proxima_secret@postgres:5432/proxima
      LIVEKIT_API_KEY: devkey
      LIVEKIT_API_SECRET: secret
      LIVEKIT_HOST: ws://livekit:7880
      PORT: 3001

volumes:
  postgres_data:
```

---

## Environment Variables Update

```
server/.env additions:
DATABASE_URL=postgresql://proxima:proxima_secret@localhost:5432/proxima
UPLOAD_DIR=./uploads
MAX_FILE_SIZE_MB=10
```

---

## Notes

The current in-memory store for live room state (reactions, attention scores, raised hands) stays as-is. It does not need to go into PostgreSQL because this data is ephemeral — it only matters while the session is live. When the session ends it is gone, which is the correct behaviour.

The only persistent session data stored in PostgreSQL is the session record itself (title, scheduled time, start time, end time, status). The live real-time state remains in memory on the backend process exactly as it is today.