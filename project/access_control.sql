-- Permite que o admin acesse o MySQL Server a partir de qualquer IP com todas as permissões
CREATE USER 'admin'@'%' IDENTIFIED BY 'senha_super_segura';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';

-- Permite que raphael acesse o MySQL Server para manipular somente três tabelas.
CREATE USER 'raphael'@'%' IDENTIFIED BY 'senha_raphael';
GRANT SELECT, INSERT, UPDATE, DELETE ON gerenciamento_conferencia.participante TO 'raphael'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON gerenciamento_conferencia.participacao TO 'raphael'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON gerenciamento_conferencia.avaliacao TO 'raphael'@'%';

-- Permite que pedro acesse o MySQL Server para manipular somente três colunas da tabela avaliacao.
CREATE USER 'pedro'@'%s' IDENTIFIED BY 'senha_pedro';
GRANT SELECT (id, id_sessao, nota) ON gerenciamento_conferencia.avaliacao TO 'pedro'@'%';
