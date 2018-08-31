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

# Git HTTP clone URL for the material2-docs-content repository.
docsContentRepoUrl="https://github.com/angular/material2-docs-content"

# Path to the directory where the docs-content will be cloned.
docsContentPath=/tmp/material2-docs-content

# Create all necessary directories if they don't exist.
mkdir -p ${documentsDestination}
mkdir -p ${examplesDestination}
mkdir -p ${stackblitzDestination}
mkdir -p ${materialExamplesDestination}

# Remove previous repository if directory is present.
rm -Rf ${docsContentPath}

# Clone the docs-content repository.
git clone ${docsContentRepoUrl} ${docsContentPath}

# Set commit to the installed version of angular material
materialVersion=$(npm list @angular/material | tail -n 2 | head -n 1 | sed 's#.*/material@\(.*\)#\1#' | tr -d '[:space:]')
cd ${docsContentPath}
commitHash=$(git log | grep "master" -B 4 | grep "changelog" -B 4 | grep ${materialVersion} -B 4 | grep "commit" | awk '{print $2}' | head -n 1)
echo "Getting docs content from angular/material2-docs-content"
echo "@angular/material version: ${materialVersion}, docs commit: ${commitHash}"
git reset --hard ${commitHash}
cd -

# Copy all document assets (API, overview and guides).
cp -R ${docsContentPath}/api ${documentsDestination}
cp -R ${docsContentPath}/overview ${documentsDestination}
cp -R ${docsContentPath}/guides ${documentsDestination}

# Copy the example assets to the docs.
cp -R ${docsContentPath}/examples ${examplesDestination}

# Copy the StackBlitz examples to the docs.
cp -R ${docsContentPath}/stackblitz/examples ${stackblitzDestination}

# Manually install the @angular/material-examples package from the docs-content.
cp -R ${docsContentPath}/examples-package/* ${materialExamplesDestination}
