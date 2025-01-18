module "mgmt_internal_vpc" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/net-vpc"
  project_id = var.infra_project_id
  name       = "${var.region_short}-${var.bu_short}-${var.environment}-mgmt-internal-vpc"
  # routing_mode = "REGIONAL"
  subnets = [
    {
      ip_cidr_range = "10.239.16.144/28"
      name          = "${var.region_short}-${var.location_short}-${var.bu_short}-${var.environment}-mgmt-internal-sub"
      region        = var.region
      
      }
    ]
}

module "prod_ic_vpc" {
  source  = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/net-vpc"
  #version = "~> 2.4"

  project_id   =var.infra_project_id
  name = "${var.region_short}-${var.bu_short}-prod-${var.ic_network["name"]}-vpc"
  routing_mode = "REGIONAL"

  #delete_default_internet_gateway_routes = "true"

  subnets = [
    {
      name              = "${var.region_short}-${var.location_short}-${var.bu_short}-prod-${var.ic_network["name"]}-sub"
      ip_cidr_range                 = var.ic_network["ip_range"]
      region             = var.region
      subnet_private_access     = "true"

      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_5_SEC"
      subnet_flow_logs_sampling = 0.5
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
    },
  /***********
    Agiee Infra Subnets. Comments only during the RFC
          --------------------------------------------
  ****/
    {
      name              = "${var.region_short}-${var.location_short}-${var.bu_short}-prod-${var.ic_sb_network["name"]}-sub"
      ip_cidr_range                 = var.ic_sb_network["ip_range"]
      region             = var.region
      subnet_private_access     = "true"

      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_5_SEC"
      subnet_flow_logs_sampling = 0.5
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
    },
    {
      name              = "${var.region_short}-${var.location_short}-${var.bu_short}-prod-${var.ic-psc_sa_network["name"]}-sub"
      ip_cidr_range                 = var.ic-psc_sa_network["ip_range"]
      region             = var.region
      private_access     = "true"
      purpose            = "PRIVATE_SERVICE_CONNECT"
      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_5_SEC"
      subnet_flow_logs_sampling = 0.5
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
    },
    {
      name              = "${var.region_short}-${var.location_short}-${var.bu_short}-prod-${var.ic_neg_ings_network["name"]}-sub"
      ip_cidr_range                = var.ic_neg_ings_network["ip_range"]
      region             = var.region
      private_access     = "false"
	    purpose				    = "REGIONAL_MANAGED_PROXY"
      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_5_SEC"
      subnet_flow_logs_sampling = 0.5
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
    },
    {
      name              = "${var.region_short}-${var.location_short}-${var.bu_short}-prod-${var.ic_vip_network["name"]}-sub"
      ip_cidr_range                 = var.ic_vip_network["ip_range"]
      region             = var.region
      subnet_private_access     = "true"

      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_5_SEC"
      subnet_flow_logs_sampling = 0.5
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
    }
  ]
/**
  secondary_ranges = {
    ap-sea01-its-prod-ic-sub = [
      {
        range_name    = "ap-sea01-its-prod-ic-sip"
        ip_cidr_range = "10.239.16.192/28"
      }
    ]
  }**/
}

resource "google_compute_firewall" "prod-ic_fwr_i_any" {
  name    = "${var.region_short}-prod-ic-fwr-i-any"
  project = var.infra_project_id
  network = "${var.region_short}-${var.bu_short}-prod-ic-vpc"

 allow {
     protocol = "all"
     
    }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "prod-mgmt-internal_fwr_i_any" {
  name    = "${var.region_short}-prod-mgmt-internal-fwr-i-any"
  project = var.infra_project_id
  network = "${var.region_short}-${var.bu_short}-prod-mgmt-internal-vpc"
  allow {
     protocol = "all"
     
    }
  source_ranges = ["0.0.0.0/0"]
  }


