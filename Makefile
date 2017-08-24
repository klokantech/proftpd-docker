IMAGE_NAME=klokan/proftp

build: 
	docker build -f Dockerfile.proftpd -t $(IMAGE_NAME) .

test: build
	make -C tests test
