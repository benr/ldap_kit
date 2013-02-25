#!/bin/bash

if [[ -r /var/openldap/tls/ca.crt && -w /var/ldap ]]
then 
  certutil -N -d /var/ldap -f /dev/null
  certutil -A -d /var/ldap -n "Joyent Operations CA" -i /var/openldap/tls/ca.crt -a -t CT
  certutil -L -d /var/ldap
else
  echo "An error has occured.  This is a crappy error message."
fi
