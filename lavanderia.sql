use lavanderia;

show tables;

CREATE DATABASE lavanderia;

USE lavanderia;

CREATE TABLE cliente(
	id_cliente INT NOT NULL AUTO_INCREMENT,
	nome_cliente VARCHAR(100) NOT NULL,
	cpf_cliente VARCHAR(11) NOT NULL,
	data_nasc_cliente DATE NOT NULL,
	rua_cliente VARCHAR(100) NOT NULL,
    numero_cliente INT NOT NULL,
    bairro_cliente VARCHAR(100) NOT NULL,
    cidade_cliente VARCHAR(100) NOT NULL,
    estado_cliente VARCHAR(2) NOT NULL,
    telefone_cliente VARCHAR(45) NOT NULL,
    email_cliente VARCHAR(45) NOT NULL,
    PRIMARY KEY(id_cliente)
);

CREATE TABLE cargo(
	id_cargo INT NOT NULL AUTO_INCREMENT,
    nome_cargo VARCHAR(45) NOT NULL,
    descricao_cargo VARCHAR(100) NOT NULL,
    PRIMARY KEY(id_cargo)
);

CREATE TABLE operador(
	id_operador INT NOT NULL AUTO_INCREMENT,
    nome_operador VARCHAR(100) NOT NULL,
    cpf_operador VARCHAR(11) NOT NULL,
	matricula_operador VARCHAR(45) NOT NULL,
    telefone_operador VARCHAR(45) NOT NULL,
    email_operador VARCHAR(45) NOT NULL,
    cargo_id INT NOT NULL,
    PRIMARY KEY(id_operador),
    FOREIGN KEY(cargo_id) REFERENCES cargo(id_cargo)
);

CREATE TABLE produto(
	id_produto INT NOT NULL AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    descricao_produto VARCHAR(255) NOT NULL,
    PRIMARY KEY(id_produto)
);

CREATE TABLE pedido(
	id_pedido INT NOT NULL AUTO_INCREMENT,
    quantidade_pecas_pedido INT NOT NULL,
    data_entrada_pedido DATE NOT NULL,
    data_entrega_pedido DATE NOT NULL,
    cliente_id INT NOT NULL,
    operador_id INT NOT NULL,
    PRIMARY KEY(id_pedido),
    FOREIGN KEY(cliente_id) REFERENCES cliente(id_cliente),
    FOREIGN KEY(operador_id) REFERENCES operador(id_operador)
);

CREATE TABLE pedido_produto(
	id_pedido_produto INT NOT NULL AUTO_INCREMENT,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    PRIMARY KEY(id_pedido_produto),
    FOREIGN KEY(pedido_id) REFERENCES pedido(id_pedido),
    FOREIGN KEY(produto_id) REFERENCES produto(id_produto)
);

CREATE TABLE pagamento(
	id_pagamento INT NOT NULL AUTO_INCREMENT,
    tipo_pagamento CHAR(1) NOT NULL,
    data_pagamento DATE NOT NULL,
    pedido_id INT NOT NULL,
    PRIMARY KEY(id_pagamento),
    FOREIGN KEY(pedido_id) REFERENCES pedido(id_pedido)
);

INSERT INTO cargo VALUES (1,'gerente','Responsável pela gestão da loja.'),
(2,'atendente','Responsável pela recepção dos clientes e processamento dos pedidos.'),
(3,'caixa','Responsável pelo recebimento dos pagamentos dos clientes.'),
(4,'operador de máquinas','Responsável por manuseio das máquinas de lavar.'),
(5,'serviços gerais','Responsável pela limpeza da loja.');

INSERT INTO cliente VALUES (1,'Sebastião Guilherme','19791958467','2001-06-19','Rua José Soares de Moura',845,'Parque Capibaribe','São Lourenço da Mata','PE','81995165753','sebastiaoguilhermemonteiro@debiasi.com.br'),
(2,'Lavínia Fernanda','09502899490','1992-05-21','Avenida Ceará',394,'Universitário','Caruaru','PE','81983247252','lavinia_duarte@attglobal.net'),
(3,'Pietro Davi','46218339440','1987-08-22','Rua Gilberto Trajano',724,'Linha do Tiro','Recife','PE','81993663757','pietro.davi.novaes@zulix.com.br'),
(4,'Sebastiana Patrícia','79904789436','1964-09-01','Travessa Lidia Rodrigues Alves',915,'Água fria','Recife','PE','81991455185','sebastianapatriciagomes@pobox.com'),
(5,'Mário Diogo','08121260418','1970-02-08','Rua Egipcio',850,'Alto da Conquista','Olinda','PE','81998626267','mario.diogo.damata@megasurgical.com.br');

INSERT INTO operador VALUES (1,'Alice Liz','81236912462','135773520','81988396030','alice-dias73@virtualcriativa.com.br',2),
(2,'Vitor Luan','72288447427','230916302','81992234417','vitorluanalmada@soespodonto.com.br',3),
(3,'Emily Priscila','46392770402','324081923','81994713402','emily-carvalho77@cognis.com',1),
(4,'Aline Emilly','41001331460','375649529','81996862696','aline.emilly.figueiredo@rodrigofranco.com',4),
(5,'Filipe Henrique','99759433494','389529588','81988139419','filipe-dacosta85@projetochama.com.br',5);

INSERT INTO produto VALUES (1,'Kit 10','Limite de 10 peças.'),
(2,'Kit 20','Limite de 20 peças.'),
(3,'Kit 30','Limite de 30 peças.'),
(4,'Kit 40','Limite de 40 peças.'),
(5,'Kit 50','Limite de 50 peças.');

INSERT INTO pedido VALUES (1,15,'2023-05-24','2023-05-27',2,2),
(2,12,'2024-03-05','2024-03-07',4,2),
(3,31,'2024-10-18','2024-10-27',5,1),
(4,29,'2024-10-28','2024-11-05',3,2),
(5,6,'2024-11-11','2024-11-12',1,1);

INSERT INTO pagamento VALUES (1,'P','2023-05-24',1),
(2,'D','2024-03-07',2),
(3,'D','2024-10-28',3),
(4,'C','2024-10-28',4),
(5,'P','2024-11-11',5);

INSERT INTO pedido_produto VALUES (1,1,2),
(2,2,2),
(3,3,4),
(4,4,3),
(5,5,1);

SELECT * FROM cargo;
SELECT * FROM cliente;
SELECT * FROM operador;
SELECT * FROM pagamento;
SELECT * FROM pedido;
SELECT * FROM pedido_produto;
SELECT * FROM produto;

SELECT c.nome_cliente, c.cpf_cliente, o.nome_operador, cg.nome_cargo, pd.nome_produto, p.quantidade_pecas_pedido, p.data_entrada_pedido, p.data_entrega_pedido, pg.tipo_pagamento, pg.data_pagamento
FROM pedido AS p JOIN cliente AS c
ON c.id_cliente = p.cliente_id
JOIN operador AS o
ON o.id_operador = p.operador_id
JOIN cargo AS cg
ON cg.id_cargo = o.cargo_id
JOIN pagamento AS pg
ON p.id_pedido = pg.pedido_id
JOIN pedido_produto AS pp
ON p.id_pedido = pp.pedido_id
JOIN produto AS pd
ON pd.id_produto = pp.produto_id;

UPDATE pedido SET operador_id = '1' WHERE (id_pedido = '1');
UPDATE pedido SET operador_id = '1' WHERE (id_pedido = '2');
UPDATE pedido SET operador_id = '3' WHERE (id_pedido = '3');
UPDATE pedido SET operador_id = '1' WHERE (id_pedido = '4');
UPDATE pedido SET operador_id = '3' WHERE (id_pedido = '5');

UPDATE operador SET cargo_id = '2' WHERE (id_operador = '5');

DELETE FROM cargo WHERE (id_cargo = '5');