CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGINSLDC_COMI_TARIFA BEFORE INSERT or update
ON LDC_COMI_TARIFA
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW

/************************************************************************
PROPIEDAD INTELECTUAL DE PETI . 2013
PROCEDIMIENTO           : LDC_TRGINSLDC_COMI_TARIFA
AUTOR                : EMIRO LEYVA
FECHA                : 28 de Febrero de 2013
DESCRIPCION          : Valida que no se traslapen los rangos parametrizados
                       para el porcentaje de penetracion de las tarifas de comision de ventas

                       Valida tambien que el valor del rango final de petracion de la saturacion no sea
                       mayor a 100 porciento

Parametros de Entrada
Parametros de Salida
Historia de Modificaciones
Autor   Fecha   Descripcion
************************************************************************/

DECLARE

    nuOK                number;
    gsberrmsg           ge_error_log.description%TYPE; /*variable para error de excepción*/
    cnunull_attribute   CONSTANT NUMBER := 2741; /*constante*/
    nuCodigoError       NUMBER;
    sbMensajeError      VARCHAR2(4000);

    CURSOR cuLdcCTTaricomi
    (
        inuComision_plan_id IN  ldc_comi_tarifa.COMISION_PLAN_ID%type,
        inuRangoInicial     IN  ldc_comi_tarifa.RANG_INI_PENETRA%type,
        inuRangoFinal       IN  ldc_comi_tarifa.RANG_FIN_PENETRA%type,
        idtfechaini         IN  ldc_comi_tarifa.FECHA_VIG_INICIAL%type,
        idtfechafin         IN  ldc_comi_tarifa.FECHA_VIG_FINAL%type
    )
    IS
      SELECT nvl(comi_tarifa_id,0) --COUNT(1)
      from LDC_COMI_TARIFA
      where COMISION_PLAN_ID = inuComision_plan_id
      and  ((inuRangoInicial BETWEEN RANG_INI_PENETRA  and  RANG_FIN_PENETRA or
            inuRangoFinal  BETWEEN RANG_INI_PENETRA  and RANG_FIN_PENETRA)
           and (idtfechaini  BETWEEN FECHA_VIG_INICIAL and FECHA_VIG_FINAL or
               idtfechafin  BETWEEN   FECHA_VIG_INICIAL and FECHA_VIG_FINAL))
      and comi_tarifa_id <> :new.comi_tarifa_id;


   PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN

     if INSERTING  then
        IF cuLdcCTTaricomi%ISOPEN
        THEN
            CLOSE cuLdcCTTaricomi;
        END IF;

        OPEN cuLdcCTTaricomi(:new.COMISION_PLAN_ID, :new.RANG_INI_PENETRA, :new.RANG_FIN_PENETRA,
                             :new.FECHA_VIG_INICIAL,:new.FECHA_VIG_FINAL);

        FETCH cuLdcCTTaricomi INTO nuOk;
        CLOSE cuLdcCTTaricomi;

        IF nuOk > 0 THEN
           rollback;
           errors.seterror(2741, 'Los rangos que está ingresando se traslapan con otros.  ver registro id :'||nuOk||' Pestaña: Tarifa para vendedores');
           RAISE ex.controlled_error;
        END IF;

        IF  :new.RANG_FIN_PENETRA > 100 THEN
            errors.seterror(2741, 'El valor del rango de penetracion final no puede ser mayor a 100 %.  ver registro id :'||:new.COMI_TARIFA_ID||' Pestaña: Tarifa para vendedores');
            RAISE ex.controlled_error;
        END IF;
        IF  nvl(:new.PORC_TOTAL_COMI,0) > 0 and ((nvl(:new.PORC_ALINICIO,0) + nvl(:new.PORC_ALFINAL,0)) <> 100) THEN
            errors.seterror(2741, 'La suma de porcentajes debe ser igual a 100 %.  ver registro id :'||:new.COMI_TARIFA_ID||' Pestaña: Tarifa para vendedores');
            RAISE ex.controlled_error;
        END IF;
        IF  nvl(:new.PORC_TOTAL_COMI,0) = 0 and ((nvl(:new.PORC_ALINICIO,0) + nvl(:new.PORC_ALFINAL,0)) > 0) THEN
            errors.seterror(2741, 'si el % total de la comisión es zero los porcentajes de aplicación deben ser igual a zero.  ver registro id :'||
                                   :new.COMI_TARIFA_ID||' Pestaña: Tarifa para vendedores');
            RAISE ex.controlled_error;
        END IF;


        if nvl(:new.PORC_TOTAL_COMI,0) > 0 and (nvl(:new.VALOR_ALINICIO,0) > 0 or nvl(:new.VALOR_ALFINAL,0) > 0) then
            errors.seterror(2741, 'La tarifa solo se debe definir por un solo concepto ya sea por porcentaje o por valor.  ver registro id :'||
                                   :new.COMI_TARIFA_ID||' Pestaña: Tarifa para vendedores');
            RAISE ex.controlled_error;
        END IF;

        if (nvl(:new.VALOR_ALINICIO,0) > 0 or nvl(:new.VALOR_ALFINAL,0) > 0) and nvl(:new.PORC_TOTAL_COMI,0) > 0 then
            errors.seterror(2741, 'La tarifa solo se debe definir por un solo concepto ya sea por porcentaje o por valor.  ver registro id :'||
                                   :new.COMI_TARIFA_ID||' Pestaña: Tarifa para vendedores');
            RAISE ex.controlled_error;
        END IF;
        if (nvl(:new.VALOR_ALINICIO,0) + nvl(:new.VALOR_ALFINAL,0) + nvl(:new.PORC_TOTAL_COMI,0)) = 0 then
            errors.seterror(2741, 'Debe definir el valor de la tarifa ya sea por % o por valor.  ver registro id :'||
                                   :new.COMI_TARIFA_ID||' Pestaña: Tarifa para vendedores');
            RAISE ex.controlled_error;
        END IF;

     elsif UPDATING then
      IF cuLdcCTTaricomi%ISOPEN
        THEN
            CLOSE cuLdcCTTaricomi;
        END IF;

        OPEN cuLdcCTTaricomi(:new.COMISION_PLAN_ID, :new.RANG_INI_PENETRA, :new.RANG_FIN_PENETRA,
                             :new.FECHA_VIG_INICIAL,:new.FECHA_VIG_FINAL);

        FETCH cuLdcCTTaricomi INTO nuOk;
        CLOSE cuLdcCTTaricomi;

        IF nuOk > 0 THEN
          rollback;
           errors.seterror(2741, 'Los rangos que está ingresando se traslapan con otros.  ver registro id :'||nuOk||' Pestaña: Tarifa para vendedores');
           RAISE ex.controlled_error;
        END IF;

        if :OLD.RANG_INI_PENETRA <> :new.RANG_INI_PENETRA or :OLD.RANG_FIN_PENETRA <> :new.RANG_FIN_PENETRA then
            errors.seterror(2741, 'No se puede modificar los valores a los rangos, si quiere modificarlo debe borrarlo y crear el nuevo.  ver registro id :'||
                                  :new.COMI_TARIFA_ID||' Pestaña: Tarifa para vendedores');
            RAISE ex.controlled_error;
            END IF;
        IF  nvl(:new.PORC_TOTAL_COMI,0) > 0 and ((nvl(:new.PORC_ALINICIO,0) + nvl(:new.PORC_ALFINAL,0)) <> 100) THEN
            errors.seterror(2741, 'La suma de porcentajes debe ser igual a 100 %.  ver registro id :'||:new.COMI_TARIFA_ID||' Pestaña: Tarifa para vendedores');
            RAISE ex.controlled_error;
        END IF;
        IF  nvl(:new.PORC_TOTAL_COMI,0) = 0 and ((nvl(:new.PORC_ALINICIO,0) + nvl(:new.PORC_ALFINAL,0)) > 0) THEN
            errors.seterror(2741, 'si el % total de la comisión es zero los porcentajes de aplicación deben ser igual a zero.  ver registro id :'||
                                  :new.COMI_TARIFA_ID||' Pestaña: Tarifa para vendedores');
            RAISE ex.controlled_error;
        END IF;
        if nvl(:new.PORC_TOTAL_COMI,0) > 0 and (nvl(:new.VALOR_ALINICIO,0) > 0 or nvl(:new.VALOR_ALFINAL,0) > 0) then
            errors.seterror(2741, 'La tarifa solo se debe definir por un solo concepto ya sea por porcentaje o por valor.  ver registro id :'||
                                   :new.COMI_TARIFA_ID||' Pestaña: Tarifa para vendedores');
            RAISE ex.controlled_error;
        END IF;
        if (nvl(:new.VALOR_ALINICIO,0) > 0 or nvl(:new.VALOR_ALFINAL,0) > 0) and nvl(:new.PORC_TOTAL_COMI,0) > 0 then
            errors.seterror(2741, 'La tarifa solo se debe definir por un solo concepto ya sea por porcentaje o por valor.  ver registro id :'||
                                   :new.COMI_TARIFA_ID||' Pestaña: Tarifa para vendedores');
            RAISE ex.controlled_error;
        END IF;
        if (nvl(:new.VALOR_ALINICIO,0) + nvl(:new.VALOR_ALFINAL,0) + nvl(:new.PORC_TOTAL_COMI,0)) = 0 then
            errors.seterror(2741, 'Debe definir el valor de la tarifa ya sea por % o por valor.  ver registro id :'||
                                  :new.COMI_TARIFA_ID||' Pestaña: Tarifa para vendedores');
            RAISE ex.controlled_error;
        END IF;

     END IF;

EXCEPTION

    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 THEN
        pkErrors.GetErrorVar( nuCodigoError, sbMensajeError );
        RAISE;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbMensajeError );
        RAISE;
END;
/
