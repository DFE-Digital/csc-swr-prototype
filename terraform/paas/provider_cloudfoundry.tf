provider "cloudfoundry" {
  api_url  = "https://api.london.cloud.service.gov.uk"
  user     = var.user
  password = var.password
}

data "cloudfoundry_org" "my_org" {
  name = "dfe-childrens-social-care-services"
}

data "cloudfoundry_space" "recording-alpha-development" {
  name = "social-worker-recording-tool"
  org = data.cloudfoundry_org.my_org.id
}

data "cloudfoundry_service" "postgres" {
  name = "postgres"
}

resource "cloudfoundry_service_instance" "postgres" {
  name = "recording-development-db"
  space = data.cloudfoundry_space.recording-alpha-development.id
  service_plan = data.cloudfoundry_service.postgres.service_plans["medium-11"]
}

data "cloudfoundry_domain" "dev" {
  name = "london.cloudapps.digital"
}

resource "cloudfoundry_route" "dev_route" {
  domain = data.cloudfoundry_domain.dev.id
  space = data.cloudfoundry_space.recording-alpha-development.id
  hostname = "social-worker-recording-tool-dev"
}

resource "cloudfoundry_app" "social-worker-recording-tool-dev" {
  name = "social-worker-recording-tool-dev"
  space = data.cloudfoundry_space.recording-alpha-development.id
  docker_image = var.csc_docker_repo
  service_binding {
    service_instance = cloudfoundry_service_instance.postgres.id
  }
  routes {
    route = cloudfoundry_route.dev_route.id
  }
}
