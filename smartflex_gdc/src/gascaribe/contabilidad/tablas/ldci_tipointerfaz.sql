DECLARE
  nuConta NUMBER;
  nuExiste 	NUMBER;
  
	cursor cuDatos(sbCampo VARCHAR2) is
	select count(1)
	  from dba_tab_columns
	 where table_name='LDCI_TIPOINTERFAZ'
	   and column_name= sbCampo;
	   
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'LDCI_TIPOINTERFAZ' 
    AND OWNER = 'OPEN';
  
   IF nuConta = 0 THEN
	EXECUTE IMMEDIATE q'#create table OPEN.LDCI_TIPOINTERFAZ
                        (
                          consecutivo     NUMBER(15),
                          tipointerfaz    VARCHAR2(3) not null,
                          cod_comprobante NUMBER(15) not null,
                          cod_tipocomp    NUMBER(4),
                          ledgers         VARCHAR2(3) default '-' not null
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
  EXECUTE IMMEDIATE q'#alter table OPEN.LDCI_TIPOINTERFAZ
                      add constraint LDCI_TIPOINTERFAZ_PK primary key (TIPOINTERFAZ, COD_COMPROBANTE)
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

	EXECUTE IMMEDIATE q'#COMMENT ON TABLE LDCI_TIPOINTERFAZ IS 'TIPO DE INTERFAZ POR COMPROBANTE Y TIPO DE COMPROBANTE'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN LDCI_TIPOINTERFAZ.consecutivo IS 'Consecutivo'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN LDCI_TIPOINTERFAZ.tipointerfaz IS 'TIPO INTERFAZ (L1,L2,L3,L4,L5,L6,L7,L8,L9,LA,LC)'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN LDCI_TIPOINTERFAZ.cod_comprobante IS 'COMPROBANTE CONTABLE'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN LDCI_TIPOINTERFAZ.cod_tipocomp IS 'TIPO COMPROBANTE'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN LDCI_TIPOINTERFAZ.ledgers IS 'Grupo de Ledgers'#';
	
    EXECUTE IMMEDIATE q'#grant select on OPEN.LDCI_TIPOINTERFAZ to MIGRA#';
    EXECUTE IMMEDIATE q'#grant insert, update, delete on OPEN.LDCI_TIPOINTERFAZ to RDMLOPEN#';
    EXECUTE IMMEDIATE q'#grant select on OPEN.LDCI_TIPOINTERFAZ to ROLESELOPEN#';
    EXECUTE IMMEDIATE q'#grant select on OPEN.LDCI_TIPOINTERFAZ to RSELOPEN#';
    EXECUTE IMMEDIATE q'#grant select on OPEN.LDCI_TIPOINTERFAZ to RSELSYS#';
    EXECUTE IMMEDIATE q'#grant select on OPEN.LDCI_TIPOINTERFAZ to RSELUSELOPEN#';
    EXECUTE IMMEDIATE q'#grant select, insert, update, delete on OPEN.LDCI_TIPOINTERFAZ to SYSTEM_OBJ_PRIVS_ROLE#';
   END IF;
  
     -- Agregar Columna Empresa

  	OPEN cuDatos('EMPRESA');
	FETCH cuDatos INTO nuExiste;
	CLOSE cuDatos;

	IF nuExiste = 0 THEN
	
		EXECUTE IMMEDIATE 
		'alter table OPEN.LDCI_TIPOINTERFAZ
		add(
			"EMPRESA" VARCHAR2(10) DEFAULT' || ''''||'GDCA'||''''|| 'NOT NULL
			)';


		   EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDCI_TIPOINTERFAZ.EMPRESA IS ' || '''' || 'Codigo de Empresa'|| '''';

  
	END IF;
	
  
END;
/