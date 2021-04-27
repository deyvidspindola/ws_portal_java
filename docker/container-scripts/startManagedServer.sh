#!/bin/bash
#
# Copyright (c) 2019, 2020, Oracle and/or its affiliates.
#
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.
#
export MANAGED_NAME=mngnode1
export DOMAIN_HOME=$DOMAIN_ROOT/$DOMAIN_NAME
echo "Domain Home is:  $DOMAIN_HOME"

export MS_HOME="${DOMAIN_HOME}/servers/${MANAGED_NAME}"
export MS_SECURITY="${MS_HOME}/security"

# Wait for AdminServer to become available for any subsequent operation
/u01/oracle/container-scripts/waitForAdminServer.sh

echo "Managed Server Name: ${MANAGED_NAME}"
echo "Managed Server Home: ${MS_HOME}"
echo "Managed Server Security: ${MS_SECURITY}"

#Set Java options
#JAVA_OPTIONS="-Dweblogic.StdoutDebugEnabled=false"
export JAVA_OPTIONS=${JAVA_OPTIONS}
echo "Java Options: ${JAVA_OPTIONS}"

${DOMAIN_HOME}/bin/setDomainEnv.sh

echo "Connecting to Admin Server at http://${ADMIN_HOST}:${ADMIN_LISTEN_PORT}"
${DOMAIN_HOME}/bin/startManagedWebLogic.sh ${MANAGED_NAME} "http://${ADMIN_HOST}:${ADMIN_LISTEN_PORT}"

# tail Managed Server log
touch ${MS_HOME}/logs/${MANAGED_NAME}.log
tail -f ${MS_HOME}/logs/${MANAGED_NAME}.log &

childPID=$!
wait $childPID
