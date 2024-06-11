CREATE DATABASE securityWings;

USE securityWings;

CREATE TABLE Empresa(
    idEmpresa int primary key auto_increment,
    nome varchar(45),
    cnpj char(18) unique,
    telefone char(15)    
);

CREATE TABLE Endereco(
    idEndereco int primary key auto_increment,
    cidade varchar(50),
    bairro varchar(50),
    uf char(2),
    rua varchar(50),
    cep char(9),
    complemento varchar(30),
    fkEmpresa int,
    constraint fk_endereco_empresa foreign key (fkEmpresa) references Empresa(idEmpresa)
);

CREATE TABLE usuario(
    idUsuario int primary key auto_increment,
    nome varchar(45),
    cpf char(14) unique,
    email varchar(255) UNIQUE,
    isAdmin boolean,
    isManager boolean,
    senha varchar(255),
    fkEmpresa int,
    constraint fk_empresa_funcionario foreign key (fkEmpresa) references Empresa(idEmpresa)
);

CREATE TABLE ComputadorESpec(
    idComputador int primary key auto_increment,
    processadorModelo varchar(150),
    processadorNucleosFisicos int,
    processadorNucleosLógicos int,
    processadorFrequencia float,
    discoTotal int,
    ramTotal int,
    fkEmpresa int,
    fkUsuario int,
    constraint fkEmpresa foreign key (fkEmpresa) references Empresa(idEmpresa),
    constraint fkUsuarioComp foreign key(fkUsuario) references usuario(idUsuario)
);

CREATE TABLE Monitoramento(
    idMonitoramento int primary key auto_increment,
    processadorUso Double,
    ramUso int,
    discoUso int,
    bytesEnviados bigint,
    dataCaptura varchar(100),
    fkComputador int,
    constraint fkComputadorMon foreign key (fkComputador) references ComputadorESpec(idComputador)
);

CREATE TABLE parametrosDeAlerta (
    idEmpresa int,
	enviado boolean,
    ramWarning varchar(50),
    ramDanger varchar(50),
    processadorWarning varchar(50),
    processadorDanger varchar(50),
    internetWarning varchar(50),
    internetDanger varchar(50),
    discoWarning varchar(50),
    discoDanger varchar(50),
    PRIMARY KEY (idEmpresa),
    constraint fk_empresa_parametros foreign key(idEmpresa) references Empresa(idEmpresa)
);

CREATE TABLE categoria (
    idCategoria int primary key auto_increment,
    categorias varchar(50)
);

CREATE TABLE processos (
    idProcesso int primary key auto_increment,
    nomeAmigavel varchar(50),
    processoName varchar(50),
    fkCategoria int,
    constraint fk_categoria_processos foreign key (fkCategoria) references categoria(idCategoria)
);

CREATE TABLE permissoes (
    idPermissao INT PRIMARY KEY AUTO_INCREMENT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fkEmpresa INT,
    fkProcesso INT,
    isAllowed BOOLEAN,
    isVisible BOOLEAN,
    CONSTRAINT fk_empresa_permissoes FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    CONSTRAINT fk_processo_permissoes FOREIGN KEY (fkProcesso) REFERENCES processos(idProcesso)
);


-- DAQUI PRA BAIXO É TUDO MOCK PRA TESTAR EM DEV --
INSERT INTO Empresa (nome, cnpj, telefone) VALUES 
    ('Aeroportos Brasil S.A.', '12.345.678/0001-90', '(12) 3456-7890'),
    ('Aviação Express Ltda.', '23.456.789/0001-91', '(23) 4567-8910'),
    ('Jet Airways Inc.', '34.567.890/0001-92', '(34) 5678-9101'),
    ('SkyPort Transportes Aéreos', '45.678.901/0001-93', '(45) 6789-1011'),
    ('WingTech Aviação Ltda.', '56.789.012/0001-94', '(56) 7890-1122'),
    ('Voo Seguro Transportadora Aérea', '67.890.123/0001-95', '(67) 8901-1233'),
    ('AeroBrasil Logística Aeroportuária', '78.901.234/0001-96', '(78) 9012-3454'),
    ('Aerogiro Serviços Aeronáuticos', '89.012.345/0001-97', '(89) 0123-4567'),
    ('AirLink Transportes Aéreos', '90.123.456/0001-98', '(90) 1234-5678'),
    ('SkyHawk Comércio de Aeronaves', '01.234.567/0001-99', '(01) 2345-6789'),
    ('Security Wings', '44.234.567/0001-99', '(01) 2345-6790');
    
    -- NOSSAS CREDÊNCIAS --
INSERT INTO usuario (nome, cpf, email, isAdmin, isManager, senha, fkEmpresa) VALUES 
('Eduardo Melo De Oliveira', '12345678900', 'eduardo@secWings.com', true, true, '123123', 11),
('Fernanda Das Flores Silvino ', '12345678910', 'fernanda@secWings.com', true, true, '123123', 11),
('Kauã Vidal Magalhães', '12345678920', 'kaua@secWings.com', true, true, '123123', 11),
('Luca Sena', '12345678930', 'luca@secWings.com', true, true, '123123', 11),
('Victor Nunes', '12345678940', 'victor@secWings.com', true, true, '123123', 11),
('Gustavo Fernandes', '12345678950', 'gustavo@secWings.com', true, true, '123123', 11);

INSERT INTO categoria VALUES
(1,"navegador"),
(2,"utils"),
(3,"outros");

INSERT INTO processos (nomeAmigavel, processoName, fkCategoria) VALUES 
('Google Chrome', 'chrome', 1),
('Mozilla Firefox', 'firefox', 1),
('Safari', 'safari', 1),
('Microsoft Edge', 'msedge', 1),
('Opera', 'opera', 1);

INSERT INTO processos (nomeAmigavel, processoName, fkCategoria) VALUES 
('Microsoft Word', 'WINWORD', 2),
('Microsoft Excel', 'EXCEL', 2),	
('Discord', 'discord', 2),
('Zoom', 'zoom', 2),
('Slack', 'slack', 2);

INSERT INTO processos (nomeAmigavel, processoName, fkCategoria) VALUES 
('Calculadora', 'calculadora', 3),
('Skype', 'skype', 3),
('VLC Media Player', 'vlc', 3),
('Notepad++', 'notepad++', 3);

select * from permissoes where fkEmpresa =1;

select * from usuario;
select * from monitoramento order by idMonitoramento desc;
SELECT p.*, pr.nomeAmigavel, pr.processoName FROM permissoes p JOIN processos pr ON p.fkProcesso = pr.idProcesso WHERE p.idPermissao IN (SELECT MAX(idPermissao) FROM permissoes WHERE fkEmpresa = 1 GROUP BY fkProcesso) ORDER BY p.created_at DESC;

-- Criação de tabela para jar individual -- 
CREATE TABLE inovacao(
idInovacao INT PRIMARY KEY AUTO_INCREMENT,
ipv4 VARCHAR(250),
mac VARCHAR(250),
fkComputadorESpec INT,
CONSTRAINT fk_ComputadorESpec FOREIGN KEY (fkComputadorESpec) REFERENCES ComputadorESpec(idComputador)
);
select * from inovacao;

SELECT * FROM inovacao 