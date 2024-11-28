SELECT * FROM AERONAVE;

SELECT DISTINCT
         p.nome,
         p.cpf,
         p.telefone,
         p.passaporte,
         v.numero_voo,
         origem.nome AS origem,
         destino.nome AS destino
    FROM passageiro p
    NATURAL JOIN passageiro_voo pv
    NATURAL JOIN voo v
    JOIN aeroporto origem ON v.ORIGEM_ID = origem.AEROPORTO_ID
    JOIN aeroporto destino ON v.DESTINO_ID = destino.AEROPORTO_ID
    WHERE origem.PAIS = 'Brasil' AND destino.PAIS = 'Brasil';

-- Passageiros em voos internacionais
SELECT DISTINCT
         p.nome,
         p.cpf,
         p.telefone,
         p.passaporte,
         v.numero_voo,
         origem.nome AS origem,
         destino.nome AS destino
    FROM passageiro p
      NATURAL JOIN passageiro_voo pv
      NATURAL JOIN voo v
   JOIN aeroporto origem ON v.ORIGEM_ID = origem.AEROPORTO_ID
   JOIN aeroporto destino ON v.DESTINO_ID = destino.AEROPORTO_ID
   WHERE origem.PAIS != 'Brasil' OR destino.PAIS != 'Brasil';


-- Seleciona os IDs dos passageiros que viajaram em voos nacionais, os que participaram de voos internaccionais e, depois, intersecciona os IDs dos passageiros que aparecem em ambos os conjuntos, ou seja, que viajaram em ambos os tipos de voos. 
SELECT  
    f.nome AS Nome, 
    'Funcionario' AS Tipo, 
    v.numero_voo AS NumeroVoo, 
    v.data_partida AS DataPartida 
FROM  funcionario f 
   JOIN  funcionario_voo fv USING (funcionario_id)
   JOIN   voo v ON fv.voo_id = v.voo_id 
UNION ALL 
   SELECT  
      p.nome AS Nome, 
      'Passageiro' AS Tipo, 
      v.numero_voo AS NumeroVoo, 
      v.data_partida AS DataPartida 
      FROM  passageiro p 
      JOIN  passageiro_voo pv USING (passageiro_id)
      JOIN  voo v ON pv.voo_id = v.voo_id 
ORDER BY  
    DataPartida, Tipo, Nome;

-- Quais aeronaves estão inativas atualmente, listar seu modelo, fabricante e a data da última manutenção realizada, e tiveram voos internacionais no ano de 2024.
SELECT DISTINCT
   a.MODELO, 
   a.FABRICANTE,
   a.STATUS,
   v.DATA_CHEGADA,
   origem.nome AS origem,
   destino.nome AS destino,
   m.DATA_MANUTENCAO
FROM AERONAVE a 
   LEFT JOIN MANUTENCAO m USING (AERONAVE_ID)
   JOIN VOO v USING (AERONAVE_ID)
   JOIN aeroporto origem ON v.ORIGEM_ID = origem.AEROPORTO_ID
   JOIN aeroporto destino ON v.DESTINO_ID = destino.AEROPORTO_ID
WHERE a.STATUS = 'Inativa'
AND (origem.PAIS != 'Brasil' OR destino.PAIS != 'Brasil')
AND v.DATA_PARTIDA   
   BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') 
   AND TO_DATE('2024-12-31', 'YYYY-MM-DD')
ORDER BY m.DATA_MANUTENCAO;

--Identificar os aeroportos brasileiros que permitem voos internacionais que mais serviram como destino de voos no último ano e listar o nome do aeroporto, a cidade e o número total de voos recebidos.

SELECT 
   a.NOME, 
   a.CIDADE, 
   COUNT(v.DESTINO_ID) AS TotalVoos
FROM AEROPORTO a
   JOIN VOO v ON a.AEROPORTO_ID = v.DESTINO_ID
   WHERE a.PAIS = 'Brasil'
   AND a.NOME LIKE '%Internacional%'
GROUP BY a.NOME, a.CIDADE
ORDER BY TotalVoos DESC;

/*
* Questão 3
* Criação de 3 subconsultas, com a explicação do porquê de sua classificação como subconsulta;
*/

SELECT Fabricante, AVG(CustoTotal) AS MediaCusto 
FROM ( 
      SELECT a.FABRICANTE, 
      SUM(m.CUSTO) AS CustoTotal 
      FROM MANUTENCAO m 
      INNER JOIN AERONAVE a USING (AERONAVE_ID)
      GROUP BY a.FABRICANTE 
   ) 
GROUP BY Fabricante;

-- Seleciona o fabricante e o custo médio de manutenção das aeronaves por fabricante, através de uma subconsulta que agrupa e seleciona todas as manutenções realizadas por fabricante. 
SELECT v.numero_voo, ( 
      SELECT COUNT(*)   
      FROM funcionario_voo fv   
      WHERE fv.voo_id = v.voo_id  
    ) AS total_funcionarios  
FROM voo v;

--Seleciona o número do voo e a quantidade de funcionários presentes em cada voo, utilizando uma subconsulta que seleciona e conta cada funcionário presente em cada voo. 
SELECT p.nome, ( 
   SELECT COUNT(*)  
   FROM passageiro_voo pv  
   WHERE pv.passageiro_id = p.passageiro_id 
) AS total_voos 
FROM passageiro p;