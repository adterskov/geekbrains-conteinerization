FROM golang:1.19 as builder

WORKDIR /app1

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server

FROM alpine:3.16

COPY --from=builder /app1/server /

EXPOSE 8080
CMD ["/server"]


