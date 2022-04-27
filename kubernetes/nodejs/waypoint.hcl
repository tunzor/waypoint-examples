project = "example-nodejs"
# test   


app "example-nodejs" {
  runner {
    profile = "odrsecondary"
  }
  labels = {
    "service" = "example-nodejs",
    "env"     = "dev"
  }

  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "ttl.sh/example-nodejs-${gitrefpretty()}"
        tag   = "5m"
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
