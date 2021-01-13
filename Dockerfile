FROM ruby:2.7.2-alpine

ENV RAILS_ENV=production \
    NODE_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_LOG_TO_STDOUT=true

WORKDIR /app

RUN apk add --update build-base postgresql-dev tzdata nodejs yarn

RUN gem install bundler:2.1.4 --no-document

RUN cp /usr/share/zoneinfo/Europe/London /etc/localtime && \
  echo "Europe/London" > /etc/timezone

COPY Gemfile* .ruby-version ./

RUN bundle install --no-binstubs --retry=5 --jobs=4

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile

COPY . .

EXPOSE 3000

RUN SECRET_KEY_BASE=`bundle exec rake secret` bundle exec rake assets:precompile

CMD bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0
