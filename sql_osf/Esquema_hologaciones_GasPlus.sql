DECLARE

  CURSOR CUENTIDADES IS
    select B.OWNER, B.OBJECT_NAME
      from dba_objects b
     where b.OWNER in ('OPEN'
                       --'ADM_PERSON',
                       --'PERSONALIZACIONES',
                       --'MULTIEMPRESA'
                       --'HOMOLOGACION'
                       --''
                       )
       and b.OBJECT_TYPE in ('TABLE')
     order by b.OWNER, B.OBJECT_NAME;

  CURSOR CULLAVEPROMARIA(SBENTIDAD VARCHAR2) IS
    SELECT uc.table_name, ucc.column_name, uc.constraint_name
      FROM user_constraints uc
      JOIN user_cons_columns ucc
        ON uc.constraint_name = ucc.constraint_name
     WHERE uc.constraint_type = 'P'
       AND uc.table_name = SBENTIDAD;

  SBCADENA VARCHAR2(4000);

BEGIN

  FOR RFENTIDADES IN CUENTIDADES LOOP
  
    SBCADENA := NULL;
  
    FOR RFLLAVEPROMARIA IN CULLAVEPROMARIA(RFENTIDADES.OBJECT_NAME) LOOP
    
      IF SBCADENA IS NULL THEN
        SBCADENA := ' A WHERE A.' || RFLLAVEPROMARIA.column_name || ' = ';
      ELSE
        SBCADENA := SBCADENA || ' AND A.' || RFLLAVEPROMARIA.column_name ||
                    ' = ';
      END IF;
    END LOOP;
  
    DBMS_OUTPUT.put_line('*' || RFENTIDADES.OBJECT_NAME ||
                         '=SELECT A.* FROM ' || RFENTIDADES.OWNER || '.' ||
                         RFENTIDADES.OBJECT_NAME || SBCADENA || ';');
  END LOOP;

END;
