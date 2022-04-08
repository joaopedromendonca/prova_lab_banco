-- Gerado por Oracle SQL Developer Data Modeler 21.4.2.059.0838
--   em:        2022-04-07 23:27:18 BRT
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


CREATE TABLE DM Cliente_JN
 (JN_OPERATION CHAR(3) NOT NULL
 ,JN_ORACLE_USER VARCHAR2(30) NOT NULL
 ,JN_DATETIME DATE NOT NULL
 ,JN_NOTES VARCHAR2(240)
 ,JN_APPLN VARCHAR2(35)
 ,JN_SESSION NUMBER(38)
 ,id_cliente INTEGER NOT NULL
 ,nome VARCHAR2 (50) NOT NULL
 ,estado VARCHAR2 (2) NOT NULL
 ,sexo CHAR (1) NOT NULL
 ,classe VARCHAR2 (50) NOT NULL
 );

CREATE OR REPLACE TRIGGER DM Cliente_JNtrg
  AFTER 
  INSERT OR 
  UPDATE OR 
  DELETE ON DM Cliente for each row 
 Declare 
  rec DM Cliente_JN%ROWTYPE; 
  blank DM Cliente_JN%ROWTYPE; 
  BEGIN 
    rec := blank; 
    IF INSERTING OR UPDATING THEN 
      rec.id_cliente := :NEW.id_cliente; 
      rec.nome := :NEW.nome; 
      rec.estado := :NEW.estado; 
      rec.sexo := :NEW.sexo; 
      rec.classe := :NEW.classe; 
      rec.JN_DATETIME := SYSDATE; 
      rec.JN_ORACLE_USER := SYS_CONTEXT ('USERENV', 'SESSION_USER'); 
      rec.JN_APPLN := SYS_CONTEXT ('USERENV', 'MODULE'); 
      rec.JN_SESSION := SYS_CONTEXT ('USERENV', 'SESSIONID'); 
      IF INSERTING THEN 
        rec.JN_OPERATION := 'INS'; 
      ELSIF UPDATING THEN 
        rec.JN_OPERATION := 'UPD'; 
      END IF; 
    ELSIF DELETING THEN 
      rec.id_cliente := :OLD.id_cliente; 
      rec.nome := :OLD.nome; 
      rec.estado := :OLD.estado; 
      rec.sexo := :OLD.sexo; 
      rec.classe := :OLD.classe; 
      rec.JN_DATETIME := SYSDATE; 
      rec.JN_ORACLE_USER := SYS_CONTEXT ('USERENV', 'SESSION_USER'); 
      rec.JN_APPLN := SYS_CONTEXT ('USERENV', 'MODULE'); 
      rec.JN_SESSION := SYS_CONTEXT ('USERENV', 'SESSIONID'); 
      rec.JN_OPERATION := 'DEL'; 
    END IF; 
    INSERT into DM Cliente_JN VALUES rec; 
  END; 
  /CREATE TABLE "DM Produto" (
    id_produto INTEGER NOT NULL,
    nome       VARCHAR2(50) NOT NULL,
    classe     CHAR(1) NOT NULL
)
LOGGING;

ALTER TABLE "DM Produto" ADD CONSTRAINT "DM - Produto_PK" PRIMARY KEY ( id_produto );


CREATE TABLE DM Produto_JN
 (JN_OPERATION CHAR(3) NOT NULL
 ,JN_ORACLE_USER VARCHAR2(30) NOT NULL
 ,JN_DATETIME DATE NOT NULL
 ,JN_NOTES VARCHAR2(240)
 ,JN_APPLN VARCHAR2(35)
 ,JN_SESSION NUMBER(38)
 ,id_produto INTEGER NOT NULL
 ,nome VARCHAR2 (50) NOT NULL
 ,classe CHAR (1) NOT NULL
 );

CREATE OR REPLACE TRIGGER DM Produto_JNtrg
  AFTER 
  INSERT OR 
  UPDATE OR 
  DELETE ON DM Produto for each row 
 Declare 
  rec DM Produto_JN%ROWTYPE; 
  blank DM Produto_JN%ROWTYPE; 
  BEGIN 
    rec := blank; 
    IF INSERTING OR UPDATING THEN 
      rec.id_produto := :NEW.id_produto; 
      rec.nome := :NEW.nome; 
      rec.classe := :NEW.classe; 
      rec.JN_DATETIME := SYSDATE; 
      rec.JN_ORACLE_USER := SYS_CONTEXT ('USERENV', 'SESSION_USER'); 
      rec.JN_APPLN := SYS_CONTEXT ('USERENV', 'MODULE'); 
      rec.JN_SESSION := SYS_CONTEXT ('USERENV', 'SESSIONID'); 
      IF INSERTING THEN 
        rec.JN_OPERATION := 'INS'; 
      ELSIF UPDATING THEN 
        rec.JN_OPERATION := 'UPD'; 
      END IF; 
    ELSIF DELETING THEN 
      rec.id_produto := :OLD.id_produto; 
      rec.nome := :OLD.nome; 
      rec.classe := :OLD.classe; 
      rec.JN_DATETIME := SYSDATE; 
      rec.JN_ORACLE_USER := SYS_CONTEXT ('USERENV', 'SESSION_USER'); 
      rec.JN_APPLN := SYS_CONTEXT ('USERENV', 'MODULE'); 
      rec.JN_SESSION := SYS_CONTEXT ('USERENV', 'SESSIONID'); 
      rec.JN_OPERATION := 'DEL'; 
    END IF; 
    INSERT into DM Produto_JN VALUES rec; 
  END; 
  /CREATE TABLE "DM Tempo" (
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


CREATE TABLE DM Tempo_JN
 (JN_OPERATION CHAR(3) NOT NULL
 ,JN_ORACLE_USER VARCHAR2(30) NOT NULL
 ,JN_DATETIME DATE NOT NULL
 ,JN_NOTES VARCHAR2(240)
 ,JN_APPLN VARCHAR2(35)
 ,JN_SESSION NUMBER(38)
 ,id_tempo INTEGER NOT NULL
 ,ano VARCHAR2 (4) NOT NULL
 ,trimestre CHAR (1) NOT NULL
 ,mês VARCHAR2 (2) NOT NULL
 ,dia VARCHAR2 (2) NOT NULL
 );

CREATE OR REPLACE TRIGGER DM Tempo_JNtrg
  AFTER 
  INSERT OR 
  UPDATE OR 
  DELETE ON DM Tempo for each row 
 Declare 
  rec DM Tempo_JN%ROWTYPE; 
  blank DM Tempo_JN%ROWTYPE; 
  BEGIN 
    rec := blank; 
    IF INSERTING OR UPDATING THEN 
      rec.id_tempo := :NEW.id_tempo; 
      rec.ano := :NEW.ano; 
      rec.trimestre := :NEW.trimestre; 
      rec.mês := :NEW.mês; 
      rec.dia := :NEW.dia; 
      rec.JN_DATETIME := SYSDATE; 
      rec.JN_ORACLE_USER := SYS_CONTEXT ('USERENV', 'SESSION_USER'); 
      rec.JN_APPLN := SYS_CONTEXT ('USERENV', 'MODULE'); 
      rec.JN_SESSION := SYS_CONTEXT ('USERENV', 'SESSIONID'); 
      IF INSERTING THEN 
        rec.JN_OPERATION := 'INS'; 
      ELSIF UPDATING THEN 
        rec.JN_OPERATION := 'UPD'; 
      END IF; 
    ELSIF DELETING THEN 
      rec.id_tempo := :OLD.id_tempo; 
      rec.ano := :OLD.ano; 
      rec.trimestre := :OLD.trimestre; 
      rec.mês := :OLD.mês; 
      rec.dia := :OLD.dia; 
      rec.JN_DATETIME := SYSDATE; 
      rec.JN_ORACLE_USER := SYS_CONTEXT ('USERENV', 'SESSION_USER'); 
      rec.JN_APPLN := SYS_CONTEXT ('USERENV', 'MODULE'); 
      rec.JN_SESSION := SYS_CONTEXT ('USERENV', 'SESSIONID'); 
      rec.JN_OPERATION := 'DEL'; 
    END IF; 
    INSERT into DM Tempo_JN VALUES rec; 
  END; 
  /CREATE TABLE "DM Vendedor" (
    id_vendedor INTEGER NOT NULL,
    nome        VARCHAR2(50) NOT NULL,
    nível       CHAR(1) NOT NULL
)
LOGGING;

ALTER TABLE "DM Vendedor" ADD CONSTRAINT "DM - Vendedor_PK" PRIMARY KEY ( id_vendedor );


CREATE TABLE DM Vendedor_JN
 (JN_OPERATION CHAR(3) NOT NULL
 ,JN_ORACLE_USER VARCHAR2(30) NOT NULL
 ,JN_DATETIME DATE NOT NULL
 ,JN_NOTES VARCHAR2(240)
 ,JN_APPLN VARCHAR2(35)
 ,JN_SESSION NUMBER(38)
 ,id_vendedor INTEGER NOT NULL
 ,nome VARCHAR2 (50) NOT NULL
 ,nível CHAR (1) NOT NULL
 );

CREATE OR REPLACE TRIGGER DM Vendedor_JNtrg
  AFTER 
  INSERT OR 
  UPDATE OR 
  DELETE ON DM Vendedor for each row 
 Declare 
  rec DM Vendedor_JN%ROWTYPE; 
  blank DM Vendedor_JN%ROWTYPE; 
  BEGIN 
    rec := blank; 
    IF INSERTING OR UPDATING THEN 
      rec.id_vendedor := :NEW.id_vendedor; 
      rec.nome := :NEW.nome; 
      rec.nível := :NEW.nível; 
      rec.JN_DATETIME := SYSDATE; 
      rec.JN_ORACLE_USER := SYS_CONTEXT ('USERENV', 'SESSION_USER'); 
      rec.JN_APPLN := SYS_CONTEXT ('USERENV', 'MODULE'); 
      rec.JN_SESSION := SYS_CONTEXT ('USERENV', 'SESSIONID'); 
      IF INSERTING THEN 
        rec.JN_OPERATION := 'INS'; 
      ELSIF UPDATING THEN 
        rec.JN_OPERATION := 'UPD'; 
      END IF; 
    ELSIF DELETING THEN 
      rec.id_vendedor := :OLD.id_vendedor; 
      rec.nome := :OLD.nome; 
      rec.nível := :OLD.nível; 
      rec.JN_DATETIME := SYSDATE; 
      rec.JN_ORACLE_USER := SYS_CONTEXT ('USERENV', 'SESSION_USER'); 
      rec.JN_APPLN := SYS_CONTEXT ('USERENV', 'MODULE'); 
      rec.JN_SESSION := SYS_CONTEXT ('USERENV', 'SESSIONID'); 
      rec.JN_OPERATION := 'DEL'; 
    END IF; 
    INSERT into DM Vendedor_JN VALUES rec; 
  END; 
  /CREATE TABLE "TF Vendas" (
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


CREATE TABLE TF Vendas_JN
 (JN_OPERATION CHAR(3) NOT NULL
 ,JN_ORACLE_USER VARCHAR2(30) NOT NULL
 ,JN_DATETIME DATE NOT NULL
 ,JN_NOTES VARCHAR2(240)
 ,JN_APPLN VARCHAR2(35)
 ,JN_SESSION NUMBER(38)
 ,id_venda INTEGER NOT NULL
 ,id_tempo INTEGER NOT NULL
 ,id_cliente INTEGER NOT NULL
 ,id_produto INTEGER NOT NULL
 ,id_vendedor INTEGER NOT NULL
 ,valor_produto NUMBER (2,10) NOT NULL
 ,valor_total_venda NUMBER (2,10) NOT NULL
 ,desconto_total_venda NUMBER (2,10) NOT NULL
 ,qtde_vendas INTEGER NOT NULL
 );

CREATE OR REPLACE TRIGGER TF Vendas_JNtrg
  AFTER 
  INSERT OR 
  UPDATE OR 
  DELETE ON TF Vendas for each row 
 Declare 
  rec TF Vendas_JN%ROWTYPE; 
  blank TF Vendas_JN%ROWTYPE; 
  BEGIN 
    rec := blank; 
    IF INSERTING OR UPDATING THEN 
      rec.id_venda := :NEW.id_venda; 
      rec.id_tempo := :NEW.id_tempo; 
      rec.id_cliente := :NEW.id_cliente; 
      rec.id_produto := :NEW.id_produto; 
      rec.id_vendedor := :NEW.id_vendedor; 
      rec.valor_produto := :NEW.valor_produto; 
      rec.valor_total_venda := :NEW.valor_total_venda; 
      rec.desconto_total_venda := :NEW.desconto_total_venda; 
      rec.qtde_vendas := :NEW.qtde_vendas; 
      rec.JN_DATETIME := SYSDATE; 
      rec.JN_ORACLE_USER := SYS_CONTEXT ('USERENV', 'SESSION_USER'); 
      rec.JN_APPLN := SYS_CONTEXT ('USERENV', 'MODULE'); 
      rec.JN_SESSION := SYS_CONTEXT ('USERENV', 'SESSIONID'); 
      IF INSERTING THEN 
        rec.JN_OPERATION := 'INS'; 
      ELSIF UPDATING THEN 
        rec.JN_OPERATION := 'UPD'; 
      END IF; 
    ELSIF DELETING THEN 
      rec.id_venda := :OLD.id_venda; 
      rec.id_tempo := :OLD.id_tempo; 
      rec.id_cliente := :OLD.id_cliente; 
      rec.id_produto := :OLD.id_produto; 
      rec.id_vendedor := :OLD.id_vendedor; 
      rec.valor_produto := :OLD.valor_produto; 
      rec.valor_total_venda := :OLD.valor_total_venda; 
      rec.desconto_total_venda := :OLD.desconto_total_venda; 
      rec.qtde_vendas := :OLD.qtde_vendas; 
      rec.JN_DATETIME := SYSDATE; 
      rec.JN_ORACLE_USER := SYS_CONTEXT ('USERENV', 'SESSION_USER'); 
      rec.JN_APPLN := SYS_CONTEXT ('USERENV', 'MODULE'); 
      rec.JN_SESSION := SYS_CONTEXT ('USERENV', 'SESSIONID'); 
      rec.JN_OPERATION := 'DEL'; 
    END IF; 
    INSERT into TF Vendas_JN VALUES rec; 
  END; 
  /ALTER TABLE "TF Vendas"
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
