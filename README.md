# Cloud Infrastructure CI/CD on AWS


- [Application Server Repository](https://github.com/GokulaKrishnanRGK/cloud-webapp-server)
- [Serverless Function Repository](https://github.com/GokulaKrishnanRGK/serverless-function)

## Project Overview

This project involved the creation of a comprehensive CI/CD pipeline for cloud infrastructure on Amazon Web Services (AWS). The key objectives were to integrate application tests, validate infrastructure code, and automate deployment processes using industry-standard tools and practices.

## Features

- **CI/CD Pipeline**: Implemented a CI/CD pipeline using GitHub Actions, integrating application tests, and validating Terraform and Packer configurations.
- **Terraform Infrastructure**: Developed Terraform scripts to deploy cloud infrastructure, including:
  - Auto-Scaling Groups for dynamic resource management.
  - Load Balancers to manage traffic efficiently.
  - Serverless cloud functions triggered by Pub/Sub CDN events for scalable and event-driven processing.

## Technologies Used

- **Cloud Platform**: Amazon Web Services (AWS)
- **Infrastructure as Code (IaC)**: Terraform
- **Image Building**: Packer
- **Programming Languages and Frameworks**: 
  - Java
  - Spring Boot
  - Hibernate
- **Database**: MySQL
- **Scripting and OS**: 
  - Bash
  - Linux
- **Version Control**: Git

## How to Use

### Prerequisites

- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [Packer](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/GokulaKrishnanRGK/tf-gcp-infra.git
   cd tf-gcp-infra

2. **Configure AWS Authentication**
   ```bash
   aws configure

3. **Initialize Terraform**
   ```bash
   terraform init

4. **Apply Terraform Configuration**
   ```bash
   terraform apply

### Additional Instructions
- Generate server Packer build from [Application Server Repository](https://github.com/GokulaKrishnanRGK/cloud-webapp-server)
- Generate serverless maven build from [Serverless Function Repository](https://github.com/GokulaKrishnanRGK/serverless-function)
