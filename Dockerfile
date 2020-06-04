###############################################################
### ---- Create a Docker image for Jolie Documentation ---- ###
###############################################################
FROM nginx:alpine
LABEL build_date="2020-06-03" \
	  author="Brian Alberg <alberg@imada.sdu.dk>" \
	  description="Jolie Documentation" \
	  url="https://jolie-lang.org"
MAINTAINER Brian Alberg "alberg@imada.sdu.dk"
ENV REFRESHED_AT 2020-06-03
## Fix issue in Node/Docker as reported here:
## https://stackoverflow.com/questions/52196518/could-not-get-uid-gid-when-building-node-docker
ENV npm_config_unsafe_perm true
## Install NodeJS
RUN apk update && \
	apk add --update nodejs npm --no-cache
RUN mkdir -p /home/nginx/jolie-docs
WORKDIR /home/nginx/jolie-docs
COPY Documentation/ ./
COPY gitbook/ ./
RUN npm install -g gitbook-cli
RUN npm install gitbook-plugin-highlight-jolie
RUN gitbook init && \
	gitbook install && \
	gitbook build
## Copy static webserver
RUN chown -R nginx:nginx _book && \
    cp -r _book /usr/share/nginx/html/jolie-docs
## Copy nginx config file
COPY Docker/nginx/conf.d/ /etc/nginx/conf.d/
WORKDIR /
EXPOSE 8080