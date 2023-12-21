<p align="center">
  <img src="https://github.com/faciltech/scan-user/assets/3409713/d5c035b9-f723-426a-856b-a472bbfe737d">
</p>

<h1 align="center">
  Scan-User - Ferramenta para enumeraçao de usuário.
</h1>
Meu principal objetivo é criar uma ferramenta no idioma português brasileiro, que atenda a comunidade nacional, claro que o resultado pode ser interepretado por qualquer usuário seja de qual país esteja fazendo uso. Mas todo esforço é para que nossa comunidade cresça, e que outros profissionais venham desenvolver produções nacionais.
A ideia alvo desse script simples é verificar a partir de um email e um nick name, contas de usuários nas redes sociais e outros sites, além de tentar verificar fotos.

## 🚀 Por que usa-lo?

Muitas vezes precisamos verificar de forma rápida se um determinado usuário possui outras contas válidas, ou mesmo confirmar se existe, além disso para quem trabalha com OSINT ajuda na relação de vinculos entre redes..
  
1.  **Como instalar?**

    Navegue dentro de seu sistema, escolha o local e execute no terminal o comando abaixo.

    ``` 
        git clone https://github.com/faciltech/scan-user.git
        Cloning into 'scan'...
        remote: Enumerating objects: 10, done.
        remote: Counting objects: 100% (10/10), done.
        remote: Compressing objects: 100% (10/10), done.
        remote: Total 10 (delta 1), reused 0 (delta 0), pack-reused 0
        Receiving objects: 100% (10/10), 19.14 KiB | 612.00 KiB/s, done.
        Resolving deltas: 100% (1/1), done.
      ```

2.  **Conceda permissão para o arquivo!**
```
chmod +x scan_user.sh
```
OBS: Uma outra boa dica é mover o arquivo do script para o diretório /usr/bin , dessa forma podemos utilizar de forma direta no terminal.
## 🧐 Como usar o script?
Você irá digitar ```./scan_user.sh ``` 
<p>❓<b>Ele vai perguntar o nome do projeto:</b> Voce nao pode deixar em branco</br>
<b>❓Ele vai perguntar o nome do email:</b> Voce pode deixar em branco, mas nao terá o retorno de imagem do gravatar.com</br>
<b>❓Ele vai perguntar o nome completo:</b> Voce pode deixar em branco, mas nao terá o retorno de links do site escavador.com</br>
<b>❓Ele vai perguntar o nome do usuário:</b> Voce nao pode deixar em branco.</br>

Em seguida o script faz o scan em sites e redes sociais e cria uma arquivo dentro da pasta do projeto com todas encontradas.</br></p>

![image](https://github.com/faciltech/scan-user/assets/3409713/660f46b9-2fec-4ec6-bf65-52665dac6c3f)

Em seguida o script verifica se existe conta associada ao usuário inserido.

![image](https://github.com/faciltech/scan-user/assets/3409713/2b3ab326-83a3-4f55-bb0b-dd621dcbd45c)

Depois ele verifica informaçoes da conta do instagram.

![image](https://github.com/faciltech/scan-user/assets/3409713/bc9f8b6c-a2f0-43c0-bae4-8979a4cd0362)

Depois é verificado se existe uma imagem no site gravatar.

![image](https://github.com/faciltech/scan-user/assets/3409713/dbf84022-14b6-4548-a78c-424b02082ba4)

Depois é verifado informaçoes no site escavador.com

![image](https://github.com/faciltech/scan-user/assets/3409713/fcc95682-645d-4283-bce7-0bc52ef42aa6)

Ao final ele salva as fotos baixadas do instagram, gravatar.com, cria dois arquivos .txt com as informaçoes colhidas.

![image](https://github.com/faciltech/scan-user/assets/3409713/3ae9c981-047c-4ff7-99e9-1f0e1298d609)

## 🎓 Linguagem

O utilitário é desenvolvido em linguagem shellscript.




<!-- AUTO-GENERATED-CONTENT:END -->


