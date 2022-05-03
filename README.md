# Desafio DevOps Apiki 

Processo automatizado para construção de um servidor web para WordPress em sua última versão.

## Terraform 
1. Faça o [download](https://www.terraform.io/downloads) e a instalação do Terraform de acordo com seu sistema operacional;

2. Abra o cmd/terminal e vá até a pasta Terraform na qual vc clonou contida no github;

3. Dê o comando aws configure e coloque as credenciais especificadas no arquivo credentials_terraform.csv;

4. Dê os seguintes comandos:
   
- terraform init

- terraform plan

- terraform apply

5. Aguarde até que finalize o processo.


## Criação do ambiente 
Será criada uma instância t2.micro na AWS com o IAM especificado no credentials_terraform.csv (enviado por e-mail junto com a chave), com nome de desafio-apiki.

A instância possui armazenamento de 30gb e uma grupo de segurança com as portas 80, 443, 22 e 3306 liberadas.


## Especificações ##
Após a criação do ambiente, é executado automaticamente via ansible um script que instala o nginx e o apache, em seguida é executado um arquivo compose do docker que cria 2 contêiners:

- Mysql na versão 5.7;
 
- Wordpress na última versão (5.9.3) com o php também na última versão (8.1);


Para fazer a conexão SSH, faça o [login na AWS com o usuário IAM](https://474357573470.signin.aws.amazon.com/console) e pegue o DNS IPv4 público, após isso logue na máquina com o usuário ubuntu passando a chave.

Conecte utilizando as credenciais enviadas para o e-mail wphost@apiki.com.