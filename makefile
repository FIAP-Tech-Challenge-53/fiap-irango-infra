#!/bin/bash

NETWORK_NAME=local-network
NETWORK_ID=$(shell docker network ls -qf "name=${NETWORK_NAME}")

.PHONY: add-network
add-network:
	@if [ -n '${NETWORK_ID}' ]; then \
		echo 'The ${NETWORK_NAME} network already exists. Skipping...'; \
	else \
		docker network create -d bridge ${NETWORK_NAME}; \
	fi

.PHONY: local-up
local-up: add-network
	docker compose up --remove-orphans -d

.PHONY: local-down
local-down:
	docker compose down

.PHONY: local-logs
local-logs:
	docker compose logs -f

bash:
	docker exec -it $(shell docker ps -qf "name=localstack") bash

init:
	terraform -chdir=terraform init

plan:
	terraform -chdir=terraform plan

up:
	terraform -chdir=terraform apply -auto-approve

down:
	terraform -chdir=terraform destroy -auto-approve