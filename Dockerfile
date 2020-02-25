FROM ruby:2.5.7

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  libqt4-dev \
  libqtwebkit-dev \
  libqtwebkit4 \
  postgresql-client \
  imagemagick \
  curl

# Install NodeJS 10
RUN curl -sL https://deb.nodesource.com/setup_10.x > setup_10.x
RUN chmod +x setup_10.x
RUN ./setup_10.x
RUN apt install nodejs
RUN /usr/bin/nodejs -v
RUN npm -v

ENV APPROOT /fablabs
WORKDIR /$APPROOT

# Create application home. App server will need the pids dir so just create everything in one shot
RUN mkdir -p $APPROOT/tmp/pids

# Update Gems
#RUN gem update --system

# Bundler
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES 1
RUN gem install bundler
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

# Copy the Rails application into place
COPY . $APPROOT

RUN npm install

# Precompile assets here, so we don't have to do it inside a container + restart
RUN bin/rake assets:precompile

#CMD ["rails", "server", "-b", "0.0.0.0"]
#CMD ["bash","-c","rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"]

CMD ["bash","-c","bundle exec puma -C config/puma.rb"]
