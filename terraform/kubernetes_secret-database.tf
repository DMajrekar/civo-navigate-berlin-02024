resource "kubernetes_secret" "database_access" {
    metadata {
      name = "database-access"
      namespace = "default"
    }

    data = {
        "username": civo_database.database.username
        "password": civo_database.database.password
        "host": civo_database.database.endpoint
    }
}
