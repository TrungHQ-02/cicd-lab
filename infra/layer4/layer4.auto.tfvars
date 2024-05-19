

resource_configs = {
  eks_configs = {
    cluster_name = "trunghq-cluster"
    region       = "us-west-1"
  }

}

user_defined_tags = {
  "Layer"       = 3
  "Description" = "Provisionin eks cluster"
}
