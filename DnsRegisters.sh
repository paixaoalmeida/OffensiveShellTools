#!/usr/env/bin bash

#Script que realiza a consulta de díversos registros dns como o txt por exemplo
#inicio do projeto: 7 de junho
#dia 8 de junho: adicionado menu de ajuda e também a consulta de registro CNAME
#topção -a mais o uso da url alvo

#18 de junho
#Alguma alterações na estrutura do código do script
#Ainda está funcional
#-----------------------------------------------------------------------------------------

#VARIAVEIS

HELP_MESSAGE="
$(basename $0) - MENU DE AJUDA

O script faz díversas consultas com registros dns no domínio alvo e te fornece algumas juices infos

MODO DE USO: $0 -a URL ou IP do host

By WhiteRose / github.com/paixaoalmeida
"

YELLOW_COLOR="\e[33;1;1m"

#----------------------------------------------------------------------------------
#CÓDIGO DO PROGRAMA

case "$1" in
  -h) echo "$HELP_MESSAGE"                                                                                           ;;


  -a) echo -e ${YELLOW_COLOR}"Registros a (Endereço IPV4 do domínio $2) \e[m \n"

      host -t aaaa $2
      echo -e ${YELLOW_COLOR}"Registros aaaa (Endereço IPV6 do domínio $2) \e[m \n"

      host -t ns $2
      echo -e ${YELLOW_COLOR}"Registros ns (Servidores dns do domínio $2) \e[m \n"

      host -t mx $2
      echo -e ${YELLOW_COLOR}"Registros mx (Servidores de e-mail do domínio $2) \e[m \n"

      host -t CNAME $2
      echo -e ${YELLOW_COLOR}"Registros CNAME (Apelido de um subdominio do $2) \e[m \n"

      host -t HINFO $2
      echo -e ${YELLOW_COLOR}"Registros HINFO (Informações do host $2) \e[m \n"

      host -t txt $2
      echo -e ${YELLOW_COLOR}"Registros txt (Text string, exemplo:Config. SPF do servidor de e-mail) \e[m \n"

      host -t SOA $2
      echo -e ${YELLOW_COLOR}"Registros SOA (Responsável pelo domínio $2) \e[m \n"                                    ;;


   *) echo "PARAMETRO INVÁLIDO! Consulte -h"                                                                          ;;
esac

#-----------------------------------------------------------------------------------
#EXECUÇÕES DO PROGRAMA
