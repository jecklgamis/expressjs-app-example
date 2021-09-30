FROM alpine:3.14

RUN apk update && apk add --no-cache bash curl dumb-init nodejs npm

COPY server.crt /app/
COPY server.key /app/

EXPOSE 8080
EXPOSE 8443

RUN mkdir -p /app
WORKDIR /app
COPY "package.json" .
COPY "package-lock.json" .
RUN npm install -production
COPY . .

RUN addgroup -S app && adduser -S app -G app
RUN chown -R app:app /app

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

ENV NODE_ENV=production
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
CMD ["/docker-entrypoint.sh"]