project = "example-nodejs"
# test   


app "example-nodejs" {
  runner {
    profile = "secondary-cluster-odr"
  }
  labels = {
    "service" = "example-nodejs",
    "env"     = "dev"
  }

  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "ttl.sh/example-nodejs-v2"
        tag   = "1h"
        local = true
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
