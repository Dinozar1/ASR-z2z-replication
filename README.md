# Azure Site Recovery (AZ → AZ) with Terraform

## Overview
This repository is a **proof of concept** demonstrating **Azure Site Recovery (ASR) Zone-to-Zone (AZ → AZ)** disaster recovery **within a single Azure region**, configured **with Terraform**.

**Validated scope:**
- VM running in **Availability Zone 1**
- **ASR replication to Availability Zone 2** (same region)
- Replication of **OS disk and data disk**
- Validation via **Test Failover**

> Terraform prepares and enables DR. **Failover / Test Failover are operational actions** performed in ASR (portal or runbooks), not via Terraform.

---

## Repository Structure
```text
modules/
  network/          # Source, recovery and test VNets
  compute/          # VM, NIC, disks, SSH key
  asr-core/         # Vault, fabric, containers, policy, cache
  asr-replication/  # Enable AZ→AZ replication
main.tf             # Root configuration
variables.tf         # Root variables
outputs.tf           # Optional outputs

```
## Operational Notes
- Terraform **does not perform failover** by design
- **Test Failover** is the recommended method to validate disaster recovery
- **Real Failover** is intended only for real incidents or planned migrations
- Linux OS image and kernel version must be **supported by Azure Site Recovery**


### Terraform state after full ASR failover cycles

After completing a full Azure Site Recovery cycle (failover → commit → reprotect → failback → commit → reprotect), `terraform plan` shows **no changes**.

This is expected. During ASR operations the primary managed data disk is **recreated and resynchronized**, not migrated back. Some disk properties (`create_option`, `source_resource_id`, `tags`) change as an implementation detail of ASR but have no architectural impact.

To avoid false drift, these attributes are intentionally ignored in Terraform:

```hcl
lifecycle {
  ignore_changes = [
    create_option,
    source_resource_id,
    tags
  ]
}
```

## Disclaimer
This repository is a **proof of concept**.

It demonstrates feasibility and supported patterns for **Azure Site Recovery Zone‑to‑Zone (AZ → AZ)** using Terraform.
