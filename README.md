# tf_network

Este projeto é uma avaliação do provisionamento de recursos de rede envolvendo VPCs e criando a comunicação entre elas via peering e transit gateway.

**Índice**
   * [Sobre o projeto](#Sobre-o-projeto)
   * [Estrutura](#Estrutura)
   * [Pré Requisitos](#Pré-requisitos)
   * [Rodando o código](#Rodando-o-código)
   * [Tecnologias e recursos](#Tecnologias-e-recursos)
   * [Contatos](#Contatos)

***

## Sobre o projeto

Foi implementado uma estrutura básica de redes usando 3 VPC segmentada em 3 tipos de tráfego e criado a comunicação entre as VPC usando peering e também transit gateway com controle de tráfego, assim como um VPN IPSEC de um ponto remoto à VPC A.

Na comunicação via peering a VPC A fala com a VPC B e C, VPC B fala apenas com a VPC A, VPC C fala apenas com a VPC A, VPC B e C não se falam conforme solicitado.

Na comunicação via transit gateway, foi implementado dois transit gateway, um com controle de tráfego e 3 tabelas de roteamento. O primeiro transit gateway solicitado no item 3, todas as VPCs se falam e no segundo transit gateway com controle de tráfego, pedido no item 4, segue os mesmos parâmetros pedidos para a comunicação via peering.
    
***

## Estrutura

<img src="Images/diagrama.png" alt="diagrama.png" width="700">

***

## Pré Requisitos

Antes de começar, você vai precisar ter o [Terraform](https://www.terraform.io/) instalado em sua máquina e uma conta na [AWS](https://aws.amazon.com/pt/) com a variável de ambiente configurada.
Além disto é bom ter um editor para trabalhar com o código como o [Visual Studio Code](https://code.visualstudio.com/).

***

## Rodando o código

```bash
Clone este repositório
$ git clone <https://github.com/gersonborgesbatista/tf_network.git>

Acesse a pasta do projeto no terminal
$ cd tf_network

Inicie o terraform
$ terraform init

Verifique as configurações antes de executar efetivamente
$ terraform plan

Execute o código
$ terraform apply
```

***

## Tecnologias e recursos

* AWS https://aws.amazon.com/pt/
* Draw.io https://app.diagrams.net/
* Terraform https://www.terraform.io/
* Visual Studio Code https://code.visualstudio.com/
* Curso AWS com Terraform https://www.udemy.com/course/aws-com-terraform/

***

## Contatos

Para qualquer pergunta ou feedback, sinta-se à vontade para entrar em contato:

* E-mail: gerson.borges@live.com
* Linkedin: https://www.linkedin.com/in/gerson-borges/
 
      
