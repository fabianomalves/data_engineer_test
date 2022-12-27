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
  SUBSTR(utm, 4, 2) as utm_source,
  COUNT(DISTINCT id) as num_users
FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano 
WHERE SUBSTR(utm, 4, 2) IN ('gg', 'fb', 'wp')
GROUP BY SUBSTR(utm, 4, 2)




/* Quantos usuários únicos temos por source 
 * ordando por ordem alfabética?
 */


/*
 * O estado de acesso obtido atraves das coordenadas geograficas 
 * fica na mesma Região Fiscal que esse CPF foi registrado? 
 * (Criar flag same_state no select)
 */

SELECT 
FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano AS t1
LEFT JOIN begrowth_user_api_demo_bg_users_brazilian_state AS t2
ON t1.address_state = t2.uf
WHERE 

