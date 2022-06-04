#!/usr/bin/env bash
#dia 24 de maio ás 11:18
#Script que analisa portas populares de um host na internet com uma lista
#Pode ser feito direto no bash sem IDE, mas eu gosto de documentar tudo e deixar colorido rs
#Modo de uso: sudo bash script.sh IP do host alvo

#Dia 3 de junho ás 22:44
#Adicionei um menu de ajuda personalizado, um case para o primeiro parametro (organização do código)
#Amanha pretendo colocar as funções novas no programa! (v1.1)

#-----------------------------------------------------------------------------------------

#VARIAVEIS

COR_VERMELHO="\e[31;1m"

COR_AMARELO="\e[33;1m"

MENSAGEM_HELP="

  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  >      SCAN DE PORTAS TCP POPULARES!                    <
  >      $(basename $0)                               <
  >                                                       <
  >                                                       <
  >      .......                                          <
  >      .     .         .......         SCAN             <
  >      ....... ......  .    .   ......                  < ---------> MODOO DE USO
  >      .       .    .  .   .      .                     <
  >      .       ......  .    ..    .                     < ---> PopularTcpPorts.sh -a (Scan portas TCP populares E com delay)
  >                                                       <
  >                                                       < ---> PopularTcpPorts.sh -l (Scan de todas as portas TCP e sem delay)
  >                                                       <
  >                                                       <
  >                                                       <
  > By:Whiterose / Github.com/paixaoalmeida               <
  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

"



#------------------------------------------------------------------------------------------------

#CÓDIDO DO PROGRAMA
case "$1" in
  *) echo "$MENSAGEM_HELP" && exit 0 ;;
esac


while read portas;do
  if [ $(hping3 -S -p $portas -c 1 $1 2> /dev/null | grep flags=SA | cut -d " " -f 6 | cut -d = -f 2) ];then
    echo -e ${COR_VERMELHO}"Porta $portas ABERTA no host com"${COR_AMARELO} "IP $1"
  fi
done < portas.txt

exit 0
