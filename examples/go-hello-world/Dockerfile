FROM golang:1.20-alpine3.18

RUN mkdir -p /opt/go-hello-world
COPY . /opt/go-hello-world
WORKDIR /opt/go-hello-world/src

RUN go build
WORKDIR /opt/go-hello-world/src
CMD ["./go-hello-world"]
