# terraform-vra-vmapps-consume-blueprint

> **Deprecated.** Use [`terraform-vra-deployment`](https://github.com/sentania-labs/terraform-vra-deployment) instead.

This module deploys **any Aria Automation or VCF Automation blueprint** using dynamic inputs passed from the parent Terraform configuration.  This module currently supports deploy the latest draft of an Assembler Blueprint. 

It abstracts away the boilerplate of:
- Selecting a project  
- Supplying a blueprint ID  
- Passing input maps  
- Collecting deployment outputs  

---

## 📦 Module Inputs

| Variable | Type | Description | Required |
|---------|------|-------------|----------|
| `project_name` | string | Aria/VCF project to deploy into | Yes |
| `blueprint_name` | string | The blueprint ID or name | Yes |
| `deployment_name` | string | Name of the deployment | Yes |
| `inputs` | map(any) | Key/value inputs for the blueprint | Yes |
| `description` | string | Optional description | No |

### Example Usage

```hcl
module "deployments" {
  source  = "sentania-labs/vmapps-blueprint/vra"
  version = "0.8.0"

  for_each = var.deployments

  project_name    = var.vcfa_project
  deployment_name = each.value.deployment_name
  description     = each.value.description
  blueprint_name  = each.value.blueprint_name
  inputs          = each.value.inputs
}
```

---

## 📤 Outputs

| Output | Description |
|--------|------------|
| `id` | Deployment ID |
| `name` | Deployment name |

These can be consumed by further modules by utilizing the vra_machine data source.
- DNS automation
- CMDB inserts
- NSX policy modules
- Monitoring registration pipelines

---

## 🧠 Notes / Best Practices

### ✔️ Fully single-pass  
The module does **not** require cyclic re-plans.  
All dependent attributes are fetched after creation via `deployment.resources`.

### ✔️ Blueprint-agnostic  
Any combination of inputs can be passed as long as they match the blueprint's contract.

### ✔️ Ideal for multi-repo or chained pipelines  
This module makes it trivial to build:
- Repo A → deploy VM  
- Repo B → configure DNS / CMDB / Monitoring  
- Repo C → attach network policies  
…all consuming the outputs from this module.

---

## 📜 License  
MIT
