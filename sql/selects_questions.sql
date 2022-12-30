/* Quantos usuários temos por estado de acesso 
 * ordenando pelo estado com maior número 
 * (coluna address_state)?
 */

SELECT 
    COUNT(DISTINCT t1.id) AS users_by_state,
    t1.address_state AS state
FROM
    begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano AS t1
GROUP BY
    t1.address_state
ORDER BY
    COUNT(DISTINCT ID) DESC;

-----------------------------



/*
 * Quantos usuários únicos temos por estado
 * de acesso ordenando pelo estado com maior número
 * (coluna address_state)?
*/

SELECT 
    COUNT(DISTINCT t1.id) AS unique_users_by_state,
    t1.address_state AS state
FROM
    begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano AS t1
GROUP BY
    t1.address_state
HAVING
    COUNT(DISTINCT t1.id) = '1';
-----------------------------

-----------------------------


/* Quantos usuários temos por source 
 * ordando por ordem alfabética?
 */

SELECT
    COUNT(t1.*) AS users,
    SUBSTR(
        t1.utm, 4, 3
    ) AS utm_source
FROM
    begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano AS t1 
GROUP BY
    utm_source
ORDER BY
    utm_source ASC;
-----------------------------



/* Quantos usuários únicos temos por source 
 * ordando por ordem alfabética?
 */

SELECT 
    COUNT(DISTINCT t1.id) AS unique_users,
    SUBSTR(
        t1.utm, 4, 3
    ) AS utm_source
FROM
    begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano AS t1
GROUP BY
    utm_source
ORDER BY
    utm_source ASC;
-----------------------------



/*
 * O estado de acesso obtido atraves das coordenadas geograficas 
 * fica na mesma Região Fiscal que esse CPF foi registrado? 
 * (Criar flag same_state no select) 
 */

SELECT 
    t1.id AS id_user,
    LPAD(t1.cpf, 11, '0') AS cpf_user,
    t1.address_state AS adress_state_user,
    t3.id AS cpf_state_ids,
    t3.uf AS region_state_cpf,
    COALESCE(
        (
            SELECT 'same_state'
            FROM (
                SELECT 
                    t1.id AS id_user,
                    LPAD(t1.cpf, 11, '0') AS cpf_user,
                    t1.address_state AS adress_state_user,
                    t3.id AS cpf_state_ids,
                    t3.uf AS region_state_cpf 
                FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano AS t1
                LEFT JOIN begrowth_user_api_demo_bg_users_brazilian_state AS t2
                ON t1.address_state = t2.initials 
                LEFT JOIN begrowth_user_api_demo_bg_users_cpf_state AS t3
                ON SUBSTRING(LPAD(t1.cpf, 11, '0'), 9, 1) = CAST (t3.id AS TEXT)
            ) AS subquery
            WHERE t1.address_state 
            IN (
                SELECT regexp_split_to_table(t3.uf, ', ')
)
            LIMIT 1
        ), 'different_state'
    ) AS same_state
FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano AS t1
LEFT JOIN begrowth_user_api_demo_bg_users_brazilian_state AS t2
ON t1.address_state = t2.initials 
LEFT JOIN begrowth_user_api_demo_bg_users_cpf_state AS t3
ON SUBSTRING(LPAD(t1.cpf, 11, '0'), 9, 1) = CAST (t3.id AS TEXT)
ORDER BY same_state DESC;
-----------------------------



SELECT *
FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano AS t1
LIMIT 10;
-----------------------------

SELECT  
    *
FROM begrowth_user_api_demo_bg_users_brazilian_state AS t2
-----------------------------

SELECT  
    *
FROM begrowth_user_api_demo_bg_users_cpf_state AS t3
-----------------------------


 

