IMAGE_NAME=klokan/proftp

build: 
	docker build -f Dockerfile -t $(IMAGE_NAME) .

test: build
	make -C tests test
