#!/bin/bash

docker run -it --rm  --volume "$PWD":/root/pysrc  snafuz/pyvim vim
