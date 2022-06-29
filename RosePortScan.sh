#!/usr/bin/env bash

#dia 24 de maio ás 11:18
#Script que analisa portas populares de um host na internet com uma lista
#Pode ser feito direto no bash sem IDE, mas eu gosto de documentar tudo e deixar colorido rs
#Modo de uso: sudo bash script.sh IP do host alvo

#Dia 3 de junho ás 22:44
#Adicionei um menu de ajuda personalizado, um case para o primeiro parametro (organização do código)
#Amanha pretendo colocar as funções novas no programa!

#Dia 4 de junho
#Adicionei os scans de portas populares com -a e de todas as portas com o -l
#Menu de ajuda, menu se der algum parametro inválido e também quando não houver parametro
#Alguns ajustes estéticos da saída do programa forama ajustados
#Coloquei delay no scan popular para tentar evitar bloqueio por ip (v1.0)

#Dia 14 de junho #Produção da versão v1.1 (começo)
#Adicionei validacao do pacote hping3 (necessário para rodar o programa)
#Validação de root para rodar o scan
#Nova Message help

#Dia 16: Começo de verdade do novo código e versao v1.1
#Diversas alterações no código para torna-lo mais versátil e "enxuto"
#Adicionado banner grabbing (simples e não tão intuitivo, mas funciona bem)
#Modificação quase que inteira do código
#Abaixei o delay, pois syn scan não completa conexão (havia me esquecido disso)
#Apaga todo o lixo do diretório do usuário após o scan e saídas do script

#Dia 23: Adicionado menu e função de abortar com CTRL+C

#Dia 28: Se não houver serviços nas portas, há uma mensagem de "sem serviço"

#-----------------------------------------------------------------------------------------
#VARIAVEIS

__PortMessage__() {
echo -e ${COR_VERMELHO}"___________________________________________________________________________________________________________\n"



echo -e ${COR_AMARELO}  "██████╗░░█████╗░░██████╗███████╗  ██████╗░░█████╗░██████╗░████████╗  ░██████╗░█████╗░░█████╗░███╗░░██╗"
echo -e ${COR_VERMELHO} "██╔══██╗██╔══██╗██╔════╝██╔════╝  ██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝  ██╔════╝██╔══██╗██╔══██╗████╗░██║"
echo -e ${COR_ROSA}     "██████╔╝██║░░██║╚█████╗░█████╗░░  ██████╔╝██║░░██║██████╔╝░░░██║░░░  ╚█████╗░██║░░╚═╝███████║██╔██╗██║"
echo -e ${COR_VERDE}    "██╔══██╗██║░░██║░╚═══██╗██╔══╝░░  ██╔═══╝░██║░░██║██╔══██╗░░░██║░░░  ░╚═══██╗██║░░██╗██╔══██║██║╚████║"
echo -e ${COR_AZUL}     "██║░░██║╚█████╔╝██████╔╝███████╗  ██║░░░░░╚█████╔╝██║░░██║░░░██║░░░  ██████╔╝╚█████╔╝██║░░██║██║░╚███║"

echo -e ${COR_VERMELHO}"___________________________________________________________________________________________________________\n"

}

MENSAGEM_HELP="


██████╗░░█████╗░░██████╗███████╗  ██████╗░░█████╗░██████╗░████████╗  ░██████╗░█████╗░░█████╗░███╗░░██╗
██╔══██╗██╔══██╗██╔════╝██╔════╝  ██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝  ██╔════╝██╔══██╗██╔══██╗████╗░██║
██████╔╝██║░░██║╚█████╗░█████╗░░  ██████╔╝██║░░██║██████╔╝░░░██║░░░  ╚█████╗░██║░░╚═╝███████║██╔██╗██║
██╔══██╗██║░░██║░╚═══██╗██╔══╝░░  ██╔═══╝░██║░░██║██╔══██╗░░░██║░░░  ░╚═══██╗██║░░██╗██╔══██║██║╚████║
██║░░██║╚█████╔╝██████╔╝███████╗  ██║░░░░░╚█████╔╝██║░░██║░░░██║░░░  ██████╔╝╚█████╔╝██║░░██║██║░╚███║
╚═╝░░╚═╝░╚════╝░╚═════╝░╚══════╝  ╚═╝░░░░░░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░  ╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝░░╚══╝

  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  >      SCAN DE PORTAS TCP POPULARES!          <
  >      $(basename $0)                         <
  >                                             <
  >                  ╱╱╱╱╱╱╭╮                   <
  >                  ╱╱╱╱╱╭╯╰╮                  <
  >                  ╭━━┳━┻╮╭╯                  <
  >                  ┃━━┫┃━┫┃                   <
  >                  ┣━━┃┃━┫╰╮                  <
  >                  ╰━━┻━━┻━╯                  <
  >                   ╭╮╭┳━━╮                   < ---> MENU DE AJUDA! VEJA O MODO DE USO ABAIXO!
  >                   ┃┃┃┃━━┫                   <
  >                   ┃╰╯┣━━┃                   < ---------> MODOO DE USO
  >                   ╰━━┻━━╯                   <
  >                 ╱╭━╮                        < ---> PopularTcpPorts.sh -a [ipdohost] (Scan portas TCP populares | Banner Grabbing)
  >                 ╱┃╭╯                        <
  >                 ╭╯╰┳━┳━━┳━━╮                < ---> PopularTcpPorts.sh -l [ipdohost] (Scan de todas as portas TCP | SYN scan)
  >                 ╰╮╭┫╭┫┃━┫┃━┫                <
  >                 ╱┃┃┃┃┃┃━┫┃━┫                <
  >                ╱╰╯╰╯╰━━┻━━╯                 <
  >                                             <
  >               v1.1 (18/06/22)               <
  >   By:Whiterose / Github.com/paixaoalmeida   <
  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

"

MENSAGEM_HELP_INVALIDO="

  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  >      SCAN DE PORTAS TCP POPULARES!                    <
  >      $(basename $0)                                  <
  >                                                       <
  >                                                       <
  >      .......                                          <
  >      .     .         .......         SCAN             <
  >      ....... ......  .    .   ......                  < ---------> MODOO DE USO
  >      .       .    .  .   .      .                     <
  >      .       ......  .    ..    .                     < ---> PopularTcpPorts.sh -a [ipdohost] (Scan portas TCP populares | Banner Grabbing)
  >                                                       <
  >                                                       < ---> PopularTcpPorts.sh -l [ipdohost] (Scan de todas as portas TCP | SYN scan)
  > --->   PARAMETRO INVÁLIDO! VEJA O MODO DE USO!   <--- <
  >                                                       <
  >                                                       <
  > By:Whiterose / Github.com/paixaoalmeida               <
  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"
MENSAGEM_HELP_HPING="
  VOCÊ NÃO TEM O PACOTE hping3 instalado!
  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  >      SCAN DE PORTAS TCP POPULARES!                    <
  >      $(basename $0)                                  <
  >                                                       <
  >                                                       <
  >      .......                                          <
  >      .     .         .......         SCAN             <
  >      ....... ......  .    .   ......                  < ---------> MODOO DE USO
  >      .       .    .  .   .      .                     <
  >      .       ......  .    ..    .                     < ---> PopularTcpPorts.sh -a [ipdohost] (Scan portas TCP populares | Banner Grabbing)
  >                                                       <
  >                                                       < ---> PopularTcpPorts.sh -l [ipdohost] (Scan de todas as portas TCP | SYN scan)
  > --> INSTALE O PACOTE hping3 | sudo apt install hping3 <
  > --> Ou qualquer outro instalador do seu sistema! <--- <
  >                                                       <
  > By:Whiterose / Github.com/paixaoalmeida               <
  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"

COR_SERV1="\e[37;1m"
COR_SERV="\e[37;4;1m"
COR_VERMELHO="\e[31;1m"
COR_AMARELO="\e[33;1m"
COR_BRANCO="\e[37;1;5m"
COR_ROSA="\e[35;1m"
COR_VERDE="\e[32;1m"
COR_AZUL="\e[34;1m"
SCAN_WA="A PARTE DO SCAN SÓ FUNCIONA RODANDO COMO ROOT! APERTE SUDO! \e[m \n"
CHAVE_1=0
CHAVE_2=0
CHAVE_3=0
CHAVE_4=0

#------------------------------------------------------------------------------------------------
#VERIFICACOES DO PROGRAMA

#Sair do programa com CTRL+C
trap __Ctrl_c__ INT

__Ctrl_c__() {
    echo -e ${COR_AMARELO}"Ação abortada!"
    exit 1
}

[ ! -e /usr/sbin/hping3 ] && echo "$MENSAGEM_HELP_HPING" && exit 1  #hping3 instalado?
[ ! "$(id -u)" = 0 ] && printf "${COR_BRANCO}$SCAN_WA" && exit 1    #Está rodando como root? Necessário!

#----------------------------------------------------------------------------------------------------
#CÓDIGO DO PROGRAMA

#case e chaves valores para ativação dos códigos
case "$1" in
  -l) __PortMessage__
  echo -e ${COR_BRANCO}"ESCANEANDO TODAS AS PORTAS DO HOST ALVO! \e[m \n"
  for ip in $(seq 1 65536);do
    if [ $(hping3 -S -p $ip -c 1 $2 2> /dev/null | grep flags=SA | cut -d " " -f 2 | cut -d = -f 2) ];then
      echo -e ${COR_VERMELHO}"Porta $ip ABERTA no host com"${COR_AMARELO} "IP $2 \n"
    fi                          #Full port-scan, com todas as portas  TCP
  done                                                                                                       ;;

  -a) CHAVE_1=1 && CHAVE_2=1 && CHAVE_3=1 && CHAVE_4=1                                                       ;;
  -h) echo "$MENSAGEM_HELP" && exit 0                                                                        ;;
   *) echo "$MENSAGEM_HELP_INVALIDO" && exit 1                                                               ;;
esac

#---------------------------------------------------------------------------------------------------------
#EXECUÇÕES DO PROGRAMA

#função -a
[ $CHAVE_1 -eq 1 ] && __PortMessage__ && echo -e ${COR_BRANCO}"ESCANEANDO PORTAS NO HOST ALVO! \e[m \n"
      while read portas;do
        if [ $(hping3 -S -p $portas -c 1 $2 2> /dev/null | grep flags=SA | cut -d " " -f 6 | cut -d = -f 2) ];then
          echo -e ${COR_VERMELHO}"Porta $portas ABERTA no host com"${COR_AMARELO} "IP $2 \e[m \n" | tee -a res.txt
          sleep 2             #Scan portas TCP populares | Syn scan
        fi
      done < portas.txt
echo
echo -e ${COR_SERV}"Serviços encontrados nas portas acima:\e[m \n"


#Formatação do arquivo para execução do banner grabbing via netcat
[ $CHAVE_2 -eq 1 ] && cut -d " " -f2 res.txt > res1.txt && rm res.txt


#Formatação de saída dos arquivos para o banner grabbing via netcat
{
[ $CHAVE_3 -eq 1 ] && for por in $(cat res1.txt);do nc -v -w 3 $2 $por;done >> serv.txt
} &> /dev/null

while read -r linha; do
  echo "$linha"
  echo
done < serv.txt 

#Se não houver linhas no arquivo, sem serviço nas portas
if [ "$(wc -l serv.txt)" = "0 serv.txt" ]; then
  echo -e ${COR_SERV1}"Nenhm serviço encontrado nas portas acima! Tente manualmente!"
fi

#Limpar diretório do usuário
[ $CHAVE_4 -eq 1 ] && rm serv.txt && rm res1.txt && exit 0
