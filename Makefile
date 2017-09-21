IMAGE_NAME=research-env

run:
	docker run -it \
		-v `pwd`/nb:/app/nb/ \
		-e PASS_HASH=$(PASS_HASH) \
		-p 8080:8080 $(IMAGE_NAME) \

dev:
	docker exec -it `docker ps -l -q` bash

build-env:
	docker build -t $(IMAGE_NAME) .

rebuild-env:
	docker build --no-cache=true -t $(IMAGE_NAME) .

push-env:
	./bin/push-docker.sh
