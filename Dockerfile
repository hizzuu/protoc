FROM golang:alpine AS go-builder

RUN apk add --no-cache git make protobuf-dev

# install protoc-gen-go
RUN go get github.com/golang/protobuf/protoc-gen-go

# install protoc-gen-validate
RUN go get -d github.com/envoyproxy/protoc-gen-validate && \
    cd ${GOPATH}/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v0.6.2 && \
    make build

# install protoc-gen-doc
RUN go get github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc

FROM alpine
WORKDIR /proto

RUN apk add --no-cache protobuf-dev
COPY --from=go-builder /go/bin /usr/local/bin
COPY --from=go-builder /go/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v0.6.2/validate/validate.proto /go/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v0.6.2/validate/validate.proto

ENTRYPOINT ["protoc"]