FROM golang:1-alpine3.16 as builder
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server .
RUN addgroup --system app && adduser -S -G app app

#Final
FROM scratch
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /app/server /
USER app
EXPOSE 8080
CMD ["/server"]
