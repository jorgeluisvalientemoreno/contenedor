CREATE OR REPLACE PROCEDURE      LDC_CIER_PROD_H11_TMP IS
/**************************************************************************
  Fecha       : 2015-09-25
  Descripcion : Cartera por producto Hilo2

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
	/* IF trunc(dtfecheject)>trunc(SYSDATE) THEN
	RETURN;
	ELSE
	-- Si es la hora del cierre
	IF to_date(nuhora,'hh24:mi')>=to_date(horaej,'hh24:mi') AND nvl(sbesta,'N')='N' THEN
	nucontacier := ldc_fncretornaprocejecierr(nuccano,nuccmes,'LDC_CIER_PROD_H1');
	IF nucontacier = 0 THEN*/
	SELECT USERENV('SESSIONID'),USER INTO nusession,sbuser FROM dual;
	-- Se ejecuta el 1er hilo
	ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_CIER_PROD_H11','En ejecucion..',nusession,sbuser);
    ldc_proccargdatsesu('LDC_OSF_SESUCIER_TMP11',sbmensa,nuerror);
	ldc_proactualizaestaprog(nusession,'Ok','LDC_CIER_PROD_H11','Termino ');
	-- Termina proceso ldc_progencierre
	ldc_proinsertaestaprog(nuccano,nuccmes,'ldc_actconcceroultplafi_tmp','En ejecucion..',nusession,sbuser);
	ldc_actconcceroultplafi_tmp('LDC_OSF_SESUCIER_TMP11',sbmensa,nuerror);
	ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'ldc_actconcceroultplafi_tmp','Termino '||nuerror);
	-- Guardamos los registros en la tabla ldc_osf_sesucier
	ldc_proinsertaestaprog(nuccano,nuccmes,'ldc_procactudatsesu','En ejecucion..',nusession,sbuser);
	ldc_procactudatsesu('LDC_OSF_SESUCIER_TMP11',sbmensa,nuerror);
	ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'ldc_procactudatsesu','Termino '||nuerror);

	-- END IF;
	--END IF;
	-- END IF;

END;
/