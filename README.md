# :rocket: Desafio
Nosso time de negócio precisa analisar dados de alguns usuários para tomada de decisões futuras

O desafio é capturar os dados que recebemos de alguns usuários e conseguir responder perguntas que definirão os próximos passos da empresa!
 
## Tarefas
### 1. Consumir dados de usuário da Mock APIs
Passando o token recebido por email para o endpoint ```https://my.api.mockaroo.com/users_bg.json?key=userkey``` ele retorna dados de usuários formatado em json
 
### 2. Transformar e tratar os dados em um dataframe com Python
Para ajudar o time de produto em suas análises, precisamos que os dados estejam formatados e com seu data type correto
 
**Regras de negócio**
* Precisamos saber o estado que a pessoa acessou nossos serviços, com as coordenadas dos usuários (`address.geo_latitude` e `address.geo_longitude`) devemos criar uma coluna de estado chamada `address_state`;
* a API nos devolve o CPF do usuário, mas temos um problema: o CPF está **criptografado**! Utilizando a chave de criptografia passada por email, abra esse CPF para que possamos analisar o próximo requisito;
* Você sabia que o nono dígito do CPF corresponde a Região Fiscal emissora do CPF? [veja sobre](http://clubes.obmep.org.br/blog/a-matematica-nos-documentos-cpf/). Sabendo disso, nosso time precisa saber qual a Região Fiscal que esse CPF foi registrado:


| Nono dígito | UF |
| :--- | :--- |
| 1 | DF, GO, MS, MT, TO |
| 2 | AC, AM, AP, PA, RO, RR |
| 3 | CE, MA, PI |
| 4 | AL, PB, PE, RN |
| 5 | BA, SE |
| 6 | MG |
| 7 | ES, RJ |
| 8 | SP |
| 9 | PR, SC |
| 0 | RS |


* Para ajudar a identificar registros mais atualizados e para nosso controle de auditoria, precisamos que o dataframe tenha as colunas `dt_insert` que contenha data/hora de inclusão do registro e `candidate_name` que contenha seu nome
 
### 3. Jogar esse dataframe dentro de uma tabela no BigQuery
Deixamos os dados no jeitinho para que eles possam ser armazenados dentro de uma tabela na nossa base de dados.
Utilizando a service account enviada por email crie a tabela no banco de dados com a seguinte nomenclatura **bg_data_enginner_test_seuNome**
 
**utilizando consultas SQL responda as perguntas**
* Quantos usuários temos por estado de acesso (coluna address_state)?
* Quantos usuários únicos temos por estado de acesso (coluna address_state)?
* Quantos usuários temos por source?
* Quantos usuários únicos temos por source?
* O estado de acesso obtido atraves das coordenadas geograficas fica na mesma Região Fiscal que esse CPF foi registrado? (Criar flag same_state no Select)
 
### 4. O que esperamos:
* Seu projeto deve estar em um repositório **git**.
* Crie uma documentação que explique como fez para chegar nos resultados obtidos, pode ser no README.md do git.
* Sinta-se à vontade para usar qualquer framework, bibliotecas e ferramentas que se sentir à vontade a única restrição é a linguagem de programação que deve ser **Python**

***Todos os dados de usuário são ficticios gerados para efeito de teste/estudo por plataformas como mockaroo e 4Devs**
