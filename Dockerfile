FROM ruby:2.3.3-alpine

RUN apk update && apk upgrade && \
    apk add --update nodejs git build-base libxml2 libxml2-dev libxml2-utils libxslt-dev tzdata && \
    rm -rf /var/cache/apk/*

ENV HOME /webmock
ENV RAILS_ENV production
# TODO move this to static file server, e.g. nginx
ENV RAILS_SERVE_STATIC_FILES true
ENV SECRET_KEY_BASE abcdefgh12345678
ENV DB_HOST mongo:27017
ENV GA_TRACKER_ID UA-11111111-1
ENV RECAPTCHA_PUBLIC_KEY 6Lc6BAAAAAAAAChqRbQZcn_yyyyyyyyyyyyyyyyy
ENV RECAPTCHA_PRIVATE_KEY 6Lc6BAAAAAAAAKN3DRm6VA_xxxxxxxxxxxxxxxxx

WORKDIR $HOME

# Install gems
ADD Gemfile* $HOME/
RUN gem update bundler
RUN bundle install --deployment --without development test

# Add the app code
ADD . $HOME
RUN bundle exec rake assets:precompile

# Default command
CMD ["bundle", "exec", "rails", "server"]
