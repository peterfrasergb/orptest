locals {
  tags = {
    eai        = "3535702"
    created-by = "terraform"
  }
  ou_path = "corp.ds.fedex.com/fxi/azure/northeurope"
  environments = {
    nonprod = {
      uds_control_server = {
        hosts              = toset(["031", "032", "033", "034", "035"]) //Adding nonprod Vm's
        vm_type            = "Windows"
        vm_sku             = "Standard_D4s_v3"
        maintenance_window = "EMEA-SVR-PATCHING-SUN-BATCH1"
        server_role        = "uDS-Control-Server"
        host_name          = "FXIAZNEURNS" //base hostname, module will compute node num as assigned to ou
        source_image = {
          id        = null
          offer     = "WindowsServer",
          publisher = "MicrosoftWindowsServer",
          sku       = "2019-Datacenter",
          version   = "latest"
        }
        vsts_config = {
          account_name     = "fedex-pande"
          team_project     = "pande-prod-prod-project"
          deployment_group = "Global_Pool"
        }
      }
    }
    prod = { //naming prd for now as existing infra for prod
      uds_control_server = {
        hosts = toset([ // List of hosts to allow for configuration / deletion etc of select instances. syntax. hostnum = vm_id (where vm_id is used as uid in hostname)
          "090", "091", "092", "093", "094", "095", "096", "097", "098", "099", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110",
          "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129","125", "126", "127", 
          "128", "129"

        ])
        vm_type            = "Windows"
        vm_sku             = "Standard_D4s_v3"
        maintenance_window = "EMEA-SVR-PATCHING-SUN-BATCH1"
        server_role        = "uDS-Control-Server"
        host_name          = "FXIAZNEURPS" //base hostname, module will compute node num as assigned to ou
        source_image = {
          id        = null
          offer     = "WindowsServer",
          publisher = "MicrosoftWindowsServer",
          sku       = "2019-Datacenter",
          version   = "latest"
        }
        vsts_config = {
          account_name     = "fedex-pande"
          team_project     = "pande-prod-prod-project"
          deployment_group = "Global_Pool"
        }
      }
    }
  }
  dns_zone = var.dns_zone
}
