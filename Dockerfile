FROM ruby:2.3.1

# see update.sh for why all "apt-get install"s have to stay as one long line
RUN apt-get update && apt-get install -y nodejs # build-essential

ENV HOME /home/rails/webapp
ENV RAILS_ENV production

WORKDIR $HOME

# Install gems
ADD Gemfile* $HOME/
RUN gem update bundler
RUN bundle install --without development test

# Add the app code
ADD . $HOME
RUN MONGO_PORT_27017_TCP_ADDR=localhost MONGO_PORT_27017_TCP_PORT=27017 bundle exec rake assets:precompile

# TODO move this to static file server, e.g. nginx
ENV RAILS_SERVE_STATIC_FILES true
ENV SECRET_KEY_BASE abcdefgh12345678

# Default command
CMD ["bundle", "exec", "rails", "server"]
