all: build push

DOCKERREPO       := kubeforge/bastion

build:
				docker build -t $(DOCKERREPO) -f Dockerfile .

push: build
				docker push $(DOCKERREPO)
