DECLARE
  nuConta NUMBER;
  nuExiste 	NUMBER;
  
	cursor cuDatos(sbCampo VARCHAR2) is
	select count(1)
	  from dba_tab_columns
	 where table_name='LDCI_REGISTRAINTERFAZ'
	   and column_name= sbCampo;
	   
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'LDCI_REGISTRAINTERFAZ' 
    AND OWNER = 'OPEN';
  
  IF nuConta = 0 THEN

	EXECUTE IMMEDIATE q'#create table OPEN.LDCI_REGISTRAINTERFAZ
						(
						  ldcodinterf    NUMBER(10) not null,
						  ldanocontabi   NUMBER(4) not null,
						  ldmescontab    NUMBER(2) not null,
						  ldfechconta    DATE not null,
						  ldflagcontabi  VARCHAR2(1) not null,
						  ldtipointerfaz VARCHAR2(3) not null,
						  fechaupdate    DATE,
						  userupdate     VARCHAR2(100),
						  terminalupdate VARCHAR2(100),
						  flagold        VARCHAR2(1)
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


	EXECUTE IMMEDIATE q'#COMMENT ON TABLE LDCI_REGISTRAINTERFAZ IS 'registro de interfaz'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN LDCI_REGISTRAINTERFAZ.ldcodinterf IS 'codigo de la interfaz'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN LDCI_REGISTRAINTERFAZ.ldanocontabi IS 'ano de ejecucion de la interfaz'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN LDCI_REGISTRAINTERFAZ.ldmescontab IS 'mes de ejecucion de la interfaz'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN LDCI_REGISTRAINTERFAZ.ldfechconta IS 'fecha de ejecucion de la interfaz'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN LDCI_REGISTRAINTERFAZ.ldflagcontabi IS 'flag que indica la ejecucion de la interfaz'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN LDCI_REGISTRAINTERFAZ.ldtipointerfaz IS 'Codigo tipo Interfaz'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN LDCI_REGISTRAINTERFAZ.fechaupdate IS 'Fecha actualizacion'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN LDCI_REGISTRAINTERFAZ.userupdate IS 'Usuario que realizo la actualizacion'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN LDCI_REGISTRAINTERFAZ.terminalupdate IS 'Flag que tenia antes de la actualizacion'#';
	
    EXECUTE IMMEDIATE q'#grant select on OPEN.LDCI_REGISTRAINTERFAZ to MIGRA#';
    EXECUTE IMMEDIATE q'#grant insert, update, delete on OPEN.LDCI_REGISTRAINTERFAZ to RDMLOPEN#';
    EXECUTE IMMEDIATE q'#grant select on OPEN.LDCI_REGISTRAINTERFAZ to ROLESELOPEN#';
    EXECUTE IMMEDIATE q'#grant select on OPEN.LDCI_REGISTRAINTERFAZ to RSELOPEN#';
    EXECUTE IMMEDIATE q'#grant select on OPEN.LDCI_REGISTRAINTERFAZ to RSELSYS#';
    EXECUTE IMMEDIATE q'#grant select on OPEN.LDCI_REGISTRAINTERFAZ to RSELUSELOPEN#';
    EXECUTE IMMEDIATE q'#grant select, insert, update, delete on OPEN.LDCI_REGISTRAINTERFAZ to SYSTEM_OBJ_PRIVS_ROLE#';
  END IF;
  
     -- Agregar Columna Empresa

  	OPEN cuDatos('EMPRESA');
	FETCH cuDatos INTO nuExiste;
	CLOSE cuDatos;

	IF nuExiste = 0 THEN
	
		EXECUTE IMMEDIATE 
		'alter table OPEN.LDCI_REGISTRAINTERFAZ
		add(
			"EMPRESA" VARCHAR2(10)
			)';


		   EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDCI_REGISTRAINTERFAZ.EMPRESA IS ' || '''' || 'Codigo de Empresa'|| '''';

  
	END IF;
	
  
END;
/