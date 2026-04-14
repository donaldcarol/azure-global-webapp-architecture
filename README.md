![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform)
![Azure](https://img.shields.io/badge/Cloud-Azure-0078D4?logo=microsoftazure)
![Status](https://img.shields.io/badge/Status-Demo-success)
![License](https://img.shields.io/badge/License-MIT-blue)

# 🌍 Azure Global Web App Architecture

## 🧠 Overview

This project demonstrates a modern Azure architecture using both **regional** and **global Layer 7 load balancing**.

```text
Internet → Azure Front Door → Application Gateway → VM Scale Set → Nginx
```

---

## 🔧 Architecture Components


## 🏗️ Architecture Diagram

```mermaid
flowchart LR
    A[User] --> B[Azure Front Door]
    B --> C[Application Gateway]
    C --> D[VM Scale Set]
    D --> E[Nginx Web App]
```

### 🔴 Azure Front Door (Global Layer 7)

* Global entry point (`*.azurefd.net`)
* Routes traffic at the edge (Microsoft network)
* Sends requests to regional backend (Application Gateway)

---

### 🔵 Application Gateway (Regional Layer 7)

* Web traffic routing (HTTP)
* Health probes for backend
* Load balancing across VM Scale Set instances

---

### 🟢 VM Scale Set (Backend)

* Linux (Ubuntu)
* 2 instances
* Nginx installed via custom script
* Displays hostname for load balancing demo

---

## 🔁 Request Flow

1. User accesses Front Door endpoint:

   ```
   http://<endpoint>.azurefd.net
   ```

2. Front Door routes traffic to:

   * Application Gateway (configured as origin)

3. Application Gateway forwards request to:

   * VM Scale Set backend pool

4. VM responds with instance hostname:

   ```
   Served from instance: vmss-web000001
   ```

---

## 📸 Demo

### 🌐 Front Door Response

![Front Door](architecture/screenshots/FD.jpg)

---
### 🔵 Application Gateway Backend Health

![Backend Health](architecture/screenshots/appgw-backend-health.jpg)

---
### 🟢 VM Scale Set Instances

![VMSS](architecture/screenshots/vmss-instances.jpg)

---

## ⚠️ Important Notes

### 🔥 HTTP Only (Current Version)

* This setup uses **HTTP only**
* HTTPS is not configured
* Browsers may automatically attempt HTTPS and fail

---

### 🔥 Front Door Origin Configuration

* Backend is defined using **Application Gateway public IP**
* Works for lab/demo scenarios
* Production environments should use **FQDN or custom domain**

---

### 🔥 Cost Optimization

```bash
terraform apply → test → terraform destroy
```

* Application Gateway and Front Door incur hourly costs
* Resources are destroyed after testing

---

## 🚀 Deployment

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

---

## 🧪 Validation

* Access Front Door endpoint over HTTP
* Refresh page to observe different VM instances
* Confirm full path:

```text
Front Door → App Gateway → VMSS
```

---

## 📈 Future Improvements

* 🔒 Enable HTTPS on Front Door
* 🛡️ Add Web Application Firewall (WAF)
* 🌍 Multi-region deployment with failover
* 🌐 Replace IP-based origin with DNS-based configuration

---

## 💬 Key Takeaways

* **Front Door = global load balancing**
* **Application Gateway = regional routing**
* **VMSS = scalable compute layer**

---

## 🧠 Lessons Learned

- Front Door requires correct protocol configuration (HTTP vs HTTPS)
- Browsers may default to HTTPS, causing misleading failures
- Application Gateway works reliably as a backend for Front Door
- Using IP as origin works for labs, but FQDN is preferred in production
- Health probes are critical for backend availability
- Terraform helps maintain consistent and repeatable deployments

---

## 🧑‍💻 Author

Azure Cloud Engineer – hands-on lab demonstrating real-world architecture patterns.

