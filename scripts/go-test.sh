#!/usr/bin/env bash

if command -v dmenu; then
  echo dmenu found
else
  yes | sudo apt-get install suckless-tools
fi

TEST=`grep -oP 'func\s+\K(Test\w+)' $1 | dmenu`

go test -v -timeout 100m . -run $TEST
