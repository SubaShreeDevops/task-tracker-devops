# Task Tracker API – DevOps Take-Home Assignment

## Overview

This project demonstrates a complete **DevOps workflow** for deploying a simple **Task Tracker API** using modern DevOps practices.

The system includes:

* API application
* Docker containerization
* Infrastructure provisioning with Terraform
* CI/CD pipeline using GitHub Actions
* Automated deployment to AWS EC2
* Basic monitoring setup

The goal of this project is to showcase **Infrastructure as Code, automation, containerization, and CI/CD best practices**.

---

# Architecture

```
Developer
   │
   │ Push Code
   ▼
GitHub Repository
   │
   │ GitHub Actions CI/CD
   ▼
Build & Test Application
   │
   ▼
Build Docker Image
   │
   ▼
Push Image → DockerHub
   │
   ▼
SSH Deployment
   │
   ▼
AWS EC2 Instance
 ├─ Docker Container (Task Tracker API)
 └─ Node Exporter (Monitoring)

Monitoring
Prometheus → Node Exporter
```

---

# Tech Stack

| Component        | Technology                |
| ---------------- | ------------------------- |
| API              | FastAPI / Flask / Node.js |
| Containerization | Docker                    |
| Infrastructure   | Terraform                 |
| CI/CD            | GitHub Actions            |
| Cloud            | AWS EC2                   |
| Monitoring       | Prometheus Node Exporter  |
| Storage          | SQLite / PostgreSQL       |

---

# Repository Structure

```
task-tracker-devops
│
├── app/
│   ├── main.py
│   ├── requirements.txt
│
├── docker/
│   └── Dockerfile
│
├── terraform/
│   ├── main.tf
│   ├── provider.tf
│
├── ansible/
│
├── monitoring/
│
├── .github/workflows/
│   └── ci-cd.yml
│
└── README.md
```

---

# API Endpoints

### Create Task

POST `/tasks`

Example:

```
curl -X POST http://EC2_IP:3000/tasks \
-H "Content-Type: application/json" \
-d '{"name":"Learn DevOps"}'
```

---

### List Tasks

GET `/tasks`

```
curl http://EC2_IP:3000/tasks
```

---

# Infrastructure Provisioning (Terraform)

Terraform provisions the following AWS resources:

* EC2 instance
* Security Group
* S3 bucket for logs/artifacts

### Initialize Terraform

```
cd terraform
terraform init
```

### Preview Infrastructure

```
terraform plan
```

### Deploy Infrastructure

```
terraform apply
```

Resources created:

* Ubuntu EC2 instance
* Security group (ports 22 & 3000)
* S3 bucket

---

# Docker Setup

The application is containerized using Docker.

### Build Image

```
docker build -t task-tracker -f docker/Dockerfile .
```

### Run Container

```
docker run -d -p 3000:3000 task-tracker
```

---

# CI/CD Pipeline

CI/CD is implemented using **GitHub Actions**.

Pipeline stages:

1. Checkout repository
2. Install dependencies
3. Run tests
4. Build Docker image
5. Push image to DockerHub
6. SSH into EC2
7. Deploy container

### Workflow File

```
.github/workflows/ci-cd.yml
```

---

# GitHub Secrets

The following secrets must be configured in GitHub:

| Secret          | Description            |
| --------------- | ---------------------- |
| DOCKER_USERNAME | DockerHub username     |
| DOCKER_PASSWORD | DockerHub access token |
| EC2_HOST        | EC2 public IP          |
| EC2_USER        | EC2 username (ubuntu)  |
| EC2_SSH_KEY     | EC2 private key        |

---

# Monitoring

Basic monitoring is implemented using **Prometheus Node Exporter**.

Metrics endpoint:

```
http://EC2_IP:9100/metrics
```

Example metrics:

* CPU usage
* Memory usage
* Disk IO
* Network statistics

---

# Testing the Deployment

After deployment, access the API:

```
http://EC2_IP:3000/tasks
```

Test with curl:

```
curl http://EC2_IP:3000/tasks
```

---

# Design Decisions

### Containerization

Docker was used to ensure consistent environments across development and production.

### Infrastructure as Code

Terraform allows reproducible and version-controlled infrastructure deployment.

### CI/CD Automation

GitHub Actions automates build, test, and deployment processes.

### Monitoring

Node Exporter provides basic system metrics for observability.

---

# Possible Improvements

Future improvements could include:

* Deploy using **ECS or Fargate**
* Add **Application Load Balancer**
* Implement **Blue-Green deployment**
* Add **Grafana dashboards**
* Use **Terraform remote backend**
* Add **Prometheus + Alertmanager**

---

# Clean Up Infrastructure

To remove resources:

```
terraform destroy
```

---

# Author

Suba Shree
DevOps Engineer
