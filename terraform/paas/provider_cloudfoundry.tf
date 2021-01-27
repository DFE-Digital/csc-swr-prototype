provider "cloudfoundry" {
  api_url  = "https://api.london.cloud.service.gov.uk"
  user     = var.user
  password = var.password
}

data "cloudfoundry_org" "my_org" {
  name = "dfe"
}

data "cloudfoundry_space" "social-worker-recording-tool" {
  name = "social-worker-recording-tool"
  org = data.cloudfoundry_org.my_org.id
}

data "cloudfoundry_service" "postgres" {
  name = "postgres"
}

resource "cloudfoundry_service_instance" "postgres" {
  name = "recording-development-db"
  space = data.cloudfoundry_space.social-worker-recording-tool.id
  service_plan = data.cloudfoundry_service.postgres.service_plans["medium-11"]
}

data "cloudfoundry_domain" "dev" {
  name = "london.cloudapps.digital"
}

resource "cloudfoundry_route" "dev_route" {
  domain = data.cloudfoundry_domain.dev.id
  space = data.cloudfoundry_space.social-worker-recording-tool.id
  hostname = "social-worker-recording-tool-develop"
}

resource "cloudfoundry_app" "social-worker-recording-tool-develop" {
  name = "social-worker-recording-tool-develop"
  space = data.cloudfoundry_space.social-worker-recording-tool.id
  docker_image = var.csc_docker_repo
  service_binding {
    service_instance = cloudfoundry_service_instance.postgres.id
  }
  routes {
    route = cloudfoundry_route.dev_route.id
  }
}
