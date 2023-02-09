
data "databricks_node_type" "smallest" {
  local_disk = true
}


data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

resource "databricks_cluster" "single_node" {
  cluster_name            = "Single Node - ${var.environment}"
  node_type_id            = data.databricks_node_type.smallest.id
  spark_version           = data.databricks_spark_version.latest_lts.id
  autotermination_minutes = 60

  spark_conf = {
    "spark.databricks.cluster.profile" : "singleNode"
    "spark.master" : "local[*]"
  }

  custom_tags = {
    "ResourceClass" = "SingleNode"
  }
}

resource "databricks_library" "eventhubs" {
  cluster_id = databricks_cluster.single_node.id
  maven {
    coordinates = "com.microsoft.azure:azure-eventhubs-spark_2.12:2.3.18"
  }
}

resource "databricks_token" "pat" {
  comment          = "azure-data-factory-from-terraform"
  lifetime_seconds = 100 * (24 * 60 * 60) // 100 days
}
