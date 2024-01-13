#!/bin/bash
figlet SCAN-USER
echo "Autor: Eduardo Amaral - eduardo4maral@protonmail.com"
echo "You Tube : https://www.youtube.com/faciltech"
echo "github   : https://github.com/faciltech"
echo "Linkedin : https://www.linkedin.com/in/eduardo-a-02194451/"
echo "Uso: ./scan-user.sh"
echo "OBS 1: O nome completo ajuda na busca por links no site escavador;"
echo "OBS 2: O email ajuda na busca da imagem no site gravatar;"
echo "Atualização: 03/01/2024"
trap 'printf "\n";partial;exit 1' 2
echo ""
echo -e "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Inicio do Scan:\e[0m\e[1;77m  $(date +%d/%m/%y) - às $(date +%T)" 
echo ""


##### CONFIGURAR OS DADOS DE TOKEN E ID DO TELEGRAM
token=""
id=""

#### Condicao para criar um novo projeto caso este nome ja exista

while true; do
read -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Escolha o nome do projeto:\e[0m ' projeto
if [[ -e $projeto ]]; then
	echo "[-] Já existe um projeto com esse nome."
	
elif [[ -z $projeto ]];then
	echo "[-] O nome do projeto não pode ser vazio."
	
else
	mkdir $projeto
	break
fi
done


### Condicao para sanitizar o email (validar), ou deixar em branco

while true; do
read -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Entre com um Email:\e[0m ' email
if [[ "$email" =~ [a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4} ]] || [[ -z "$email" ]]
then
    break;
else
    echo "[+] Por favor entre com um email válido ou deixe em branco."
fi
done

###### Vai ser passado o nome completo ou deixar em branco
read -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Digite o nome completo ou deixe em branco: \e[0m' fullname

####################### Criar usuario
while true; do
read -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Entre com o nome do usuario:\e[0m ' username
if [[ -z $username ]]; then
        echo "[-] O nome de usuario nao pode ser vazio."
else
        break
fi
done

###### CASO QUEIRA ENVIAR DADOS PARA O INSTAGRAM DEVE INFORMAR (S,s,SIM,sim)
read -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Você quer enviar os dados para o telegram (S,s,SIM,Sim,sim)? \e[0m ' INFOTELEGRAM

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

check_tiktok=$(curl -s "https://www.tiktok.com/@$username" -L -H "Accept-Language: en" | grep -o '"id":"'; echo $?)
echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] TikTok: \e[0m"

if [[ $check_tiktok == *'0'* ]]; then
echo -e "\e[1;92m Encontrado!\e[0m https://www.tiktok.com/@$username"
echo -e "https://www.tiktok.com/@$username" >> $projeto/$username.txt
elif [[ $check_tiktok == *'1'* ]]; then
echo -e "\e[1;93mNão Encontrado!\e[0m"
fi

## Facebook

check_face=$(curl -s "https://www.facebook.com/$username" -L -H "Accept-Language: en" | grep -o 'not found'; echo $?)
echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Facebook: \e[0m"

if [[ $check_face == *'1'* ]]; then
echo -e "\e[1;92m Encontrado!\e[0m https://www.facebook.com/$username"
echo -e "https://www.facebook.com/$username" >> $projeto/$username.txt
elif [[ $check_face == *'0'* ]]; then
echo -e "\e[1;93mNão Encontrado!\e[0m"
fi
## TWITTER 

check_twitter=$(curl -s "https://www.twitter.com/$username" -L -H "Accept-Language: en" | grep -o 'page doesn’t exist'; echo $?)
echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Twitter: \e[0m"

if [[ $check_twitter == *'1'* ]]; then
echo -e "\e[1;92m Encontrado!\e[0m https://www.twitter.com/$username"
echo -e "https://www.twitter.com/username" >> $projeto/$username.txt
elif [[ $check_twitter == *'0'* ]]; then
echo -e "\e[1;93mNão Encontrado!\e[0m"
fi

## YOUTUBE

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] YouTube: \e[0m"
check_youtube=$(curl -s "https://www.youtube.com/$username" -L -H "Accept-Language: en" | grep -o 'Not Found'; echo $?)


if [[ $check_youtube == *'1'* ]]; then
echo -e "\e[1;92m Encontrado!\e[0m https://www.youtube.com/$username"
echo -e "https://www.youtube.com/$username" >> $projeto/$username.txt
elif [[ $check_youtube == *'0'* ]]; then
echo -e "\e[1;93mNão Encontrado!\e[0m"
fi

## BLOGGER

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Blogger: \e[0m"
check=$(curl -s "https://$username.blogspot.com" -L -H "Accept-Language: en" -i | grep -o 'HTTP/2 404'; echo $?)


if [[ $check == *'1'* ]]; then
echo -e "\e[1;92m Encontrado!\e[0m https://$username.blogspot.com"
echo -e "https://$username.blogspot.com" >> $projeto/$username.txt
elif [[ $check == *'0'* ]]; then
echo -e "\e[1;93mNão Encontrado!\e[0m"
fi


## REDDIT

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Reddit: \e[0m"
check1=$(curl -s -i "https://www.reddit.com/user/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o "Sorry, nobody on Reddit goes by that name"; echo $?)

if [[ $check1 == *'0'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'1'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://www.reddit.com/user/$username"
echo -e "https://www.reddit.com/user/$username" >> $projeto/$username.txt
fi

## WORDPRESS

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Wordpress: \e[0m"
check1=$(curl -s "https://wordpress.com/typo/?subdomain=$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o "doesn&apos;t&nbsp;exist"; echo $?)

if [[ $check1 == *'0'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'1'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://$username.wordpress.com"
echo -e "https://$username.wordpress.com" >> $projeto/$username.txt
fi

## PINTEREST

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Pinterest: \e[0m"
check1=$(curl -s -i "https://www.pinterest.com/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o "seo_title"; echo $?)

if [[ $check1 == *'1'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'0'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://www.pinterest.com/$username"
echo -e "https://www.pinterest.com/$username" >> $projeto/$username.txt
fi

## ONLYFANS
echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Onlyfans: \e[0m"
check1=$(curl -s -i "https://onlyfinder.com/$username/profiles/" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o "About 0 results"; echo $?)

if [[ $check1 == *'0'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'1'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://www.onlyfans.com/$username"
echo -e "https://www.onlyfans.com/$username" >> $projeto/$username.txt
fi

## GITHUB

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] GitHub: \e[0m"
check1=$(curl -s -i "https://www.github.com/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o "HTTP/2 404"; echo $?)

if [[ $check1 == *'0'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'1'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://www.github.com/$username"
echo -e "https://www.github.com/$username" >> $projeto/$username.txt
fi

## TUMBLR

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Tumblr: \e[0m"
check1=$(curl -s -i "https://$username.tumblr.com" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o 'Not found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'1'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://$username.tumblr.com"
echo -e "https://$username.tumblr.com" >> $projeto/$username.txt
fi

## FLICKR

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Flickr: \e[0m"
check1=$(curl -s "https://www.flickr.com/photos/$username" | grep "is-http-404" ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'1'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://www.flickr.com/photos/$username"
echo -e "https://www.flickr.com/photos/$username" >> $projeto/$username.txt
fi

## STEAM

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Steam: \e[0m"
check1=$(curl -s -i "https://steamcommunity.com/id/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep "og:title" | grep -o "Error"; echo $?)

if [[ $check1 == *'0'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'1'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://steamcommunity.com/id/$username"
echo -e "https://steamcommunity.com/id/$username" >> $projeto/$username.txt
fi


## SoundCloud

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] SoundCloud: \e[0m"
check1=$(curl -s "https://soundcloud.com/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o 'users:'; echo $?)

if [[ $check1 == *'1'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'0'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://soundcloud.com/$username"
echo -e "https://soundcloud.com/$username" >> $projeto/$username.txt
fi

## MEDIUM

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Medium: \e[0m"
check1=$(curl -s "https://medium.com/@$username" -H "Accept-Language: en" | grep -o "404" ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'1'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://medium.com/@$username"
echo -e "https://medium.com/@$username" >> $projeto/$username.txt
fi

## VK

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] VK: \e[0m"
check1=$(curl -s -i "https://vk.com/$username" -A "Mozilla 2.0" | grep -o 'Not Found'; echo $?)

if [[ $check1 == *'0'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'1'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://vk.com/$username"
echo -e "https://vk.com/$username" >> $projeto/$username.txt
fi

## About.me

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] About.me: \e[0m"
check1=$(curl -s "https://about.me/$username" -A "Mozilla 2.0" | grep -o 'user_name'; echo $?)

if [[ $check1 == *'1'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'0'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://about.me/$username"
echo -e "https://about.me/$username" >> $projeto/$username.txt
fi


## SlideShare

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] SlideShare: \e[0m"
check1=$(curl -s "https://pt.slideshare.net/$username" -A "Mozilla 2.0" | grep -o 'fb:app_id'; echo $?)

if [[ $check1 == *'1'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'0'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://slideshare.net/$username"
echo -e "https://slideshare.net/$username" >> $projeto/$username.txt
fi

## Spotify

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Spotify: \e[0m"
check1=$(curl -s "https://open.spotify.com/user/$username" -H "Accept-Language: en" -L | grep -o 'description' ; echo $?)

if [[ $check1 == *'1'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'0'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://open.spotify.com/user/$username"
echo -e "https://open.spotify.com/user/$username" >> $projeto/$username.txt
fi

## Scribd

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Scribd: \e[0m"
check1=$(curl -s "https://www.scribd.com/$username" -H "Accept-Language: en" -L | grep -o 'Page not found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'1'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://www.scribd.com/$username"
echo -e "https://www.scribd.com/$username" >> $projeto/$username.txt
fi

## Pastebin

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Pastebin: \e[0m"
check1=$(curl -s -i "https://pastebin.com/u/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o 'Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'1'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://pastebin.com/u/$username"
echo -e "https://pastebin.com/u/$username" >> $projeto/$username.txt
fi

## Foursquare

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Foursquare: \e[0m"
check1=$(curl -s "https://foursquare.com/$usename" -A "Mozzila 2.0" | grep -o 'APP_ID:'; echo $?)

if [[ $check1 == *'1'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'0'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://foursquare.com/$username"
echo -e "https://foursquare.com/$username" >> $projeto/$username.txt
fi

## Roblox

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Roblox: \e[0m"
check1=$(curl -s -i "https://www.roblox.com/users/profile?username=$username" -A "Mozilla 2.0" | grep -o "code=404"; echo $?)

if [[ $check1 == *'0'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'1'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://www.roblox.com/user.aspx?username=$username"
echo -e "https://www.roblox.com/user.aspx?username=$username" >> $projeto/$username.txt
fi


## TripAdvisor

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] TripAdvisor: \e[0m"
check1=$(curl -s "https://www.tripadvisor.com/Profile/$username" -H "Accept-Language: en" --user-agent 'Mozilla/5.0' | grep -o '404 Not Found'; echo $?)

if [[ $check1 == *'0'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'1'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://tripadvisor.com/Profile/$username"
echo -e "https://tripadvisor.com/Profile/$username" >> $projeto/$username.txt
fi

# Ebay

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Ebay: \e[0m"
check1=$(curl -s "https://www.ebay.com/usr/$username" -A "Mozilla/5.0" | grep -o "usuário não foi encontrado"; echo $?)
if [[ $check1 == *'0'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'1'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://www.ebay.com/usr/$username"
echo -e "https://www.ebay.com/usr/$username" >> $projeto/$username.txt
fi

## Slack

echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Slack: \e[0m"
check1=$(curl -s -i "https://$username.slack.com" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404\|404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
echo -e "\e[1;93mNão Encontrado!\e[0m"
elif [[ $check1 == *'1'* ]]; then 

echo -e "\e[1;92m Encontrado!\e[0m https://$username.slack.com"
echo -e "https://$username.slack.com" >> $projeto/$username.txt
fi

partial
}
scanner


echo ""
echo "#############################"
echo "## VERIFICANDO INSTAGRAM...##"
echo "#############################"

site="https://www.pixwox.com/profile/"
nome_perfil=$(curl -s $site/$username/ -A "faciltech.go" | awk -F= '/"fullname">/ {print $2}' | cut -c 12- | rev | cut -c6- | rev)

if [ -z "$nome_perfil"  ]
then
        echo -e "\e[1;93mEsta conta não existe!\e[0m"
else
	echo "##### INSTAGRAM #####" >> $projeto/$username.txt
	echo "" >> $projeto/$username.txt
	echo "[*] Nome de usuario: @$username" >> $projeto/$username.txt
	echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m]Nome de usuario:\e[0m @$username"

	echo "[*] Nome: " `curl -s $site/$username/ -A "faciltech.go" | awk -F= '/"fullname">/ {print $2}' | cut -c 12- | rev | cut -c6- | rev` >> $projeto/$username.txt
	echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m]Nome:\e[0m`curl -s $site/$username/ -A "faciltech.go" | awk -F= '/"fullname">/ {print $2}' | cut -c 12- | rev | cut -c6- | rev`"


	echo "[*] Posts: " `curl -s $site/$username/ -A "faciltech.go" | awk -F= '/"num"/ {print $3}' | cut -c 2- | rev | cut -c3- | rev | awk 'NR==1{print}'` >> $projeto/$username.txt
	echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m]Posts:\e[0m `curl -s $site/$username/ -A "faciltech.go" | awk -F= '/"num"/ {print $3}' | cut -c 2- | rev | cut -c3- | rev | awk 'NR==1{print}'`"

	echo "[*] Seguidores: " `curl -s $site/$username/ -A "faciltech.go" | awk -F= '/"num"/ {print $3}' | cut -c 2- | rev | cut -c3- | rev | awk 'NR==2{print}'` >> $projeto/$username.txt
	echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m]Seguidores:\e[0m `curl -s $site/$username/-A "faciltech.go" | awk -F= '/"num"/ {print $3}' | cut -c 2- | rev | cut -c3- | rev | awk 'NR==2{print}'`"

	echo "[*] Seguindo: " `curl -s $site/$username/ -A "faciltech.go" | awk -F= '/"num"/ {print $3}' | cut -c 2- | rev | cut -c3- | rev | awk 'NR==3{print}'` >> $projeto/$username.txt
	echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m]Seguindo:\e[0m `curl -s $site/$username/ -A "faciltech.go" | awk -F= '/"num"/ {print $3}' | cut -c 2- | rev | cut -c3- | rev | awk 'NR==3{print}'`"

	echo "[*] Link da foto do perfil: " >> $projeto/$username.txt
	echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m]Link da Foto:\e[0m Foto salva em $projeto/$username.jpeg " 

	imagem=$(curl -s $site/$username/ -A "faciltech.go" | awk '/href/&&/scontent/ {print $2}' | cut -c 7- | rev | cut -c10- | rev)
	echo $imagem >> $projeto/$username.txt
	link=$(echo $imagem)
	curl -s -A "Mozilla 2.0" $link > $projeto/$username.jpeg


	status=$(curl -s $site/$username/ -A "faciltech.go" | awk -F= '/This account/ {print}' | cut -c 18- | rev | cut -c7- | rev)
	if [ -z "$status"  ]
	then
		echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m]Status da Conta:\e[0m CONTA PUBLICA"
		echo "[*] Status da Conta: Conta Publica" >> $projeto/$username.txt
	else
		echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m]Status da Conta:\e[0m CONTA PRIVADA"
		echo "[*] Status da Conta: Conta Privada" >> $projeto/$username.txt
	fi
	echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m]URL do Perfil: https://www.instagram.com/$username" 
	echo "[*] URL do Perfil: https://www.instagram.com/$username" >> $projeto/$username.txt
	echo "###################################"
fi

#### Inicia a verificação no gravatar por imagens relacionada ao email e faz o download
if [[ ! -z "$email" ]];
then
	printf "\n"
	echo "###################################"
	echo "## VERIFICANDO IMAGEM GRAVATAR...##"
	echo "###################################"
	hash=$(echo -n $email | md5sum | cut -d" " -f1)
	echo -ne "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] VISUALIZAR FOTO NO NAVEGADOR: \e[0m"
	echo "https://gravatar.com/avatar/$hash?s=600"

	echo "### Foto Gravatar ###" >> $projeto/$username.txt
	echo "https://gravatar.com/avatar/$hash?s=600" >> $projeto/$username.txt
	link=$(echo https://gravatar.com/avatar/$hash?s=600)
	echo -e "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] BAIXANDO IMAGEM DO PERFIL GRAVATAR: \e[0m" 
	curl -s -A "faciltech.go" $link > $projeto/gravatar.jpeg
	echo -e "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Salvo em: \e[0m\e[1;77m$projeto/gravatar.jpg"
	echo "###################################"
fi

if [[ ! -z "$fullname" ]];
then
	printf "\n"
	echo "##################################"
	echo "## VERIFICANDO SITE ESCAVADOR...##"
	echo "##################################"
	echo "### Escavador ###" >> $projeto/$username.txt

	nome=$(echo $fullname | sed 's/ /+/g'); 

	primeiroNome=$(echo $fullname | cut -d" " -f1,2)

	res=$(curl -s 'https://www.escavador.com/busca?qo=t&q=%22'."$nome".'%22' -A "Mozilla 2.0" | grep "resu" | cut -d">" -f2 | cut -d"<" -f1 | cut -d" " -f1)

		if [ -z "$res" ]; 
		then 
			echo "Nada encontrado"; 
		else 
			echo "Foram encontrado $res resultados !!!"
			echo ""
			echo "#### LINKS ENCONTRADOS ####"
			echo "Links Encontrados:" >> $projeto/$username.txt
			echo "" >> $projeto/$username.txt
			echo "" >> $projeto/escavador.txt
		for i in $(seq 1 3);
		do
			link=$(curl -s 'https://www.escavador.com/busca?qo=t&q=%22'."$nome".'%22&qo=t&page='."$i".'' -A "Mozilla 2.0" | grep "link-address" | cut -d">" -f2 | cut -d"<" -f1)
			for i in $(echo $link);
			do
				echo $i >> $projeto/$username.txt
				echo $i >> $projeto/escavador.txt
			done;

		done
		echo "Os links foram salvos no arquivo $projeto/$username.txt"
		for i in $(cat $projeto/escavador.txt);
		do
			echo "[✔] $i"
		done
		fi
else
	exit
fi

#### Caso tenha setado a opção "sim" na etada de envio para o telegram, será feito isso agora
case $INFOTELEGRAM in
S|s|Sim|SIM|sim)
        if [[ -n $token ]] || [[ -n $id ]]
        then
                curl --silent  -F caption="Informacões do $username" -F document=@"$projeto/$username.txt" -A "Mozilla 2.0"  https://api.telegram.org/bot"$token"/sendDocument?chat_id="$id" | grep -q '"ok":true';
                curl --silent  -F caption="Informacões do $username" -F document=@"$projeto/escavador.txt" -A "Mozilla 2.0"  https://api.telegram.org/bot"$token"/sendDocument?chat_id="$id" | grep -q '"ok":true';
                curl --silent  -F caption="Foto do gravatar" -F document=@"$projeto/gravatar.jpeg" -A "Mozilla 2.0"  https://api.telegram.org/bot"$token"/sendDocument?chat_id="$id" | grep -q '"ok":true';
                curl --silent  -F caption="Foto do instagram" -F document=@"$projeto/$username.jpeg" -A "Mozilla 2.0"  https://api.telegram.org/bot"$token"/sendDocument?chat_id="$id" | grep -q '"ok":true';
        else
                echo "Você deve alterar inserir o token e seu id para poder receber as informações no instagram!!!"
        fi
;;
*) echo "Relatório não enviado para o Telegram!" ;;
esac
echo ""
echo -e "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Fim do Scan:\e[0m\e[1;77m  $(date +%d/%m/%y) - às $(date +%T)" 

exit ## encerra o programa
