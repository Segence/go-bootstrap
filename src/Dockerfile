############################
# Building executable binary
############################

# golang:1.14.1-alpine3.11
FROM golang@sha256:0b69b5d47b70b9905cde03b9094d1b17178a7655faa0b2ce6b8b744b1abca8ba as builder

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
