# :rocket: Desafio
Nosso time de negócio precisa analisar dados de alguns usuários para tomada de decisões futuras

O desafio é capturar os dados que recebemos de alguns usuários e conseguir responder perguntas que definirão os próximos passos da empresa!
 
## Tarefas
**Documentações da API**
- [Swagger UI](https://ua8vha.deta.dev/docs)
- [ReDoc](https://ua8vha.deta.dev/redoc)
### 1. Cadastrar usuário para obter token de acesso da API :key:

**Request Address**: `https://ua8vha.deta.dev/user/`

**Request Method** `POST`

**Request Parameters JSON**:
```
{
  "full_name": "string",
  "email": "user@example.com"
}
```
**Curl**
```
curl -X 'POST' \
  'https://ua8vha.deta.dev/user/' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "full_name": "Joao Henrique",
  "email": "joao@begrowth.com.br"
}'
```
------
**Server response**

Code: **201**
Response Body: 
``` 
{
  "user": "joao@begrowth.com.br",
  "API Token": "{your_access_token}"
}
```

### 2. Consumir dados de usuário da API :key:
Substituindo `access_token` pelo token obtido na etapa anterior, podemos chamar o endpoint `https://ua8vha.deta.dev/token=access_token` que nos retorna dados de usuários em formato **JSON**

Exemplo:
**Saída**
```
{
    "id": 1,
    "first_name": "Allard",
    "last_name": "Shattock",
    "email": "ashattock0@youtube.com",
    "gender": "Male",
    "address": {
        "geo_latitude": -22.4709659,
        "geo_longitude": -44.4513347,
        "country": "Brazil"
    }
}
```
 
### 2. Transformar e tratar os dados em um dataframe com Python
Para ajudar o time de produto em suas análises, precisamos que os dados estejam formatados e com seu data type correto
 
**Regras de negócio**
* Precisamos saber o estado que a pessoa acessou nossos serviços, com as coordenadas `address.geo_latitude` e `address.geo_longitude` dos usuários devemos criar uma coluna de estado chamada `address_state`, processo denominado [reverse geocode](https://en.wikipedia.org/wiki/Reverse_geocoding)
* a API nos devolve o CPF do usuário, mas temos um problema: o CPF está **criptografado**! :lock: Utilizando a chave de criptografia passada por email, abra esse CPF para que possamos analisar o próximo requisito; :unlock:
* :mag_right: Você sabia que o [nono dígito do CPF corresponde a Região Fiscal emissora do CPF](http://clubes.obmep.org.br/blog/a-matematica-nos-documentos-cpf/)? Sabendo disso, nosso time precisa saber qual a Região Fiscal que esse CPF foi registrado:


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
 
### 3. Jogar este dataframe dentro de uma tabela no BigQuery
Deixamos os dados no jeitinho para que eles possam ser armazenados dentro de uma tabela na nossa base de dados.
Utilizando a service account enviada por email crie a tabela no banco de dados com a seguinte nomenclatura **bg_data_enginner_test_seuNome**

**Ponto de atenção**: o BigQuery não aceita colunas com ponto ou caracter especial, precisaremos renomear as colunas que contenham alguns desses casos trocando-os por *underscore* `_`

Leia sobre [Nomes de coluna BigQuery](https://cloud.google.com/bigquery/docs/schemas#column_names)
 
**utilizando consultas SQL responda as perguntas**
* Quantos **usuários** temos por **estado** de acesso (coluna `address_state`)?
* Quantos **usuários únicos** temos por **estado de acesso** (coluna `address_state`)?
* Quantos **usuários** temos por **source**?
* Quantos **usuários** únicos temos por **source**?
* O estado de acesso obtido atraves das coordenadas geograficas fica na mesma Região Fiscal que esse CPF foi registrado? (Criar flag `same_state` no select)
 
### 4. O que esperamos:
* Seu projeto deve estar em um repositório **git**.
* Crie uma documentação que explique como fez para chegar nos resultados obtidos, pode ser no **README** do git.
* Sinta-se à vontade para usar qualquer framework, bibliotecas e ferramentas que se sentir à vontade a única restrição é a linguagem de programação que deve ser **Python**

***Todos os dados de usuário são ficticios gerados para efeito de teste/estudo por plataformas como mockaroo e 4Devs**

**A má utilização dos dados aqui gerados é de total responsabilidade do usuário. Os dados são gerados de forma aleatória, respeitando as regras de criação de cada documento.**
