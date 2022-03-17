create database startups;
use startups;
create table Startup (
id_startup int not null,
nome_startup varchar(20),
cidade_sede varchar(15),
primary key(id_startup)
);

create table Linguagem_programação(
id_linguagem int not null,
nome_linguagem varchar(15),
ano_lançamento char(4),
primary key(id_linguagem)
);

create table Programador(
id_programador int not null,
id_startup int,
nome_programador varchar(20),
gênero char(1),
data_nascimento date not null,
email varchar(30) unique not null,
primary key(id_programador)
);

create table Programador_Linguagem(
id_programador int not null,
id_linguagem int not null, 
primary key(id_programador, id_linguagem)
);

insert into startup values
('10001', 'Tech4Toy', 'Porto Alegre'),
('10002', 'Smart123', 'Belo Horizonte'),
('10003', 'knowledgeUp', 'Rio de Janeiro'),
('10004', 'BSI Next Level', 'Recife'),
('10005', 'QualiHealth', 'São Paulo'),
('10006', 'ProEdu', 'Florianópolis');

insert into linguagem_programação values
('20001', 'Python', '1991'),
('20002', 'PHP', '1995'),
('20003', 'Java', '1995'),
('20004', 'C', '1972'),
('20005', 'JavaScript', '1995'),
('20006', 'Dart', '2011');

insert into programador values
('30001', '10001', 'João Pedro', 'M', '1993-06-23', 'joaop@mail.com'),
('30002', '10002', 'Paula Silva', 'F', '1986-01-10', 'paulas@mail.com'),
('30003', '10003', 'Renata Vieira', 'F', '1991-07-05', 'renatav@mail.com'),
('30004', '10004', 'Felipe Santos', 'M', '1976-11-25', 'felipes@mail.com'),
('30005', '10001', 'Ana Cristina', 'F', '1968-02-19', 'anac@mail.com'),
('30006', '10004', 'Alexandre Alves', 'M', '1988-07-07', 'alexandrea@mail.com'),
('30007', '10002', 'Laura Marques', 'F', '1987-10-04', 'lauram@mail.com');

insert into programador_linguagem values
('30001', '20001'),
('30001', '20002'),
('30002', '20003'),
('30003', '20004'),
('30003', '20005'),
('30004', '20005'),
('30007', '20001'),
('30007', '20002');

alter table programador add constraint fk_id_da_startup foreign key(id_startup) references startup(id_startup) on update cascade;
alter table programador_linguagem add constraint fk_id_do_programador foreign key(id_programador) references programador(id_programador) on delete cascade;
alter table programador_linguagem add foreign key(id_linguagem) references linguagem_programação(id_linguagem);


