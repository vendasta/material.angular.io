#!/bin/bash

#
# Script that fetches material2 assets from the material2-docs-content repo.
#

cd $(dirname ${0})/../

# Directory where documentation assets should be copied to (overviews, api docs)
documentsDestination=./src/assets/documents/

# Directory where the live example assets will be copied to.
examplesDestination=./src/assets/

# Path to the directory where the Stackblitz examples should be copied to.
stackblitzDestination=./src/assets/stackblitz/

# Path to the @angular/material-examples package in the node modules.
materialExamplesDestination=./node_modules/@angular/material-examples

# Path to the directory where the docs-content will be cloned.
docsContentPath=./tmp/material2-docs-content

# Create all necessary directories if they don't exist.
mkdir -p ${documentsDestination}
mkdir -p ${examplesDestination}
mkdir -p ${stackblitzDestination}
mkdir -p ${materialExamplesDestination}

# Remove previous repository if directory is present.
rm -Rf ${docsContentPath}

mkdir tmp
cd tmp
git remote add material2 https://github.com/vendasta/material2
git fetch material2
latestCommit=$(git log material2/master | head -n 1 | awk '{print $2}')
materialDocsFileUrl=$(curl -X GET "https://www.googleapis.com/storage/v1/b/vendasta-material-docs/o" | grep `git log material2/master | head -n 1 | awk '{print $2}'` | grep mediaLink | awk '{print $2}' | cut -d '"' -f 2)
curl -X GET -o ./material-docs.tar.gz ${materialDocsFileUrl}
tar -xzvf material-docs.tar.gz
rm -rf material-docs.tar.gz
cd material2-docs-content
echo "material2-docs-content unpacked to:"
ls
docsContentPath=$(pwd)
cd ../..

# Copy all document assets (API, overview and guides).
cp -R ${docsContentPath}/api/ ${documentsDestination}
cp -R ${docsContentPath}/overview/ ${documentsDestination}
cp -R ${docsContentPath}/guides ${documentsDestination}

# Copy the example assets to the docs.
cp -R ${docsContentPath}/examples ${examplesDestination}

# Copy the StackBlitz examples to the docs.
cp -R ${docsContentPath}/stackblitz/examples ${stackblitzDestination}

# Manually install the @angular/material-examples p ackage from the docs-content.
cp -R ${docsContentPath}/examples-package/* ${materialExamplesDestination}
