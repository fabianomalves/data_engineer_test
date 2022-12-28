SELECT *
FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano 
LIMIT 10;

/* Quantos usuários temos por estado de acesso 
 * ordenando pelo estado com maior número 
 * (coluna address_state)?
 */
SELECT 
    COUNT(DISTINCT ID) AS count_by_state,
    address_state AS state
FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano 
GROUP BY address_state 
ORDER BY COUNT(DISTINCT ID) DESC;

/*
 * Quantos usuários únicos temos por estado
 * de acesso ordenando pelo estado com maior número
 * (coluna address_state)?
*/

SELECT 
    COUNT(DISTINCT id) AS count_by_state,
    address_state AS state
FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano 
GROUP BY address_state 
HAVING COUNT(DISTINCT ID) <= '1';

/* Quantos usuários temos por source 
 * ordando por ordem alfabética?
 */


SELECT 
    SUBSTR(utm, 4, 3) AS utm_source, 
    COUNT(*) AS users
FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano
GROUP BY utm_source
ORDER BY utm_source ASC;




/* Quantos usuários únicos temos por source 
 * ordando por ordem alfabética?
 */

SELECT 
    SUBSTR(utm, 4, 3) AS utm_source, 
    COUNT(DISTINCT id) AS unique_users
FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano 
GROUP BY utm_source
ORDER BY utm_source ASC;


/*
 * O estado de acesso obtido atraves das coordenadas geograficas 
 * fica na mesma Região Fiscal que esse CPF foi registrado? 
 * (Criar flag same_state no select) 
 */

-- a coluna UF da tabela begrowth_user_api_demo_bg_users_brazilian_state
-- e a coluna address_state da tabela begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano
-- estão diferentes. Olhar uma forma de fazer um de para com elas

SELECT *
FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano 
LIMIT 10;

SELECT  
    *
FROM begrowth_user_api_demo_bg_users_brazilian_state

SELECT
    t1.id,
    t1.address_state,
    t2.uf 
FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano AS t1
LEFT JOIN begrowth_user_api_demo_bg_users_brazilian_state AS t2
ON t1.address_state = t2.uf 
 

