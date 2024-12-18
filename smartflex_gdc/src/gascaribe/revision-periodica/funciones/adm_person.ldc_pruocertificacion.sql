CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_PRUOCERTIFICACION" (SBIN IN VARCHAR2)
  RETURN VARCHAR2 IS
  /**************************************************************************
    Autor       : GDC
    Fecha       : 2020-08-28
    caso        : 19
    Descripcion : procedimieto 'pre' de UOBYSOL para Asiganar unidad operativa de la ultima orden
                  de suspension a la orden de certificacion.

    Parametros Entrada
      nuano A?o
      numes Mes

    Valor de salida
      sbmen  mensaje
      error  codigo del error

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION

  ***************************************************************************/

  SBORDER_ID      VARCHAR2(4000) := NULL;
  SBPACKAGE_ID    VARCHAR2(4000) := NULL;
  SBACTIVITY_ID   VARCHAR2(4000) := NULL;
  SUBSCRIPTION_ID VARCHAR2(4000) := NULL;
  NUORDER_DES     OR_ORDER.ORDER_ID%TYPE;
  VALORDER        NUMBER := 0;
  --CON ESTA ORDEN SE SABE EN EL CICLO QUE DATO VA
  --EN SECUENCIA PARA SABER CUAL DE LOS DATOS UTILIZAR
  ----------------------------------------------------

  --SEPARA LOS DATOS OBTENIDOS DE LA CADENA DE ENTRADA
  --CON EL SEPARADOR |
  CURSOR CUDATA IS
    SELECT COLUMN_VALUE
      FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(SBIN, '|'));
  ---FIN CURSOR DATA

  ONUERRORCODE    NUMBER;
  OSBERRORMESSAGE VARCHAR2(4000);

  NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE;

  RCORDERTOASSIGN     DAOR_ORDER.STYOR_ORDER;
  RCORDERTOASSIGNNULL DAOR_ORDER.STYOR_ORDER;

  --CUROSR PARA OBTENER LA UNIDAD OPERATIVA
  CURSOR CUUO(NUPRODUCTO OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE) IS
    select oo.operating_unit_id --, oo.legalization_date
      from open.Or_Order_Activity ooa, or_order oo, mo_packages mp
     where ooa.product_id = NUPRODUCTO
       and ooa.order_id = oo.order_id
       and ooa.task_type_id =
           nvl(dald_parameter.fnuGetNumeric_Value('TT_VEN_INI', null), 0)
       and oo.causal_id =
           nvl(dald_parameter.fnuGetNumeric_Value('CAU_EXI_VEN_INI', null),
               0)
       and ooa.package_id = mp.package_id
       and mp.package_type_id IN
           (select to_number(column_value)
              from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('TIP_SOL_VEN_INI',
                                                                                       NULL),
                                                      ',')))
     order by oo.legalization_date desc;

  cursor cuproducto(NUORDEN open.or_order.order_id%type) is
    select ooa.product_id
      from open.Or_Order_Activity ooa
     where ooa.order_id = NUORDEN;

  nuproducto number;

  nucantidad NUMBER;
  NUCAUSAL   NUMBER;

BEGIN

  UT_TRACE.TRACE('INICIO LDC_PRUOCERTIFICACION', 10);

  FOR TEMPCUDATA IN CUDATA LOOP

    UT_TRACE.TRACE(TEMPCUDATA.COLUMN_VALUE, 10);

    IF SBORDER_ID IS NULL THEN
      SBORDER_ID      := TEMPCUDATA.COLUMN_VALUE;
      OSBERRORMESSAGE := '[ORDEN - ' || SBORDER_ID || ']';
    ELSIF SBPACKAGE_ID IS NULL THEN
      SBPACKAGE_ID    := TEMPCUDATA.COLUMN_VALUE;
      OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [SOLICITUD - ' ||
                         SBPACKAGE_ID || ']';
    ELSIF SBACTIVITY_ID IS NULL THEN
      SBACTIVITY_ID   := TEMPCUDATA.COLUMN_VALUE;
      OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [ACTIVIDAD - ' ||
                         SBACTIVITY_ID || ']';
    ELSIF SUBSCRIPTION_ID IS NULL THEN
      SUBSCRIPTION_ID := TEMPCUDATA.COLUMN_VALUE;
      OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [CONTRATO - ' ||
                         SUBSCRIPTION_ID || ']';
    END IF;

  END LOOP;
  NUORDER_DES := TO_NUMBER(SBORDER_ID);

  open cuproducto(NUORDER_DES);
  fetch cuproducto
    into nuproducto;
  close cuproducto;

  open CUUO(nuproducto);
  fetch CUUO
    into NUOPERATING_UNIT_ID;
  close CUUO;

  IF NVL(NUOPERATING_UNIT_ID, -1) <> -1 THEN

    BEGIN

      os_assign_order(NUORDER_DES,
                      NUOPERATING_UNIT_ID,
                      SYSDATE,
                      SYSDATE,
                      onuerrorcode,
                      osberrormessage);

      IF onuerrorcode = 0 THEN

        UPDATE LDC_ORDER
           SET ASIGNADO = 'S'
         WHERE NVL(PACKAGE_ID, 0) = NVL(TO_NUMBER(SBPACKAGE_ID), 0)
           AND ORDER_ID = NUORDER_DES;

      ELSE
        NUOPERATING_UNIT_ID := -1;
        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                             NUORDER_DES,
                                             'LA UNIDAD OPERATIVA NO FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                             NUOPERATING_UNIT_ID ||
                                             '] - MENSAJE DE ERROR PROVENIENTE DE os_assign_order --> ' ||
                                             osberrormessage);

      END IF;

    EXCEPTION
      WHEN OTHERS THEN
        osberrormessage := 'INCONSISTENCIA  [' ||
                           DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                           DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

    END;

  ELSE
    NUOPERATING_UNIT_ID := -1;
  END IF; --VALIDAR UNIDAD OPERATIVA DIFERENTE A -1

  UT_TRACE.TRACE('FIN LDC_PRUOCERTIFICACION', 10);

  RETURN(NUOPERATING_UNIT_ID);

EXCEPTION

  WHEN EX.CONTROLLED_ERROR THEN
    --ROLLBACK;
    ONUERRORCODE    := PKG_ERROR.CNUGENERIC_MESSAGE;
    OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA ' ||
                       PKERRORS.FSBGETERRORMESSAGE;
    OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' ||
                       DBMS_UTILITY.FORMAT_ERROR_STACK || ' - [' ||
                       DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                         NUORDER_DES,
                                         OSBERRORMESSAGE);

    RETURN(-1);

  WHEN OTHERS THEN
    --ROLLBACK;
    ONUERRORCODE    := PKG_ERROR.CNUGENERIC_MESSAGE;
    OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA ' ||
                       PKERRORS.FSBGETERRORMESSAGE;
    OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' ||
                       DBMS_UTILITY.FORMAT_ERROR_STACK || ' - [' ||
                       DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                         NUORDER_DES,
                                         OSBERRORMESSAGE);

    RETURN(-1);

END LDC_PRUOCERTIFICACION;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRUOCERTIFICACION', 'ADM_PERSON');
END;
/
