FROM ruby:2.6.10-bullseye

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  libqt5webkit5-dev \
  postgresql-client \
  imagemagick \
  curl

# Install NodeJS
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/* \
    && /usr/bin/node -v \
    && npm -v

ENV APPROOT /fablabs
WORKDIR /$APPROOT

# Create application home. App server will need the pids dir so just create everything in one shot
RUN mkdir -p $APPROOT/tmp/pids

COPY Gemfile Gemfile.lock .ruby-version $APPROOT/

# Bundler
RUN gem install bundler
RUN bundle install

#Without yarn we cannot run rake assets:precompile'
RUN npm install yarn -g

COPY package.json yarn.lock $APPROOT/
RUN yarn install

# Copy the Rails application into place
COPY . $APPROOT

# Precompile assets here, so we don't have to do it inside a container + restart
#RUN bin/rake assets:precompile
# Precompile started erroring 2021-01-18 - for now we precompile in scripts/deploy.sh

# Add a script to be executed every time the container starts.
# TODO: use the entryscript to WAIT for the other containers, so the app survives restart?
# Right now we have to start containers in correct order and wait for services to be ready
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD [ "bin/rails", "server", "-p", "3000", "-b", "0.0.0.0" ]
