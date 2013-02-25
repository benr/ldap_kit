This is the "Joyent LDAP Kit".  It was created years ago as an attempt to make it easier to bootstrap an LDAP infrastructure for Solaris authentication.  Found here is a copy of "Easy RSA" for creating a CA, the source for the ns1 tool to encrypt/decrypt passwords in the format that Solaris's Native LDAP client reads them, an OpenLDAP compatable "consolidated schema" with all the DIT schema objects for Solaris features, DIT templates for creating your base objects, and some (really basic and bad) scripts for bootstrapping clients.


The real readme is LDAP-KIT.README.

Please understand that this stuff is all still relevant today but I am not longer maintaining it.  The irony is that once you have your LDAP implementation in place you are past all the pain that this kit was designed to remove.  All bootstrapping of LDAP clients is now preformed via Chef Cookbooks, which are not included here.

This kit is intended for use with OpenLDAP.  
