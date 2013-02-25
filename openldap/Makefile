include ../Makefile.config

# Note the trailing slash:
TLS_ROOT=	/var/openldap/tls/
# You must create an uber-escaped version for SED:
TLS_ROOT_SED=	\\/var\\/openldap\\/tls\\/

all:	slapd.conf.master

slapd.conf.master:
	/bin/sed s/__DATE__/$(DATE)/g slapd.conf.template \
		| /bin/sed s/__HOSTNAME__/$(HOST)/g \
		| /bin/sed s/__DIT_SUFFIX__/$(DIT_SUFFIX)/g \
		| /bin/sed s/__TLS_CA_CERT__/$(TLS_ROOT_SED)$(TLS_CA_CERT)/g \
		| /bin/sed s/__TLS_SRV_CERT__/$(TLS_ROOT_SED)$(TLS_SRV_CERT)/g \
		| /bin/sed s/__TLS_SRV_KEY__/$(TLS_ROOT_SED)$(TLS_SRV_KEY)/g \
		| /bin/sed s/__ROOTDN_PASS__/$(ROOTDN_PASS_SSHA)/g \
		| /bin/sed s/__MIRROR_PEER_IP__/$(MIRROR_PEER_IP)/g \
		| /bin/sed s/__MIRROR_PASS__/$(MIRROR_PASS)/g \
		> slapd.conf.master


install: slapd.conf.master
	mkdir -p $(TLS_ROOT)
	chown root:openldap       $(TLS_ROOT)
	chmod 655		  $(TLS_ROOT)

	cp ../pki/$(TLS_CA_CERT)  $(TLS_ROOT)$(TLS_CA_CERT)
	chown root:openldap 	  $(TLS_ROOT)$(TLS_CA_CERT)
	chmod 640		  $(TLS_ROOT)$(TLS_CA_CERT)

	cp ../pki/$(TLS_SRV_CERT) $(TLS_ROOT)$(TLS_SRV_CERT)
	chown root:openldap       $(TLS_ROOT)$(TLS_SRV_CERT)
	chmod 640                 $(TLS_ROOT)$(TLS_SRV_CERT)

	cp ../pki/$(TLS_SRV_KEY)  $(TLS_ROOT)$(TLS_SRV_KEY)
	chown root:openldap	  $(TLS_ROOT)$(TLS_SRV_KEY)
	chmod 640		  $(TLS_ROOT)$(TLS_SRV_KEY)

	cp consolidatedSolaris.schema /etc/openldap/schema/
	chown root:sys		      /etc/openldap/schema/consolidatedSolaris.schema
	chmod 444		      /etc/openldap/schema/consolidatedSolaris.schema

	cp /etc/openldap/slapd.conf /etc/openldap/slapd.conf.$(DATE)
	cp slapd.conf.master /etc/openldap/slapd.conf
	chown root:openldap  /etc/openldap/slapd.conf
	chmod 640	     /etc/openldap/slapd.conf

clean:
	rm -f slapd.conf.master
