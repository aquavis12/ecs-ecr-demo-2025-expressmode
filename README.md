# ECS ECR Demo 2025

From image to HTTPS endpoint in one step with ECS Express Mode

## Overview

This project demonstrates deploying a simple nginx-based web application to AWS ECS using ECR (Elastic Container Registry) and ECS Express Mode for quick deployment.

## Prerequisites

- Docker installed
- AWS CLI configured with appropriate credentials
- AWS account with ECR and ECS permissions

## Step 1: Get Your AWS Account ID

```bash
aws sts get-caller-identity --query Account --output text
```

## Step 2: Create ECR Repository

```bash
aws ecr create-repository --repository-name ecs-ecr-demo-2025 --region <your-region>
```

Replace `<your-region>` with your AWS region (e.g., `us-east-1`, `us-west-2`)

## Step 3: Authenticate Docker to ECR

```bash
aws ecr get-login-password --region <your-region> | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.<your-region>.amazonaws.com
```

Replace:
- `<your-region>` with your AWS region
- `<your-account-id>` with your AWS account ID from Step 1

## Step 4: Build Docker Image

```bash
docker build -t ecs-ecr-demo-2025 .
```

## Step 5: Tag the Image

```bash
docker tag ecs-ecr-demo-2025:latest <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/ecs-ecr-demo-2025:latest
```

## Step 6: Push to ECR

```bash
docker push <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/ecs-ecr-demo-2025:latest
```

## Step 7: Deploy with ECS Express Mode

1. Go to AWS ECS Console
2. Select "Express Mode"
4. Choose your ECR image: `ecs-ecr-demo-2025:latest`
5. Configure (opitional)
   - Container port: 80
   - Autoscaling
   - Env variables
   - Networking
   - logging
6. Click "Create"

ECS Express Mode will automatically:
- Create VPC and networking
- Set up security groups
- Configures load balancer with target groups , listeners & rules .
- Deploy your container
- Provide a public endpoint

##Blog 

[For more info](http://dev.to/aws-builders/from-image-to-https-endpoint-in-one-step-with-ecs-express-mode-1oi2)

## Local Testing

Test the container locally before pushing:

```bash
docker run -p 8080:80 ecs-ecr-demo-2025
```

Access at: http://localhost:8080

## Application Features

The demo application displays:
- Client IP address
- Server hostname
- Instance configuration
- System time and uptime
- Platform information

## Architecture

- **Base Image**: nginx:alpine (minimal footprint)
- **Port**: 80 (nginx default)
- **Content**: Static HTML dashboard




