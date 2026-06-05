# GitHub + Vercel Deployment Steps

## Prerequisites
- A GitHub account (free at https://github.com)

---

## Step 1: Create the GitHub repo

1. Go to https://github.com/new
2. **Repository name**: `connectvoice` (or whatever you want)
3. **Visibility**: Public or Private (your choice)
4. **IMPORTANT**: Do NOT check "Add a README file" — we already have one
5. **IMPORTANT**: Do NOT add .gitignore or license — we already have them
6. Click **"Create repository"**

---

## Step 2: Push your code

GitHub will show you the remote URL after creating. It looks like:
`https://github.com/YOUR_USERNAME/connectvoice.git`

Run these commands in PowerShell:

```powershell
cd "E:\New folder (2)\connectvoice"

# Add the remote (REPLACE YOUR_USERNAME with your actual GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/connectvoice.git

# Push to GitHub
git push -u origin main
```

You'll be prompted for your GitHub username and password. For password, use a **Personal Access Token** (GitHub no longer accepts account passwords):
- Generate one at https://github.com/settings/tokens/new
- Scopes: `repo` (full control of private repositories)
- Copy the token, paste it as the password

---

## Step 3: Connect Vercel to the GitHub repo

1. Go to https://vercel.com/new
2. Click **"Import Git Repository"**
3. Find and select your `connectvoice` repo
4. Vercel auto-detects:
   - Framework Preset: **Vite**
   - Build Command: `npm run build`
   - Output Directory: `dist`
5. Click **"Environment Variables"** and add:
   ```
   VITE_SUPABASE_URL     = https://upfhubhvzgvtjarysgfa.supabase.co
   VITE_SUPABASE_ANON_KEY = <your anon key from Supabase dashboard>
   VITE_VAPID_PUBLIC_KEY  = <your VAPID public key>
   ```
6. Click **"Deploy"**

Wait ~60 seconds. Your site is live at `https://connectvoice-xxx.vercel.app`.

---

## Optional: Custom domain

1. Vercel project → **Settings** → **Domains**
2. Add your domain (e.g. `connectvoice.app`)
3. Update DNS as Vercel instructs
4. SSL is automatic

---

## After the first deploy

Every time you run:
```powershell
git add -A
git commit -m "Update message"
git push
```

Vercel automatically rebuilds and redeploys.
