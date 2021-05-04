# <h1 align="center">tf_network</h1>
<p align="center"> Desafio técnico Network</p>
Este projeto tem a intenção de avaliar e mostrar ao candidato as ferramentas e trabalhos executados no dia a dia de trabalho.

Índice
===============
<!--ts-->
   * [Sobre o desafio](#Sobre-o-desafio)
   * [Tabela de Conteudo](#tabela-de-conteudo)
   * [Instalação](#instalacao)
   * [Como usar](#como-usar)
      * [Pre Requisitos](#pre-requisitos)
      * [Local files](#local-files)
      * [Remote files](#remote-files)
      * [Multiple files](#multiple-files)
      * [Combo](#combo)
   * [Tests](#testes)
   * [Tecnologias](#tecnologias)
<!--te-->

##Sobre o desafio##

**Objetivos**
1. Criar uma estrutura básica de rede usando 3 VPCs.
  * a. Criar as VPCs usando os respectivos blocos
    * i. VPC A - 10.10.0.0/16
   * ii. VPC B - 10.20.0.0/16
  * iii. VPC C - 10.30.0.0/16
  b. Cada VPC precisa ser segmentada em 3 tipos de tráfego
    i. Public - subnet que pode receber acessos públicos vindo da internet.
   ii. Private - subnet que irá alocar os servidores de aplicações.
  iii. Database - subnet que irá alocar os servidores de banco de dados.
  c. Cada subnet precisa ter 4 AZ (Availability Zones - São locais distintos dentro de uma região classificadas como A,B,C e D).
    I. subnet-pb (Public) 
      1. subnet-pb-a 
      2. subnet-pb-b 
      3. subnet-pb-c
      4. subnet-pb-d
    II. subnet-pv (Private) 
      1. subnet-pv-a 
      2. subnet-pv-b 
      3. subnet-pv-c 
      4. subnet-pv-d
   III. subnet-db (Database) 
      1. subnet-db-a 
      2. subnet-db-b 
      3. subnet-db-c 
      4. subnet-db-d
  d. Cada VPC precisa ter 2 tabelas de roteamento
    i. Tabela roteamento pública
      1. subnet-pb-a 
      2. subnet-pb-b 
      3. subnet-pb-c 
      4. subnet-pb-d
    ii. Tabela roteamento privada 
      1. subnet-pv-a
      2. subnet-db-a 
      3. subnet-pv-b 
      4. subnet-db-b 
      5. etc
      
2. Criar a comunicação entre as VPC usando VPC Peering
  a. Fluxograma
  +-------+                            +-------+
  | VPC B |                            | VPC C |   
  +-------+                            +-------+
      |                                    |
      |            +----------+            |
      +------------+   VPC A  +------------+
                   +----------+
  b. Parâmetros desejados
    i. VPC A fala com VPC B e C
   ii. VPC B fala com VPC A
  iii. VPC C fala com VPC A
   iv. VPC B e C não podem se falar

3. Criar a comunicação entre as VPC usando Transit-Gateway
a. Fluxograma
+-------+ | VPC B | +---+---+
+-------+ | VPC A | +---+---+
+-------+ | VPC C | +---+---+
||| ||| | +--------+--------+ | +-------+ Transit-Gateway +--------+
+-----------------+



      
