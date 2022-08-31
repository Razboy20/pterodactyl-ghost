FROM node:16-alpine

RUN apk --update --no-cache add curl ca-certificates
RUN npm install ghost-cli@latest -g

USER container
ENV  USER container
ENV HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]
