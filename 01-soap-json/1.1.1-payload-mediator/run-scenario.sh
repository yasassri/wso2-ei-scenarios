#!/bin/bash

repo='https://github.com/yasassri/product-dummy.git'
DIR='product-dummy'

git clone $repo
cd $DIR
mvn clean install