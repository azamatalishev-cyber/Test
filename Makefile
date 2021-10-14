GO_BINARY=/usr/local/bin/go
REPO_NAME=github.com/azamatalishev-cyber/Test

all: terraform-roles-test

terraform-roles-test:
		cd test && \
		go test -v
