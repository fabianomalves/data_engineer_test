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
-----------------------------

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
-----------------------------

/* Quantos usuários temos por source 
 * ordando por ordem alfabética?
 */


SELECT 
    SUBSTR(utm, 4, 3) AS utm_source, 
    COUNT(*) AS users
FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano
GROUP BY utm_source
ORDER BY utm_source ASC;
-----------------------------



/* Quantos usuários únicos temos por source 
 * ordando por ordem alfabética?
 */

SELECT 
    SUBSTR(utm, 4, 3) AS utm_source, 
    COUNT(DISTINCT id) AS unique_users
FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano 
GROUP BY utm_source
ORDER BY utm_source ASC;
-----------------------------



/*
 * O estado de acesso obtido atraves das coordenadas geograficas 
 * fica na mesma Região Fiscal que esse CPF foi registrado? 
 * (Criar flag same_state no select) 
 */


SELECT 
    t1.cpf AS cpf_user,
    t1.address_state AS adress_state_user_acronym,
    t2.initials AS brazilian_state_acronym,
    t3.id AS cpf_state_ids,
    t3.uf AS region_state_cpf 
FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano AS t1
LEFT JOIN begrowth_user_api_demo_bg_users_brazilian_state AS t2
ON t1.address_state = t2.initials 
LEFT JOIN begrowth_user_api_demo_bg_users_cpf_state AS t3
ON SUBSTRING(t1.cpf, 9, 1) = CAST (t3.id AS TEXT)  
-----------------------------


SELECT 
    t1.cpf AS cpf_user,
    t1.address_state AS adress_state_user_acronym,
    t2.initials AS brazilian_state_acronym,
    t3.id AS cpf_state_ids,
    t3.uf AS region_state_cpf,
    COALESCE(
        (
            SELECT 'same_state'
            FROM (
                SELECT 
                    t1.cpf AS cpf_user,
                    t1.address_state AS adress_state_user_acronym,
                    t2.initials AS brazilian_state_acronym,
                    t3.id AS cpf_state_ids,
                    t3.uf AS region_state_cpf 
                FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano AS t1
                LEFT JOIN begrowth_user_api_demo_bg_users_brazilian_state AS t2
                ON t1.address_state = t2.initials 
                LEFT JOIN begrowth_user_api_demo_bg_users_cpf_state AS t3
                ON SUBSTRING(t1.cpf, 9, 1) = CAST (t3.id AS TEXT)
            ) AS subquery
            WHERE region_state_cpf = t2.initials
            LIMIT 1
        ), 'different_state'
    ) AS same_state
FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano AS t1
LEFT JOIN begrowth_user_api_demo_bg_users_brazilian_state AS t2
ON t1.address_state = t2.initials 
LEFT JOIN begrowth_user_api_demo_bg_users_cpf_state AS t3
ON SUBSTRING(t1.cpf, 9, 1) = CAST (t3.id AS TEXT);


-----------------------------


SELECT *
FROM begrowth_user_api_demo_bg_users_bg_data_enginner_test_fabiano 
LIMIT 10;
-----------------------------

SELECT  
    *
FROM begrowth_user_api_demo_bg_users_brazilian_state
-----------------------------

SELECT  
    *
FROM begrowth_user_api_demo_bg_users_cpf_state
-----------------------------


 

