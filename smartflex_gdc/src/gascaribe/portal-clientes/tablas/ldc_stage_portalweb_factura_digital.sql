DECLARE
  CURSOR cuTabla(sbTable VARCHAR2, sbEsquema VARCHAR2) IS
    SELECT * FROM all_tables WHERE upper(TABLE_NAME) = upper(sbTable) and owner = sbEsquema;

  rccuTabla cuTabla%ROWTYPE;

BEGIN
  Dbms_Output.Put_Line('Inicia Creacion tabla PERSONALIZACIONES.LDC_STAGE_PW_FACT_DIG');
  OPEN cuTabla('LDC_STAGE_PW_FACT_DIG','PERSONALIZACIONES');
  FETCH cuTabla
    INTO rccuTabla;

  IF (cuTabla%NOTFOUND) THEN

    Dbms_Output.Put_Line('Inicia Crea PERSONALIZACIONES.LDC_STAGE_PW_FACT_DIG');

    EXECUTE IMMEDIATE 'create table PERSONALIZACIONES.LDC_STAGE_PW_FACT_DIG
               (
                   CONTRATO NUMBER(8) NOT NULL,
                   MARCA_FACTURA_DIGITAL VARCHAR2(1) NOT NULL,
                   CORREO_COBRO VARCHAR2(100) NOT NULL
                )';
    --- Comentarios de la tabla y campos.
    EXECUTE IMMEDIATE 'comment on table PERSONALIZACIONES.LDC_STAGE_PW_FACT_DIG is ''TABLA DE STAGING PARA SINCRONIZACIÓN DE INFORMACIÓN DE FACTURA DIGITAL DEL PORTAL DE CLIENTES''';
    EXECUTE IMMEDIATE 'comment on column PERSONALIZACIONES.LDC_STAGE_PW_FACT_DIG.CONTRATO is ''Identificador del contrato''';
    EXECUTE IMMEDIATE 'comment on column PERSONALIZACIONES.LDC_STAGE_PW_FACT_DIG.MARCA_FACTURA_DIGITAL is ''Marca que índica si la factura digital está o no activa (S -> Sí, N -> No)''';
    EXECUTE IMMEDIATE 'comment on column PERSONALIZACIONES.LDC_STAGE_PW_FACT_DIG.CORREO_COBRO is ''Dirección de correo electrónico al que se le enviará la factura digital si se encuentra activa''';

    --- Fin.

    Dbms_Output.Put_Line('Fin Creacion tabla PERSONALIZACIONES.LDC_STAGE_PW_FACT_DIG');
  ELSE
    Dbms_Output.Put_Line('***************tabla PERSONALIZACIONES.LDC_STAGE_PW_FACT_DIG ya existe');
  END IF;
  CLOSE cuTabla;

END;
/