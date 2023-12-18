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
Ele vai perguntar o nome do projeto:
Ele vai perguntar o nome do email:
Ele vai perguntar o nome do usuário:
Em seguida o script faz o scan em sites e redes sociais e cria uma arquivo dentro da pasta do projeto com todas encontradas;
![image](https://github.com/faciltech/scan-user/assets/3409713/323f8021-2f5e-4324-aef3-5507853a9810)

Ao final ele verifica se existe alguma foto desse usuário no site gravatar, se existir, ele baixa para a pasta do projeto essa foto e em seguida mostra na tela também.

![image](https://github.com/faciltech/scan-user/assets/3409713/52d64e2b-bfa0-450c-96fb-c2a0a8406e32)

## 🎓 Linguagem

O utilitário é desenvolvido em linguagem shellscript.




<!-- AUTO-GENERATED-CONTENT:END -->


