# CI/CD Module

## Overview

This repository contains my work from the **CI/CD module** at *CoderCo Academy*.
The focus of this module was building **real-world Continuous Integration and Continuous Deployment pipelines** using GitHub Actions, with practical examples involving **Docker and Terraform**.

---

## Skills Learned

- CI/CD fundamentals: CI vs CD and how they fit into DevOps workflows
- Building GitHub Actions pipelines from scratch
- Automating Docker image builds and pushes
- Using GitHub Secrets securely in workflows
- Running Terraform linting and validation in CI
- Triggering pipelines on pushes and pull requests
- Debugging failed workflows and fixing pipeline issues
- Structuring repositories for scalable CI/CD projects

---

## Directories

- **[GitHub Workflows](./.github/workflows/)** - All GitHub Actions workflow YAML files used for CI and CD pipelines across the module.

- **[CI/CD Tasks](./cicd/):**
    
    - **[Task 1 – Terraform CI Pipeline](./cicd/task-1/)** - Built a CI pipeline that automatically runs `terraform init`, `terraform fmt -check`, and `terraform validate` on pull requests.

    - **[Task 2 – Docker CD Pipeline](./cicd/task-2/)** - Built a CD workflow that automatically builds a Docker image from a Flask app and pushes it to Docker Hub using GitHub Actions.

- **[Notes](notes.md)** - Key CI/CD concepts, GitHub Action syntax, and learning summaries from the module.

---

## Key Takeaways

This module helped solidify how CI/CD pipelines:

- Reduce manual work and human error
- Enforce consistent standards automatically
- Provide fast feedback on code quality
- Form the foundation for production-ready DevOps workflows
