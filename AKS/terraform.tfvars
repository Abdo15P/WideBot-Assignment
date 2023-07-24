name     = "WBotAssig"
location = "East US"

kubernetes_version         = "1.24.9"
agent_count                = 3
vm_size                    = "Standard_DS2_v2"
ssh_public_key             = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDpkQ1QTnWesa8RcoPW23WtnV1EYFoVSDNhT4EOi+F/laiMei7OOCqRsBJkJvbiQVLif0B1OIqQ0PD5lqvhgxNcq+HXg1JVhFR0MI8GlQv8c/G8iEp83Zw84GqfyaoEWpL2A4o2jTKO0B5J7D1PE0wCScVhAdpWX35SQ4e19QVmdhrWQUnANt/Yuo3RVdwjWCwjoOdzAVDX6d3nEgpal6L2A/TUbY/LxtaQzG+p32c2miBumoMbQo+CFHj3rT7v/yRV1Uenakdni3LkuvlSpXLRBlQdgeixnthLNjut3VFXCqkqFfli6H1zTEI21dnGEnycaZ6saNay2zfbJ0CFaXwBpHCGIfcRyZRLm2eW5+6ytZNOs5/WF9H67SMRQqhBmMGmXg0XTcjN/RIdKWIakW36yldqFF9jMdWl7PBCvMzz5dRG9Gc2HZMHIl6pVm6yZJLxmuI19CmgcZ02+cJrq0NnPKfktGVuOeYmfYzya6TA3Wvd80sliEZVxHPof5psq0k= abdelrahman@LAPTOP-8NOIG3IU"
aks_admins_group_object_id = "3b3a893f-dd1a-49a2-a9d0-6501411000cd"

addons = {
  oms_agent                   = true
  ingress_application_gateway = true
}