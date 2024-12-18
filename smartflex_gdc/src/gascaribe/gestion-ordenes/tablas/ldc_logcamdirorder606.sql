DECLARE
  CURSOR cuTabla(sbTable VARCHAR2) IS
  SELECT COUNT(1) FROM all_tables WHERE upper(TABLE_NAME) = upper(sbTable);

  nuExistsTable NUMBER; 

BEGIN

  --Validacion de existencia de entidad
  OPEN cuTabla('LDC_LOGCAMDIRORDER606');
  FETCH cuTabla INTO nuExistsTable;

    IF (nuExistsTable <> 0) THEN
      /*Si la tabla ya existe, se informa en consola acerca de su existencia*/
      dbms_output.put_Line('La Tabla LDC_LOGCAMDIRORDER606 ya existe, se procede a borrar');
      EXECUTE IMMEDIATE 'drop table OPEN.LDC_LOGCAMDIRORDER606';
    END IF;    
    --- Fin.
  CLOSE cuTabla;

END;
/