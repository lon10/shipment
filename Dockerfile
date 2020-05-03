FROM ruby:2.6.5

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN mkdir -p /app
WORKDIR /app

COPY . ./

RUN gem install bundler -v 2.1.4
RUN bundle install --verbose --jobs 20 --retry 5

EXPOSE 9292

CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0"]
