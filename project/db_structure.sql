CREATE DATABASE gerenciamento_conferencia;

USE gerenciamento_conferencia;

CREATE TABLE gerente(
  id INT NOT NULL PRIMARY KEY auto_increment,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(255) NOT NULL,
  senha VARCHAR(255) NOT NULL
);

CREATE TABLE conferencia(
  id INT NOT NULL PRIMARY KEY auto_increment,
  titulo VARCHAR(120) NOT NULL,
  descricao TEXT,
  data_inicio DATETIME NOT NULL,
  data_fim DATETIME NOT NULL,
  limite_participantes INT,
  id_gerente INT NOT NULL,
  FOREIGN KEY (id_gerente) REFERENCES gerente(id)
  ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE INDEX idx_conferencia_id_gerente ON conferencia(id_gerente);

CREATE TABLE sessao(
  id INT NOT NULL PRIMARY KEY auto_increment,
  assunto VARCHAR(120) NOT NULL,
  descricao TEXT,
  data DATE NOT NULL,
  hora_inicio TIME NOT NULL,
  hora_termino TIME NOT NULL,
  link_acesso VARCHAR(255) NOT NULL,
  id_conferencia INT NOT NULL,
  FOREIGN KEY (id_conferencia) REFERENCES conferencia(id) 
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX idx_sessao_id_conferencia ON sessao(id_conferencia);

CREATE TABLE imagem(
  id INT NOT NULL PRIMARY KEY auto_increment,
  url VARCHAR(255) NOT NULL,
  descricao VARCHAR(255) NOT NULL,
  id_entidade INT NOT NULL
);

CREATE INDEX idx_imagem_id_entidade ON imagem(id_entidade);

CREATE TABLE participante (
  id INT NOT NULL PRIMARY KEY auto_increment,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(255) NOT NULL
);

CREATE TABLE participacao (
  id INT NOT NULL PRIMARY KEY auto_increment,
  id_participante INT NOT NULL,
  id_sessao INT NOT NULL,
  FOREIGN KEY (id_participante) REFERENCES participante(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_sessao) REFERENCES sessao(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX idx_participacao_id_participante ON participacao(id_participante);
CREATE INDEX idx_participacao_id_sessao ON participacao(id_sessao);

CREATE TABLE palestrante (
  id INT NOT NULL PRIMARY KEY auto_increment,
  nome VARCHAR(75) NOT NULL,
  sobrenome VARCHAR(75) NOT NULL,
  email VARCHAR(255) NOT NULL,
  descricao_profissional VARCHAR(255) NOT NULL
);

CREATE TABLE palestra (
  id INT NOT NULL PRIMARY KEY auto_increment,
  id_palestrante INT NOT NULL,
  id_sessao INT NOT NULL,
  FOREIGN KEY (id_palestrante) REFERENCES palestrante(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_sessao) REFERENCES sessao(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX idx_palestra_id_palestrante ON palestra(id_palestrante);
CREATE INDEX idx_palestra_id_sessao ON palestra(id_sessao);

CREATE TABLE avaliacao (
  id INT NOT NULL PRIMARY KEY auto_increment,
  id_sessao INT NOT NULL,
  id_participante INT NOT NULL,
  nota INT NOT NULL,
  FOREIGN KEY (id_sessao) REFERENCES sessao(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_participante) REFERENCES participante(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX idx_availacao_id_sessao ON avaliacao(id_sessao);
CREATE INDEX idx_availacao_id_participante ON avaliacao(id_participante);
