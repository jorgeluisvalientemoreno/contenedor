DECLARE
 nuTab1 number := 0;
BEGIN

 SELECT COUNT(*) INTO nuTab1
 FROM DBA_TABLES
 WHERE TABLE_NAME = 'LDC_CONTANVEHIST';

 if nuTab1 = 0 then
	execute IMMEDIATE 'CREATE TABLE  LDC_CONTANVEHIST(	CONTPADRE NUMBER(15,0), 
                              CONTANUL NUMBER(15,0), 
                              OPERACION VARCHAR2(2),
                              FECHREGI DATE DEFAULT SYSDATE, 
                              USUARIO VARCHAR2(400 BYTE), 
                              TERMINAL VARCHAR2(400 BYTE) )';
	execute IMMEDIATE 'create index idx_con02contanveh on LDC_CONTANVEHIST (contpadre)';
	execute IMMEDIATE 'create index idx_con03contanveh on LDC_CONTANVEHIST (contanul, contpadre)';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTANVEHIST.CONTPADRE IS ''contrato padre''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTANVEHIST.CONTANUL IS ''contrato anular venta''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTANVEHIST.FECHREGI IS ''FECHA DE REGISTRO''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTANVEHIST.USUARIO IS ''USUARIO''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTANVEHIST.TERMINAL IS ''TERMINAL''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTANVEHIST.OPERACION IS ''OPERACION I-INSERTAR, U - MODIFICAR, D - ELIMINAR''';
	execute IMMEDIATE 'COMMENT ON TABLE OPEN.LDC_CONTANVEHIST  IS ''historico contrato para anular venta''';
	
	EXECUTE immediate 'grant select, insert, delete, update on LDC_CONTANVEHIST to SYSTEM_OBJ_PRIVS_ROLE';
	execute immediate 'grant select on LDC_CONTANVEHIST to RSELOPEN';
	execute immediate 'grant select on LDC_CONTANVEHIST to reportes';
  ELSE
    execute IMMEDIATE 'create index idx_con02contanveh on LDC_CONTANVEHIST (contpadre)';
	execute IMMEDIATE 'create index idx_con03contanveh on LDC_CONTANVEHIST (contanul, contpadre)';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTANVEHIST.CONTPADRE IS ''contrato padre''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTANVEHIST.CONTANUL IS ''contrato anular venta''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTANVEHIST.FECHREGI IS ''FECHA DE REGISTRO''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTANVEHIST.USUARIO IS ''USUARIO''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTANVEHIST.TERMINAL IS ''TERMINAL''';
	execute IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CONTANVEHIST.OPERACION IS ''OPERACION I-INSERTAR, U - MODIFICAR, D - ELIMINAR''';
	execute IMMEDIATE 'COMMENT ON TABLE OPEN.LDC_CONTANVEHIST  IS ''historico contrato para anular venta''';
	
	EXECUTE immediate 'grant select, insert, delete, update on LDC_CONTANVEHIST to SYSTEM_OBJ_PRIVS_ROLE';
	execute immediate 'grant select on LDC_CONTANVEHIST to RSELOPEN';
	execute immediate 'grant select on LDC_CONTANVEHIST to reportes';
  end if;
end;
/


