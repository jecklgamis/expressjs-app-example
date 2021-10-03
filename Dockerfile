FROM alpine:3.14
MAINTAINER Jerrico Gamis <jecklamis@gmail.com>

# Install required packages
RUN apk update && apk add --no-cache bash curl dumb-init nodejs npm

ENV APP_HOME /app

# Copy files to /app
RUN mkdir -p ${APP_HOME}
WORKDIR /app
COPY "package.json" .
COPY "package-lock.json" .
RUN npm install -production
ADD public public
ADD routes routes
ADD views views
COPY app.js .
COPY build_info_data.js .
COPY server.crt .
COPY server.key .

# Create user
RUN addgroup -S app && adduser -S app -G app
RUN chown -R app:app /app

EXPOSE 8080
EXPOSE 8443
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/docker-entrypoint.sh"]