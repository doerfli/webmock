FROM ruby:2.3.1

# see update.sh for why all "apt-get install"s have to stay as one long line
RUN apt-get update && apt-get install -y nodejs # build-essential

ENV HOME /webmock
ENV RAILS_ENV production
ENV DB_HOST mongo:27017

WORKDIR $HOME

# Install gems
ADD Gemfile* $HOME/
RUN gem update bundler
RUN bundle install --without development test

# Add the app code
ADD . $HOME
RUN bundle exec rake assets:precompile

# TODO move this to static file server, e.g. nginx
ENV RAILS_SERVE_STATIC_FILES true
ENV SECRET_KEY_BASE abcdefgh12345678

# Default command
CMD ["bundle", "exec", "rails", "server"]
