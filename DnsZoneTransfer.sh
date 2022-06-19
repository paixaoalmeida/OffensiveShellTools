#!/usr/bin/env bash

#Script que realiza a consulta dos nameservers de um alvo, e tenta uma transferencia de zona
#pode ser feito no bash, mas eu gosto de documentar e deixar tudo bonitinho

#dia 23 de maio ás 17:38
#Script funcional, não sei se dá para fazer mais do que isso sinceramente, funciona perfeitamente
#Não tem para que enfeitar ele

#Dia 19 de junho
#Alterações na estrutura do código
#Alterações no design

#----------------------------------------------------------------------------------------------------
#VARIAVEIS

COR_YELLOW="\e[33;1m"
CHAVE=0

MENSAGEM_USO="
$(basename $0) - DnsZoneTransfer / MENU DE AJUDA

-MODO DE USO: $0 -a e URL do host alvo

O script verifica os ns e tenta uma tranferência de zona
"
#---------------------------------------------------------------------------------------------------
#CÓDIGO DO PROGRAMA

case "$1" in
  -h) echo "$MENSAGEM_USO"                   ;;
  -a) CHAVE=1                                ;;
   *) echo "PARAMETRO INVÁLIDO! DIGITE -h"   ;;
esac

#------------------------------------------------------------------------------------------------------
#EXECUÇÕES DO PROGRAMA

[ $CHAVE -eq 1 ] &&
echo -e ${COR_YELLOW}"Consultando os ns e tentando uma transferência de zona... \e[m \n"
for servers in $(host -t ns $2 | cut -d " " -f4);do host -l -a $2 $servers;done
