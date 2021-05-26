# builder stage
FROM golang:1.16.4 as builder

COPY . /app

WORKDIR /app
# compile
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o greeting .


FROM scratch

# copy bianry file from previous stage, e.c. builder
COPY --from=builder /app/greeting /

EXPOSE 8080
CMD ["/greeting"]