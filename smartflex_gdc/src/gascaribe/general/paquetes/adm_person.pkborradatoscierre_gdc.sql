CREATE OR REPLACE PACKAGE adm_person.pkborradatoscierre_gdc IS

  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  18/06/2024   Adrianavg   OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
  PROCEDURE proborradatos(nuppano NUMBER,nuppmes NUMBER);
  PROCEDURE proborradatossesucier(nupano NUMBER,nupmes NUMBER);
  PROCEDURE proborradatosotroscart(nupano NUMBER,nupmes NUMBER);
  PROCEDURE proborradatosproccart(nupano NUMBER,nupmes NUMBER);
  PROCEDURE proborradatosbrilla(nupano NUMBER,nupmes NUMBER);
  PROCEDURE proborradatosrecaudo(nupano NUMBER,nupmes NUMBER);
  PROCEDURE proborradatosvarios(nupano NUMBER,nupmes NUMBER);
  PROCEDURE proborradatoscreg(nupano NUMBER,nupmes NUMBER);
  PROCEDURE proborradatosplane(nupano NUMBER,nupmes NUMBER);
  PROCEDURE proborradatosb1(nupano NUMBER,nupmes NUMBER);
  PROCEDURE proborradatosb2(nupano NUMBER,nupmes NUMBER);
  PROCEDURE proborradatossubc(nupano NUMBER,nupmes NUMBER);
  PROCEDURE proborradatosconc(nupano NUMBER,nupmes NUMBER);
  PROCEDURE proborradatosusuex(nupano NUMBER,nupmes NUMBER);
  PROCEDURE ldc_actdatosciercome(nuanoac NUMBER,numesact NUMBER,nuanosig NUMBER,numessig NUMBER,dthoejec DATE);
  PROCEDURE ldc_proreversatodocierre(nuaact NUMBER,numac NUMBER,nuasi NUMBER,numsi NUMBER,dtphoej DATE);
  PROCEDURE prborradiferido(nuano number, numes number, innuTotHilos number, innuNroHilo number);
  PROCEDURE prGeneraHiloDife(nuano number, numes number);
END;
/
CREATE OR REPLACE PACKAGE BODY adm_person.PKBORRADATOSCIERRE_GDC IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2014-02-13
  Descripcion : Borra datos del cierre cuando se requiere reversar
  Parametros Entrada
    nuano A?o
    numes Mes

HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION
   24/05/2024   JSOTO   OSF-2749 Se borra procedimiento proborradatoscartcast que hacia llamado a la tabla LDC_OSF_CASTCONC ya que será borrada
                        Se elimina llamado a la tabla LDC_OSF_INDICA_CARTE ya que esta será borrada.
***************************************************************************/
PROCEDURE proborradatosproccart(nupano NUMBER,nupmes NUMBER) IS
BEGIN
 proborradatosotroscart(nupano,nupmes);
 proborradatossesucier(nupano,nupmes);
END;
PROCEDURE proborradatos(nuppano NUMBER,nuppmes NUMBER) IS
 nusession   NUMBER;
 sbuser      VARCHAR2(30);
 sbmensa     VARCHAR2(1000);
 nuerror     NUMBER(1);
BEGIN
 SELECT USERENV('SESSIONID'),USER INTO nusession,sbuser FROM dual;
 -- Varios
  ldc_proinsertaestaprog(nuppano,nuppmes,'PROBORRADATOSVARIOS','En ejecucion..',nusession,sbuser);
   BEGIN
    proborradatosvarios(nuppano,nuppmes);
    sbmensa := 'Proceso termin? de manera satisfactoria.';
    nuerror := 0;
   EXCEPTION
    WHEN OTHERS THEN
     sbmensa := ' Error en : PROBORRADATOSVARIOS '||SQLERRM;
     nuerror := -1;
   END;
  ldc_proactualizaestaprog(nusession,sbmensa,'PROBORRADATOSVARIOS','Termino '||to_char(nuerror));
  -- Recaudo
    ldc_proinsertaestaprog(nuppano,nuppmes,'PROBORRADATOSRECAUDO','En ejecucion..',nusession,sbuser);
   BEGIN
    proborradatosrecaudo(nuppano,nuppmes);
    sbmensa := 'Proceso termin? de manera satisfactoria.';
    nuerror := 0;
   EXCEPTION
    WHEN OTHERS THEN
     sbmensa := ' Error en : PROBORRADATOSRECAUDO '||SQLERRM;
     nuerror := -1;
   END;
  ldc_proactualizaestaprog(nusession,sbmensa,'PROBORRADATOSRECAUDO','Termino '||to_char(nuerror));
 -- Brilla
    ldc_proinsertaestaprog(nuppano,nuppmes,'PROBORRADATOSBRILLA','En ejecucion..',nusession,sbuser);
   BEGIN
    proborradatosbrilla(nuppano,nuppmes);
    sbmensa := 'Proceso termin? de manera satisfactoria.';
    nuerror := 0;
   EXCEPTION
    WHEN OTHERS THEN
     sbmensa := ' Error en : PROBORRADATOSBRILLA '||SQLERRM;
     nuerror := -1;
   END;
  ldc_proactualizaestaprog(nusession,sbmensa,'PROBORRADATOSBRILLA','Termino '||to_char(nuerror));
 -- Cartera
  ldc_proinsertaestaprog(nuppano,nuppmes,'PROBORRADATOSPROCCART','En ejecucion..',nusession,sbuser);
   BEGIN
    proborradatosproccart(nuppano,nuppmes);
    sbmensa := 'Proceso termin? de manera satisfactoria.';
    nuerror := 0;
   EXCEPTION
    WHEN OTHERS THEN
     sbmensa := ' Error en : PROBORRADATOSPROCCART '||SQLERRM;
     nuerror := -1;
   END;
  ldc_proactualizaestaprog(nusession,sbmensa,'PROBORRADATOSPROCCART','Termino '||to_char(nuerror));
 -- Creg
 ldc_proinsertaestaprog(nuppano,nuppmes,'PROBORRADATOSCREG','En ejecucion..',nusession,sbuser);
   BEGIN
    proborradatoscreg(nuppano,nuppmes);
    sbmensa := 'Proceso termin? de manera satisfactoria.';
    nuerror := 0;
   EXCEPTION
    WHEN OTHERS THEN
     sbmensa := ' Error en : PROBORRADATOSCREG '||SQLERRM;
     nuerror := -1;
   END;
 ldc_proactualizaestaprog(nusession,sbmensa,'PROBORRADATOSCREG','Termino '||to_char(nuerror));
 -- Borramos datos de la tabla ldc_osf_estaproc para el dia del cierre comercial
 ldc_proinsertaestaprog(nuppano,nuppmes,'LDC_OSF_ESTAPROC','En ejecucion..',nusession,sbuser);
  DELETE
    FROM ldc_osf_estaproc
   WHERE ano = nuppano
     AND mes = nuppmes
     AND TRIM(proceso) IN(
                          SELECT TRIM(l.proceso)
                            FROM ldc_procesos_cierre l
                           WHERE l.flag = 'C');
  COMMIT;
   ldc_proactualizaestaprog(nusession,sbmensa,'LDC_OSF_ESTAPROC','Termino '||to_char(nuerror));
END proborradatos;
-- Borramos los datos de la tabla sesucier
PROCEDURE proborradatossesucier(nupano NUMBER,nupmes NUMBER) IS
 CURSOR cudatosss(nucano NUMBER,nucmes NUMBER) IS
  SELECT ss.nuano ano,ss.numes mes,ss.producto producto
    FROM open.ldc_osf_sesucier ss
   WHERE nuano = nucano
     AND numes = nucmes;
nuconta NUMBER DEFAULT 0;
BEGIN
 nuconta := 0;
 FOR i IN cudatosss(nupano,nupmes) LOOP
  DELETE open.ldc_osf_sesucier kl
   WHERE kl.nuano = i.ano
     AND kl.numes = i.mes
     AND kl.producto = i.producto;
     nuconta := nuconta + 1;
   IF nuconta >= 5000 THEN
     COMMIT;
     nuconta := 0;
    END IF;
 END LOOP;
 COMMIT;
END proborradatossesucier;
-- Borramos datos resto proceso de cartera
PROCEDURE proborradatosotroscart(nupano NUMBER,nupmes NUMBER) IS
BEGIN
DELETE total_cart_mes                     WHERE nuano   = nupano AND numes = nupmes;
COMMIT;
DELETE ldc_osf_cartconci l                WHERE l.nuano = nupano AND l.numes = nupmes;
COMMIT;
DELETE open.ldc_osf_sin_ctas_bril y       WHERE y.nuano = nupano AND y.numes = nupmes;
COMMIT;
DELETE open.ldc_osf_cartticonc h          WHERE h.nuano = nupano AND h.numes = nupmes;
COMMIT;
DELETE open.ldc_osf_ecuacart g            WHERE g.nuano = nupano AND g.numes = nupmes;
COMMIT;
DELETE open.ldc_usuarios_loca_edad_mora g WHERE g.nuano = nupano AND g.numes = nupmes;
COMMIT;
END;
-- Borramos los datos de brilla
PROCEDURE proborradatosbrilla(nupano NUMBER,nupmes NUMBER) IS
 CURSOR cudatosss(nucano NUMBER,nucmes NUMBER) IS
  SELECT ss.ano ano,ss.mes mes,ss.producto producto
    FROM open.ldc_osf_ventas_brilla ss
   WHERE ano = nucano
     AND mes = nucmes;
BEGIN
 FOR i IN cudatosss(nupano,nupmes) LOOP
  DELETE open.ldc_osf_ventas_brilla kl
   WHERE kl.ano = i.ano
     AND kl.mes = i.mes
     AND kl.producto = i.producto;
    COMMIT;
 END LOOP;
 DELETE ldc_osf_estad_ventas_brilla jk WHERE jk.ano = nupano AND jk.mes = nupmes;
 COMMIT;
END proborradatosbrilla;
-- Borramos datos recaudo
PROCEDURE proborradatosrecaudo(nupano NUMBER,nupmes NUMBER) IS
BEGIN
 DELETE ldc_osf_cier_reca jk WHERE jk.ano = nupano AND jk.mes = nupmes;
 COMMIT;
-- DELETE ldc_osf_datosreccup kl WHERE kl.ano = nupano;
-- COMMIT;
 DELETE ldc_osf_cier_part_conci kk WHERE kk.ano = nupano AND kk.mes = nupmes;
 COMMIT;
END proborradatosrecaudo;
-- Borramos datos varios
PROCEDURE proborradatosvarios(nupano NUMBER,nupmes NUMBER) IS
BEGIN
 DELETE open.ldc_osf_salbitemp sb WHERE sb.nuano = nupano AND sb.numes = nupmes;
 COMMIT;
 DELETE open.ldc_osf_diferido sc WHERE sc.difeano = nupano AND sc.difemes = nupmes;
 COMMIT;
 DELETE open.ldc_osf_contrato sd WHERE sd.nuano = nupano AND sd.numes = nupmes;
 COMMIT;
 DELETE open.ldc_osf_salcuini sh WHERE sh.ano = nupano AND sh.mes = nupmes;
 COMMIT;
END proborradatosvarios;
-- Borramos datos CREG
PROCEDURE proborradatoscreg(nupano NUMBER,nupmes NUMBER) IS
  CURSOR cudatoscreg(nuccano NUMBER,nuccmes NUMBER) IS
   SELECT dc.anioperifac ano,dc.mesperifac mes,dc.idproducto prod
     FROM open.ldc_snapshotcreg dc
    WHERE dc.anioperifac = nuccano
      AND dc.mesperifac = nuccmes;
nuconta NUMBER DEFAULT 0;
BEGIN
 nuconta := 0;
 FOR i IN cudatoscreg(nupano,nupmes) LOOP
  DELETE open.ldc_snapshotcreg fg
   WHERE fg.anioperifac = i.ano
     AND fg.mesperifac  = i.mes
     AND fg.idproducto  = i.prod;
  nuconta := nuconta + 1;
  IF nuconta >= 5000 THEN
    COMMIT;
    nuconta := 0;
  END IF;
 END LOOP;
 COMMIT;
END proborradatoscreg;
-- Borradatos cierre planeaci?n
PROCEDURE proborradatosplane(nupano NUMBER,nupmes NUMBER) IS
 nusession   NUMBER;
 sbuser      VARCHAR2(30);
 sbmensa     VARCHAR2(1000);
 nuerror     NUMBER(1);
BEGIN
 SELECT USERENV('SESSIONID'),USER INTO nusession,sbuser FROM dual;
 -- Subsidio
  ldc_proinsertaestaprog(nupano,nupmes,'PROBORRADATOSSUBC','En ejecucion..',nusession,sbuser);
   BEGIN
    proborradatossubc(nupano,nupmes);
    sbmensa := 'Proceso termin? de manera satisfactoria.';
    nuerror := 0;
   EXCEPTION
    WHEN OTHERS THEN
     sbmensa := ' Error en : PROBORRADATOSSUBC '||SQLERRM;
     nuerror := -1;
   END;
  ldc_proactualizaestaprog(nusession,sbmensa,'PROBORRADATOSSUBC','Termino '||to_char(nuerror));
  -- Contribucion
    ldc_proinsertaestaprog(nupano,nupmes,'PROBORRADATOSCONC','En ejecucion..',nusession,sbuser);
   BEGIN
    proborradatosconc(nupano,nupmes);
    sbmensa := 'Proceso termin? de manera satisfactoria.';
    nuerror := 0;
   EXCEPTION
    WHEN OTHERS THEN
     sbmensa := ' Error en : PROBORRADATOSCONC '||SQLERRM;
     nuerror := -1;
   END;
  ldc_proactualizaestaprog(nusession,sbmensa,'PROBORRADATOSCONC','Termino '||to_char(nuerror));
 -- Usuario excento
    ldc_proinsertaestaprog(nupano,nupmes,'PROBORRADATOSUSUEX','En ejecucion..',nusession,sbuser);
   BEGIN
    proborradatosusuex(nupano,nupmes);
    sbmensa := 'Proceso termin? de manera satisfactoria.';
    nuerror := 0;
   EXCEPTION
    WHEN OTHERS THEN
     sbmensa := ' Error en : PROBORRADATOSUSUEX '||SQLERRM;
     nuerror := -1;
   END;
  ldc_proactualizaestaprog(nusession,sbmensa,'PROBORRADATOSUSUEX','Termino '||to_char(nuerror));
 -- B2
   ldc_proinsertaestaprog(nupano,nupmes,'PROBORRADATOSB2','En ejecucion..',nusession,sbuser);
   BEGIN
    proborradatosb2(nupano,nupmes);
    sbmensa := 'Proceso termin? de manera satisfactoria.';
    nuerror := 0;
   EXCEPTION
    WHEN OTHERS THEN
     sbmensa := ' Error en : PROBORRADATOSB2 '||SQLERRM;
     nuerror := -1;
   END;
  ldc_proactualizaestaprog(nusession,sbmensa,'PROBORRADATOSB2','Termino '||to_char(nuerror));
  -- B1
   ldc_proinsertaestaprog(nupano,nupmes,'PROBORRADATOSB1','En ejecucion..',nusession,sbuser);
   BEGIN
    proborradatosb1(nupano,nupmes);
    sbmensa := 'Proceso termin? de manera satisfactoria.';
    nuerror := 0;
   EXCEPTION
    WHEN OTHERS THEN
     sbmensa := ' Error en : PROBORRADATOSB1 '||SQLERRM;
     nuerror := -1;
   END;
  ldc_proactualizaestaprog(nusession,sbmensa,'PROBORRADATOSB1','Termino '||to_char(nuerror));
  -- Borramos datos de la tabla ldc_osf_estaproc para el dia del cierre comercial  planeacion
 ldc_proinsertaestaprog(nupano,nupmes,'PLANE LDC_OSF_ESTAPROC','En ejecucion..',nusession,sbuser);
  DELETE
    FROM ldc_osf_estaproc
   WHERE ano = nupano
     AND mes = nupmes
     AND TRIM(proceso) IN(
                          SELECT TRIM(l.proceso)
                            FROM ldc_procesos_cierre l
                           WHERE l.flag = 'P');
  COMMIT;
   ldc_proactualizaestaprog(nusession,sbmensa,'PLANE LDC_OSF_ESTAPROC','Termino '||to_char(nuerror));
END proborradatosplane;
-- Borra datos b1
PROCEDURE proborradatosb1(nupano NUMBER,nupmes NUMBER) IS

BEGIN
  NULL;
END proborradatosb1;
-- Borra datos b2
PROCEDURE proborradatosb2(nupano NUMBER,nupmes NUMBER) IS
BEGIN
  NULL;
END proborradatosb2;
-- Borra datos subsidio cierre
PROCEDURE proborradatossubc(nupano NUMBER,nupmes NUMBER) IS
BEGIN
 DELETE open.ldc_osf_subsidio n WHERE n.anofact = nupano AND n.mesfact = nupmes;
 COMMIT;
END proborradatossubc;
-- Borra datos Contribucion cierre
PROCEDURE proborradatosconc(nupano NUMBER,nupmes NUMBER) IS
BEGIN
 DELETE open.ldc_osf_contribucion n WHERE n.anofact = nupano AND n.mesfact = nupmes;
 COMMIT;
END;
-- Borra datos Usuario Exento cierre
PROCEDURE proborradatosusuex(nupano NUMBER,nupmes NUMBER) IS
BEGIN
 DELETE open.ldc_usuexentos t WHERE t.ano = nupano AND t.mes = nupmes;
 COMMIT;
END proborradatosusuex;
PROCEDURE ldc_actdatosciercome(nuanoac NUMBER,numesact NUMBER,nuanosig NUMBER,numessig NUMBER,dthoejec DATE) IS
 sbaltera VARCHAR2(1000);
BEGIN
  sbaltera := 'ALTER TRIGGER LDCTRG_LDCCIERCOME DISABLE';
  EXECUTE IMMEDIATE TRIM(sbaltera);
  DELETE ldc_ciercome l WHERE l.cicoano = nuanosig AND l.cicomes = numessig;
  COMMIT;
  UPDATE ldc_ciercome l SET l.cicoesta = 'N',l.cicohoej = dthoejec WHERE l.cicoano = nuanoac AND l.cicomes = numesact;
  COMMIT;
  sbaltera := 'ALTER TRIGGER LDCTRG_LDCCIERCOME ENABLE';
  EXECUTE IMMEDIATE TRIM(sbaltera);
END;
PROCEDURE ldc_proreversatodocierre(nuaact NUMBER,numac NUMBER,nuasi NUMBER,numsi NUMBER,dtphoej DATE) IS
BEGIN
 ldc_actdatosciercome(nuaact,numac,nuasi,numsi,dtphoej);
 proborradatos(nuaact,numac);
 proborradatosplane(nuaact,numac);
END;
PROCEDURE ldc_proccambfechfincierhojcir(nuaact NUMBER,numac NUMBER,dtfechfin DATE DEFAULT NULL,dtphoej DATE) IS
BEGIN
 IF dtfechfin IS NOT NULL THEN
  UPDATE ldc_ciercome l
     SET l.cicofech = dtfechfin
        ,l.cicohoej = dtphoej
   WHERE l.cicoano  = nuaact
     AND l.cicomes  = numac;
 ELSE
  UPDATE ldc_ciercome l
     SET l.cicohoej = dtphoej
   WHERE l.cicoano  = nuaact
     AND l.cicomes  = numac;
 END IF;
 COMMIT;
END;

 PROCEDURE prborradiferido(nuano number, numes number, innuTotHilos number, innuNroHilo number) is
   cursor cudiferido is
  SELECT I.ROWID FILA
    from ldc_osf_diferido i
   where DIFEANO = nuano
    and DIFEMES = numes
   and  mod(difenuse, innuTotHilos) + 1 = innuNroHilo;

   TYPE tbdiferido IS TABLE OF cudiferido%ROWTYPE  ;
    v_tbdiferido tbdiferido;

  nuparano   NUMBER;
  nuparmes   NUMBER;
  nutsess    NUMBER;
  sbparuser  VARCHAR2(4000);
  osberror   VARCHAR2(4000);
   nulei number := 0;
  nuact number := 0;
  nuerr number := 0;

 begin

   SELECT  to_number(to_char(SYSDATE,'YYYY')),
                to_number(to_char(SYSDATE,'MM')),
                userenv('SESSIONID'),
                USER
   INTO nuparano,nuparmes,nutsess,sbparuser
   FROM dual;
   ldc_proinsertaestaprog(nuparano,nuparmes,'PRBORRADIFERIDO','En ejecucion',nutsess,sbparuser);

  OPEN cudiferido;
  LOOP
   FETCH cudiferido BULK COLLECT INTO v_tbdiferido LIMIT 1000;
     for rg in 1..v_tbdiferido.count loop
       nulei := nulei + 1;
        begin
        savepoint errorupdate;
        delete from ldc_osf_diferido i WHERE ROWID=v_tbdiferido(RG).FILA;
        nuact := nuact + 1;

       exception when others then
          nuerr := nuerr + 1;
          ROLLBACK TO errorupdate;
      end;

     end loop;
     commit;
       ldc_proactualizaestaprog(nutsess,' Van leidos ' || nulei || ' Eliminados ' || nuact || ' Con Error ' || nuerr,'PRBORRADIFERIDO','En Ejecucion');

     EXIT WHEN cudiferido%NOTFOUND;
      END LOOP;
    close cudiferido;
   commit;
   ldc_proactualizaestaprog(nutsess,' Leidos ' || nulei || ' Eliminados ' || nuact || ' Con Error ' || nuerr,'PRBORRADIFERIDO','Ok.');
 exception
 when others then
  rollback;
  errors.seterror;
  errors.geterror(nuerr, osberror);
  ldc_proactualizaestaprog(nutsess,'Error General: ' ||  osberror  ||
                                 '. Se leyeron ' || nulei || ' Eliminados ' || nuact || ' con Error ' || nuerr ,'PRBORRADIFERIDO','Error ');

 end prborradiferido;

 PROCEDURE prGeneraHiloDife(nuano number, numes number) is
    nuCantHilos number := 10;
    nujob number;
    DTFECHA date;
    nuerror NUMBER;
    sbError VARCHAR2(4000);
    nuparano   NUMBER;
    nuparmes   NUMBER;
    nutsess    NUMBER;
    sbparuser  VARCHAR2(4000);
    sbWhat VARCHAR2(4000);
    SW BOOLEAN :=TRUE;
 begin

  SELECT  to_number(to_char(SYSDATE,'YYYY')),
                to_number(to_char(SYSDATE,'MM')),
                userenv('SESSIONID'),
                USER
   INTO nuparano,nuparmes,nutsess,sbparuser
   FROM dual;
   ldc_proinsertaestaprog(nuparano,nuparmes,'PRGENERAHILODIFE','En ejecucion',nutsess,sbparuser);
  -- se crean los jobs y se ejecutan
    for rgJob in 1 .. nuCantHilos loop
        DTFECHA := sysdate + 1 / 3600;
        sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
                  chr(10) || '   pkborradatoscierre_gdc.prborradiferido( '||nuano||','||NUMES||','|| nuCantHilos || ',' ||
                  chr(10) || rgJob|| ');' ||
                  chr(10) || 'END;';
        dbms_job.submit(nujob, sbWhat,DTFECHA ); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;
        insert into tmphilocargdif(nujob, fecha) values (nujob, DTFECHA);
    end loop;

    dbms_lock.sleep(5);

   -- ESPERA A QUE TERMINEN TODOS LOS JOBS QUE LLENAN LAS TEMPORALES EN PARALELO
    WHILE SW LOOP
       -- SELECT COUNT(1) INTO NUJOB FROM dba_ WHERE ESTADO IN ('T','E');
        select count(*) INTO NUJOB
        from DBA_JOBS_RUNNING_rac, tmphilocargdif
        where job = nujob;
        IF NUJOB=0 THEN
         SW:=FALSE;
        END IF;
    END LOOP;
     ldc_proactualizaestaprog(nutsess, 'Termino','PRGENERAHILODIFE','Ok.');
 exception
 when others then
  rollback;
  errors.seterror;
  errors.geterror(nuerror, sbError);
  ldc_proactualizaestaprog(nutsess,'Termino'||sbError ,'PRBORRADIFERIDO','Error ');

 end prGeneraHiloDife;

END;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre PKBORRADATOSCIERRE_GDC
BEGIN
    pkg_utilidades.prAplicarPermisos('PKBORRADATOSCIERRE_GDC', 'ADM_PERSON'); 
END;
/