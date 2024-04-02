#!/bin/bash
echo "Autor: Eduardo Amaral - eduardo4maral@protonmail.com"
echo "You Tube : https://www.youtube.com/faciltech"
echo "github   : https://github.com/faciltech"
echo "Linkedin : https://www.linkedin.com/in/eduardo-a-02194451/"
echo "Uso: ./scan-user.sh"
echo "OBS 1: O nome completo ajuda na busca por links no site escavador, jusbrasil e faz a Prova de Vida;"
echo "OBS 2: O email ajuda na busca da imagem no site gravatar;"
echo "OBS 3: A base de dados de falecidos não possui dados de menores de 18 anos."
echo "OBS 4: Você pode inserir um nickname ou vários separados por virgulas (nick1,nick2)"
echo "Atualização: 01/04/2024"
trap 'printf "\n";partial;exit 1' 2
echo ""
echo -e "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Inicio do Scan:\e[0m\e[1;77m  $(date +%d/%m/%y) - às $(date +%T)" 
echo ""


####### VARIAVEIS IMPORTANTES #####
user_agent="-L --user-agent 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801'"
linguagem="-H 'Accept-Language: en'"
bd="banco.txt"

##### VARIAVEIS DOS SITES USADOS
site_tiktok="tiktok.com"
site_facebook="facebook.com"
site_twitter="twitter.com"
site_youtube="youtube.com"
site_reddit="reddit.com"
site_wordpress="wordpress.com"
site_pinterest="pinterest.com"
site_onlyfans="onlyfinder.com"
site_github="github.com"
site_tumblr="tumblr.com"
site_flickr="flickr.com"
site_steam="steamcommunity.com"
site_soundcloud="soundcloud.com"
site_medium="medium.com"
site_about="about.me"
site_slideshare="pt.slideshare.net"
site_spotify="open.spotify.com"
site_scribd="scribd.com"
site_pastebin="pastebin.com"
site_foursquare="foursquare.com"
site_roblox="roblox.com/users/profile?username="
site_ebay="ebay.com/usr"
site_instagram="https://www.pixwox.com/profile"
site_gravatar="gravatar.com/avatar"
site_gravatar1="gravatar.com/"
site_escavador="escavador.com/busca?qo=t&q="
site_jusbrasil="jusbrasil.com.br/diarios/busca?q="
site_falecidos="falecidosnobrasil.org.br"
site_telegram_api="falecidosnobrasil.org.br"


##### CONFIGURAR OS DADOS DE TOKEN E ID DO TELEGRAM
token=""
id=""

#### Condicao para criar um novo projeto caso este nome ja exista
while true; do
read -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Escolha o nome do projeto:\e[0m ' projeto
if [[ -e $projeto ]]; then
        echo "[-] Já existe um projeto com esse nome."
        read -p "[?] Quer criar outro projeto S ou N? " resposta

        case $resposta in
        S|s)
                aleatorio=$(echo $RANDOM | md5sum | head -c 4); # ESSA FUNÇÃO GERA UMA STRING ALEATÓRIA PARA CONCATENAR COM O NOME DO DIRETORIO ANTERIOR
                projeto=$(echo $projeto$aleatorio)
                mkdir $projeto 
                break
        ;;  
        N|n)
                projeto=$(echo $projeto)
                break
        ;;
        *) echo -e "\033[1;31mOpção Invalida !!! \033[0m"
	;;
        esac

elif [[ -z $projeto ]];then
        echo "[-] O nome do projeto não pode ser vazio."

else
        mkdir $projeto
	echo "###### Relatório ######" >> $projeto/relatorio_$projeto.txt
        break
fi
done

############### UTILIZAÇÃO DO BANDO DE DADOS #####
if [ -e $bd ]
then
        read -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Você deseja usar a base de dados S ou N? \e[0m' base_status
        case $base_status in
        S|s)

                read -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Digite o nome da pessoa: \e[0m' fullname
                if [[ ! -z "$fullname" ]] 
                then
                        echo "#### Relacao de Nomes encontrados ####" > $projeto/nomes.txt
                        grep -i "$fullname" $bd >> $projeto/nomes.txt
                        cat $projeto/nomes.txt
			echo ""
                else
                        read -n11 -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Digite o cpf da pessoa: \e[0m' cpf
                        if [ -n $cpf ]
                        then
                                echo ""
                                grep -m1 -i "$cpf" $bd 
                        fi
                fi
        ;;
        *)
        ;;
        esac
fi


### Condicao para sanitizar o email (validar), ou deixar em branco

while true; do
read -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Entre com um Email ou deixe em branco:\e[0m ' email
if [[ "$email" =~ [a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4} ]] || [[ -z "$email" ]]
then
    echo  "Email: $email" >> $projeto/relatorio_$projeto.txt
    break;
else
    echo "[+] Por favor entre com um email válido ou deixe em branco."
fi
done

###### Vai ser passado o nome completo ou deixar em branco
read -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Digite o nome completo ou deixe em branco: \e[0m' fullname
echo "Nome: $fullname" >> $projeto/relatorio_$projeto.txt

####################### Criar usuario
# SE TIVER VAZIO NÃO SERÁ VERIFICADO AS REDES SOCIAIS
read -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Entre com o nome do usuario(s) (separado por virgula) ou deixe em branco:\e[0m ' nickname
echo "Nickname: $nickname" >> $projeto/relatorio_$projeto.txt

###### CASO QUEIRA ENVIAR DADOS PARA O TELEGRAM DEVE INFORMAR (S,s,SIM,sim)
if [[ ! -z $token ]];then
read -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Você quer enviar os dados para o telegram (S,s,SIM,Sim,sim)? \e[0m ' INFOTELEGRAM
fi

####### Nome do projeto
echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Nome do Projeto:  \e[0m$projeto"

if [[ ! -z "$nickname" ]];
then
for username in $(echo $nickname | sed 's/,/ /g');
do
	#### Inicia a verificação de redes sociais
	echo ""
	echo "#################################"
	echo "## VERIFICANDO REDES SOCIAIS...##"
	echo "#################################"
	partial() {

	if [[ -e $projeto/$username.txt ]]; then
	echo -e "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Salvo:\e[0m\e[1;77m $projeto/$username.txt"
	fi

	}
	scanner() {

	if [[ -e /$projeto/$username.txt ]]; then
	echo -e "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Removendo arquivo:\e[0m\e[1;77m $username.txt"
	rm -rf /$projeto/$username.txt
	fi
	echo -e "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Verificando username\e[0m\e[1;77m $username\e[0m\e[1;92m on: \e[0m"
	echo -e "## - REDES SOCIAIS ENCONTRADAS - ##" >> $projeto/$username.txt

	## TIKTOK
	check_tiktok=$(curl -s "https://www.$site_tiktok/@$username" $user_agent | grep -o '"id":"'; echo $?)
	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] TikTok: \e[0m"

	if [[ $check_tiktok == *'0'* ]]; then
	echo -e "\e[1;92m Encontrado!\e[0m https://www.$site_tiktok/@$username"
	echo -e "https://www.$site_tiktok/@$username" >> $projeto/$username.txt
	elif [[ $check_tiktok == *'1'* ]]; then
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	fi

	## Facebook

	check_face=$(curl -s "https://www.$site_facebook/$username" $user_agent | grep -o 'not found'; echo $?)
	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Facebook: \e[0m"

	if [[ $check_face == *'1'* ]]; then
	echo -e "\e[1;92m Encontrado!\e[0m https://www.$site_facebook/$username"
	echo -e "https://www.$site_facebook/$username" >> $projeto/$username.txt
	elif [[ $check_face == *'0'* ]]; then
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	fi

	## TWITTER 

	check_twitter=$(curl -s "https://www.$site_twitter/$username" $user_agent | grep -o 'page doesn’t exist'; echo $?)
	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Twitter: \e[0m"

	if [[ $check_twitter == *'1'* ]]; then
	echo -e "\e[1;92m Encontrado!\e[0m https://www.$site_twitter/$username"
	echo -e "https://www.$site_twitter/$username" >> $projeto/$username.txt
	elif [[ $check_twitter == *'0'* ]]; then
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	fi

	## YOUTUBE

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] YouTube: \e[0m"
	check_youtube=$(curl -s "https://www.$site_youtube/$username" $user_agent | grep -o 'Not Found'; echo $?)


	if [[ $check_youtube == *'1'* ]]; then
	echo -e "\e[1;92m Encontrado!\e[0m https://www.$site_youtube/$username"
	echo -e "https://www.$site_youtube/$username" >> $projeto/$username.txt
	elif [[ $check_youtube == *'0'* ]]; then
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	fi

	## REDDIT

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Reddit: \e[0m"
	check1=$(curl -s "https://www.$site_reddit/user/$username" $user_agent | grep -o "not_found"; echo $?)


	if [[ $check1 == *'0'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'1'* ]]; then 

	echo -e "\e[1;92m Encontrado!\e[0m https://www.$site_reddit/user/$username"
	echo -e "https://www.$site_reddit/user/$username" >> $projeto/$username.txt
	fi

	## WORDPRESS

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Wordpress: \e[0m"
	check1=$(curl -s "https://$site_wordpress/typo/?subdomain=$username" $user_agent | grep -o "doesn&apos;t&nbsp;exist"; echo $?)

	if [[ $check1 == *'0'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'1'* ]]; then 

	echo -e "\e[1;92m Encontrado!\e[0m https://$username.$site_wordpress"
	echo -e "https://$username.$site_wordpress" >> $projeto/$username.txt
	fi

	## PINTEREST

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Pinterest: \e[0m"
	check1=$(curl -s "https://www.$site_pinterest/$username/" $user_agent | grep -o "seo_title"; echo $?)

	if [[ $check1 == *'1'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'0'* ]]; then 

	echo -e "\e[1;92m Encontrado!\e[0m https://www.$site_pinterest/$username"
	echo -e "https://www.$site_pinterest/$username" >> $projeto/$username.txt
	fi

	## GITHUB

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] GitHub: \e[0m"
	check1=$(curl -s -i "https://www.$site_github/$username" $user_agent | grep -o "HTTP/2 404"; echo $?)

	if [[ $check1 == *'0'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'1'* ]]; then 

	echo -e "\e[1;92m Encontrado!\e[0m https://www.$site_github/$username"
	echo -e "https://www.$site_github/$username" >> $projeto/$username.txt
	fi

	## TUMBLR

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Tumblr: \e[0m"
	check1=$(curl -s -i "https://$username.$site_tumblr" $user_agent | grep -o 'Not found' ; echo $?)

	if [[ $check1 == *'0'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'1'* ]]; then 

	echo -e "\e[1;92m Encontrado!\e[0m https://$username.$site_tumblr"
	echo -e "https://$username.$site_tumblr" >> $projeto/$username.txt
	fi

	## FLICKR

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Flickr: \e[0m"
	check1=$(curl -s "https://www.$site_flickr/photos/$username" | grep "is-http-404" ; echo $?)

	if [[ $check1 == *'0'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'1'* ]]; then 

	echo -e "\e[1;92m Encontrado!\e[0m https://www.$site_flickr/photos/$username"
	echo -e "https://www.$site_flickr/photos/$username" >> $projeto/$username.txt
	fi

	## STEAM

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Steam: \e[0m"
	check1=$(curl -s -i "https://$site_steam/id/$username" $user_agent | grep "og:title" | grep -o "Error"; echo $?)

	if [[ $check1 == *'0'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'1'* ]]; then 

	echo -e "\e[1;92m Encontrado!\e[0m https://$site_steam/id/$username"
	echo -e "https://$site_steam/id/$username" >> $projeto/$username.txt
	fi


	## SoundCloud

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] SoundCloud: \e[0m"
	check1=$(curl -s "https://$site_soundcloud/$username" $user_agent | grep -o 'users:'; echo $?)

	if [[ $check1 == *'1'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'0'* ]]; then 

	echo -e "\e[1;92m Encontrado!\e[0m https://$site_soundcloud/$username"
	echo -e "https://$site_soundcloud/$username" >> $projeto/$username.txt
	fi

	## MEDIUM

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Medium: \e[0m"
	check1=$(curl -s "https://$site_medium/@$username" $user_agent | grep -o "404" ; echo $?)

	if [[ $check1 == *'0'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'1'* ]]; then 

	echo -e "\e[1;92m Encontrado!\e[0m https://$site_medium/@$username"
	echo -e "https://$site_medium/@$username" >> $projeto/$username.txt
	fi

	## About.me

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] About.me: \e[0m"
	check1=$(curl -s "https://$site_about/$username" $user_agent | grep -o 'user_name'; echo $?)

	if [[ $check1 == *'1'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'0'* ]]; then 

	echo -e "\e[1;92m Encontrado!\e[0m https://$site_about/$username"
	echo -e "https://$site_about/$username" >> $projeto/$username.txt
	fi


	## SlideShare

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] SlideShare: \e[0m"
	check1=$(curl -s "https://$site_slideshare/$username" $user_agent | grep -o 'fb:app_id'; echo $?)

	if [[ $check1 == *'1'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'0'* ]]; then 

	echo -e "\e[1;92m Encontrado!\e[0m https://$site_slideshare/$username"
	echo -e "https://$site_slideshare/$username" >> $projeto/$username.txt
	fi

	## Spotify

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Spotify: \e[0m"
	check1=$(curl -s "https://$site_spotify/user/$username" $user_agent | grep -o 'description' ; echo $?)

	if [[ $check1 == *'1'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'0'* ]]; then 

	echo -e "\e[1;92m Encontrado!\e[0m https://$site_spotify/user/$username"
	echo -e "https://$site_spotify/user/$username" >> $projeto/$username.txt
	fi

	## Scribd

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Scribd: \e[0m"
	check1=$(curl -s "https://www.$site_scribd/$username" $user_agent | grep -o 'Page not found' ; echo $?)

	if [[ $check1 == *'0'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'1'* ]]; then 

	echo -e "\e[1;92m Encontrado!\e[0m https://www.$site_scribd/$username"
	echo -e "https://www.$site_scribd/$username" >> $projeto/$username.txt
	fi

	## Pastebin

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Pastebin: \e[0m"
	check1=$(curl -s "https://$site_pastebin/$username" $user_agent | grep -o 'Not Found' ; echo $?)

	if [[ $check1 == *'0'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'1'* ]]; then 

	echo -e "\e[1;92m Encontrado!\e[0m https://$site_pastebin/u/$username"
	echo -e "https://$site_pastebin/$username" >> $projeto/$username.txt
	fi

	## Foursquare

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Foursquare: \e[0m"
	check1=$(curl -s "https://$site_foursquare/$username" $user_agent | grep -o 'APP_ID:'; echo $?)

	if [[ $check1 == *'1'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'0'* ]]; then 
	echo -e "\e[1;92m Encontrado!\e[0m https://$site_foursquare/$username"
	echo -e "https://$site_foursquare/$username" >> $projeto/$username.txt
	fi

	## Roblox

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Roblox: \e[0m"
	check1=$(curl -s "https://www.$site_roblox$username" $user_agent | grep -o "code=404"; echo $?)

	if [[ $check1 == *'0'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'1'* ]]; then 

	echo -e "\e[1;92m Encontrado!\e[0m https://www.$site_roblox$username"
	echo -e "https://www.$site_roblox$username" >> $projeto/$username.txt
	fi

	# Ebay

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Ebay: \e[0m"
	check1=$(curl -s "https://www.$site_ebay/usr/$username"  | grep -o "username"; echo $?)
	if [[ $check1 == *'1'* ]] ; then 
	echo -e "\e[1;93mNão Encontrado!\e[0m"
	elif [[ $check1 == *'0'* ]]; then 

	echo -e "\e[1;92m Encontrado!\e[0m https://www.$site_ebay/usr/$username"
	echo -e "https://www.$site_ebay/usr/$username" >> $projeto/$username.txt
	fi

	## Gravatar

	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Gravatar: \e[0m"
        check1=$(curl -s "https://$site_gravatar1$username" | grep -o "g-profile__profile-image"; echo $?)

        if [[ $check1 == *'1'* ]] ; then 
        echo -e "\e[1;93mNão Encontrado!\e[0m"
        elif [[ $check1 == *'0'* ]]; then 

        echo -e "\e[1;92mEncontrado!\e[0m https://$site_gravatar1$username"
        echo -e "https://$site_gravatar1$username" >> $projeto/$username.txt
        fi

        # Ebay

        echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Ebay: \e[0m"
        check1=$(curl -s "https://www.$site_ebay/usr/$username"  | grep -o "username"; echo $?)
        if [[ $check1 == *'1'* ]] ; then 
        echo -e "\e[1;93mNão Encontrado!\e[0m"
        elif [[ $check1 == *'0'* ]]; then 

        echo -e "\e[1;92m Encontrado!\e[0m https://www.$site_ebay/usr/$username"
        echo -e "https://www.$site_ebay/usr/$username" >> $projeto/$username.txt
        fi

	partial
	}
	scanner

	################# BLOCO QUE FARÁ A VERIFICAÇÃO DAS INFORMAÇÕES DO INSTAGRAM
	echo ""
	echo "" >> $projeto/relatorio_$projeto.txt
	echo "#############################"
	echo "## VERIFICANDO INSTAGRAM...##"
	echo "#############################"

	nome_perfil=$(curl -s $site_instagram/$username/ $user_agent | awk -F= '/"fullname">/ {print $2}' | cut -c 12- | rev | cut -c6- | rev)

	if [ -z "$nome_perfil"  ]
	then
	        echo -e "\e[1;93mEsta conta não existe!\e[0m"
	else
		echo "" >> $projeto/$username.txt
		echo "##### INSTAGRAM #####" >> $projeto/$username.txt
		echo "" >> $projeto/$username.txt
		echo "[*] Nome de usuario: @$username" >> $projeto/$username.txt
		echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Nome de usuario:\e[0m @$username"

		echo "[*] Nome: " `curl -s $site_instagram/$username/ $user_agent | awk -F= '/"fullname">/ {print $2}' | cut -c 12- | rev | cut -c6- | rev` >> $projeto/$username.txt
		echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Nome:\e[0m`curl -s $site_instagram/$username/ $user_agent | awk -F= '/"fullname">/ {print $2}' | cut -c 12- | rev | cut -c6- | rev`"


		echo "[*] Posts: " `curl -s $site_instagram/$username/ $user_agent | awk -F= '/"num"/ {print $3}' | cut -c 2- | rev | cut -c3- | rev | awk 'NR==1{print}'` >> $projeto/$username.txt
		echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Posts:\e[0m `curl -s $site_instagram/$username/ $user_agent | awk -F= '/"num"/ {print $3}' | cut -c 2- | rev | cut -c3- | rev | awk 'NR==1{print}'`"

		echo "[*] Seguidores: " `curl -s $site_instagram/$username/ $user_agent | awk -F= '/"num"/ {print $3}' | cut -c 2- | rev | cut -c3- | rev | awk 'NR==2{print}'` >> $projeto/$username.txt
		echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Seguidores:\e[0m `curl -s $site_instagram/$username/ $user_agent | awk -F= '/"num"/ {print $3}' | cut -c 2- | rev | cut -c3- | rev | awk 'NR==2{print}'`"

		echo "[*] Seguindo: " `curl -s $site_instagram/$username/ $user_agent | awk -F= '/"num"/ {print $3}' | cut -c 2- | rev | cut -c3- | rev | awk 'NR==3{print}'` >> $projeto/$username.txt
		echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Seguindo:\e[0m `curl -s $site_instagram/$username/ $user_agent | awk -F= '/"num"/ {print $3}' | cut -c 2- | rev | cut -c3- | rev | awk 'NR==3{print}'`"

		echo "[*] Link da foto do perfil: " >> $projeto/$username.txt
		echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Link da Foto:\e[0m Foto salva em $projeto/$username.jpeg " 

		imagem=$(curl -s $site_instagram/$username/ $user_agent | awk '/href/&&/scontent/ {print $2}' | cut -c 7- | rev | cut -c10- | rev)
		echo $imagem >> $projeto/$username.txt
		link=$(echo $imagem)
		curl -s $user_agent $link > $projeto/$username.jpeg


		status=$(curl -s $site_instagram/$username/ $user_agent | awk -F= '/This account/ {print}' | cut -c 18- | rev | cut -c7- | rev)
		if [ -z "$status"  ]
		then
			echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Status da Conta:\e[0m CONTA PUBLICA"
			echo "[*] Status da Conta: Conta Publica" >> $projeto/$username.txt
		else
			echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Status da Conta:\e[0m CONTA PRIVADA"
			echo "[*] Status da Conta: Conta Privada" >> $projeto/$username.txt
		fi
		echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] URL do Perfil: https://www.instagram.com/$username" 
		echo "[*] URL do Perfil: https://www.instagram.com/$username" >> $projeto/$username.txt
		echo "###################################"
	fi
	cat $projeto/$username.txt >> $projeto/relatorio_$projeto.txt
done
	fi ### encerramento da condicao do username
#### Inicia a verificação no gravatar por imagens relacionada ao email e faz o download
if [[ ! -z "$email" ]];
then
	printf "\n"
	echo "###################################"
	echo "## VERIFICANDO IMAGEM GRAVATAR...##"
	echo "###################################"
	hash=$(echo -n $email | md5sum | cut -d" " -f1)
	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] VISUALIZAR FOTO NO NAVEGADOR: \e[0m"
	echo "https://$site_gravatar/$hash?s=600"

	echo "### Foto Gravatar ###" >> $projeto/$username.txt
	echo "https://$site_gravatar/$hash?s=600" >> $projeto/$username.txt
	link=$(echo https://$site_gravatar/$hash?s=600)
	echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] BAIXANDO IMAGEM DO PERFIL GRAVATAR: \e[0m" 
	curl -s $user_agent $link > $projeto/gravatar.jpeg
	echo -e "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Salvo em: \e[0m\e[1;77m$projeto/gravatar.jpg"
	res=$(curl -s https://api.proxynova.com/comb?query=$email | jq | grep "$email" > /dev/null; echo $?)
	if [ $res -eq 0 ] 
	then
		echo "##############################"
		echo "## VAZEMENTO DE CREDENCIAIS ##"
		echo "##############################"
		curl -s https://api.proxynova.com/comb?query=$email | jq | grep "$email" | cut -d'"' -f2
	else
		echo -e "\033[1;31mNenhum vazamento de dados encontrado !!!\033[0m";
	fi
fi

########### VERIFICAR AS INFORMAÇÕES DO ESCAVADOR

if [[ ! -z "$fullname" ]];
then
	nome=$(echo $fullname | sed 's/ /+/g'); 

	res=$(curl -s "https://www.$site_escavador%22$nome%22" $user_agent | grep "resu" | cut -d">" -f2 | cut -d"<" -f1 | cut -d" " -f1 | head -n1)
	res1=$(curl -s "https://www.$site_jusbrasil%22$nome%22" $user_agent | sed 's/\s/\n/g' | grep 'href="https' | grep -v "busca" | grep -w "diarios" | cut -d'"' -f2)
	res2=$(curl -s "https://www.falecidosnobrasil.org.br/resultado2.php?nome=$nome&exata=true" | grep -o "card"; echo $?)
	res3=$(curl -s "https://www.jusbrasil.com.br/busca?q=%22$nome%22" -H "Accept-Language: en" -L --user-agent "Mozilla/5.0" | sed 's/\s/\n/g' | grep 'href="https' | grep "processos" | cut -d'"' -f2;)
	if [ "$res" -eq 0 ]; 
	then 
        	echo -e "\033[1;31m[-] Nada encontrado no Escavador\033[0m"; 
	else 
		printf "\n"
        	echo "##################################"
        	echo "## VERIFICANDO SITE ESCAVADOR...##"
	        echo "##################################"
        	echo "Foram encontrado $res resultados no site Escavador !!!" 
        	echo "" > $projeto/escavador.txt

        	echo -e "\e[1;92m###### Links Encontrados no Site Escavador ######## \e[0m"

        	for i in $(seq 1 3);
        	do
                	curl -s "https://www.$site_escavador%22$nome%22&qo=t&page=$i" $user_agent | grep "link-address" | cut -d">" -f2 | cut -d"<" -f1 | tee -a $projeto/escavador.txt
        	done
	fi

####### VERIFICA AS INFORMAÇÕES NO SITE JUSBRASIL

if [[ -z "$res1" ]] && [[ -z "$res3" ]];
	then
        	echo -e "\033[1;31m[-] Nada encontrado no Jusbrasil\033[0m";

	else
		printf "\n"
        	echo "##################################"
        	echo "## VERIFICANDO SITE JUSBRASIL...##"
	        echo "##################################"

        	echo "" > $projeto/jusbrasil.txt
	     	echo -e "\e[1;92m###### Links Encontrados no Site Jusbrasil ####### \e[0m"

        for i in $(seq 1 3);
        do
                curl -s "https://www.jusbrasil.com.br/diarios/busca?q=%22$nome%22&p=$i" -H "Accept-Language: en" -L --user-agent "Mozilla/5.0" | sed 's/\s/\n/g' | grep 'href="https' | grep "diarios" |grep -v "busca"| cut -d'"' -f2 | tee -a $projeto/jusbrasil.txt
        done;
                curl -s "https://www.jusbrasil.com.br/busca?q=%22$nome%22&p=$i" -H "Accept-Language: en" -L --user-agent "Mozilla/5.0" | sed 's/\s/\n/g' | grep 'href="https' | grep "processos" | cut -d'"' -f2 | tee -a $projeto/jusbrasil.txt
	fi

	echo "" >> $projeto/$username.txt
	echo "##### ESCAVADOR ######" >> $projeto/relatorio_$projeto.txt
	cat $projeto/escavador.txt >> $projeto/relatorio_$projeto.txt
	echo "" >> $projeto/$username.txt

	echo "##### JUSBRASIL ######" >> $projeto/relatorio_$projeto.txt

	cat $projeto/jusbrasil.txt >> $projeto/relatorio_$projeto.txt
	echo "" >> $projeto/relatorio_$projeto.txt
	echo "##################################" >> $projeto/relatorio_$projeto.txt

	####### VERIFICA AS INFORMAÇÕES DE PROVA DE VIDA

	if [[ $res2 == *'0'* ]]; then
		printf "\n"
                echo "##################################"
                echo "##	 TESTE DE VIDA...      ##"
                echo "##################################"

        	echo -e "\e[1;92mNome consta na base de Falecidos.\e[0m"
        	curl -s "https://www.$site_falecidos/resultado2.php?nome=$nome&exata=true" | grep "card" | cut -d">" -f2 | cut -d "<" -f1
	elif [[ $res2 == *'1'* ]]; then
        	echo -e "\033[1;31m[-] Não Consta na base de dados de Falecidos!\033[0m"
	fi


else
	exit
fi


#### Caso tenha setado a opção "sim" na etada de envio para o telegram, será feito isso agora
case $INFOTELEGRAM in
S|s|Sim|SIM|sim)
        if [[ -n $token ]] || [[ -n $id ]]
        then
                curl --silent  -F caption="Informacões do $projeto" -F document=@"$projeto/$username.txt" $user_agent https://api.telegram.org/bot"$token"/sendDocument?chat_id="$id" | grep -q '"ok":true';
                curl --silent  -F caption="Informacões do $projeto" -F document=@"$projeto/escavador.txt" $user_agent https://api.telegram.org/bot"$token"/sendDocument?chat_id="$id" | grep -q '"ok":true';
                curl --silent  -F caption="Foto do $projeto" -F document=@"$projeto/gravatar.jpeg" $user_agent https://api.telegram.org/bot"$token"/sendDocument?chat_id="$id" | grep -q '"ok":true';
                curl --silent  -F caption="Foto do instagram do $projeto" -F document=@"$projeto/$username.jpeg" $user_agent https://api.telegram.org/bot"$token"/sendDocument?chat_id="$id" | grep -q '"ok":true';
  		curl --silent  -F caption="Informações do $projeto" -F document=@"$projeto/jusbrasil.txt" $user_agent https://api.telegram.org/bot"$token"/sendDocument?chat_id="$id" | grep -q '"ok":true';
                curl --silent  -F caption="Nomes encontrados do $projeto" -F document=@"$projeto/nomes.txt" $user_agent https://api.telegram.org/bot"$token"/sendDocument?chat_id="$id" | grep -q '"ok":true';

		echo -e "\e[1;92mDados enviados para o telegram com sucesso.\e[0m"
      else
                echo "Você deve alterar inserir o token e seu id para poder receber as informações no instagram!!!"
      fi
;;
*) echo -e "\033[1;31m[-] Relatório não enviado para o Telegram! \033[0m";;
esac
echo ""
echo -e "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Fim do Scan:\e[0m\e[1;77m  $(date +%d/%m/%y) - às $(date +%T)" 

exit ## encerra o programa
