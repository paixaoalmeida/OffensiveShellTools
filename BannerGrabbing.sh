#!/usr/bin/env bash

for portas in $(cat portas.txt);do nc -vv -w1 $1 $portas;done
