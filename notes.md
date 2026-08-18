# DevOps + Terraform Bootcamp — Restructured 3-Week Plan (Continuation)

**Format:** 5 days/week, ~3 hrs/day, weekends off.
**Started:** Original 3-week bootcamp (Days 1–5 + start of Day 7 already complete).
**This tracker covers the remainder**, restructured to fit a 5-day work week instead of 7.

> Rule from the original plan, still in force: push to GitHub daily (even broken code),
> and write 3 sentences here every day — what broke, why, how you fixed it.
> This becomes your interview STAR stories.

---

## Status Snapshot (update this section as you go)

- [x] Day 1 — Linux & CLI survival skills
- [x] Day 2 — Git & GitHub (branching, PR, conflict, protection)
- [x] Day 3 — Cloud fundamentals (manual Portal walkthrough)
- [x] Day 4 — Terraform core concepts
- [x] Day 5 — Terraform state deep dive (incl. real state-loss recovery — good interview story)
- [ ] Day 6 — Variables, Outputs, Workspaces
- [~] Day 7 — Mini project (RG → VNet → Subnet → NSG → VM + NSG segmentation test) — **in progress**

**Current position:** Finishing Day 7 (NSG segmentation test with real VMs), then Day 6.

---

## Week A

### A1 — Finish Day 7: Mini Project
- [ ] VM + NSG + Public IP applied successfully
- [ ] SSH-hop test: Web → App → DB, confirm NSG rules enforce segmentation correctly
- [ ] Install nginx on `vm-web`, confirm port 80 reachable from your browser via public IP
- [ ] Push to GitHub with a README.md explaining the architecture (add a diagram — draw.io or excalidraw)
- [ ] **Checkpoint:** End-to-end proof that RG → VNet → Subnet → NSG → VM works, documented

**Notes (what broke / why / fix):**
-

---

### A2 — Day 6: Variables, Outputs, Workspaces
- [ ] Refactor `main.tf`: move hardcoded values (RG name, location, CIDR blocks, VM size) into `variables.tf`
- [ ] Add `terraform.tfvars` for actual values
- [ ] Add `outputs.tf` (e.g. VM public IP, VNet ID, subnet IDs)
- [ ] Create `dev` and `prod` Terraform workspaces
- [ ] Prove same code deploys different-sized environments based on workspace/tfvars
- [ ] **Checkpoint:** No hardcoded values remain in resource blocks; `terraform workspace select dev` vs `prod` changes output

**Notes:**
-

---

### A3 — Day 8: Terraform Modules
- [ ] Create `modules/network` (VNet, subnets, NSGs)
- [ ] Create `modules/compute` (NICs, VMs, public IP)
- [ ] Root `main.tf` calls both modules, passing variables in
- [ ] **Checkpoint:** Root module is clean — no raw resource blocks, just module calls

**Notes:**
-

---

### A4 — Day 9: for_each, count, data sources, functions
- [ ] Rebuild the 3 subnets using a single `for_each` block driven by a variable map (instead of 3 copy-pasted blocks)
- [ ] Add at least one `data` source (reference an existing resource without managing it)
- [ ] Try at least one built-in function (`lookup`, `merge`, or `try`)
- [ ] **Checkpoint:** Loop-based subnet creation working with one `for_each` block
- [ ] **Interview prep:** Be ready to explain `count` vs `for_each` — why `for_each` is safer for lists that change (avoids re-indexing issues)

**Notes:**
-

---

### A5 — Day 10: Terraform + AKS Intro
- [ ] Learn AKS concepts at a high level (pods, deployments, services, ingress) — conceptual fluency, not deep mastery
- [ ] Provision a small (1–2 node, free-tier-friendly) AKS cluster via `azurerm_kubernetes_cluster`
- [ ] Run `kubectl get nodes` to confirm it's live
- [ ] **Destroy the cluster same day** — don't burn Azure credit overnight
- [ ] **Checkpoint:** `kubectl get nodes` returned a running, Terraform-provisioned cluster (screenshot/log it before destroying)

**Notes:**
-

---

## Week B

### B1 — Day 11: Docker Fundamentals
- [ ] Learn: images vs containers, Dockerfile syntax, layers/caching, multi-stage builds
- [ ] Containerize a simple app (basic Node.js/Python "Hello World" API)
- [ ] Provision Azure Container Registry (ACR) via Terraform
- [ ] `docker run` locally, then `docker push` to your own ACR
- [ ] **Checkpoint:** Image successfully pushed to your Terraform-provisioned ACR

**Notes:**
-

---

### B2 — Day 12: CI/CD Concepts + GitHub Actions
- [ ] Learn: CI vs CD vs Continuous Deployment, pipeline stages, YAML basics
- [ ] Set up GitHub Actions workflow: run `terraform fmt -check` and `terraform validate` on every push
- [ ] **Checkpoint:** Green checkmark on a PR triggered by GitHub Actions

**Notes:**
-

---

### B3 — Day 13: Azure DevOps Full Setup
- [ ] Sign in to dev.azure.com with same account as Azure Portal
- [ ] Create free Organization → new Project (private, Git version control)
- [ ] **If parallelism approval is needed, submit the free-tier request form TODAY** (Organization Settings → Parallel jobs) — approval takes 1–3 business days, so kick this off early to avoid blocking B4
- [ ] Connect Azure subscription via Service Connection (Project Settings → Service connections → New → Azure Resource Manager)
- [ ] Push Week A Terraform code into Azure Repos (or link existing GitHub repo)
- [ ] Create first `azure-pipelines.yml` running `terraform init` + `terraform plan`
- [ ] **Checkpoint:** Green pipeline run visible in Azure DevOps Pipelines tab, with plan output in logs

**Notes:**
-

---

### B4 — Day 14: Full Terraform CI/CD Pipeline
- [ ] Extend B3's pipeline into 2 stages: **Plan** (auto on every PR) and **Apply** (manual approval gate, on merge to `main`)
- [ ] Store remote state credentials as pipeline secret variables (never hardcode)
- [ ] Trigger it: open a PR changing a VM size, watch Plan run, approve, watch Apply provision it
- [ ] **Checkpoint:** A real infra change deployed entirely through the pipeline, not your local machine
- [ ] **Interview prep:** Practice explaining PR → automated plan → manual approval → apply out loud — this is THE workflow interviewers want to hear described

**Notes:**
-

---

### B5 — Day 15: Capstone Kickoff — 3-Tier App Infrastructure
- [ ] Design (on paper/diagram) a 3-tier architecture: VNet with app subnet + DB subnet, AKS or App Service for compute, Azure SQL or PostgreSQL Flexible Server for DB, Key Vault for secrets
- [ ] Start building Terraform modules for networking + database layer
- [ ] **Checkpoint:** Network + DB provisioned and reachable (test connection string via a client)

**Notes:**
-

---

## Week C

### C1 — Day 16: Capstone — Compute Layer + Secrets Management
- [ ] Learn: Key Vault + Terraform integration, avoiding secrets in state files/git history
- [ ] Provision App Service or AKS deployment
- [ ] Wire up Key Vault references for DB connection strings
- [ ] Deploy your B1 Docker container to it
- [ ] **Checkpoint:** App reachable via public URL, pulling secrets from Key Vault (not hardcoded)

**Notes:**
-

---

### C2 — Day 17: Capstone — Full CI/CD Wired Up
- [ ] Build complete pipeline (pick GitHub Actions or Azure DevOps — specialize in one) that:
  1. Lints/validates Terraform on PR
  2. Builds and pushes Docker image to ACR on merge
  3. Runs `terraform apply` to update infra
  4. Rolls out the new container image
- [ ] **Checkpoint:** One `git push` results in fully automated infra + app deployment
- [ ] Stretch goal: post `terraform plan` output as a PR comment (e.g. via `hashicorp/setup-terraform`)

**Notes:**
-

---

### C3 — Day 18: Monitoring, Logging & Cost Control
- [ ] Learn: Azure Monitor, Log Analytics, budgets/alerts, tagging strategy
- [ ] Add Terraform-managed budget alert + Log Analytics workspace to capstone
- [ ] Set up a simple alert (e.g., CPU > 80%)
- [ ] **Checkpoint:** Alert rule visible and testable in Azure Monitor
- [ ] **Interview prep:** "How do you control cloud costs?" → tags + budgets + auto-shutdown for dev environments

**Notes:**
-

---

### C4 — Day 19: Security & Terraform Best Practices
- [ ] Learn: least-privilege IAM, `tfsec`/`checkov` static scanning, avoiding wildcard permissions, private endpoints
- [ ] Run `tfsec` or `checkov` against capstone repo
- [ ] Fix at least 3 flagged issues
- [ ] Add the scanner as a pipeline step
- [ ] **Checkpoint:** Security scan integrated into CI pipeline with passing (or explicitly justified) results

**Notes:**
-

---

### C5 — Day 20: Portfolio Polish + Resume Alignment
- [ ] Clean up all repos: proper READMEs, architecture diagrams, "how to run this" instructions
- [ ] Write a 1-paragraph project summary for each (→ resume bullet points)
- [ ] Update LinkedIn/resume with metrics where possible
- [ ] `terraform destroy` everything not actively needed — protect free credit
- [ ] **Checkpoint:** 3 clean, documented, destroy-and-recreate-able repos on GitHub

**Notes:**
-

---

## Bonus / Buffer — Mock Interview Prep
*(No laptop required — can be done as reading/talking practice on a weekend if you want, entirely optional)*

- [ ] Record yourself explaining your capstone project in 3 minutes
- [ ] Drill the core question bank out loud (see below)
- [ ] Prepare one real story of failure/debugging (you already have a strong one: the Aug 7–13 state-loss recovery)

### Core question bank
- Walk me through what happens when you run `terraform apply`.
- How do you manage state across a team? What happens if two people apply at once?
- `count` vs `for_each` — when would you use each?
- What's the difference between `terraform plan` and `terraform apply -refresh-only`?
- How would you structure Terraform code for dev/staging/prod?
- Describe a time a deployment failed. What did you do?
- What's idempotency, and why does it matter in IaC?
- How do you avoid secrets ending up in your Terraform state or git history?
- CI vs CD vs Continuous Deployment — explain the difference.
- How do you roll back a bad deployment?
- What's the difference between a Deployment and a StatefulSet in Kubernetes?
- Explain the difference between an NSG and an Azure Firewall.

### Practical tricks
- Have Terraform installed and one repo open during virtual interviews — practice writing an `azurerm_resource_group` + `azurerm_storage_account` from memory, fast.
- Know your own project's numbers — if you claim "reduced deployment time," be ready for "by how much? how did you measure that?"
- Reverse-engineer target job descriptions — make sure your capstone touches every tool they list.
- Ask about their IaC maturity in the interview ("monorepo or separate repos per environment?") — signals real experience.

### Certifications (optional, after the 2–3 weeks of hands-on work, not instead of it)
- Terraform Associate (003) — HashiCorp's own cert
- AZ-104 (Azure Administrator) — solid if targeting Azure-heavy roles

---

## Safety Net: Protecting Your Free Azure Credit
- `terraform destroy` at the end of any day you're not actively using resources — especially AKS clusters and VMs
- Set a budget alert now, don't wait until Day 18
- Prefer B-series (burstable) VMs and the smallest AKS node size for labs

---

## How to use this file with Claude in a new session
Since Claude doesn't retain memory across separate conversations by default, do one of:
1. Paste this file's content (or the relevant day's section) at the start of a new chat, or
2. Turn on Claude's memory feature in Settings, or
3. Just say "here's my plan, I'm on Day X" and paste that day's checklist
