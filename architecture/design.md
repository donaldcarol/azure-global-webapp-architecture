\# Design Notes



\## Project Objective



This project demonstrates a practical Azure web application architecture built for scalability, availability, and clean traffic flow separation.



The first version focuses on a regional web application pattern using:



\- Azure Application Gateway

\- Azure Virtual Machine Scale Set

\- Azure Virtual Network with dedicated subnets

\- Network Security Groups

\- Terraform for Infrastructure as Code



A later version will extend the architecture with Azure Front Door as the global entry point.



\## Version Roadmap



\### Version 1

Internet  

→ Application Gateway  

→ VM Scale Set



\### Version 2

Internet  

→ Azure Front Door  

→ Application Gateway  

→ VM Scale Set



\## Why this design



This architecture was chosen to demonstrate several important Azure concepts that are commonly discussed in cloud engineering and architecture roles:



\- Layer 7 load balancing

\- scalable compute

\- health probes and backend pools

\- web traffic routing

\- infrastructure modularity

\- secure exposure of public services



\## Main Components



\### Application Gateway

Application Gateway is used as the regional Layer 7 entry point for HTTP traffic.



Its role in this project:

\- accept inbound web requests

\- route traffic to backend instances

\- provide a clean web-tier entry layer

\- prepare the design for future HTTPS and WAF support



\### VM Scale Set

The web tier runs on multiple Linux instances deployed through a Virtual Machine Scale Set.



Its role in this project:

\- host identical web server instances

\- allow horizontal scaling

\- improve availability

\- simplify backend pool management



\### Virtual Network and Subnets

The deployment uses separate subnets for:

\- Application Gateway

\- VM Scale Set instances



This separation reflects common Azure design practice and keeps the architecture organized.



\### Network Security Group

The VMSS subnet is protected so that HTTP access is only expected through the Application Gateway path, rather than exposing individual instances directly.



\## Why not use Azure Load Balancer here



Azure Load Balancer is a Layer 4 service and is excellent for TCP/UDP traffic distribution.



For this project, the focus is specifically on a web application architecture using HTTP-aware routing, so Azure Application Gateway is the better fit.



Load Balancer may be introduced later as a comparison scenario.



\## Design Principles



\- avoid direct public exposure of backend instances

\- separate entry tier from compute tier

\- use scalable backend compute

\- keep the first version simple and functional

\- design the solution so it can evolve toward global entry and multi-region patterns



\## Future Improvements



Planned improvements include:

\- Azure Front Door integration

\- HTTPS listener

\- WAF enablement

\- custom domain

\- autoscaling rules

\- multi-region failover scenario

\- GitHub Actions deployment with OIDC

