#!/bin/bash

dir="localstack"

vagrant destroy

if [[ -e $dir ]]; then
    rm -rfv $dir
fi
