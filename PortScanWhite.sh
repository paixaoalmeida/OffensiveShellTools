#!/usr/bin/env bash

#Whiterose
#Script que verifica porta aberta num host, seja em rede local ou na internet
#14 de Maio 11:30 da manhã
#Adicionei mensagem de ajuda, mensagem se a porta estiver aberta e mensagem se a porta estiver fechada
#Falta adicionar quando a porta estiver filtrada/com firewall (eu sei qual é a resposta mas n consigo encontrar no hping)

#Fiz algumas pequenas alteracoes no visual e na saida do script (dia 14 maio)
#ultilizado o hping3, que voce pinga e ele fornece a resposta que teve na porta especifica do host
#depois disso foi filtrar as informacoes com grep, cut etc

#dia 23 de maio ás 16:46
#VOCÊ DEVE RODAR O SCRIPT COMO ROOT, OTHERWISE VAI DAR UMA MENSAGEM "RUN AS ROOT" OU O SCRIPT SIMPLESMENTE
#NÃO VAI RODAR!
#Algumas mudanças de visual para melhor apreciação da ferramenta
#Se demorar mto pouco para o resultado, significa que a URL está errada (tenho que dar uma mensagem de erro p URL inválida)

#-----------------------------------------------------------------------------------------------------------------

#VARIAVEIS

MENSAGEM_HELP="
$(basename $0) - SCAN WHITEROSE / MENU DE AJUDA
MODO DE USO: $0 IP ALVO e porta alvo
SÓ FUNCIONA SE RODAR COMO SUDO!!!!!!
"

#PORTA_ABERTA=$(hping3 -S -p $2 -c 1 $1 2> /dev/null | grep flags=SA | cut -d " " -f 2 | cut -d = -f 2)

COR_VERMELHO="\e[31;4m"
COR_AMARELO="\e[33;4m"
#------------------------------------------------------------------------------------------------------------------

#CÓDIGO DO PROGRAMA
if [ $(id -u) = 1000 ];then
  echo -e ${COR_VERMELHO}"RUN AS ROOT \e[m" && exit               #ESTÁ RODANDO COMO ROOT?
fi

#------------------------------------------------------------------------------------------------------------------

if [ $1 =  ];then
  echo "$MENSAGEM_HELP"                #Hping3, remove as mensagem de erro e filtra somente as flags SYN e ACK
else                                   #Que são as flags padrão de quando há resposta positiva
hping3 -S -p $2 -c 1 $1 2> /dev/null | grep flags=SA | cut -d " " -f 2 | cut -d = -f 2
if [ $(hping3 -S -p $2 -c 1 $1 2> /dev/null | grep flags=SA | cut -d " " -f 2 | cut -d = -f 2) ];then
  echo
  echo -e ${COR_VERMELHO}"Porta $2 aberta no host acima"
else
  echo -e ${COR_AMARELO}"Porta $2 sem serviço/filtrada no host"
fi fi
