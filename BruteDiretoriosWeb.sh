#!/usr/bin/env bash

#Script que faz bruteforce de diretórios web em sites
#dia 20 de maio ás 10:03 (manhã)
#Apenas faz o bruteforce e na saída do script mostra as URLs disponíveis
#Irei usar para uso pessoas e também irei tentar aperfeiçoar!


domain=$1
COR_RED="\e[31;1;4m"
COR_YELLOW="\e[33;1;1m"

  while read dir;do
    if wget $domain/$dir &> /dev/null;then
      echo -e ${COR_YELLOW}"Diretório encontrado: " ${COR_RED}"$1/$dir"
    fi
  done < listadiretorios.txt
