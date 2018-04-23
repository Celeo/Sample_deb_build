.PHONY: build build-deb build-both test-install

all: build-both

build-both: build build-deb

build: deb_testing

deb_testing: main.go
	go build

build-deb: helloworld_1.0-1.deb

helloworld_1.0-1.deb: deb_testing control.conf
	rm -rf helloworld_1.0-1
	mkdir -p helloworld_1.0-1/usr/local/bin
	mkdir -p helloworld_1.0-1/DEBIAN
	cp control.conf helloworld_1.0-1/DEBIAN/control
	cp deb_testing helloworld_1.0-1/usr/local/bin/hello_world
	docker run -ti --rm -v `pwd`:/srv debian bash -c 'cd /srv && dpkg-deb --build helloworld_1.0-1'

clean:
	rm -rf helloworld_1.0-1
	rm -f helloworld_1.0-1.deb
	go clean

test-install: helloworld_1.0-1.deb
	docker run -ti --rm -v `pwd`:/srv debian bash -c 'cd /srv && dpkg -i helloworld_1.0-1.deb && hello_world && dpkg -r helloworld'
