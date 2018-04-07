FROM ruby:2.5
MAINTAINER Hidenori Miyoshi miyohide@gmail.com

## I wrote this file with reference to https://github.com/yokawasa/ci-demo-rails-app/blob/master/Dockerfile
## and https://www.slideshare.net/yokawasa/web-app-for-containers-mysqlrails-80754390

RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends vim openssh-server \
    && apt-get install -y build-essential libpq-dev nodejs \
    && apt-get install -y nginx

WORKDIR /myapp

## Setup all the configfiles
COPY railsapp/bin/init_container.sh /bin/init_container.sh
RUN chmod 777 /bin/init_container.sh \
    && echo "root:Docker!" | chpasswd \
    && rm -f /etc/nginx/conf.d/*

COPY railsapp/config/nginx.conf /etc/nginx/conf.d/myapp.conf
COPY railsapp/config/sshd_config /etc/ssh/sshd_config
COPY railsapp /myapp

## Install for Rails app
RUN gem install bundler --pre \
    && bundle install --path /myapp/vendor/bundle

EXPOSE 8080 2222
ENV PORT 8080
ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance

# Start Server
ENTRYPOINT ["/bin/init_container.sh"]
