FROM ubuntu:22.04
LABEL org.opencontainers.image.authors="jecklgamis@gmail.com"

RUN apt update -y && apt install -y curl dumb-init nodejs npm && rm -rf /var/lib/apt/lists/*

ENV APP_HOME /app

RUN mkdir -p ${APP_HOME}
WORKDIR /app
COPY "package.json" .
COPY "package-lock.json" .
RUN npm install -production
ADD public public
ADD routes routes
ADD views views
ADD middleware middleware
COPY app.js .
COPY build-info-data.js .
COPY server.crt .
COPY server.key .

RUN groupadd -r app && useradd -r -gapp app
RUN chown -R app:app /app

EXPOSE 8080
EXPOSE 8443
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/docker-entrypoint.sh"]