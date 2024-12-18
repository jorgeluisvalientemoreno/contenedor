CREATE OR REPLACE PROCEDURE LDC_PROGENCIERRE_GDC IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-08-14
  Descripcion : Ejecutamos cierre cartera

  Parametros Entrada
    nuano A?o
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION
   24/05/2024   JSOTO   OSF-2749 Se elimina llamado a procedimiento ldc_cartcastigada_cierre_gdc 
                        Se elimina llamado a procedimiento ldc_procllenaindicadorcartera
***************************************************************************/
sbmensa     VARCHAR2(1000);
nuerror     NUMBER(15);
nusession   NUMBER;
sbuser      VARCHAR2(30);
nuccano     ldc_ciercome.cicoano%TYPE;
nuccmes     ldc_ciercome.cicomes%TYPE;
nuhora      VARCHAR2(6);
pfecin      ldc_ciercome.cicofein%TYPE;
pfecfin     ldc_ciercome.cicofech%TYPE;
horaej      VARCHAR2(6);
sbesta      ldc_ciercome.cicoesta%TYPE;
nucontacier NUMBER(3) DEFAULT 0;
nucontahil1 NUMBER(3) DEFAULT 0;
nucontahil2 NUMBER(3) DEFAULT 0;
nucontahil3 NUMBER(3) DEFAULT 0;
nucontahil4 NUMBER(3) DEFAULT 0;
nucontahil5 NUMBER(3) DEFAULT 0;
nucontahil6 NUMBER(3) DEFAULT 0;
dtfecheject DATE;
nunsali     NUMBER(1);
sbdatabase  VARCHAR2(1000);
nucontabd   NUMBER(2);
BEGIN
-- Obtenemos a?o, mes y hora del mes a cerrar
ldc_proretornafechavalcierr(nuccano,nuccmes,nuhora,pfecin,pfecfin,dtfecheject,horaej,sbesta,nunsali);
  IF trunc(dtfecheject)>trunc(SYSDATE) THEN
     RETURN;
  ELSE
   -- Si es la hora del cierre
    IF to_date(nuhora,'hh24:mi')>=to_date(horaej,'hh24:mi') AND nvl(sbesta,'N')='N' THEN
     nucontacier := ldc_fncretornaprocejecierr(nuccano,nuccmes,'LDC_PROGENCIERRE_GDC');
     nucontahil1 := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H1');
     nucontahil2 := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H2');
     nucontahil3 := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H3');
     nucontahil4 := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H4');
     nucontahil5 := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H5');
     nucontahil6 := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H6');
     IF nucontacier = 0 AND nucontahil1 > 0 AND nucontahil2 > 0 AND nucontahil3 > 0 AND nucontahil4 > 0 AND nucontahil5 > 0 AND nucontahil6 > 0 THEN
        SELECT USERENV('SESSIONID'),USER INTO nusession,sbuser FROM dual;
        -- Se ejecuta el 1er hilo
         ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROGENCIERRE_GDC','En ejecucion..',nusession,sbuser);
          SELECT sys_context('userenv','db_name') INTO sbdatabase FROM dual;
           -- Validamos las empresas donde aplica la cartera por edad de cta de cobro
           nucontabd := 0;
           SELECT COUNT(1) INTO nucontabd
             FROM open.bases_datos_osf bs
            WHERE upper(trim(bs.basedatos)) = upper(trim(sbdatabase))
              AND bs.cartera                = upper(TRIM(dald_parameter.fsbGetValue_Chain('EDAD_MORA_MAXIMA_EDAD',NULL)));
           IF nucontabd > 0 THEN
             ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROCRESUMENSESUCIER','En ejecucion..',nusession,sbuser);
              ldc_procresumensesucier(nuccano,nuccmes,sbmensa,nuerror);
             ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_PROCRESUMENSESUCIER','Termino '||nuerror);
           ELSE
            ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROCRESUMENSESUCIEROTRO','En ejecucion..',nusession,sbuser);
              ldc_procresumensesucierotro(nuccano,nuccmes,sbmensa,nuerror);
             ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_PROCRESUMENSESUCIEROTRO','Termino '||nuerror);
           END IF;
            -- Informacion resumida d cartera x concepto tipo de producto y clasificador contable
             ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROCCARTCONCCIERRE_DB_GDC','en ejecucion..',nusession,sbuser);
              ldc_proccartconccierre_db_gdc(nuccano,nuccmes,sbmensa,nuerror);
             ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_PROCCARTCONCCIERRE_DB_GDC','Termino '||nuerror);
            -- Informacion resumida d cartera x concepto tipo de producto y clasificador contable
            ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROCCARTCONCCIERRE_DBOTGDC','en ejecucion..',nusession,sbuser);
              ldc_proccartconccierre_dbotgdc(nuccano,nuccmes,sbmensa,nuerror);
             ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_PROCCARTCONCCIERRE_DBOTGDC','Termino '||nuerror);
          -- Generamos informacion sincronizacion ctas brilla con gas
          ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROCSINCROCARTBRILLCI','En ejecucion..',nusession,sbuser);
           ldc_procsincrocartbrillci(nuccano,nuccmes,sbmensa,nuerror);
          ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_PROCSINCROCARTBRILLCI','Termino '||nuerror);
          -- Informacion indicador cartera por tipo de concepto
          ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROGENCARTTIPOCONC','en ejecucion..',nusession,sbuser);
           ldc_progencarttipoconc(nuccano,nuccmes,sbmensa,nuerror);
          ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_PROGENCARTTIPOCONC','Termino '||nuerror);
          -- Informacion indicador ecuacion de cartera
          ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROCLLENAECUACIONCARTERA','En ejecucion..',nusession,sbuser);
           ldc_procllenaecuacioncartera(nuccano,nuccmes,sbmensa,nuerror);
          ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_PROCLLENAECUACIONCARTERA','Termino '||to_char(nuerror));
          -- Informacion indicador cartera mayor a 90 dias x localidad
          ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROCCANTUSUAEDAMORLOC','En ejecucion..',nusession,sbuser);
           ldc_proccantusuaedamorloc(nuccano,nuccmes,sbmensa,nuerror);
          ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_PROCCANTUSUAEDAMORLOC','Termino '||to_char(nuerror));
          -- Termina proceso LDC_PROGENCIERRE_GDC
         ldc_proactualizaestaprog(nusession,'Ok','LDC_PROGENCIERRE_GDC','Termino ');
       END IF;
    END IF;
  END IF;
END;
/
