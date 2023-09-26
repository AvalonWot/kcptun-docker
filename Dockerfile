FROM golang:alpine as builder
RUN go install -ldflags "-s -w" github.com/xtaci/kcptun/server@latest
RUN go install -ldflags "-s -w" github.com/xtaci/kcptun/client@latest

FROM alpine
COPY --from=builder /go/bin /bin
CMD ["server", "-c", "/etc/kcptun/config.json"]
