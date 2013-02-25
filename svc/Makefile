all: install


install:
	svcadm disable ldap/server && svccfg delete ldap/server

	mkdir -p /var/svc/method/
	chown root:sys /var/svc/method/
	chmod 755 /var/svc/method/

	cp openldap-server /var/svc/method/openldap-server
	svccfg import openldap-server.xml


clean:
	svcadm disable ldap/server
	rm -f /var/svc/method/openldap-server
	rmdir /var/svc/method/
	svccfg delete ldap/server
	svccfg import /var/svc/manifest/network/ldap/ldap-olslapd.xml


# Clean will fail if ldap/server isn't present
fix:
	svccfg import /var/svc/manifest/network/ldap/ldap-olslapd.xml
