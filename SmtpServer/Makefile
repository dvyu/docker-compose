NS = dvin
VERSION ?= 1.0.5

REPO = emailsmtpserver

build:
	docker build -t $(NS)/$(REPO):$(VERSION) .

push:
	docker push $(NS)/$(REPO):$(VERSION)
