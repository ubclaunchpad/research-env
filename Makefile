IMAGE_NAME=research-env

run:
	docker run -it \
		-e PASS_HASH=$(PASS_HASH) \
		-p 8080:8080 $(IMAGE_NAME) \
		-v nb:/app/nb/

dev:
	docker exec -it `docker ps -l -q` bash

build-env:
	docker rm -f $(IMAGE_NAME) || true
	docker build -t $(IMAGE_NAME) .

rebuild-env:
	docker build -t $(IMAGE_NAME) .

push-env:
	./bin/push-docker.sh
