drop table LDC_DAVEINGTEMP;
CREATE   GLOBAL TEMPORARY TABLE LDC_DAVEINGTEMP 
   (	VETETISO NUMBER(15,0), 
	VETETIRE NUMBER(4,0), 
	VETEPROD NUMBER(15,0), 
	VETEPERS NUMBER(15,0), 
	VETEPATE NUMBER(6,0), 
	VETECONT NUMBER(15,0), 
	VETEOBSE VARCHAR2(1000 BYTE), 
	VETECLIE NUMBER(15,0), 
	VETEIDDI NUMBER(15,0), 
	VETEUNID NUMBER(15,0), 
	VETEACTI NUMBER(15,0), 
	VETECAUS NUMBER(4,0), 
	VETEITEM VARCHAR2(600 BYTE), 
	VETEDAAD VARCHAR2(600 BYTE), 
	VETECOLE VARCHAR2(600 BYTE), 
	VETEFEGE DATE, 
	VETEUSUA NUMBER(15,0), 
	VETEESTA VARCHAR2(2 BYTE), 
	VETEINTE NUMBER(2,0)
   ) ON COMMIT PRESERVE ROWS;
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETETISO IS 'Tipo de solicitud';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETETIRE IS 'Tipo de recepcion';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETEPROD IS 'Producto';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETEPERS IS 'Persona que legaliza';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETEPATE IS 'Punto de atencion';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETECONT IS 'Contrato';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETEOBSE IS 'Observacion de la solicitud';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETECLIE IS 'Cliente';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETEIDDI IS 'Direccion';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETEUNID IS 'Unidad Operativa';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETEACTI IS 'Actividad';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETECAUS IS 'Causal de legalizacion';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETEITEM IS 'Items [ item>cantidad>code_elemento]';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETEDAAD IS 'Datos adicionales [atributo1=valor1]';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETECOLE IS 'Comentarios de Legalizacion [Tipo_comentario;Texto_Comentario]';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETEFEGE IS 'Fecha de generacion';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETEUSUA IS 'Usuario que proceso';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETEESTA IS 'Estado del Registro';
   COMMENT ON COLUMN LDC_DAVEINGTEMP.VETEINTE IS 'Intentos';
   COMMENT ON TABLE LDC_DAVEINGTEMP  IS 'Registro de Datos para Ventas de Ingenieria';

  CREATE INDEX IDX_LDC_DAVEINGTEMP ON LDC_DAVEINGTEMP (VETEESTA, VETEUSUA, VETEINTE, VETEPROD) ;

  CREATE INDEX IDX_LDC_DAVEINGTEMP1 ON LDC_DAVEINGTEMP (VETETISO, VETETIRE, VETEPROD, VETEFEGE, VETEPATE, VETEOBSE, VETEUNID, VETEACTI, VETECONT, VETECLIE, VETEIDDI) 
  /