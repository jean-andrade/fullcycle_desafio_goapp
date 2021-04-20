FROM golang:alpine as builder
WORKDIR /src
COPY goapp.go .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
  -ldflags='-w -s -extldflags "-static"' -a \
  -o goapp

FROM scratch
COPY --from=builder /src/goapp /app/goapp
ENTRYPOINT ["/app/goapp"]