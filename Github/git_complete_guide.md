# 🌳 Complete Git Guide - Professional Edition
### From Zero to Hero - Master Git & GitHub for Open Source

[![Git](https://img.shields.io/badge/Git-2.40+-orange.svg)](https://git-scm.com/)
[![GitHub](https://img.shields.io/badge/GitHub-Ready-blue.svg)](https://github.com/)
[![License](https://img.shields.io/badge/License-Educational-green.svg)](https://opensource.org/licenses/MIT)

> 🚀 A comprehensive guide covering everything from Git basics to advanced workflows, including open-source contributions, best practices, and real-world scenarios.

---

## 📋 Table of Contents

### 🎯 Getting Started
- [What is Git?](#-what-is-git)
- [Installing Git](#-installing-git)
- [Initial Configuration](#-initial-configuration)
- [Git Basics Concepts](#-git-basic-concepts)

### 📚 Core Git Operations
- [Repository Basics](#-repository-basics)
- [Making Changes](#-making-changes)
- [Viewing History](#-viewing-history)
- [Undoing Changes](#-undoing-changes)
- [Branching & Merging](#-branching--merging)
- [Remote Repositories](#-remote-repositories)

### 🌟 Advanced Topics
- [Git Workflows](#-git-workflows)
- [Rebasing](#-rebasing)
- [Stashing](#-stashing)
- [Cherry Picking](#-cherry-picking)
- [Git Tags](#-git-tags)
- [Submodules](#-submodules)

### 🤝 Open Source Contributions
- [Forking & Pull Requests](#-forking--pull-requests)
- [Contributing to Projects](#-contributing-to-projects)
- [Code Review Best Practices](#-code-review-best-practices)

### 🛠️ Professional Workflows
- [Git Hooks](#-git-hooks)
- [CI/CD Integration](#-cicd-integration)
- [Advanced Git Commands](#-advanced-git-commands)
- [Troubleshooting](#-troubleshooting)

### 📌 Quick Reference
- [Common Commands Cheat Sheet](#-common-commands-cheat-sheet)
- [Git Aliases](#-git-aliases)
- [Best Practices](#-best-practices)

---

## 🔍 What is Git?

**Git** is a distributed version control system that tracks changes in your code over time.

### 🎯 Why Use Git?

| Benefit | Description |
|---------|-------------|
| 🔄 **Version Control** | Track every change made to your code |
| 🤝 **Collaboration** | Work with multiple developers simultaneously |
| 🔙 **Undo Changes** | Revert to any previous version |
| 🌿 **Branching** | Experiment without affecting main code |
| 🔍 **History** | See who changed what and when |
| 💾 **Backup** | Your code is safe in multiple locations |

---

### 📊 Git Workflow Overview

```
Working Directory  →  Staging Area  →  Local Repository  →  Remote Repository
     (Untracked)         (Staged)         (Committed)         (Pushed)
         │                   │                  │                  │
         │    git add        │   git commit     │    git push      │
         └──────────────────>└─────────────────>└─────────────────>
```

---

## 📥 Installing Git

### Windows 🪟

**Option 1: Official Installer**
1. Download from [git-scm.com](https://git-scm.com/download/win)
2. Run installer
3. Use recommended settings

**Option 2: Chocolatey**
```bash
choco install git
```

**Option 3: Winget**
```bash
winget install --id Git.Git -e --source winget
```

---

### MacOS 🍎

**Option 1: Homebrew (Recommended)**
```bash
brew install git
```

**Option 2: Xcode Command Line Tools**
```bash
xcode-select --install
```

**Option 3: Official Installer**
- Download from [git-scm.com](https://git-scm.com/download/mac)

---

### Linux 🐧

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install git
```

**Fedora:**
```bash
sudo dnf install git
```

**Arch Linux:**
```bash
sudo pacman -S git
```

---

### ✅ Verify Installation

```bash
# Check Git version
git --version

# Expected output:
git version 2.40.0
```

---

## ⚙️ Initial Configuration

### 🔧 Global Settings (One-time Setup)

**Set Your Identity:**
```bash
# Set your name (will appear in commits)
git config --global user.name "Your Name"

# Set your email (should match GitHub email)
git config --global user.email "your.email@example.com"
```

**Set Default Editor:**
```bash
# VS Code
git config --global core.editor "code --wait"

# Vim
git config --global core.editor "vim"

# Nano
git config --global core.editor "nano"

# Notepad (Windows)
git config --global core.editor "notepad"
```

**Set Default Branch Name:**
```bash
# Use 'main' instead of 'master'
git config --global init.defaultBranch main
```

**Enable Colored Output:**
```bash
git config --global color.ui auto
```

**Line Ending Configuration:**
```bash
# Windows (CRLF to LF)
git config --global core.autocrlf true

# Mac/Linux (LF only)
git config --global core.autocrlf input
```

---

### 👀 View Configuration

```bash
# View all settings
git config --list

# View specific setting
git config user.name
git config user.email

# View with origin (where setting is defined)
git config --list --show-origin

# Edit config file directly
git config --global --edit
```

**Configuration Levels:**

| Level | Scope | Command | Location |
|-------|-------|---------|----------|
| `--system` | All users | `git config --system` | `/etc/gitconfig` |
| `--global` | Current user | `git config --global` | `~/.gitconfig` |
| `--local` | Current repo | `git config --local` | `.git/config` |

---

## 📖 Git Basic Concepts

### 🎯 Three States of Git

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  Working Dir    │────>│  Staging Area   │────>│   Repository    │
│   (Modified)    │     │    (Staged)     │     │   (Committed)   │
└─────────────────┘     └─────────────────┘     └─────────────────┘
        │                        │                        │
    git add                 git commit                git push
```

1. **Working Directory** - Where you edit files
2. **Staging Area (Index)** - Where you prepare changes
3. **Repository (.git)** - Where commits are stored

---

### 📁 File Status Lifecycle

```
Untracked ──git add──> Staged ──git commit──> Committed
                          │                        │
                          │                   git modify
                          │                        │
                          └──git add──<───── Modified
```

---

## 📦 Repository Basics

### ➕ Create a New Repository

**Method 1: Start from Scratch**
```bash
# Create new directory
mkdir my-project
cd my-project

# Initialize Git repository
git init

# Verify initialization
ls -la
# You should see .git directory
```

**Method 2: Clone Existing Repository**
```bash
# Clone via HTTPS
git clone https://github.com/username/repository.git

# Clone via SSH
git clone git@github.com:username/repository.git

# Clone to specific folder
git clone https://github.com/username/repository.git my-folder

# Clone specific branch
git clone -b develop https://github.com/username/repository.git
```

---

### 📊 Check Repository Status

```bash
# See current status
git status

# Short status format
git status -s
```

**Status Output Example:**
```bash
$ git status
On branch main
Your branch is up to date with 'origin/main'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   README.md

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes)
        modified:   script.js

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        newfile.txt
```

**Short Status Symbols:**
```
?? - Untracked
A  - Added to staging
M  - Modified
D  - Deleted
R  - Renamed
C  - Copied
U  - Updated but unmerged
```

---

## ✏️ Making Changes

### ➕ Add Files to Staging

```bash
# Add specific file
git add filename.txt

# Add multiple files
git add file1.txt file2.txt file3.txt

# Add all files in directory
git add .

# Add all modified files (not untracked)
git add -u

# Add all files (including new & modified)
git add -A

# Add files by pattern
git add *.js
git add src/*.css

# Add interactively (choose what to stage)
git add -p
```

**Interactive Staging Example:**
```bash
git add -p filename.txt

# Options:
# y - stage this hunk
# n - don't stage
# s - split into smaller hunks
# e - manually edit hunk
# q - quit
```

---

### 💾 Commit Changes

```bash
# Commit with message
git commit -m "Add user authentication feature"

# Commit with detailed message
git commit -m "Add user login" -m "- Implement JWT tokens
- Add password hashing
- Create login API endpoint"

# Add and commit in one command
git commit -am "Update documentation"

# Commit with editor for long message
git commit

# Amend last commit (fix message or add files)
git commit --amend -m "Corrected commit message"

# Amend without changing message
git commit --amend --no-edit
```

---

### 📝 Commit Message Best Practices

**Good Commit Message Format:**
```
<type>: <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance

**Examples:**
```bash
# ✅ Good commits
git commit -m "feat: add user registration form"
git commit -m "fix: resolve login redirect issue"
git commit -m "docs: update API documentation"
git commit -m "refactor: simplify database queries"

# ❌ Bad commits
git commit -m "update"
git commit -m "fix bug"
git commit -m "changes"
git commit -m "asdfasdf"
```

---

### 🗑️ Remove Files

```bash
# Remove file from Git and filesystem
git rm filename.txt

# Remove file from Git only (keep in filesystem)
git rm --cached filename.txt

# Remove directory
git rm -r directory/

# Force remove (if file has changes)
git rm -f filename.txt
```

---

### 📋 Move/Rename Files

```bash
# Rename file
git mv oldname.txt newname.txt

# Move file to directory
git mv file.txt directory/

# This is equivalent to:
# mv oldname.txt newname.txt
# git rm oldname.txt
# git add newname.txt
```

---

## 📜 Viewing History

### 📖 View Commit History

```bash
# Basic log
git log

# One line per commit
git log --oneline

# Show last N commits
git log -5

# Show with diff
git log -p

# Show statistics
git log --stat

# Graphical representation
git log --graph --oneline --all

# Beautiful format
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
```

**Output Example:**
```bash
$ git log --oneline
a1b2c3d (HEAD -> main) feat: add user authentication
e4f5g6h fix: resolve database connection issue
i7j8k9l docs: update README
```

---

### 🔍 Filter Commit History

```bash
# By author
git log --author="John Doe"

# By date range
git log --since="2024-01-01"
git log --until="2024-01-31"
git log --since="2 weeks ago"

# By message
git log --grep="bug"

# By file
git log -- filename.txt

# By content
git log -S "function_name"

# Combining filters
git log --author="John" --since="1 month ago" --grep="feature"
```

---

### 👁️ View Specific Commit

```bash
# Show commit details
git show a1b2c3d

# Show specific file in commit
git show a1b2c3d:path/to/file.txt

# Show files changed in commit
git show --name-only a1b2c3d
```

---

### 📊 View File Changes

```bash
# See unstaged changes
git diff

# See staged changes
git diff --staged
# or
git diff --cached

# Compare branches
git diff main..feature-branch

# Compare commits
git diff a1b2c3d..e4f5g6h

# See changes in specific file
git diff filename.txt

# See who changed what (blame)
git blame filename.txt

# Show file at specific commit
git show a1b2c3d:filename.txt
```

---

## ⏮️ Undoing Changes

### 🔄 Discard Working Directory Changes

```bash
# Discard changes in specific file
git restore filename.txt
# or (old way)
git checkout -- filename.txt

# Discard all changes
git restore .

# Discard changes in directory
git restore src/
```

---

### 📤 Unstage Files

```bash
# Unstage specific file
git restore --staged filename.txt
# or (old way)
git reset HEAD filename.txt

# Unstage all files
git restore --staged .
```

---

### ⏪ Undo Commits

**⚠️ Use with Caution! These change history.**

```bash
# Undo last commit, keep changes staged
git reset --soft HEAD~1

# Undo last commit, keep changes unstaged
git reset --mixed HEAD~1
# or simply
git reset HEAD~1

# Undo last commit, discard all changes
git reset --hard HEAD~1

# Undo multiple commits
git reset --hard HEAD~3

# Reset to specific commit
git reset --hard a1b2c3d
```

**Reset Types:**

| Type | Moves HEAD | Updates Index | Updates Working Dir |
|------|-----------|---------------|-------------------|
| `--soft` | ✅ | ❌ | ❌ |
| `--mixed` | ✅ | ✅ | ❌ |
| `--hard` | ✅ | ✅ | ✅ |

---

### 🔙 Revert Commits (Safe)

```bash
# Create new commit that undoes changes
git revert a1b2c3d

# Revert without creating commit
git revert -n a1b2c3d

# Revert multiple commits
git revert a1b2c3d..e4f5g6h

# Revert merge commit
git revert -m 1 merge-commit-hash
```

> **💡 Tip:** Use `git revert` for public/shared branches, `git reset` for local branches only.

---

### 🔍 Find Lost Commits

```bash
# View reflog (history of HEAD)
git reflog

# Recover lost commit
git checkout a1b2c3d
# or create branch
git branch recovered a1b2c3d
```

---

## 🌿 Branching & Merging

### 🌳 Branch Basics

**Why Use Branches?**
- ✨ Develop features independently
- 🐛 Fix bugs without affecting main code
- 🧪 Experiment safely
- 👥 Collaborate effectively

---

### ➕ Create Branches

```bash
# Create new branch
git branch feature-login

# Create and switch to branch
git checkout -b feature-login
# or (new way)
git switch -c feature-login

# Create branch from specific commit
git branch feature-login a1b2c3d

# Create branch from remote branch
git checkout -b feature-login origin/feature-login
```

---

### 🔀 Switch Branches

```bash
# Switch to branch
git checkout feature-login
# or (new way)
git switch feature-login

# Switch to previous branch
git checkout -
# or
git switch -
```

---

### 👀 View Branches

```bash
# List local branches
git branch

# List all branches (including remote)
git branch -a

# List remote branches only
git branch -r

# Show last commit on each branch
git branch -v

# Show merged branches
git branch --merged

# Show unmerged branches
git branch --no-merged
```

**Output Example:**
```bash
$ git branch
  develop
* feature-login
  main
```
`*` indicates current branch

---

### 🔗 Merge Branches

**Fast-Forward Merge:**
```bash
# Switch to target branch
git checkout main

# Merge feature branch
git merge feature-login
```

```
Before:                After Fast-Forward:
main      feature      main/feature
  │          │            │
  A──────────B────C       A────B────C
```

**Three-Way Merge:**
```bash
git checkout main
git merge feature-login
```

```
Before:                After Three-Way Merge:
main      feature      main        feature
  │          │           │            │
  A──B       │           A──B────D────E (merge commit)
     │       │              │    │
     └───C───┘              └────C
```

**Merge with Message:**
```bash
git merge feature-login -m "Merge login feature"
```

**Abort Merge:**
```bash
git merge --abort
```

---

### ⚔️ Resolve Merge Conflicts

**When Conflict Occurs:**
```bash
$ git merge feature-login
Auto-merging index.html
CONFLICT (content): Merge conflict in index.html
Automatic merge failed; fix conflicts and then commit the result.
```

**Conflict Markers in File:**
```html
<html>
<<<<<<< HEAD
<title>My Website</title>
=======
<title>Our Awesome Website</title>
>>>>>>> feature-login
</html>
```

**Resolution Steps:**

1. **Open conflicted file(s)**
2. **Decide which changes to keep**
3. **Remove conflict markers**
4. **Save the file**
5. **Mark as resolved**
   ```bash
   git add index.html
   ```
6. **Complete the merge**
   ```bash
   git commit
   ```

**Tools to Help:**
```bash
# Use merge tool
git mergetool

# See conflicts
git diff

# Show both versions
git show :1:filename  # common ancestor
git show :2:filename  # HEAD (current branch)
git show :3:filename  # merging branch
```

---

### 🗑️ Delete Branches

```bash
# Delete merged branch
git branch -d feature-login

# Force delete branch (even if unmerged)
git branch -D feature-login

# Delete remote branch
git push origin --delete feature-login
```

---

### 📋 Rename Branch

```bash
# Rename current branch
git branch -m new-branch-name

# Rename other branch
git branch -m old-name new-name

# Update remote
git push origin :old-name new-name
git push origin -u new-name
```

---

## 🌐 Remote Repositories

### 🔗 Add Remote

```bash
# Add remote repository
git remote add origin https://github.com/username/repo.git

# Add multiple remotes
git remote add upstream https://github.com/original/repo.git
```

---

### 👀 View Remotes

```bash
# List remotes
git remote

# Show remote URLs
git remote -v

# Show remote details
git remote show origin
```

**Output:**
```bash
$ git remote -v
origin  https://github.com/user/repo.git (fetch)
origin  https://github.com/user/repo.git (push)
upstream https://github.com/original/repo.git (fetch)
upstream https://github.com/original/repo.git (push)
```

---

### 📥 Fetch & Pull

**Fetch (Download without merging):**
```bash
# Fetch from origin
git fetch origin

# Fetch specific branch
git fetch origin main

# Fetch all remotes
git fetch --all

# Fetch and prune deleted branches
git fetch --prune
```

**Pull (Fetch + Merge):**
```bash
# Pull current branch
git pull

# Pull specific branch
git pull origin main

# Pull with rebase
git pull --rebase

# Pull all branches
git pull --all
```

**Pull vs Fetch:**
```
Fetch:  Remote → Local Repo (no merge)
Pull:   Remote → Local Repo → Working Dir (merge)
```

---

### 📤 Push to Remote

```bash
# Push current branch
git push

# Push to specific remote/branch
git push origin main

# Push and set upstream
git push -u origin feature-branch

# Push all branches
git push --all

# Push tags
git push --tags

# Force push (⚠️ dangerous!)
git push --force
# Safer force push
git push --force-with-lease
```

---

### 🔧 Change Remote URL

```bash
# Change remote URL
git remote set-url origin https://github.com/user/new-repo.git

# Switch from HTTPS to SSH
git remote set-url origin git@github.com:user/repo.git
```

---

### 🗑️ Remove Remote

```bash
# Remove remote
git remote remove origin
```

---

## 🔄 Git Workflows

### 🌊 Common Workflows

#### 1️⃣ **Centralized Workflow**
```
main ──A────B────C────D────E──>
       ↑    ↑    ↑    ↑    ↑
     Dev1 Dev2 Dev1 Dev2 Dev1
```
- Single main branch
- Everyone commits directly
- Good for small teams

---

#### 2️⃣ **Feature Branch Workflow**
```
main     ──A────────E────────H──>
              ↘    ↗    ↘    ↗
feature-1      B──C──D    │
                          ↗
feature-2        ────F──G
```
- Create branch for each feature
- Merge when complete
- Most common workflow

**Example:**
```bash
# Create feature branch
git checkout -b feature-user-auth

# Work on feature
git add .
git commit -m "Add user authentication"

# Push to remote
git push -u origin feature-user-auth

# Merge to main
git checkout main
git merge feature-user-auth
git push
```

---

#### 3️⃣ **Gitflow Workflow**
```
main     ──A──────────H──────────M──>
            ↘        ↗  ↘        ↗
develop      B──C──D──E──F──G──H
              ↘  ↗      ↘  ↗
feature-1      C──D       │
                         ↗
feature-2          ─────G
```

**Branches:**
- `main` - Production code
- `develop` - Integration branch
- `feature/*` - New features
- `release/*` - Release preparation
- `hotfix/*` - Emergency fixes

**Example:**
```bash
# Start feature
git checkout -b feature/user-profile develop

# Finish feature
git checkout develop
git merge --no-ff feature/user-profile
git branch -d feature/user-profile

# Start release
git checkout -b release/1.0.0 develop

# Finish release
git checkout main
git merge --no-ff release/1.0.0
git tag -a 1.0.0
git checkout develop
git merge --no-ff release/1.0.0
git branch -d release/1.0.0
```

---

#### 4️⃣ **Forking Workflow** (Open Source)
```
Original Repo:
main ──A────B────C────D──>

Your Fork:
main ──A────B────C────D────E────F──>
                        ↘        ↗
                      feature   
                         E────F
```

**Steps:**
1. Fork repository
2. Clone your fork
3. Create feature branch
4. Make changes
5. Push to your fork
6. Create Pull Request

---

## 🔀 Rebasing

### 🎯 What is Rebase?

**Rebase** rewrites history by moving commits to a new base.

**Merge vs Rebase:**
```
Merge:                    Rebase:
main    A──B──D           main    A──B──D
         ↘  ↗  ↘                      ↘
feature   C     E         feature      C'──D'
```

---

### 📝 Basic Rebase

```bash
# Rebase current branch onto main
git checkout feature-branch
git rebase main

# or
git rebase main feature-branch
```

**Steps:**
1. Git finds common ancestor
2. Saves your commits
3. Applies main's commits
4. Reapplies your commits

---

### ⚔️ Resolve Rebase Conflicts

```bash
# When conflict occurs
$ git rebase main
CONFLICT (content): Merge conflict in file.txt

# Fix conflicts, then:
git add file.txt
git rebase --continue

# Skip current commit
git rebase --skip

# Abort rebase
git rebase --abort
```

---

### 🔄 Interactive Rebase

**Rewrite History:**
```bash
# Rebase last 3 commits
git rebase -i HEAD~3

# Rebase from specific commit
git rebase -i a1b2c3d
```

**Editor Opens:**
```
pick a1b2c3d Add feature A
pick e4f5g6h Fix typo
pick i7j8k9l Add feature B

# Commands:
# p, pick = use commit
# r, reword = use commit, but edit message
# e, edit = use commit, but stop for amending
# s, squash = meld into previous commit
# f, fixup = like squash, but discard message
# d, drop = remove commit
```

**Common Uses:**

**Squash Commits:**
```
pick a1b2c3d Add feature A
squash e4f5g6h Fix typo
squash i7j8k9l Add more to feature A
```

**Reword Commit:**
```
pick a1b2c3d Add feature A
reword e4f5g6h Fix typo  # Will prompt for new message
pick i7j8k9l Add feature B
```

**Reorder Commits:**
```
pick i7j8k9l Add feature B
pick a1b2c3d Add feature A
pick e4f5g6h Fix typo
```

---

### ⚠️ Golden Rule of Rebasing

**❌ Never rebase commits that exist on public/shared branches!**

```bash
# ✅ Safe: Rebasing local feature branch
git checkout feature-branch
git rebase main

# ❌ Dangerous: Rebasing shared branch
git checkout main
git rebase feature-branch  # Others will have conflicts!
```

---

## 💼 Stashing

### 💾 Save Work Temporarily

**Stash** saves your changes without committing.

```bash
# Stash changes
git stash

# Stash with message
git stash save "WIP: feature implementation"

# Stash including untracked files
git stash -u

# Stash including ignored files
git stash -a
```

---

### 📤 Apply Stashed Changes

```bash
# Apply most recent stash
git stash apply

# Apply and remove from stash list
git stash pop

# Apply specific stash
git stash apply stash@{2}

# Apply to different branch
git stash branch new-branch-name
```

---

### 👀 View Stashes

```bash
# List all stashes
git stash list

# Show stash contents
git stash show

# Show detailed stash contents
git stash show -p
```

**Output:**
```bash
$ git stash list
stash@{0}: WIP on main: a1b2c3d Add feature
stash@{1}: WIP on develop: e4f5g6h Fix bug
```

---

### 🗑️ Delete Stashes

```bash
# Delete specific stash
git stash drop stash@{0}

# Delete all stashes
git stash clear
```

---

## 🍒 Cherry Picking

### 🎯 Apply Specific Commits

**Cherry-pick** applies a commit from one branch to another.

```bash
# Apply specific commit
git cherry-pick a1b2c3d

# Apply multiple commits
git cherry-pick a1b2c3d e4f5g6h

# Apply without committing
git cherry-pick -n a1b2c3d

# Apply and edit message
git cherry-pick -e a1b2c3d
```

**Visual:**
```
main      A──B──D──E
           ↘     ↗
feature     C───→  (cherry-picked)
```

---

### ⚔️ Resolve Cherry-Pick Conflicts

```bash
# Fix conflicts, then:
git add .
git cherry-pick --continue

# Abort cherry-pick
git cherry-pick --abort
```

---

## 🏷️ Git Tags

### 📌 Create Tags

**Lightweight Tag:**
```bash
git tag v1.0.0
```

**Annotated Tag** (Recommended):
```bash
# With message
git tag -a v1.0.0 -m "Release version 1.0.0"

# Tag specific commit
git tag -a v1.0.0 a1b2c3d -m "Release 1.0.0"
```

---

### 👀 View Tags

```bash
# List all tags
git tag

# Search tags
git tag -l "v1.*"

# Show tag details
git show v1.0.0
```

---

### 📤 Push Tags

```bash
# Push specific tag
git push origin v1.0.0

# Push all tags
git push --tags

# Push annotated tags only
git push --follow-tags
```

---

### 🗑️ Delete Tags

```bash
# Delete local tag
git tag -d v1.0.0

# Delete remote tag
git push origin --delete v1.0.0
# or
git push origin :refs/tags/v1.0.0
```

---

### ✅ Checkout Tags

```bash
# Checkout tag (detached HEAD)
git checkout v1.0.0

# Create branch from tag
git checkout -b version-1 v1.0.0
```

---

## 📦 Submodules

### ➕ Add Submodule

```bash
# Add submodule
git submodule add https://github.com/user/library.git lib/library

# Add to specific path
git submodule add https://github.com/user/plugin.git plugins/custom-plugin

# Commit submodule
git commit -m "Add library submodule"
```

---

### 📥 Clone with Submodules

```bash
# Clone and initialize submodules
git clone --recursive https://github.com/user/repo.git

# If already cloned without --recursive
git submodule init
git submodule update

# Or in one command
git submodule update --init --recursive
```

---

### 🔄 Update Submodules

```bash
# Update all submodules to latest
git submodule update --remote

# Update specific submodule
git submodule update --remote lib/library

# Pull changes in submodule
cd lib/library
git pull origin main
cd ../..
git add lib/library
git commit -m "Update library submodule"
```

---

### 🗑️ Remove Submodule

```bash
# Remove submodule (multi-step process)
git submodule deinit lib/library
git rm lib/library
rm -rf .git/modules/lib/library
git commit -m "Remove library submodule"
```

---

## 🤝 Forking & Pull Requests

### 🍴 Fork a Repository

**On GitHub:**
1. Navigate to repository
2. Click **Fork** button (top-right)
3. Choose your account
4. Wait for fork to complete

---

### 📥 Clone Your Fork

```bash
# Clone your fork
git clone https://github.com/YOUR-USERNAME/repo.git
cd repo

# Add original repo as upstream
git remote add upstream https://github.com/ORIGINAL-OWNER/repo.git

# Verify remotes
git remote -v
```

**Output:**
```bash
origin    https://github.com/YOUR-USERNAME/repo.git (fetch)
origin    https://github.com/YOUR-USERNAME/repo.git (push)
upstream  https://github.com/ORIGINAL-OWNER/repo.git (fetch)
upstream  https://github.com/ORIGINAL-OWNER/repo.git (push)
```

---

### 🔄 Sync Fork with Upstream

```bash
# Fetch upstream changes
git fetch upstream

# Merge upstream into your main
git checkout main
git merge upstream/main

# Or rebase
git rebase upstream/main

# Push to your fork
git push origin main
```

---

### 🌿 Create Feature Branch

```bash
# Create and switch to feature branch
git checkout -b feature/add-dark-mode

# Make changes
# ... edit files ...

# Commit changes
git add .
git commit -m "feat: add dark mode toggle"

# Push to your fork
git push -u origin feature/add-dark-mode
```

---

### 📝 Create Pull Request

**On GitHub:**
1. Go to your fork on GitHub
2. Click **Pull requests** tab
3. Click **New pull request**
4. Select:
   - Base repository: original repo
   - Base branch: main
   - Head repository: your fork
   - Compare branch: feature/add-dark-mode
5. Fill in PR details:
   ```markdown
   ## Description
   Added dark mode toggle feature
   
   ## Changes
   - Added toggle button in navbar
   - Implemented dark theme CSS
   - Added localStorage persistence
   
   ## Screenshots
   [Add screenshots if UI changes]
   
   ## Testing
   - Tested on Chrome, Firefox, Safari
   - Verified localStorage functionality
   
   ## Closes
   Closes #123
   ```
6. Click **Create pull request**

---

### 🔄 Update Pull Request

```bash
# Make additional changes
git add .
git commit -m "fix: address review comments"

# Push to same branch
git push origin feature/add-dark-mode

# PR automatically updates!
```

---

### 🔀 Handling Review Comments

```bash
# Make requested changes
# ... edit files ...

# Commit with descriptive message
git add .
git commit -m "refactor: improve dark mode implementation

- Extract theme logic into separate file
- Add unit tests
- Fix toggle animation"

# Push changes
git push origin feature/add-dark-mode
```

---

### ✅ After PR is Merged

```bash
# Switch to main
git checkout main

# Delete local feature branch
git branch -d feature/add-dark-mode

# Delete remote feature branch
git push origin --delete feature/add-dark-mode

# Update your main with upstream
git fetch upstream
git merge upstream/main
git push origin main
```

---

## 📚 Contributing to Projects

### 🎯 Find Projects to Contribute To

**Good First Issue Labels:**
- `good first issue`
- `beginner-friendly`
- `help wanted`
- `easy`

**Platforms:**
- [GitHub Explore](https://github.com/explore)
- [Good First Issue](https://goodfirstissue.dev/)
- [First Timers Only](https://www.firsttimersonly.com/)
- [Up For Grabs](https://up-for-grabs.net/)

---

### 📖 Read Contributing Guidelines

**Before contributing, check for:**
- `CONTRIBUTING.md`
- `CODE_OF_CONDUCT.md`
- `README.md`
- Issue templates
- PR templates

---

### ✅ Contribution Checklist

- [ ] Fork the repository
- [ ] Create descriptive branch name
- [ ] Follow code style guidelines
- [ ] Write clear commit messages
- [ ] Add tests if applicable
- [ ] Update documentation
- [ ] Test your changes
- [ ] Create focused PR (one feature/fix)
- [ ] Fill PR template completely
- [ ] Be responsive to feedback
- [ ] Be patient and respectful

---

### 📝 Commit Message Guidelines

**Conventional Commits:**
```bash
<type>(<scope>): <subject>

<body>

<footer>
```

**Examples:**
```bash
feat(auth): add OAuth2 login support

Implement OAuth2 authentication flow with Google and GitHub providers.
Includes token refresh and secure storage.

Closes #45

fix(ui): resolve mobile navigation overlap

The hamburger menu was overlapping with the logo on screens < 768px.
Adjusted z-index and positioning.

Fixes #123

docs(readme): update installation instructions

Added prerequisites section and clarified Node.js version requirement.

refactor(api): simplify error handling

Consolidated error handling logic into middleware.
Reduced code duplication by 30%.

test(user): add unit tests for user registration

Added comprehensive test coverage for user registration flow
including validation and error cases.

chore(deps): update dependencies to latest versions

Updated all npm packages to resolve security vulnerabilities.
```

---

### 🎨 Code Review Best Practices

**As a Contributor:**
- ✅ Respond promptly to feedback
- ✅ Be open to suggestions
- ✅ Ask questions if unclear
- ✅ Make requested changes
- ✅ Test thoroughly
- ❌ Don't take feedback personally
- ❌ Don't argue unnecessarily

**As a Reviewer:**
- ✅ Be constructive and respectful
- ✅ Explain your reasoning
- ✅ Suggest improvements
- ✅ Acknowledge good work
- ✅ Test the changes
- ❌ Don't be overly critical
- ❌ Don't nitpick unnecessarily

---

## 🔨 Git Hooks

### 🎯 What are Git Hooks?

**Git hooks** are scripts that run automatically at certain Git events.

**Hook Types:**

| Hook | Trigger | Use Case |
|------|---------|----------|
| `pre-commit` | Before commit | Lint code, run tests |
| `prepare-commit-msg` | After commit message creation | Add ticket number |
| `commit-msg` | Before commit finalized | Validate message format |
| `post-commit` | After commit | Send notifications |
| `pre-push` | Before push | Run full test suite |
| `pre-rebase` | Before rebase | Prevent rebasing protected branches |

---

### 📝 Create Hooks

**Location:** `.git/hooks/`

**Pre-commit Hook Example:**
```bash
# Create file: .git/hooks/pre-commit
#!/bin/bash

echo "Running pre-commit checks..."

# Run linter
npm run lint
if [ $? -ne 0 ]; then
    echo "❌ Linting failed! Fix errors before committing."
    exit 1
fi

# Run tests
npm test
if [ $? -ne 0 ]; then
    echo "❌ Tests failed! Fix tests before committing."
    exit 1
fi

echo "✅ Pre-commit checks passed!"
exit 0
```

**Make executable:**
```bash
chmod +x .git/hooks/pre-commit
```

---

### 📦 Husky (Easier Hook Management)

**Install Husky:**
```bash
npm install husky --save-dev
npx husky install

# Add to package.json
npm set-script prepare "husky install"
```

**Add Pre-commit Hook:**
```bash
npx husky add .git/hooks/pre-commit "npm run lint"
npx husky add .git/hooks/pre-commit "npm test"
```

**Add Commit Message Hook:**
```bash
npx husky add .git/hooks/commit-msg 'npx --no -- commitlint --edit "$1"'
```

---

### 🎯 Pre-commit Hook Examples

**Python Linting:**
```bash
#!/bin/bash
echo "Running Python linter..."
python -m flake8 .
```

**JavaScript Formatting:**
```bash
#!/bin/bash
echo "Running Prettier..."
npm run format
git add -A
```

**Prevent Commits to Main:**
```bash
#!/bin/bash
branch="$(git rev-parse --abbrev-ref HEAD)"

if [ "$branch" = "main" ]; then
  echo "❌ Cannot commit directly to main branch!"
  exit 1
fi
```

---

## 🚀 CI/CD Integration

### 🎯 GitHub Actions

**`.github/workflows/test.yml`:**
```yaml
name: Run Tests

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
    
    - name: Install dependencies
      run: npm ci
    
    - name: Run linter
      run: npm run lint
    
    - name: Run tests
      run: npm test
    
    - name: Build
      run: npm run build
```

---

### 📋 GitLab CI

**`.gitlab-ci.yml`:**
```yaml
stages:
  - test
  - build
  - deploy

test:
  stage: test
  script:
    - npm ci
    - npm run lint
    - npm test
  only:
    - main
    - develop

build:
  stage: build
  script:
    - npm run build
  artifacts:
    paths:
      - dist/
  only:
    - main

deploy:
  stage: deploy
  script:
    - npm run deploy
  only:
    - main
```

---

## 🔧 Advanced Git Commands

### 🔍 Search in Code

```bash
# Search for text in all files
git grep "function_name"

# Search in specific file types
git grep "TODO" -- "*.js"

# Search with line numbers
git grep -n "bug"

# Search in specific commit
git grep "pattern" commit-hash

# Count occurrences
git grep -c "import"
```

---

### 📊 Repository Statistics

```bash
# Count commits by author
git shortlog -sn

# Show code contributions
git log --author="John" --oneline --shortstat

# Lines added/removed by author
git log --author="John" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added: %s, removed: %s, total: %s\n", add, subs, loc }'

# File change frequency
git log --pretty=format: --name-only | sort | uniq -c | sort -rg | head -10

# Contributors
git log --format='%aN' | sort -u
```

---

### 🔍 Find Bugs with Bisect

**Binary search to find bug introduction:**

```bash
# Start bisect
git bisect start

# Mark current as bad
git bisect bad

# Mark known good commit
git bisect good a1b2c3d

# Git checks out middle commit
# Test and mark as good or bad
git bisect good  # or git bisect bad

# Repeat until bug is found

# Reset when done
git bisect reset
```

**Automated Bisect:**
```bash
git bisect start HEAD a1b2c3d
git bisect run npm test
```

---

### 🔄 Advanced Diff

```bash
# Word diff
git diff --word-diff

# Show changes with context
git diff -U10  # 10 lines of context

# Ignore whitespace
git diff -w

# Show file names only
git diff --name-only

# Show statistics
git diff --stat

# Compare branches
git diff main..develop

# Three-way diff
git diff HEAD HEAD~1 HEAD~2
```

---

### 📝 Patch Files

```bash
# Create patch file
git format-patch -1 HEAD

# Create patch for multiple commits
git format-patch HEAD~3

# Create patch for branch
git format-patch main..feature-branch

# Apply patch
git apply 0001-patch-name.patch

# Apply with am (includes commit info)
git am 0001-patch-name.patch
```

---

### 🔍 Find Who Changed What

```bash
# Annotate file with commit info
git blame filename.txt

# Show specific lines
git blame -L 10,20 filename.txt

# Ignore whitespace changes
git blame -w filename.txt

# Show email instead of name
git blame -e filename.txt
```

---

## 🆘 Troubleshooting

### 🔥 Common Problems & Solutions

#### Problem: Committed to Wrong Branch

```bash
# Create new branch with current commits
git branch feature-branch

# Reset current branch
git reset --hard HEAD~3

# Switch to new branch
git checkout feature-branch
```

---

#### Problem: Need to Undo Last Commit

```bash
# Keep changes in working directory
git reset --soft HEAD~1

# Discard changes completely
git reset --hard HEAD~1
```

---

#### Problem: Pushed Wrong Code

```bash
# Create revert commit (safe for public branches)
git revert HEAD
git push

# Force push (⚠️ only if no one else pulled)
git reset --hard HEAD~1
git push --force-with-lease
```

---

#### Problem: Merge Conflict

```bash
# See conflicted files
git status

# Use merge tool
git mergetool

# Abort merge
git merge --abort

# After fixing conflicts
git add .
git commit
```

---

#### Problem: Accidentally Deleted Branch

```bash
# Find commit hash
git reflog

# Recreate branch
git branch recovered-branch commit-hash
```

---

#### Problem: Large File in History

```bash
# Remove large file from history
git filter-branch --tree-filter 'rm -f path/to/large/file' HEAD

# Or use BFG Repo-Cleaner (faster)
java -jar bfg.jar --delete-files large-file.zip
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

---

#### Problem: Detached HEAD State

```bash
# Create branch to save work
git branch temp-branch

# Or checkout existing branch
git checkout main
```

---

#### Problem: Wrong Commit Message

```bash
# Fix last commit message
git commit --amend -m "Correct message"

# Fix older commit message
git rebase -i HEAD~3
# Change 'pick' to 'reword' for the commit
```

---

#### Problem: Need to Split Commit

```bash
# Start interactive rebase
git rebase -i HEAD~3

# Change 'pick' to 'edit' for commit to split
# Git will pause at that commit

# Reset but keep changes
git reset HEAD~1

# Stage and commit separately
git add file1.txt
git commit -m "First part"

git add file2.txt
git commit -m "Second part"

# Continue rebase
git rebase --continue
```

---

### 🔍 Debug Git Issues

```bash
# Verbose output
GIT_TRACE=1 git push

# Trace environment
GIT_TRACE_SETUP=1 git status

# Check repository integrity
git fsck

# Verify connectivity
git remote -v
ssh -T git@github.com

# Clean up repository
git gc
git prune
```

---

## 📌 Common Commands Cheat Sheet

### 🚀 Setup & Config

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --list
```

---

### 📦 Create & Clone

```bash
git init
git clone <url>
git clone -b <branch> <url>
```

---

### 📊 Basic Commands

```bash
git status
git add <file>
git add .
git commit -m "message"
git commit -am "message"
git push
git pull
```

---

### 🌿 Branching

```bash
git branch
git branch <name>
git checkout <branch>
git checkout -b <branch>
git merge <branch>
git branch -d <branch>
```

---

### 📜 History

```bash
git log
git log --oneline
git log --graph --all
git show <commit>
git diff
```

---

### ⏮️ Undo

```bash
git restore <file>
git restore --staged <file>
git reset HEAD~1
git reset --hard HEAD~1
git revert <commit>
```

---

### 🌐 Remote

```bash
git remote add origin <url>
git remote -v
git fetch
git pull
git push
git push -u origin <branch>
```

---

### 🔧 Advanced

```bash
git stash
git stash pop
git cherry-pick <commit>
git rebase <branch>
git rebase -i HEAD~3
git tag <name>
```

---

## ⚡ Git Aliases

### 🎯 Create Useful Aliases

```bash
# Pretty log
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Short status
git config --global alias.st "status -sb"

# Quick commit
git config --global alias.cm "commit -m"

# Amend commit
git config --global alias.amend "commit --amend --no-edit"

# Undo last commit
git config --global alias.undo "reset HEAD~1 --mixed"

# List aliases
git config --global alias.alias "config --get-regexp ^alias\."

# Delete merged branches
git config --global alias.cleanup "!git branch --merged | grep -v '\\*\\|main\\|develop' | xargs -n 1 git branch -d"

# Show changed files
git config --global alias.changed "diff --name-only"

# Contributors
git config --global alias.contributors "shortlog -sn"
```

**Usage:**
```bash
git lg
git st
git cm "Fix bug"
git amend
git undo
```

---

## ✅ Best Practices

### 📝 Commit Best Practices

✅ **DO:**
- Write clear, descriptive commit messages
- Commit logical units of work
- Commit often (small, focused commits)
- Use present tense ("Add feature" not "Added feature")
- Reference issue numbers
- Keep commits atomic (one purpose per commit)

❌ **DON'T:**
- Commit commented-out code
- Commit TODO comments
- Commit sensitive data (passwords, keys)
- Make huge commits with mixed changes
- Commit generated files
- Use vague messages ("fix", "update", "changes")

---

### 🌿 Branch Best Practices

✅ **DO:**
- Use descriptive branch names
- Follow naming conventions:
  - `feature/user-authentication`
  - `bugfix/login-error`
  - `hotfix/security-patch`
  - `release/v1.2.0`
- Keep branches short-lived
- Delete merged branches
- Regularly sync with main

❌ **DON'T:**
- Use ambiguous names (`test`, `fix`, `temp`)
- Keep long-lived feature branches
- Work directly on main
- Leave stale branches

---

### 🔀 Merge Best Practices

✅ **DO:**
- Pull before you push
- Resolve conflicts carefully
- Test after merging
- Use merge commits for feature branches
- Document merge strategy in CONTRIBUTING.md

❌ **DON'T:**
- Force push to shared branches
- Merge without testing
- Ignore conflicts
- Mix formatting changes with logic changes

---

### 📊 Repository Best Practices

✅ **DO:**
- Include `.gitignore`
- Add README.md
- Include LICENSE
- Add CONTRIBUTING.md for open source
- Use .gitattributes for consistent line endings
- Add CI/CD configuration
- Include issue/PR templates

❌ **DON'T:**
- Commit node_modules, vendor, or build folders
- Commit IDE-specific files
- Commit local configuration
- Commit large binary files (use Git LFS)

---

### 🔒 Security Best Practices

✅ **DO:**
- Use SSH keys for authentication
- Enable two-factor authentication
- Review code before committing
- Use environment variables for secrets
- Scan for secrets with tools
- Use signed commits

❌ **DON'T:**
- Commit API keys or passwords
- Share credentials
- Commit .env files with secrets
- Disable security features
- Use weak passwords

---

### 📁 .gitignore Best Practices

**Common .gitignore Template:**
```gitignore
# Dependencies
node_modules/
vendor/
bower_components/

# Build outputs
dist/
build/
*.min.js
*.min.css

# IDE
.vscode/
.idea/
*.swp
*.swo
.DS_Store

# Environment
.env
.env.local
.env*.local

# Logs
*.log
logs/
npm-debug.log*

# Testing
coverage/
.nyc_output/

# Operating System
Thumbs.db
.DS_Store

# Python
__pycache__/
*.py[cod]
*.so
.Python
venv/

# Java
*.class
*.jar
target/

# Temporary
*.tmp
*.bak
*.swp
```

---

## 🎓 Learning Resources

### 📚 Official Documentation
- [Git Official Documentation](https://git-scm.com/doc)
- [Pro Git Book (Free)](https://git-scm.com/book/en/v2)
- [Git Reference](https://git-scm.com/docs)

### 🎮 Interactive Learning
- [Learn Git Branching](https://learngitbranching.js.org/) - Visual, interactive tutorial
- [Git Immersion](http://gitimmersion.com/) - Guided tour
- [GitHub Learning Lab](https://lab.github.com/)
- [Katacoda Git Scenarios](https://www.katacoda.com/courses/git)

### 📺 Video Courses
- [Git and GitHub for Beginners - FreeCodeCamp](https://www.youtube.com/watch?v=RGOj5yH7evk)
- [Git Tutorial - Programming with Mosh](https://www.youtube.com/watch?v=8JJ101D3knE)

### 📖 Guides & Tutorials
- [Atlassian Git Tutorial](https://www.atlassian.com/git/tutorials)
- [GitHub Guides](https://guides.github.com/)
- [GitLab Git Handbook](https://about.gitlab.com/handbook/git/)

### 🛠️ Tools
- [GitHub Desktop](https://desktop.github.com/) - GUI for Git
- [GitKraken](https://www.gitkraken.com/) - Advanced GUI
- [Sourcetree](https://www.sourcetreeapp.com/) - Free GUI
- [VS Code Git Integration](https://code.visualstudio.com/docs/editor/versioncontrol)

### 🏆 Practice Projects
- Contribute to [First Contributions](https://github.com/firstcontributions/first-contributions)
- Browse [Good First Issues](https://goodfirstissue.dev/)
- Try [Exercism](https://exercism.org/) with Git workflow

---

## 🎯 Next Steps

### For Beginners 🌱
1. ✅ Install Git and configure it
2. ✅ Practice basic commands (add, commit, push)
3. ✅ Learn branching and merging
4. ✅ Create your first repository on GitHub
5. ✅ Make your first open-source contribution

### For Intermediate Users 🚀
1. ✅ Master rebasing and stashing
2. ✅ Learn Git workflows (Gitflow, GitHub Flow)
3. ✅ Set up Git hooks
4. ✅ Configure CI/CD with GitHub Actions
5. ✅ Contribute regularly to open source

### For Advanced Users 💎
1. ✅ Optimize large repositories
2. ✅ Master Git internals
3. ✅ Create custom Git commands
4. ✅ Maintain open-source projects
5. ✅ Teach others and give back to community

---

## 📞 Getting Help

### 💬 Community
- [Stack Overflow - Git Tag](https://stackoverflow.com/questions/tagged/git)
- [r/git on Reddit](https://www.reddit.com/r/git/)
- [Git Forum](https://git.661346.n2.nabble.com/)

### 📧 Support
- [GitHub Community Forum](https://github.community/)
- [GitLab Forum](https://forum.gitlab.com/)
- [Git Mailing List](https://git-scm.com/community)

### 🐛 Report Issues
- [Git Bug Reports](https://git-scm.com/community)
- [GitHub Support](https://support.github.com/)

---

<div align="center">

## 🎉 Congratulations!

You now have a comprehensive understanding of Git, from basics to advanced workflows!

### 🌟 Remember:
- Practice regularly
- Start contributing to open source
- Help others learn Git
- Keep exploring and learning

---

### 📚 Quick Tips for Success

💡 **Commit early, commit often**  
🌿 **Branch for every feature**  
🔄 **Pull before you push**  
📝 **Write meaningful commit messages**  
🤝 **Review before you merge**  
🔒 **Never commit secrets**  
📖 **Read the documentation**  
🎓 **Learn from mistakes**

---

**Made with ❤️ for Git learners worldwide**

⭐ If this guide helped you, share it with others!

</div>

---

**Last Updated:** November 2025  
**Version:** 1.0.0  
**License:** Educational Use

---

## 🔖 Appendix

### Common Git Terminology

| Term | Definition |
|------|------------|
| **Repository (Repo)** | Project folder tracked by Git |
| **Commit** | Snapshot of your code at a point in time |
| **Branch** | Independent line of development |
| **Merge** | Combine branches |
| **Fork** | Personal copy of someone's repository |
| **Clone** | Local copy of a repository |
| **Remote** | Repository hosted on internet |
| **Origin** | Default name for remote repository |
| **Upstream** | Original repository you forked from |
| **HEAD** | Pointer to current branch/commit |
| **Staging Area** | Prepared changes for commit |
| **Working Directory** | Your local files |
| **Pull Request (PR)** | Request to merge your changes |
| **Conflict** | Competing changes in same file |
| **Fast-forward** | Moving pointer forward without merge |
| **Detached HEAD** | HEAD points to specific commit, not branch |

---

### Git Status Codes

| Code | Status |
|------|--------|
| `??` | Untracked |
| `A` | Added |
| `M` | Modified |
| `D` | Deleted |
| `R` | Renamed |
| `C` | Copied |
| `U` | Updated but unmerged |

---

### Exit Codes

```bash
0   # Success
1   # General error
128 # Invalid argument
```

---

Happy Gitting! 🚀