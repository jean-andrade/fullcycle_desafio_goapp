FROM golang:alpine as builder
ADD . /src
WORKDIR /src
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
  -ldflags='-w -s -extldflags "-static"' -a \
  -o goapp
ENTRYPOINT ./goapp

FROM scratch
COPY --from=builder /src/goapp /app/goapp
ENTRYPOINT ["/app/goapp"]