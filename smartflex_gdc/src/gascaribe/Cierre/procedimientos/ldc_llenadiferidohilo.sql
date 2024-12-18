CREATE OR REPLACE procedure LDC_LLENADIFERIDOHILO(hilo number,pano number,pmes number) is
/**************************************************************************
  Autor       : HORBATH
  Fecha       : 2020-07-16
  Descripcion : Generamos informacion de los diferidos a cierre

  Parametros Entrada
    HILO  hILO
    nuano A?o
    numes Mes


 HISTORIA DE MODIFICACIONES
   FECHA        CASO  AUTOR   DESCRIPCION
2020-07-04      457   HORBATH creacion
***************************************************************************/
dtfechejcier date;
cursor cu_diferidos IS
 SELECT difecodi,difesusc, difeconc, difevatd, difevacu, difecupa, difenucu, difesape, difenudo, difeinte, difeinac, difeusua, difeterm, difesign, difenuse, difemeca, difecoin, difeprog, difepldi, difefein, difefumo, difespre, difetain, difefagr, difecofi, difetire, difefunc, difelure, difeenre,
 case WHEN DIFENUCU-DIFECUPA<=12 THEN DIFESAPE*DECODE(DIFESIGN,'DB',1,-1) ELSE ROUND(DECODE(DIFESIGN,'DB',1,-1)*(difevacu - (difesape * (difeinte / 100))) * 12,0) END DC,
CASE WHEN DIFENUCU-DIFECUPA<=12 THEN 0 ELSE ROUND((difesape - (difevacu - (difesape * (difeinte / 100))) * 12)*DECODE(DIFESIGN,'DB',1,-1),0) END DNC
   FROM diferido
  WHERE difesape > 0 and mod(difecodi,10)=hilo and
        difefein<=dtfechejcier;
nucantiregcom NUMBER(15) DEFAULT 0;
nucantiregtot NUMBER(15) DEFAULT 0;
nucontareg    NUMBER(15) DEFAULT 0;
mssg varchar2(4000);
NUCORRMOVIDIFE NUMBER:=0;
begin
--xlogpno('LLENADIFERIDO: ENTRE A HILO '||TO_CHAR(HILO));
UPDATE LDCHILOSLLENADIFE SET INICIA=SYSDATE,OBSERVACION='En proceso', estado='P' WHERE HILO_=HILO;
COMMIT;
select cicoFECH into dtfechejcier from ldc_ciercome where cicoano=pano and cicomes=pmes;
nucantiregcom := 0;
nucantiregtot := 0;
nucontareg := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');
FOR i IN cu_diferidos LOOP

    -- AJUSTE VALIDO PARA PRUEBA II
	if i.difefein<dtfechejcier and i.difefumo>=dtfechejcier then
	   BEGIN
	     Select sum(decode(modisign,'CR',modivacu,'DB', -1*modivacu))
	       INTO NUCORRMOVIDIFE
		   from movidife where modidife=I.DIFECODI and
                Modifech>dtfechejcier;
       EXCEPTION
	     WHEN OTHERS THEN
		      NUCORRMOVIDIFE:=0;
	   END;
	   IF I.DIFESIGN='CR' then
	      NUCORRMOVIDIFE:=-1*NUCORRMOVIDIFE;
	   end if;
	end if;
	INSERT INTO ldc_osf_diferido
      (difeano, difemes, difecodi, difesusc, difeconc, difevatd, difevacu, difecupa, difenucu, difesape, difenudo, difeinte, difeinac, difeusua, difeterm, difesign, difenuse, difemeca, difecoin, difeprog, difepldi, difefein, difefumo, difespre, difetain, difefagr, difecofi, difetire, difefunc, difelure, difeenre,difecorr,difencorr)
    VALUES
     (pano, pmes, i.difecodi, i.difesusc, i.difeconc, i.difevatd, i.difevacu, i.difecupa, i.difenucu, i.difesape, i.difenudo, i.difeinte, i.difeinac, i.difeusua, i.difeterm, i.difesign, i.difenuse, i.difemeca, i.difecoin, i.difeprog, i.difepldi, i.difefein, i.difefumo, i.difespre, i.difetain, i.difefagr, i.difecofi, i.difetire, i.difefunc, i.difelure, i.difeenre,I.DC+NVL(NUCORRMOVIDIFE,0),I.DNC);
        nucantiregcom := nucantiregcom + 1;
    IF nucantiregcom >= nucontareg THEN
       UPDATE LDCHILOSLLENADIFE SET OBSERVACION='En proceso, van '||to_char(nucantiregtot + nucantiregcom)||' registros procesados.',  REGPROCS=nucantiregtot+nucantiregcom WHERE HILO_=HILO;
       COMMIT;
       nucantiregtot := nucantiregtot + nucantiregcom;
       nucantiregcom := 0;
    END IF;
	NUCORRMOVIDIFE:=0;
END LOOP;
COMMIT;
nucantiregtot := nucantiregtot + nucantiregcom;
UPDATE LDCHILOSLLENADIFE SET TERMINA=SYSDATE,OBSERVACION='Termino con exito', estado='T', REGPROCS=nucantiregtot WHERE HILO_=HILO;
COMMIT;
--xlogpno('LLENADIFERIDO: SALI DE HILO '||TO_CHAR(HILO));
EXCEPTION
    WHEN OTHERS THEN
	     mssg:=sqlerrm;
       --  xlogpno('LLENADIFERIDO: ERROR EN HILO '||TO_CHAR(HILO));
	     UPDATE LDCHILOSLLENADIFE SET TERMINA=SYSDATE,OBSERVACION='Termino con errores. '||SUBSTR(MSSG,1,500), estado='E' WHERE HILO_=HILO;
		 commit;
end;
/
