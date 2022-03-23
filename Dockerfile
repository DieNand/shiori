# syntax=docker/dockerfile:1
FROM ruby:2.7.2
COPY ./ ./myapp
WORKDIR /myapp
RUN apt-get update -qq && \
    gem install bundler -v 2.2.27 && \
    bundle install && \
    rm -rf /var/lib/apt/lists/*

# Configure the main process to run when running the image
CMD ["bundle", "exec", "shiori"]
