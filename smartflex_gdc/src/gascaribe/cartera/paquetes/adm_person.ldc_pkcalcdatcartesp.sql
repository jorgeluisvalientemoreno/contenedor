CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_PKCALCDATCARTESP aS
/********************************************************************************************************************
Propiedad intelectual de GASES DEL CARIBE S.A. E.S.P.

      Package       : LDC_PKCALCDATCARTESP

      Descripcion   : Calcula valores de la tabla LDC_USUCARTERAESP para llevar control de usuarios especiales

      Autor       :   HORBATH TECHNOLOGIES
      Fecha       :   17-11-2018 7:42 PM CASO 200-2241

      Historia de Modificaciones
      Fecha           IDEntrega

***********************************************************************************************************************/

  -----------------------------------------------------------------------------
  -- Funciones

  function fnc_DIRECCION(inuproducto in pr_product.product_id%type) return varchar2;
  function fnc_CARTERA_FECHA (inuproducto in pr_product.product_id%type) return number;
  function fnc_EDAD_MORA (inuproducto in pr_product.product_id%type) return number;
  function fnc_NO_FACTURAS_DEUDA(inuproducto in pr_product.product_id%type) return number;
  function fnc_ESTADO_PRODUCTO(inuproducto in pr_product.product_id%type) return varchar2;
  function fnc_FECHA_REFINANCIACION(inuproducto in pr_product.product_id%type) return date;
  function fnc_VALOR_CONSUMO(inuproducto in pr_product.product_id%type) return number; -- (deuda por concepto de consumo)
  function fnc_M3_DEUDA(inuproducto in pr_product.product_id%type) return number; -- (Cuantos m3 equivalen ese valor de consumo)
  function fnc_CONSUMO_PROMEDIO_M3 (inuproducto in pr_product.product_id%type) return number; --(Consumo promedio en los últimos N meses)
  function fnc_VALOR_PROMEDIO_FACTURA (inuproducto in pr_product.product_id%type) return number; -- (Valor promedio en los últimos N meses)
  function fnc_FECH_VENC_ULT_FACT (inuproducto in pr_product.product_id%type) return DATE; --(Fecha vencimiento ultima factura)
  function fnc_VECES_MORA_ANO (inuproducto in pr_product.product_id%type) return number; --(Cuantas veces ha estado en mora en el último año)
  function fnc_FECHA_SUSPENSION (inuproducto in pr_product.product_id%type) return date; --(Fecha última suspensiOn)
  function fnc_HACE_SUSPENDIDO (inuproducto in pr_product.product_id%type) return number; --(Cuantos días lleva suspendido)
  function fnc_VIOLA_SERVICIO (inuproducto in pr_product.product_id%type) return varchar2; --(Si se encuentra violando el servicio)
  function fnc_VALOR_RECLAMO (inuproducto in pr_product.product_id%type) return number; --(Valor en reclamo)
  function fnc_FECHA_RECLAMO (inuproducto in pr_product.product_id%type) return date; --(Fecha del último reclamo)
  function fnc_DETALLE_RECLAMO (inuproducto in pr_product.product_id%type) return varchar2; --(Detalle del último reclamo)
  function fnc_PROMEDIO_PAGOS (inuproducto in pr_product.product_id%type) return number; --(Promedio pagos en los últimos N meses)
  function fnc_FECHA_PAGO (inuproducto in pr_product.product_id%type) return date; --(Fecha del último pago)
  function fnc_DIAS_PAGO_FACTURA (inuproducto in pr_product.product_id%type) return number; --(Promedio de días que demora en pagar las facturas, de los últimos N pagos)
  function fnc_REFINANCIACION_ACTIVA (inuproducto in pr_product.product_id%type) return varchar2; --(tiene refinanciacion activa)
END;
/
CREATE OR REPLACE Package Body ADM_PERSON.LDC_PKCALCDATCARTESP as
/********************************************************************************************************************
Propiedad intelectual de GASES DEL CARIBE S.A. E.S.P.

      Package       : LDC_PKCALCDATCARTESP

      Descripcion   : Calcula valores de la tabla LDC_USUCARTERAESP para llevar control de usuarios especiales

      Autor       :   HORBATH TECHNOLOGIES
      Fecha       :   17-11-2018 7:42 PM CASO 200-2241

      Historia de Modificaciones
      Fecha           IDEntrega

***********************************************************************************************************************/

  function fnc_DIRECCION(inuproducto in pr_product.product_id%type) return varchar2 is -- direccion del servicio suscrito
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  FNC_DIRECCION

    Proposito:
    Determina direccion del producto

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/
  nuADDRESS_ID pr_product.address_id%type;
  Begin
       select ADDRESS_ID into nuADDRESS_ID from pr_product where product_id=inuproducto;
       return(daab_address.fsbgetaddress(nuaddress_id));
  EXCEPTION
       WHEN OTHERS THEN
            RETURN('');
  end fnc_DIRECCION;

  function fnc_CARTERA_FECHA (inuproducto in pr_product.product_id%type) return number is -- cartera a la fecha
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_cartera_fecha

    Proposito:
    Determina valor de la cartera a la fecha

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/
  diadia date;
  vlrcartera number;
  Begin
       select max(dia) into diadia from ldc_concepto_diaria where producto=inuproducto;

       select sum(nvl(valor_causado,0)+nvl(valor_diferido,0)+nvl(valor_no_vencido,0))
              into vlrcartera
              from ldc_concepto_diaria
              where dia=diadia and producto=inuproducto;
       return(vlrcartera);
  EXCEPTION
       WHEN OTHERS THEN
            RETURN(0);
  end fnc_cartera_fecha;

  function fnc_EDAD_MORA (inuproducto in pr_product.product_id%type) return number is -- edad de mora
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_EDAD_MORA

    Proposito:
    Determina edad de mora

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/

  Begin
       return(GC_BODEBTMANAGEMENT.FnuGetDebtAgeByProd(inuProducto));
  EXCEPTION
       WHEN OTHERS THEN
            RETURN(0);
  end fnc_edad_mora;

  function fnc_NO_FACTURAS_DEUDA(inuproducto in pr_product.product_id%type) return number is -- numero de factura en deuda
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_no_facturas_deuda

    Proposito:
    Determina numero de facturas en deuda

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/
  ctasaldo number;
  Begin
       select count(1) into ctasaldo
       from cuencobr,factura where cuconuse=inuproducto and nvl(cucosacu,0)>0
       and factcodi=cucofact and factprog=6;
       return(ctasaldo);
  EXCEPTION
       WHEN OTHERS THEN
            RETURN(0);
  end fnc_no_facturas_deuda;

  function fnc_ESTADO_PRODUCTO(inuproducto in pr_product.product_id%type) return varchar2 is -- estado producto
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_ESTADO_PRODUCTO

    Proposito:
    Determina estado producto

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/
  descesta ps_product_status.description%type;
  codiesta ps_product_status.PRODUCT_STATUS_ID%type;
  Begin
       select product_status_id into codiesta from pr_product where product_id=inuproducto;
       select description into descesta from ps_product_status where product_status_id=codiesta;
       return(descesta);
  EXCEPTION
       WHEN OTHERS THEN
            RETURN('');
  end fnc_estado_producto;
  function fnc_FECHA_REFINANCIACION(inuproducto in pr_product.product_id%type) return date is -- fecha ultima refinanciacion
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_FECHA_REFINANCIACION

    Proposito:
    Determina fecha ultima refinanciacion

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/
  dia date;
  Begin
       select max(difefein) into dia from diferido where difeprog in ('GCNED', 'FINAN') and difenuse=inuproducto;
       return(dia);
  EXCEPTION
       WHEN OTHERS THEN
            RETURN(SYSDATE);
  end fnc_fecha_refinanciacion;

  function fnc_VALOR_CONSUMO(inuproducto in pr_product.product_id%type) return number is -- (deuda por concepto de consumo)
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_VALOR_CONSUMO

    Proposito:
    Determina Deuda por concepto de consumo

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/

  diadia date;
  vlrcartera number;
  Begin
       select max(dia) into diadia from ldc_concepto_diaria where producto=inuproducto;

       select sum(nvl(valor_causado,0)+nvl(valor_diferido,0)+nvl(valor_no_vencido,0))
              into vlrcartera
              from ldc_concepto_diaria
              where dia=diadia and producto=inuproducto and concepto=31;
       return(vlrcartera);
  EXCEPTION
       WHEN OTHERS THEN
            RETURN(0);
  end fnc_valor_consumo;

  function fnc_M3_DEUDA(inuproducto in pr_product.product_id%type) return number is -- (Cuantos m3 equivalen ese valor de consumo)
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_M3_DEUDA

    Proposito:
    Determina Cuantos m3 se deben

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

			    *******************************************************************************/
  CM3 NUMBER;
  UM3 NUMBER;
  CURSOR CC IS SELECT * FROM CUENCOBR ,FACTURA WHERE CUCOSACU>0 AND CUCONUSE=INUPRODUCTO AND CUCOFACT=FACTCODI AND FACTPROG=6;
  Begin
      -- CM3:=0;
      -- FOR C IN CC LOOP
      SELECT SUM(DECODE(CARGSIGN,'DB',CARGUNID,'CR',-CARGUNID))
      INTO UM3
      FROM CARGOS
      WHERE CARGnuse = INUPRODUCTO
        AND CARGCONC=31
        AND cargcaca = 15
        AND cargcuco in (SELECT cucocodi FROM CUENCOBR ,FACTURA WHERE CUCOSACU>0 AND CUCONUSE=INUPRODUCTO AND CUCOFACT=FACTCODI AND FACTPROG=6);
      --     CM3:=CM3;
      -- END LOOP;
       return(UM3);
  EXCEPTION
       WHEN OTHERS THEN
            RETURN(0);
  end fnc_m3_deuda;

  function fnc_CONSUMO_PROMEDIO_M3 (inuproducto in pr_product.product_id%type) return number is --(Consumo promedio en los últimos N meses)
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_CONSUMO_PROMEDIO_M3

    Proposito:
    Determina Consumo promedio en m3

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/
     VLRPROMEDIO NUMBER;
     nuMeses NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('PARMESESCARTESP', NULL);
  Begin
       --return(NVL(LDCI_PKFACTURACION.fnuGetAverageCons(INUPRODUCTO,6),0));

       select  round((sum(SUMA) / nuMeses), 0) into VLRPROMEDIO
        from( select COSSFERE, COSSCOCA SUMA
              from CONSSESU
             where COSSSESU = INUPRODUCTO
               and  COSSMECC = 4
          order by COSSFERE desc)
        where ROWNUM <= nuMeses;

      return VLRPROMEDIO;
  EXCEPTION
       WHEN OTHERS THEN
            RETURN(0);
  end fnc_CONSUMO_PROMEDIO_M3;

  function fnc_VALOR_PROMEDIO_FACTURA (inuproducto in pr_product.product_id%type) return number is -- (Valor promedio en los últimos N meses)
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_VALOR_PROMEDIO_FACTURA

    Proposito:
    Determina valor promedio de factura

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/
  VLRPROMEDIO NUMBER;
  Begin
       SELECT SUMA/REGISTROS INTO VLRPROMEDIO
              FROM
              (SELECT COUNT(1) REGISTROS, SUM(CUCOVATO) SUMA
              FROM CUENCOBR, FACTURA
              WHERE FACTPROG=6 AND
                    CUCONUSE=INUPRODUCTO AND
                    CUCOFACT=FACTCODI
                    ORDER BY FACTFEGE DESC)
            where ROWNUM<=6;
       return(VLRPROMEDIO);
  EXCEPTION
       WHEN OTHERS THEN
            RETURN(0);
  end fnc_VALOR_PROMEDIO_FACTURA;

  function fnc_FECH_VENC_ULT_FACT (inuproducto in pr_product.product_id%type) return DATE is --(Fecha vencimiento ultima factura)
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_VALOR_PROMEDIO_FACTURA

    Proposito:
    Determina 	fecha vencimiento ultima factura

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/
  DTVENC DATE;
  Begin
       SELECT CUCOFEVE INTO DTVENC
       FROM (
             SELECT CUCOFEVE
             FROM CUENCOBR , FACTURA
             WHERE FACTPROG=6 AND CUCONUSE=INUPRODUCTO
             AND CUCOFACT=FACTCODI
             ORDER BY FACTFEGE DESC)
       WHERE  ROWNUM = 1 ;
       return(DTVENC);
  EXCEPTION
       WHEN OTHERS THEN
            RETURN(NULL);
  end fnc_FECH_VENC_ULT_FACT;

  function fnc_VECES_MORA_ANO (inuproducto in pr_product.product_id%type) return number is --(Cuantas veces ha estado en mora en el último año)
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_VECES_MORA_ANO

    Proposito:
    Determina Cuantas veces ha estado en mora en el último año

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/
  VECES NUMBER;
  Begin
       SELECT COUNT(1) INTO VECES
       FROM LDC_OSF_SESUCIER
       WHERE PRODUCTO=INUPRODUCTO AND EDAD>=60
          AND LAST_DAY(TO_DATE('01/'||NUMES||'/'||NUANO,'DD/MM/YYYY')) >= ADD_MONTHS(SYSDATE,-12)
      ;
       return(VECES);
  EXCEPTION
       WHEN OTHERS THEN
            RETURN(0);
  end fnc_VECES_MORA_ANO;

  function fnc_FECHA_SUSPENSION (inuproducto in pr_product.product_id%type) return date is --(Fecha última suspensiOn)
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_FECHA_SUSPENSION

    Proposito:
    Determina Fecha ultima suspension

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/
  DIADIA DATE;
  Begin

       SELECT O.LEGALIZATION_DATE INTO DIADIA
        FROM PR_PRODUCT p, or_order_activity oa, or_order o
        WHERE p.PRODUCT_ID = inuproducto
        and o.order_id = oa.order_id
        and OA.ORDER_ACTIVITY_ID = P.SUSPEN_ORD_ACT_ID;
       return(DIADIA);
  EXCEPTION
       WHEN OTHERS THEN
            RETURN(NULL);
  end fnc_FECHA_SUSPENSION;

  function fnc_HACE_SUSPENDIDO (inuproducto in pr_product.product_id%type) return number is --(Cuantos días lleva suspendido)
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_HACE_SUSPENDIDO

    Proposito:
    Determina Cuantos dias lleva suspendido

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/

  DIADIA DATE;
  ESCO SERVSUSC.SESUESCO%TYPE;
  Begin
         SELECT O.LEGALIZATION_DATE INTO DIADIA
          FROM PR_PRODUCT p, or_order_activity oa, or_order o
          WHERE p.PRODUCT_ID = inuproducto
            and o.order_id = oa.order_id
            and OA.ORDER_ACTIVITY_ID = P.SUSPEN_ORD_ACT_ID;

          return(SYSDATE-nvl(DIADIA,sysdate));

  EXCEPTION
       WHEN OTHERS THEN
            RETURN(0);
  end fnc_hace_suspendido;

  function fnc_VIOLA_SERVICIO (inuproducto in pr_product.product_id%type) return varchar2 is --(Si se encuentra violando el servicio)
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_viola_servicio

    Proposito:
    Determina Si se encuentra violando el servicio

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/

  Begin
       return('NO');
  EXCEPTION
       WHEN OTHERS THEN
            RETURN('NO');
  end fnc_viola_servicio;

  function fnc_VALOR_RECLAMO (inuproducto in pr_product.product_id%type) return number is --(Valor en reclamo)
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_valor_reclamo

    Proposito:
    Determina Valor en reclamo

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/
  vlor number;
  Begin
       select sum(nvl(cucovare,0)) into vlor from cuencobr where cuconuse=inuproducto;
       return(vlor);
  EXCEPTION
       WHEN OTHERS THEN
            RETURN(0);
  end fnc_valor_reclamo;

  function fnc_FECHA_RECLAMO (inuproducto in pr_product.product_id%type) return date IS --(Fecha del último reclamo)
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_FECHA_RECLAMO

    Proposito:
    Determina Fecha del ultimo reclamo

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/
  DIADIA DATE;
  Begin
       SELECT MAX(P.REQUEST_DATE)
              INTO DIADIA
              FROM MO_PACKAGES P, MO_MOTIVE M
              WHERE P.PACKAGE_TYPE_ID IN (545,966,100345,100335) AND
                    P.PACKAGE_ID=M.PACKAGE_ID AND
                    M.PRODUCT_ID=INUPRODUCTO AND
                    P.MOTIVE_STATUS_ID = 14;
       return(DIADIA);
  EXCEPTION
       WHEN OTHERS THEN
            RETURN(SYSDATE);
  end fnc_FECHA_RECLAMO;

  function fnc_DETALLE_RECLAMO (inuproducto in pr_product.product_id%type) return varchar2 is --(Detalle del último reclamo)
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_DETALLE_RECLAMO

    Proposito:
    Determina Detalle del ultimo reclamo

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/
  DETALLE VARCHAR2(4000);

  Begin
       SELECT COMMENT_
              INTO DETALLE

       FROM (       SELECT  P.COMMENT_
              FROM MO_PACKAGES P, MO_MOTIVE M
              WHERE P.PACKAGE_TYPE_ID IN (545,966,100345,100335) AND
                    P.PACKAGE_ID=M.PACKAGE_ID AND
                    M.PRODUCT_ID=INUPRODUCTO AND
                    P.MOTIVE_STATUS_ID =14
              ORDER BY P.REQUEST_DATE DESC)
        WHERE ROWNUM < 2;
       return(DETALLE);
  EXCEPTION
       WHEN OTHERS THEN
            RETURN('');
  end fnc_DETALLE_RECLAMO;

  function fnc_PROMEDIO_PAGOS (inuproducto in pr_product.product_id%type) return number is --(Promedio pagos en los últimos N meses)
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_PROMEDIO_PAGOS

    Proposito:
    Determina Promedio pagos en los últimos N meses

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/
  VLR NUMBER;
   nuMeses NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('PARMESESCARTESP', NULL);
  Begin
       SELECT AVG(CARGVALO) INTO VLR
       FROM CARGOS
       WHERE CARGNUSE=INUPRODUCTO AND CARGSIGN='PA' AND CARGFECR>ADD_MONTHS(SYSDATE,-nuMeses);
       RETURN(VLR);
  EXCEPTION
       WHEN OTHERS THEN
            RETURN(0);
  end fnc_PROMEDIO_PAGOS;
  function fnc_FECHA_PAGO (inuproducto in pr_product.product_id%type) return date is --(Fecha del último pago)
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_FECHA_PAGO

    Proposito:
    Determina Fecha del último pago

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/
  diadia date;
  Begin
     /*  select max(cargfecr) into diadia
       from cargos
       where CARGNUSE=INUPRODUCTO
          AND CARGSIGN='PA';*/

         SELECT max(PAGOFEPA) into diadia
      FROM pagos p, servsusc
      WHERE sesunuse = INUPRODUCTO
       and P.PAGOSUSC = sesususc
       and exists (select 1
                   from cargos
                   where CARGNUSE=sesunuse
                      AND CARGSIGN='PA'
                      and cargcodo = p.pagocupo);

       return(diadia);
  EXCEPTION
       WHEN OTHERS THEN
            RETURN(null);
  end fnc_FECHA_PAGO;

  function fnc_DIAS_PAGO_FACTURA (inuproducto in pr_product.product_id%type) return number is --(Promedio de días que demora en pagar las facturas, de los últimos N pagos)
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_DIAS_PAGO_FACTURA

    Proposito:
    Determina Promedio de días que demora en pagar las facturas, de los últimos N pagos

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/

  nuMeses NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('PARMESESCARTESP', NULL);

  cursor cuentas is
         select cucofepa,factfege
          from cuencobr , factura
          where factcodi = cucofact and
                factprog = 6 and
                cuconuse = inuproducto and
                factfege > ADD_MONTHS(SYSDATE,-nuMeses) and
                cucosacu = 0;
  npagos        number;
  nacum         number;
  diferencia    number;
  Begin
       npagos:=0;
       nacum :=0;
       for c in cuentas loop
           diferencia:=c.cucofepa-c.factfege;
           nacum:=nacum+diferencia;
           npagos:=npagos+1;
       end loop;
       if npagos=0 then
          return(0);
       else
          return(nacum/npagos);
       end if;
  EXCEPTION
       WHEN OTHERS THEN
            RETURN(0);
  end fnc_DIAS_PAGO_FACTURA;


  function fnc_REFINANCIACION_ACTIVA (inuproducto in pr_product.product_id%type) return VARCHAR2 is --(tiene refinanciacion activa)
  /*******************************************************************************
    Propiedad intelectual:   GASES DEL CARIBE
    Autor:                   HORBATH TECHNOLOGIES
    Fecha creacion:          17-11-2018
    Nombre:                  fnc_REFINANCIACION_ACTIVA

    Proposito:
    Determina tiene refinanciacion activa

    Parametros:
    inuproducto : codigo producto

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    17-11-2018      caso 200-2241 Creacion.

    *******************************************************************************/
  RPTA VARCHAR2(2);
  N NUMBER;
  Begin
       SELECT COUNT(1)
              INTO N
              FROM DIFERIDO
              WHERE DIFENUSE=INUPRODUCTO AND
                    DIFEPROG IN ('GCNED', 'FINAN') AND
                    DIFESAPE>0;
       IF N=0 THEN
          RPTA:='NO';
       ELSE
          RPTA:='SI';
       END IF;
       RETURN(RPTA);
  EXCEPTION
       WHEN OTHERS THEN
            RETURN('NO');
  end FNC_REFINANCIACION_ACTIVA;
end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKCALCDATCARTESP', 'ADM_PERSON');
END;
/
