DECLARE
  nuConta NUMBER;
  nuExiste 	NUMBER;
  
	cursor cuDatos(sbCampo VARCHAR2) is
	select count(1)
	  from dba_tab_columns
	 where table_name='LDC_HOMOITMAITAC'
	   and column_name= sbCampo;
	   
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'LDC_HOMOITMAITAC' 
    AND OWNER = 'OPEN';
  
   IF nuConta = 0 THEN
	EXECUTE IMMEDIATE q'#create table OPEN.LDC_HOMOITMAITAC
						(
						  item_material  NUMBER(15) not null,
						  item_actividad NUMBER(15) not null
						)
						tablespace TSD_DEFAULT
						  pctfree 10
						  initrans 1
						  maxtrans 255
						  storage
						  (
							initial 2M
							next 2M
							minextents 1
							maxextents unlimited
							pctincrease 0
						  )#';
  EXECUTE IMMEDIATE q'#alter table OPEN.LDC_HOMOITMAITAC
					  add constraint LDC_HOMOITMAITAC_PK primary key (ITEM_MATERIAL,ITEM_ACTIVIDAD)
					  using index 
					  tablespace TSI_DEFAULT
					  pctfree 10
					  initrans 2
					  maxtrans 255
					  storage
					  (
						initial 2M
						next 2M
						minextents 1
						maxextents unlimited
						pctincrease 0
					  )#';

	EXECUTE IMMEDIATE q'#COMMENT ON TABLE LDC_HOMOITMAITAC IS 'HOMOLOGACION ITEMS DE MATERIAL - ITEMS DE ACTIVIDAD'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN LDC_HOMOITMAITAC.item_material IS 'ITEMS DE MATERIAL'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN LDC_HOMOITMAITAC.item_actividad IS 'ITEMS DE ACTIVIDAD'#';
	
    EXECUTE IMMEDIATE q'#grant select on OPEN.LDC_HOMOITMAITAC to REPORTES#';
    EXECUTE IMMEDIATE q'#grant select on OPEN.LDC_HOMOITMAITAC to RGISOSF#';
    EXECUTE IMMEDIATE q'#grant select on OPEN.LDC_HOMOITMAITAC to ROLESELOPEN#';
    EXECUTE IMMEDIATE q'#grant select on OPEN.LDC_HOMOITMAITAC to RSELOPEN#';
    EXECUTE IMMEDIATE q'#grant select on OPEN.LDC_HOMOITMAITAC to RSELUSELOPEN#';
    EXECUTE IMMEDIATE q'#grant select on OPEN.LDC_HOMOITMAITAC to RSELUSELOPEN#';
    EXECUTE IMMEDIATE q'#grant select, insert, update, delete, alter on OPEN.LDC_HOMOITMAITAC to SYSTEM_OBJ_PRIVS_ROLE#';
   END IF;


	SELECT COUNT(*) INTO nuConta
	FROM user_cons_columns
	WHERE constraint_name = 'LDC_HOMOITMAITAC_PK' 
	AND COLUMN_NAME = 'ITEM_ACTIVIDAD'; 

	IF nuConta = 0 THEN
		EXECUTE IMMEDIATE q'#alter table LDC_HOMOITMAITAC drop constraint LDC_HOMOITMAITAC_PK#';
		EXECUTE IMMEDIATE q'#alter table LDC_HOMOITMAITAC add constraint LDC_HOMOITMAITAC_PK primary key(ITEM_MATERIAL,ITEM_ACTIVIDAD)#';
	END IF;
	 
  
     -- Agregar Columna Empresa

  	OPEN cuDatos('EMPRESA');
	FETCH cuDatos INTO nuExiste;
	CLOSE cuDatos;

	IF nuExiste = 0 THEN
	
		EXECUTE IMMEDIATE 
		'alter table OPEN.LDC_HOMOITMAITAC
		add(
			"EMPRESA" VARCHAR2(10) DEFAULT' || ''''||'GDCA'||''''|| 'NOT NULL
			)';


		   EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_HOMOITMAITAC.EMPRESA IS ' || '''' || 'Codigo de Empresa'|| '''';

  
	END IF;
	
  
END;
/