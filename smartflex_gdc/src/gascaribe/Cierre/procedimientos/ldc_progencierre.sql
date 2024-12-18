CREATE OR REPLACE PROCEDURE LDC_PROGENCIERRE IS
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
   11/10/2019   LJLB     CA 200 se quita proceso LDC_PROCCIERCARTREFINANC del cierre
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
nucontacier  NUMBER(3) DEFAULT 0;
nucontahil1  NUMBER(3) DEFAULT 0;
nucontahil2  NUMBER(3) DEFAULT 0;
nucontahil3  NUMBER(3) DEFAULT 0;
nucontahil4  NUMBER(3) DEFAULT 0;
nucontahil5  NUMBER(3) DEFAULT 0;
nucontahil6  NUMBER(3) DEFAULT 0;
nucontahil7  NUMBER(3) DEFAULT 0;
nucontahil8  NUMBER(3) DEFAULT 0;
nucontahil9  NUMBER(3) DEFAULT 0;
nucontahil10 NUMBER(3) DEFAULT 0;
nucontahil11 NUMBER(3) DEFAULT 0;
nucontahil12 NUMBER(3) DEFAULT 0;
dtfecheject DATE;
nunsali     NUMBER(1);
BEGIN
-- Obtenemos a?o, mes y hora del mes a cerrar
ldc_proretornafechavalcierr(nuccano,nuccmes,nuhora,pfecin,pfecfin,dtfecheject,horaej,sbesta,nunsali);
  IF trunc(dtfecheject)>trunc(SYSDATE) THEN
     RETURN;
  ELSE
   -- Si es la hora del cierre
    IF to_date(nuhora,'hh24:mi')>=to_date(horaej,'hh24:mi') AND nvl(sbesta,'N')='N' THEN
     nucontacier  := ldc_fncretornaprocejecierr(nuccano,nuccmes,'LDC_PROGENCIERRE');
     nucontahil1  := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H1');
     nucontahil2  := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H2');
     nucontahil3  := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H3');
     nucontahil4  := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H4');
     nucontahil5  := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H5');
     nucontahil6  := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H6');
     nucontahil7  := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H7');
     nucontahil8  := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H8');
     nucontahil9  := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H9');
     nucontahil10 := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H10');
     nucontahil11 := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H11');
     nucontahil12 := ldc_fncretornaprocejecierr2(nuccano,nuccmes,'LDC_CIER_PROD_H12');
       IF nucontacier = 0 AND nucontahil1 > 0 AND nucontahil2 > 0 AND nucontahil3 > 0 AND nucontahil4 > 0 AND nucontahil5 > 0 AND nucontahil6 > 0  AND nucontahil7 > 0 AND nucontahil8 > 0 AND nucontahil9 > 0 AND nucontahil10 > 0 AND nucontahil11 > 0 AND nucontahil12 > 0 THEN
        SELECT USERENV('SESSIONID'),USER INTO nusession,sbuser FROM dual;
        -- Se ejecuta el 1er hilo
         ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROGENCIERRE','En ejecucion..',nusession,sbuser);
         -- Cartera resumida a cierre
          ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROCRESUMENSESUCIER','En ejecucion..',nusession,sbuser);
           ldc_procresumensesucier(nuccano,nuccmes,sbmensa,nuerror);
          ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_PROCRESUMENSESUCIER','Termino '||nuerror);
           -- Informacion resumida d cartera x concepto tipo de producto y clasificador contable
          ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROCCARTCONCCIERRE_DB','en ejecucion..',nusession,sbuser);
           ldc_proccartconccierre_db(nuccano,nuccmes,sbmensa,nuerror);
          ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_PROCCARTCONCCIERRE_DB','Termino '||nuerror);
          -- Generamos la cartera castigada por concepto
          ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_CARTCASTIGADA_CIERRE','En ejecucion..',nusession,sbuser);
           ldc_cartcastigada_cierre(nuccano,nuccmes,nuerror,sbmensa);
          ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_CARTCASTIGADA_CIERRE','Termino '||nuerror);
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
          -- Generamos la cartera refinanciada por concepto
         -- ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROCCIERCARTREFINANC','En ejecucion..',nusession,sbuser);
         --  ldc_pkg_calc_gest_cartera.ldc_procliquidacion(nuccano,nuccmes);
         -- ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_PROCCIERCARTREFINANC','Termino '||nuerror);
          -- Generamos la cartera refinanciada por concepto
          /*TICKET 200 LJLB --se quita proceso del cierre
          ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROCCIERCARTREFINANC','En ejecucion..',nusession,sbuser);
           ldc_procciercartrefinanc(nuccano,nuccmes,pfecfin,sbmensa,nuerror);
          ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_PROCCIERCARTREFINANC','Termino '||nuerror);*/
           -- Termina proceso ldc_progencierre
         ldc_proactualizaestaprog(nusession,'Ok','LDC_PROGENCIERRE','Termino ');
       END IF;
    END IF;
  END IF;
END;
/
