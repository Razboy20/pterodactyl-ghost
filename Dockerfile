FROM node:18-alpine

RUN apk --update --no-cache add curl ca-certificates \
	&& adduser -D -h /home/container container
RUN npm i --no-audit ghost-cli@latest -g

USER container
ENV  USER container
ENV HOME /home/container

WORKDIR /home/container

COPY --chown=container:container ./entrypoint.sh /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]
