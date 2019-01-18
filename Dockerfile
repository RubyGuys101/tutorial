# used to build images which are deployed to production
FROM ruby:2.5
MAINTAINER alex@safing.io

# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
RUN apt-get update && apt-get install -y build-essential

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p /tutorial
WORKDIR /tutorial

# Copy the Gemfile & Gemfile.lock and install the RubyGems.
# This is a separate step so the dependencies will be cached
# unless changes to one of those two files are made.
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Copy the main application.
COPY . ./

# Configure an entry point, so we don't need to specify
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]
