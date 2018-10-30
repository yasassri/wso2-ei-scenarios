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


get_product_home() {
    PRODUCT_NAME=`grep -w "$PROP_PRODUCT_NAME" ${FILE1} | cut -d'=' -f2`
    PRODUCT_VERSION=`grep -w "$PROP_PRODUCT_VERSION" ${FILE1} | cut -d'=' -f2`

    echo $REM_DIR/storage/$PRODUCT_NAME-$PRODUCT_VERSION
}

PRODUCT_HOME=$(get_product_home)

git clone $repo
cd $TEST_DIR
mvn clean install

scp -o StrictHostKeyChecking=no -r -i ${key_pem} ${user}@${host}:${PRODUCT_HOME}/repository/logs ${DIR}
cp integration/mediation-tests/tests-service/target/surefire-reports ${DIR}