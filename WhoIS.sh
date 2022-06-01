#!/usr/bin/env bash

#Shell que consulta o nome do domínio na base de dados da IANA (conselho que administra a internet) e da um retorno
#do conselho que administra aquele domínio, assim facilitando um pouco o trabalho de reconhecimento
#Qualquer falso-positivo, verifique manualmente os domínios, na dúvida, o manual SEMPRE funciona


resposta="$(whois -h whois.iana.org $1 | grep refer | cut -d ":" -f 2)"

#echo "$resposta" > /dev/null

whois -h $resposta $1
