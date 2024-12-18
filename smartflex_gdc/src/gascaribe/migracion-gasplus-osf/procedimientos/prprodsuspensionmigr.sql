CREATE OR REPLACE procedure      PRPRODSUSPENSIONmigr (NUMINICIO number, numFinal number,pbd number ) is
  /*******************************************************************
 PROGRAMA    	    :   PRPRODSUSPENSIONmigr
 FECHA		    :	25/05/2014
 AUTOR		    :	VICTOR HUGO MUNIVE ROCA
 DESCRIPCION	    :	crea las informacion de los productos suspendidos
 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION
 *******************************************************************/
  nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuComplementoDI   number;
  complementos number;
  limitei      number;
  limites      number;
  nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;
   cursor cuSuspendidos is
  SELECT SESUNUSE sesunuse,
         fnuTipoSuspROLLOUT(SESUNUSE,PBD,nuComplementoPR) SUSPENSION_TYPE_ID,
         fdtFecha(SESUNUSE,pBd,nuComplementoPR)        REGISTER_DATE,
         fdtFecha(SESUNUSE,pbd,nuComplementoPR)        APLICATION_DATE,
         null INACTIVE_DATE,
         'Y' ACTIVE,
         null connection_Code
   from  pr_product, servsusc
   where product_status_id = 2
   and   product_type_id = 7014
   and   pr_product.product_id >= NUMINICIO
   and   pr_product.product_id <  numFinal
   and pr_product.product_id  in (SELECT sesunuse + nuComplementoPR
              FROM LDC_TEMP_SERVSUSC_SGE
             WHERE basedato = pBd)
   and   pr_product.service_number = sesunuse;
   
BEGIN
    pkg_constantes.COMPLEMENTO(pbd,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);
    PKLOG_MIGRACION.prInsLogMigra (180,180,1,'PRPRODSUSPENSIONmigr',0,0,'Inicia Proceso','INICIO',nuLogError);
        UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=pbd AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=180;
  -- Cargar Registros
  for rtSusp in cuSuspendidos loop
      begin
         INSERT INTO PR_PROD_SUSPENSION (PROD_SUSPENSION_ID, PRODUCT_ID, SUSPENSION_TYPE_ID, REGISTER_DATE, APLICATION_DATE,
                                         INACTIVE_DATE, ACTIVE, CONNECTION_CODE)
                    VALUES (SEQ_PR_PROD_SUSPENSION.NEXTVAL, rtSusp.sesunuse, rtSusp.SUSPENSION_TYPE_ID,
                            rtSusp.REGISTER_DATE, rtSusp.APLICATION_DATE, rtSusp.INACTIVE_DATE,
                            rtSusp.ACTIVE, rtSusp.CONNECTION_CODE);
         COMMIT;
         NUTOTALREGS := NUTOTALREGS + 1;
      EXCEPTION
        WHEN OTHERS THEN
           NUERRORES := NUERRORES + 1;
           PKLOG_MIGRACION.prInsLogMigra ( 180,180,2,'PRPRODSUSPENSIONmigr',0,0,'Producto : '||rtSusp.sesunuse||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
      END;
   end loop;
       --- Termina log
    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=pbd AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=180;
    PKLOG_MIGRACION.PRINSLOGMIGRA ( 180,180,3,'PRPRODSUSPENSIONmigr',NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||NUTOTALREGS,'FIN',NULOGERROR);
EXCEPTION
     WHEN OTHERS THEN
        BEGIN
           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 180,180,2,'PRPRODSUSPENSIONmigr',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
        END;
end; 
/
