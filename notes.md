# CI / CD (Continuous Integration & Continuous Deployment/Delivery)

---

## **CI/CD Key Notes**

### **1. Basics**
- **CI (Continuous Integration):** Frequent code integration to catch errors early.
- **CD:**

  * **Delivery:** Code always deployable, manual release possible.
  * **Deployment:** Automatic release after passing tests.
- **Benefits:** Faster delivery, fewer errors, better team collaboration.

### **2. CI/CD Pipeline**
1. **Commit code** → trigger build
2. **Build** → compile & assemble dependencies
3. **Test** → automated tests
4. **Staging** → further testing
5. **Production** → deploy live

### **3. Popular Tools**
 GitLab CI/CD, Jenkins, CircleCI, TravisCI, GitHub Actions
- Cloud-native: AWS, Azure, GCP

### **4. Role in DevOps**

* CI/CD automates build, test, deploy.
* **Benefits:** Collaboration, automation, continuous feedback, consistency.
* **Architecture:** Source control → CI/CD → Monitoring/logging (Prometheus, Grafana, ELK).

---

## GitHub Actions
- GitHub's built-in CI/CD tool
- Runs workflows automatically on events (eg: push, pull-requests etc)

**Workflow Basics**
- Defined in *YAML*
- Triggered by events like *commit* or *pull request*

**Main use cases**
- **CI:** Run tests on every push or pull request
- **CD:** Auto-deploy after tests pass
- **Automation:** Automate repetitive tasks (eg: project board updates)

**Why it matter**
- Faster releases
- Fewer manual errors
- Consistent deployments

---

## YAML = “YAML Ain’t Markup Language”
- Human-readable format used for **configuration files**
- Core to **DevOps tools** (CI/CD, Kubernetes, GitHub Actions)
- **YAML is indentation-sensitive**
- Wrong spacing = broken config

**What YAML Is Used For**
- Defining **configs and workflows**
- Easy for humans to read and write
- Machine-friendly for automation

**Core Concepts (Very Important)**
- **1. Key–Value Pairs**
  - Format: `key: value`
  - Used to define settings and parameters
```
name: John Doe
age: 40
```

**2. Lists**
  - Used to store multiple values
  - Each item starts with a **dash (-)**
```
fruits:
- apple
- banana
- cherry
```

**3. Nested Data (Indentation)**
  - YAML uses **indentation (spaces)** to show hierarchy
  - Child elements belong to the parent above them
  - **Consistency in spacing is critical** (usually 2 spaces)
```
address:
  street: 53 Fir Road
  city: Manchester
  country: United Kingdom
```

---

## GitHub Actions Workflow
## **GitHub Actions Workflow Syntax – Must-Know Notes**

**1. Workflow File**
- Defined in a **YAML file**
- Location: `.github/workflows/`
- Any `.yml` / `.yaml` file here becomes a **pipeline**

**2. Workflow Structure (Top Level)**
- **name**
  - Human-readable workflow label
  - Used only for identification

**on (trigger / event)**
  - Defines **when** the workflow runs
  - Common events:

  - `push`
  - `pull_request`
  - `schedule` (cron)

**3. Jobs**
- A workflow contains **one or more jobs**
- Jobs:

  - Run on **virtual machines**
  - Can run **in parallel or sequentially**
- Each job has a unique name (e.g. `build`)

**4. runs-on**
- Defines the **OS/environment** for a job
- Common values:

  - `ubuntu-latest` (most common)
  - `windows-latest`
  - `macos-latest`
- Jobs can also run in **containers**

**5. Steps**
- Jobs are made up of **steps**
- Steps run **sequentially**
- Each step:

  - Runs a shell command **or**
  - Uses a reusable **action**

**6. Actions**
- Reusable units of work
- Pulled from the **GitHub Actions Marketplace**
- Common examples:

  - `actions/checkout` → pulls repo code
  - Setup language runtimes (Node, Python, etc.)
  - Run install, test, build commands

**Core Structure to Remember**
```
Workflow
 └── Event (on)
     └── Job(s)
         └── runs-on
             └── Steps
```
**Create first pipeline/workflow**
```yaml
## Workflow name shown in GitHub Actions
name: CoderCo CICD workflow

## Event that triggers the workflow
on: [push]

## Jobs run by the workflow
jobs:
  ## Job name
  build:
    ## Runner environment
    runs-on: ubuntu-latest

    ## Steps executed in order
    steps:
      ## Checkout repository code
      - name: checkout code
        uses: actions/checkout@v2

      ## Test step to verify workflow runs
      - name: We are testing this workflow
        run: echo Hello everyone!
```

---

## Matrix Builds & Parallel Testing
- A **matrix** lets you run the same job across **multiple configurations** (e.g., Python versions) **in parallel**.
- Each combination is a separate “job instance” running independently

**Example:**
```yaml
strategy:
  matrix:
    python-version: [3.7, 3.8, 3.9]
```

**Usage:**
```yaml
- name: Set up Python
  uses: actions/setup-python@v4
  with:
    python-version: ${{ matrix.python-version }}
```

- This creates **3 parallel runs**, one for each Python version.
- Parallel runs help **catch compatibility issues** early.

---

## Conditionals
- Use conditionals to **run steps only when a certain condition is met**.
- Common conditions:
  - `success()` → only run if previous steps passed.
  - `failure()` → only run if previous steps failed.

**Example:**
```yaml
- name: Notify success
  if: success()
  run: echo "All tests passed on Python ${{ matrix.python-version }}"
```

**Explanation**
- Step runs **only if tests succeed**.
- Can combine with matrix:
  - You get notifications **per Python version**, only for successful runs.

---

## Secrets in GitHub Actions
- Encrypted values for *passwords, tokens, and keys*
- Stores securely in *GitHub repo settings -> Secrets -> Actions*
- *Never* printed in logs (hidden by GitHub)

**How secrets are used**
- Accessed in workflows via:
  - `secrets.SECRET_NAME`

**Secrets vs Variables**
- Secrets are hidden and encrypted for sensitive data
- Variables are visible, for non-sensitive config

Got it! Here’s a **notes-style summary** you can drop into your notes repo — concise, conceptual, and highlights what matters:

---

## Custom GitHub Actions (JavaScript)
- Reusable automation logic for GitHub workflows.
- Can be used across multiple repos.

**Structure:**
- **`action.yml`** → defines inputs, outputs, runtime, entry point.
- **`index.js`** → main JavaScript logic.
- **`dist/index.js`** → compiled bundle with dependencies (via `ncc`).

**Inputs/Outputs:**
- Inputs defined in `action.yml` → read with `core.getInput()`.
- Outputs set with `core.setOutput()`.

**Dependencies:**
- Use `@actions/core` for GitHub integration.
- Dependencies must be bundled (`ncc`) because GitHub **does not install `node_modules`**.

**Compilation:**
- `ncc` bundles your JS + dependencies into one file for GitHub.
- `dist/` usually committed; `node_modules/` ignored.

**Workflow Usage:**
- Called via `uses: owner/repo@branch` in `.github/workflows/*.yml`.
- Inputs passed via `with:`.
- Outputs can be consumed by later steps.

---

## Manual triggers in GitHub Actions
- Allows workflows to be started *manually* from the GitHub Actions UI
- Implemented using `workflow_dispatch`

**How It Works:**
- Define a workflow name
- Add `workflow_dispatch` under `on`
- Optionally define *inputs* user must provide before running

**Key Benefits**
- Full control over when workflows run
- Safer production operations
- No need for code pushes to trigger jobs

---

## CI/CD Security & Debugging
**1. Security in CI/CD Pipelines**
**Best Practices:**
1. **Secure Secrets**
   - Never hardcode API keys, passwords, or tokens
   - Use GitHub Secrets or a secure secret manager
2. **Control Access**
   - Apply **least privilege** principle
   - Use **role-based access control (RBAC)**
3. **Scan for Vulnerabilities**
   - Regularly check code and dependencies
   - Tools: Dependabot, Snyk, or other security scanners
4. **Audit & Monitor**
   - Track actions and changes
   - Enable logging, monitoring, and alerts for unusual activity

**2. Debugging Workflow Failures**
**Common Issues:**
- **Failed tests** → check test results and code logic
- **Dependency errors** → missing, conflicting, or outdated packages
- **Configuration errors** → YAML syntax mistakes (indentation, spaces, typos)
- **Permission issues** → insufficient repo or secret access

**Common Solutions:**
1. **Review logs** → identify exact errors
2. **Rerun jobs** → catch transient failures
3. **Update dependencies** → fix conflicts and compatibility
4. **Check configuration & secrets** → ensure correct syntax and access

---