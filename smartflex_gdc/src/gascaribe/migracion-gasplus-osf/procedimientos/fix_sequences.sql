CREATE OR REPLACE PROCEDURE      "FIX_SEQUENCES"
as
maxnumber number;
sbsql varchar2(800);
nuLogError number;
begin

PKLOG_MIGRACION.prInsLogMigra ( 1020,1020,1,'FIX_SECUENCES',0,0,'INICIA PROCESO','INICIA',nuLogError);

-- SECUENCIA SEQ_GE_SUBSCRIBER
sbsql:='DROP SEQUENCE OPEN.SEQ_GE_SUBSCRIBER';

execute immediate sbsql;

SELECT max(subscriber_id) + 1 INTO maxnumber FROM GE_SUBSCRIBER where subscriber_id not in (999999999999999,999999);

sbsql:=
'CREATE SEQUENCE OPEN.SEQ_GE_SUBSCRIBER
  START WITH '||maxnumber||'
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  ORDER';

execute immediate sbsql;

sbsql:='GRANT SELECT ON OPEN.SEQ_GE_SUBSCRIBER TO SYSTEM_OBJ_PRIVS_ROLE';

execute immediate sbsql;


-- SECUENCIA SEQ_PR_PRODUCT
sbsql:='DROP SEQUENCE OPEN.SEQ_PR_PRODUCT';

execute immediate sbsql;

SELECT max(product_id) + 1 INTO maxnumber FROM Pr_product WHERE product_id<>9999999999;

sbsql:=
'CREATE SEQUENCE OPEN.SEQ_PR_PRODUCT
  START WITH '||maxnumber||'
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  ORDER';

execute immediate sbsql;

sbsql:='GRANT SELECT ON OPEN.SEQ_PR_PRODUCT TO SYSTEM_OBJ_PRIVS_ROLE';


-- SECUENCIA DIFERIDO DIFECOFI
sbsql:='DROP SEQUENCE OPEN.SQ_DEFERRED_DIFECOFI';

execute immediate sbsql;

SELECT max(difecofi) + 1 INTO maxnumber FROM diferido;

sbsql:=
'CREATE SEQUENCE OPEN.SQ_DEFERRED_DIFECOFI
  START WITH '||maxnumber||'
  MAXVALUE 9999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  ORDER';

execute immediate sbsql;

sbsql:='GRANT SELECT ON OPEN.SQ_DEFERRED_DIFECOFI TO SYSTEM_OBJ_PRIVS_ROLE';

execute immediate sbsql;

-- secuencia DIFECODI
sbsql:='DROP SEQUENCE OPEN.SQ_DIFERIDO_DIFECODI';

execute immediate sbsql;

SELECT max(difecodi) + 1 INTO maxnumber FROM diferido;

sbsql:=
'CREATE SEQUENCE OPEN.SQ_DIFERIDO_DIFECODI
  START WITH '||maxnumber||'
  MAXVALUE 9999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  ORDER';

execute immediate sbsql;

sbsql:='GRANT SELECT ON OPEN.SQ_DIFERIDO_DIFECODI TO SYSTEM_OBJ_PRIVS_ROLE';

execute immediate sbsql;
-- Secuencia SUSCRIPC

sbsql:='DROP SEQUENCE OPEN.SQ_SUSCRIPC_897';

execute immediate sbsql;


SELECT max(susccodi) + 1  INTO maxnumber FROM suscripc WHERE susccodi not in (99999999,99999990);

sbsql:=
'CREATE SEQUENCE OPEN.SQ_SUSCRIPC_897
  START WITH '||maxnumber||'
  MAXVALUE 9999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  ORDER';

execute immediate sbsql;

sbsql:='GRANT SELECT ON OPEN.SQ_SUSCRIPC_897 TO SYSTEM_OBJ_PRIVS_ROLE';

execute immediate sbsql;

-- Segunda secuencia suscripc

sbsql:='DROP SEQUENCE OPEN.SEQ_MO_SUBSCRIPTION';

execute immediate sbsql;

SELECT max(susccodi) + 1 INTO maxnumber FROM suscripc WHERE susccodi <>99999999;

sbsql:=
'CREATE SEQUENCE OPEN.SEQ_MO_SUBSCRIPTION
  START WITH '||maxnumber||'
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  ORDER';

execute immediate sbsql;

sbsql:='GRANT SELECT ON OPEN.SEQ_MO_SUBSCRIPTION TO SYSTEM_OBJ_PRIVS_ROLE';



-- secuencia PR_COMPONENT

sbsql:='DROP SEQUENCE OPEN.SEQ_PR_COMPONENT';

execute immediate sbsql;

SELECT max(COMPONENT_ID) + 1 INTO maxnumber FROM PR_COMPONENT;

sbsql:=
'CREATE SEQUENCE OPEN.SEQ_PR_COMPONENT
  START WITH '||maxnumber||'
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  ORDER';

execute immediate sbsql;

sbsql:='GRANT SELECT ON OPEN.SEQ_PR_COMPONENT TO SYSTEM_OBJ_PRIVS_ROLE';

execute immediate sbsql;

-- Secuencia compsesu

sbsql:='DROP SEQUENCE OPEN.SQCOMPSESU';

execute immediate sbsql;

SELECT max(cmssidco) + 1 INTO maxnumber FROM COMPSESU;

sbsql:=
'CREATE SEQUENCE OPEN.SQCOMPSESU
  START WITH '||maxnumber||'
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  ORDER';

execute immediate sbsql;

sbsql:='GRANT SELECT ON OPEN.SQCOMPSESU TO SYSTEM_OBJ_PRIVS_ROLE';

execute immediate sbsql;


-- Secuencia compsesu

sbsql:='DROP SEQUENCE OPEN.SQ_FACTURA_FACTCODI';

execute immediate sbsql;

SELECT max(factcodi) + 1 into  maxnumber FROM factura;

sbsql:=
'CREATE SEQUENCE OPEN.SQ_FACTURA_FACTCODI
  START WITH '||maxnumber||'
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  ORDER';

execute immediate sbsql;

sbsql:='GRANT SELECT ON OPEN.SQ_FACTURA_FACTCODI TO SYSTEM_OBJ_PRIVS_ROLE';

execute immediate sbsql;

PKLOG_MIGRACION.prInsLogMigra ( 1020,1020,3,'FIX_SECUENCES',0,0,'TERMINA PROCESO','FIN',nuLogError);

END; 
/
