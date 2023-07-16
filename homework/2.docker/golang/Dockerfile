WORKDIR /app

ADD . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o golang .

FROM scratch

COPY --from=builder /app/golang /

EXPOSE 8080

CMD ["/golang"]
