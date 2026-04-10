# Azure Global Web App Architecture

This project demonstrates a practical Azure web application architecture designed around high availability, scalability, and secure traffic distribution.

The solution is built to showcase several important Azure services often used in real-world cloud environments:

- Azure Front Door as the global entry point
- Azure Application Gateway for regional Layer 7 routing
- Azure Virtual Machine Scale Sets for scalable web compute
- Azure networking components such as VNets, subnets, and NSGs
- Infrastructure as Code using Terraform

## Architecture Overview

Traffic flow:

Internet  
→ Azure Front Door  
→ Azure Application Gateway  
→ Azure VM Scale Set (web servers)

This design reflects a common enterprise-style pattern where:

- Front Door provides global HTTP/HTTPS entry and traffic optimization
- Application Gateway handles regional web routing and can later be extended with WAF
- VM Scale Sets provide horizontal scaling for stateless web servers

## Project Goals

The purpose of this project is to demonstrate:

- practical Azure architecture thinking
- separation of global and regional traffic management
- high availability design principles
- scalable compute using VM Scale Sets
- reusable Infrastructure as Code patterns
- a portfolio-ready Azure deployment example

## Repository Structure

```text
azure-global-webapp-architecture/
├── README.md
├── architecture/
│   ├── design.md
│   └── diagram-placeholder.md
├── terraform/
│   ├── provider.tf
│   ├── variables.tf
│   ├── main.tf
│   ├── network.tf
│   ├── vmss.tf
│   ├── appgw.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
├── app/
│   ├── install-nginx.sh
│   └── index.html
├── scripts/
│   └── test-load.ps1
└── .github/
    └── workflows/
        └── deploy.yml
```

## Current Scope

 Initial version:

- Resource Group
- Virtual Network
- Dedicated subnets
- Network Security Group
- Linux VM Scale Set
- Application Gateway
- basic web server bootstrap script

Planned next steps:

- Azure Front Door
- WAF policy
- HTTPS with certificates
- multi-region failover
- GitHub Actions deployment using OIDC
- monitoring and health validation


## Why This Project Matters

This repository is meant as a practical cloud portfolio project, not just a lab. It demonstrates how several Azure services work together in a realistic web hosting scenario.

It can be used to discuss topics such as:

- Load Balancer vs Application Gateway vs Front Door
- regional vs global traffic distribution
- autoscaling patterns
- health probes and backend pools
- Layer 4 vs Layer 7 design choices
- high availability in Azure

   ## Technologies Used
  
- Microsoft Azure
- Terraform
- Azure Front Door
- Azure Application Gateway
- Azure VM Scale Sets
- GitHub Actions
- Linux / Nginx

  ## Deployment Notes

The Terraform configuration is designed to be modular enough for learning and portfolio purposes.

Before deployment, update the values in terraform.tfvars and make sure you are authenticated to Azure.

Typical workflow:

terraform init  
terraform plan  
terraform apply  

## Future Improvements

Possible improvements for future iterations:

add Azure Front Door Standard/Premium
enable Web Application Firewall
add a second region for failover
use custom domain and TLS
publish architecture diagram
add CI/CD automation with GitHub Actions and OIDC federation
Author

This project was created as part of my Azure architecture and cloud engineering portfolio, with focus on practical design, infrastructure automation, and interview-ready cloud scenarios.


---

# architecture/design.md



```markdown
# Design Notes

## Objective

Build a highly available and scalable Azure-hosted web application architecture that demonstrates the role of global entry services, regional Layer 7 routing, and scalable backend compute.

## Main Components

### Azure Front Door
Used as the global HTTP/HTTPS entry point.
It helps route user traffic efficiently and can later be extended with security and failover capabilities.

### Azure Application Gateway
Used as the regional Layer 7 load balancer.
It provides HTTP/HTTPS-aware routing and is the right place for features such as:
- host-based routing
- path-based routing
- SSL termination
- WAF

### VM Scale Set
Used to host multiple identical web server instances.
This provides:
- horizontal scaling
- better availability
- easier backend management

## Why not just use Azure Load Balancer?

Azure Load Balancer works at Layer 4 and is excellent for TCP/UDP scenarios.
For web applications that need HTTP/HTTPS-aware routing, Application Gateway is a better fit.

## Design Principles

- avoid direct public exposure of individual VMs
- keep traffic flow structured and layered
- make the backend scalable
- prepare the design for future multi-region expansion
- keep the deployment reproducible with Terraform

## Future Evolution

- Add Front Door as the global entry point
- Add WAF
- Add custom domain and TLS
- Add multi-region deployment
- Add GitHub Actions deployment automation

