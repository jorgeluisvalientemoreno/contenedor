CREATE OR REPLACE FUNCTION adm_person.ldc_validaordeninstance (
    inuinstance_id IN NUMBER
) RETURN NUMBER IS
 /**************************************************************
  Propiedad intelectual PETI.
  Trigger  :  ldc_validaordeninstance
  Descripci¿n  :
  Autor  : 
  Fecha  : 

  Historia de Modificaciones
  FECHA             AUTOR                   MODIFICACION
  ==========        =========               ====================
  07/03/2024        Paola Acosta            OSF-2104: Se quitan referencias .open 
  29/02/2024        Paola Acosta            OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON 
  **************************************************************/

    nuproducto   pr_product.product_id%TYPE;
    nuorderid    or_order.order_id%TYPE;
    nuestadoter  NUMBER;
    nuultimasusp NUMBER;
    sbvalor      VARCHAR2(1);
    varcc        VARCHAR2(100);
    var1         VARCHAR2(2000);
    varr         VARCHAR2(2000);
    t_query      VARCHAR2(200);
    ocucursorr   constants.tyrefcursor;
    CURSOR cuinstance IS
    SELECT
        or_order_activity.product_id,
        or_order_activity.order_id
    FROM
        or_order_activity
    WHERE
        instance_id = inuinstance_id;

    CURSOR cuvalidater IS
    SELECT
        COUNT(1)
    FROM
        or_order_activity oa,
        or_order          o
    WHERE
            oa.product_id = nuproducto
        AND o.order_id = oa.order_id
        AND o.order_status_id NOT IN ( 8 )
        AND oa.activity_id IN (
            SELECT
                nvl(to_number(column_value), 0)
            FROM
                TABLE ( ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('PAR_ACTORESTNOTER', NULL), ',') )
        );

    CURSOR cuultimasusp IS
    SELECT
        COUNT(1)
    FROM
        or_order_activity,
        pr_product,
        or_order_activity suoa
    WHERE
            or_order_activity.order_id = nuorderid
        AND or_order_activity.product_id = pr_product.product_id
        AND pr_product.suspen_ord_act_id = suoa.order_activity_id
        AND suoa.activity_id IN (
            SELECT
                nvl(to_number(column_value), 0)
            FROM
                TABLE ( ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('PAR_ITACTSUSP', NULL), ',') )
        );

BEGIN
  --Instance id:
  --inuInstance_id := 99666733;
 -- inuInstance_id := 99660911;
  /*
     CA-2020030619 Se envia siempre 1 para que los flujos no se detengan, esta funcion es de EFIGAS por error
                   se instalo en gases.

  open cuInstance;
  fetch cuInstance into nuProducto,nuOrderId;
  close cuInstance;
  DBMs_output.put_line('producto: '||nuProducto||' Orden: '||nuOrderId);

  open cuValidaTer;
  fetch cuValidaTer into nuEstadoTer;
  close cuValidaTer;
  DBMs_output.put_line('Cantidad estado: '||nuEstadoTer);

  open cuUltimaSusp;
  fetch cuUltimaSusp into nuUltimaSusp;
  close cuUltimaSusp;
  DBMs_output.put_line('Cantidad ultima suspension: '||nuEstadoTer);

  --inicializacion de valibles de resultado
  varCC := dald_parameter.fsbGetValue_Chain('PAR_VALORCCDATADIC');

  IF nuOrderId IS NOT NULL THEN
                --busqueda del dato adicional
                for i in 1 .. 20 loop

                  t_query := 'select upper(d.value_' || i ||
                             ') from or_requ_data_value d where d.name_' || i ||
                             ' = ''' ||
                             dald_parameter.fsbGetValue_Chain('PAR_DATADICCERTIF') ||
                             ''' and d.order_id = ' || nuOrderId;

                  open ocuCursorR for t_query;
                  LOOP
                    FETCH ocuCursorR
                      INTO varR;
                    EXIT WHEN ocuCursorR%NOTFOUND;
                    if varR is not NULL then
                      var1 := varR;
                    end if;
                  END LOOP;
                  close ocuCursorR;
                end loop;

             if var1 is not NULL then

                 --proceso de validacion sin certificacion
                 if var1 = varCC then

                    IF nuEstadoTer = 0 and nuUltimaSusp =0 then
                      --DBMs_output.put_line('NO SE ARROJO INFORMACION');
                      sbValor:=0;
                    ELSE
                      sbValor :=1;
                    END IF;
                 else
                   sbValor :=1;
                 end if;
              else
                sbValor :=1;
              end if;
    ELSE
        sbValor :=1;
    END IF;

  */

    sbvalor := 1;
  /* END CA-2020030619 */

    RETURN sbvalor;
EXCEPTION
    WHEN ex.controlled_error THEN
        RAISE;
    WHEN OTHERS THEN
        errors.seterror;
        RAISE ex.controlled_error;
END ldc_validaordeninstance;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_VALIDAORDENINSTANCE', 'ADM_PERSON');
END;
/