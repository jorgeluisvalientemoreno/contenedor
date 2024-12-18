CREATE OR REPLACE PACKAGE adm_person.pkborradatoscierre IS

  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  18/06/2024   Adrianavg   OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
  
  PROCEDURE proborradatos(nuppano NUMBER,nuppmes NUMBER);
  PROCEDURE proborradatossesucier(nupano NUMBER,nupmes NUMBER);
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
END;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkborradatoscierre IS
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

***************************************************************************/
PROCEDURE proborradatos(nuppano NUMBER,nuppmes NUMBER) IS
BEGIN
proborradatosvarios(nuppano,nuppmes);
proborradatosrecaudo(nuppano,nuppmes);
proborradatosbrilla(nuppano,nuppmes);
proborradatossesucier(nuppano,nuppmes);
proborradatoscreg(nuppano,nuppmes);
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
-- Borradatos cierre planeacion
PROCEDURE proborradatosplane(nupano NUMBER,nupmes NUMBER) IS
BEGIN
proborradatossubc(nupano,nupmes);
proborradatosconc(nupano,nupmes);
proborradatosusuex(nupano,nupmes);
proborradatosb2(nupano,nupmes);
proborradatosb1(nupano,nupmes);
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
END PKBORRADATOSCIERRE;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre PKBORRADATOSCIERRE
BEGIN
    pkg_utilidades.prAplicarPermisos('PKBORRADATOSCIERRE', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS a REXEREPORTES sobre PKBORRADATOSCIERRE
GRANT EXECUTE ON ADM_PERSON.PKBORRADATOSCIERRE TO REXEREPORTES;
/