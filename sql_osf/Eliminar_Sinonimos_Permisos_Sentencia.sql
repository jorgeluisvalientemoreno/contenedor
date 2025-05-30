/*BEGIN
adm_person.pkg_bogestionventaconstructora
personalizaciones.pkg_boventaconstructora.sql
pkg_reglas_ventaconstructora.sql
prcfinancotizaventaconstr.sql
prompt "Aplicando src/efigas/ventas/homologaciones/pkg_bogestionventaconstructora.fsbgetmodalitybyitem.sql"
@src/efigas/ventas/homologaciones/pkg_bogestionventaconstructora.fsbgetmodalitybyitem.sql

END;
/*/

DECLARE
  cursor CUPERMISOS is
    SELECT 'REVOKE ' || PRIVILEGE || ' ON ' || OWNER || '.' || TABLE_NAME ||
           ' FROM ' || GRANTEE || ';' cadena_sql
      FROM dba_tab_privs
     WHERE TABLE_NAME = upper('pkg_boventaconstructora')
    --AND GRANTEE = UPPER(isbEsquema)
    ;

  rfCUPERMISOS CUPERMISOS%rowtype;
BEGIN
  for rfCUPERMISOS in CUPERMISOS loop
    dbms_output.put_line(rfCUPERMISOS.cadena_sql);
    --execute immediate rfCUPERMISOS.cadena_sql;
  end loop;
END;
/

DECLARE cursor CUSINONIMOS is
  SELECT 'DROP SYNONYM ' || owner || '.' || synonym_name || ';' cadena_sql
    FROM dba_synonyms
   WHERE upper(TABLE_NAME) = upper('pkg_boventaconstructora');

rfCUSINONIMOS CUSINONIMOS%rowtype;
BEGIN
  for rfCUSINONIMOS in CUSINONIMOS loop
    dbms_output.put_line(rfCUSINONIMOS.cadena_sql);    
    --execute immediate rfCUSINONIMOS.cadena_sql;
  end loop;
END;
/
  SELECT *
    FROM dba_tab_privs
   WHERE TABLE_NAME = upper('pkg_boventaconstructora')
  --AND GRANTEE = UPPER(isbEsquema)
  ;
SELECT *
  FROM dba_synonyms
 WHERE upper(TABLE_NAME) = upper('pkg_boventaconstructora');

/*DROP SYNONYM OPEN.LD_BOCONSTANS;
    DROP SYNONYM PERSONALIZACIONES.LD_BOCONSTANS;
    
    DROP SYNONYM OPEN.LD_BOCONSTANS;
    DROP SYNONYM ADM_PERSON.LD_BOCONSTANS;*/
