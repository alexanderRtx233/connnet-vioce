# Vercel Deployment Guide

## One-time setup

### 1. Push to GitHub
```bash
cd connectvoice
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/connectvoice.git
git push -u origin main
```

### 2. Import into Vercel
1. Go to https://vercel.com/new
2. Click **"Import Git Repository"**
3. Select your `connectvoice` repo
4. Vercel auto-detects the framework as **Vite** (reads `vercel.json`)
5. Click **"Environment Variables"** and add these:

| Name | Value |
|---|---|
| `VITE_SUPABASE_URL` | `https://upfhubhvzgvtjarysgfa.supabase.co` |
| `VITE_SUPABASE_ANON_KEY` | your Supabase anon key |
| `VITE_VAPID_PUBLIC_KEY` | your VAPID public key |

6. Click **Deploy**

That's it. The site will be live at `https://connectvoice-xxx.vercel.app` in ~60 seconds.

## Continuous deployment
Every `git push` to `main` triggers a new production deploy.
Every push to other branches creates a preview URL.

## Custom domain
1. Vercel project → **Settings** → **Domains**
2. Add your domain (e.g. `connectvoice.app`)
3. Update DNS as instructed
4. SSL is auto-issued by Vercel

## Supabase CORS (important!)
After deploying, go to **Supabase Dashboard → Authentication → URL Configuration** and add your Vercel domain to:
- **Site URL**: `https://connectvoice-xxx.vercel.app`
- **Additional Redirect URLs**: same URL

This prevents auth errors on the deployed site.

## WebRTC notes
- WebRTC works on Vercel-hosted sites over HTTPS out of the box
- Camera/mic APIs require a **secure context** — Vercel provides HTTPS automatically
- For users behind strict NATs, configure TURN servers via `VITE_TURN_SERVERS` (see `.env.example`)

## Build settings (auto-detected from `vercel.json`)
- Build command: `npm run build`
- Output directory: `dist`
- Framework: Vite
- SPA rewrites: all routes → `/index.html` (so TanStack Router works)
- Headers: security headers + service worker cache rules
