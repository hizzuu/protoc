# Protoc docker image for Go
This Docker image contains [protoc-gen-go](github.com/golang/protobuf/protoc-gen-go), [protoc-gen-validate](https://github.com/envoyproxy/protoc-gen-validate), and [protoc-gen-doc](github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc)
<br>
Please refer to the relevant project for the usage of each project.

## Quick Start

Generage Go code by protocol buffer

```bash
docker run --rm --name protoc -v $(PWD)/gen/pb:/pb -v $(SCHEMA_PATH)/proto:/schema hizzuu/protoc \
	-I/schema \
	--go_out=plugins=grpc:/pb \
	user.proto
```

When using protoc-gen-validate

```bash
docker run --rm --name protoc -v $(PWD)/gen/pb:/pb -v $(SCHEMA_PATH)/proto:/schema hizzuu/protoc \
  -I/schema \
  -I/go/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v0.6.2 \
  --go_out=plugins=grpc:/pb \
  --validate_out="lang=go:/pb" \
  user.proto
```

Generate Document by Protocol Buffers

```bash
docker run --rm -v ${PWD}:/proto hizzuu/protoc \
  -I/proto \
  -I/go/src/github.com/envoyproxy/protoc-gen-validate \
  --doc_out=. \
  --doc_opt=markdown,README.md \
  user.proto
```

## Development

1. Clone this repository
2. Install dependencies using `Docker build .`

[Docker Hub](https://hub.docker.com/repository/docker/hizzuu/protoc)