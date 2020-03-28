#!/usr/bin/env sh

set -e

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

# Functions

function stringRegexValidation {
    if [[ ! "${1}" =~ ^[a-z0-9-]+$ ]]; then
        echo "${FONT_RED}${2} name should only contain lowercase letters, numbers and hyphens${FONT_NC}"
        exit 2
    fi
}

function inputStringValidation {
    if [[ -z "${1}" ]]; then
        echo "${FONT_RED}${2} name has to be defined${FONT_NC}"
        exit 1
    fi

    stringRegexValidation "${1}" "${2}"
}

# Questions
read -p 'Organisation name: ' ORGANISATION_NAME
inputStringValidation "${ORGANISATION_NAME}" 'Organization'

read -p 'Application name: ' APPLICATION_NAME
inputStringValidation "${APPLICATION_NAME}" 'Application'

echo "${FONT_BOLD}Downloading bootstrap files (using version ${BOOTSTRAP_PROJECT_VERSION})...${FONT_NC}"
curl -sL ${BOOTSTRAP_PROJECT_ARCHIVE_URL} | tar zx

echo "${FONT_BOLD}Renaming directories...${FONT_NC}"
mv ${BOOTSTRAP_PROJECT_ARCHIVE_DIRNAME}/src ${APPLICATION_NAME}
rm -rf ${BOOTSTRAP_PROJECT_ARCHIVE_DIRNAME}

cd ${APPLICATION_NAME}

go mod init ${ORGANISATION_NAME}/${APPLICATION_NAME}

sed -i '' 's/my-app/'${APPLICATION_NAME}'/g' ./README.md ./.gitignore ./main.go ./cmd/main.go ./lambda/aws.go ./Makefile
sed -i '' 's/my-organization/'${ORGANISATION_NAME}'/g' ./README.md ./main.go ./cmd/main.go ./lambda/aws.go ./Makefile

echo "${FONT_BOLD}Project ${APPLICATION_NAME} successfully created.${FONT_NC}"
