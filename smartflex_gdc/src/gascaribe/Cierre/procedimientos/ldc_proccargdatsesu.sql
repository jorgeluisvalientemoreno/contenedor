CREATE OR REPLACE PROCEDURE ldc_proccargdatsesu(sbptable VARCHAR2,sbmensa OUT VARCHAR2,nuerror OUT NUMBER) IS
 error               NUMBER(3);
 nuconta             NUMBER(10) DEFAULT 0;
 sbejecuta           VARCHAR2(1000);
BEGIN
 -- Insertamos informacion en la tabla ldc_osf_sesucier
 error := -1;
 sbejecuta := 'INSERT INTO ldc_osf_sesucier('||'SELECT * FROM '||TRIM(sbptable)||')';
 EXECUTE IMMEDIATE sbejecuta;
 COMMIT;
 error := -2;
 -- Contamos registros procesados
 nuconta := 0;
  sbejecuta := 'SELECT COUNT(1) FROM '||TRIM(sbptable);
 EXECUTE IMMEDIATE sbejecuta INTO nuconta;
 error := -3;
 sbmensa := 'Proceso terminó OK. Se procesarón : '||to_char(nuconta)||' registros.';
 nuerror := 0;
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_proccargdatsesu lineas error '||error||' '||sqlerrm;
  nuerror := -1;
END;
/
