FROM golang:1.12 as builder

COPY . /app

WORKDIR  /app
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o newserver

FROM scratch

COPY --from=builder /app/newserver /

EXPOSE 8000
CMD ["/newserver"]
