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
  * Criar as VPCs usando os respectivos blocos
    * VPC A - 10.10.0.0/16
    * VPC B - 10.20.0.0/16
    * VPC C - 10.30.0.0/16
  * Cada VPC precisa ser segmentada em 3 tipos de tráfego
    * Public - subnet que pode receber acessos públicos vindo da internet.
    * Private - subnet que irá alocar os servidores de aplicações.
    * Database - subnet que irá alocar os servidores de banco de dados.
  * Cada subnet precisa ter 4 AZ (Availability Zones - São locais distintos dentro de uma região classificadas como A,B,C e D).
    * subnet-pb (Public) 
     * subnet-pb-a 
     * subnet-pb-b 
     * subnet-pb-c
     * subnet-pb-d
    * subnet-pv (Private) 
     * subnet-pv-a 
     * subnet-pv-b 
     * subnet-pv-c 
     * subnet-pv-d
    * subnet-db (Database) 
     * subnet-db-a 
     * subnet-db-b 
     * subnet-db-c 
     * subnet-db-d
  * Cada VPC precisa ter 2 tabelas de roteamento
    * Tabela roteamento pública
     * subnet-pb-a 
     * subnet-pb-b 
     * subnet-pb-c 
     * subnet-pb-d
    * Tabela roteamento privada 
     * subnet-pv-a
     * subnet-db-a 
     * subnet-pv-b 
     * subnet-db-b 
     * etc
      
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



      
