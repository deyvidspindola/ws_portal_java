#!/bin/sh

# WARNING: This file is created by the Configuration Wizard.
# Any changes to this script may be lost when adding extensions to this configuration.

# --- Start Functions ---

usage()
{
	echo "Usage: $1 {help} COMPONENT_NAME {storeUserConfig} {showErrorStack}"
	echo "Where:"
	echo "  help            - Optional. Show this usage."
	echo "  COMPONENT_NAME  - Required. System Component name, only one name allowed"
	echo "  storeUserConfig - Optional. If provided, save the user config into a file if the file does not exist. "
	echo "  showErrorStack  - Optional. Show error stack if provided."
}

# --- End Functions ---

if [ "$1" = "" ] ; then
	usage $0
	exit
fi
param="$(echo $1 | tr -s '')"
if [ "${param}" = "" ] ; then
	usage $0
	exit
fi


if [ "$1" = "storeUserConfig" ] ; then
	usage $0
	exit
fi

if [ "$1" = "showErrorStack" ] ; then
	usage $0
	exit
fi

storeUserConfig="false"
showErrorStack="false"
doUsage="false"
while [ $# -gt 0 ]
do
	case $1 in
	storeUserConfig)
		storeUserConfig="true"
		export storeUserConfig
		;;
	showErrorStack)
		showErrorStack="true"
		export showErrorStack
		;;
	help)
		doUsage="true"
		;;
	*)
		if [ "${componentName}" != "" ] ; then
			usage $0
			exit
		fi
		componentName="$1"
		export componentName
		;;
	esac
	shift
done


if [ "${doUsage}" = "true" ] ; then
	usage $0
	exit
fi

WL_HOME="/u01/oracle/wlserver"

DOMAIN_HOME="/u01/oracle/user_projects/domains/domwebps01_dev"

if [ "${TMPDIR}" != "" ] ; then
	PY_LOC="${TMPDIR}/startComponent.py"
else
	PY_LOC="/tmp/startComponent.py"
fi


umask 027


if [ "${showErrorStack}" = "false" ] ; then
	echo "try:" >"${PY_LOC}" 
	echo "  startComponentInternal('${componentName}', r'${DOMAIN_HOME}', '${storeUserConfig}')" >>"${PY_LOC}" 
	echo "  exit()" >>"${PY_LOC}" 
	echo "except Exception,e:" >>"${PY_LOC}" 
	echo "  print 'Error:', sys.exc_info()[1]" >>"${PY_LOC}" 
	echo "  exit()" >>"${PY_LOC}" 
else
	echo "startComponentInternal('${componentName}', r'${DOMAIN_HOME}', '${storeUserConfig}')" >"${PY_LOC}" 
	echo "exit()" >>"${PY_LOC}" 
fi

echo "Starting system Component ${componentName} ..."

# Start WLST.

${WL_HOME}/../oracle_common/common/bin/wlst.sh -i ${PY_LOC}  2>&1 

if [ -f ${PY_LOC} ] ; then

	rm -f ${PY_LOC}

fi

echo "Done"

exit

