CREATE DATABASE projeto
go
use projeto


CREATE TABLE users
(
	Id			int				not null			identity(1,1),
	nome		varchar(45)		not null,
	username	varchar(45)		not null			UNIQUE,
	passwords	varchar(45)		not null			DEFAULT('123MUDAR'),
	email		varchar(45)		not null
	PRIMARY KEY(Id)
)
go

CREATE TABLE projects
(
	Id			int				not null			identity(10001,1),
	nome		varchar(45)		not null,
	descricao	varchar(45),
	data_Proj	date			not null			CHECK(data_Proj > '2014-09-01')
	PRIMARY KEY (Id)
)
go 

CREATE TABLE users_has_projects
(
	users_Id		int		not null,
	projects_Id		int		not null
	PRIMARY KEY (users_Id, projects_Id),
	FOREIGN KEY (users_Id)		REFERENCES users (Id),
	FOREIGN KEY (projects_Id)	REFERENCES 	projects (Id)
)

ALTER TABLE users
ALTER COLUMN username varchar(10)

ALTER TABLE users
ALTER COLUMN passwords varchar(8)


--inserindo na tb users

INSERT INTO users (nome, username, passwords, email) values
('Maria', 'Rh_maria', '123mudar', 'maria@empresa.com')

--dárá erro, pois o password padrao está incorreto
INSERT INTO users (nome, username, passwords, email) values
('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com')

INSERT INTO users (nome, username, passwords, email) values
('Ana', 'Rh_ana', '123mudar', 'ana@empresa.com')

INSERT INTO users (nome, username, passwords, email) values
('Clara', 'Ti_clara', '123mudar', 'clara@empresa.com')

--dárá erro, pois o password padrao está incorreto
INSERT INTO users (nome, username, passwords, email) values
('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')

INSERT INTO users (nome, username, passwords, email) values
('Joao', 'Ti_joao', '123mudar', 'joao@empresa.com')


--inserindo projects
INSERT INTO projects (nome, descricao, data_Proj) values
('Re-folha', 'Refatoração das Folhas', '2014-09-05')

INSERT INTO projects (nome, descricao, data_Proj) values
('Manutenção PC´s', 'Manutenção PC´s', '2014-09-06')

INSERT INTO projects (nome, descricao, data_Proj) values
('Auditoria', '', '2014-09-07')

INSERT INTO projects (nome, descricao, data_Proj) values
('Atualizacao de Sistemas', 'Modificação de Sistemas Operacionais nos PC', '2014-09-12')

--inserindo na tb users_has_projects

INSERT INTO users_has_projects (users_Id, projects_Id) values
(1, 10001)

INSERT INTO users_has_projects (users_Id, projects_Id) values
(5, 10001)

INSERT INTO users_has_projects (users_Id, projects_Id) values
(3, 10003)

INSERT INTO users_has_projects (users_Id, projects_Id) values
(4, 10002)

INSERT INTO users_has_projects (users_Id, projects_Id) values
(2, 10002)

select us.Id,
	   us.nome,
	   us.email,
	   pro.descricao,
	   pro.data_Proj
from projects pro  left outer join users us
on us.Id = pro.Id
where pro.nome = 'Re-folha'

SELECT pro.id, us.Id
FROM projects pro LEFT OUTER JOIN users us
ON pro.id = us.Id
WHERE us.Id IS NULL

SELECT us.Id, pro.id
FROM  users us LEFT OUTER JOIN  projects pro
ON us.Id = pro.id
WHERE pro.Id IS NUll