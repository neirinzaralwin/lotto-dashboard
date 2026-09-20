# Setup — Lotto Fullstack

Guide for **new developers** to run the admin dashboard against a **local Supabase** stack on your machine.

## Mental model (read this once)

| Piece | What it is | How you start it |
| --- | --- | --- |
| **Admin dashboard** | Next.js app in `apps/admin-dashboard` | `npm run dev` (normal Node — **not** Docker) |
| **Local Supabase** | Postgres + Auth + API + Studio | `supabase start` (Supabase CLI starts **Docker containers**) |
| **Docker Desktop** | Engine that runs those containers | Install separately and keep it **running** |

Important:

- Installing the **Supabase CLI does not install Docker**. Install Docker Desktop yourself.
- We do **not** run the Next.js admin app inside Docker. There is no app `docker-compose` for Nest/admin.
- Excel files are **imported through the admin UI** into Postgres. You do not “upload Excel permanently into Docker.”

```text
Docker Desktop (must be open)
        ↑
supabase start   →  local Postgres / Auth / API / Studio (containers)
        ↑
Admin (.env.local URL + keys)  →  talks to local API at http://127.0.0.1:54321
```

---

## Prerequisites (install once)

1. **Node.js 18+** and **npm 10+**
2. **Docker Desktop** — [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)  
   Open the app and wait until it says Docker is running.
3. **Supabase CLI**

```bash
brew install supabase/tap/supabase
supabase --version
```

4. Optional: Python 3.11 + `uv` only if you use Graphify (`./setup_graphify.sh`)

---

## First-time setup (do in order)

Work from the fullstack root:

```bash
cd lotto_fullstack
```

### 1. Install JS dependencies

```bash
npm install
```

### 2. Create env files

```bash
cp apps/admin-dashboard/.env.example apps/admin-dashboard/.env.local
cp supabase/.env.example supabase/.env
```

You will fill real keys in step 4 (after Supabase is up).

### 3. Start local Supabase (Docker)

Make sure **Docker Desktop is running**, then:

```bash
supabase start
```

The first run downloads official Supabase images (Postgres, Studio, etc.) from Supabase’s registry. That can take several minutes.

When it finishes, you should see URLs similar to:

| Service | Typical local URL |
| --- | --- |
| API / Project URL | http://127.0.0.1:54321 |
| Studio (DB UI) | http://127.0.0.1:54323 |
| Database | postgresql://postgres:postgres@127.0.0.1:54322/postgres |

### 4. Apply database migrations

```bash
supabase db reset
```

This recreates the local DB and applies SQL under `supabase/migrations/` (tables like `draws`, RLS, triggers).

### 5. Copy keys into the admin env

```bash
supabase status
```

From that output, put values into `apps/admin-dashboard/.env.local`:

```env
NEXT_PUBLIC_SUPABASE_URL=http://127.0.0.1:54321
NEXT_PUBLIC_SUPABASE_ANON_KEY=<Publishable or anon key from supabase status>
SUPABASE_SERVICE_ROLE_KEY=<Secret / service_role key from supabase status>
```

Also update `supabase/.env` with the same local URL and keys if you use it for tooling.

> Never commit real keys. Never put the **service role** key in Flutter.

### 6. Create an admin login user

The dashboard requires staff Auth. Mobile end users do **not** sign in.

**Local default (dev only)**

| Email | Password |
| --- | --- |
| `admin@gmail.com` | `password` |

Create it once (while local Supabase is running):

```bash
# from lotto_fullstack — uses service role from supabase status
API=$(supabase status -o env | sed -n 's/^API_URL="\(.*\)"/\1/p')
SERVICE=$(supabase status -o env | sed -n 's/^SERVICE_ROLE_KEY="\(.*\)"/\1/p')
curl -s -X POST "$API/auth/v1/admin/users" \
  -H "apikey: $SERVICE" \
  -H "Authorization: Bearer $SERVICE" \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@gmail.com","password":"password","email_confirm":true}'
```

**Option A — Studio UI**

1. Open http://127.0.0.1:54323  
2. Authentication → Users → Add user (email + password)

**Option B — CLI** (if your CLI version supports it)

```bash
supabase auth signup --email admin@gmail.com --password 'password'
```

> After `supabase db reset`, Auth users are wiped — recreate the admin user with the command above.
### 7. Start the admin dashboard

```bash
npm run dev
```

Open http://localhost:3000 → you should be redirected to `/login` → sign in with the user from step 6.

---

## Every day after that (short checklist)

1. Open **Docker Desktop** (must be running).
2. Start Supabase if it is not already up:

```bash
cd lotto_fullstack
supabase start
```

3. Start the admin app:

```bash
npm run dev
```

4. Open http://localhost:3000 and sign in.

Useful checks:

```bash
docker ps          # should list supabase_* containers when local stack is up
supabase status    # prints local URLs and keys
```

Stop local Supabase when you are done for the day (optional):

```bash
supabase stop
```

---

## After you change SQL migrations

If you add/edit files under `supabase/migrations/`:

```bash
supabase db reset
```

That re-applies all migrations on the **local** DB (wipes local data).

To send **schema** (not Excel data) to a **hosted** Supabase project later:

```bash
supabase login
supabase link --project-ref <your-project-ref>
supabase db push
```

Then point `.env.local` at the **cloud** URL and keys instead of `127.0.0.1`.

---

## Flutter sibling (mobile)

The Flutter app lives in `../lotto_flutter`. It reads published draws with the **anon / publishable** key only.

Example (local Supabase):

```bash
cd ../lotto_flutter
flutter pub get
flutter run \
  --dart-define=SUPABASE_URL=http://127.0.0.1:54321 \
  --dart-define=SUPABASE_ANON_KEY=<same anon/publishable key as admin>
```

Without those dart-defines, the app still launches but uses stub/empty data.

See also [../docs/results-flow-acceptance.md](../docs/results-flow-acceptance.md) for an end-to-end checklist (import Excel → publish → see on mobile).

---

## Push notifications (FCM) — credentials drop-in later

End-to-end path is wired: Admin Alerts → `notification_records` → Edge Function `send-push` → FCM topics `lotto6` / `lotto7` → Flutter subscribe. Until Firebase is configured, admin CRUD works and Send returns `fcm_not_configured` (draft stays draft).

### Topics

| Topic | Who receives |
| --- | --- |
| `lotto6` | Installs subscribed to Lotto 6 alerts |
| `lotto7` | Installs subscribed to Lotto 7 alerts |
| Manual target **All** | Sends to both topics |

Flutter always subscribes to both topics on launch (once Firebase options are real).

### 1. Firebase project (Client / you)

1. Create a Firebase project; add Android (`com.lotto.lotto_app`) and iOS apps.
2. Download `google-services.json` → `lotto_flutter/android/app/` (gitignored if you prefer; do not commit secrets).
3. Download `GoogleService-Info.plist` → `lotto_flutter/ios/Runner/`.
4. From `lotto_flutter`:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

This overwrites `lib/firebase_options.dart` placeholders (`REPLACE_ME`).

5. Android: add the Google Services Gradle plugin when FlutterFire instructs (after `google-services.json` exists).
6. iOS: enable Push Notifications + Background Modes (Remote notifications) in Xcode; upload APNs key to Firebase.

### 2. Service account for Edge Function

1. Firebase Console → Project settings → Service accounts → Generate new private key (JSON).
2. Set the secret (local or hosted):

```bash
cd lotto_fullstack
# Paste the entire JSON as one line / file contents
supabase secrets set FIREBASE_SERVICE_ACCOUNT_JSON="$(cat path/to/firebase-adminsdk.json)"
supabase functions serve send-push
# Deploy:
# supabase functions deploy send-push
```

Also list the secret name in `supabase/.env.example` for documentation only — never commit the JSON.

### 3. Manual test checklist

1. Apply migration: `supabase db reset` (or migrate) so `notification_records.status` + `notification_settings` exist.
2. Admin → Alerts: create draft → Save (persists to Postgres).
3. Send **without** FCM secret → expect clear “not configured” flash; draft remains draft.
4. Set secret → Send again → row becomes **sent**; FCM console / device receives topic message.
5. Settings: toggle auto-notify Lotto 6/7 → Save → publish a draw → auto row created + push attempted.
6. Flutter: with real `firebase_options`, launch app, grant permission, confirm topic subscribe in logs; publish from admin and see notification.

Without dart-defines / Firebase, Flutter still launches; FCM init no-ops when `apiKey` is `REPLACE_ME`.

---

## Optional extras

### Edge Functions

```bash
supabase functions serve send-push
supabase functions serve run-algorithms
# Deploy later:
# supabase functions deploy send-push
# supabase functions deploy run-algorithms
```

### Graphify

```bash
./setup_graphify.sh
```

See [GRAPHIFY.md](./GRAPHIFY.md).

---

## npm scripts

| Command | Purpose |
| --- | --- |
| `npm run dev` | Run admin dashboard (Turbo) |
| `npm run build` | Build all workspaces |
| `npm run lint` | Lint |
| `npm run check-types` | Typecheck |
| `npm run format` | Prettier write |

---

## Troubleshooting

| Problem | What to try |
| --- | --- |
| `supabase start` fails | Open Docker Desktop; wait until it is healthy; retry |
| Admin cannot reach Supabase | Confirm `.env.local` uses `http://127.0.0.1:54321` and keys from `supabase status` |
| Login fails | Create a user in Studio (Auth → Users) |
| Empty tables after pull | Run `supabase db reset` to apply migrations |
| Port already in use | `supabase stop`, then `supabase start` again |

Published draws (`is_published = true`) are readable with the anon key. Drafts stay admin-only.
