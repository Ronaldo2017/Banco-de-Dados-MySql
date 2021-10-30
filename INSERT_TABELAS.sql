USE MERCADO;

INSERT INTO CLIENTE (ID_CLI, NOME_CLI, ENDERECO_CLI, CIDADE_CLI, CEP_CLI, UF_CLI, RG_CLI)
			VALUES     (01, 'RONALDO', 'XXX', 'YYY', '86989', 'PR', '869583');
            
INSERT INTO CLIENTE (ID_CLI, NOME_CLI, ENDERECO_CLI, CIDADE_CLI, CEP_CLI, UF_CLI, RG_CLI)
			VALUES     (02, 'LARI', 'XXX', 'YYY', '132154', 'PR', '6486764');
 
 INSERT INTO CLIENTE (ID_CLI, NOME_CLI, ENDERECO_CLI, CIDADE_CLI, CEP_CLI, UF_CLI, RG_CLI)
			VALUES     (03, 'SUZY', 'RUA TYTYTYT', 'YYY', '34537', 'PR', '24535');

INSERT INTO CLIENTE (ID_CLI, NOME_CLI, ENDERECO_CLI, CIDADE_CLI, CEP_CLI, UF_CLI, RG_CLI)
			VALUES     (04, 'MARIANA', 'RUA ZZZZ', 'YYY', '456399', 'PR', '3678375');
            
SELECT * FROM CLIENTE;

INSERT INTO VENDEDOR (ID_VEND, NOME_VEND, SALARIO_VEN, COMISSAO_VEND)
			VALUES     (01, 'RONALDO', 2.500, 10.5);
            
INSERT INTO VENDEDOR (ID_VEND, NOME_VEND, SALARIO_VEN, COMISSAO_VEND)
			VALUES     (02, 'LUCIA', 2.200, 5.5);
            
INSERT INTO VENDEDOR (ID_VEND, NOME_VEND, SALARIO_VEN, COMISSAO_VEND)
			VALUES     (03, 'FLAVIA', 2.500, 12.5);
            
            SELECT * FROM VENDEDOR;
            
            
INSERT INTO PRODUTO(ID_PRODUTO, UNIDADE, DESCRICAO, VAL_UNIT)
		VALUES(01, 10, 'MOUSE SEM FIO', 25.25);
        
INSERT INTO PRODUTO(ID_PRODUTO, UNIDADE, DESCRICAO, VAL_UNIT)
		VALUES(02, 6, 'CELULAR LG', 750.00);
        
INSERT INTO PRODUTO(ID_PRODUTO, UNIDADE, DESCRICAO, VAL_UNIT)
		VALUES(03, 10, 'TABLET LG', 250.50);
        
INSERT INTO PRODUTO(ID_PRODUTO, UNIDADE, DESCRICAO, VAL_UNIT)
		VALUES(04, 10, 'MONITOR 24"', 450.00);
        
INSERT INTO PRODUTO(ID_PRODUTO, UNIDADE, DESCRICAO, VAL_UNIT)
		VALUES(05, 7, 'TELA 29"', 350.65);
            
SELECT * FROM PRODUTO;

INSERT INTO PEDIDO(NUM_PEDIDO, ID_CLI, ID_VEND, PRAZO_ENTREGA)
VALUES(1, 1, 1, '2021-03-02');

INSERT INTO PEDIDO(NUM_PEDIDO, ID_CLI, ID_VEND, PRAZO_ENTREGA)
VALUES(2, 2, 1, '2021-03-07');

INSERT INTO PEDIDO(NUM_PEDIDO, ID_CLI, ID_VEND, PRAZO_ENTREGA)
VALUES(3, 3, 3, '2021-05-02');
SELECT * FROM PEDIDO;


INSERT INTO itens_pedido(ID_ITEM_PEDIDO, NUM_PEDIDO, ID_PRODUTO, QUANTIDADE)
VALUES(1, 1, 1, 3);

INSERT INTO itens_pedido(ID_ITEM_PEDIDO, NUM_PEDIDO, ID_PRODUTO, QUANTIDADE)
VALUES(2, 2, 3, 2);

INSERT INTO itens_pedido(ID_ITEM_PEDIDO, NUM_PEDIDO, ID_PRODUTO, QUANTIDADE)
VALUES(3, 3, 3, 1);

SELECT * FROM itens_pedido;

select * from cliente;

/* DELETANDO DADOS*/
delete from cliente where ID_CLI = 4;

/**
	CONSULTAS COM SELECT
*/
SELECT NOME_CLI, CIDADE_CLI from CLIENTE;

SELECT * FROM VENDEDOR order by NOME_VEND DESC;

SELECT * FROM PRODUTO;

SELECT DESCRICAO FROM PRODUTO WHERE ID_PRODUTO = 2;

/*CLAUSULA BETWEEN = ENTRE*/

SELECT * FROM PEDIDO WHERE PRAZO_ENTREGA BETWEEN '2021-03-01' AND '2021-05-02';

/*OPERADOR LIKE*/
SELECT * FROM CLIENTE WHERE NOME_CLI LIKE '%R%';


/*CONSULTA DE MAIS DE UMA TABELA*/

SELECT * FROM itens_pedido;
SELECT * FROM PRODUTO;

SELECT ITENS_PEDIDO.NUM_PEDIDO, itens_pedido.ID_PRODUTO, produto.DESCRICAO
FROM itens_pedido, produto
WHERE itens_pedido.NUM_PEDIDO = 1 AND itens_pedido.ID_ITEM_PEDIDO = produto.ID_PRODUTO;


/* join */
select itens_pedido.NUM_PEDIDO, itens_pedido.ID_PRODUTO, produto.DESCRICAO
from itens_pedido join produto on itens_pedido.ID_PRODUTO = produto.ID_PRODUTO;

/*left join*/
select * from cliente left join pedido on cliente.ID_CLI = pedido.ID_CLI;

/*FUNÇÕES*/
SELECT MIN(VAL_UNIT) AS 'MINIMO VALOR PRODUTO' FROM PRODUTO;

SELECT MAX(VAL_UNIT) AS 'MÁXIMO VALOR PRODUTO' FROM PRODUTO;

SELECT COUNT(*) AS 'CONTA O VALOR' FROM PRODUTO;

SELECT SUM(VAL_UNIT) AS 'SOMA DO VALOR' FROM PRODUTO;

SELECT avg(VAL_UNIT) AS 'MÉDIA DO VALOR' FROM PRODUTO;

/*GROUP BY*/

SELECT ID_CLI, COUNT(*) AS 'NÚMERO DE PEDIDOS' FROM PEDIDO group by ID_CLI;

/*HAVING = FILTRA O CAMPO = WHERE*/
SELECT * FROM PRODUTO;

UPDATE  produto SET UNIDADE = 'PC' WHERE ID_PRODUTO < 3;

SELECT UNIDADE, count(*) AS 'QTD PRODUTO'
FROM PRODUTO group by UNIDADE having UNIDADE = 'UN';


USE MERCADO;
/*VIEWS - TABELA VIRTUAL CUJOS CONTEÚDOS SÃO DEFINIDOS POR UMA CONSULTA
NÃO EXISTE FISICAMENTE NO BD
*/
CREATE VIEW TODOS_CLIENTES AS
SELECT CLIENTE.ID_CLI, CLIENTE.NOME_CLI FROM CLIENTE;

SELECT * FROM TODOS_CLIENTES;

SELECT * FROM V_PEDIDOS;

create view V_PEDIDOS AS 
SELECT ITENS_PEDIDO.NUM_PEDIDO, itens_pedido.ID_PRODUTO, produto.DESCRICAO
FROM itens_pedido, produto
WHERE itens_pedido.NUM_PEDIDO = 1 AND itens_pedido.ID_ITEM_PEDIDO = produto.ID_PRODUTO;

/* STORED PROCEDURES*/
DELIMITER $$
create procedure PRC_INSERIR_VENDEDOR(
	in ID_VEND int,
	in NOME_VEND VARCHAR(40),
    in SALARIO_VEN float,
    in COMISSAO_VEND int
)
begin
	INSERT INTO VENDEDOR(ID_VEND, NOME_VEND, SALARIO_VEN, COMISSAO_VEND)
    valueS(ID_VEND, NOME_VEND, SALARIO_VEN, COMISSAO_VEND);
END
$$

SELECT * FROM  VENDEDOR;
/*INSERINDO DADOS NA STORED PROCEDORE*/
CALL PRC_INSERIR_VENDEDOR(04, 'ANA JULIA', 3500, 20);
CALL PRC_INSERIR_VENDEDOR(05, 'ANA', 3500, 20);

DELIMITER $$
	CREATE procedure BUSCA_VENDEDOR(IN ID INT)
    BEGIN
		SELECT * FROM VENDEDOR WHERE ID_VEND = ID;
	END
$$

/*CHAMANDO O PROCEDIMENTO*/
call BUSCA_VENDEDOR(2);

/*EXCLUIR VENDEDOR*/
DELIMITER $$
	CREATE PROCEDURE EXCLUIR_VENDEDOR(IN ID INT)
    BEGIN
		DELETE FROM VENDEDOR
        WHERE ID_VEND = ID;
	END
$$

SELECT * FROM VENDEDOR;
CALL EXCLUIR_VENDEDOR(4);

/*ATUALIZA VENDEDOR*/
DELIMITER $$
	CREATE procedure ATUALIZA_VENDEDOR(IN ID_VEND INT, IN NOME_VEND VARCHAR(40),
    IN SALARIO_VEN FLOAT, IN COMISSAO_VEND INT)
    BEGIN
		UPDATE VENDEDOR SET ID_VEND = ID_VEND, NOME_VEND = NOME_VEND,
        SALARIO_VEN = SALARIO_VEN, COMISSAO_VEND = COMISSAO_VEND
        WHERE ID_VEND = ID_VEND;
	END
$$

SELECT * FROM VENDEDOR;

CALL ATUALIZA_VENDEDOR(1, 'RONALDO', 5000, 35);





            