FROM golang:1.21 AS build

WORKDIR /go/src/app

COPY ./backend ./backend
COPY ./cmd ./cmd
COPY ./crypt ./crypt
COPY ./pid ./pid
COPY ./server ./server
COPY ./storages ./storages
COPY ./types ./types

COPY ./go.mod ./
COPY ./main.go ./

RUN mkdir bin && go mod tidy && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o ./bin/ .

FROM alpine:3.18

# Include CA Certs to resolve TLS handshakes
RUN apk update && \
    apk add --no-cache ca-certificates && \
    rm -rf /var/cache/apk/*

WORKDIR /usr/bin
COPY --from=build /go/src/app/bin/terraform-backend-git /usr/bin/terraform-backend-git

CMD ["terraform-backend-git"]
