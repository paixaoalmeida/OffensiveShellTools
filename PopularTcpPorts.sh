#!/usr/bin/env bash
#dia 24 de maio ás 11:18
#Script que analisa portas populares de um host na internet com uma lista
#Pode ser feito direto no bash sem IDE, mas eu gosto de documentar tudo e deixar colorido rs
#Modo de uso: sudo bash script.sh IP do host alvo
#-----------------------------------------------------------------------------------------

#VARIAVEIS

COR_VERMELHO="\e[31;1m"

COR_AMARELO="\e[33;1m"

#------------------------------------------------------------------------------------------------

#CÓDIDO DO PROGRAMA

while read portas;do
  if [ $(hping3 -S -p $portas -c 1 $1 2> /dev/null | grep flags=SA | cut -d " " -f 6 | cut -d = -f 2) ];then
    echo -e ${COR_VERMELHO}"Porta $portas ABERTA no host com"${COR_AMARELO} "IP $1"
  fi
done < portas.txt

exit 0
