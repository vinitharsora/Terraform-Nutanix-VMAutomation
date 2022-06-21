# Terraform-Nutanix-VMAutomation

Main concepts covered in this repository:

- Adding `nutanix` as a required provider
- Creating a new Nutanix AHV-VM by taking clone of an existing reference template image that can be used as the base disk for a Nutanix AHV-hosted virtual machine
- Specification of a Nutanix AHV-hosted virtual machine, including custom virtual resource spec (vCPU, vRAM, storage, networking)
- Using Terraform variables to specify Nutanix Prism Central connection parameters:
  - Prism Central endpoint/IP address
  - Credentials
  - Cluster name for virtual machine deployment
  - Subnet name for new virtual machine network connection
- Please see the related [Nutanix.dev blog](https://www.nutanix.dev/2021/04/20/using-the-nutanix-terraform-provider/) and [video](https://www.nutanix.dev/videos/what-is-hci-for-devs-part-5-nutanix-terraform-provider/) for a guided walk-through!


## Usage

- Clone this repository to your local system:

  ```shell
  git clone https://github.com/vinitharsora/Terraform-Nutanix-VMAutomation.git
  ```

- Change to the subdirectory and edit the `terraform.tfvars` variables for your environment

- Initialise, plan, and apply the Terraform configuration.  For example:

  ```shell
  terraform init
  terraform validate
  terraform plan
  terraform apply
  # terraform destroy # optional, when finished
  ```