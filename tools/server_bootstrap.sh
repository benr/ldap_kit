#!/bin/bash

# +Joyent LDAP Kit: Server (Primary) Bootstrap Script
# benr@joyent.com	11/3/10

#
#
#
#
#
#
#
#
#		THIS ISN'T DONE!  
#
#		  Don't use it!
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#



############################################################
# 	Globals						   #
############################################################


TLS_CA_CERT=/var/openldap/tls/ca.crt
TLS_SRV_CERT=/var/openldap/tls/${HOSTNAME}.crt
TLS_SRV_KEY=/var/openldap/tls/${HOSTNAME}.key

DATE=`date`

# Set from ARGS:
DIT_SUFFIX=""
MIRROR_PEER=""
MIRROR_CRED=""
ROOTPW=""


############################################################
#	Arg Parsing					   #
############################################################

## options handler here.



############################################################
# 	Functions					   #
############################################################


# usage: Print the usage banner and exit.
#

function usage 
{

 echo " +Joyent LDAP Kit: Server Bootstrap Script"
 echo " Usage: $0 <Root Password> <Peer Address> <Peer Pass>
 echo ""
 echo "  The Root Password can be created using \"slappasswd\""

 if [ $1 ]
 then
   echo ""
   echo " ERROR: $1"
 fi
 exit 1
}


# check_deps: On SX:CE the OpenLDAP package plus all its 
#		must be pre-installed before we do anyting.

function check_deps 
{

 PACKAGES=( SUNWopenldapr SUNWopenldapu SUNWtls SUNWtlsu SUNWlldap SUNWopensslr SUNWopenssl-libraries SUNWopenssl-commands SUNWlibnet SUNWicu )
 MISSING=0

 for PKG in ${PACKAGES[@]}
 do
  printf " Searching for dependancy: %s" $PKG

  if pkginfo | grep $PKG >/dev/null
  then
   printf " ... FOUND.\n"
  else
   ((MISSING++))
   printf " ... MISSING.\n"
  fi 
 done

 if [ $MISSING -gt 0 ]
 then
  echo "ERROR: Sorry, your missing $MISSING dependancies."
  echo "Please install them and try again." 
  exit 1
 fi
}


#
#

function bootstrap_ca
{

}

function generate_slapd
{

 echo "Applying customizations to slapd.conf template..."

 TEMPLATE_VALUES=( DATE HOSTNAME DIT_SUFFIX TLS_CA_CERT TLS_SRV_CERT TLS_SRV_KEY ROOTPW MIRROR_PEER MIRROR_CRED ) 
 PASS=0
 
 cp extras/openldap/slapd.conf /tmp/slapd.conf.$PASS

 for VALUE in ${TEMPLATE_VALUES[@]}
 do
  LAST=$PASS
  ((PASS++))

  if [[ -z ${!VALUE} ]]
  then
    echo "WARNING!  $VALUE is not set.  Going to continue, but you will need to manually fix this."
  else 
    cat /tmp/slapd.conf.$LAST sed s/__${VALUE}__/${!VALUE}/ > /tmp/slapd.conf.$PASS
  fi
 done

 echo "Copying final slapd.conf to /etc/openldap"
 cp /tmp/slapd.conf.$PASS /etc/openldap/slapd.conf

}

# server_config: Copy in the configuration files, 
#                customize  & start the server

function server_config
{

 if [ -f extras/openldap/slapd.conf ] && [ -f extras/openldap/consolidatedSolaris.schema ]
 then 
  echo ""
  echo "Configuring OpenLDAP
 else 
  echo "ERROR: Can not find extras/openldap/slapd.conf & extras/openldap/consolidatedSolaris.schema"
  exit 1
 fi 

 if [ ! -d /etc/openldap/schema ]
 then
   echo "ERROR: OpenLDAP must not be installed properly, /etc/openldap/schema does not exist."
 fi

 if getent passwd openldap
 then
   echo "Using user: openldap"
 else
   groupadd openldap -g 75
   useradd -u 75 -g openldap -c "OpenLDAP User" -d / openldap
 fi
 

 # Copy in schema
 cp extras/openldap/consolidatedSolaris.schema /etc/openldap/schema/consolidatedSolaris.schema
 chown root:root /etc/openldap/schema/consolidatedSolaris.schema
 chown 444 /etc/openldap/schema/consolidatedSolaris.schema

 # Create a local CA and generate the keys
 bootstrap_ca 

 # Copy in config
 cp /etc/openldap/slapd.conf /etc/openldap/slapd.conf.old
 generate_slapd 
 chmod 400 /etc/openldap/slapd.conf
 chown openldap:openldap /etc/openldap/slapd.conf

 

 
 



}

# fix_smf:
#
function fix_smf
{
 # ...
}

# load_base_dit
#
function load_base_dit
{
 # ...
}

############################################################
# 	MAIN     					   #
############################################################

preflight
check_deps
#server_config
#fix_smf
#load_base_dit
