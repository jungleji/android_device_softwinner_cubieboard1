#!/bin/bash

function cdev ()
{
    tdevice=$(get_build_var TARGET_DEVICE)
    cd $T/device/*/$tdevice
}
