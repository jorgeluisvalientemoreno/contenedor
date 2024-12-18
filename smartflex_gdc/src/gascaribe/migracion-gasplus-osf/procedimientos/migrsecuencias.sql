CREATE OR REPLACE PROCEDURE      migrsecuencias is
sbsql     varchar2(800);
maxnumber number;
begin
    sbsql:='DROP SEQUENCE OPEN.SQ_CM_VAVAFACO_198733';
     execute immediate sbsql;
     sbsql:=
     'CREATE SEQUENCE OPEN.SQ_CM_VAVAFACO_198733
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  ORDER';
     execute immediate sbsql;
     sbsql:='DROP SEQUENCE OPEN.SEQ_GE_SUBSCRIBER';
     execute immediate sbsql;
     sbsql:=
          'CREATE SEQUENCE OPEN.SEQ_GE_SUBSCRIBER
           START WITH 50000
           MAXVALUE 9999999999999999999999999999
           MINVALUE 1
           NOCYCLE
          CACHE 20
         ORDER';
     execute immediate sbsql;
     sbsql:='drop sequence open.SEQ_GE_ITEMS_SERIADO';
     execute immediate sbsql;
     SELECT nvl(max(id_items_seriado),0) + 1 INTO maxnumber FROM GE_ITEMS_SERIADO where id_items_seriado not in (999999999999999,999999);
     IF MAXNUMBER<=10000 THEN
        MAXNUMBER:=10001;
     END IF;
     sbsql:=
     'CREATE SEQUENCE open.SEQ_GE_ITEMS_SERIADO START WITH '||maxnumber||
     'MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 ORDER';
     execute immediate sbsql;

     sbsql:='drop sequence open.SEQ_GE_ITEMS_TIPO_AT_VAL';
     execute immediate sbsql;
     SELECT nvl(max(id_items_tipo_at_val),0) + 1 INTO maxnumber FROM GE_ITEMS_TIPO_AT_VAL where id_items_seriado not in (999999999999999,999999);     
     sbsql:=
     'CREATE SEQUENCE open.SEQ_GE_ITEMS_TIPO_AT_VAL START WITH '||maxnumber||
     'MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 ORDER';
     execute immediate sbsql;
     
     
     sbsql:='DROP SEQUENCE OPEN.SQELEMMEDI';
     execute immediate sbsql;
      sbsql:=
     'CREATE SEQUENCE open.SQELEMMEDI START WITH '||maxnumber||
     'MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 ORDER';
      execute immediate sbsql;
      
     sbsql:='DROP SEQUENCE OPEN.SEQ_LDC_MIG_PERIFACT';
     execute immediate sbsql;
     sbsql:=
          'CREATE SEQUENCE OPEN.SEQ_LDC_MIG_PERIFACT
           START WITH 2
           MAXVALUE 9999999999999999999999999999
           MINVALUE 1
           NOCYCLE
          CACHE 20
         ORDER';
     execute immediate sbsql;
     maxnumber:=2000000000;
     sbsql:='DROP SEQUENCE SQ_FACTURA_FACTCODI';
     execute immediate sbsql;
     sbsql:=
          'CREATE SEQUENCE SQ_FACTURA_FACTCODI
           START WITH '||maxnumber||'
           MAXVALUE 9999999999999999999999999999
           MINVALUE 1
           NOCYCLE
          CACHE 20
         ORDER';
     execute immediate sbsql;
     sbsql:='DROP SEQUENCE OPEN.SEQ_MEDIREPE';
     execute immediate sbsql;
     sbsql:=
          'CREATE SEQUENCE OPEN.SEQ_MEDIREPE
           START WITH 1
           MAXVALUE 9999999999999999999999999999
           MINVALUE 1
           NOCYCLE
          CACHE 20
         ORDER';
     execute immediate sbsql;
end; 
/
