CREATE TABLE IF NOT EXISTS loja.pedidos_com_cliente (
    cliente_id int,
    nome text STATIC,
    data date,
    pedido_id int,
    total decimal,
    PRIMARY KEY ((cliente_id), data, pedido_id)
) WITH CLUSTERING ORDER BY (data DESC, pedido_id DESC);

SELECT * FROM pedidos_com_cliente;

INSERT INTO loja.pedidos_com_cliente (cliente_id, data, pedido_id, nome, total) VALUES (42, '2026-10-07', 20, 'Ana Lima', 100);
INSERT INTO loja.pedidos_com_cliente (cliente_id, data, pedido_id, nome, total) VALUES (40, '2026-10-05', 20, 'Andre', 200);

SELECT * FROM loja.pedidos_com_cliente WHERE cliente_id = 42;

SELECT * FROM loja.pedidos_com_cliente WHERE nome = 'Andre' ALLOW FILTERING;

CREATE TABLE IF NOT EXISTS loja.cliente (
    cliente_id int,
    nome_cliente text STATIC,
    PRIMARY KEY ((cliente_id))
) WITH CLUSTERING ORDER BY (cliente_id);

-- Tabela criado igual pq a sintaxe do outro exemplo tá com algum erro
CREATE TABLE IF NOT EXISTS loja.cliente (
    cliente_id int,
    nome text STATIC,
    data date,
    pedido_id int,
    total decimal,
    PRIMARY KEY ((cliente_id), data, pedido_id)
) WITH CLUSTERING ORDER BY (data DESC, pedido_id DESC);

INSERT INTO loja.cliente (cliente_id, data, pedido_id, nome, total) VALUES (40, '2026-10-05', 20, 'Andre', 200);

-- FALHA: Não tem join no cassandra, tem que desnormalizar os dados
SELECT * FROM loja.cliente JOIN loja.pedidos_com_cliente ON loja.cliente.cliente_id = loja.pedidos_com_cliente.cliente_id

-- https://www.invertexto.com/senac102026