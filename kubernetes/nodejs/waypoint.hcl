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
        image = "public.ecr.aws/t9f2n2b5/wp-test/example-nodejs"
        tag   = "${gitrefpretty()}"
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
