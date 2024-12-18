CREATE OR REPLACE PACKAGE adm_person.LDC_PAKGENFORMCOTI IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : LDC_PAKGENFORMCOTI
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    12/07/2024              PAcosta         OSF-2850: Cambio de esquema ADM_PERSON                              
    ****************************************************************/  
    
      vgProyecto                       LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type := NULL;
      vgCotizacinoConsec               LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type := NULL;
      vgTipo                           VARCHAR(1) := 'D';

  /**************************************************************************
      Proceso     : DATOSBASICOSPROYCTCOTIZ
      Autor       : Josh Brito / Horbath
      Fecha       : 2018-24-10
      Ticket      : 200-2022
      Descripcion : Proceso para obtener los datso basicos del proyecto y de la cotizacion

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
  PROCEDURE DATOSBASICOSPROYCTCOTIZ(orfcursor Out constants.tyRefCursor);

  /**************************************************************************
      Proceso     : ITEMSCOTIZADOS
      Autor       : Josh Brito / Horbath
      Fecha       : 2018-24-10
      Ticket      : 200-2022
      Descripcion : Proceso para obtener el consolidado de los items cotizados

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
  PROCEDURE ITEMSCOTIZADOS(orfcursor Out constants.tyRefCursor);

  /**************************************************************************
      Proceso     : TOTALITEMSCOTIZADOS
      Autor       : Josh Brito / Horbath
      Fecha       : 2018-24-10
      Ticket      : 200-2022
      Descripcion : Proceso para obtener la SUMATORIA del consolidado de los items cotizados

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
  PROCEDURE TOTALITEMSCOTIZADOS(orfcursor Out constants.tyRefCursor);

  /**************************************************************************
      Proceso     : IMPRIME_COTIZACION
      Autor       : Josh Brito / Horbath
      Fecha       : 2018-24-10
      Ticket      : 200-2022
      Descripcion : Proceso para imprimir formato de contrato de prestacion de servicio de gas  PB [IMPCPS]

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
  PROCEDURE IMPRIME_COTIZACION(nuProyecto LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
                                        , nuCotizacinoConsec LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type
                                        , sbTipo VARCHAR2);

END LDC_PAKGENFORMCOTI;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PAKGENFORMCOTI IS

  PROCEDURE DATOSBASICOSPROYCTCOTIZ(orfcursor Out constants.tyRefCursor) is
  /**************************************************************************
      Proceso     : DATOSBASICOSPROYCTCOTIZ
      Autor       : Josh Brito / Horbath
      Fecha       : 2018-24-10
      Ticket      : 200-2022
      Descripcion : Proceso para obtener los datso basicos del proyecto y de la cotizacion

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

  begin
    ut_trace.trace('******* Inicio [DATOSBASICOSPROYCTCOTIZ]', 10);

    open orfcursor for

      SELECT LDC_PAKGENFORMCOTI.vgTipo TIPO_IMPRESION,
      PC.ID_PROYECTO PROYECTO,
      upper(PC.NOMBRE) NOM_PROYECTO,
      CC.ID_COTIZACION_DETALLADA CONSEC_COTIZACION,
      PC.ID_SOLICITUD NUM_SOLICITUD,
      TO_CHAR(CC.FECHA_CREACION, 'DD-MON-YYYY') FECHA_CREACION,
      TO_CHAR(CC.FECHA_VIGENCIA, 'DD-MON-YYYY') FECHA_VIGENCIA,
      upper(DAAB_ADDRESS.FSBGETADDRESS(PC.ID_DIRECCION)) DIRECCION,
      DAGE_SUBSCRIBER.FSBGETIDENTIFICATION(PC.CLIENTE) IDENT_CLIENTE,
      upper(DAGE_SUBSCRIBER.FSBGETSUBSCRIBER_NAME(PC.CLIENTE) || ' ' || DAGE_SUBSCRIBER.FSBGETSUBS_LAST_NAME(PC.CLIENTE)) NOM_CLIENTE,
      DAGE_SUBSCRIBER.FSBGETPHONE(PC.CLIENTE) TELEFONO,
      upper('') CATEGORIA,
      upper('') SUBCATEGORIA,
      upper(dage_geogra_location.fsbgetDescription(PC.ID_LOCALIDAD)) LOCALIDAD,
      upper(dage_geogra_location.fsbgetDescription(DAGE_GEOGRA_LOCATION.FNUGETGEO_LOCA_FATHER_ID(PC.ID_LOCALIDAD))) DEPARTAMENTO,
      upper(decode(CA.CONTRATISTA, null, null,DAGE_CONTRATISTA.FSBGETNOMBRE_CONTRATISTA(CA.CONTRATISTA))) CONTRATISTA,
      CC.OBSERVACION,
      TO_CHAR(round(CC.VALOR_COTIZADO,0),'$999,999,999,999,999.99' ) VALOR_PROYECTO,
      PC.CANT_UNID_PREDIAL
      FROM LDC_PROYECTO_CONSTRUCTORA PC,
      LDC_COTIZACION_CONSTRUCT CC,
      LDC_COTICONSTRUCTORA_ADIC CA
      WHERE PC.ID_PROYECTO = CC.ID_PROYECTO
      AND CC.ID_PROYECTO = CA.ID_PROYECTO(+)
      AND CC.ID_COTIZACION_DETALLADA = CA.ID_COTIZACION(+)
      AND PC.ID_PROYECTO = LDC_PAKGENFORMCOTI.vgProyecto--2
      AND CC.ID_COTIZACION_DETALLADA = LDC_PAKGENFORMCOTI.vgCotizacinoConsec;--1;

      ut_trace.trace('Fin [DATOSBASICOSPROYCTCOTIZ]', 10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END DATOSBASICOSPROYCTCOTIZ;

  PROCEDURE ITEMSCOTIZADOS(orfcursor Out constants.tyRefCursor) is
  /**************************************************************************
      Proceso     : ITEMSCOTIZADOS
      Autor       : Josh Brito / Horbath
      Fecha       : 2018-24-10
      Ticket      : 200-2022
      Descripcion : Proceso para obtener el consolidado de los items cotizados

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

  begin
    ut_trace.trace('******* Inicio [ITEMSCOTIZADOS]', 10);

    IF LDC_PAKGENFORMCOTI.vgTipo <> 'R' THEN

      open orfcursor for
        SELECT TIPO_TRABAJO,
        COD_ITEM,
        case
          when instr(DESC_ITEM,'>') > 0
            or instr(DESC_ITEM,'<') > 0 then
                REPLACE(REPLACE(DESC_ITEM,'>','&'||'gt;'),'<','&'||'lt;')
        ELSE DESC_ITEM END DESC_ITEM,
        CANTIDAD,
        COSTO,
        PRECIO_TOTAL,
        IVA,
        VALOR_TOTAL
        FROM (
            SELECT DAOR_TASK_TYPE.FSBGETDESCRIPTION(id_tipo_trabajo,NULL) TIPO_TRABAJO,
                   id_item COD_ITEM,
                   NVL(DAGE_ITEMS.FSBGETDESCRIPTION(id_item, null), 'INTERVENTORIA') DESC_ITEM,
                   sum(cantidad) CANTIDAD,
                   TO_CHAR(sum(COSTO),'$999,999,999,999,999.99' ) COSTO,
                   TO_CHAR(sum(PRECIO),'$999,999,999,999,999.99' ) PRECIO_TOTAL,
                   TO_CHAR(sum(0),'$999,999,999,999,999.99' ) IVA,
                   TO_CHAR(sum(PRECIO_TOTAL),'$999,999,999,999,999.99' ) VALOR_TOTAL
            FROM ldc_items_por_unid_pred
            WHERE id_proyecto = LDC_PAKGENFORMCOTI.vgProyecto
                AND id_cotizacion_detallada = LDC_PAKGENFORMCOTI.vgCotizacinoConsec
                AND tipo_item <> 'FP'
            GROUP BY id_tipo_trabajo, id_item
            UNION ALL
             SELECT DAOR_TASK_TYPE.FSBGETDESCRIPTION(tipo_trab,NULL) TIPO_TRABAJO,
                   id_item COD_ITEM,
                   DAGE_ITEMS.FSBGETDESCRIPTION(id_item, null) DESC_ITEM,
                   CANTIDAD,
                   TO_CHAR(COSTO,'$999,999,999,999,999.99' ) COSTO,
                   TO_CHAR(PRECIO,'$999,999,999,999,999.99' ) PRECIO_TOTAL,
                   TO_CHAR(0,'$999,999,999,999,999.99' ) IVA,
                   TO_CHAR(TOTAL_PRECIO,'$999,999,999,999,999.99' ) VALOR_TOTAL
              FROM ldc_items_cotiz_proy a
              WHERE id_proyecto = LDC_PAKGENFORMCOTI.vgProyecto
                AND id_cotizacion_detallada = LDC_PAKGENFORMCOTI.vgCotizacinoConsec
                AND tipo_item = 'FP'
            UNION ALL
              SELECT upper(DAOR_TASK_TYPE.FSBGETDESCRIPTION(TTC.ID_TIPO_TRABAJO)) TIPO_TRABAJO,
              TTC.ID_ACTIVIDAD_PRINCIPAL COD_ITEM,
              upper(DAGE_ITEMS.FSBGETDESCRIPTION(TTC.ID_ACTIVIDAD_PRINCIPAL)) DESC_ITEM,
              1 CANTIDAD,
              TO_CHAR(CC.COSTO,'$999,999,999,999,999.99' ) COSTO,
              TO_CHAR(CC.PRECIO,'$999,999,999,999,999.99' ) PRECIO_TOTAL,
              TO_CHAR(((CC.PRECIO * CC.IVA ) / 100),'$999,999,999,999,999.99' ) IVA,
              TO_CHAR(CC.PRECIO_TOTAL,'$999,999,999,999,999.99' ) VALOR_TOTAL
              FROM LDC_TIPOS_TRABAJO_COT TTC,
              LDC_CONSOLID_COTIZACION CC
              WHERE TTC.ID_PROYECTO = CC.ID_PROYECTO
              AND TTC.ID_COTIZACION_DETALLADA = CC.ID_COTIZACION_DETALLADA
              AND TTC.ID_TIPO_TRABAJO = CC.ID_TIPO_TRABAJO
              AND TTC.TIPO_TRABAJO_DESC = 'CE'
              AND TTC.ID_COTIZACION_DETALLADA = LDC_PAKGENFORMCOTI.vgCotizacinoConsec
              AND TTC.ID_PROYECTO = LDC_PAKGENFORMCOTI.vgProyecto)
        ORDER BY TIPO_TRABAJO;

      ELSE

        open orfcursor for
          SELECT TIPO_TRABAJO,
          COD_ITEM,
          case
            when instr(DESC_ITEM,'>') > 0
              or instr(DESC_ITEM,'<') > 0 then
                  REPLACE(REPLACE(DESC_ITEM,'>','&'||'gt;'),'<','&'||'lt;')
          ELSE DESC_ITEM END DESC_ITEM,
          CANTIDAD,
          COSTO,
          PRECIO_TOTAL,
          IVA,
          VALOR_TOTAL
          FROM (
          SELECT 0 CANTIDAD,
          upper(DAOR_TASK_TYPE.FSBGETDESCRIPTION(TTC.ID_TIPO_TRABAJO)) TIPO_TRABAJO,
          TTC.ID_ACTIVIDAD_PRINCIPAL COD_ITEM,
          upper(DAGE_ITEMS.FSBGETDESCRIPTION(TTC.ID_ACTIVIDAD_PRINCIPAL)) DESC_ITEM,
          TO_CHAR(CC.COSTO,'$999,999,999,999,999.99' ) COSTO,
          TO_CHAR(CC.PRECIO,'$999,999,999,999,999.99' ) PRECIO_TOTAL,
          TO_CHAR(((CC.PRECIO * CC.IVA ) / 100),'$999,999,999,999,999.99' ) IVA,
          TO_CHAR(CC.PRECIO_TOTAL,'$999,999,999,999,999.99' ) VALOR_TOTAL
          FROM LDC_TIPOS_TRABAJO_COT TTC,
          LDC_CONSOLID_COTIZACION CC, LDC_PROYECTO_CONSTRUCTORA p
          WHERE TTC.ID_PROYECTO = CC.ID_PROYECTO
           and TTC.ID_PROYECTO = p.ID_PROYECTO
          AND TTC.ID_COTIZACION_DETALLADA = CC.ID_COTIZACION_DETALLADA
          AND TTC.ID_TIPO_TRABAJO = CC.ID_TIPO_TRABAJO
          AND TTC.ID_PROYECTO = LDC_PAKGENFORMCOTI.vgProyecto--2
          AND TTC.ID_COTIZACION_DETALLADA = LDC_PAKGENFORMCOTI.vgCotizacinoConsec)
            ORDER BY TIPO_TRABAJO;

      END IF;

      ut_trace.trace('Fin [ITEMSCOTIZADOS]', 10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END ITEMSCOTIZADOS;

  PROCEDURE TOTALITEMSCOTIZADOS(orfcursor Out constants.tyRefCursor) is
  /**************************************************************************
      Proceso     : TOTALITEMSCOTIZADOS
      Autor       : Josh Brito / Horbath
      Fecha       : 2018-24-10
      Ticket      : 200-2022
      Descripcion : Proceso para obtener la SUMATORIA del consolidado de los items cotizados

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

  begin
    ut_trace.trace('******* Inicio [TOTALITEMSCOTIZADOS]', 10);

    IF LDC_PAKGENFORMCOTI.vgTipo <> 'R' THEN

      open orfcursor for
        SELECT
        sum(CANTIDAD) SUM_CANTIDAD,
        TO_CHAR(sum(COSTO),'$999,999,999,999,999.99' ) SUM_COSTO,
        TO_CHAR(sum(PRECIO_TOTAL),'$999,999,999,999,999.99' ) SUM_PRECIO_TOTAL,
        TO_CHAR(sum(IVA),'$999,999,999,999,999.99' ) SUM_IVA,
        TO_CHAR(sum(VALOR_TOTAL),'$999,999,999,999,999.99' ) SUM_VALOR_TOTAL
        FROM (
            SELECT DAOR_TASK_TYPE.FSBGETDESCRIPTION(id_tipo_trabajo,NULL) TIPO_TRABAJO,
                   id_item COD_ITEM,
                   NVL(DAGE_ITEMS.FSBGETDESCRIPTION(id_item, null), 'INTERVENTORIA') DESC_ITEM,
                   sum(cantidad) CANTIDAD,
                   sum(COSTO) COSTO,
                   sum(PRECIO) PRECIO_TOTAL,
                   sum(0) IVA,
                   sum(PRECIO_TOTAL) VALOR_TOTAL
            FROM ldc_items_por_unid_pred
            WHERE id_proyecto = LDC_PAKGENFORMCOTI.vgProyecto
                AND id_cotizacion_detallada = LDC_PAKGENFORMCOTI.vgCotizacinoConsec
                AND tipo_item <> 'FP'
            GROUP BY id_tipo_trabajo, id_item
            UNION ALL
             SELECT DAOR_TASK_TYPE.FSBGETDESCRIPTION(tipo_trab,NULL) TIPO_TRABAJO,
                   id_item COD_ITEM,
                   DAGE_ITEMS.FSBGETDESCRIPTION(id_item, null) DESC_ITEM,
                   CANTIDAD,
                   COSTO,
                   PRECIO PRECIO_TOTAL,
                   0 IVA,
                   TOTAL_PRECIO VALOR_TOTAL
              FROM ldc_items_cotiz_proy a
              WHERE id_proyecto = LDC_PAKGENFORMCOTI.vgProyecto
                AND id_cotizacion_detallada = LDC_PAKGENFORMCOTI.vgCotizacinoConsec
                AND tipo_item = 'FP'
            UNION ALL
              SELECT upper(DAOR_TASK_TYPE.FSBGETDESCRIPTION(TTC.ID_TIPO_TRABAJO)) TIPO_TRABAJO,
              TTC.ID_ACTIVIDAD_PRINCIPAL COD_ITEM,
              upper(DAGE_ITEMS.FSBGETDESCRIPTION(TTC.ID_ACTIVIDAD_PRINCIPAL)) DESC_ITEM,
              1 CANTIDAD,
              CC.COSTO COSTO,
              CC.PRECIO PRECIO_TOTAL,
              ((CC.PRECIO * CC.IVA ) / 100) IVA,
              CC.PRECIO_TOTAL VALOR_TOTAL
              FROM LDC_TIPOS_TRABAJO_COT TTC,
              LDC_CONSOLID_COTIZACION CC
              WHERE TTC.ID_PROYECTO = CC.ID_PROYECTO
              AND TTC.ID_COTIZACION_DETALLADA = CC.ID_COTIZACION_DETALLADA
              AND TTC.ID_TIPO_TRABAJO = CC.ID_TIPO_TRABAJO
              AND TTC.TIPO_TRABAJO_DESC = 'CE'
              AND TTC.ID_COTIZACION_DETALLADA = LDC_PAKGENFORMCOTI.vgCotizacinoConsec
              AND TTC.ID_PROYECTO = LDC_PAKGENFORMCOTI.vgProyecto);
    ELSE

      open orfcursor for
        SELECT
        sum(CANTIDAD) SUM_CANTIDAD,
        TO_CHAR(sum(COSTO),'$999,999,999,999,999.99' ) SUM_COSTO,
        TO_CHAR(sum(PRECIO_TOTAL),'$999,999,999,999,999.99' ) SUM_PRECIO_TOTAL,
        TO_CHAR(sum(IVA),'$999,999,999,999,999.99' ) SUM_IVA,
        TO_CHAR(sum(VALOR_TOTAL),'$999,999,999,999,999.99' ) SUM_VALOR_TOTAL
        FROM (
        SELECT p.CANT_UNID_PREDIAL CANTIDAD,
            round(SUM(CC.COSTO),0) COSTO,
            round(SUM(CC.PRECIO),0) PRECIO_TOTAL,
            round((SUM(CC.PRECIO * CC.IVA ) / 100),0) IVA,
            round(SUM(CC.PRECIO_TOTAL),0) VALOR_TOTAL

        FROM LDC_TIPOS_TRABAJO_COT  TTC,
        LDC_CONSOLID_COTIZACION CC, LDC_PROYECTO_CONSTRUCTORA p
        WHERE TTC.ID_PROYECTO = CC.ID_PROYECTO
           and TTC.ID_PROYECTO = p.ID_PROYECTO
        AND TTC.ID_COTIZACION_DETALLADA = CC.ID_COTIZACION_DETALLADA
        AND TTC.ID_TIPO_TRABAJO = CC.ID_TIPO_TRABAJO
        AND TTC.ID_PROYECTO = LDC_PAKGENFORMCOTI.vgProyecto--2
        AND TTC.ID_COTIZACION_DETALLADA = LDC_PAKGENFORMCOTI.vgCotizacinoConsec
         group by  p.CANT_UNID_PREDIAL);

    END IF;

      ut_trace.trace('Fin [TOTALITEMSCOTIZADOS]', 10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END TOTALITEMSCOTIZADOS;

  PROCEDURE IMPRIME_COTIZACION(nuProyecto LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
                              , nuCotizacinoConsec LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type
                              , sbTipo VARCHAR2) IS
      /**************************************************************************
      Proceso     : IMPRIME_COTIZACION
      Autor       : Josh Brito / Horbath
      Fecha       : 2018-24-10
      Ticket      : 200-2022
      Descripcion : Proceso para imprimir formato de contrato de prestacion de servicio de gas  PB [IMPCPS]

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/


    sbmensa                 VARCHAR2(4000);
    sbParametros            ge_process_schedule.parameters_%TYPE;
    nuHilos                 NUMBER := 1;
    nuLogProceso            ge_log_process.log_process_id%TYPE;

    rcConfexme                             pktbled_confexme.cued_confexme%rowtype;
    clData                                 CLOB;
    nuFormato                              ed_formato.formcodi%type;
    sbError                                VARCHAR2(4000);
    cnuConfexme                            NUMBER := 118;

  BEGIN
    ut_trace.trace('*************************** Inicio [IMPRIME_COTIZACION]', 10);

     --Se realizan Setting a las variables para el formato de impresion
     LDC_PAKGENFORMCOTI.vgProyecto := nuProyecto;
     LDC_PAKGENFORMCOTI.vgCotizacinoConsec := nuCotizacinoConsec;
     LDC_PAKGENFORMCOTI.vgTipo := sbTipo;

     --MEZCLA Y GENERACION DEL FORMATO
     pkbced_confexme.obtieneregistro(cnuConfexme, rcConfexme);

    -- pkbodataextractor.instancebaseentity(sbVenta, 'LDCI_COTIVENTASMOVIL', pkconstante.verdadero);

     nuFormato := pkbced_formato.fnugetformcodibyiden(rcconfexme.coempada);

     pkbodataextractor.executerules(nuFormato, clData);

     pkboed_documentmem.set_printdocid(vgCotizacinoConsec);

     pkboed_documentmem.set_printdoc(clData);

     pkboed_documentmem.settemplate(rcconfexme.coempadi);

     GE_BOIOPENEXECUTABLE.PRINTDUPLICATERULE();


  -- Se inicia log del programa

  EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
   /*WHEN OTHERS THEN
      ROLLBACK;
      sbmensa := 'Error no Controlado '||sqlerrm;
      ge_boschedule.changelogProcessStatus(nuLogProceso,'F'); */

  END IMPRIME_COTIZACION;


END LDC_PAKGENFORMCOTI;
/
PROMPT Otorgando permisos de ejecucion a LDC_PAKGENFORMCOTI
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PAKGENFORMCOTI', 'ADM_PERSON');
END;
/
