#!/usr/bin/env bash

FILENAME=$1

if [ "${FILENAME: -3}" == ".tf" ]; then
  terraform fmt $1
fi

if [ "${FILENAME: -3}" == ".go" ]; then
  go fmt $1
fi
