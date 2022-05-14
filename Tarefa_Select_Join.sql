CREATE DATABASE Locadora
GO
USE Locadora
GO

CREATE TABLE cliente
(
	num_cadastro	int					not null		identity(5501,1),
	nome			varchar(100)		not null,
	logradouro		varchar(150)		not null,
	num				int				    not null		check(num >= 0),
	cep				char(8)								CHECK(LEN(cep) = 8)
	PRIMARY KEY(num_cadastro)
)
GO
CREATE TABLE filme
(
	id		int			not null	identity(1001,1),
	titulo	varchar(40)	not null,
	ano		int						check(ano <= 2021)
	PRIMARY KEY(id)
)
GO
CREATE TABLE estrela
(
	id	int	not null	identity(9901,1),
	nome varchar(50) not null
	PRIMARY KEY(id)
)
GO
CREATE TABLE filme_estrela
(
	filmeId		int		not null,
	estrelaId	int		not null
	FOREIGN KEY (filmeId) REFERENCES filme (id),
	FOREIGN KEY (estrelaId) REFERENCES estrela (id)
)
GO
CREATE TABLE dvd
(
	num					int			not null	identity(10001,1),
	data_fabricacao	    date	    not null	check(data_fabricacao < getdate()),
	idFilme				int			not null
	PRIMARY KEY(num),
	FOREIGN KEY (idFilme) REFERENCES filme (id)
)
GO
CREATE TABLE locacao
(
	DVDnum				int				not null,
	Clientenum_cadastro	int				not null,
	data_locacao		date			not null	check(data_locacao = getdate()),
	data_devolucao		date			not null,
	valor				decimal(7,2)	not null	check(valor >= 0)
	
	PRIMARY KEY(data_locacao, DVDnum, Clientenum_cadastro),
	FOREIGN KEY(DVDnum) REFERENCES dvd(num),
	FOREIGN KEY (Clientenum_cadastro) REFERENCES cliente (num_cadastro)
	
)

alter table filme
alter column titulo varchar(80)


--inserindo filme na tabela
INSERT INTO filme (titulo, ano) VALUES
('Whiplash', 2015)

INSERT INTO filme (titulo, ano) VALUES
('Birdman', 2015)

INSERT INTO filme (titulo, ano) VALUES
('Interestelar', 2014)

INSERT INTO filme (titulo, ano) VALUES
('A Culpa é das estrelas', 2015)

INSERT INTO filme (titulo, ano) VALUES
('Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', 2016)

INSERT INTO filme (titulo, ano) VALUES
('Sing', 2016)

INSERT INTO filme (titulo, ano) VALUES
('Aaaaaaaa', 2020)

select *
from filme

select *
from estrela

--inserindo estrela na tabela
alter table estrela
add nomeReal varchar(50) 

INSERT INTO estrela(nome, nomeReal) VALUES
('Michael Keaton', 'Michael John Douglas')

INSERT INTO estrela(nome, nomeReal) VALUES
('Emma Stone', 'Emily Jean Stone')

INSERT INTO estrela(nome, nomeReal) VALUES
('Miles Teller')

INSERT INTO estrela(nome, nomeReal) VALUES
('Steve Carell', 'Steven John Carell')

INSERT INTO estrela(nome, nomeReal) VALUES
('Jennifer Garner', 'Jennifer Anne Garner')

--inserindo cliente
INSERT INTO cliente(nome, logradouro, num, cep) VALUES
('Matilde Luz', 'Rua Síria', 150, '03086040')

INSERT INTO cliente(nome, logradouro, num, cep) VALUES
('Carlos Carreiro', 'Rua Bartolomeu Aires', 1250, '04419110')

INSERT INTO cliente(nome, logradouro, num) VALUES
('Daniel Ramalho', 'Rua Itajutiba', 169)

INSERT INTO cliente(nome, logradouro, num) VALUES
('Roberta Bento', 'Rua Jayme Von Rosenburg', 36)

INSERT INTO cliente(nome, logradouro, num, cep) VALUES
('Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110')

--inserindo dvd
INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2020-12-02', 1001)

INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2019-10-18', 1002)

INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2020-04-03', 1003)

INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2020-12-02', 1001)

INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2019-10-18', 1004)

INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2020-04-03', 1002)

INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2020-12-02', 1005)

INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2019-10-18', 1002)

INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2020-04-03', 1003)

--inserindo filme_estrela
INSERT INTO filme_estrela(filmeId, estrelaId) VALUES
(1002, 9901)

INSERT INTO filme_estrela(filmeId, estrelaId) VALUES
(1002, 9902)

INSERT INTO filme_estrela(filmeId, estrelaId) VALUES
(1001, 9903)

INSERT INTO filme_estrela(filmeId, estrelaId) VALUES
(1005, 9904)

INSERT INTO filme_estrela(filmeId, estrelaId) VALUES
(1005, 9905)

--inserindo locacao
INSERT INTO locacao(DVDnum, Clientenum_cadastro, data_devolucao, valor) VALUES
(10001, 5501,'2022-04-30', 3.50)

update cliente
set cep = '08411150'
where num_cadastro = 5503

update cliente
set cep = '02918190'
where num_cadastro = 5504

--1
select f.id, 
	   f.titulo
from filme f
where ano = 2014

--2
select f.id, f.ano
from filme f
where titulo = 'Birdman'

--3
select f.id, f.ano
from filme f
where titulo like '%plash'

--4 Fazer um select que retorne o id, o nome e o nome_real da estrela 
--cujo nome começa com Steve

--5 Fazer um select que retorne FilmeId e a data_fabricação em 
--formato (DD/MM/YYYY) (apelidar de fab) dos filmes fabricados a partir de 01-01-2020

--6 
select l.DVDnum,
	   l.data_locacao,
	   l.data_devolucao,
	   l.valor,
	   cast(l.valor + l.valor * 2.00 as decimal (7,2)) as crescimo
from cliente cli  left  outer join locacao l
on cli.num_cadastro = l.Clientenum_cadastro
 where num_cadastro = 5505

 select * from cliente where num_cadastro = 5505

--7 
select cli.logradouro,
	   cli.num,
	   cli.cep 
from cliente cli
where nome = 'Matilde Luz'

--8 
select es.nomeReal
from estrela es 
where nome = 'Michael Keaton'

--9 
select cli.num_cadastro,
	   cli.nome,
	   cli.logradouro + ' ' + cast(cli.num as varchar(4)) + ' ' + cli.cep as end_comp
from cliente cli
where cli.num_cadastro >= 5503