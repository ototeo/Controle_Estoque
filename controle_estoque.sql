/* Gerando nome de constraints
 * nomeTabelaRecebeConstraint_campoTabelaConstraint_nomeTabelaReferencia_campoTabelaReferencia
 */

DROP DATABASE IF EXISTS controle_estoque;
CREATE DATABASE controle_estoque DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_bin;
CREATE TABLE controle_estoque.categoria
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(95),
	created_at TIMESTAMP DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
) DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_bin;
CREATE TABLE controle_estoque.cliente
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(95),
	cpfcnpj VARCHAR(95),
	rgie VARCHAR(95),
	rsocial VARCHAR(95),
	tipo INT,
	cep VARCHAR(20),
	endereco VARCHAR(95),
	bairro VARCHAR(95),
	fone VARCHAR(14),
	cel VARCHAR(15),
	email VARCHAR(95),
	endnumero VARCHAR(10),
	cidade VARCHAR(95),
	estado VARCHAR(95),
	created_at TIMESTAMP DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
) DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_bin;
CREATE TABLE controle_estoque.fornecedor
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(95),
	rsocial VARCHAR(95),
	ie VARCHAR(95),
	cnpj VARCHAR(95),
	cep VARCHAR(95),
	endereco VARCHAR(95),
	bairro VARCHAR(95),
	fone VARCHAR(14),
	cel VARCHAR(15),
	email VARCHAR(95),
	endnumero VARCHAR(95),
	cidade VARCHAR(95),
	estado VARCHAR(95),
	created_at TIMESTAMP DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
) DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_bin;
CREATE TABLE controle_estoque.tipo_pagamento
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(90),
	created_at TIMESTAMP DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
) DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_bin;
CREATE TABLE controle_estoque.und_medida
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(95),
	created_at TIMESTAMP DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
) DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_bin;
CREATE TABLE controle_estoque.compra
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	data DATETIME,
	nfiscal INT,
	total DECIMAL(10,2),
	nparcelas INT,
	status INT,
	fornecedor_id INT,
	tipo_pagamento_id INT,
	CONSTRAINT compra_fornecedorId_fornecedor_id FOREIGN KEY (fornecedor_id) REFERENCES controle_estoque.fornecedor (id),
	CONSTRAINT compra_tipoPagamentoId_tipoPagamento_id FOREIGN KEY (tipo_pagamento_id) REFERENCES controle_estoque.tipo_pagamento (id),
	created_at TIMESTAMP DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
) DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_bin;
CREATE TABLE controle_estoque.parcelas_compra
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	valor DECIMAL(10,2),
	datapagto DATE,
	datavecto DATE,
	compra_id INT,
	CONSTRAINT parcelasCompra_compraId_compra_id FOREIGN KEY (compra_id) REFERENCES controle_estoque.compra (id),
	created_at TIMESTAMP DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
) DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_bin;
CREATE TABLE controle_estoque.sub_categoria
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(95),
	categoria_id INT,
	CONSTRAINT subCategoria_categoriaId_categoria_id FOREIGN KEY (categoria_id) REFERENCES controle_estoque.categoria (id),
	created_at TIMESTAMP DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
) DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_bin;
CREATE TABLE controle_estoque.produto
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(95),
	descricao TEXT,
	caminho_foto TEXT,
	valorpago DECIMAL(10,2),
	valorvenda DECIMAL(10,2),
	qtde DOUBLE,
	undmedida_id INT,
	categoria_id INT,
	subcategoria_id INT,
	CONSTRAINT produto_undmedidaId_undMedida_id FOREIGN KEY (undmedida_id) REFERENCES controle_estoque.und_medida (id),
	CONSTRAINT produto_categoriaId_categoria_id FOREIGN KEY (categoria_id) REFERENCES controle_estoque.categoria (id),
	CONSTRAINT produto_subcategoriaId_subCategoria_id FOREIGN KEY (subcategoria_id) REFERENCES controle_estoque.sub_categoria (id),
	created_at TIMESTAMP DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
) DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_bin;
CREATE TABLE controle_estoque.itens_compra
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	qtde DOUBLE,
	valor DECIMAL(10,2),
	compra_id INT,
	produto_id INT,
	CONSTRAINT itensCompra_compraId_compra_id FOREIGN KEY (compra_id) REFERENCES controle_estoque.compra (id),
	CONSTRAINT itensCompra_produtoId_produto_id FOREIGN KEY (produto_id) REFERENCES controle_estoque.produto (id),
	created_at TIMESTAMP DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
) DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_bin;
CREATE TABLE controle_estoque.venda
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	data DATETIME,
	nfiscal INT,
	total DECIMAL(10,2),
	nparcelas INT,
	status INT,
	cliente_id INT,
	tipopagamento_id INT,
	CONSTRAINT venda_clienteId_cliente_id FOREIGN KEY (cliente_id) REFERENCES controle_estoque.cliente (id),
	CONSTRAINT venda_tipopagamentoId_tipoPagamento_id FOREIGN KEY (tipopagamento_id) REFERENCES controle_estoque.tipo_pagamento (id),
	created_at TIMESTAMP DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
) DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_bin;
CREATE TABLE controle_estoque.itens_venda
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	qtde DOUBLE,
	valor DECIMAL(10,2),
	venda_id INT,
	produto_id INT,
	CONSTRAINT itensVenda_vendaId_venda_id FOREIGN KEY (venda_id) REFERENCES controle_estoque.venda (id),
	CONSTRAINT itensVenda_produtoId_produto_id FOREIGN KEY (produto_id) REFERENCES controle_estoque.produto (id),
	created_at TIMESTAMP DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
) DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_bin;
CREATE TABLE controle_estoque.parcelas_venda
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	valor DECIMAL(10,2),
	datapagto DATE,
	datavecto DATE,
	venda_id INT,
	CONSTRAINT parcelasVenda_vendaId_venda_id FOREIGN KEY (venda_id) REFERENCES controle_estoque.venda (id),
	created_at TIMESTAMP DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
) DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_bin;