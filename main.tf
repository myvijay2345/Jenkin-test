module "prod_ic_vpc1" {
  source  = "terraform-google-modules/network/google"
 # version = "~> 2.4"

  project_id   = "core-project-448210"
  network_name = "new-prod-ic-vpc"
  routing_mode = "REGIONAL"

  delete_default_internet_gateway_routes = "true"

  subnets = [
    {
      subnet_name               = "new-prod-ic-vpc-sub"
      subnet_ip                 = "10.11.2.0/24"
      subnet_region             = "asia-southeast1"
      subnet_private_access     = "true"
      description               = "This is PSC subnet "
      purpose                   = "PRIVATE_SERVICE_CONNECT"

    }
''',
    {
      subnet_name               = "new-prod-ic-vpc-sub-1"
      subnet_ip                 = "10.11.3.0/24"
      subnet_region             = "asia-southeast1"
      subnet_private_access     = "false"
      description               = "This is neg subnet for proxy only "
      purpose                   = "REGIONAL_MANAGED_PROXY"
      role                      = "ACTIVE"

    }'''
]
}
