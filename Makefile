.PHONY: all clean

all: var/cidr var/delegated-apnic var/iptables

var/cidr: var/delegated-apnic
	mkdir -p $@
	bin/countries.pl var/delegated-apnic var/cidr

var/iptables: var/cidr
	mkdir -p $@
	for i in $(shell ls var/cidr); do bin/iptables-rule.pl var/cidr eth0 $$i > var/iptables/$$i; done

var/delegated-apnic:
	mkdir -p var
	curl -o var/delegated-apnic http://ftp.apnic.net/stats/apnic/delegated-apnic-latest

clean:
	rm -rf var

