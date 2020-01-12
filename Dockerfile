FROM golang:latest as builder

WORKDIR /src
COPY . .

RUN go get github.com/gin-gonic/gin
RUN go build -o gofuture

FROM centos:7.7.1908

WORKDIR /app
COPY --from=builder /src/gofuture .
COPY --from=builder /src/assets ./assets
COPY --from=builder /src/templates ./templates

CMD ["./gofuture"]
