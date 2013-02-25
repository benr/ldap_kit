include ../Makefile.config


DOMAIN= $(DIT_SUFFIX)
################################################################################


all: templates



templates:
	/bin/sed s/__DOMAIN__/$(DOMAIN)/g autofs.template > autofs.ldif
	/bin/sed s/__DOMAIN__/$(DOMAIN)/g dit-base.template \
		| /bin/sed s/__NISDOMAIN__/$(NISDOMAIN)/g > dit-base.ldif
	/bin/sed s/__DOMAIN__/$(DOMAIN)/g dua.template \
		| /bin/sed s/__LDAPSERVERS__/$(SERVERS)/ \
		| /bin/sed s/__PREFSERVERS__/$(PREFSERVERS)/ > dua.ldif
	/bin/sed s/__DOMAIN__/$(DOMAIN)/g proxyAgent.template \
		| /bin/sed s/__PROXYPASS__/$(PROXY_PASS_SSHA)/ > proxyAgent.ldif
	/bin/sed s/__DOMAIN__/$(DOMAIN)/g rbac.template > rbac.ldif

	/bin/sed s/__DOMAIN__/$(DOMAIN)/g mirrormode.template \
		| /bin/sed s/__MIRRORMODE_PASS__/$(MIRROR_PASS_SSHA)/ > mirrormode.ldif
	
	mkdir groups
	/bin/sed s/__DOMAIN__/$(DOMAIN)/g group.template > groups/group.copyme
	mkdir users
	/bin/sed s/__DOMAIN__/$(DOMAIN)/g user.template > users/user.copyme
	mkdir hosts
	/bin/sed s/__DOMAIN__/$(DOMAIN)/g host.template > hosts/host.copyme
	mkdir projects
	/bin/sed s/__DOMAIN__/$(DOMAIN)/g project.template > projects/project.copyme
	mkdir netgroups
	/bin/sed s/__DOMAIN__/$(DOMAIN)/g netgroup.template > netgroups/netgroup.copyme
	mkdir aliases
	/bin/sed s/__DOMAIN__/$(DOMAIN)/g aliases.template > aliases/aliases.copyme

	mkdir template
	mv *.template template
	#
	# Now start modifying LDIF's, namely DUA, proxyAgent, and mirrormode.
	#

clean-all: 
	rm -f autofs.ldif dit-base.ldif dua.ldif proxyAgent.ldif \
		mirrormode.ldif rbac.ldif
	rm -rf groups users hosts projects netgroups aliases
	mv template/*.template .
	rmdir template
	


backup: 
	mkdir backups
	cp *.ldif backups


addbase:
	cp /etc/openldap/DB_CONFIG.example /var/openldap/DB_CONFIG
	chown root:openldap /var/openldap/DB_CONFIG
	chmod 440 /var/openldap/DB_CONFIG

	slapadd -l dit-base.ldif
	slapadd -l dua.ldif
	slapadd -l proxyAgent.ldif
	slapadd -l rbac.ldif
	slapadd -l mirrormode.ldif
	# Now add custom LDIF's, such as users, groups, hosts, projects, etc.
