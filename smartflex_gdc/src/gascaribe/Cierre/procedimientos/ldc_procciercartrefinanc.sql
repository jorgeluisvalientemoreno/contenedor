CREATE OR REPLACE PROCEDURE      ldc_procciercartrefinanc(nupaano NUMBER,nupames NUMBER,dtpafechcier DATE,sbpmensa OUT VARCHAR2,nuperror OUT NUMBER) IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2016-03-28
  Descripcion : Generamos informacion de la cartera refinanciada a cierre

  Parametros Entrada
    nuano A?o
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/
 CURSOR cudiferefinan(nupacuano NUMBER,nupacumes NUMBER) IS
  SELECT difecodi,difenuse,difesusc,difeconc,difesape,(SELECT suscclie FROM open.suscripc WHERE susccodi = difesusc) difcliente
    FROM open.ldc_osf_diferido
   WHERE difeano = nupacuano
     AND difemes = nupacumes
     AND difeprog = 'GCNED';

dtfechacierre  DATE;
dosocapital    VARCHAR2(200);
dosointeres    VARCHAR2(200);
nucapidiferefi open.cargos.cargvalo%TYPE DEFAULT 0;
nuintediferefi open.cargos.cargvalo%TYPE DEFAULT 0;
nuconta        NUMBER(10) DEFAULT 0;
nuconta2       NUMBER(10) DEFAULT 0;
nuvdepa        open.ge_geogra_location.geo_loca_father_id%TYPE;
nuvloca        open.ge_geogra_location.geograp_location_id%TYPE;
nutipprod      pr_product.product_type_id%TYPE;
BEGIN
 nuconta  := 0;
 nuconta2 := 0;
 dtfechacierre := dtpafechcier;

 -- Borramos los registros
 DELETE ldc_osf_cartreficier f WHERE f.nuano = nupaano AND f.numes = nupames;
 COMMIT;

 FOR i IN cudiferefinan(nupaano,nupames) LOOP
  dosocapital := 'DF-'||i.difecodi;
  dosocapital := TRIM(dosocapital);
  dosointeres := 'ID-'||i.difecodi;
  dosointeres := TRIM(dosointeres);

  -- Obtenemos el facturado
  nucapidiferefi := 0;
  SELECT nvl(SUM(decode(cargdoso,dosocapital,decode(cargsign,'DB',cargvalo,cargvalo*-1),0)),0)
        ,nvl(SUM(decode(cargdoso,dosointeres,decode(cargsign,'DB',cargvalo,cargvalo*-1),0)),0) INTO nucapidiferefi,nuintediferefi
    FROM open.cargos
   WHERE cargnuse = i.difenuse
     AND cargconc = i.difeconc
     AND cargfecr <= dtfechacierre
     AND cargdoso  IN(dosocapital,dosointeres)
     AND cargprog = dald_parameter.fnuGetNumeric_Value('COD_PROG_FGCA');

  -- Obtenemos el Departamento y Localidad del producto
  nuvdepa   := NULL;
  nuvloca   := NULL;
  nutipprod := NULL;
  SELECT d.geograp_location_id
        ,(SELECT l.geo_loca_father_id
            FROM open.ge_geogra_location l
           WHERE l.geograp_location_id = d.geograp_location_id)
        ,p.product_type_id
    INTO nuvdepa,nuvloca,nutipprod
    FROM open.pr_product p,open.ab_address d
   WHERE p.product_id = i.difenuse
     AND p.address_id = d.address_id;

  -- Insertamos la informacion
     INSERT INTO ldc_osf_cartreficier
                                    (
                                     nuano
                                    ,numes
                                    ,cliente
                                    ,contrato
                                    ,producto
                                    ,tipo_producto
                                    ,departamento
                                    ,localidad
                                    ,dife_ref
                                    ,concepto
                                    ,fact_capital
                                    ,fact_interes
                                    ,saldo_diferi
                                    )
                              VALUES
                                    (
                                    nupaano
                                   ,nupames
                                   ,i.difcliente
                                   ,i.difesusc
                                   ,i.difenuse
                                   ,nutipprod
                                   ,nuvdepa
                                   ,nuvloca
                                   ,i.difecodi
                                   ,i.difeconc
                                   ,nucapidiferefi
                                   ,nuintediferefi
                                   ,i.difesape
                                   );
 nuconta := nuconta + 1;
  IF nuconta >= 100 THEN
   COMMIT;
   nuconta2 := nuconta2 + nuconta;
   nuconta := 0;
  END IF;
 END LOOP;
 IF nuconta <= 99 THEN
    nuconta2 := nuconta2 + nuconta;
 END IF;
 COMMIT;
 sbpmensa := 'Proceso termino Ok : '||'Se procesaron : '||to_char(nuconta2)||' resgistros.';
 nuperror := 0;
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  sbpmensa := 'Error en ldc_procciercartrefinanc error code : '||TO_CHAR(SQLCODE)||' MENSAJE '||SQLERRM;
  nuperror := -1;
END;
/
