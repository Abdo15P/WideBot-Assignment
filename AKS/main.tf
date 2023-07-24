terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.66.0"
    }
  }
}

# Configure the MicrosoftAzure Provider
provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "WBAssig"
    storage_account_name = "wbsaaa"
    container_name       = "tfstate"
    key                  = "aks-terraform.tfstate"
  }
}

data "azurerm_resource_group" "rg" {
  name = "${var.name}-rg"
}

data "azurerm_subnet" "akssubnet" {
  name                 = "aks"
  virtual_network_name = "${var.name}-vnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "appgwsubnet" {
  name                 = "appgw"
  virtual_network_name = "${var.name}-vnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
}

/* data "azurerm_log_analytics_workspace" "workspace" {
  name                = "${var.name}-la"
  resource_group_name = data.azurerm_resource_group.rg.name
} */

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "${var.name}aks"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "${var.name}dns"
  kubernetes_version  = var.kubernetes_version
  node_resource_group = "${var.name}-node-rg"

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = var.ssh_public_key
    }
  }

  default_node_pool {
    name                 = "agentpool"
    node_count           = var.agent_count
    vm_size              = var.vm_size
    vnet_subnet_id       = data.azurerm_subnet.akssubnet.id
    type                 = "VirtualMachineScaleSets"
    orchestrator_version = var.kubernetes_version
  }

  identity {
    type = "SystemAssigned"
  }
/* 
  oms_agent {
    log_analytics_workspace_id = data.azurerm_log_analytics_workspace.workspace.id
  } */

  ingress_application_gateway {
    subnet_id = data.azurerm_subnet.appgwsubnet.id
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "azure"
  }

  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = [var.aks_admins_group_object_id]
  }

}

data "azurerm_resource_group" "node_resource_group" {
  name = azurerm_kubernetes_cluster.k8s.node_resource_group
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
}

resource "azurerm_role_assignment" "aks-role" {
  scope                = data.azurerm_resource_group.node_resource_group.id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id

  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
}

data "azurerm_container_registry" "acr" {
  name                = "${var.name}acr"
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  scope                = data.azurerm_resource_group.rg.id
  role_definition_name = "acrpull"
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
}
