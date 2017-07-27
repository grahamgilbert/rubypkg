USE_PKGBUILD=1
include /usr/local/share/luggage/luggage.make

TITLE=Ruby
PACKAGE_NAME=ruby
REVERSE_DOMAIN=com.grahamgilbert
VERSION=2.3.4
PACKAGE_VERSION=${VERSION}
URL=https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.4.tar.gz
PREFIX=/usr/local/ruby
PAYLOAD=\
	pack-ruby

pack-ruby:
	curl -o ruby.tar.gz ${URL}
	mkdir -p ruby_source
	tar xf ruby.tar.gz -C ruby_source --strip-components 1
	cd ruby_source; ./configure --prefix=${PREFIX}; make; sudo make install
	@sudo mkdir -p ${WORK_D}${PREFIX}
	@sudo rsync -a ${PREFIX}/ ${WORK_D}${PREFIX}/
	@sudo chown -R root:wheel ${WORK_D}${PREFIX}
	@sudo rm -rf ruby_source
	@sudo rm -rf *.tar.gz
