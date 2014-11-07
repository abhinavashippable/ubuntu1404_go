ubuntu1404_go
=============

Shippable CI image for Go on Ubuntu 14.04. Available go versions:

1. 1.1
2. 1.2
3. 1.3
4. tip
5. release

## How to use
You can use this image to run go builds on Shippable. Just update your
`shippable.yml` file and add the `build_image` directive. You should also
activate the appropriate virtual envrionment so your build runs against the
correct version of go. The go versions you specify in the go directive in the YML will be available in the `$SHIPPABLE_GO_VERSION` environment variable. Here's a sample YML file to get you going:

````
language: go
go:
  - 1.1
  - 1.2
  - 1.3
  - tip
  - release

build_image: shippableimages/ubuntu1404_go

before_install:
  - source $HOME/.gvm/scripts/gvm;
  - if [[ $SHIPPABLE_GO_VERSION == "tip" ]]; then gvm install tip; gvm use tip; fi
  - if [[ $SHIPPABLE_GO_VERSION == *release* ]]; then gvm install release; gvm use release; fi
  - if [[ $SHIPPABLE_GO_VERSION =~ [0-9].[0-9] ]]; then gvm install go$SHIPPABLE_GO_VERSION; gvm use go$SHIPPABLE_GO_VERSION; fi
  - export GOPATH=$SHIPPABLE_GOPATH
  - go get github.com/t-yuki/gocover-cobertura
  - go get github.com/onsi/gomega
  - go get github.com/onsi/ginkgo
  - go get code.google.com/p/go.tools/cmd/cover

install:
  - go get -d -v ./... && go build -v ./...

script:
  - go test -coverprofile=coverage.txt -covermode count ./

````
