variable "registry_username" {
  type = string
  default = "AWS"
}

variable "registry_password" {
  type = string
  sensitive = true
  default = ""
}

variable "registry_hostname" {
  type = string
  default = ""
}

project = "nodejs-example"
#runner {
#  profile = "secondary-cluster-odr"
#}  


app "nodejs-example" {
  
  labels = {
    "service" = "example-nodejs",
    "env"     = "dev"
  }

  build {
    use "pack" {}
#     registry {
#       use "docker" {
#         image = "${var.registry_hostname}/waypoint-ecr"
#         #tag   = "${gitrefpretty()}"
#         tag = "latest"
#         username = var.registry_username
#         password = var.registry_password
#         local = false
#       }
#     }
    registry {
        use "aws-ecr" {
          region = "ca-central-1"
          repository = "waypoint-ecr"
          tag = "latest"
          auth {
            hostname = var.registry_hostname
            username = var.registry_username
            password = var.registry_password
          }
        }
    }
  }

  deploy {
    use "kubernetes" {
      probe_path = "/"
    }
  }

  release {
    use "kubernetes" {
      // Sets up a load balancer to access released application
      load_balancer = true
      port          = 3000
    }
  }
}
