# Ruby 3.1.2 on Rails 7
FROM ruby:3.1.2

ARG UID=1000
ARG GID=1000

#RUN apt-get update -qq && apt-get install -y sudo nodejs postgresql-client
RUN apt-get update -qq && apt-get install -y sudo postgresql-client

# コンテナ内の管理権限を、buildした際のユーザーの権限と同じにする
RUN groupadd -g $GID devel
RUN useradd -u $UID -g devel -m devel
RUN echo "devel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN mkdir -p /app/public/image

WORKDIR /tmp
COPY init/Gemfile /tmp/Gemfile
COPY init/Gemfile.lock /tmp/Gemfile.lock

RUN gem update bundler && bundle install

COPY ./app /app

USER devel

WORKDIR /app