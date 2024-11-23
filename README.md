myburgercontrol-infra
---

O código fornecido é destinado a configuração do ambiente de
infraestrutura Kubernetes (k8s) para uma aplicação "My Burger"
para o projeto de POS SOAT da FIAP.

## Pré-requisitos

Para executar estes scripts é necessário as ferramentas abaixo:
- kubectl - ferramenta de linha de comando para gerenciar recursos k8s
- doctl - ferramenta de linha de comando para gerenciar recursos do Digital Ocean
- jq - ferramenta de linha de comando para processar JSON e XML
- helm - pacote de gerenciamento de pacotes k8s

## Cloud Provider

O cloud provider utilizado é a Digital Ocean, que oferece recursos
de infraestrutura como servidores virtuais, discos, redes e
balanceadores de carga.

### Instalando o Digital Ocean CLI

Nossos scripts utilizam a ferramenta CLI DigitalOcean (doctl) para
interagir com a API do Digital Ocean para gerenciar clusters 
Kubernetes e bancos de dados. Para baixar o `doctl` [CLI fornecido pela Digital Ocean](https://docs.digitalocean.com/reference/doctl/how-to/install/) siga as isntruções desse link.

### Autenticando com o Digital Ocean CLI

Para autenticar com a API do Digital Ocean, execute:
> doctl auth login

### Criando o Kubeconfig

Para configurar o acesso ao cluster Kubernetes usando o `doctl`, execute:
> doctl kubernetes cluster kubeconfig create <cluster_name>

## Conteúdo do Repositório

O reporitório contém os seguintes arquivos e pastas:
- `k8s`: Pasta contendo o manifesto de deploy da aplicação My Burger.
- `scripts`: Pasta com scripts para automatizar a criação do cluster k8s, criação do banco de dados e destruição dos recursos criados.
- `scripts/bd`: Scripts para provisionar o usuário e banco que a aplicação My Burger utiliza.

Ficar atento para não executar o script `script\k8s-cluster\init-db-on-k8s-cluster.sh` que cria um servidor PostgreSQL no cluster Kubernetes ao invés de usar o banco de dados fornecido pela Digital Ocean.

## Instalação e Configuração do Ambiente do My Burger

Para subir o ambiente e a aplicação My Burger, siga os passos abaixo:
> sh -v ./script/k8s-cluster/create-cluster.sh
> 
> sh -v ./script/k8s-cluster/init-db-on-digital-ocean.sh
>
> sh -v ./script/k8s-cluster/start-myburger.sh
