<p align="center">
  <img src="https://github.com/faciltech/scan-user/assets/3409713/ddbe101b-a4f5-448d-833b-769679245252" width="300">
</p>
<p align="center">
  <img src="https://github.com/faciltech/scan-user/assets/3409713/d5c035b9-f723-426a-856b-a472bbfe737d">
</p>

<h1 align="center">
  Scan-User - Ferramenta para enumeração de usuário.
</h1>
Meu principal objetivo é criar uma ferramenta no idioma português brasileiro, que atenda a comunidade nacional, claro que o resultado pode ser interepretado por qualquer usuário seja de qual país esteja fazendo uso. Mas todo esforço é para que nossa comunidade cresça, e que outros profissionais venham desenvolver produções nacionais.
A ideia alvo desse script simples é verificar a partir de um e-mail e um nick name, contas de usuários nas redes sociais e outros sites, além de tentar verificar fotos e ainda tem a capacidade de enviar pro telegram.

<h2> Redes Sociais que estão incluídas:</h2>
[✔] TikTok:  
[✔] Facebook
[✔] Onlyfans
[✔] Mercado Livre
[✔] Twitter
[✔] YouTube
[✔] Reddit
[✔] Wordpress
[✔] Pinterest
[✔] GitHub
[✔] Tumblr
[✔] Flickr
[✔] Steam
[✔] SoundCloud
[✔] Medium
[✔] About.me
[✔] SlideShare
[✔] Spotify
[✔] Scribd
[✔] Pastebin
[✔] Foursquare
[✔] Roblox
[✔] Ebay
[✔] Gravatar
<p align="center">
<img src="https://github.com/user-attachments/assets/ffba8f4c-cdd1-4083-bd38-fc8f818d3dcd">
</p>

## Observação importante:
- Fiz questão de comentar o código para ficar de fácil entendimento, além de não fazer uso de muitas expressões regulares para que iniciantes também possam entender do que se trata, mas os usuários mais avançados fiquem a vontade para deixar o código mais limpo.
- Outra importante observação é que os domínios dos sites utilizados podem sofrer modificações, assim como a chamada de usuário nas redes sociais, por isso é importante sempre verificar o porque os resultados trazem falsos positivos, caso vejam algo informe pelo LinkedIn ou por e-mail.
- O mais importante é que todos possam utilizar a ferramenta, e melhorá-la, tentei deixar o código bem compreensível.

## 🚀 Por que usá-lo?

Muitas vezes precisamos verificar de forma rápida se um determinado usuário possui outras contas válidas, ou mesmo confirmar se existe, além disso para quem trabalha com OSINT ajuda na relação de vínculos entre redes..
  
1.  **Como instalar?**

    Navegue dentro de seu sistema, escolha o local e execute no terminal o comando abaixo:

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
3. **Caso queira usar integrado ao telegram!**

Você terá que editar o arquivo scan_user.sh, e inserir seu Token e seu id do Telegram.

![image](https://github.com/faciltech/scan-user/assets/3409713/f0face68-fa9e-4606-826a-49b01b08236c)

O Token e seu id ou do grupo podem ser adquiridos de forma simples, siga o link abaixo para saber como: https://core.telegram.org/bots/api

4. **Caso queira usar um banco de dados!**

![image](https://github.com/faciltech/scan-user/assets/3409713/d18a9e04-72dd-4dcc-b520-1fdec2d8b51b)

Caso tenha um banco de dados, poderá ser passado o caminho nessa variável, como na imagem. Caso não seja passado o script não fará as perguntas necessárias.
Nesse caso, eu coloquei um arquivo no seguinte formato, podendo ser em .txt.
```
nomecompleto,cpf,data_de_nascimento,sexo
```
Será necessário inserir ou o nome completo ou o cpf (Mas você pode ajustar de acordo com o seu banco de dados).

   
## 🧐 Como usar o script?
Você irá digitar ```./scan_user.sh ``` 
<p>
<b>❓ Ele vai perguntar o nome do projeto:</b> Você não pode deixar em branco</br>
<b>❓ Ele vai perguntar se deseja usar o banco de dados, caso tenha inserido o caminho do arquivo:</b> Você pode passar o nome completo ou mesmo o cpf.</br>
<b>❓ Ele vai perguntar o nome do e-mail:</b> Você pode deixar em branco, mas não terá o retorno de imagem do gravatar.com</br>
<b>❓ Ele vai perguntar o nome completo:</b> Você pode deixar em branco, mas não terá o retorno de links do site escavador.com, jusbrasil e faz a Prova de Vida também.</br>
<b>❓ Ele vai perguntar o nome do usuário:</b> Você pode deixar em branco, inserir um nome de usuário ou inserir vários, separando-os por vírgulas (nick1,nick2,nick3).</br>
<b>❓ Você quer enviar os dados para o telegram</b> Você pode responder s|S|Sim|sim ele vai validar se tem configurado na linha de código seu ID e seu TOKEN.</br>

Em seguida o script faz o scan em sites e redes sociais e cria uma arquivo dentro da pasta do projeto com todas encontradas.</br></p>

![image](https://github.com/faciltech/scan-user/assets/3409713/57c1db4a-b456-40fd-9171-740698d72bc2)

Em seguida o script verifica se existe conta associada ao usuário inserido.

![image](https://github.com/faciltech/scan-user/assets/3409713/2b3ab326-83a3-4f55-bb0b-dd621dcbd45c)

Depois ele verifica informações da conta do instagram.

![image](https://github.com/faciltech/scan-user/assets/3409713/bc9f8b6c-a2f0-43c0-bae4-8979a4cd0362)

Depois é verificado se existe uma imagem no site gravatar.

![image](https://github.com/faciltech/scan-user/assets/3409713/dbf84022-14b6-4548-a78c-424b02082ba4)

Em seguida verifica se existe alguma senha vazada na internet, caso haja é mostrada na tela.

![image](https://github.com/faciltech/scan-user/assets/3409713/2047d112-fea9-4b3b-9f69-bb78fb277852)

Depois é verificado informações no site escavador.com

![image](https://github.com/faciltech/scan-user/assets/3409713/fcc95682-645d-4283-bce7-0bc52ef42aa6)

Depois é verificado informações no site jusbrasil.com.br

![image](https://github.com/faciltech/scan-user/assets/3409713/053ca046-4088-4dc0-9cea-b30bb6f0070b)

Também é feito através do nome completo a prova de vida:

![image](https://github.com/faciltech/scan-user/assets/3409713/2066497c-54ba-4dfb-be21-3fbacbd66170)

Caso tenha cadastrado o ID e Token, é informado que gostaria que fosse enviado os resultados ao telegram, nesse momento seria enviado.

![image](https://github.com/faciltech/scan-user/assets/3409713/b747fea7-ce48-4772-83d9-7db20cf35bd0)

Ao final ele salva as fotos baixadas do instagram, gravatar.com, cria dois arquivos .txt com as informações colhidas.

![image](https://github.com/faciltech/scan-user/assets/3409713/3ae9c981-047c-4ff7-99e9-1f0e1298d609)

## 🎓 Linguagem

O utilitário é desenvolvido em linguagem shellscript.

<!-- AUTO-GENERATED-CONTENT:END -->


