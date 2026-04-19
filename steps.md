# DevOps Workshop - Student Guide

## Overview

In this workshop, you'll experience a complete CI/CD pipeline:
1. Make a code change
2. Push to GitHub
3. Watch Jenkins automatically build and deploy
4. See your changes live on a website

---

## Prerequisites

- A GitHub account
- Basic knowledge of Git commands

---

## Steps

### Step 1: Fork or Clone the Repository

```bash
git clone https://github.com/Namyalg/jenkins-workshop-rvce-4th-may.git
cd jenkins-workshop-rvce-4th-may
```

### Step 2: Create Your Own Branch

Create a branch with your name (use lowercase, no spaces):

```bash
git checkout -b feature/your-name
```

Example:
```bash
git checkout -b feature/alice
```

### Step 3: Edit the Website

Open `index.html` and make two changes:

**Change 1:** Find the title line:
```html
<title>Jenkins Workshop - RVCE</title>
```

Change it to include your name:
```html
<title>Alice - Jenkins Workshop</title>
```

**Change 2:** Find the name div:
```html
<div class="name">Your Name Here</div>
```

Change it to your name:
```html
<div class="name">Alice</div>
```

**Important:** The tests will fail if you don't make both changes!

### Step 4: Commit Your Changes

```bash
git add .
git commit -m "Add my name"
```

### Step 5: Push Your Branch

```bash
git push origin feature/your-name
```

Example:
```bash
git push origin feature/alice
```

### Step 6: Watch Jenkins Build

1. Go to Jenkins: `http://104.197.51.120:8080/job/workshop-pipeline/`
2. Find your branch in the list
3. Click on it to see the build progress
4. Watch the pipeline stages: Clone → Build → Test → Deploy

### Step 7: See Your Site Live

Once the build succeeds, visit:

```
http://104.197.51.120/feature/your-name/
```

Example:
```
http://104.197.51.120/feature/alice/
```

You should see your name displayed on the page!

---

## What Just Happened?

```
You pushed code
      ↓
GitHub webhook notified Jenkins
      ↓
Jenkins pulled your code
      ↓
Jenkins ran the pipeline (Jenkinsfile)
      ↓
Your site was deployed to nginx
      ↓
Your page is now live!
```

---

## The CI/CD Flow

| Stage | What Happens |
|-------|--------------|
| **Clone** | Jenkins downloads your code from GitHub |
| **Build** | Prepares the application |
| **Test** | Validates your changes (name and title updated) |
| **Deploy** | Copies files to the web server |

**If tests fail, deployment is blocked!** This is the power of CI/CD - bad code never reaches production.

---

## Key Files

| File | Purpose |
|------|---------|
| `index.html` | The web page you're editing |
| `Jenkinsfile` | Instructions for Jenkins (the pipeline) |

---

## Troubleshooting

**Tests failed?**
- Did you change your name in index.html?
- Did you change the title in index.html?
- Check Console Output to see which test failed

**Build failed?**
- Check the Console Output in Jenkins for error messages
- Make sure your branch name has no spaces

**Can't see your page?**
- Verify the build succeeded (green checkmark)
- Check you're using the correct URL with your branch name

**Push rejected?**
- Make sure you created a new branch
- Don't push directly to `master`

---

## Next Steps

Try making another change:
1. Edit `index.html` again
2. Commit and push
3. Watch Jenkins automatically rebuild
4. See your updated page

This is the power of CI/CD - automatic deployment on every code change!
