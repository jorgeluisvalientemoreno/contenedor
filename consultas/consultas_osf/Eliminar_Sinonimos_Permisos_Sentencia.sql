/*BEGIN
  PKG_UTILIDADES.prCrearSinonimos('pkg_ldc_aud_bloq_lega_sol', 'PERSONALIZACIONES');
END;
/*/

SELECT 'REVOKE  ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' FROM ' ||
       GRANTEE || ';' cadena_sql
  FROM dba_tab_privs
 WHERE TABLE_NAME = upper('LD_BOCONSTANS')
--AND GRANTEE = UPPER(isbEsquema)
;
SELECT 'DROP SYNONYM ' || owner || '.' || synonym_name || ';'
  FROM dba_synonyms
 WHERE upper(TABLE_NAME) = upper('LD_BOCONSTANS');

/*DROP SYNONYM OPEN.LD_BOCONSTANS;
DROP SYNONYM PERSONALIZACIONES.LD_BOCONSTANS;

DROP SYNONYM OPEN.LD_BOCONSTANS;
DROP SYNONYM ADM_PERSON.LD_BOCONSTANS;*/
