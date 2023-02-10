FROM golang:1.16-alpine as builder

WORKDIR /app

ADD . /app

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o golang .

FROM scratch

COPY --from=builder /app/golang /

EXPOSE 8080

CMD ["/golang"]
