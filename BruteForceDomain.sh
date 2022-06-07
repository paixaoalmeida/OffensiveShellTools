#!/usr/bin/env bash


#Script que faz bruteforce de subdominios web (algum dia que não lembro)

#dia 23 de maio ás 17:19
#Menu de ajuda
#Alguns ajustes de melhoria de aparencia
#nova estrutura de código com elif etc
#É necessário ter uma lista para o brute force (listadns.txt) (eu tenho no meu sistema)

#Alterações para fazer um reonhecimento de mais subdominios e seus ALIAS, também serve
#para tentar fazer subdomain takeover #dia 6 de junho
#Faz uma pesquisa pelos registros CNAMES dos subdominios para tentar achar subdominios interessantes
#função -s #dia 6 de junho

domain=$2

COR_VERMELHO="\e[31;1;4m \n"

COR_YELLOW="\e[33;1m"

MENSAGEM_DE_AJUDA="
$(basename $0) - BruteForcDomain / MENU DE AJUDA
MODO DE USO:
$0 -a URL sem o WWW (Faz brute force de subdominios)
$0 -s URL sem o WWW (Faz brute force de subdominios mas usando os registros CNAMES)

By WhiteRose / github.com/paixaoalmeida
"
#-------------------------------------------------------------------------------
if [ $1 =  ];then          #if for the script
  echo $MENSAGEM_DE_AJUDA
elif [ $1 = "-a" ];then
  while read sub;do
    if host $sub.$domain &> /dev/null;then          #comand host and default output
      echo -e ${COR_VERMELHO} "Dominios encontrados:" ${COR_YELLOW}"$sub.$domain";
    fi
  done < listadns.txt          #u need to have that "listadns.txt" in ur path, its in the repository
elif [ $1 = "-s" ];then
  for dns in $(cat listadns.txt);do host -t cname $dns.$domain;done | grep "alias for" #consulting valid cname registers
fi
