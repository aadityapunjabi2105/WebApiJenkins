terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
  required_version = ">=1.0.0"
}

provider "azurerm" {
  subscription_id = "39007855-6a12-4f14-ac77-13c3310b2789"
  tenant_id       = "f56c6c65-c045-4485-9192-aa84a2951b0e"
  features {}
}

resource "azurerm_resource_group" "web_rg" {
  name     = "rick23"
  location = "Central India"
}

resource "azurerm_service_plan" "Web_plan" {
  name                = "webPlan01"
  location            = azurerm_resource_group.web_rg.location
  resource_group_name = azurerm_resource_group.web_rg.name
  os_type             = "Windows"

  sku_name = "B1"

}
resource "azurerm_app_service" "web_app" {
  name                = "app234"
  location            = azurerm_resource_group.web_rg.location
  resource_group_name = azurerm_resource_group.web_rg.name
  app_service_plan_id = azurerm_service_plan.Web_plan.id

  site_config {
    dotnet_framework_version = "v6.0" # Change to your preferred version
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "0"
  }

  https_only = true
}
