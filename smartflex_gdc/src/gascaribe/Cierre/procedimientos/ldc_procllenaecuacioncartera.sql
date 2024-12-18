CREATE OR REPLACE PROCEDURE ldc_procllenaecuacioncartera(nupano NUMBER,nupmes NUMBER,sbmensa OUT VARCHAR2,nuerror OUT NUMBER) IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2015-01-21
  Descripcion : Generamos información de ecuacion de cartera a cierre

  Parametros Entrada
    nuano Año
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION
 ***************************************************************************/
 dtfeincierract      open.ldc_ciercome.cicofein%TYPE;
 dtfeficierreact     open.ldc_ciercome.cicofech%TYPE;
 err_fecha_per_conta EXCEPTION;
 error               NUMBER(3);
 sbmensaje           VARCHAR2(1000);
 nuconta             NUMBER(10) DEFAULT 0;
 nuanoant            NUMBER(4);
 numesant            NUMBER(2);
 nuvaano             NUMBER(4);
 nuvames             NUMBER(2);
BEGIN
 error := -1;
 sbmensa := NULL;
 nuerror := 0;
 -- Obtenemos periodo anterior al cierre actual
 error := -2;
 IF nupmes = 1 THEN
    nuanoant := nupano -1;
    numesant := 12;
    -- Insertamos registros de todo el año en curso
    FOR i IN 1..12 LOOP
     nuvaano := nupano;
     nuvames := i;
     INSERT INTO ldc_osf_ecuacart VALUES(nuvaano,nuvames,-1,-1,-1,1,0,0);
     INSERT INTO ldc_osf_ecuacart VALUES(nuvaano,nuvames,-1,-1,-1,11,0,0);
     INSERT INTO ldc_osf_ecuacart VALUES(nuvaano,nuvames,-1,-1,-1,16,0,0);
     INSERT INTO ldc_osf_ecuacart VALUES(nuvaano,nuvames,-1,-1,-1,23,0,0);
     INSERT INTO ldc_osf_ecuacart VALUES(nuvaano,nuvames,-1,-1,-1,40,0,0);
     INSERT INTO ldc_osf_ecuacart VALUES(nuvaano,nuvames,-1,-1,-1,44,0,0);
     INSERT INTO ldc_osf_ecuacart VALUES(nuvaano,nuvames,-1,-1,-1,46,0,0);
     INSERT INTO ldc_osf_ecuacart VALUES(nuvaano,nuvames,-1,-1,-1,56,0,0);
     INSERT INTO ldc_osf_ecuacart VALUES(nuvaano,nuvames,-1,-1,-1,-1,0,0);
     INSERT INTO ldc_osf_ecuacart VALUES(nuvaano,nuvames,-1,-1,-1,-3,0,0);
    END LOOP;
    COMMIT;
 ELSE
   nuanoant := nupano;
   numesant := nupmes - 1;
 END IF;
  -- Borramos datos tabla mes anterior
 error := -3;
 DELETE open.ldc_osf_ecuacart g WHERE g.nuano = nupano AND g.numes = nupmes;
 COMMIT;
  -- Registramos cartera causada y diferida cierre inmediatamente anterior
  error := -4;
  INSERT INTO ldc_osf_ecuacart
                              (
                         SELECT nupano
                               ,nupmes
                               ,tipo_producto
                               ,departamento
                               ,localidad
                               ,-1 AS tipo_movimiento
                               ,NVL(SUM(valor_causado),0) valor_causado
                               ,NVL(SUM(valor_diferido),0) AS diferido
                           FROM ldc_osf_cartconci c
                          WHERE c.nuano = nuanoant
                            AND c.numes = numesant
                          GROUP BY tipo_producto,departamento,localidad);
     COMMIT;
  error := -5;
 -- Periodo del cierre actual
  error := -6;
 BEGIN
  SELECT c.cicofein,c.cicofech INTO dtfeincierract,dtfeficierreact
    FROM open.ldc_ciercome c
   WHERE c.cicoano = nupano
     AND c.cicomes = nupmes;
  EXCEPTION
   WHEN no_data_found THEN
   sbmensaje := 'No existe configuracion en el comando LDCPECIER para el periodo contable actual : '||to_char(nupano)||' - '||to_char(nupmes);
   RAISE err_fecha_per_conta;
 END;

 -- Registramos movimientos diferido mes actual
  error := -7;
  INSERT INTO ldc_osf_ecuacart
                              (
                               SELECT nupano
                                     ,nupmes
                                     ,p.product_type_id tipo_producto
                                     ,l.geo_loca_father_id departamento
                                     ,l.geograp_location_id localidad
                                     ,-3 AS tipo_movimiento
                                     ,0 AS causado
                                     ,NVL(SUM(decode(m.modisign,'DB',m.modivacu,'CR',m.modivacu*-1)),0) valor
                                 FROM open.movidife m,open.pr_product p,open.ab_address d,open.ge_geogra_location l
                                WHERE m.modifech BETWEEN  dtfeincierract AND dtfeficierreact
                                  AND m.modinuse            = p.product_id
                                  AND p.address_id          = d.address_id
                                  AND d.geograp_location_id = l.geograp_location_id
                                GROUP BY p.product_type_id
                                         ,l.geo_loca_father_id
                                         ,l.geograp_location_id);
   COMMIT;
  -- Registramos cartera causada mes actual
   error := -8;
  INSERT INTO ldc_osf_ecuacart
                              (
                               SELECT
                                      nupano
                                     ,nupmes
                                     ,m.moviserv tipo_producto
                                     ,m.moviubg2 departamento
                                     ,m.moviubg3 localidad
                                     ,movitimo tipo_movimiento
                                     ,decode(movitimo,1,nvl(sum(decode(m.movisign,'D',movivalo,movivalo*-1)),0),11,nvl(sum(decode(m.movisign,'D',movivalo,movivalo*-1)),0)*-1,16,nvl(sum(decode(m.movisign,'D',movivalo,movivalo*-1)),0),23,nvl(sum(decode(m.movisign,'D',movivalo,movivalo*-1)),0)*-1,40,nvl(sum(decode(m.movisign,'D',movivalo,movivalo*-1)),0)*-1,nvl(sum(decode(m.movisign,'D',movivalo,movivalo*-1)),0)) valor
                                     ,0 AS valor_diferido
                                 FROM open.ic_movimien m
                                WHERE m.movifeco BETWEEN dtfeincierract AND dtfeficierreact
                                  AND m.movitido IN(71,72,73)
                                  AND m.movitimo IN(1,11,16,23,40,44,46,56)
                                  AND m.movicons = m.movicons
                                GROUP BY m.moviserv,m.moviubg2,m.moviubg3,movitimo);
  COMMIT;
 -- Contamos registros procesados
 nuconta := 0;
 SELECT COUNT(1) INTO nuconta
   FROM ldc_osf_ecuacart x
  WHERE x.nuano = nupano
    AND x.numes = nupmes;
 sbmensa := 'Proceso terminó OK. Se procesarón : '||to_char(nuconta)||' registros.';
 nuerror := 0;
EXCEPTION
 WHEN err_fecha_per_conta THEN
   ROLLBACK;
   sbmensa := sbmensaje;
   nuerror := -1;
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_procllenaecuacioncartera lineas error '||error||' '||sqlerrm;
  nuerror := -1;
END;
/
