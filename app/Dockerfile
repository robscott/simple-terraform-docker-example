FROM docker.io/node:8.9.4-alpine

# Setup the base app directory
RUN mkdir -p /usr/src/sample-app
WORKDIR /usr/src/sample-app

# Base packages that we want to stay in
RUN apk update && apk upgrade

# Now bring in the source code.
COPY index.js .

# Create and add app user + make all the things read only
RUN addgroup -S app && adduser -S -g app app
RUN chown -R app /usr/src/sample-app
RUN chmod -R 500 /usr/src/sample-app
USER app

# Run the app
CMD node index.js
