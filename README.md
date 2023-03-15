# Diretório Services

O diretório services faz referência aos serviços embutidos dentro de:
**/opt/core/daemon/core/configservices/utilservices/templates**
Dentro desse diretório estarão inseridos diversas configurações de serviços. Existem alguns serviços predefinidos, alguns na possibilidade de retorno de erros por causa da não instalação de serviços ou não seguirem a base de configurações como alguns o definem.

## RADVD
Serviço para realizar SLAAC (Autoconfiguração Stateless IPv6) nos dispositivos através de um servidor. Para realizar a configuração:
```
apt-get update
apt-get install radvd
touch /etc/radvd.conf
ln -s /etc/radvd.conf /opt/core/daemon/core/configservices/utilservices/templates/etc/radvd.conf
```
Uma vez que o arquivo de configuração principal do serviço esteja apontando para um link simbólico nas configurações do CORE, basta inserir o arquivo executável em Shell Script no diretório apontado acima. Assim o laboratório iniciar, as configurações SLAAC serão automaticamente definidas, identificando as interfaces, prefixos e inicializando o serviço.
