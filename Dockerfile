FROM ruby:2.5.3-stretch

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  libqt4-dev \
  libqtwebkit-dev \
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

# Prevent bundler warnings; ensure that the bundler version executed is >= that which created Gemfile.lock
RUN gem install bundler

# Finish establishing our Ruby environment
#RUN gem install nokogiri

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES 1

#RUN gem install capybara-webkit -v '1.10.1'

#RUN gem install kgio -v '2.9.2' --platform=ruby --verbose
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

ADD bower.json bower.json

RUN npm install -g bower
RUN echo '{ "allow_root": true }' > /root/.bowerrc
RUN bower install


# Copy the Rails application into place
#COPY . $APPROOT


# OR call puma? prod is currently using unicorn
#CMD ["rails", "server", "-b", "0.0.0.0"]

#CMD ["bash","-c","rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"]

CMD ["bash","-c","bundle exec puma -C config/puma.rb"]
