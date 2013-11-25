#!/bin/bash

PROJECT_ROOT=$PWD

(
cd tools/pack
ANDROID_IMAGE_OUT=${PROJECT_ROOT}/out/target/product/cubieboard1 ./pack -c sun4i -p android -b cubieboard
)

