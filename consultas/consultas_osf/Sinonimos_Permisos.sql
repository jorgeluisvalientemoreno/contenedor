declare

  isbObjeto  VARCHAR2(4000) := 'PKG_FM_POSSIBLE_NTL';--'PR_BOPRODUCT';
  isbEsquema VARCHAR2(4000) := 'ADM_PERSON';---'OPEN';

  sbTipoObje VARCHAR2(4000);
  sbPermisos VARCHAR2(4000);

  CURSOR cuGetInfoObje IS
    SELECT object_type
      FROM dba_objects
     WHERE object_name = UPPER(isbObjeto)
       AND object_type IN
           ('TABLE', 'PROCEDURE', 'PACKAGE', 'FUNCTION', 'VIEW', 'SEQUENCE');

BEGIN

  IF cuGetInfoObje%ISOPEN THEN
    CLOSE cuGetInfoObje;
  END IF;

  OPEN cuGetInfoObje;
  FETCH cuGetInfoObje
    INTO sbTipoObje;
  CLOSE cuGetInfoObje;

  IF sbTipoObje IS NULL THEN
    dbms_output.put_line(' objeto ' || isbObjeto || ' no existe');
  ELSE
    IF sbTipoObje = 'TABLE' THEN
      sbPermisos := 'SELECT,INSERT,DELETE,UPDATE';
    ELSIF sbTipoObje IN ('VIEW', 'SEQUENCE') THEN
      sbPermisos := 'SELECT';
    ELSE
      sbPermisos := 'EXECUTE';
    END IF;
  
    dbms_output.put_line('execute immediate GRANT ' || sbPermisos ||
                         ' ON ' || isbEsquema || '.' || isbObjeto ||
                         ' TO SYSTEM_OBJ_PRIVS_ROLE');
    IF UPPER(isbEsquema) <> 'PERSONALIZACIONES' THEN
      dbms_output.put_line('execute immediate GRANT ' || sbPermisos ||
                           ' ON ' || isbEsquema || '.' || isbObjeto ||
                           ' TO PERSONALIZACIONES');
    END IF;
    dbms_output.put_line('execute immediate GRANT ' || sbPermisos ||
                         ' ON ' || isbEsquema || '.' || isbObjeto ||
                         ' TO REXEINNOVA');
  
  END IF;
  
  IF isbEsquema = 'OPEN' THEN
        dbms_output.put_line('execute immediate CREATE OR REPLACE SYNONYM personalizaciones.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto);
        dbms_output.put_line('execute immediate CREATE OR REPLACE SYNONYM adm_person.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto);
        dbms_output.put_line('execute immediate CREATE OR REPLACE SYNONYM innovacion.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto);
    END IF;

    IF isbEsquema = 'PERSONALIZACIONES' THEN
        dbms_output.put_line('execute immediate CREATE OR REPLACE SYNONYM open.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto);
        dbms_output.put_line('execute immediate CREATE OR REPLACE SYNONYM adm_person.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto);
        dbms_output.put_line('execute immediate CREATE OR REPLACE SYNONYM innovacion.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto);
    END IF;

    IF isbEsquema = 'ADM_PERSON' THEN
        dbms_output.put_line('execute immediate CREATE OR REPLACE SYNONYM open.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto);
        dbms_output.put_line('execute immediate CREATE OR REPLACE SYNONYM personalizaciones.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto);
        dbms_output.put_line('execute immediate CREATE OR REPLACE SYNONYM innovacion.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto);
    END IF;

    IF isbEsquema = 'INNOVACION' THEN
        dbms_output.put_line('execute immediate CREATE OR REPLACE SYNONYM open.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto);
        dbms_output.put_line('execute immediate CREATE OR REPLACE SYNONYM personalizaciones.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto);
        dbms_output.put_line('execute immediate CREATE OR REPLACE SYNONYM adm_person.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto);
    END IF;

end;
