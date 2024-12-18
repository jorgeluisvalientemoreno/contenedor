CREATE OR REPLACE PROCEDURE PR_ACTFECHACALENT_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS
/*******************************************************************
 PROGRAMA    	:	PR_ACTFECHACALENT_ROLLOUT
 FECHA		:	22/10/2014
 AUTOR		:	OLSoftware
 DESCRIPCION	:	Actualiza las fechas de la revisiion periodica en LDC_PLAZOS_CERT y PR_CERTIFICATE
 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	DESCRIPCION

 *******************************************************************/

    nuMesesNoti      number := dald_parameter.fnuGetNumeric_Value('MESES_NOTI_RP_ITEM_ESPECIAL');
    nuMesesCert      number := dald_parameter.fnuGetNumeric_Value('MESES_PROXIMA_RP_ITEM_ESPECIAL');
    nuDiasMin        number := dald_parameter.fnuGetNumeric_Value('LDC_DIAS_MINIMO_RP');
    dtFechaFinRP     date;
    dtFechaMaxNoti   date;
    dtFechaMinNoti   date;
    dtFechaSusp      date;
    nuCont           number(4) := 0;
    vfecha_ini       DATE;
    vprograma        VARCHAR2 (100);
    nuComplementoPR  number;
    nuComplementoSU  number;
    nuComplementoFA  number;
    nuComplementoCU  number;
    nuComplementoDI  number;

    cursor cuExistcalentador is
     select /*+ parallel index(A IX_SUSCRIPC020) INDEX (C) INDEX(B INDEX3_LDC_TEMP_SERVSUSC_SGE) */
           A.SUSCCODI SUSCCODISFMA,
           A.SUSCIDDI,
           A.SUSCCLIE,
           C.GEOGRAP_LOCATION_ID LOCAHOMO,
           B.SESUNUSE + nuComplementoPR PRODUCTO,
           B.SESUSUSC + nuComplementoSU SUBSCRIPTION_ID,
           B.*
      from SUSCRIPC A, LDC_TEMP_SERVSUSC_SGE B, AB_ADDRESS C
     where A.SUSCCODI - nuComplementoSU = B.SESUSUSC
       and A.SUSCIDDI = C.ADDRESS_ID
       and B.SESUSERV = 1
       and B.SESUSUSC >= nuInicio
       and B.SESUSUSC < nuFinal
       and B.BASEDATO = nuBD
       and B.SESUCAES = 'S'
       and exists (select 1 from PR_CERTIFICATE W
                          where W.PRODUCT_ID = B.SESUNUSE + nuComplementoPR);

TYPE tipo_cu_datos IS TABLE OF cuExistcalentador%ROWTYPE;

tbl_datos      tipo_cu_datos := tipo_cu_datos ();

idtFechaRevision DATE;
OdtFechaFinRP DATE;
nuLogError NUMBER;
nuErrores number := 0;
nuTotalRegs number := 0;

  BEGIN
  
   vprograma := 'PR_ACTFECHACALENT_ROLLOUT';
   vfecha_ini := SYSDATE;
      
   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (234,234,1,'PR_ACTFECHACALENT_ROLLOUT',0,0,'Inicia Proceso','INICIO',nuLogError);
   
   UPDATE MIGR_RANGO_PROCESOS set RAPRFEIN = SYSDATE, RAPRTERM = 'P' where RAPRCODI = 234 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;
   
   PKG_CONSTANTES.COMPLEMENTO(nuBD,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);
  
    -- Abre CURSOR.
   OPEN cuExistcalentador;
   LOOP
      --
      -- Borrar tablas PL.
      --
      tbl_datos.delete;

      -- Cargar registros.
      --
      FETCH cuExistcalentador
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;

      FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
      
      BEGIN
      
      idtFechaRevision := NVL(TBL_DATOS(NUINDICE).SESUFERE,TBL_DATOS(NUINDICE).SESUFEIN);

	if idtFechaRevision is NOT null then

      /*Ubica la fecha de registro del certificado N meses adelante
      para empezar a devolverse y calcular la fecha mínima
      y máxima en que se debe notificar al usuario
      que debe presentar el certificado de revisión*/
      dtFechaFinRP := ADD_MONTHS(idtFechaRevision, nuMesesCert);

      /*A la fecha final de la revisión se le restan nuMesesNoti para ubicarnos
      en los N meses atrás en los que se notifica al usuario que pronto le vencerá
      el certificado de revisión.
      */
      --dtFechaMaxNoti := TRUNC(ADD_MONTHS(dtFechaFinRP,-1 * nuMesesNoti));
      dtFechaMinNoti := LAST_DAY(ADD_MONTHS(dtFechaFinRP, -1 * nuMesesNoti));

      --Busca el día hábil en caso de que el ultimo día sea festivo
      --y/o fin de semana
      WHILE NOT pkHolidayMgr.fboIsNonHoliday(dtFechaMinNoti - nuCont) LOOP
        --dbms_output.put_Line('nuCont:'||nuCont);
      nuCont := nuCont + 1;
      END LOOP;

      --Ultimo día hábil del mes
      dtFechaMinNoti := dtFechaMinNoti - nuCont;

      --Ultimo día del mes
      dtFechaMaxNoti := LAST_DAY(dtFechaFinRP);

      nuCont := 0;

      --Busca el día hábil en caso de que el ultimo día sea festivo
      --y/o fin de semana
      WHILE NOT pkHolidayMgr.fboIsNonHoliday(dtFechaMaxNoti - nuCont) LOOP
        --dbms_output.put_Line('nuCont:'||nuCont);
        nuCont := nuCont + 1;
      END LOOP;

      --Ultimo día hábil del mes
      dtFechaMaxNoti := dtFechaMaxNoti - nuCont;

      --Fecha para notificar la suspensión
      dtFechaSusp := dtFechaMaxNoti - nuDiasMin;

      OdtFechaFinRP := dtFechaFinRP;
    else
      dtFechaMaxNoti := null;
      dtFechaSusp    := null;
      dtFechaMinNoti := null;
    end if;

    --IF nuExiste = 1 THEN
      UPDATE LDC_PLAZOS_CERT
         SET PLAZO_MIN_REVISION   = dtFechaMinNoti,
             PLAZO_MIN_SUSPENSION = dtFechaSusp,
             PLAZO_MAXIMO         = dtFechaMaxNoti
       WHERE ID_PRODUCTO = TBL_DATOS(NUINDICE).PRODUCTO;

      UPDATE PR_CERTIFICATE P
         SET P.ESTIMATED_END_DATE = dtFechaFinRP
       WHERE P.PRODUCT_ID = TBL_DATOS(NUINDICE).PRODUCTO;
       
      COMMIT;

END;

END LOOP;
 
 EXIT WHEN cuExistcalentador%NOTFOUND;

   END LOOP;
   -- Cierra CURSOR.
   IF (cuExistcalentador%ISOPEN)
   THEN
      CLOSE cuExistcalentador;
   END IF;

 -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra(234,234,3,'PR_ACTFECHACALENT_ROLLOUT',nuTotalRegs,nuErrores,'TERMINO PROCESO #regs: ' || nuTotalRegs,'FIN',nuLogError);

  UPDATE MIGRA.MIGR_RANGO_PROCESOS SET RAPRFEFI = SYSDATE, RAPRTERM = 'T' WHERE RAPRCODI = 234 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
  COMMIT;
  
    PKLOG_MIGRACION.prInsLogMigra(234,234,2,'PR_ACTFECHACALENT_ROLLOUT',0,0,'Error10: ' || sqlerrm,to_char(sqlcode),nuLogError);
      
  END PR_ACTFECHACALENT_ROLLOUT; 
/
