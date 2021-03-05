#
# docker run -d \
# 	--restart always \
#	-p 2022:2022 \
#	-p 8080:8080 \
# 	-v /volumes/cloudc2:/data \
# 	--name cloudc2 \
# 	poshsecurity/cloudc2 \
#	-hostname server.local

FROM alpine:latest
LABEL maintainer "Kieran Jacobsen <code@poshsecurity.com>"

WORKDIR /app

RUN apk --no-cache update

RUN apk --no-cache upgrade

RUN apk --no-cache add musl-utils=1.2.2-r1 --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main

RUN apk --no-cache add musl=1.2.2-r1 --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main

RUN apk --no-cache add \
	ca-certificates \
	curl

RUN curl -L https://c2.hak5.org/download/community --output c2.zip \
     && unzip c2.zip -d /tmp \
     && cp /tmp/*_i386_linux /app/cloudc2

# 80 and 443 only needed if using -https or -httpscert options, otherwise Cloud C2 will listen on 8080.
EXPOSE 80 443 2022 8080

ENTRYPOINT ["/app/cloudc2"]