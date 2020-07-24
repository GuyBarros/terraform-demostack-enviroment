
//--------------------------EMEA-SE_PLAYGROUND-2019-----------------------------------------
# Using a single workspace:
/*
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "emea-se-playground-2019"
    workspaces {
      name = "Guy-Demostack-V2"
    }
  }
}
*/

module "tls"{
source               = "git::https://github.com/GuyBarros/terraform-tls-certificate.git?ref=0.0.2"
  validity_period_hours  = var.validity_period_hours
  organization           = var.organization
  is_ca_certificate      = var.is_ca_certificate
  ecdsa_curve            = var.ecdsa_curve
  common_name            = var.common_name
  algorithm              = var.algorithm
}

module "dns" {
source               = "git::https://github.com/lhaig/terraform-dns-multicloud.git?ref=0.2.1"
 hosted-zone           = var.hosted-zone
  # AWS_ACCESS_KEY_ID     = var.AWS_ACCESS_KEY_ID
  # AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
  # ARM_SUBSCRIPTION_ID   = var.ARM_SUBSCRIPTION_ID
  # ARM_TENANT_ID         = var.ARM_TENANT_ID
  # ARM_CLIENT_ID         = var.ARM_CLIENT_ID
  # ARM_CLIENT_SECRET     = var.ARM_CLIENT_SECRET
  # GOOGLE_CREDENTIALS    = var.GOOGLE_CREDENTIALS
  owner                 = var.owner
  namespace             = var.namespace
  created-by            = var.created-by
  create_aws_dns_zone   = var.create_aws_dns_zone
  create_azure_dns_zone = var.create_azure_dns_zone
  create_gcp_dns_zone   = var.create_gcp_dns_zone
  gcp_project           = var.gcp_project
  gcp_region            = var.gcp_region
}

module "aws_cluster" {
       providers = {
        aws = aws.demostack
         }
  depends_on           = [module.dns,module.tls]
  // count                = var.count_aws_demostack
  source               = "git::https://github.com/GuyBarros/terraform-aws-demostack.git//modules?ref=0.0.6"
  owner                = var.owner
  region               = var.primary_region
  namespace            = var.primary_namespace
  public_key           = var.public_key
  servers              = var.servers
  workers              = var.workers
  vaultlicense         = var.vaultlicense
  consullicense        = var.consullicense
  nomadlicense         = var.nomadlicense
  enterprise           = var.enterprise
  consul_url           = var.consul_url
  consul_ent_url       = var.consul_ent_url
  fabio_url            = var.fabio_url
  nomad_url            = var.nomad_url
  nomad_ent_url        = var.nomad_ent_url
  cni_plugin_url       = var.cni_plugin_url
  vault_url            = var.vault_url
  vault_ent_url        = var.vault_ent_url
  created-by           = var.created-by
  sleep-at-night       = var.sleep-at-night
  TTL                  = var.TTL
  vpc_cidr_block       = var.vpc_cidr_block
  cidr_blocks          = var.cidr_blocks
  instance_type_server = var.instance_type_server
  instance_type_worker = var.instance_type_worker
  # zone_id              = module.dns.aws_sub_zone_id[0]
  zone_id              = "Z3ABWIDSN7J1TI"
  run_nomad_jobs       = var.run_nomad_jobs
  host_access_ip       = var.host_access_ip
  primary_datacenter   = var.primary_namespace
  ca_key_algorithm      = module.tls.ca_key_algorithm
  ca_private_key_pem    = module.tls.ca_private_key_pem
  ca_cert_pem           = module.tls.ca_cert_pem
  consul_join_tag_value = "${var.namespace}-${module.tls.consul_join_tag_value}"
  consul_gossip_key     = module.tls.consul_gossip_key
  consul_master_token   = module.tls.consul_master_token
  nomad_gossip_key      = module.tls.nomad_gossip_key
}
