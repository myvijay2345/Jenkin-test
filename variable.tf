variable "infra_project_id" {
  description = "The GCP project identifier where the resources will be deployed"
  type        = string
}

variable "prod_int_project_id" {
  description = "The GCP project identifier where the resources will be deployed"
  type        = string
}

variable "environment" {
  type        = string
  description = "Infrastructure environment (organization) e.g. dev / production"
}

variable "region" {
  type        = string
  description = "GCP Region that landing zone will be deployed in"
}

variable "region_short" {
  type        = string
  description = "Shortcut for global bussiness regions used in naming conventions e.g. ea,am"
}

variable "location_short" {
  type        = string
  description = "Shortcut for GCP data center location (gcp region) e.g. weu3 - europe-west3"
}

variable "bu_short" {
  type        = string
  description = "Shortcut for department used in naming conventions e.g. its"
}

variable "prefix" {
  type = string
  validation {
    # Upstream BIG-IP module adds "-XXXX" suffix to each instance name, so
    # validate that the prefix is RFC1035 compliant with a maximum length of 58
    # alphanumeric and/or - characters.
    condition     = can(regex("^[a-z][a-z0-9-]{0,57}$", var.prefix))
    error_message = "The prefix variable must be RFC1035 compliant and between 1 and 58 characters in length."
  }
  description = <<-EOD
The prefix to use when naming resources managed by this module. Must be RFC1035
compliant and between 1 and 58 characters in length, inclusive.
EOD
}


variable "zones" {
  type = list(string)
  validation {
    condition     = length(var.zones) > 0 && length(join("", [for zone in var.zones : can(regex("^[a-z]{2,20}-[a-z]{4,20}[0-9]-[a-z]$", zone)) ? "x" : ""])) == length(var.zones)
    error_message = "At least one zone must be specified, and each zone must be a valid GCE zone name."
  }
  description = <<-EOD
The compute zones where where the BIG-IP instances will be deployed. At least one
zone must be provided; if more than one zone is given, the instances will be
distributed among them.
EOD
}

variable "min_cpu_platform" {
  type        = string
  default     = "Intel Skylake"
  description = <<-EOD
An optional constraint used when scheduling the BIG-IP VMs; this value prevents
the VMs from being scheduled on hardware that doesn't meet the minimum CPU
micro-architecture. Default value is 'Intel Skylake'.
EOD
}

variable "f5_machine_type" {
  type        = string
  default     = "n1-standard-4"
  description = <<-EOD
The machine type to use for BIG-IP VMs; this may be a standard GCE machine type,
or a customised VM ('custom-VCPUS-MEM_IN_MB'). Default value is 'n1-standard-4'.
*Note:* machine_type is highly-correlated with network bandwidth and performance;
an N2 machine type will give better performance but has limited regional availability.
EOD
}

variable "image" {
  type = string
  validation {
    condition     = can(regex("^(?:https://www.googleapis.com/compute/v1/)?projects/[a-z][a-z0-9-]{4,28}[a-z0-9]/global/images/[a-z][a-z0-9-]{0,61}[a-z0-9]", var.image))
    error_message = "The image variable must be a fully-qualified URI."
  }
  default     = "projects/f5-7626-networks-public/global/images/f5-bigip-17-1-1-3-0-0-5-byol-all-modules-1boot-loc-40321070009"
  description = <<-EOD
The self-link URI for a BIG-IP image to use as a base for the VM cluster. This
can be an official F5 image from GCP Marketplace, or a customised image.
EOD
}

variable "disk_type" {
  type    = string
  default = "pd-ssd"
  validation {
    condition     = contains(["pd-balanced", "pd-ssd", "pd-standard"], var.disk_type)
    error_message = "The disk_type variable must be one of 'pd-balanced', 'pd-ssd', or 'pd-standard'."
  }
  description = <<EOD
The boot disk type to use with instances; can be 'pd-balanced', 'pd-ssd' (default),
or 'pd-standard'.
EOD
}

variable "disk_size_gb" {
  type        = number
  default     = null
  description = <<EOD
Use this flag to set the boot volume size in GB. If left at the default value
the boot disk will have the same size as the base image.
EOD
}

variable "f5_ssh_publickey" {
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
  description = <<-EOD
The path to the SSH public key to install on BIG-IP instances for admin access.
EOD
}

variable "sleep_time" {
  type        = string
  default     = "300s"
  description = "The number of seconds/minutes of delay to build into creation of BIG-IP VMs; default is 250. BIG-IP requires a few minutes to complete the onboarding process and this value can be used to delay the processing of dependent Terraform resources."
}

variable "ic_sb_network"  {
  type        = map(string)
  description = "List of VPC networks with default subnet parameters."
}
variable "ic-psc_sa_network"  {
  type        = map(string)
  description = "List of VPC networks with default subnet parameters."
}
variable "ic_neg_ings_network"  {
  type        = map(string)
  description = "List of VPC networks with default subnet parameters."
}
variable "ic_vip_network"  {
  type        = map(string)
  description = "List of VPC networks with default subnet parameters."
}
variable "ic_network" {
  type        = map(string)
  description = "List of VPC networks with default subnet parameters."
}

variable "prod-mgmt"  {
  type        = map(string)
  description = "List of VPC networks with default subnet parameters."
}

variable "prod-external"  {
  type        = map(string)
  description = "List of VPC networks with default subnet parameters."
}

variable "prod-internal"  {
  type        = map(string)
  description = "List of VPC networks with default subnet parameters."
}