-- Gerar uma lista com as conferências iniciadas nos últimos 30 dias, com o número de sessões em cada conferência. As conferências
-- devem ser ordenadas por data em ordem crescente
SELECT 
    c.id "ID da Conferência", 
    c.titulo 'Título da Conferência', 
    (SELECT COUNT(*) FROM sessao s WHERE s.id_conferencia = c.id) "Número de Sessões"
FROM conferencia c    
WHERE
     c.data_inicio >= DATE_SUB(CURDATE(),INTERVAL 30 DAY)
ORDER BY c.data_inicio ASC;
  
-- Gerar uma lista com as 10 sessões mais bem avaliadas. O título da conferência, assim como o nome do palestrante também devem ser apresentados
SELECT
    s.id "ID da Sessão",
    s.assunto "Assunto da Sessão",
    c.titulo "Conferência",
    p.nome "Nome do Palestrante",
    (SELECT AVG(a.nota) FROM avaliacao a WHERE a.id_sessao = s.id) "Nota Media"
FROM sessao s
INNER JOIN conferencia c ON s.id_conferencia = c.id
INNER JOIN palestra ON palestra.id_sessao = s.id
INNER JOIN palestrante p ON p.id = palestra.id_palestrante
ORDER BY 5 DESC
LIMIT 10;

-- Gerar uma lista dos 5 participantes que mais realizaram palestras na plaforma. Os resultados devem ser ordenados em ordem decrescente pelo número
-- de palestras
SELECT
    p.id "ID do Participante",
    p.nome "Nome do Participante",
    (SELECT COUNT(*) FROM participacao WHERE id_participante = p.id) "Participações"
 FROM participante p   
 ORDER BY 3 DESC
 LIMIT 5;

-- Gerar uma lista com todos os participantes que estiveram em alguma sessão nos últimos 790 dias. Ao lado do nome de cada participante
-- deve ser apresentado se ele/ela gostou ou não da sessao. Caso sua avaliação tenha sido >= 3, significa que tenha gostado, caso contrário não.
SELECT 
    p.id "ID do Participante",
    p.nome "Nome do Participante",
    CASE 
      WHEN (SELECT a.nota FROM avaliacao a WHERE a.id_participante = p.id LIMIT 1) >= 3 THEN 'Sim'
      ELSE 'Não'
    END 'Gostou'
FROM participante p
INNER JOIN participacao ON p.id = participacao.id_participante
INNER JOIN sessao s ON s.id = participacao.id_sessao
WHERE
    s.data >= DATE(DATE_SUB(CURDATE(), INTERVAL 90 DAY));

-- Gerar uma lista com lotação de todas as conferência que possuem limite de participantes. A lotação deve ser calculado dividindo o número de 
-- participantes pelo limite de participantes. Apenas as 20 primeiras conferências devem ser retornadas.
SELECT 
    c.id "ID da Conferência",
    c.titulo "Título da Conferência",
    (
      SELECT COUNT(*) FROM participante 
      INNER JOIN participacao ON participante.id = participacao.id_participante
      INNER JOIN sessao s ON s.id = participacao.id_sessao
      WHERE s.id_conferencia = c.id
    ) 
    / c.limite_participantes
    AS 'Lotação (%)'
FROM conferencia c
WHERE c.limite_participantes IS NOT NULL
ORDER BY 3 DESC
LIMIT 20;
