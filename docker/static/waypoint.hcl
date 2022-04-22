project = "nginx-project"

# Labels can be specified for organizational purposes.
# labels = { "foo" = "bar" }

app "web" {
  runner {
    profile = "secondary-cluster-odr"
  }
  build {
    use "docker" {
    }
  }

  deploy {
    use "docker" {
    }
  }
}
