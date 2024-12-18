CREATE OR REPLACE PROCEDURE      ldc_llenadiferido(
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-08-22
  Descripcion : Generamos informacion de los diferidos a cierre

  Parametros Entrada
    nuano A?o
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        CASO  AUTOR   DESCRIPCION
2020-07-04      457   HORBATH SE MODIFICA PARA QUE MANEJE EL PROCESO POR 10 HILOS Y ADEMAS SE OPTIMICE EL
                              PROCESAMIENTO DE MANERA TAL QUE EL CALCULO DE LA PARTE DE DIFERIDO CORRIENTE Y
                              DIFERIDO NO CORRIENTE SEA CALCULADO DE MANERA INMEDIATA EN EL RECORRIDO DEL CURSOR
                              Y NO SEA CALCULADO CON UN CURSOR INTERNO QUE IMPLIQUE VOLVER A CONSULTAR LA TABLA DIFERIDO
                              DENTRO DEL RECORRIDO DE CADA UNO DE LOS DIFERIDOS
***************************************************************************/
                                              nupano IN NUMBER,
                                              nupmes IN NUMBER,
                                              sbmensa OUT VARCHAR2,
                                              error  OUT NUMBER
                                             ) IS
/*
CURSOR cu_diferidos IS
 SELECT difecodi,difesusc, difeconc, difevatd, difevacu, difecupa, difenucu, difesape, difenudo, difeinte, difeinac, difeusua, difeterm, difesign, difenuse, difemeca, difecoin, difeprog, difepldi, difefein, difefumo, difespre, difetain, difefagr, difecofi, difetire, difefunc, difelure, difeenre
   FROM diferido
  WHERE difesape > 0;
  */

nucontareg    NUMBER(15) DEFAULT 0;
nucantiregcom NUMBER(15) DEFAULT 0;
nucantiregtot NUMBER(15) DEFAULT 0;
nudifcor      ldc_osf_diferido.difecorr%TYPE;
nudifncor     ldc_osf_diferido.difencorr%TYPE;
dtfecha            date;
nujob number;
SW BOOLEAN;
nusession NUMBER;
sbuser VARCHAR2(30);
NNN NUMBER;
BEGIN
SELECT USERENV('SESSIONID'),USER INTO nusession,sbuser FROM dual;
ldc_proinsertaestaprog(nuPano,nuPmes,'LDC_LLENADIFERIDO','En ejecucion..',nusession,sbuser);
--xlogpno('LLENADIFERIDO: INICIA PROCESO ANO='||TO_CHAR(NUPANO)||' MES='||TO_CHAR(NUPMES)||' FECHA '||TO_CHAR(SYSDATE, 'YYY/MM/DD HH24:MI:SS')||' VA borrar de la tabla ldc_osf_diferido');
sbmensa := NULL;
error := 0;
nucantiregcom := 0;
nucantiregtot := 0;
nucontareg := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');


DELETE ldc_osf_diferido l WHERE l.difeano = nupano AND l.difemes = nupmes;
--xlogpno('LLENADIFERIDO: BORRA DE LDC_OSF_DIFERIDO');
COMMIT;
DELETE FROM LDCHILOSLLENADIFE;
--xlogpno('LLENADIFERIDO: BORRA TABLA DE HILOS');
insert into LDCHILOSLLENADIFE (hilo_,inicia,termina,observacion,estado,REGPROCS) values(1,sysdate,null,'CREAD0','C',0);
insert into LDCHILOSLLENADIFE (hilo_,inicia,termina,observacion,estado,REGPROCS) values(2,sysdate,null,'CREAD0','C',0);
insert into LDCHILOSLLENADIFE (hilo_,inicia,termina,observacion,estado,REGPROCS) values(3,sysdate,null,'CREAD0','C',0);
insert into LDCHILOSLLENADIFE (hilo_,inicia,termina,observacion,estado,REGPROCS) values(4,sysdate,null,'CREAD0','C',0);
insert into LDCHILOSLLENADIFE (hilo_,inicia,termina,observacion,estado,REGPROCS) values(5,sysdate,null,'CREAD0','C',0);
insert into LDCHILOSLLENADIFE (hilo_,inicia,termina,observacion,estado,REGPROCS) values(6,sysdate,null,'CREAD0','C',0);
insert into LDCHILOSLLENADIFE (hilo_,inicia,termina,observacion,estado,REGPROCS) values(7,sysdate,null,'CREAD0','C',0);
insert into LDCHILOSLLENADIFE (hilo_,inicia,termina,observacion,estado,REGPROCS) values(8,sysdate,null,'CREAD0','C',0);
insert into LDCHILOSLLENADIFE (hilo_,inicia,termina,observacion,estado,REGPROCS) values(9,sysdate,null,'CREAD0','C',0);
insert into LDCHILOSLLENADIFE (hilo_,inicia,termina,observacion,estado,REGPROCS) values(0,sysdate,null,'CREAD0','C',0);
--xlogpno('LLENADIFERIDO: INICIA TABLA DE HILOS');
COMMIT;
FOR I IN 0..9 LOOP
    dtFecha := sysdate;
  --  xlogpno('LLENADIFERIDO: VA A CORRER EL SIGUIENTE JOB '||'LDC_LLENADIFERIDOHILO('||    TO_CHAR(I)||','|| TO_CHAR(NUPANO) ||','||TO_CHAR(NUPMES) ||');');
    DBMS_JOB.SUBMIT ( nujob,'LDC_LLENADIFERIDOHILO(' ||TO_CHAR(I)||','|| TO_CHAR(NUPANO) ||','||TO_CHAR(NUPMES) ||');', DTFECHA);
    COMMIT;
END LOOP;
--xlogpno('LLENADIFERIDO: CREE JOBS A ESPERAR QUE TERMINEN');
SW:=TRUE;

-- ESPERA A QUE TERMINEN TODOS LOS JOBS QUE LLENAN LAS TEMPORALES EN PARALELO
WHILE SW LOOP
      SELECT COUNT(1) INTO NUJOB FROM LDCHILOSLLENADIFE WHERE ESTADO IN ('T','E');
      IF NUJOB=10 THEN
		 SW:=FALSE;
      END IF;
END LOOP;

--xlogpno('LLENADIFERIDO: TERMINARON LOS JOBS');
 /*
 FOR i IN cu_diferidos LOOP
     -- Dividimos la duda diferida en corriente y no corriente
     BEGIN
      SELECT ROUND(NVL(SUM(difcor),0),0),ROUND(NVL(SUM(difncor),0),0) INTO nudifcor,nudifncor
        FROM(
             SELECT round(decode(difesign, 'DB',SUM((difevacu - (difesape * (difeinte / 100))) * 12),-SUM((difevacu - (difesape * (difeinte / 100))) * 12)),0) difcor,
                   round(decode(difesign, 'DB', SUM(difesape - (difevacu - (difesape * (difeinte / 100))) * 12),-SUM(difesape - (difevacu - (difesape * (difeinte / 100))) * 12)),0) difncor
               FROM diferido
              WHERE difecodi = i.difecodi
                AND difesape > 0
                AND difenucu > difecupa
                AND difenucu - difecupa > 12
              GROUP BY difesign
            UNION
             SELECT round(decode(difesign,'DB',SUM(difesape),-SUM(difesape)),0) difcor,
                   SUM(0) difncor
               FROM diferido
              WHERE difecodi = i.difecodi
                AND difesape > 0
                AND difenucu > difecupa
                AND difenucu - difecupa <= 12
              GROUP BY difesign);
       EXCEPTION
        WHEN no_data_found THEN
         nudifcor := 0;
         nudifncor := 0;
       END;
   INSERT INTO ldc_osf_diferido
     (difeano, difemes, difecodi, difesusc, difeconc, difevatd, difevacu, difecupa, difenucu, difesape, difenudo, difeinte, difeinac, difeusua, difeterm, difesign, difenuse, difemeca, difecoin, difeprog, difepldi, difefein, difefumo, difespre, difetain, difefagr, difecofi, difetire, difefunc, difelure, difeenre,difecorr,difencorr)
   VALUES
     (nupano, nupmes, i.difecodi, i.difesusc, i.difeconc, i.difevatd, i.difevacu, i.difecupa, i.difenucu, i.difesape, i.difenudo, i.difeinte, i.difeinac, i.difeusua, i.difeterm, i.difesign, i.difenuse, i.difemeca, i.difecoin, i.difeprog, i.difepldi, i.difefein, i.difefumo, i.difespre, i.difetain, i.difefagr, i.difecofi, i.difetire, i.difefunc, i.difelure, i.difeenre,nudifcor,nudifncor);
        nucantiregcom := nucantiregcom + 1;
     IF nucantiregcom >= nucontareg THEN
        COMMIT;
        nucantiregtot := nucantiregtot + nucantiregcom;
        nucantiregcom := 0;
     END IF;
  END LOOP;

  */

  COMMIT;
--  nucantiregtot := nucantiregtot + nucantiregcom;

  SELECT COUNT(1) INTO NUJOB FROM LDCHILOSLLENADIFE WHERE ESTADO IN ('T');
  IF NUJOB=10 THEN
     SELECT SUM(REGPROCS) INTO NUCANTIREGTOT FROM LDCHILOSLLENADIFE;
     sbmensa := 'Proceso termino Ok : se procesaron '||nucantiregtot||' registros.';
     error := 0;
  ELSE
     sbmensa := 'Proceso termino con errores : se procesaron correctamente'|| nujob||' hilos de los 10. Hicieron falta '||to_char(10-nujob)||' hilos revisar el log en la tabla LDCHILOSLLENADIFE';
     error := 0;
  END IF;

  ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_LLENADIFERIDO','Termino '||error);
  COMMIT;
--END IF;
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_llenadiferido error code : '||TO_CHAR(SQLCODE)||' MENSAJE '||SQLERRM;
  error := -1;
END;
/
