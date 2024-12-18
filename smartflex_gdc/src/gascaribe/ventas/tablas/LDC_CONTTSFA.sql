DECLARE
 nuTab1 number := 0;
BEGIN

 SELECT COUNT(*) INTO nuTab1
 FROM DBA_TABLES
 WHERE TABLE_NAME = 'LDC_CONTTSFA';

 if nuTab1 = 0 then
	execute IMMEDIATE 'CREATE TABLE  LDC_CONTTSFA(	CONTPADRE NUMBER(15,0), 
                            DIREPRHI  NUMBER(15,0), 
                            FECHREGI DATE DEFAULT SYSDATE, 
                            FECHULMO DATE,
							ESTADO   VARCHAR2(1),
                            USUARIO VARCHAR2(400 BYTE), 
                            TERMINAL VARCHAR2(400 BYTE) )';
	execute IMMEDIATE 'alter table LDC_CONTTSFA add constraints pk_CONTTSFA primary key (DIREPRHI)';
	execute IMMEDIATE 'alter table LDC_CONTTSFA add constraint fk_dire_CONTTSFA foreign key (DIREPRHI) references ab_address (ADDRESS_ID)';
	execute IMMEDIATE 'create index idxcon01_CONTTSFA on LDC_CONTTSFA(CONTPADRE, DIREPRHI)';
	execute IMMEDIATE 'create index idxcon02_CONTTSFA on LDC_CONTTSFA(CONTPADRE)';
	execute IMMEDIATE 'create index idxcon03_CONTTSFA on LDC_CONTTSFA(FECHREGI)';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTTSFA.CONTPADRE IS ''contrato padre''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTTSFA.DIREPRHI IS ''Direccion producto hijo''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTTSFA.FECHREGI IS ''FECHA DE REGISTRO''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTTSFA.ESTADO IS ''ESTADO''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTTSFA.USUARIO IS ''USUARIO''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTTSFA.TERMINAL IS ''TERMINAL''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTTSFA.FECHULMO IS ''Ultima Modificacion''';
	execute IMMEDIATE 'COMMENT ON TABLE OPEN.LDC_CONTTSFA  IS ''Contrato para trasladar saldo a favor''';
	
	EXECUTE immediate 'grant select, insert, delete, update on LDC_CONTTSFA to SYSTEM_OBJ_PRIVS_ROLE';
	execute immediate 'grant select on LDC_CONTTSFA to RSELOPEN';
	execute immediate 'grant select on LDC_CONTTSFA to reportes';
  ELSE 
    execute IMMEDIATE 'create index idxcon01_CONTTSFA on LDC_CONTTSFA(CONTPADRE, DIREPRHI)';
	execute IMMEDIATE 'create index idxcon02_CONTTSFA on LDC_CONTTSFA(CONTPADRE)';
	execute IMMEDIATE 'create index idxcon03_CONTTSFA on LDC_CONTTSFA(FECHREGI)';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTTSFA.CONTPADRE IS ''contrato padre''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTTSFA.DIREPRHI IS ''Direccion producto hijo''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTTSFA.FECHREGI IS ''FECHA DE REGISTRO''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTTSFA.ESTADO IS ''ESTADO''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTTSFA.USUARIO IS ''USUARIO''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTTSFA.TERMINAL IS ''TERMINAL''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTTSFA.FECHULMO IS ''Ultima Modificacion''';
	execute IMMEDIATE 'COMMENT ON TABLE OPEN.LDC_CONTTSFA  IS ''Contrato para trasladar saldo a favor''';
	
	EXECUTE immediate 'grant select, insert, delete, update on LDC_CONTTSFA to SYSTEM_OBJ_PRIVS_ROLE';
	execute immediate 'grant select on LDC_CONTTSFA to RSELOPEN';
	execute immediate 'grant select on LDC_CONTTSFA to reportes';
	execute IMMEDIATE 'alter table LDC_CONTTSFA add constraint fk_dire_CONTTSFA foreign key (DIREPRHI) references ab_address (ADDRESS_ID)';
  end if;
end;
/


