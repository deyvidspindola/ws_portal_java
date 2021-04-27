#! /bin/bash

set_context() {
   scriptDir="$( cd "$( dirname "$0" )" && pwd )"
   if [ ! -d "${scriptDir}" ]; then
       echo "Unable to determine the working directory for the domain home in image sample"
       echo "Using shell /bin/sh to determine and found ${scriptDir}"
       clean_and_exit
   fi
   echo "Context for docker build is ${scriptDir}"
}

set_context
. ${scriptDir}/container-scripts/setEnv.sh ${scriptDir}/properties/domain.properties


admin_host() {
   adminhost=${ADMIN_HOST:-"AdminContainer"}
}

admin_host

docker stop  ${adminhost} && docker rm ${adminhost}

./build.sh

./run_admin_server.sh

docker logs -f  ${adminhost}