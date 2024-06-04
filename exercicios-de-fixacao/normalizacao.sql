## O comando USE é por sua conta.

CREATE TABLE categoria(
	id tinyint unsigned primary key auto_increment,
    nome varchar(30) not null
);

INSERT INTO categoria(nome)
SELECT DISTINCT categoria FROM livros order by categoria;

SELECT * FROM categoria;

ALTER TABLE livros
ADD id_categoria tinyint unsigned;

ALTER TABLE livros
ADD CONSTRAINT FOREIGN KEY (id_categoria)
REFERENCES categoria(id);

SELECT * FROM livros;

UPDATE livros l
SET id_categoria = ( SELECT id FROM categoria c WHERE c.nome = l.categoria);

ALTER TABLE livros
DROP COLUMN categoria;

CREATE TABLE idioma(
	id tinyint unsigned primary key auto_increment,
    nome varchar(30) not null
);

INSERT INTO idioma(nome)
SELECT DISTINCT idioma FROM livros order by idioma;


ALTER TABLE livros
ADD id_idioma tinyint unsigned;

ALTER TABLE livros
ADD CONSTRAINT FOREIGN KEY (id_idioma)
REFERENCES idioma(id);

UPDATE livros l
SET id_idioma = ( SELECT id FROM idioma i WHERE i.nome = l.idioma);

ALTER TABLE livros
DROP COLUMN idioma;

CREATE TABLE Editora(
	id tinyint unsigned primary key auto_increment,
    nome varchar(50) not null
);

INSERT INTO Editora(nome)
SELECT DISTINCT Editora FROM livros order by Editora;

SELECT * FROM Editora;


ALTER TABLE livros
ADD id_editora tinyint unsigned;

ALTER TABLE livros
ADD CONSTRAINT FOREIGN KEY (id_editora)
REFERENCES editora(id);

UPDATE livros l
SET id_editora = ( SELECT id FROM editora i WHERE i.nome = l.editora);

ALTER TABLE livros
DROP COLUMN editora;

CREATE TABLE Autor(
	id tinyint unsigned primary key auto_increment,
    nome varchar(50) not null
);

INSERT INTO Autor(nome)
SELECT DISTINCT Autor FROM livros order by Autor;

SELECT * FROM Autor;

CREATE TABLE Autor_Livro(
	id_livro int,
    id_autor tinyint unsigned,
    CONSTRAINT PRIMARY KEY (id_livro, id_autor),
    CONSTRAINT `FK_LIVRO` FOREIGN KEY (id_livro)
		REFERENCES livros(id),
	CONSTRAINT `FK_AUTOR` FOREIGN KEY (id_autor)
		REFERENCES autor(id)
);
INSERT INTO Autor_Livro
SELECT livros.id, autor.id
FROM livros
INNER JOIN autor ON autor.nome = livros.autor;

ALTER TABLE livros
DROP COLUMN autor;
