FROM golang:1.20.5-alpine3.18 as builder
RUN apk update && \
    apk upgrade && \
    apk add git gcc libc-dev linux-headers
RUN go install -ldflags "-X main.VERSION=$(data -u +%Y%m%d) -s -w" github.com/xtaci/kcptun/server@latest

FROM alpine:3.18
COPY --from=builder /go/bin /bin
CMD ["server", "-c", "/etc/kcptun/config.json"]
