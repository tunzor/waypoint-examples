project = "example-nodejs"
runner {
  profile = "secondary-cluster-odr"
}
# test 

app "example-nodejs" {
  
  labels = {
    "service" = "example-nodejs",
    "env"     = "dev"
  }

  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "561656980159.dkr.ecr.ca-central-1.amazonaws.com/waypoint-ecr"
        tag   = "${gitrefpretty()}"
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
