# Spec Kit Complete Guide

**Version**: 2.0.0 (Official Best Practices)
**Source**: [GitHub Spec Kit](https://github.com/github/spec-kit)
**Optimized For**: Claude AI + Any Project
**Last Updated**: 2026-02-03

---

> **🎯 PURPOSE**: Drop this file into ANY project. Tell Claude: "Set up Spec Kit using speckit_guide.md" and everything is handled automatically.

> **🌍 UNIVERSAL**: Works with ALL languages and frameworks - JavaScript, Python, Go, Rust, PHP, Java, Ruby, Dart, Swift, Kotlin, and more. Examples show multiple tech stacks, adapt to yours.

---

## 📱 Supported Frameworks & Languages

This guide works with **any** technology stack. Examples include:

| Category | Technologies |
|----------|-------------|
| **Web (JS/TS)** | React, Next.js, Vue, Angular, Svelte, Express, NestJS |
| **Mobile** | React Native, Flutter, Swift (iOS), Kotlin (Android) |
| **Backend** | Node.js, Django, Flask, Laravel, Spring Boot, Rails, Go, Rust |
| **Languages** | JavaScript, TypeScript, Python, Go, Rust, PHP, Java, Ruby, Dart, Swift, Kotlin, C#, C++ |

**All commands and examples are provided with multi-framework alternatives.** Adapt quality gates, tools, and structure to your stack.

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [What is Spec Kit?](#what-is-spec-kit)
3. [For Claude AI: Setup Instructions](#for-claude-ai-setup-instructions)
4. [Installation](#installation)
5. [The Six-Step Workflow](#the-six-step-workflow)
6. [Official Commands](#official-commands)
7. [Constitutional Foundation](#constitutional-foundation)
8. [Directory Structure](#directory-structure)
9. [Helper Scripts](#helper-scripts)
10. [Quality Gates](#quality-gates)
11. [Workflow Patterns](#workflow-patterns)
12. [Git Integration](#git-integration)
13. [Troubleshooting](#troubleshooting)
14. [Best Practices](#best-practices)

---

## Quick Start

### For Users: Single Command

**Copy this to Claude:**

```
Set up Spec Kit using speckit_guide.md.
Follow all official best practices and prepare for our first specification.
```

Claude will handle everything automatically.

### For Claude: What You'll Do

When user says "Set up Spec Kit":

1. Install Spec Kit CLI
2. Create constitution
3. Set up helper scripts
4. Verify slash commands work
5. Confirm setup complete
6. Guide user to create first spec

**See [For Claude AI: Setup Instructions](#for-claude-ai-setup-instructions) section below.**

---

## What is Spec Kit?

### Official Definition

**Spec Kit** is GitHub's open-source toolkit for **Spec-Driven Development (SDD)** — a methodology where specifications become executable and directly generate working implementations.

### Core Philosophy

> "Focus on product scenarios and predictable outcomes instead of vibe coding."

Traditional development treats specs as temporary scaffolding. Spec-Driven Development makes them the **central artifact** that drives implementation through AI-assisted development.

### The Inversion

**Traditional Development:**
```
Code → Documentation → Specs (if at all)
```

**Spec-Driven Development:**
```
Constitution → Specification → Plan → Tasks → Code
```

### Key Benefits

- ✅ **Clarity First** - Define WHAT before HOW
- ✅ **Less Rework** - Catch issues in planning, not code
- ✅ **AI-Optimized** - Structure designed for AI assistants
- ✅ **Scalable** - Works for greenfield, brownfield, exploration
- ✅ **Traceable** - Every implementation traces to specification
- ✅ **Quality Built-In** - Templates enforce best practices

### Supported AI Agents

- Claude Code (Anthropic)
- GitHub Copilot
- Cursor
- Gemini Code Assist
- Amazon Q Developer
- Windsurf
- And 10+ more

---

## For Claude AI: Setup Instructions

### When User Says: "Set up Spec Kit"

Follow these steps exactly:

#### Step 1: Verify Prerequisites

```bash
# Check Python version
python3 --version  # Must be 3.11+

# Check if uv installed
uv --version || echo "Need to install uv"

# Check git
git --version
```

**If uv not installed, guide user:**

```bash
# macOS
brew install uv

# Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# Windows
pip install uv
```

#### Step 2: Install Spec Kit

```bash
# Run official installation
uvx --from git+https://github.com/github/spec-kit.git specify init . --ai claude

# Verify installation
ls .specify/memory/ .specify/specs/ .specify/scripts/ .specify/templates/
```

**Expected output:**
```
.specify/memory/         ✅
.specify/specs/          ✅
.specify/scripts/        ✅
.specify/templates/      ✅
```

#### Step 3: Verify Slash Commands Available

Test these commands work:

```
/speckit.constitution
/speckit.specify
/speckit.plan
/speckit.tasks
```

**If commands don't work:**
- Check `.claude/commands/` directory exists
- Restart Claude Code
- Reinstall if needed

#### Step 4: Create Constitution

**Ask user these questions:**

1. "What's your project name?"
2. "What platforms do you support?" (iOS/Android/Web/All)
3. "Any specific principles?" (Security, performance, etc.)
4. "Test coverage threshold?" (default: 80%)

**Then create `.specify/memory/constitution.md`:**

Use the [Constitutional Template](#constitutional-template) below, filling in user's answers.

#### Step 5: Create Helper Scripts

**Create these 4 scripts in `.specify/scripts/`:**

1. `create-spec.sh` - [See Helper Scripts section](#create-specsh)
2. `validate-spec.sh` - [See Helper Scripts section](#validate-specsh)
3. `check-quality.sh` - [See Helper Scripts section](#check-qualitysh)
4. `list-specs.sh` - [See Helper Scripts section](#list-specssh)

**Make executable:**
```bash
chmod +x .specify/scripts/*.sh
```

#### Step 6: Confirm Setup Complete

**Tell user:**

```
✅ Spec Kit setup complete!

Your project now has:
- Constitution defining core principles
- Spec templates ready to use
- Helper scripts for automation
- Quality gates configured

Available commands:
- /speckit.constitution - View/update constitution
- /speckit.specify - Create new specification
- /speckit.plan - Create technical plan
- /speckit.tasks - Generate task list
- /speckit.implement - Begin implementation

Helper scripts:
- ./.specify/scripts/create-spec.sh - Auto-create specs
- ./.specify/scripts/check-quality.sh - Run quality gates
- ./.specify/scripts/validate-spec.sh - Validate specs
- ./.specify/scripts/list-specs.sh - List all specs

Next: What feature would you like to specify first?
```

### Ongoing Work: Workflow Reference

**Every time user starts new feature:**

```
1. Run /speckit.specify
   → Focus on WHAT and WHY (not HOW)
   → Define requirements clearly
   → Set success criteria
   → Present to user for approval

2. WAIT for approval
   → Never proceed without explicit approval
   → Address all questions first

3. Run /speckit.plan
   → Focus on HOW to build
   → Architecture decisions
   → Technology choices with rationale
   → Present to user for approval

4. WAIT for approval

5. Run /speckit.tasks
   → Break into <30 min tasks
   → Define clear acceptance criteria
   → Present to user

6. Run /speckit.implement
   → Follow TDD (tests before implementation)
   → Commit with spec references
   → Run quality gates after each task
   → Update progress in tasks.md
```

### Before ANY Code Change

**Constitutional Compliance Check:**

```bash
# 1. Read constitution
cat .specify/memory/constitution.md

# 2. Verify compliance with ALL articles
# 3. If violation: STOP and explain to user

# Template response:
⚠️  This violates Article [N] of our constitution:

"[Quote the principle]"

We can either:
1. Find alternative approach that complies
2. Propose constitutional amendment
3. Skip this feature

Which would you prefer?
```

### Before Every Commit

**Quality Gate Check:**

```bash
# Run quality gates
./.specify/scripts/check-quality.sh

# Must pass ALL gates:
# ✅ Type checking: 0 errors
# ✅ Tests: All passing
# ✅ Coverage: ≥ 80% (or constitutional threshold)
# ✅ Linting: 0 errors, 0 warnings
# ✅ Formatting: Correct
# ✅ No console statements
```

**Commit format:**

```bash
git commit -m "feat(scope): description

- Change 1
- Change 2

Implements: Task X.Y from Spec NNN"
```

### When Spec and Code Diverge

```
⚠️  Implementation is diverging from Spec [NNN].

**Spec says**: [What spec requires]
**Current implementation**: [What we're doing]

We should either:
1. Update implementation to match spec
2. Update spec and get re-approval
3. Document rationale in notes.md

Which approach do you prefer?
```

---

## Installation

### Prerequisites

**Required:**
- Python 3.11+
- Git
- `uv` package manager
- Claude Code or other supported AI agent

**Install uv:**

```bash
# macOS
brew install uv

# Linux/WSL
curl -LsSf https://astral.sh/uv/install.sh | sh

# Windows
pip install uv

# Verify
uv --version
```

### Installation Command

**For new projects:**

```bash
uvx --from git+https://github.com/github/spec-kit.git specify init <PROJECT_NAME> --ai claude
```

**For existing projects (current directory):**

```bash
uvx --from git+https://github.com/github/spec-kit.git specify init . --ai claude
```

**Other AI agents:**

```bash
# GitHub Copilot
--ai copilot

# Cursor
--ai cursor

# Gemini
--ai gemini

# Others: codebuddy, qwen, opencode, amazon-q, windsurf, amp, shai, bob
```

**Script type (optional):**

```bash
# Force Bash scripts (Linux/macOS)
--script sh

# Force PowerShell scripts (Windows)
--script ps
```

### Verification

After installation:

```bash
# Check directories created
ls .specify/

# Should see:
# memory/
# specs/
# scripts/
# templates/

# Check slash commands (in Claude)
/speckit.constitution
/speckit.specify
```

**If slash commands don't work:**

```bash
# Check Claude commands directory
ls .claude/commands/

# Should see:
# speckit-constitution.md
# speckit-specify.md
# speckit-plan.md
# speckit-tasks.md
# etc.

# If missing, reinstall
```

---

## The Six-Step Workflow

### Official Spec Kit Workflow

```
1. CONSTITUTION → Define immutable principles
   ↓
2. SPECIFY      → Describe WHAT you're building
   ↓
3. CLARIFY      → Resolve ambiguities (optional)
   ↓
4. PLAN         → Define HOW to build
   ↓
5. TASKS        → Break into actionable STEPS
   ↓
6. IMPLEMENT    → Execute implementation
```

### Detailed Breakdown

#### 1. Constitution (`/speckit.constitution`)

**Purpose**: Establish project's immutable principles

**Creates**: `.specify/memory/constitution.md`

**Content**: Core articles defining:
- Development standards
- Quality requirements
- Technology decisions
- Non-negotiable rules

**When to run:**
- ✅ Once at project start
- ✅ When changing fundamental principles
- ❌ For individual features

**Example:**

```markdown
# Project Constitution

## Article I: Specification-First Development
Every feature must have approved specification before implementation.

## Article II: Test-First Development
Tests written BEFORE implementation code.

## Article III: Type Safety
TypeScript strict mode. Zero 'any' types.
```

#### 2. Specify (`/speckit.specify`)

**Purpose**: Define feature requirements

**Creates**: `.specify/specs/NNN-feature-name/spec.md`

**Focus on:**
- **What**: Feature description
- **Why**: Business justification
- **Who**: User scenarios
- **Success criteria**: Measurable outcomes

**Do NOT include:**
- ❌ Implementation details
- ❌ Technology choices
- ❌ Code structure

**Example sections:**

```markdown
# Spec 005: User Authentication

## Summary
Implement user authentication with email/password and OAuth.

## Problem Statement
Users need secure way to access protected features.

## User Scenarios
**Scenario 1**: New user signs up with email
- User enters email and password
- System validates email format
- System creates account
- User receives confirmation email

## Requirements
- REQ-1: Support email/password authentication
- REQ-2: Support OAuth (Google, GitHub)
- REQ-3: JWT tokens with 24h expiration
- REQ-4: Secure password hashing (bcrypt)

## Success Criteria
- [ ] User can register with email
- [ ] User can login with email
- [ ] User can login with OAuth
- [ ] Sessions persist across app restarts
- [ ] Invalid credentials show error message
```

#### 3. Clarify (`/speckit.clarify`)

**Purpose**: Resolve specification ambiguities

**Updates**: Current `spec.md`

**Process:**
1. Analyzes spec for ambiguities
2. Asks clarifying questions
3. Updates spec with answers
4. Re-presents for approval

**Example questions:**
- "Should OAuth create local accounts automatically?"
- "What happens to existing sessions after password change?"
- "Do we support password reset via email?"

#### 4. Plan (`/speckit.plan`)

**Purpose**: Define technical implementation approach

**Creates**: `.specify/specs/NNN-feature-name/plan.md`

**Focus on:**
- Architecture and design
- Technology choices (with rationale)
- Data models and API contracts
- File structure and organization
- Test strategy
- Migration path (if breaking changes)

**Example sections:**

```markdown
# Plan 005: User Authentication

## Technical Approach

### Architecture
```
Client → Server → Authentication Module → Database
                       ↓
                  Token Manager
```

### Technology Choices

| Decision | Options | **Chosen** | Rationale |
|----------|---------|-----------|-----------|
| Auth approach | Session, Token-based | **Token-based** | Stateless, scalable |
| Storage | SQL, NoSQL, In-memory | **SQL** | ACID compliance needed |
| Hashing | bcrypt, argon2, scrypt | **argon2** | Modern, secure |

### Data Model

```
User:
  - id (unique identifier)
  - email (unique, indexed)
  - password_hash
  - oauth_providers (array)
  - created_at
  - last_login

OAuthProvider:
  - provider (google, github, etc.)
  - provider_id
  - email
```

### File Structure

Adapt to your project structure. Examples:

**For modular projects:**
```
your-project/
├── auth/
│   ├── auth_service
│   ├── token_service
│   ├── password_service
│   └── tests/
```

**For layered projects:**
```
your-project/
├── services/auth/
├── controllers/auth/
├── models/user
└── tests/auth/
```

### Test Strategy

- **Unit tests**: Individual components (target: 90% coverage)
- **Integration tests**: Complete authentication flow
- **Security tests**: Common vulnerabilities (injection, XSS, CSRF)
```

#### 5. Tasks (`/speckit.tasks`)

**Purpose**: Break plan into actionable steps

**Creates**: `.specify/specs/NNN-feature-name/tasks.md`

**Task characteristics:**
- ✅ Small and focused
- ✅ Independently completable
- ✅ Clear acceptance criteria
- ✅ Ordered logically
- ✅ Test-first oriented

**Example:**

```markdown
# Tasks 005: User Authentication

## Phase 1: Data Layer

- [ ] **Task 1.1**: Create User model
  - Define user data structure
  - Fields: id, email, password_hash, created_at
  - Add constraints (unique email, etc.)
  - Acceptance: Model validates correctly

- [ ] **Task 1.2**: Create database migration
  - Apply schema changes to database
  - Verify tables/collections created
  - Acceptance: Migration runs successfully

- [ ] **Task 1.3**: Create test data
  - Write data seeding script
  - Add sample users for testing
  - Acceptance: Test data queryable

## Phase 2: Core Authentication

- [ ] **Task 2.1**: Implement password hashing
  - Write tests for hash() and verify()
  - Implement secure password hashing
  - Handle edge cases (empty, too long, etc.)
  - Acceptance: 100% test coverage

- [ ] **Task 2.2**: Implement token management
  - Write tests for generate() and verify()
  - Implement token creation with expiration
  - Implement token validation
  - Acceptance: Tokens work correctly

- [ ] **Task 2.3**: Implement authentication logic
  - Write tests for register() and login()
  - Implement user registration
  - Implement user login
  - Acceptance: Users can register and login
```

#### 6. Implement (`/speckit.implement`)

**Purpose**: Execute the implementation

**Process:**

1. **Read context:**
   ```bash
   cat .specify/memory/constitution.md
   cat .specify/specs/NNN-feature/spec.md
   cat .specify/specs/NNN-feature/plan.md
   cat .specify/specs/NNN-feature/tasks.md
   ```

2. **For each task:**
   - Write test FIRST (TDD)
   - Implement to pass test
   - Refactor if needed
   - Run quality gates
   - Commit with spec reference
   - Mark task complete

3. **Test-Driven Development cycle:**
   ```
   RED → GREEN → REFACTOR

   RED: Write failing test
   GREEN: Write minimal code to pass
   REFACTOR: Improve code quality
   ```

4. **Commit format:**
   ```bash
   git commit -m "feat(auth): implement password hashing

   - Add PasswordService with bcrypt
   - Hash passwords on registration
   - Verify passwords on login
   - Add comprehensive tests (100% coverage)

   Implements: Task 2.1 from Spec 005"
   ```

---

## Official Commands

### Command Reference

| Command | Purpose | Creates | Requires |
|---------|---------|---------|----------|
| `/speckit.constitution` | Define principles | `constitution.md` | None |
| `/speckit.specify` | Create spec | `spec.md` | Constitution |
| `/speckit.clarify` | Resolve ambiguities | Updates `spec.md` | Draft spec |
| `/speckit.plan` | Technical approach | `plan.md` | Approved spec |
| `/speckit.tasks` | Action items | `tasks.md` | Approved plan |
| `/speckit.implement` | Execute | Code files | Tasks defined |
| `/speckit.analyze` | Validate plan | Analysis report | Plan created |
| `/speckit.checklist` | Quality check | Checklist results | Implementation |

### Command Details

#### `/speckit.constitution`

**Creates:** `.specify/memory/constitution.md`

**Usage:**
```
/speckit.constitution
```

**Prompts for:**
- Core development principles
- Technology standards
- Quality requirements
- Non-negotiable rules

**Output:** Constitutional document with numbered articles

---

#### `/speckit.specify`

**Creates:** `.specify/specs/NNN-feature-name/spec.md`

**Usage:**
```
/speckit.specify
```

**Auto-detects:**
- Feature number (next sequential)
- Feature name (from git branch or user input)

**Template sections:**
- Summary
- Problem Statement (What, Why, Who)
- User Scenarios
- Requirements (Functional + Non-Functional)
- Success Criteria
- Dependencies
- Risks & Mitigations

---

#### `/speckit.clarify`

**Updates:** Current `spec.md`

**Usage:**
```
/speckit.clarify
```

**Process:**
1. Analyzes spec for ambiguities
2. Identifies unclear sections
3. Asks clarifying questions
4. Updates spec with answers
5. Re-presents for approval

---

#### `/speckit.plan`

**Creates:** `.specify/specs/NNN-feature-name/plan.md`

**Usage:**
```
/speckit.plan
```

**Requires:** Approved spec.md

**Template sections:**
- Technical Approach
- Architecture Design
- Technology Choices (with rationale)
- Data Models & API Contracts
- File Structure
- Test Strategy
- Migration Plan (if needed)
- Performance Considerations
- Security Considerations

---

#### `/speckit.tasks`

**Creates:** `.specify/specs/NNN-feature-name/tasks.md`

**Usage:**
```
/speckit.tasks
```

**Requires:** Approved plan.md

**Format:**
```markdown
## Phase N: Phase Name

- [ ] Task N.M: Description (Est: XX min)
  - Specific action 1
  - Specific action 2
  - Acceptance criteria
```

---

#### `/speckit.implement`

**Action:** Begins code implementation

**Usage:**
```
/speckit.implement
```

**Process:**
1. Reads constitution, spec, plan, tasks
2. Implements following TDD
3. Runs quality gates after each task
4. Commits with spec references
5. Updates tasks.md progress

---

#### `/speckit.analyze`

**Action:** Validates implementation plan

**Usage:**
```
/speckit.analyze
```

**Checks:**
- Constitutional compliance
- Spec-plan alignment
- Technical feasibility
- Missing requirements
- Risks and mitigations

---

#### `/speckit.checklist`

**Action:** Quality gate verification

**Usage:**
```
/speckit.checklist
```

**Verifies:**
- All tests passing
- Type checking clean
- Linting clean
- Coverage > threshold
- Documentation complete
- Spec requirements met

---

## Constitutional Foundation

### Constitutional Template

**File:** `.specify/memory/constitution.md`

```markdown
# Project Constitution

**Project**: [Project Name]
**Version**: 1.0.0
**Created**: [Date]
**Last Modified**: [Date]

> This document defines the immutable principles governing this project.
> All specifications, plans, and implementations must comply with these articles.

---

## Article I: Specification-First Development

**Principle**: Every feature must have an approved specification before implementation.

**Rationale**: Specifications prevent scope creep and ensure alignment between stakeholders and implementation.

**Compliance**:
- ✅ All features have spec.md file in .specify/specs/
- ✅ Specs approved before planning begins
- ✅ No coding before spec approval
- ❌ Direct implementation without specification

**Verification**: Every git commit references spec number in message

---

## Article II: Test-First Development

**Principle**: Tests are written BEFORE implementation code.

**Rationale**: Tests define behavior, prevent regressions, enable confident refactoring.

**Compliance**:
- ✅ Test files created before implementation files
- ✅ Minimum 80% code coverage
- ✅ All edge cases and error scenarios tested
- ❌ Implementation without tests
- ❌ Tests added after the fact

**Verification**: Git commit history shows test commits before implementation

---

## Article III: Type Safety

**Principle**: All code is statically typed with strict mode enabled.

**Rationale**: Type errors caught at compile time, not runtime. Self-documenting code.

**Compliance**:
- ✅ TypeScript strict mode: `true` in tsconfig.json
- ✅ Zero `any` types without explicit justification in comments
- ✅ All public APIs fully typed with explicit return types
- ✅ Discriminated unions for state machines
- ❌ Dynamic typing in production code

**Verification**: `npm run type-check` shows 0 errors

---

## Article IV: Quality Gates

**Principle**: All quality gates must pass before merging to main branch.

**Rationale**: Prevents broken code in main branch, maintains professional standards.

**Quality Gates**:
1. **Type checking**: 0 errors (`npm run type-check`)
2. **Tests**: All passing (`npm test`)
3. **Coverage**: ≥ 80% (`npm test -- --coverage`)
4. **Linting**: 0 errors, 0 warnings (`npm run lint`)
5. **Formatting**: Correct (`npm run format`)
6. **No console statements**: None in staged files

**Verification**: `./.specify/scripts/check-quality.sh` passes

---

## Article V: Linear Workflow

**Principle**: Development follows strict sequence: Specify → Plan → Tasks → Implement

**Rationale**: Each phase builds on previous, ensuring completeness and alignment.

**Compliance**:
- ✅ Specification written and approved first
- ✅ Plan created only after spec approval
- ✅ Tasks created only after plan approval
- ✅ Implementation only after tasks defined
- ❌ Skipping workflow steps
- ❌ Coding before specification

**Verification**: Spec, plan, tasks files exist before implementation

---

## Article VI: Constitutional Authority

**Principle**: This constitution supersedes all other documentation.

**Rationale**: Ensures consistent decision-making across time and contributors.

**Compliance**:
- ✅ All design decisions reference constitutional principles
- ✅ Violations addressed immediately
- ✅ Amendments require explicit approval and documentation
- ❌ Silent violations
- ❌ Convenience over principles

**Verification**: Design decisions documented with principle references in notes.md

---

## Article VII: Platform Support

**Principle**: [Define your platform support here]

**Examples:**
- "Support iOS and Android ONLY (no web)"
- "Support all platforms (iOS, Android, Web)"
- "Web-first, mobile as progressive web app"

**Rationale**: [Why this platform choice?]

**Compliance**:
- ✅ [Platform-specific compliance]
- ❌ [Platform violations]

**Verification**: Platform limitations documented in specs

---

## Article VIII: Code Ownership and Review

**Principle**: [Define code review and ownership]

**Example:**
- "All code must be reviewed by at least one other developer"
- "Solo developer: AI assistant acts as reviewer"

**Rationale**: Multiple perspectives catch issues

**Compliance**:
- ✅ Pull requests reviewed before merge
- ✅ Review checklist includes constitutional compliance
- ❌ Direct commits to main branch

**Verification**: Git history shows PR approval before merge

---

## Article IX: Documentation Standards

**Principle**: Code is self-documenting through clear naming. Comments explain "why", not "what".

**Rationale**: Code is always current; comments become stale. Good names eliminate need for comments.

**Compliance**:
- ✅ Function/variable names explain purpose
- ✅ JSDoc on all public APIs
- ✅ Comments explain non-obvious decisions
- ❌ Comments that restate code
- ❌ Abbreviations or unclear names

**Verification**: Code review checks for self-explanatory code

---

## Amendment Process

To change constitutional principles:

1. **Propose Amendment**: Document proposed change in writing
2. **Justify**: Explain why current principle is insufficient
3. **Impact Analysis**: List all affected specifications and code
4. **Approval**: Obtain team/stakeholder sign-off
5. **Update**: Modify constitution with amendment notation below
6. **Communicate**: Notify all contributors

### Amendment Format

```markdown
## Amendment #[N] - [Date]

**Article Modified**: Article [N]

**Change**: [What changed]

**Reason**: [Why this was necessary]

**Impact**: [How this affects existing work]

**Approved By**: [Name/Role]

**Effective Date**: [Date]
```

---

## Version History

- **v1.0.0** ([Date]) - Initial constitution
- **v1.1.0** ([Date]) - Amendment #1: [Description]

---

**This constitution is the source of truth for all development decisions.**
```

### Customizing Your Constitution

**Add articles for:**
- Security standards (OWASP, encryption requirements)
- Performance requirements (load time, response time)
- Accessibility standards (WCAG compliance)
- Localization requirements (i18n support)
- Browser/device support matrix
- Third-party service constraints
- Compliance requirements (GDPR, HIPAA, SOC2)

**Keep it:**
- ✅ Specific and measurable
- ✅ Verifiable through automation
- ✅ Principle-based, not tool-based
- ❌ Vague or subjective
- ❌ Too granular (belongs in coding standards)

---

## Directory Structure

### Official Layout

```
your-project/
├── .specify/                          # Spec Kit root (official)
│   ├── memory/
│   │   └── constitution.md            # Project principles
│   ├── specs/                         # Feature specifications
│   │   ├── 001-project-setup/
│   │   │   ├── spec.md               # WHAT to build
│   │   │   ├── plan.md               # HOW to build
│   │   │   ├── tasks.md              # STEPS to implement
│   │   │   └── notes.md              # Decisions & discussions
│   │   ├── 002-authentication/
│   │   │   ├── spec.md
│   │   │   ├── plan.md
│   │   │   ├── tasks.md
│   │   │   └── notes.md
│   │   └── NNN-feature-name/
│   │       └── [same structure]
│   ├── scripts/                       # Automation helpers
│   │   ├── context.sh                # Official context script (POSIX)
│   │   ├── context.ps1               # Official context script (PowerShell)
│   │   ├── create-spec.sh            # Helper: Create new spec
│   │   ├── validate-spec.sh          # Helper: Validate spec
│   │   ├── check-quality.sh          # Helper: Quality gates
│   │   └── list-specs.sh             # Helper: List all specs
│   └── templates/                     # Reference templates
│       ├── spec-template.md
│       ├── plan-template.md
│       └── tasks-template.md
├── .claude/                           # Claude Code integration
│   └── commands/                      # Slash commands
│       ├── speckit-constitution.md
│       ├── speckit-specify.md
│       ├── speckit-plan.md
│       └── ...
├── src/                               # Your application code
└── [your project files]
```

### Feature Numbering Convention

**Format:** `NNN-descriptive-name/`

**Rules:**
- ✅ Zero-padded 3-digit numbers (001, 002, ..., 099, 100)
- ✅ Sequential (no gaps)
- ✅ Lowercase with hyphens
- ✅ Descriptive but concise names
- ❌ Never reuse numbers
- ❌ No special characters except hyphens

**Examples:**
```
001-project-setup/
002-user-authentication/
003-payment-integration/
004-notification-system/
...
042-feature-name/
```

---

## Helper Scripts

### Overview

Four automation scripts to streamline Spec Kit workflow:

1. **create-spec.sh** - Auto-create new specifications
2. **validate-spec.sh** - Validate spec completeness
3. **check-quality.sh** - Run all quality gates
4. **list-specs.sh** - List specifications with status

### create-spec.sh

**Purpose**: Automatically create new specification with proper numbering

**Location:** `.specify/scripts/create-spec.sh`

**Usage:**

```bash
# Interactive mode
./.specify/scripts/create-spec.sh

# With feature name
./.specify/scripts/create-spec.sh user-authentication

# Multi-word name
./.specify/scripts/create-spec.sh "User Authentication System"
```

**Code:**

```bash
#!/bin/bash
# Spec Kit Helper: Create New Specification

set -e

SPECS_DIR=".specify/specs"
TEMPLATES_DIR=".specify/templates"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if .specify exists
if [ ! -d "$SPECS_DIR" ]; then
    echo "❌ Error: .specify/specs/ not found"
    echo "Run Spec Kit installation first"
    exit 1
fi

# Find next spec number
if [ -z "$(ls -A $SPECS_DIR)" ]; then
    NEXT_NUM="001"
else
    LAST_NUM=$(ls -1 "$SPECS_DIR" | grep -E '^[0-9]{3}-' | sort -r | head -1 | cut -d'-' -f1)
    NEXT_NUM=$(printf "%03d" $((10#$LAST_NUM + 1)))
fi

# Get feature name
if [ -n "$1" ]; then
    FEATURE_NAME="$1"
else
    echo -e "${BLUE}Creating Spec $NEXT_NUM${NC}"
    read -p "Feature name (lowercase-with-hyphens): " FEATURE_NAME
fi

# Validate
if [ -z "$FEATURE_NAME" ]; then
    echo "❌ Error: Feature name required"
    exit 1
fi

# Convert to lowercase and replace spaces
FEATURE_NAME=$(echo "$FEATURE_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

# Create directory
SPEC_DIR="$SPECS_DIR/$NEXT_NUM-$FEATURE_NAME"
mkdir -p "$SPEC_DIR"

# Copy templates or create minimal
if [ -f "$TEMPLATES_DIR/spec-template.md" ]; then
    cp "$TEMPLATES_DIR/spec-template.md" "$SPEC_DIR/spec.md"
    cp "$TEMPLATES_DIR/plan-template.md" "$SPEC_DIR/plan.md"
    cp "$TEMPLATES_DIR/tasks-template.md" "$SPEC_DIR/tasks.md"

    # Replace placeholders
    sed -i.bak "s/NNN/$NEXT_NUM/g" "$SPEC_DIR"/*.md && rm "$SPEC_DIR"/*.md.bak

    FEATURE_TITLE=$(echo "$FEATURE_NAME" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')
    sed -i.bak "s/Feature Name/$FEATURE_TITLE/g" "$SPEC_DIR"/*.md && rm "$SPEC_DIR"/*.md.bak
else
    # Create minimal templates
    cat > "$SPEC_DIR/spec.md" << EOF
# Spec $NEXT_NUM: $FEATURE_NAME

**Status**: DRAFT
**Created**: $(date +%Y-%m-%d)

## Summary
[One-paragraph summary]

## Requirements
- REQ-1: [Requirement]

## Success Criteria
- [ ] Criteria 1
EOF

    cat > "$SPEC_DIR/plan.md" << EOF
# Plan $NEXT_NUM: $FEATURE_NAME

**Status**: DRAFT
**Created**: $(date +%Y-%m-%d)

## Technical Approach
[Describe approach]
EOF

    cat > "$SPEC_DIR/tasks.md" << EOF
# Tasks $NEXT_NUM: $FEATURE_NAME

**Status**: NOT STARTED

## Phase 1
- [ ] Task 1.1: [Description] (15 min)
EOF
fi

# Create notes.md
cat > "$SPEC_DIR/notes.md" << EOF
# Notes: Spec $NEXT_NUM

## Decisions
[Document implementation decisions here]

## Changes
- $(date +%Y-%m-%d): Spec created
EOF

# Create git branch
BRANCH_NAME="$NEXT_NUM-$FEATURE_NAME"
if git rev-parse --git-dir > /dev/null 2>&1; then
    git checkout -b "$BRANCH_NAME" 2>/dev/null || echo -e "${YELLOW}Branch exists${NC}"
fi

# Success
echo ""
echo -e "${GREEN}✅ Spec $NEXT_NUM created!${NC}"
echo -e "${BLUE}Directory:${NC} $SPEC_DIR"
echo -e "${BLUE}Branch:${NC} $BRANCH_NAME"
echo ""
echo "Next steps:"
echo "1. Edit $SPEC_DIR/spec.md"
echo "2. Run: /speckit.specify (in Claude)"
echo "3. Get approval"
```

**Make executable:**

```bash
chmod +x .specify/scripts/create-spec.sh
```

---

### validate-spec.sh

**Purpose**: Validate specification completeness

**Location:** `.specify/scripts/validate-spec.sh`

**Usage:**

```bash
# Validate specific spec
./.specify/scripts/validate-spec.sh .specify/specs/005-auth/spec.md

# Validate all specs
for spec in .specify/specs/*/spec.md; do
    ./.specify/scripts/validate-spec.sh "$spec"
done
```

**Code:**

```bash
#!/bin/bash
# Spec Kit Helper: Validate Specification

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Get spec file
if [ -n "$1" ]; then
    SPEC_FILE="$1"
else
    SPEC_FILE=$(find .specify/specs -name "spec.md" -type f | sort -r | head -1)
fi

if [ ! -f "$SPEC_FILE" ]; then
    echo -e "${RED}❌ Spec file not found: $SPEC_FILE${NC}"
    exit 1
fi

echo -e "${BLUE}Validating Specification${NC}"
echo "File: $SPEC_FILE"
echo ""

ERRORS=0
WARNINGS=0

# Required sections
declare -a REQUIRED_SECTIONS=(
    "# Spec"
    "## Summary"
    "## Problem Statement"
    "## Requirements"
    "## Success Criteria"
)

echo -e "${BLUE}Checking required sections...${NC}"
for SECTION in "${REQUIRED_SECTIONS[@]}"; do
    if grep -q "^$SECTION" "$SPEC_FILE"; then
        echo -e "${GREEN}✅${NC} $SECTION"
    else
        echo -e "${RED}❌${NC} Missing: $SECTION"
        ERRORS=$((ERRORS + 1))
    fi
done

echo ""
echo -e "${BLUE}Checking for issues...${NC}"

# Placeholders
if grep -qE '\[.*\]|\(TODO\)|TBD|FIXME' "$SPEC_FILE"; then
    echo -e "${YELLOW}⚠️${NC}  Placeholders or TODO markers found"
    WARNINGS=$((WARNINGS + 1))
else
    echo -e "${GREEN}✅${NC} No placeholders"
fi

# Status
if grep -q "Status.*APPROVED" "$SPEC_FILE"; then
    echo -e "${GREEN}✅${NC} Status: APPROVED"
elif grep -q "Status.*DRAFT" "$SPEC_FILE"; then
    echo -e "${YELLOW}⚠️${NC}  Status: DRAFT (needs approval)"
    WARNINGS=$((WARNINGS + 1))
else
    echo -e "${RED}❌${NC} No status field"
    ERRORS=$((ERRORS + 1))
fi

# Requirements
REQ_COUNT=$(grep -c "^- REQ-" "$SPEC_FILE" || echo "0")
if [ "$REQ_COUNT" -eq 0 ]; then
    echo -e "${RED}❌${NC} No requirements (REQ-1, REQ-2, etc.)"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✅${NC} Found $REQ_COUNT requirements"
fi

# Success criteria
CRITERIA_COUNT=$(grep -c "^- \[ \]" "$SPEC_FILE" || echo "0")
if [ "$CRITERIA_COUNT" -eq 0 ]; then
    echo -e "${RED}❌${NC} No success criteria (checkboxes)"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✅${NC} Found $CRITERIA_COUNT success criteria"
fi

# Summary
echo ""
echo "================================"
if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✅ SPECIFICATION IS VALID${NC}"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠️  $WARNINGS WARNING(S)${NC}"
    exit 0
else
    echo -e "${RED}❌ $ERRORS ERROR(S), $WARNINGS WARNING(S)${NC}"
    exit 1
fi
```

**Make executable:**

```bash
chmod +x .specify/scripts/validate-spec.sh
```

---

### check-quality.sh

**Purpose**: Run all quality gates before committing

**Location:** `.specify/scripts/check-quality.sh`

**Usage:**

```bash
# Run before committing
./.specify/scripts/check-quality.sh

# Add to pre-commit hook
echo './.specify/scripts/check-quality.sh' >> .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

**Code:**

```bash
#!/bin/bash
# Spec Kit Helper: Quality Gate Checker

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════╗${NC}"
echo -e "${BLUE}║   SPEC KIT QUALITY GATES      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════╝${NC}"
echo ""

FAILURES=0
TOTAL_CHECKS=6

# Check 1: Type Checking
echo -e "${BLUE}[1/$TOTAL_CHECKS] Type Checking...${NC}"
if command -v npm &> /dev/null && [ -f "package.json" ]; then
    if npm run type-check --silent 2>&1 | grep -qi "error"; then
        echo -e "${RED}❌ Type errors found${NC}"
        FAILURES=$((FAILURES + 1))
    else
        echo -e "${GREEN}✅ Type checking passed${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Skipped (no npm/package.json)${NC}"
fi
echo ""

# Check 2: Tests
echo -e "${BLUE}[2/$TOTAL_CHECKS] Running Tests...${NC}"
if command -v npm &> /dev/null && [ -f "package.json" ]; then
    if npm test -- --passWithNoTests --silent 2>&1; then
        echo -e "${GREEN}✅ Tests passed${NC}"
    else
        echo -e "${RED}❌ Tests failed${NC}"
        FAILURES=$((FAILURES + 1))
    fi
else
    echo -e "${YELLOW}⚠️  Skipped${NC}"
fi
echo ""

# Check 3: Coverage
echo -e "${BLUE}[3/$TOTAL_CHECKS] Coverage...${NC}"
if command -v npm &> /dev/null && [ -f "package.json" ]; then
    COVERAGE_OUTPUT=$(npm test -- --coverage --silent --passWithNoTests 2>&1 || true)
    LINE_COV=$(echo "$COVERAGE_OUTPUT" | grep -oE "[0-9]+\.[0-9]+" | head -1)

    if [ -n "$LINE_COV" ]; then
        if (( $(echo "$LINE_COV >= 80" | bc -l) )); then
            echo -e "${GREEN}✅ Coverage: ${LINE_COV}%${NC}"
        else
            echo -e "${RED}❌ Coverage: ${LINE_COV}% (< 80%)${NC}"
            FAILURES=$((FAILURES + 1))
        fi
    else
        echo -e "${YELLOW}⚠️  Could not determine${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Skipped${NC}"
fi
echo ""

# Check 4: Linting
echo -e "${BLUE}[4/$TOTAL_CHECKS] Linting...${NC}"
if command -v npm &> /dev/null && [ -f "package.json" ]; then
    if npm run lint --silent 2>&1; then
        echo -e "${GREEN}✅ Linting passed${NC}"
    else
        echo -e "${RED}❌ Linting failed${NC}"
        FAILURES=$((FAILURES + 1))
    fi
else
    echo -e "${YELLOW}⚠️  Skipped${NC}"
fi
echo ""

# Check 5: Formatting
echo -e "${BLUE}[5/$TOTAL_CHECKS] Formatting...${NC}"
if command -v npm &> /dev/null && [ -f "package.json" ]; then
    if npm run format -- --check --silent 2>&1; then
        echo -e "${GREEN}✅ Formatting correct${NC}"
    else
        echo -e "${YELLOW}⚠️  Run 'npm run format'${NC}"
        FAILURES=$((FAILURES + 1))
    fi
else
    echo -e "${YELLOW}⚠️  Skipped${NC}"
fi
echo ""

# Check 6: Console Statements
echo -e "${BLUE}[6/$TOTAL_CHECKS] Console Statements...${NC}"
if git rev-parse --git-dir > /dev/null 2>&1; then
    CONSOLE_FILES=$(git diff --cached --name-only --diff-filter=ACM | \
                    grep -E '\.(js|ts|jsx|tsx)$' | \
                    xargs grep -l "console\\.\\(log\\|debug\\)" 2>/dev/null || true)

    if [ -n "$CONSOLE_FILES" ]; then
        echo -e "${RED}❌ Console statements found${NC}"
        FAILURES=$((FAILURES + 1))
    else
        echo -e "${GREEN}✅ No console statements${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Skipped (not git repo)${NC}"
fi
echo ""

# Summary
echo -e "${BLUE}╔════════════════════════════════╗${NC}"
echo -e "${BLUE}║         SUMMARY                ║${NC}"
echo -e "${BLUE}╚════════════════════════════════╝${NC}"
echo ""

if [ $FAILURES -eq 0 ]; then
    echo -e "${GREEN}✅ ALL QUALITY GATES PASSED${NC}"
    exit 0
else
    echo -e "${RED}❌ $FAILURES GATE(S) FAILED${NC}"
    exit 1
fi
```

**Make executable:**

```bash
chmod +x .specify/scripts/check-quality.sh
```

---

### list-specs.sh

**Purpose**: List all specifications with status

**Location:** `.specify/scripts/list-specs.sh`

**Usage:**

```bash
# Simple list
./.specify/scripts/list-specs.sh

# Detailed view
./.specify/scripts/list-specs.sh --detailed
```

**Code:**

```bash
#!/bin/bash
# Spec Kit Helper: List All Specifications

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GRAY='\033[0;90m'
NC='\033[0m'

SPECS_DIR=".specify/specs"
DETAILED=false

if [ "$1" == "--detailed" ] || [ "$1" == "-d" ]; then
    DETAILED=true
fi

if [ ! -d "$SPECS_DIR" ]; then
    echo "❌ Error: .specify/specs/ not found"
    exit 1
fi

SPEC_COUNT=$(find "$SPECS_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║    SPEC KIT SPECIFICATIONS            ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GRAY}Total: $SPEC_COUNT${NC}"
echo ""

if [ "$SPEC_COUNT" -eq 0 ]; then
    echo "No specifications found."
    echo "Create: ./.specify/scripts/create-spec.sh"
    exit 0
fi

CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "")

for SPEC_DIR in $(find "$SPECS_DIR" -mindepth 1 -maxdepth 1 -type d | sort); do
    SPEC_NUM=$(basename "$SPEC_DIR" | cut -d'-' -f1)
    FEATURE_NAME=$(basename "$SPEC_DIR" | cut -d'-' -f2-)

    if [ ! -f "$SPEC_DIR/spec.md" ]; then
        continue
    fi

    STATUS=$(grep -m1 "Status:" "$SPEC_DIR/spec.md" | sed 's/.*Status:[[:space:]]*//' | tr -d '*' || echo "UNKNOWN")
    TITLE=$(grep -m1 "^# Spec" "$SPEC_DIR/spec.md" | sed 's/^# Spec [0-9]*: //' || echo "$FEATURE_NAME")

    IS_CURRENT=""
    if [[ "$CURRENT_BRANCH" == "$SPEC_NUM-"* ]]; then
        IS_CURRENT=" ${GREEN}← CURRENT${NC}"
    fi

    case "$STATUS" in
        *DRAFT*) STATUS_COLOR="${YELLOW}" ;;
        *APPROVED*|*READY*) STATUS_COLOR="${BLUE}" ;;
        *IMPLEMENTED*|*COMPLETE*) STATUS_COLOR="${GREEN}" ;;
        *) STATUS_COLOR="${GRAY}" ;;
    esac

    echo -e "${BLUE}Spec $SPEC_NUM${NC}: $TITLE"
    echo -e "  ${STATUS_COLOR}Status:${NC} $STATUS$IS_CURRENT"

    if [ "$DETAILED" = true ]; then
        if [ -f "$SPEC_DIR/plan.md" ]; then
            PLAN_STATUS=$(grep -m1 "Status:" "$SPEC_DIR/plan.md" | sed 's/.*Status:[[:space:]]*//' | tr -d '*' || echo "N/A")
            echo -e "  ${GRAY}Plan:${NC} $PLAN_STATUS"
        fi

        if [ -f "$SPEC_DIR/tasks.md" ]; then
            TOTAL=$(grep -c "^- \[ \]" "$SPEC_DIR/tasks.md" || echo "0")
            DONE=$(grep -c "^- \[x\]" "$SPEC_DIR/tasks.md" || echo "0")
            echo -e "  ${GRAY}Tasks:${NC} $DONE/$TOTAL complete"
        fi

        CREATED=$(grep -m1 "Created:" "$SPEC_DIR/spec.md" | sed 's/.*Created:[[:space:]]*//' || echo "Unknown")
        echo -e "  ${GRAY}Created:${NC} $CREATED"
    fi

    echo ""
done

echo -e "${BLUE}═══════════════════════════════════════${NC}"
echo ""

DRAFT=$(find "$SPECS_DIR" -name "spec.md" -exec grep -l "Status.*DRAFT" {} \; | wc -l | tr -d ' ')
APPROVED=$(find "$SPECS_DIR" -name "spec.md" -exec grep -l "Status.*APPROVED" {} \; | wc -l | tr -d ' ')
DONE=$(find "$SPECS_DIR" -name "spec.md" -exec grep -l "Status.*IMPLEMENTED\|Status.*COMPLETE" {} \; | wc -l | tr -d ' ')

echo -e "${YELLOW}Draft: $DRAFT${NC}  ${BLUE}Approved: $APPROVED${NC}  ${GREEN}Implemented: $DONE${NC}"
echo ""
```

**Make executable:**

```bash
chmod +x .specify/scripts/list-specs.sh
```

---

## Quality Gates

### Mandatory Before Every Commit

**Run all gates:**

```bash
./.specify/scripts/check-quality.sh
```

**Or manually (adapt to your stack):**

```bash
# 1. Type checking (if applicable)
# JavaScript/TypeScript: npm run type-check
# Python: mypy .
# Go: go vet ./...
# Rust: cargo check
# → Must show: 0 errors

# 2. Tests
# JavaScript: npm test
# Python: pytest
# Go: go test ./...
# Rust: cargo test
# → Must show: All passing

# 3. Coverage
# JavaScript: npm test -- --coverage
# Python: pytest --cov
# Go: go test -cover ./...
# Rust: cargo tarpaulin
# → Must show: ≥ 80% (or constitutional threshold)

# 4. Linting
# JavaScript: npm run lint
# Python: pylint . or ruff check
# Go: golangci-lint run
# Rust: cargo clippy
# → Must show: 0 errors, 0 warnings

# 5. Formatting
# JavaScript: npm run format (prettier)
# Python: black . or ruff format
# Go: gofmt -w .
# Rust: cargo fmt
# → Auto-formats code

# 6. Debug statements
# grep -r "console.log" src/  # JavaScript
# grep -r "print(" .          # Python
# grep -r "fmt.Println" .     # Go
# grep -r "println!" .        # Rust
# → Must show: No matches
```

### Gate Details

#### 1. Type Checking (if applicable)

**Purpose**: Catch type errors at compile time

**Commands (by language):**
- **TypeScript**: `npm run type-check` or `tsc --noEmit`
- **Python**: `mypy .` or `pyright`
- **Go**: `go vet ./...`
- **Rust**: `cargo check`
- **Java**: Part of compilation (`javac`)

**Requirement:** 0 errors

---

#### 2. Tests

**Purpose**: Verify functionality, prevent regressions

**Commands (by language):**
- **JavaScript/TypeScript**: `npm test` (Jest, Vitest, etc.)
- **Python**: `pytest` or `python -m unittest`
- **Go**: `go test ./...`
- **Rust**: `cargo test`
- **Java**: `mvn test` or `gradle test`
- **Ruby**: `rspec` or `rake test`

**Requirement:** All tests passing

---

#### 3. Coverage

**Purpose**: Ensure adequate test coverage

**Commands (by language):**
- **JavaScript**: `npm test -- --coverage`
- **Python**: `pytest --cov` or `coverage run`
- **Go**: `go test -cover ./...`
- **Rust**: `cargo tarpaulin`
- **Java**: `mvn jacoco:report`

**Requirement:** ≥ 80% (or constitutional threshold)

**View report:**
```bash
# JavaScript
open coverage/lcov-report/index.html

# Python
coverage html && open htmlcov/index.html

# Go
go tool cover -html=coverage.out
```

---

#### 4. Linting

**Purpose**: Enforce code quality standards

**Commands (by language/framework):**
- **JavaScript/TypeScript**: `npm run lint` (ESLint)
- **Python**: `pylint .` or `ruff check`
- **Go**: `golangci-lint run`
- **Rust**: `cargo clippy`
- **Java**: `mvn checkstyle:check`
- **PHP/Laravel**: `./vendor/bin/phpstan` or `./vendor/bin/psalm`
- **Ruby**: `rubocop`
- **Dart/Flutter**: `dart analyze` or `flutter analyze`

**Requirement:** 0 errors, 0 warnings

---

#### 5. Formatting

**Purpose**: Consistent code style

**Commands (by language/framework):**
- **JavaScript/TypeScript**: `npm run format` (Prettier)
- **Python**: `black .` or `ruff format`
- **Go**: `gofmt -w .` or `goimports -w .`
- **Rust**: `cargo fmt`
- **Java**: `mvn spotless:apply`
- **PHP/Laravel**: `./vendor/bin/pint` (Laravel Pint)
- **Ruby**: `rubocop -a`
- **Dart/Flutter**: `dart format .`

**Requirement:** All code formatted

---

#### 6. Debug Statements

**Purpose**: No debug statements in production

**Check (by language):**

```bash
# JavaScript/TypeScript
grep -r "console.log\|console.debug" src/

# Python
grep -r "print(" . --include="*.py"

# Go
grep -r "fmt.Println" . --include="*.go"

# Rust
grep -r "println!" . --include="*.rs"

# PHP
grep -r "var_dump\|print_r\|dd(" . --include="*.php"

# Dart/Flutter
grep -r "print(" . --include="*.dart"
```

**Requirement:** None found

**Use instead:** Proper logging

```
# Use language-appropriate logging:
# JavaScript: Winston, Pino, or custom Logger
# Python: logging module
# Go: log package or zap
# Rust: log crate
# PHP: Monolog or Laravel Log
# Dart: logger package
```

---

## Workflow Patterns

### Pattern 1: New Feature (Complete Flow)

```bash
# 1. Create specification
./.specify/scripts/create-spec.sh user-profile

# Or in Claude:
# "Create spec for user profile management"

# 2. Edit spec.md with requirements
vim .specify/specs/006-user-profile/spec.md

# 3. Validate spec
./.specify/scripts/validate-spec.sh .specify/specs/006-user-profile/spec.md

# 4. Present to stakeholder (tell Claude):
# "Review this spec"

# 5. Get approval (user says):
# "Looks good, approve it"

# 6. Create plan (Claude runs):
# /speckit.plan

# 7. Review plan, get approval

# 8. Create tasks (Claude runs):
# /speckit.tasks

# 9. Review tasks, approve

# 10. Implement (Claude runs):
# /speckit.implement

# Claude follows TDD:
# - Writes test first
# - Implements to pass test
# - Refactors
# - Commits with spec reference
# - Moves to next task

# 11. After each task, check quality
./.specify/scripts/check-quality.sh

# 12. Commit
git add .
git commit -m "feat(profile): implement user profile (Spec 006)"

# 13. Push and create PR
git push origin 006-user-profile

# 14. After merge, mark spec implemented
sed -i 's/Status: APPROVED/Status: IMPLEMENTED/' \
  .specify/specs/006-user-profile/spec.md
```

---

### Pattern 2: Quick Bug Fix

**Even small fixes follow spec process:**

```bash
# 1. Create minimal spec
./.specify/scripts/create-spec.sh login-timeout-fix

# 2. Fill spec.md (minimal version)
cat > .specify/specs/007-login-timeout-fix/spec.md << 'EOF'
# Spec 007: Login Timeout Fix

**Status**: DRAFT

## Summary
Fix login timeout occurring after 30 seconds

## Problem
Users experiencing timeout errors when logging in.
Current 30s timeout too short for slow connections.

## Requirements
- REQ-1: Increase login timeout to 60 seconds
- REQ-2: Add retry logic (3 attempts)
- REQ-3: Show user-friendly error message

## Success Criteria
- [ ] Timeout increased to 60s
- [ ] 3 retry attempts implemented
- [ ] User sees "Slow connection" message
- [ ] No timeout errors in logs

## Test Plan
- Test on 3G connection
- Test with intentional delays
EOF

# 3. Get approval
# "Approve spec 007"

# 4. Implement immediately (small fix doesn't need separate plan)
# Edit code, add tests, commit

# 5. Quality check
./.specify/scripts/check-quality.sh

# 6. Commit
git commit -m "fix(auth): increase login timeout to 60s (Spec 007)"
```

---

### Pattern 3: Exploring Multiple Approaches

```bash
# 1. Create spec
# "Create spec for state management"

# 2. Create 3 different plans
cp .specify/specs/008-state-mgmt/plan.md \
   .specify/specs/008-state-mgmt/plan-redux.md

cp .specify/specs/008-state-mgmt/plan.md \
   .specify/specs/008-state-mgmt/plan-zustand.md

cp .specify/specs/008-state-mgmt/plan.md \
   .specify/specs/008-state-mgmt/plan-mobx.md

# 3. Fill each with different approach

# 4. Evaluate trade-offs
cat > .specify/specs/008-state-mgmt/evaluation.md << 'EOF'
# State Management Evaluation

## Redux
**Pros**: Industry standard, DevTools, middleware
**Cons**: Verbose, boilerplate-heavy
**Bundle**: 8KB

## Zustand
**Pros**: Simple API, TypeScript-first, tiny
**Cons**: Less ecosystem support
**Bundle**: 2KB

## MobX
**Pros**: Reactive, less boilerplate
**Cons**: Magic, harder to debug
**Bundle**: 16KB

## Decision: Zustand
- Smallest bundle (2KB vs 8KB/16KB)
- TypeScript-first (our requirement)
- Simple API (team preference)
- Sufficient for our needs
EOF

# 5. Proceed with chosen approach
mv .specify/specs/008-state-mgmt/plan-zustand.md \
   .specify/specs/008-state-mgmt/plan.md

# 6. Continue with tasks and implementation
```

---

## Git Integration

### Git Hooks

#### Pre-Commit Hook

**File:** `.git/hooks/pre-commit`

```bash
#!/bin/bash
# Run quality gates before every commit

./.specify/scripts/check-quality.sh

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Commit aborted due to quality gate failures"
    echo "Fix issues and try again"
    exit 1
fi
```

**Install:**

```bash
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
./.specify/scripts/check-quality.sh
EOF

chmod +x .git/hooks/pre-commit
```

---

#### Commit-Msg Hook

**File:** `.git/hooks/commit-msg`

```bash
#!/bin/bash
# Ensure commit messages reference spec numbers

COMMIT_MSG=$(cat "$1")

if ! echo "$COMMIT_MSG" | grep -qiE "(spec|implements) [0-9]{3}"; then
    echo "❌ Error: Commit must reference spec number"
    echo ""
    echo "Examples:"
    echo "  feat(auth): add login (Spec 005)"
    echo "  fix(api): timeout error (Implements Spec 003)"
    exit 1
fi
```

**Install:**

```bash
cat > .git/hooks/commit-msg << 'EOF'
#!/bin/bash
COMMIT_MSG=$(cat "$1")
if ! echo "$COMMIT_MSG" | grep -qiE "(spec|implements) [0-9]{3}"; then
    echo "❌ Commit must reference spec number"
    exit 1
fi
EOF

chmod +x .git/hooks/commit-msg
```

---

### Commit Message Format

**Convention:** Conventional Commits

```
type(scope): subject

body

footer
```

**Types:**
- `feat`: New feature (references spec)
- `fix`: Bug fix (references spec)
- `docs`: Documentation only
- `test`: Adding/updating tests
- `refactor`: Code refactoring (no behavior change)
- `chore`: Build/tooling changes

**Examples:**

```bash
# Feature commit
git commit -m "feat(auth): implement JWT token generation

- Create TokenService class
- Add expiration handling
- Add refresh token support
- Write comprehensive tests (95% coverage)

Implements: Task 2.3 from Spec 005"

# Bug fix commit
git commit -m "fix(api): handle network timeout errors

- Increase timeout to 60s
- Add retry logic (3 attempts)
- Show user-friendly error

Fixes: Spec 007"

# Refactoring
git commit -m "refactor(auth): extract password validation

- Move validation to separate function
- Add more test cases
- No behavior changes

Related: Spec 005"
```

---

### Branch Strategy

**Feature branches match spec numbers:**

```bash
# Create branch for spec 005
git checkout -b 005-user-authentication

# Work on feature
# ...commits...

# Push
git push origin 005-user-authentication

# After merge, tag
git tag v0.5.0 -m "Spec 005: User Authentication complete"
git push --tags
```

---

### Pull Request Template

**File:** `.github/pull_request_template.md`

```markdown
## Specification

- **Spec**: [NNN](link-to-spec.md)
- **Status**: ☐ DRAFT | ☐ READY | ☐ APPROVED

## Summary

Brief description of changes.

## Implementation

- Task X.Y: [Description]
- Task X.Z: [Description]

## Constitutional Compliance

- [ ] Article I: Specification-first ✅
- [ ] Article II: Test-first development ✅
- [ ] Article III: Type safety ✅
- [ ] Article IV: Quality gates pass ✅

## Quality Checklist

- [ ] All tests passing
- [ ] Coverage ≥ 80%
- [ ] Type check: 0 errors
- [ ] Lint: 0 errors, 0 warnings
- [ ] Code formatted
- [ ] No console statements
- [ ] Documentation updated

## Verification

```bash
npm run type-check  # ✅ 0 errors
npm test           # ✅ All passing
npm run lint       # ✅ 0 errors
./.specify/scripts/check-quality.sh  # ✅ Passed
```

## Spec Alignment

- [ ] All requirements implemented (REQ-1, REQ-2, etc.)
- [ ] All success criteria met
- [ ] No deviations from approved plan

## Notes

[Implementation decisions, trade-offs, discussions]
```

---

## Troubleshooting

### Installation Issues

**Problem:** `uvx: command not found`

**Solution:**

```bash
# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Or with homebrew (macOS)
brew install uv

# Verify
uv --version
```

---

**Problem:** Python version too old

**Solution:**

```bash
# Check version
python3 --version  # Must be 3.11+

# macOS
brew install python@3.11

# Ubuntu
sudo apt install python3.11

# Windows: Download from python.org
```

---

**Problem:** Slash commands don't appear

**Solution:**

```bash
# 1. Check if commands directory exists
ls .claude/commands/

# 2. Should see speckit-*.md files
# If missing, reinstall:
uvx --from git+https://github.com/github/spec-kit.git specify init . --ai claude

# 3. Restart Claude Code
```

---

### Workflow Issues

**Problem:** Spec and implementation diverge

**Solution:**

1. **If spec is correct:** Update code to match
2. **If code is correct:** Update spec and get re-approval
3. **If requirements changed:** Create spec amendment

**Never silently ignore divergence.**

---

**Problem:** Constitutional violation

**Solution:**

```bash
# 1. STOP immediately
# 2. Review constitution
cat .specify/memory/constitution.md

# 3. Options:
#    - Find compliant approach
#    - Propose constitutional amendment
#    - Skip feature

# 4. Get user approval before proceeding
```

---

**Problem:** Quality gates failing

**Solution:**

```bash
# Type errors
npm run type-check
# Fix errors one by one

# Test failures
npm test -- --verbose
# Read failure messages, fix tests

# Linting
npm run lint -- --fix
# Auto-fix, then manual fixes

# Coverage
npm test -- --coverage
open coverage/lcov-report/index.html
# Add tests for uncovered lines
```

---

### Common Errors

**Error:** "Cannot find module '.specify'"

**Solution:** Run installation

```bash
uvx --from git+https://github.com/github/spec-kit.git specify init . --ai claude
```

---

**Error:** "No constitution found"

**Solution:** Create constitution

```bash
# Use command
/speckit.constitution

# Or manually
mkdir -p .specify/memory
# Copy template from this guide
```

---

**Error:** "Spec number already exists"

**Solution:** Use next sequential number

```bash
# Find last number
ls .specify/specs/ | sort -r | head -1
# Use next (e.g., 005 → 006)
```

---

## Best Practices

### 1. Constitution First

**ALWAYS** begin new project by establishing constitution.

```bash
# Day 1: Constitution
# Write .specify/memory/constitution.md
# Get team agreement

# Day 2+: Specs and implementation
```

---

### 2. One Feature = One Spec

Don't combine multiple features.

- ✅ GOOD: "Spec 001: User Authentication"
- ❌ BAD: "Spec 001: Auth, Profiles, Notifications"

---

### 3. Numbered Sequentially

Numbers must be sequential, never reused.

```
✅ CORRECT:
001-feature-one/
002-feature-two/
003-feature-three/

❌ WRONG:
001-feature/
005-feature/    ← Gap
003-feature/    ← Out of order
```

---

### 4. Use Templates Always

Always copy from templates, never from scratch.

```bash
# ✅ CORRECT
cp .specify/templates/spec-template.md \
   .specify/specs/003-feature/spec.md

# ❌ WRONG
vim .specify/specs/003-feature/spec.md  # From scratch
```

---

### 5. Approval Before Planning

Never create plan until spec approved.

```
SPEC (DRAFT) → Review → Approval
   ↓ (approved)
PLAN
```

---

### 6. Linear Workflow Non-Negotiable

Don't skip steps.

- ✅ CORRECT: Spec → Plan → Tasks → Code
- ❌ WRONG: Code → Spec (post-hoc docs)

---

### 7. Document Decisions

Use `notes.md` for decisions made during work.

```markdown
# Notes

## Decision 1: Chose Axios over Fetch

**Date**: 2026-02-03
**Reason**: Better error handling, interceptors
**Impact**: Added axios dependency (80KB)
**Approved By**: Team Lead
```

---

### 8. Reference Specs Everywhere

Every commit, PR, decision references spec.

```bash
# Commit
git commit -m "feat: login (Spec 005)"

# PR title
# "Spec 005: User Authentication"

# Code comment (when needed)
// See Spec 005 for token expiration requirements
```

---

### 9. Quality Gates Before Every Commit

Never commit without passing gates.

```bash
# Before every commit
./.specify/scripts/check-quality.sh

# All must pass:
# ✅ Type check
# ✅ Tests
# ✅ Coverage
# ✅ Lint
# ✅ Format
# ✅ No console logs
```

---

### 10. Keep Constitution Updated

When principles change, update immediately.

```markdown
## Amendment #1 - 2026-02-03

**Change**: Coverage 75% → 80%
**Reason**: Found bugs in undertested code
**Impact**: New features must meet 80%
```

---

## Quick Reference

### Essential Commands

```bash
# Installation
uvx --from git+https://github.com/github/spec-kit.git specify init . --ai claude

# Slash commands (in Claude)
/speckit.constitution
/speckit.specify
/speckit.clarify
/speckit.plan
/speckit.tasks
/speckit.implement

# Helper scripts
./.specify/scripts/create-spec.sh [name]
./.specify/scripts/validate-spec.sh [spec.md]
./.specify/scripts/check-quality.sh
./.specify/scripts/list-specs.sh --detailed

# Quality gates (adapt to your stack)
# Type check (if applicable)
# Run tests
# Run linter
# Format code
```

### File Locations

```
.specify/memory/constitution.md        # Principles
.specify/specs/NNN-feature/spec.md    # WHAT
.specify/specs/NNN-feature/plan.md    # HOW
.specify/specs/NNN-feature/tasks.md   # STEPS
.specify/specs/NNN-feature/notes.md   # Decisions
```

### Workflow

```
Constitution → Specify → Plan → Tasks → Implement
```

### Quality Gates

```
✅ Type check: 0 errors
✅ Tests: All passing
✅ Coverage: ≥ 80%
✅ Lint: 0 errors/warnings
✅ Format: Correct
✅ No console logs
```

---

## Resources

### Official Documentation

- [GitHub Spec Kit Repository](https://github.com/github/spec-kit)
- [Installation Guide](https://github.com/github/spec-kit/blob/main/docs/installation.md)
- [Quick Start](https://github.com/github/spec-kit/blob/main/docs/quickstart.md)
- [Spec-Driven Development](https://github.com/github/spec-kit/blob/main/spec-driven.md)
- [Agent Integration](https://github.com/github/spec-kit/blob/main/AGENTS.md)

### Community

- [GitHub Discussions](https://github.com/github/spec-kit/discussions)
- [Issue Tracker](https://github.com/github/spec-kit/issues)

---

## Version History

- **v2.0.0** (2026-02-03) - Official best practices integration
  - Based on official GitHub Spec Kit documentation
  - Complete workflow with all commands
  - Helper scripts included
  - Claude AI integration optimized
  - Single-file comprehensive guide

- **v1.0.0** (2026-02-01) - Initial release

---

**🎯 This single file contains everything needed to establish professional Spec-Driven Development in ANY project with Claude AI.**

**Start**: Tell Claude "Set up Spec Kit using speckit_guide.md"

**Done**: Professional workflow established automatically

---

**Document Version**: 2.0.0
**Last Updated**: 2026-02-03
**Source**: [GitHub Spec Kit Official](https://github.com/github/spec-kit)
**Optimized For**: Claude AI + Universal Projects
**Status**: PRODUCTION READY
