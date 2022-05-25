#!usr/bin/env bash

#Script que tenta fazer o reconhecimento de subdominios de sites
#e faz a conversao de nomes para ips, caso o usuário desejar
#iniciei dia 14 de maio, talvez haja mais alteracoes
#ultilizado o wget para pegar o código fonte da pagina e localizar as informações-chaves




#VARIAVEIS
{
PEGA_WGET="$(wget $2) $(grep href index.html | cut -d "/" -f 3 | grep "\." | cut -d '"' -f 1 | grep -v "<l" > lista.txt)"
} &> /dev/null


COR_VERMELHO="\e[31;1;1m"
COR_AMARELO="\e[33;1;1m"
COR_VERDE="\e[32;1;1m"
COR_ROSA="\e[35;1;1m"
COR_BRANCO="\e[37;1;1m"
COR_PISCANTE="\e[31;1;5m"


MENSAGEM_INICIO="
$(basename $0) - MENU BOAS VINDAS

Esse script tenta fazer o reconhecimento de possíveis subdominios de sites!

 -h (Mostrar menu de ajuda)
 -r (Coloque a frente a URL do site alvo)
  Tecla (a) Vai te fornecer os IPs dos domínios
  Tecla (b) Não vai fornercer os IPs dos domínios e vai sair do script
"
#------------------------------------------------------------------------------------------------------------------------------------------

#CÓDIGO DO PROGRAMA
case "$1" in
  -h) echo "$MENSAGEM_INICIO" && exit 0                                      ;;
  -r) echo -e "${COR_VERMELHO}Verificando o host... \e[m \n" "$PEGA_WGET"    ;;
   *) echo -e "${COR_AMARELO}$0: PARAMETRO INVÁLIDO! Digite -h" && exit 0                                      ;;
esac

echo -e "${COR_AMARELO}O que deseja fazer a seguir? Digite: \n"
echo -e "${COR_VERDE} (a) Obter o IP dos domínios \n"
echo -e "${COR_ROSA} (b) Não obter o IP dos domínios e sair do script \e[m \n"
read -sn1 opcao

if [ "$opcao" = "a" ];then
  for urls in $(cat lista.txt);do host $urls;done > ips.txt
  echo "Os IPs dos domínios estão no documento ips.txt"
  echo
  echo "A lista de domínios está no documento lista.txt"
elif [ "$opcao" = "b" ];then
  echo -e "${COR_PISCANTE} Saiu... \e[m"
fi

exit 0
