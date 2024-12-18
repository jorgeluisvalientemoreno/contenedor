BEGIN
  dbms_output.put_line('Inicia aplicación permisos para sincronización de factura digital');
  --- Aplica Permisos.
  EXECUTE IMMEDIATE 'GRANT SELECT,UPDATE,DELETE,INSERT ON PERSONALIZACIONES.LDC_STAGE_PW_FACT_DIG TO INNOVACION';
  EXECUTE IMMEDIATE 'GRANT EXECUTE ON PERSONALIZACIONES.TRUNC_LDC_STAGE_PW_FACT_DIG TO INNOVACION';

  Dbms_Output.Put_Line('Fin aplicación permisos para sincronización de factura digital');
END;
/