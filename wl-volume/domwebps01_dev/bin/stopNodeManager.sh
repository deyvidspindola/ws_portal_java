#!/bin/sh

# WARNING: This file is created by the Configuration Wizard.
# Any changes to this script may be lost when adding extensions to this configuration.

# *************************************************************************
#  This script is used to stop the NodeManager for this domain.
#  This script should be used only when node manager is configured per domain.
#  This script sets the following variables before stopping 
#  the node manager:
# 
#  WL_HOME    - The root directory of your WebLogic installation
#  NODEMGR_HOME  - The product name. Here it will product name and domain name
#  *************************************************************************

WL_HOME="/u01/oracle/wlserver"

NODEMGR_HOME="/u01/oracle/user_projects/domains/domwebps01_dev/nodemanager"
export NODEMGR_HOME

DOMAIN_HOME="/u01/oracle/user_projects/domains/domwebps01_dev"

ROOT_DIRECTORY="/u01/oracle/user_projects/domains/domwebps01_dev"
export ROOT_DIRECTORY

#  stop node manager

${WL_HOME}/server/bin/stopNodeManager.sh

