# git bash hack on windows - deals with pathname conversions from dos to unix-style
export MSYS_NO_PATHCONV=1

export _componentSettingsFileName=component.settings.sh
_settingsFileName=settings.sh
_localSettingsFileName=settings.local.sh
_settingsFile=./${_settingsFileName}
_localSettingsFile=./${_localSettingsFileName}

echoWarning (){
  _msg=${1}
  _yellow='\033[1;33m'
  _nc='\033[0m' # No Color
  echo -e "${_yellow}${_msg}${_nc}"
}

echo -e "\nLoading settings ..."

# ===========================================================================================================
# Load the project level settings file ...
# -----------------------------------------------------------------------------------------------------------
if [ -f ${_settingsFile} ]; then
  echo -e "Loading project level settings from ${PWD}/${_settingsFileName} ..."
  . ${_settingsFile}
else
  echoWarning "=================================================================================================="
  echoWarning "Warning:"
  echoWarning "--------------------------------------------------------------------------------------------------"
  echoWarning "No project settings file (${_settingsFileName}) was found in '${PWD}'."
  echoWarning "Make sure you're running the script from your project's top level 'openshift' directory"
  echoWarning "and you have a 'settings.sh' file in that folder."
  echoWarning "=================================================================================================="
fi
# ===========================================================================================================

# ===========================================================================================================
# Load the project level local override settings file ...
# -----------------------------------------------------------------------------------------------------------
if [ ! -z "${APPLY_LOCAL_SETTINGS}" ] && [ -f ${_localSettingsFile} ]; then
  echo -e "Loading project level local overrides from ${PWD}/${_localSettingsFileName} ..."
  . ${_localSettingsFile}
elif [ ! -z "${APPLY_LOCAL_SETTINGS}" ] && [ ! -f ${_localSettingsFile} ]; then
  echo "=================================================================================================="
  echo "Information:"
  echo "--------------------------------------------------------------------------------------------------"
  echo "You've specified you want to apply local settings,"
  echo "but no project level local override settings file"
  echo "(${_localSettingsFileName}) was found in '${PWD}'."
  echo "This is a great way to apply overrides when you are generating local parameter files."
  echo "=================================================================================================="
fi
# ===========================================================================================================

# ===========================================================================================================
# Default settings, many of which you will never need to override.
# -----------------------------------------------------------------------------------------------------------

# Project Variables
export PROJECT_DIR=${PROJECT_DIR:-..}
export PROJECT_OS_DIR=${PROJECT_OS_DIR:-.}

export OC_ACTION=${OC_ACTION:-create}
export DEV=${DEV:-dev}
export TEST=${TEST:-test}
export PROD=${PROD:-prod}

export TOOLS=${TOOLS:-${PROJECT_NAMESPACE}-tools}
export DEPLOYMENT_ENV_NAME=${DEPLOYMENT_ENV_NAME:-${DEPLOYMENT_ENV_NAME:-${DEV}}}
export BUILD_ENV_NAME=${BUILD_ENV_NAME:-tools}
export LOAD_DATA_SERVER=${LOAD_DATA_SERVER:-local}
export TEMPLATE_DIR=${TEMPLATE_DIR:-templates}
export PIPELINE_JSON=${PIPELINE_JSON:-https://raw.githubusercontent.com/BCDevOps/openshift-tools/master/provisioning/pipeline/resources/pipeline-build.json}
export COMPONENT_JENKINSFILE=${COMPONENT_JENKINSFILE:-../Jenkinsfile}
export PIPELINEPARAM=${PIPELINEPARAM:-pipeline.param}
export APPLICATION_DOMAIN_POSTFIX=${APPLICATION_DOMAIN_POSTFIX:-.pathfinder.gov.bc.ca}

# Jenkins account settings for initialization
export JENKINS_ACCOUNT_NAME=${JENKINS_ACCOUNT_NAME:-jenkins}
export JENKINS_SERVICE_ACCOUNT_NAME=${JENKINS_SERVICE_ACCOUNT_NAME:-system:serviceaccount:${TOOLS}:${JENKINS_ACCOUNT_NAME}}
export JENKINS_SERVICE_ACCOUNT_ROLE=${JENKINS_SERVICE_ACCOUNT_ROLE:-edit}

# Gluster settings for initialization
export GLUSTER_ENDPOINT_CONFIG=${GLUSTER_ENDPOINT_CONFIG:-https://raw.githubusercontent.com/BCDevOps/openshift-tools/master/resources/glusterfs-cluster-app-endpoints.yml}
export GLUSTER_SVC_CONFIG=${GLUSTER_SVC_CONFIG:-https://raw.githubusercontent.com/BCDevOps/openshift-tools/master/resources/glusterfs-cluster-app-service.yml}
export GLUSTER_SVC_NAME=${GLUSTER_SVC_NAME:-glusterfs-cluster-app}
# ===========================================================================================================

# ===========================================================================================================
# Settings you should supply in your project settings file
# -----------------------------------------------------------------------------------------------------------
export PROJECT_NAMESPACE=${PROJECT_NAMESPACE:-""}

# The templates that should not have their GIT referances(uri and ref) over-ridden
# Templates NOT in this list will have they GIT referances over-ridden
# with the values of GIT_URI and GIT_REF
export skip_git_overrides=${skip_git_overrides:-""}
export GIT_URI=${GIT_URI:-""}
export GIT_REF=${GIT_REF:-"master"}

# The project components
# - defaults to the support the Simple Project Structure
export components=${components:-"."}

# The builds to be triggered after buildconfigs created (not auto-triggered)
export builds=${builds:-""}

# The images to be tagged after build
export images=${images:-""}

# The routes for the project
export routes=${routes:-""}
# ===========================================================================================================

# ===========================================================================================================
# Test for important parameters.
# Throw errors/warnings if they are not defined.
# -----------------------------------------------------------------------------------------------------------
# ToDo:
# - Fill in this section.
# ===========================================================================================================
