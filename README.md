# Welcome to the Social Worker Recording Tool Prototype

Prototype link: https://social-worker-recording-tool-dev.london.cloudapps.digital/

## Docker dependencies

1. Docker
2. Docker-compose

## Installing the repo and running with Docker

`$ git clone git@github.com:DFE-Digital/csc-swr-prototype.git`
`$ cd csc-swr-prototype`
`$ docker-compose up --build`

## If you want to run it locally without docker
## Prerequisites

- Ruby 2.7.1
- PostgreSQL
- NodeJS 14.13.x
- Yarn 1.12.x

## Setting up the app in development

1. Run `bundle install` to install the gem dependencies
2. Run `yarn` to install node dependencies
3. Run `bin/rails db:setup` to set up the database development and test schemas, and seed with test data
4. Run `bundle exec rails server` to launch the app on http://localhost:3000
5. Run `./bin/webpack-dev-server` in a separate shell for faster compilation of assets

# Setting up couchDB for persisting offline data

Download couchDB locally from <a href="https://couchdb.apache.org/">here</a> (this example was created with CouchDB 3.1.1)

On downloading, you can use the CouchDB GUI to open couchDB. Create an admin account called `admin`, and give it a password `password`. This is essential to make sure querying the database is successful with the endpoints used in the examples. 

On running couchDB, you should be able to visit http://127.0.0.1:5984/ to get a welcome message from couch. If you dont, its not running. 
## Running specs, linter(without auto correct) and annotate models and serializers
```
bundle exec rake
```

## Running specs
```
bundle exec rspec
```

## Linting

It's best to lint just your app directories and not those belonging to the framework, e.g.

```bash
bundle exec rubocop app config db lib spec Gemfile --format clang -a

or

bundle exec scss-lint app/webpacker/styles
```

## Deploying on GOV.UK PaaS

### Prerequisites

- Your department, agency or team has a GOV.UK PaaS account
- You have a personal account granted by your organisation manager
- You have downloaded and installed the [Cloud Foundry CLI](https://github.com/cloudfoundry/cli#downloads) for your platform

### Deploy

1. Run `cf login -a api.london.cloud.service.gov.uk -u USERNAME`, `USERNAME` is your personal GOV.UK PaaS account email address
2. Run `bundle package --all` to vendor ruby dependencies
3. Run `yarn` to vendor node dependencies
4. Run `bundle exec rails webpacker:compile` to compile assets
5. Run `cf push` to push the app to Cloud Foundry Application Runtime

Check the file `manifest.yml` for customisation of name (you may need to change it as there could be a conflict on that name), buildpacks and eventual services (PostgreSQL needs to be [set up](https://docs.cloud.service.gov.uk/deploying_services/postgresql/)).

The app should be available at https://govuk-rails-boilerplate.london.cloudapps.digital
