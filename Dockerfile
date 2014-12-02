FROM ruby:2.1.5
MAINTAINER YANKE Guo<me@yanke.io>

# Nodejs for ExecJS
RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Install database driver for production
RUN apt-get update && apt-get install -y mysql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Prepare folder
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# ENV and EXPOSE
ENV RAILS_ENV production
EXPOSE 3000

# Prepare Gemfile ahead
COPY Gemfile /usr/src/app

# Bundle install ahead
RUN bundle install --without development test --jobs 3

# Prepare code
COPY . /usr/src/app

# Precompile assets
RUN bundle exec rake assets:precompile
