#!/usr/bin/env bash

#Script que faz bruteforce de subdominios web de um alvo!

#dia 23 de maio ás 17:19
#Menu de ajuda
#Alguns ajustes de melhoria de aparencia
#nova estrutura de código com elif etc
#É necessário ter uma lista para o brute force (listadns.txt) (pasta listas do meu repositório)

#Alterações para fazer um reonhecimento de mais subdominios e seus ALIAS, também serve
#para tentar fazer subdomain takeover #dia 6 de junho
#Faz uma pesquisa pelos registros CNAMES dos subdominios para tentar achar subdominios interessantes
#função -s #dia 6 de junho

#Dia 19 de Junho
#Alterações na estrutura do código
#Alguns ajustes de design e técnicos
#Está totalmente funcional

#-------------------------------------------------------------------------------------------------------------
#VARIÁVEIS

MENSAGEM_DE_AJUDA="
$(basename $0) - BruteForceDomain v1.0 / MENU DE AJUDA

MODO DE USO:
$0 -a URL sem o WWW (Faz brute force de subdominios)

$0 -s URL sem o WWW (Faz brute force de subdominios e consulta os registros CNAMES)

Necessário uma lista para realizar o brute force (listadns.txt) na pasta 'listas'

By WhiteRose / github.com/paixaoalmeida
"

domain=$2
CHAVE=0
CHAVE_1=0

COR_VERMELHO="\e[31;1;4m \n"
COR_YELLOW="\e[33;1m"

#------------------------------------------------------------------------------------------------------------
#VERIFICAÇÕES DO PROGRAMA

[ ! -e /usr/bin/host ] && echo "Instala o pacote net-tools na sua distribuição Linux!" #net tools instalado?
[ ! -e listadns.txt ] && echo "Você está com a lista para bruteforce nesse diretório?" #A lista está no diretório?

#---------------------------------------------------------------------------------------------------------------------
#CÓDIGO DO PROGRAMA

case "$1" in
  -h) echo "$MENSAGEM_DE_AJUDA"               ;;
  -a) CHAVE=1                                 ;;
  -s) CHAVE_1=1                               ;;
   *) echo "PARAMETRO INVÁLIDO! DIGITE -h"    ;;
esac

#----------------------------------------------------------------------------------------------------------------------
#EXECUÇÕES DO PROGRAMA

#Bruteforce dos subdominios (-a)
[ $CHAVE -eq 1 ] &&
echo -e ${COR_YELLOW}"Realizando Bruteforce nos subdomínios do alvo... \e[m \n"
while read sub;do
  if host $sub.$domain &> /dev/null;then
    echo -e ${COR_VERMELHO} "Dominios encontrados:" ${COR_YELLOW}"$sub.$domain";
  fi
done < listadns.txt

#Bruteforce dos subdomínios com consulta de registros CNAME
[ $CHAVE_1 -eq 1 ] &&
echo -e ${COR_YELLOW}"Bruteforce dos subdomínios e consultando registros CNAME... \e[m \n"
for dns in $(cat listadns.txt);do host -t cname $dns.$domain;done | grep "alias for" #Filtrando apenas cons. válidas
