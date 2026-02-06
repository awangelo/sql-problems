SELECT 
    dep.nome AS departamento,
    div.nome AS divisao,
    ROUND(AVG(salarios.liquido), 2) AS media_salarial,
    ROUND(MAX(salarios.liquido), 2) AS maior_salario
FROM departamento dep
JOIN divisao div ON dep.cod_dep = div.cod_dep
JOIN empregado e ON div.cod_divisao = e.lotacao_div
JOIN (
    -- Calculamos o salario liquido de cada matricula isoladamente
    SELECT 
        e2.matr,
        (
            -- Soma de vencimentos
            COALESCE((SELECT SUM(v.valor) 
                      FROM vencimento v 
                      JOIN emp_venc ev ON v.cod_venc = ev.cod_venc 
                      WHERE ev.matr = e2.matr), 0) 
            - 
            -- Soma de descontos
            COALESCE((SELECT SUM(d.valor) 
                      FROM desconto d 
                      JOIN emp_desc ed ON d.cod_desc = ed.cod_desc 
                      WHERE ed.matr = e2.matr), 0)
        ) AS liquido
    FROM empregado e2
) AS salarios ON e.matr = salarios.matr
GROUP BY dep.nome, div.nome
ORDER BY media_salarial DESC;