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
RUN gem install rails && rails new . tutorial --skip-bundle --database=postgresql

# Copy the main application.
COPY . ./

# Configure an entry point, so we don't need to specify
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]


# Installation Guide
#
# 1. Copy Rails files to local host
#
# 1) docker build . -t tutorial
# 2) docker run -ti --name tutorial_container tutorial:latest /bin/bash
# 3) neuer Terminal Tab
# 4) docker cp tutorial_container:/tutorial/. .              |||||||||            [https://stackoverflow.com/a/22050116]
