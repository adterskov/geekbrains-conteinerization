FROM golang:1.20 as builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server

FROM alpine:3.16

COPY --from=builder /app/server /

EXPOSE 8080
CMD ["/server"]
