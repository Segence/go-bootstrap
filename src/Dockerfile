############################
# Building executable binary
############################

# golang:1.12.7-alpine
FROM golang@sha256:1121c345b1489bb5e8a9a65b612c8fed53c175ce72ac1c76cf12bbfc35211310 as builder

# Install git + SSL ca certificates:
# - Git is required for fetching the dependencies
# - CA Certificates is required to call HTTPS endpoints
RUN apk update && apk add --no-cache git ca-certificates && update-ca-certificates

WORKDIR $GOPATH/src/application
COPY . .

ENV GO111MODULE=on
RUN go mod download
RUN go mod verify
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o $GOPATH/bin/main
RUN chmod +x $GOPATH/bin/main

###############################
# Building a small Docker image
###############################

FROM scratch

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /go/bin/main /main
USER daemon
ENTRYPOINT ["/main"]
