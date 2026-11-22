# Docker Infrastructure as Code (IaC) Work

A hands-on Infrastructure as Code project demonstrating how to build, deploy, scale, and manage containerized applications using Docker, Docker Compose, Terraform, and Ansible.

## Project Overview

This project demonstrates multiple approaches to container orchestration and infrastructure automation:

- **Docker:** Build and run a containerized Python Flask application.
- **Docker Compose:** Deploy a multi-container application with PostgreSQL and Nginx.
- **Nginx:** Reverse proxy and load balance requests across multiple Flask replicas.
- **Terraform:** Provision and manage Docker images and containers using declarative infrastructure configuration.
- **Ansible:** Automate container deployment with repeatable, idempotent playbooks.
- **Git:** Track project changes and maintain version-controlled infrastructure code.

## Architecture

```text
                 Client
                   |
                   v
             Nginx :8080
                   |
             Reverse Proxy
                   |
          Docker Compose Network
             /           \
            v             v
       Flask Web 1    Flask Web 2
            \             /
             \           /
              PostgreSQL
              Database

      Independent IaC-managed resources

      Terraform
        |-- Nginx :8082
        |-- Flask :8100
        |-- Flask :8101

      Ansible
        |-- Nginx :8084
```

## Technology Stack

| Category | Technologies |
|---|---|
| Application | Python, Flask |
| Containers | Docker, Docker Compose |
| Reverse Proxy | Nginx |
| Database | PostgreSQL 16 |
| Infrastructure as Code | Terraform |
| Configuration Management | Ansible |
| Version Control | Git, GitHub |
| Operating System | Ubuntu 24.04 LTS |

## Project Structure

```text
docker-iac-work/
├── ansible/
│   ├── ansible.cfg
│   ├── group_vars/
│   ├── inventory/
│   └── playbooks/
├── infrastructure/
│   ├── main.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   └── .terraform.lock.hcl
├── nginx/
│   └── default.conf
├── web-app/
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
├── docker-compose.yml
└── .gitignore
```

## Implementation

### 1. Docker Application

Built a Python Flask application and packaged it into a Docker image.

Available endpoints:

- `/` — Returns application information and container hostname.
- `/health` — Returns application health status.

### 2. Docker Compose

Deployed a multi-container environment containing:

- Two Flask application replicas.
- PostgreSQL 16 database.
- Nginx reverse proxy.
- Dedicated Docker network.
- Persistent PostgreSQL volume.
- Database health check.

Start the environment:

```bash
docker compose up -d --build --scale web=2
```

Verify containers:

```bash
docker compose ps
```

Test application:

```bash
curl http://localhost:8080/
curl http://localhost:8080/health
```

### 3. Nginx Load Balancing

Configured Nginx as a reverse proxy using Docker Compose service discovery.

Verified traffic distribution across two Flask replicas by sending repeated HTTP requests and observing different container hostnames.

### 4. Terraform Automation

Used the Docker provider to manage:

- Nginx Docker image.
- Terraform-managed Nginx container.
- Multiple Flask application containers.
- Configurable container names, ports, and replica counts.

Useful commands:

```bash
cd infrastructure
terraform init
terraform validate
terraform plan
terraform apply
terraform state list
```

Test Terraform-managed services:

```bash
curl http://localhost:8082/
curl http://localhost:8100/
curl http://localhost:8101/
```

Replica scaling is controlled through `web_replicas` in `terraform.tfvars`.

### 5. Ansible Automation

Created Ansible playbooks to deploy and remove Docker containers.

Deploy:

```bash
cd ansible
ansible-playbook playbooks/deploy.yml
```

Verify:

```bash
curl http://localhost:8084/
```

Remove the Ansible-managed container:

```bash
ansible-playbook playbooks/cleanup.yml
```

Tested idempotency by running the deployment playbook more than once. The second unchanged execution reported `changed=0`.

## Verification Results

- [x] Flask application containerized successfully.
- [x] Docker Compose multi-container deployment.
- [x] PostgreSQL health check.
- [x] Nginx reverse proxy.
- [x] Load balancing across two Flask replicas.
- [x] Terraform Docker provider configuration.
- [x] Terraform container provisioning and scaling.
- [x] Ansible container deployment.
- [x] Ansible idempotency verification.
- [x] Ansible cleanup playbook.
- [x] Git version control and GitHub push.

## Security Considerations

- Database credentials are stored in a local `.env` file.
- `.env` is excluded through `.gitignore`.
- Terraform state files and local provider data are excluded from Git.
- Terraform dependency lock file is committed for provider reproducibility.
- Sensitive credentials and private keys should never be committed.

## Current Scope and Limitations

This is a hands-on automation lab, not a production-ready deployment.

- Terraform and Ansible manage separate Docker resources from the Compose stack.
- Terraform uses the local Docker daemon.
- Ansible uses a local Python virtual environment containing the Docker SDK.
- GitHub Actions CI/CD integration is a planned next stage.

## Author

**Mubashir**

GitHub: [@mubashir251-tech](https://github.com/mubashir251-tech)

Repository: [docker-iac-work](https://github.com/mubashir251-tech/docker-iac-work)
