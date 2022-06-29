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

#Dia 29 de Junho
#Havia um bug no código - arrumado
#Novo banner, nova formatação do stdout
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

__PortMessage__() {
echo -e ${COR_ROSA}"╭╮╱╱╱╱╱╱╭╮╱╱╱╱╱╭━╮╱╱╱╱╱╱╱╱╱╱╱╱╱╭╮"
echo "┃┃╱╱╱╱╱╭╯╰╮╱╱╱╱┃╭╯╱╱╱╱╱╱╱╱╱╱╱╱╱┃┃"
echo "┃╰━┳━┳╮┣╮╭╋━━╮╭╯╰┳━━┳━┳━━┳━━╮╭━╯┣━━┳╮╭┳━━┳┳━╮"
echo "┃╭╮┃╭┫┃┃┃┃┃┃━┫╰╮╭┫╭╮┃╭┫╭━┫┃━┫┃╭╮┃╭╮┃╰╯┃╭╮┣┫╭╮╮"
echo "┃╰╯┃┃┃╰╯┃╰┫┃━┫╱┃┃┃╰╯┃┃┃╰━┫┃━┫┃╰╯┃╰╯┃┃┃┃╭╮┃┃┃┃┃"
echo "╰━━┻╯╰━━┻━┻━━╯╱╰╯╰━━┻╯╰━━┻━━╯╰━━┻━━┻┻┻┻╯╰┻┻╯╰╯"
echo
}

domain=$2
CHAVE=0

COR_ROSA="\e[37;1m"
COR_VERMELHO="\e[31;1m"
COR_YELLOW="\e[33;1;4m"

#------------------------------------------------------------------------------------------------------------
#VERIFICAÇÕES DO PROGRAMA

#Sair do script com CTRL+C
trap __Ctrl_c__ INT

__Ctrl_c__() {
    echo -e ${COR_AMARELO}"Ação abortada!"
    exit 1
}


[ ! -e /usr/bin/host ] && echo "Instala o pacote net-tools na sua distribuição Linux!" #net tools instalado?
[ ! -e listadns.txt ] && echo "Você está com a lista para bruteforce nesse diretório?" #A lista está no diretório?

#---------------------------------------------------------------------------------------------------------------------
#CÓDIGO DO PROGRAMA

#Case com chaves de ativação e funções -s, -a e -h
case "$1" in
  -s) __PortMessage__
      echo -e ${COR_YELLOW}"Bruteforce dos subdomínios e consultando registros CNAME \e[m \n"
      for dns in $(cat listadns.txt);do host -t cname $dns.$domain;done | grep "alias for"                                                                                                ;;

  -a) CHAVE=1                                                                                       ;;
  -h) echo "$MENSAGEM_DE_AJUDA" && exit 0                                                           ;;
   *) echo "PARAMETRO INVÁLIDO! DIGITE -h" && exit 1                                                ;;
esac

#----------------------------------------------------------------------------------------------------------------------
#EXECUÇÕES DO PROGRAMA

#Bruteforce dos subdominios (-a)
[ $CHAVE -eq 1 ] && __PortMessage__
echo -e ${COR_YELLOW}"Realizando Bruteforce nos subdomínios do alvo \e[m \n"
while read sub;do
  if host $sub.$domain &> /dev/null;then
    echo -e ${COR_VERMELHO}"Dominio encontrado:\e[m" $sub.$domain
  fi
done < listadns.txt
