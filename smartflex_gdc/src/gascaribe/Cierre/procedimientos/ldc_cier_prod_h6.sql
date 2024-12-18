CREATE OR REPLACE PROCEDURE      LDC_CIER_PROD_H6 IS
/**************************************************************************
  Fecha       : 2015-09-25
  Descripcion : Cartera por producto Hilo6

  Parametros Entrada
    nuano A?o
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
nucontacier NUMBER(3) DEFAULT 0;
dtfecheject DATE;
nunsali     NUMBER(1);
sbtable     VARCHAR2(1000);
BEGIN
-- Obtenemos a?o, mes y hora del mes a cerrar
ldc_proretornafechavalcierr(nuccano,nuccmes,nuhora,pfecin,pfecfin,dtfecheject,horaej,sbesta,nunsali);
  IF trunc(dtfecheject)>trunc(SYSDATE) THEN
     RETURN;
  ELSE
   -- Si es la hora del cierre
    IF to_date(nuhora,'hh24:mi')>=to_date(horaej,'hh24:mi') AND nvl(sbesta,'N')='N' THEN
     nucontacier := ldc_fncretornaprocejecierr(nuccano,nuccmes,'LDC_CIER_PROD_H6');
       IF nucontacier = 0 THEN
        SELECT USERENV('SESSIONID'),USER INTO nusession,sbuser FROM dual;
        -- Se ejecuta el 6to hilo
         ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_CIER_PROD_H6','En ejecucion..',nusession,sbuser);
          -- Generamos estado cuenta del usuario
          ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_LLENASESUCIER_H6','En ejecucion..',nusession,sbuser);
           sbtable := 'TRUNCATE TABLE LDC_OSF_SESUCIER_TMP6';
           EXECUTE IMMEDIATE sbtable;
           ldc_llenasesucier_h6(nuccano,nuccmes,sbmensa,nuerror);
          ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_LLENASESUCIER_H6','Termino '||nuerror);
          -- Termina proceso ldc_progencierre
         ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_ACTCONCCEROULTPLAFI6','En ejecucion..',nusession,sbuser);
           ldc_actconcceroultplafi6(nuccano,nuccmes,sbmensa,nuerror);
          ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_ACTCONCCEROULTPLAFI6','Termino '||nuerror);
          -- Guardamos los registros en la tabla ldc_osf_sesucier
          ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROCCARGDATSESU-6','En ejecucion..',nusession,sbuser);
           ldc_proccargdatsesu('LDC_OSF_SESUCIER_TMP6',sbmensa,nuerror);
          ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_PROCCARGDATSESU-6','Termino '||nuerror);
         ldc_proactualizaestaprog(nusession,'Ok','LDC_CIER_PROD_H6','Termino ');
       END IF;
    END IF;
  END IF;
END;
/
