SELECT owner || '.' || synonym_name || ';'
  FROM dba_synonyms
 WHERE upper(TABLE_NAME) = upper('LDC_FSBASIGNAUTOMATICAREVPER');
 
 
 BEGIN
  pkg_utilidades.prCrearSinonimos('LDC_FSBASIGNAUTOMATICAREVPER','ADM_PERSON');
END;
