#!/bin/bash

repo='https://github.com/yasassri/product-dummy.git'
TEST_DIR='product-dummy'
DIR=$2
export DATA_BUCKET_LOCATION=$DIR
FILE1=${DIR}/infrastructure.properties
FILE2=${DIR}/testplan-props.properties
PROP_KEY=keyFileLocation      #pem file
PROP_HOST=WSO2PublicIP           #host IP
PROP_PRODUCT_NAME=ProductName
PROP_PRODUCT_VERSION=ProductVersion
PROP_REMOTE_DIR=REMOTE_WORKSPACE_DIR_UNIX

host=`grep -w "$PROP_HOST" ${FILE1} ${FILE2} | cut -d'=' -f2`
key_pem=`grep -w "$PROP_KEY" ${FILE1} ${FILE2} | cut -d'=' -f2`
REM_DIR=`grep -w "$PROP_REMOTE_DIR" ${FILE1} ${FILE2} | cut -d'=' -f2`
user='centos'

git clone $repo
cd $TEST_DIR
mvn clean install

Echo "Copying surefire-reports to data bucket"

cp -r integration/mediation-tests/tests-service/target/surefire-reports ${DIR}
ls ${DIR}


