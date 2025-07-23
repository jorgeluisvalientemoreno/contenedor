DECLARE
  nuConta NUMBER;
  nuExiste 	NUMBER;
  
	cursor cuDatos(sbCampo VARCHAR2) is
	select count(1)
	  from dba_tab_columns
	 where table_name='RECOFAEL'
	   and column_name= sbCampo;
  
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'RECOFAEL' 
    AND OWNER = 'OPEN';
  
  IF nuConta = 0 THEN

	EXECUTE IMMEDIATE 'CREATE TABLE recofael( codigo              NUMBER(15) NOT NULL,
                       tipo_documento      NUMBER(15) NOT NULL,
                       prefijo             VARCHAR2(30) NOT NULL,
                       resolucion          VARCHAR2(40) NOT NULL,
                       cons_inicial        NUMBER(20) NOT NULL,
                       cons_final          NUMBER(20)NOT NULL,
                       ultimo_cons         NUMBER(20),
                       estado              VARCHAR2(1) NOT NULL,
                       fecha_resolucion    DATE NOT NULL,
                       fecha_ini_vigencia  DATE NOT NULL,
                       fecha_fin_vigencia  DATE NOT NULL,
                       fecha_registro      DATE,
                       usuario         	   VARCHAR2(50),
                       terminal            VARCHAR2(50))';
  EXECUTE IMMEDIATE q'#ALTER TABLE recofael ADD CONSTRAINT PK_recofael PRIMARY KEY(CODIGO)#';
  EXECUTE IMMEDIATE q'#ALTER TABLE recofael ADD CONSTRAINT FK_recofael_TIDOFAEL FOREIGN KEY(tipo_documento) REFERENCES TIDOFAEL(CODIGO)#';

	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN recofael.codigo IS 'Codigo'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN recofael.tipo_documento IS 'Tipo de documento'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN recofael.prefijo IS 'Prefijo'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN recofael.resolucion IS 'Resolucion'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN recofael.cons_inicial IS 'Consecutivo Inicial'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN recofael.cons_final IS 'Consecutivo Final'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN recofael.ultimo_cons IS 'Ultimo Consecutivo'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN recofael.estado IS 'Estado A -Activo I - Inactivo'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN recofael.fecha_resolucion IS 'Fecha de Resolucion'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN recofael.fecha_ini_vigencia IS 'Fecha Inicio Vigencia'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN recofael.fecha_fin_vigencia IS 'Fecha Fin Vigencia'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN recofael.fecha_registro IS 'Fecha de registro'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN recofael.usuario IS 'Usuario'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN recofael.terminal IS 'Terminal'#';
	EXECUTE IMMEDIATE q'#COMMENT ON TABLE recofael IS 'Resolucion de Consecutivo Facturacion Electronica'#';	
	


  END IF;
  
   -- Agregar Columna Empresa

  	OPEN cuDatos('EMPRESA');
	FETCH cuDatos INTO nuExiste;
	CLOSE cuDatos;

	IF nuExiste = 0 THEN
	
		EXECUTE IMMEDIATE 
		'alter table RECOFAEL
		add(
			"EMPRESA" VARCHAR2(10) DEFAULT' || ''''||'GDCA'||''''|| 'NOT NULL
			)';


		   EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.RECOFAEL.EMPRESA IS ' || '''' || 'Empresa' || '''';

  
	END IF;
	
	BEGIN
	  pkg_utilidades.prAplicarPermisos('RECOFAEL','OPEN');
	END;
	
END;
/