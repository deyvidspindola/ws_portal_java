# WebLogic Dev Domain

Este é um passo-a-passo para iniciar o Weblogic localmente dentro de um container Docker com o domínio minimamente configurado. 
Aqui assume-se que já tem o Docker instalado e uma conta no DockerHub, caso contrário, providencie para continuar.
Nesta versão o domínio já está criado na pasta ../wl-volume. Esta pasta deverá ser montada no container do Weblogic. Antes de começar, temos que baixar a imagem oficial do Weblogic no GitHub.

##  Obtendo a imagem oficial do WebLogic
 1. Acesse o DockerHub do Weblogic em [https://hub.docker.com/_/oracle-weblogic-server-12c](https://hub.docker.com/_/oracle-weblogic-server-12c)
 2. Lá irá pedir pra preencher alguns dados e aceitar a licença para poder utilizar a imagem. Neste passo eles exigem que esteja logado em sua conta do DockerHub.
 3. Feito isto, a imagem será liberada para fazer o pull. Para dar sequencia é necessário que seu DockerHost esteja logado no DockerHub também. Feito isto, deve ser possível fazer o pull da imagem:
```bash
$> docker pull store/oracle/weblogic:12.2.1.3-dev
```
## Configurar o container
Com a imagem no lugar podemos iniciar o container. Somente mude o caminho para o volume contendo o domínio no arquivo `properties/domain.properties`.

```properties
...
DOMAIN_HOST_VOLUME=/caminho/para/pasta/volume/wl-volume
```
## Inicializar
Agora precisa rodar o script para inicializar o container:
```bash
$> ./reboot_admin_server.sh
```
Depois você pode acessar o admin console no endereço: http://localhost:9001/console
As credenciais são:
user: weblogic
password: weblogic!

## Iniciar o Managed Server
Nesta versão o script não inicia o managed server, trabalhos futuros... Neste caso é necessário logar no console e iniciar o **mngnode1** manualmente:

Environment -> Servers -> mngnode1 -> aba control
Nesta página verifique que o mngnode1 está selecionado e depois clique em **Start/Iniciar**. Aguarde alguns instantes e dê um refresh na tela para ver se o status mudou para **RUNNING**.
Agora é possível acessar o servidor pela url: http://localhost:8001/

## Fazendo Deploy
Aqui não é feito nenhuma integração com a IDE, o deploy é feito manualmente. Faça o build do projeto java e depois faça o deploy da aplicação em **Deployments**

## Debug no Eclipse
Sem instalar ferramentas de suporte para o WebLogic é possível fazer o debug remoto da aplicação. 

 1. Vá em menu Run -> Run Configurations...
 2. Procure por Remote Java Application e crie uma nova entrada. 
 3. Preencha um nome, geralmente o nome da aplicação se já não estiver preenchida.
 4. Selecione o projeto que tem o fonte
 5. Connection type dever ser Standard Socket Attach
 6. Host deve ser localhost e Port 4000
 7. Clique em aplly e depois se quiser já pode mandar um debug
 8. Para para o debug, vá na aba Debug, clique o botão direito no processo e depois disconnect.
