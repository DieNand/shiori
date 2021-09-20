# syntax=docker/dockerfile:1
FROM ruby:2.7.2
RUN apt-get update -qq
COPY ./ ./myapp
WORKDIR /myapp
RUN gem install bundler -v 2.2.27
RUN bundle install

# Configure the main process to run when running the image
CMD ["bundle", "exec", "shiori"]
