#!/bin/bash

dir="localstack"

vagrant up

# add wait until localstack is actually ready
# temporarily, sleep for a bit
sleep 30

if [[ ! -e $dir ]]; then
    mkdir $dir
elif [[ ! -d $dir ]]; then
    echo "$dir already exists but is not a directory" 1>&2
fi

cp resources/localstack.tf localstack

rsync -avr --exclude='main.tf' infrastructure-as-code/ localstack

cd localstack

if [[ ! -e ".terraform" ]]; then
  terraform init
fi

terraform apply -auto-approve