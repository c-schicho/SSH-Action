FROM alpine:latest

RUN apk update && \
    apk add --no-cache openssh-client bash

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]