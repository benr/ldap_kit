include ../Makefile.config

all: client_deploy.sh


dist: ldap_deploy.tar


client_deploy.sh:
	/bin/sed s/__DIT_SUFFIX__/$(DIT_SUFFIX)/g client_deploy.sh.template \
		| /bin/sed s/__PROXY_PASS__/$(PROXY_PASS)/g \
		| /bin/sed s/__PREFSERVERS__/$(PREFSERVERS)/g \
		| /bin/sed s/__LDAPSERVERS__/$(SERVERS)/g \
		| /bin/sed s/__NISDOMAIN__/$(NISDOMAIN)/g \
		| /bin/sed s/__SERVER1_HOSTENTRY__/$(SERVER1_HOSTENTRY)/g \
		| /bin/sed s/__SERVER2_HOSTENTRY__/$(SERVER2_HOSTENTRY)/g \
		| /bin/sed s/__DATE__/$(DATE)/g \
		| /bin/sed s/__HOST__/$(HOST)/g \
		> client_deploy.sh


ldap_deploy.tar: client_deploy.sh
	mkdir ldap_deploy
	cp -rp ../home ldap_deploy/
	cp -rp ../solaris ldap_deploy/
	mkdir ldap_deploy/certdb/
	cp -p /var/ldap/*.db ldap_deploy/certdb/
	/bin/sed 's/\.\././g' client_deploy.sh > ldap_deploy/client_deploy.sh

	tar cfv ldap_deploy.tar ldap_deploy

	printf "\n\n\n\n Now extract ldap_deploy.tar on a node with SSH key access to all your nodes! \n\n\n"

clean:
	rm -f client_deploy.sh
	rm -rf ldap_deploy
	rm -f ldap_deploy.tar
