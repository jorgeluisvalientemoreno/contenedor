CREATE OR REPLACE PROCEDURE LDC_PROGENCIERRE_tmp IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-08-14
  Descripcion : Ejecutamos cierre cartera

  Parametros Entrada
    nuano Año
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

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

   nuccano := 2019;
   nuccmes := 9;
-- Obtenemos a?o, mes y hora del mes a cerrar
  SELECT USERENV('SESSIONID'),USER INTO nusession,sbuser FROM dual;

  ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_ACTCONCCEROULTPLAFI','En ejecucion..',nusession,sbuser);
  --ldc_actconcceroultplafi_tmp('LDC_OSF_SESUCIER_TMP',sbmensa,nuerror);
  ldc_actconcceroultplafi(nuccano,nuccmes,sbmensa,nuerror);
  ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_ACTCONCCEROULTPLAFI','Termino '||nuerror);
  -- Guardamos los registros en la tabla ldc_osf_sesucier
  ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROCCARGDATSESU','En ejecucion..',nusession,sbuser);
  ldc_proccargdatsesu('LDC_OSF_SESUCIER_TMP',sbmensa,nuerror);
  ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_PROCCARGDATSESU','Termino '||nuerror);

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
  ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROCCIERCARTREFINANC','En ejecucion..',nusession,sbuser);
  ldc_procciercartrefinanc(nuccano,nuccmes,pfecfin,sbmensa,nuerror);
  ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_PROCCIERCARTREFINANC','Termino '||nuerror);
  -- Termina proceso ldc_progencierre
  ldc_proactualizaestaprog(nusession,'Ok','LDC_PROGENCIERRE','Termino ');

END;
/
