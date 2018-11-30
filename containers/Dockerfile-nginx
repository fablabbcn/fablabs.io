# build from the official Nginx image
FROM nginx

MAINTAINER Silvia Puglisi <silvia@fablabbcn.org>

WORKDIR /$APPROOT
ENV APPROOT fablabs

# install essential Linux packages
RUN apt-get update -qq && apt-get -y install apache2-utils

# establish where Nginx should look for files
ENV RAILS_ROOT /fablabs

# Set our working directory inside the image
WORKDIR $RAILS_ROOT

# create log directory
RUN mkdir log

# copy our Nginx config template
COPY /containers/nginx.conf /tmp/fablabs.nginx

# substitute variable references in the Nginx config template for real values from the environment
# put the final config in its place
RUN envsubst $RAILS_ROOT < /tmp/fablabs.nginx > /etc/nginx/conf.d/default.conf

# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "nginx", "-g", "daemon off;" ]
