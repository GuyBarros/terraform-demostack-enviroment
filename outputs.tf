////////////////////// Main //////////////////////////

output "A_Welcome_Message" {
  value = <<WELCOMEMESSAGE

ooooo   ooooo                    oooo         o8o    .oooooo.
`888'   `888'                    `888         `"'   d8P'  `Y8b
 888     888   .oooo.    .oooo.o  888 .oo.   oooo  888           .ooooo.  oooo d8b oo.ooooo.
 888ooooo888  `P  )88b  d88(  "8  888P"Y88b  `888  888          d88' `88b `888""8P  888' `88b
 888     888   .oP"888  `"Y88b.   888   888   888  888          888   888  888      888   888
 888     888  d8(  888  o.  )88b  888   888   888  `88b    ooo  888   888  888      888   888
o888o   o888o `Y888""8o 8""888P' o888o o888o o888o  `Y8bood8P'  `Y8bod8P' d888b     888bod8P'
                                                                                    888
                                                                                   o888o


 |.--------_--_------------_--__--.|
 ||    /\ |_)|_)|   /\ | |(_ |_   ||
 ;;`,_/``\|__|__|__/``\|_| _)|__ ,:|
((_(-,-----------.-.----------.-.)`)
 \__ )        ,'     `.        \ _/
 :  :        |_________|       :  :
 |-'|       ,'-.-.--.-.`.      |`-|
 |_.|      (( (*  )(*  )))     |._|
 |  |       `.-`-'--`-'.'      |  |
 |-'|        | ,-.-.-. |       |._|
 |  |        |(|-|-|-|)|       |  |
 :,':        |_`-'-'-'_|       ;`.;
  \  \     ,'           `.    /._/
   \/ `._ /_______________\_,'  /
    \  / :   ___________   : \,'
     `.| |  |           |  |,'
       `.|  |           |  |
         |  | HashiCorp |  |

WELCOMEMESSAGE
}

// Primary
output "Primary_Region" {
  value = var.primary_region
}

output "Primary_Consul" {
  value = module.aws_primarycluster.consul_ui
}

output "Primary_Nomad" {
  value = module.aws_primarycluster.nomad_ui
}

output "Primary_Vault" {
  value = module.aws_primarycluster.vault_ui
}

output "Primary_Fabio" {
  value = module.aws_primarycluster.fabio_lb
}

output "Primary_Traefik" {
  value = module.aws_primarycluster.traefik_lb
}

output "Primary_servers_nodes" {
  value = module.aws_primarycluster.servers
}

output "Primary_workers_Nodes" {
  value = module.aws_primarycluster.workers
}



output "DNS_aws_sub_zone_id" {
  value = module.dns.aws_sub_zone_id
}
