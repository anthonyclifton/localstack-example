#!/bin/bash

dir="localstack/temporary"

vagrant up

cd infrastructure-as-code


if [[ ! -e $dir ]]; then
    mkdir $dir
elif [[ ! -d $dir ]]; then
    echo "$dir already exists but is not a directory" 1>&2
fi

rsync -avr --exclude='main.tf' aws/ localstack

cd localstack

if [[ ! -e ".terraform" ]]; then
  terraform init
fi

terraform apply