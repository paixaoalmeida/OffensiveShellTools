#!/usr/bin/env bash


#Script que faz bruteforce de subdominios web (algum dia que não lembro)

#dia 23 de maio ás 17:19
#Menu de ajuda
#Alguns ajustes de melhoria de aparencia
#nova estrutura de código com elif etc
#É necessário ter uma lista para o brute force (listadns.txt) (eu tenho no meu sistema)

domain=$2

COR_VERMELHO="\e[31;1;4m \n"

COR_YELLOW="\e[33;1m"

MENSAGEM_DE_AJUDA="
$(basename $0) - BruteForcDomain / MENU DE AJUDA
MODO DE USO:
$0 -a URL sem o WWW
"
#-------------------------------------------------------------------------------
if [ $1 =  ];then
  echo $MENSAGEM_DE_AJUDA
elif [ $1 = "-a" ];then
  while read sub;do
    if host $sub.$domain &> /dev/null;then
      echo -e ${COR_VERMELHO} "Dominios encontrados:" ${COR_YELLOW}"$sub.$domain";
    fi
  done < listadns.txt
fi
