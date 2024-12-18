CREATE OR REPLACE PROCEDURE PR_MIG_FM_POSSIBLE_NTL as
  /* *****************************************************************
  United        : PR_MIG_FM_POSSIBLE_NTL
  Description   : FM_POSSIBLE_NTL
  Autor         : Manuel Alejandro Palomares // Olsoftware
  Fecha         : 03-10-2013
  Proyecto      : Frente de Datos - Migracion SmartFlex
  *********************************************************************/


  cursor cuNtlFraudes is
  select
  NULL             															POSSIBLE_NTL_ID,
  'F'              															STATUS,
  b.PRODUCT_ID     															PRODUCT_ID,
  7014             															PRODUCT_TYPE_ID,
  a.GEOGRAP_LOCATION_ID GEOGRAP_LOCATION_ID,
  (select f.address_id from pr_product f where f.product_id = b.product_id) ADDRESS_ID,
  a.CREATED_DATE 															REGISTER_DATE,
  4 																		DISCOVERY_TYPE_ID,
  null 																		PROJECT_ID,
  a.order_id 																ORDER_ID,
  a.LEGALIZATION_DATE 														REVIEW_DATE,
  null 																		COMMENT_,
  null 																		VALUE_,
  -1 																		PERSON_ID,
  null 																		PACKAGE_ID,
  null 																		INFORMER_SUBS_ID,
  null 																		NORMALIZED_PROD_ID,
  'F' 																		NTL_TYPE,
  a.CREATED_DATE 															FRAUD_START_DATE,
  a.LEGALIZATION_DATE 														FRAUD_END_DATE,
  null 																		TCONCODI,
   (select EMSSELME from elmesesu where EMSSSESU  =  b.PRODUCT_ID  and EMSSSERV  = 7014 and rownum < 2) COSSELME,
  null 																		PNOLIQ_VERSION,
  0 																		LAST_CONS_AVG
  FROM or_order a, or_order_activity b
  WHERE a.TASK_TYPE_ID = 10128
  and a.ORDER_ID = b.ORDER_ID
  order by b.PRODUCT_ID;


    nuLogError  number;
    nuTotalRegs number := 0;
    nuErrores 	number := 0;
	nuNtlId   	number;
	vcontIns    number;
	sbError		varchar2(4000);
begin
	-- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (3003,3003,1,'FM_POSSIBLE_NTL',0,0,'Inicia Proceso','INICIO',nuLogError);

	  for rgFraude in cuNtlFraudes loop

	  -- inserta en REGISTROS
		begin
			nuNtlId := SEQ_FM_POSSIBLE_NTL_123873.nextval;
			--rgFraude.POSSIBLE_NTL_ID
			Insert into FM_POSSIBLE_NTL
			values(
				nuNtlId,
				'F',--rgFraude.STATUS,
				rgFraude.PRODUCT_ID,
				rgFraude.PRODUCT_TYPE_ID,
				rgFraude.GEOGRAP_LOCATION_ID,
				rgFraude.ADDRESS_ID,
				rgFraude.REGISTER_DATE,
				rgFraude.DISCOVERY_TYPE_ID,
				rgFraude.PROJECT_ID,
				rgFraude.ORDER_ID,
				rgFraude.REVIEW_DATE,
				rgFraude.COMMENT_,
				rgFraude.VALUE_,
				rgFraude.PERSON_ID,
				rgFraude.PACKAGE_ID,
				rgFraude.INFORMER_SUBS_ID,
				rgFraude.NORMALIZED_PROD_ID,
				rgFraude.NTL_TYPE,
				rgFraude.FRAUD_START_DATE,
				rgFraude.FRAUD_END_DATE,
				rgFraude.TCONCODI,
				rgFraude.COSSELME,
				rgFraude.PNOLIQ_VERSION,
				rgFraude.LAST_CONS_AVG
			);
		commit;
		exception
		when others then
			sbError := 'Error insert :'||sqlerrm;
			nuErrores := nuErrores + 1;
			PKLOG_MIGRACION.prInsLogMigra (3003,3003,2,'FM_POSSIBLE_NTL',0,0,sbError,null,nuLogError);
		end;

		-- cantidad de inserts
		if(sbError  is  null) then
			vcontIns := vcontIns+1;
    end if;

    end loop;

   -- Termina Log
    PKLOG_MIGRACION.prInsLogMigra ( 3003,3003,3,'FM_POSSIBLE_NTL',vcontIns,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);

  end PR_MIG_FM_POSSIBLE_NTL;
/
