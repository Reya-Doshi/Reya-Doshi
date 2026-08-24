# Reya Doshi GitHub Profile README System

This repository contains the dynamic, high-performance GitHub profile README system for **Reya Doshi**.

---

## 1. Local Preview & Asset Generation

To test asset generation and preview the complete profile locally on Windows:

```powershell
.\setup.ps1
```

Or run individual asset generators:

```powershell
# Portrait Dot-Matrix SVG
python scripts/dotify.py me.png -o assets/portrait --cols 100 --equalize --detail 0.5 --color --reveal

# Skill & Language Radars
python scripts/radar.py --data assets/skills.json -o assets/radar
python scripts/radar.py --github Reya-Doshi -o assets/radar-langs --limit 7 --values --curve 0.4

# Stat & Project Cards
python scripts/cards.py --user Reya-Doshi --projects assets/projects.json --out assets
```

Open `preview.html` in your browser to view desktop/mobile previews and dark/light themes.

---

## 2. GitHub Deployment Instructions

When ready to publish to your actual GitHub profile:

1. Create a public repository named **Reya-Doshi** (`github.com/Reya-Doshi/Reya-Doshi`).
2. Push your code to `main`:
   ```bash
   git init
   git branch -M main
   git add .
   git commit -m "feat: initial Reya Doshi profile system"
   git remote add origin https://github.com/Reya-Doshi/Reya-Doshi.git
   git push -u origin main
   ```
3. Enable GitHub Actions Write Permissions:
   - Repo → **Settings** → **Actions** → **General** → **Workflow permissions** → select **Read and write permissions** → Save.
4. Add `METRICS_TOKEN` (Personal Access Token) to Repository Secrets for GitHub Metrics.
5. Trigger Workflows (**Metrics**, **Snake**, **Charts and cards**).

---

## 3. Confidentiality & Safety 🔒

All private and internal projects are strictly hidden and excluded from public documentation and repository assets.
