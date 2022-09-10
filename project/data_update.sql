-- Ocorreu um imprevisto com a conferência 'Lexus' fazendo com que seja necessário realizar o adiamento de todas as sessões
-- conforme a seguinte especificação:
-- Se o a hora de início da sessão for antes do meio dia, então é necessário incrementar a data em um dia
-- Caso contrário, é necessário incrementar a data em dois dias

UPDATE sessao set data = CASE 
	WHEN hora_inicio < '12:00:00' THEN DATE(DATE_ADD(data, INTERVAL 1 DAY))
    ELSE DATE(DATE_ADD(data, INTERVAL 2 DAY))
END
WHERE id_conferencia = (SELECT id FROM conferencia WHERE titulo = 'Lexus'); 
