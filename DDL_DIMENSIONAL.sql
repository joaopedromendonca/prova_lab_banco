-- Gerado por Oracle SQL Developer Data Modeler 21.4.2.059.0838
--   em:        2022-04-07 23:35:06 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE "DM Cliente" (
    id_cliente INTEGER NOT NULL,
    nome       VARCHAR2(50) NOT NULL,
    estado     VARCHAR2(2) NOT NULL,
    sexo       CHAR(1) NOT NULL,
    classe     VARCHAR2(50) NOT NULL
)
LOGGING;

ALTER TABLE "DM Cliente" ADD CONSTRAINT "DM - Cliente_PK" PRIMARY KEY ( id_cliente );

CREATE TABLE "DM Produto" (
    id_produto INTEGER NOT NULL,
    nome       VARCHAR2(50) NOT NULL,
    classe     CHAR(1) NOT NULL
)
LOGGING;

ALTER TABLE "DM Produto" ADD CONSTRAINT "DM - Produto_PK" PRIMARY KEY ( id_produto );

CREATE TABLE "DM Tempo" (
    id_tempo  INTEGER NOT NULL,
    ano       VARCHAR2(4) NOT NULL,
    trimestre CHAR(1) NOT NULL,
    mês       VARCHAR2(2) NOT NULL,
    dia       VARCHAR2(2) NOT NULL
)
LOGGING;

CREATE UNIQUE INDEX autoincrement ON
    "DM Tempo" (
        id_tempo
    ASC )
        LOGGING;

ALTER TABLE "DM Tempo" ADD CONSTRAINT "DM - Tempo_PK" PRIMARY KEY ( id_tempo );

CREATE TABLE "DM Vendedor" (
    id_vendedor INTEGER NOT NULL,
    nome        VARCHAR2(50) NOT NULL,
    nível       CHAR(1) NOT NULL
)
LOGGING;

ALTER TABLE "DM Vendedor" ADD CONSTRAINT "DM - Vendedor_PK" PRIMARY KEY ( id_vendedor );

CREATE TABLE "TF Vendas" (
    id_venda             INTEGER NOT NULL,
    id_tempo             INTEGER NOT NULL,
    id_cliente           INTEGER NOT NULL,
    id_produto           INTEGER NOT NULL,
    id_vendedor          INTEGER NOT NULL,
    valor_produto        NUMBER(2, 10) NOT NULL,
    valor_total_venda    NUMBER(2, 10) NOT NULL,
    desconto_total_venda NUMBER(2, 10) NOT NULL,
    qtde_vendas          INTEGER NOT NULL
)
LOGGING;

ALTER TABLE "TF Vendas"
    ADD CONSTRAINT "TF - Vendas_PK" PRIMARY KEY ( id_venda,
                                                  id_tempo,
                                                  id_cliente,
                                                  id_produto,
                                                  id_vendedor );

ALTER TABLE "TF Vendas"
    ADD CONSTRAINT "TF - Vendas_DM - Cliente_FK" FOREIGN KEY ( id_cliente )
        REFERENCES "DM Cliente" ( id_cliente )
    NOT DEFERRABLE;

ALTER TABLE "TF Vendas"
    ADD CONSTRAINT "TF - Vendas_DM - Produto_FK" FOREIGN KEY ( id_produto )
        REFERENCES "DM Produto" ( id_produto )
    NOT DEFERRABLE;

ALTER TABLE "TF Vendas"
    ADD CONSTRAINT "TF - Vendas_DM - Tempo_FK" FOREIGN KEY ( id_tempo )
        REFERENCES "DM Tempo" ( id_tempo )
    NOT DEFERRABLE;

ALTER TABLE "TF Vendas"
    ADD CONSTRAINT "TF - Vendas_DM - Vendedor_FK" FOREIGN KEY ( id_vendedor )
        REFERENCES "DM Vendedor" ( id_vendedor )
    NOT DEFERRABLE;



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             5
-- CREATE INDEX                             1
-- ALTER TABLE                              9
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
