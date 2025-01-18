/*module peering{
    source=".//module/peering"
    net_link1=data.google_compute_network.ap-its-prod-mgmt-internal-vpc.selflink
    net_link2=data.google_compute_network.ap-its-prod-ic-vpc.selflink
}*/

net_link1=data.google_compute_network.ap-its-prod-mgmt-internal-vpc.self_link
