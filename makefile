SHELL := /bin/bash

run:
	go run main.go

# =========================
# Building containers

VERSION:= 1.0

all: golang-kubernetes-ultimate-service

golang-kubernetes-ultimate-service:
	docker build \
		-f zarf/docker/dockerfile \
		-t service-amd64:${VERSION} \
		--build-arg BUILD_REF=$(VERSION) \
		--build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
	  	.

# ==============================================================================
# Running from within k8s/kind

KIND_CLUSTER = nenad-starter-cluster

kind-up:
	kind create cluster \
		--name $(KIND_CLUSTER) \
		--config zarf/k8s/kind/kind-config.yaml

kind-down:
	kind delete cluster --name $(KIND_CLUSTER)

kind-status:
	kubectl get nodes -o wide
	kubectl get svc -o wide