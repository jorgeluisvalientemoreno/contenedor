DECLARE 
    nuExiste     NUMBER;
    sbDueno      VARCHAR2(30);
    sbNombTabla  VARCHAR2(30);
BEGIN
    BEGIN
	SELECT COUNT(1), OWNER, TABLE_NAME INTO nuexiste, sbDueno, sbNombTabla
      FROM dba_tables
     WHERE owner = 'OPEN'
       AND table_name = 'LDC_LOGAUDICLIEN597'
     GROUP BY OWNER, TABLE_NAME;
    EXCEPTION WHEN OTHERS THEN
        nuexiste:= 0;
        dbms_output.put_Line('Tabla LDC_LOGAUDICLIEN597 no existe o fue borrada');
    END;
	
   IF nuExiste > 0 THEN 
    EXECUTE IMMEDIATE 'DROP TABLE '||sbDueno||'.'||sbNombTabla||'';
   END IF;

END;
/