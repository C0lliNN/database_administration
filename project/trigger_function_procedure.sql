--  A plataforma decidiu realizar anúncios durante um evento de uma universidade. Assim, deseja-se saber 
--  quão efetiva estão sendo as propagandas. Para esse fim, deverá ser criado um trigger registrando
--  a data e horário de novas inscrições


CREATE TABLE inscricoes_logs (
  id INT NOT NULL PRIMARY KEY auto_increment,
  id_sessao INT NOT NULL,
  criado_em TIMESTAMP NOT NULL
);

delimiter #
CREATE TRIGGER inscricoes_logs_trigger AFTER INSERT ON participacao
FOR EACH ROW
BEGIN
  INSERT INTO inscricoes_logs VALUES(null, new.id, CURRENT_TIMESTAMP());
END#
delimiter ;

-- A plataforma está tendo uma grande despesa para armazenar os dados. Como a tabela de avaliacao 
-- está muito grande e apenas a media das avaliações para uma determinada sessão é útil, 
-- é necessário realizar a compilação dessa tabela da seguinte maneira:
-- para cada sessao, obtenha a media das avaliações, 
-- remova todas as avaliações para a sessao
-- insira um registro com a media da sessao

delimiter #
CREATE PROCEDURE compilar_avaliacoes()
BEGIN
  DECLARE fim INT;
  DECLARE v_id_sessao INT DEFAULT 0;
  DECLARE media INT;
  DECLARE curs CURSOR FOR SELECT DISTINCT id_sessao FROM avaliacao;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = 1;

  START TRANSACTION;

  OPEN curs;

  compilacao: LOOP
    FETCH curs INTO v_id_sessao;

    IF fim = 1 THEN 
			LEAVE compilacao;
		END IF;

    SELECT ROUND(AVG(nota)) INTO media FROM avaliacao WHERE id_sessao = v_id_sessao;

    DELETE FROM avaliacao WHERE id_sessao = v_id_sessao;
    INSERT INTO avaliacao VALUES(null, v_id_sessao, 1, media);
  END LOOP compilacao;

  CLOSE curs;

  COMMIT;
END#

delimiter ;

-- O uso da media das avaliações se tornou muito comum durante as operações do DBA. Assim uma
-- função que recebesse o id de uma sessao e retorne a media como um inteiro seria muito útil
delimiter #


CREATE FUNCTION obter_media (v_id_sessao INT)
RETURNS INT
BEGIN
  DECLARE media INT;
  SELECT ROUND(AVG(nota)) INTO media FROM avaliacao WHERE id_sessao = v_id_sessao;
  RETURN media;
END#

delimiter ;