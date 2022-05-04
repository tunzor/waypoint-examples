variable "registry_username" {
  type = string
  default = "AWS"
}

variable "registry_password" {
  type = string
  default = null
}

variable "registry_hostname" {
  type = string
  default = ""
}

project = "nodejs-example"
#runner {
#  profile = "secondary-cluster-odr"
#}
#

app "nodejs-example" {
  
  labels = {
    "service" = "example-nodejs",
    "env"     = "dev"
  }

  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "${var.registry_hostname}/example-nodejs"
        tag   = "${gitrefpretty()}"
        username = var.registry_username
        password = var.registry_password
        local = false
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
