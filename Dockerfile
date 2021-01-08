FROM ruby:2.7.2
WORKDIR /code
COPY . /code
RUN bundle install
CMD ["rails", "server", "-b", "0.0.0.0"]
