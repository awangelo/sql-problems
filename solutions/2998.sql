WITH CumulativeOperations AS (
    SELECT c.name, c.investment, o.month,
        -- SUM() OVER calcula a soma linha a linha 
        -- PARTITION BY separa por cliente e ORDER BY garante a soma na ordem dos meses.
        SUM(o.profit) OVER (PARTITION BY c.id ORDER BY o.month) AS accumulated_profit
    FROM clients c
    JOIN operations o
    ON c.id = o.client_id
),
PaybackFilter AS (
    SELECT name, investment, 
        month AS month_of_payback,
        -- O retorno eh o lucro que passou o investimento - o valor do investimento.
        (accumulated_profit - investment) AS return,
        -- ROW_NUMBER() da um numero para cada linha de payback do cliente.
        -- O primeiro mes que deu lucro sera o 1.
        ROW_NUMBER() OVER (PARTITION BY name ORDER BY month) as rn
    FROM CumulativeOperations
    WHERE accumulated_profit >= investment
)
SELECT name, investment, month_of_payback, return
FROM PaybackFilter
-- Filtra apenas o primeiro mes que o cliente teve retorno positivo,
--     ignora se o cliente continuou tendo lucro nos proximos meses.
WHERE rn = 1
ORDER BY return DESC;