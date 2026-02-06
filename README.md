# sql-problems

Window Functions (OVER): Utilizadas para realizar cálculos em um conjunto de linhas que possuem relação com a linha atual. Não juntam as linhas ao contrário do GROUP BY, permitindo operar sobre um valor de cada linha enquanto se calcula outro valor.

Subconsultas Correlacionadas: Separa somas e cálculos complexos dentro do SELECT ou em blocos JOIN.

Tratamento de Nulos (COALESCE): Substitui valores NULL por um valor padrão (geralmente 0), garantindo que operações matemáticas não terminem em NULL.

Filtragem por Partição (ROW_NUMBER): Numera registros dentro de grupos específicos. Permite selecionar apenas a primeira ocorrência (ou N o ocorrências) de um evento após uma condição ser atingida.