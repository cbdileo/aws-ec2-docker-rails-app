# Docker image to use, more info at https://hub.docker.com/_/ruby
FROM ruby:2.7.1

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs && apt install yarn -y

# Set an environment variable where the Rails app is installed to inside of Docker image:
ENV RAILS_ROOT /var/www/aws-ec2-docker-rails-app

# Run the mkdir command to create app directory
RUN mkdir -p $RAILS_ROOT

# Set working directory, where the commands will be ran:
WORKDIR $RAILS_ROOT

# Adding gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

# Install bundler
RUN gem install bundler -v 2.1.4

# Run bundle install
RUN bundle install --jobs 20 --retry 5

# Adding project files
COPY . .

# Precompile assets
RUN RAILS_ENV=production SECRET_KEY_BASE=`bundle exec rake secret` bundle exec rake assets:precompile

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the Rails application using Puma
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
