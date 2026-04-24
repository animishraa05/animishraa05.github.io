# Wiki Maintenance Guide

> Complete guide for growing, maintaining, and improving your second brain.

---

## Quick Start — First Time Setup

### 1. Install OpenCode

```bash
# Arch Linux
sudo pacman -S opencode    # if available in repos

# Or from AUR
yay -S opencode

# Or from source (see github.com/opencode-ai/opencode)
```

### 2. Get Your Gemini API Key

1. Go to [Google AI Studio](https://aistudio.google.com/)
2. Sign in with your Google account
3. Click "Get API Key"
4. Copy the key

### 3. Set the API Key

Add to your `~/.bashrc` or `~/.zshrc`:

```bash
export GEMINI_API_KEY="your-key-here"
```

Then: `source ~/.bashrc`

### 4. Enable the Weekly Timer

```bash
systemctl --user daemon-reload
systemctl --user enable --now wiki-agent.timer
systemctl --user status wiki-agent.timer   # verify it's running
```

### 5. Test It Works

```bash
cd ~/animishraa05.github.io/content
opencode run "Read wiki/index.md and tell me how many concept pages exist"
```

If you get an answer → setup is working.

---

## Daily Workflow — Ingesting Sources

This is the PRIMARY way you interact with the wiki.

### Method 1: Script (Recommended)

```bash
# 1. Drop your source file
cp ~/Downloads/some-article.md ~/animishraa05.github.io/content/sources/

# 2. Run ingest
cd ~/animishraa05.github.io/content
./scripts/wiki-ingest.sh some-article.md
```

### Method 2: Direct OpenCode

```bash
cd ~/animishraa05.github.io/content
opencode run "
Read sources/some-article.md. Extract all atomic concepts.
For each concept, create or update wiki/concepts/[concept].md.
Create a source summary in wiki/sources/.
Update wiki/index.md and wiki/log.md.
Follow AGENTS.md strictly.
"
```

### What Happens During Ingest

```
Source file (1 file)
    ↓
OpenCode reads it
    ↓
Identifies all atomic concepts — no limit
    ↓
For each concept:
  - Checks if wiki/concepts/[name].md exists
  - If YES: updates it (merges new info, flags contradictions)
  - If NO: creates it with full template
    ↓
Creates source summary in wiki/sources/
    ↓
Updates wiki/index.md with new entries
    ↓
Appends to wiki/log.md
    ↓
Creates synthesis pages if new comparisons emerge
    ↓
Auto-commits to git (if configured)
```

### What to Put in sources/

| Type | Example | Format |
|---|---|---|
| Article | Obsidian Web Clipper output | .md |
| Transcript | YouTube video transcript | .md or .txt |
| Paper | Research paper notes | .md |
| Book chapter | Reading notes | .md |
| Lecture notes | Class/talk notes | .md |
| Code study | Framework tutorial analysis | .md |

**Naming:** Use descriptive names. `karpathy-transformer-inference.md`, not `article-3.md`.

---

## Weekly Workflow — Automated Maintenance

The systemd timer runs every **Sunday at 10:00 AM**. It does:

1. **Lint** — checks for orphans, broken links, contradictions, thin pages
2. **Index rebuild** — refreshes `wiki/index.md` from current state
3. **Uningested source check** — flags sources you haven't processed
4. **Auto-commit** — saves changes to git

### Check Weekly Results

```bash
# Last 5 log entries
grep "^## \[" wiki/log.md | tail -5

# All lints
grep "^## .* lint" wiki/log.md

# All ingests
grep "^## .* ingest" wiki/log.md

# View the weekly lint report
cat /tmp/wiki-weekly-lint.log
```

### If the Timer Fails

```bash
# Check status
systemctl --user status wiki-agent.timer

# Check last run
journalctl --user -u wiki-agent.service -n 20

# Run manually
./scripts/wiki-weekly.sh
```

---

## Manual Operations

### Lint On Demand

```bash
./scripts/wiki-lint.sh
```

### Query the Wiki

```bash
# Ask a question, get a synthesized answer
cd ~/animishraa05.github.io/content
opencode run "What's the difference between connection-oriented and connectionless service in networking? Use wiki concepts only."

# Ask for a comparison
opencode run "Compare packet switching and circuit switching. Create a synthesis page if one doesn't exist."
```

### Rebuild Index Manually

```bash
cd ~/animishraa05.github.io/content
opencode run "Run the wiki-index command. Rebuild wiki/index.md from current state. Follow AGENTS.md."
```

---

## Growing the Wiki — Best Practices

### 1. Quality > Quantity

Don't ingest garbage. Every source should teach you something you can't derive from existing concepts.

### 2. Review Before Ingest

Quickly skim the source before ingesting. If you know it covers concepts already in the wiki, tell OpenCode:

```bash
opencode run "
Ingest sources/article.md. Most concepts already exist.
Focus on: what NEW information does this add?
Update existing concept pages with new details.
Don't create duplicate concept pages.
Follow AGENTS.md.
"
```

### 3. Ask Good Questions

The wiki compounds from queries too. When you ask a question that reveals a connection:

```
You: "How is the OSI model's layered approach similar to Django's architecture?"
OpenCode: [synthesizes an answer]
You: "Save that as a synthesis page."
```

This is how novel insights enter the wiki.

### 4. Use the Graph View

Open Obsidian → switch to `wiki/` folder → open Graph View.

What to look for:
- **Hubs** (many connections) → these are your core concepts, keep them strong
- **Orphans** (no connections) → these are gaps, link them to something
- **Clusters** → these are your domains, good sign the wiki is organizing itself

### 5. Periodic Deep Lint (Monthly)

```bash
# Beyond the weekly lint — ask for a deeper analysis
opencode run "
Do a deep lint of the wiki. Beyond the usual checks:
1. Are any concept pages trying to cover too much? (should be split)
2. Are any two concept pages covering the same thing? (should be merged)
3. Are there concept pages that should be syntheses instead? (and vice versa)
4. Which concepts have the fewest connections? (need more linking)
5. Which sources haven't been referenced by any concept? (dead weight)
Report findings and fix what you can.
"
```

---

## Troubleshooting

### OpenCode Returns Errors

```bash
# Check API key
echo $GEMINI_API_KEY

# Test connectivity
opencode run "Say hello"

# Check OpenCode version
opencode --version
```

### Wiki Gets Messy

If you notice the wiki is degrading (contradictions, duplicates, orphan pages):

```bash
# Run a deep lint
./scripts/wiki-lint.sh

# If really bad, ask OpenCode to reorganize
opencode run "
The wiki has gotten messy. Please:
1. Find all duplicate or overlapping concept pages
2. Merge them into single authoritative pages
3. Remove true duplicates (not subtle distinctions)
4. Fix all broken links
5. Ensure every page has 4+ connections
6. Report what you changed.
Follow AGENTS.md.
"
```

### OpenCode Makes Bad Edits

This is why we have git:

```bash
# See what changed
git log --oneline wiki/ -10

# Diff a specific file
git diff HEAD~1 wiki/concepts/packet-switching.md

# Revert a bad commit
git revert HEAD

# Or hard reset to a known good state
git log --oneline wiki/    # find the good commit
git checkout <commit> -- wiki/
git commit -m "wiki: revert to known good state"
```

### Gemini Free Tier Hits Limits

Google AI Studio free tier has rate limits. If you hit them:

1. **Wait** — limits reset (typically hourly/daily)
2. **Add another provider** — Groq free tier as fallback
3. **Use me (Qwen CLI)** — for manual ingest, just tell me "ingest this"

To add Groq as fallback in `.opencode.json`:

```json
{
  "providers": {
    "google": {
      "api_key_env": "GEMINI_API_KEY",
      "disabled": false
    },
    "groq": {
      "api_key_env": "GROQ_API_KEY",
      "disabled": false
    }
  },
  "agents": {
    "coder": {
      "model": "google/gemini-2.0-flash",
      "maxTokens": 8192
    }
  }
}
```

---

## Scaling Up

### When to Switch from Free to Paid

Signs you've outgrown free:

- You're hitting rate limits regularly (more than once a week)
- OpenCode times out on large wiki operations
- Quality of free model outputs is degrading

At that point:

| Upgrade | Cost | Benefit |
|---|---|---|
| **Google AI Studio Paid** | Pay per token, very cheap | Higher rate limits |
| **Claude Code** | $20/month | Best agent quality, understands SCHEMA perfectly |
| **Qwen Flash API** | ~₹50/month | Extremely cheap, good quality |

### When to Add Search

Right now, the `index.md` approach works for ~100-200 pages. Beyond that:

```bash
# Install qmd (local markdown search)
# https://github.com/tobi/qmd
yay -S qmd    # or cargo install qmd

# Index the wiki
qmd index wiki/

# Search
qmd search "packet switching reliability"
```

Then configure OpenCode to use qmd as a tool for wiki queries.

---

## File Map — What Goes Where

| File | Purpose | Who Owns It |
|---|---|---|
| `sources/*` | Raw materials (articles, transcripts) | You |
| `wiki/concepts/*` | Atomic concept notes | OpenCode |
| `wiki/syntheses/*` | Comparisons, deep dives | OpenCode |
| `wiki/sources/*` | LLM summaries of ingested sources | OpenCode |
| `wiki/SCHEMA.md` | Page format conventions | You + OpenCode |
| `wiki/index.md` | Catalog of all wiki content | OpenCode |
| `wiki/log.md` | Append-only operation log | OpenCode |
| `AGENTS.md` | Behavior rules for OpenCode | You |
| `.opencode.json` | OpenCode config (model, provider) | You |
| `scripts/wiki-ingest.sh` | Ingest a source | You (run it) |
| `scripts/wiki-lint.sh` | Health-check the wiki | You (run it) |
| `scripts/wiki-weekly.sh` | Automated weekly maintenance | systemd timer |

---

## Quick Reference Card

```bash
# INGEST a new source
./scripts/wiki-ingest.sh article-name.md

# LINT the wiki
./scripts/wiki-lint.sh

# QUERY the wiki
opencode run "your question here"

# CHECK the log
grep "^## \[" wiki/log.md | tail -10

# CHECK timer status
systemctl --user status wiki-agent.timer

# VIEW git history
git log --oneline wiki/ -20

# REVERT a bad edit
git log --oneline wiki/     # find good commit
git checkout <commit> -- wiki/concepts/specific-file.md
```
