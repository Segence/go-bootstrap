#!/usr/bin/env sh

# Main configuration

BOOTSTRAP_PROJECT_NAME=go-bootstrap

BOOTSTRAP_PROJECT_VERSION=$1
if [[ -z "${BOOTSTRAP_PROJECT_VERSION}" ]]; then
    BOOTSTRAP_PROJECT_VERSION=master
fi

BOOTSTRAP_PROJECT_ARCHIVE_DIRNAME=${BOOTSTRAP_PROJECT_NAME}-${BOOTSTRAP_PROJECT_VERSION}
BOOTSTRAP_PROJECT_ARCHIVE_URL=https://github.com/segence/${BOOTSTRAP_PROJECT_NAME}/archive/${BOOTSTRAP_PROJECT_VERSION}.tar.gz

# Constants

FONT_ESC=$(printf '\033')
FONT_BOLD=${FONT_ESC}[1m
FONT_RED="${FONT_ESC}[0;31m"
FONT_NC=${FONT_ESC}[0m # No colour

# Questions
read -p 'Organisation name: ' ORGANISATION_NAME
if [[ -z "${ORGANISATION_NAME}" ]]; then
    echo "${FONT_RED}Organisation name has to be defined${FONT_NC}"
    exit 1
fi

read -p 'Application name: ' APPLICATION_NAME
if [[ -z "${APPLICATION_NAME}" ]]; then
    echo "${FONT_RED}Application name has to be defined${FONT_NC}"
    exit 1
fi

echo "${FONT_BOLD}Downloading bootstrap files (using version ${BOOTSTRAP_PROJECT_VERSION})...${FONT_NC}"
curl -sL ${BOOTSTRAP_PROJECT_ARCHIVE_URL} | tar zx

echo "${FONT_BOLD}Renaming directories...${FONT_NC}"
mv ${BOOTSTRAP_PROJECT_ARCHIVE_DIRNAME}/src ${APPLICATION_NAME}
rm -rf ${BOOTSTRAP_PROJECT_ARCHIVE_DIRNAME}

cd ${APPLICATION_NAME}

go mod init ${ORGANISATION_NAME}/${APPLICATION_NAME}

sed -i '' 's/my-app/'${APPLICATION_NAME}'/g' ./README.md
sed -i '' 's/my-app/'${APPLICATION_NAME}'/g' ./.gitignore
sed -i '' 's/my-app/'${APPLICATION_NAME}'/g' ./main.go
sed -i '' 's/my-organization/'${ORGANISATION_NAME}'/g' ./main.go

echo "${FONT_BOLD}Project ${APPLICATION_NAME} successfully created.${FONT_NC}"
