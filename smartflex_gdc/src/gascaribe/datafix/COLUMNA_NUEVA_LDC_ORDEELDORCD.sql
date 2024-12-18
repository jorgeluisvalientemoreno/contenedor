DECLARE
  --<<
  -- Variables
  -->>
  nuExisteTabla   NUMBER := 0;
  nuExisteColumna NUMBER := 0;
  vaExecut        VARCHAR2(4000); -- Parametro para ejecucion
  sbtable         VARCHAR2(2000);
  sbColumn        VARCHAR2(2000);

  --<<
  -- Cursores del proceso
  -->>
  CURSOR cuExisteTabla(isbtable VARCHAR) IS
    SELECT COUNT(1) FROM dba_tables d WHERE UPPER(d.TABLE_NAME) = isbtable;

  CURSOR cuExisteColumna(isbtable_name VARCHAR, isbcolumn_name VARCHAR) IS
    select COUNT(1)
      from all_tab_columns
     where upper(table_name) = upper(isbtable_name)
       and upper(column_name) = upper(isbcolumn_name);

BEGIN

  sbtable  := 'LDC_ORDEELDORCD';
  sbColumn := 'NOMBRE_SOLICITANTE';

  OPEN cuExisteTabla(sbtable);
  FETCH cuExisteTabla
    INTO nuExisteTabla;
  CLOSE cuExisteTabla;

  --<<
  -- Valida si la tabla existe
  -->>
  IF (nuExisteTabla = 1) THEN
    --<<
    -- Columna existe
    -->>
    OPEN cuExisteColumna(sbtable, sbColumn);
    FETCH cuExisteColumna
      INTO nuExisteColumna;
    CLOSE cuExisteColumna;
  
    if (nuExisteColumna = 0) then
      EXECUTE IMMEDIATE 'ALTER TABLE ' || sbtable || ' ADD ' || sbColumn ||
                        ' VARCHAR2(4000)';
    
      EXECUTE IMMEDIATE 'comment on column ' || sbtable || '.' || sbColumn ||
                        ' is ''NOMBRE DEL SOLICITANTE''';
    
      dbms_output.put_line('Creacion de columna ' || sbColumn ||
                           ' en la entidad ' || sbtable ||
                           ' de manera exitosa...');
    
    else
      dbms_output.put_line('Ya existe la columna ' || sbColumn ||
                           ' en la entidad entidad ' || sbtable);
    end if;
  
  ElSE
  
    dbms_output.put_line('No existe la entidad entidad ' || sbtable);
  
  END IF;

END;
/
