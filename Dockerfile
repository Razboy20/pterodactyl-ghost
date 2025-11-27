FROM node:22-alpine

RUN apk --update --no-cache add curl python3 python3-dev py3-pip ca-certificates \
	&& adduser -D -h /home/container container
RUN npm i --no-audit ghost-cli@latest -g

USER container
ENV  USER container
ENV HOME /home/container

WORKDIR /home/container

COPY --chown=container:container ./entrypoint.sh /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]
