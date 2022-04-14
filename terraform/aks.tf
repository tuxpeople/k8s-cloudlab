resource "azurerm_resource_group" "k8s" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_public_ip" "aks_lb_ingress" {
  name                = "pip-${var.cluster_name}-aks-lb-ingress"
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.aks.kubernetes_version

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  default_node_pool {
    name                = "linux"
    vm_size             = var.aks.node_pool.vm_size
    type                = "VirtualMachineScaleSets"
    availability_zones  = var.aks.availability_zones
    enable_auto_scaling = true
    min_count           = var.aks.node_pool.agent_min_count
    max_count           = var.aks.node_pool.agent_max_count
    vnet_subnet_id      = azurerm_subnet.private.id
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet"
  }

  tags = {
    Environment = "Cloudlab"
  }
}