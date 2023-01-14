FROM golang:1.20rc3 as builder

WORKDIR /app

COPY . /app

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server .

FROM scratch

COPY --from=builder /app/server /

EXPOSE 8080
ENTRYPOINT ["/server"]
