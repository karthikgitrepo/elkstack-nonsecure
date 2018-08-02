#!/bin/sh

if [ $# -lt 1 ]
then
  echo "Usage: $0 <playbook (without .yml)> [debug]"
  echo "Example sh runansible.sh site debug"
  exit 1
fi

export ANSIBLE_HOST_KEY_CHECKING=False

DEBUG=""

if [ "debug" = "$2" ]
then
  DEBUG="-C"
fi


if [ "local" = "$1" ]
then
  ansible-playbook $DEBUG --ask-pass  -i hosts $1.yml
  #ansible-playbook $DEBUG --ask-pass --ask-become-pass --become-method=sudo -i hosts $1.yml
else
  ansible-playbook $DEBUG --ask-pass -i hosts $1.yml 
  #ansible-playbook $DEBUG --ask-pass --ask-become-pass --become-method=sudo -i hosts $1.yml 
fi

