variable "registry_username" {
  type = string
  default = "AWS"
}

variable "registry_password" {
  type = string
  default = var.repo_pass
}
#test

project = "example-nodejs"
runner {
  profile = "secondary-cluster-odr"
}

app "example-nodejs" {
  
  labels = {
    "service" = "example-nodejs",
    "env"     = "dev"
  }

  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "example-nodejs"
        tag   = "${gitrefpretty()}"
        username = var.registry_username
        password = var.registry_password
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
