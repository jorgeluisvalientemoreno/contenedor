CREATE OR REPLACE PROCEDURE ldc_cartcastigada_cierre(nuano NUMBER,numes NUMBER,nuerror OUT NUMBER,sberror OUT VARCHAR2) IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-12-22
  Descripcion : Generamos información la cartera castaigada por concepto a cierre

  Parametros Entrada
    nuano Año
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION
   11/10/2019   LJLB     CA 200 se quita proceso de consultar cartera castigada y el que llena
                         por concepto castigados
***************************************************************************/
TYPE array_cursor IS RECORD(
                              iden VARCHAR2(1000)
                             ,prod ldc_osf_sesucier.producto%TYPE
                             );
TYPE t_array_cursor IS TABLE OF array_cursor;
v_array_cursor t_array_cursor;

CURSOR cucast(nucano NUMBER,nucmes NUMBER) is
 SELECT l.rowid ident,l.producto
   FROM open.ldc_osf_sesucier l
  WHERE l.nuano = nucano
    AND l.numes = nucmes
    AND l.area_servicio = l.area_servicio
    AND l.estado_financiero = 'C';

TYPE regProducto IS RECORD ( rerowid VARCHAR2(4000),
                             nuValor  ldc_osf_sesucier.valor_castigado%TYPE
                              );
TYPE tplValorCasti IS TABLE OF regProducto INDEX BY PLS_INTEGER;
vtplValorCasti   tplValorCasti;

nuvalorcast   ldc_osf_sesucier.valor_castigado%TYPE;
tbCharges     pkBCCharges.tytbReacCharges;
nucontaarr    NUMBER DEFAULT 0;
nunuse        ldc_osf_sesucier.producto%TYPE;
nucontareg    NUMBER(15) DEFAULT 0;
limit_in      NUMBER(15) DEFAULT 0;
nucantiregcom NUMBER(15) DEFAULT 0;
BEGIN
nuerror := 0;
sberror := NULL;
nucantiregcom := 0;
nucontareg := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');
limit_in   := nucontareg;
nuerror := -1;
OPEN cucast(nuano,numes);
 LOOP
  FETCH cucast BULK COLLECT INTO v_array_cursor LIMIT limit_in;
   FOR i IN 1..v_array_cursor.count LOOP
     nunuse                 := v_array_cursor(i).prod;
     nuvalorcast :=0;
    --TICKET 200 LJLB --se quita api de donde se consulta la cartera castigada
      SELECT  /*+ index( gc_prodprca IDX_GC_PRODPRCA01 ) */
                 SUM( NVL(PRPCSACA, 0) - NVL(PRPCSARE, 0) ) INTO nuvalorcast
          FROM    GC_PRODPRCA
          WHERE   PRPCNUSE = nunuse
           AND     ( NVL(PRPCSACA, 0) - NVL(PRPCSARE, 0)) > 0;
    -- nuvalorcast            := gc_bodebtmanagement.fnugetpunidebtbyprod(nunuse);
     IF nvl(nuvalorcast,0) > 0 THEN
        nuerror := -2;
        nucantiregcom := nucantiregcom + 1;
        vtplValorCasti(nucantiregcom).rerowid := v_array_cursor(i).iden;
        vtplValorCasti(nucantiregcom).nuValor := nuvalorcast;

       /* gc_bocastigocartera.getpunishbalancebyprod(nunuse,tbCharges);
        nuerror := -3;
        nucontaarr := tbCharges.count;
        IF nucontaarr > 0 THEN
         nuerror := -4;
         -- Deuda castigada x concepto
         FOR pos IN tbcharges.first..tbcharges.last LOOP
          nuerror := -5;
           INSERT INTO ldc_osf_castconc
            (
             nuano
            ,numes
            ,producto
            ,cta_cobro
            ,concepto
            ,valor
            ,signo
            ,documento_soporte
            )
           VALUES
            (
              nuano
             ,numes
             ,nunuse
             ,tbCharges(pos).nuAccount
             ,tbCharges(pos).nuChargeConc
             ,tbCharges(pos).nuChargeValue
             ,tbCharges(pos).sbSign
             ,tbCharges(pos).sbSupportDoc
             );
          -- Actualizamos saldo castigado en ldc_osf_sesucier
          UPDATE open.ldc_osf_sesucier r
             SET r.valor_castigado = nvl(nuvalorcast,0)
           WHERE r.rowid = v_array_cursor(i).iden;
         END LOOP;

        END IF;*/

       END IF;
    END LOOP;
   FORALL indx IN 1 .. vtplValorCasti.COUNT
         -- Actualizamos saldo castigado en ldc_osf_sesucier
        UPDATE open.ldc_osf_sesucier r
           SET r.valor_castigado = vtplValorCasti(indx).nuValor
         WHERE r.rowid = vtplValorCasti(indx).rerowid;


   COMMIT;
  EXIT WHEN cucast%NOTFOUND;
 END LOOP;
CLOSE cucast;
  nuerror := 0;
  sberror := 'Proceso terminó Ok : se procesarón '||to_char(nucantiregcom)||' registros.';
EXCEPTION
 WHEN OTHERS THEN
   ROLLBACK;
   nuerror := -1;
   sberror := 'Error en proceso : ldc_cartcastigada_cierre, producto : '||to_char(nunuse)||' '||sqlerrm;
END;
/
