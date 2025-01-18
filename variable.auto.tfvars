infra_project_id    = "core-project-448210"
prod_int_project_id = "internet-project-448210"

environment    = "prod"
region         = "asia-southeast1"
zones          = ["asia-southeast1-a", "asia-southeast1-b"]
region_short   = "ap"
location_short = "sea01"
bu_short       = "its"

# F5 BIGIP
prefix       = "ap-sea01-gcp"
disk_size_gb = 256

ic_network = {
  "name" = "ic"
  "ip_range" = "10.239.16.0/27"
}
ic_sb_network = {
  "name" = "ic-sb"
  "ip_range" = "10.239.16.96/28"
}
ic-psc_sa_network = {
  "name" = "ic-psc-sa"
  "ip_range" = "10.239.16.112/28"
}
ic_neg_ings_network = {
  "name" = "ic-neg-ings"
  "ip_range" = "10.239.17.64/26"
}
ic_vip_network = {
  "name" = "ic-vip"
  "ip_range" = "10.6.56.0/27"
}

prod-mgmt=  {
  "name" = "prod-mgmt"
  "ip_range" = "10.239.17.32/28"
}

prod-external=  {
  "name" = "prod-external"
  "ip_range" = "10.239.17.0/28"
}

prod-internal=  {
 "name" = "prod-internal"
  "ip_range" = "10.239.17.16/28"
}