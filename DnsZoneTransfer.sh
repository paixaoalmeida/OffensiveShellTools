#!/usr/bin/env bash

#Script que realiza a consulta dos nameservers de um alvo, e tenta uma transferencia de zona
#pode ser feito no bash, mas eu gosto de documentar e deixar tudo bonitinho

#dia 23 de maio ás 17:38
#Script funcional, não sei se dá para fazer mais do que isso sinceramente, funciona perfeitamente
#Não tem para que enfeitar ele

#----------------------------------------------------------------------------------------------------
MENSAGEM_USO="
$(basename $0) - DnsZoneTransfer / MENU DE AJUDA

-MODO DE USO: $0 -a e URL do host alvo

O script verifica os ns e tenta uma tranferência de zona
"
#---------------------------------------------------------------------------------------------------

if [ $1 =  ];then
  echo $MENSAGEM_USO
elif [ $1 = "-a" ];then
  for servers in $(host -t ns $2 | cut -d " " -f4);do host -l -a $2 $servers;done
fi

exit 0
