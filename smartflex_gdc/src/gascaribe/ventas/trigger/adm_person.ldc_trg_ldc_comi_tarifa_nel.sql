CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_LDC_COMI_TARIFA_NEL BEFORE INSERT or update
ON LDC_COMI_TARIFA_NEL
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW

/************************************************************************
PROPIEDAD INTELECTUAL DE JM
PROCEDIMIENTO           : LDC_TRGINSLDC_COMI_TARIFA_NEL
AUTOR                : Sebastian Tapias
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
    gsberrmsg           ge_error_log.description%TYPE; /*variable para error de excepcion*/
    cnunull_attribute   CONSTANT NUMBER := 2741; /*constante*/
    nuCodigoError       NUMBER;
    sbMensajeError      VARCHAR2(4000);

    CURSOR cuLdcCTTaricomi
    (
        inuComision_plan_id IN  LDC_COMI_TARIFA_NEL.COMISION_PLAN_ID%type,
        idtfechaini         IN  LDC_COMI_TARIFA_NEL.FECHA_VIG_INICIAL%type,
        idtfechafin         IN  LDC_COMI_TARIFA_NEL.FECHA_VIG_FINAL%type
    )
    IS
      SELECT nvl(comi_tarifa_id,0) --COUNT(1)
      from LDC_COMI_TARIFA_NEL
      where COMISION_PLAN_ID = inuComision_plan_id
      and (idtfechaini  BETWEEN FECHA_VIG_INICIAL and FECHA_VIG_FINAL or
               idtfechafin  BETWEEN   FECHA_VIG_INICIAL and FECHA_VIG_FINAL)
      and comi_tarifa_id <> :new.comi_tarifa_id;


   PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN

     if INSERTING  then
        IF cuLdcCTTaricomi%ISOPEN
        THEN
            CLOSE cuLdcCTTaricomi;
        END IF;

        OPEN cuLdcCTTaricomi(:new.COMISION_PLAN_ID,
                             :new.FECHA_VIG_INICIAL,:new.FECHA_VIG_FINAL);

        FETCH cuLdcCTTaricomi INTO nuOk;
        CLOSE cuLdcCTTaricomi;

        IF nuOk > 0 THEN
           rollback;
           errors.seterror(2741, 'Los rangos que esta ingresando se traslapan con otros.  ver registro id :'||nuOk||' Pesta?a: Tarifa para vendedores');
           RAISE ex.controlled_error;
        END IF;
        IF  (:new.PORC_TOTAL_COMI is null) THEN
            errors.seterror(2741, 'El porcertanje de la comision no puede ser nulo.  ver registro id :'||:new.COMI_TARIFA_ID||' Pesta?a: Tarifa para vendedores');
            RAISE ex.controlled_error;
        END IF;
        IF  nvl(:new.PORC_TOTAL_COMI,0) > 0 and ((nvl(:new.PORC_ALINICIO,0) + nvl(:new.PORC_ALFINAL,0)) <> 100) THEN
            errors.seterror(2741, 'La suma de porcentajes debe ser igual a 100 %.  ver registro id :'||:new.COMI_TARIFA_ID||' Pesta?a: Tarifa para vendedores');
            RAISE ex.controlled_error;
        END IF;
        IF  nvl(:new.PORC_TOTAL_COMI,0) = 0 and ((nvl(:new.PORC_ALINICIO,0) + nvl(:new.PORC_ALFINAL,0)) > 0) THEN
            errors.seterror(2741, 'si el % total de la comision es zero los porcentajes de aplicacion deben ser igual a zero.  ver registro id :'||
                                   :new.COMI_TARIFA_ID||' Pesta?a: Tarifa para vendedores');
            RAISE ex.controlled_error;
        END IF;

     elsif UPDATING then
      IF cuLdcCTTaricomi%ISOPEN
        THEN
            CLOSE cuLdcCTTaricomi;
        END IF;

         OPEN cuLdcCTTaricomi(:new.COMISION_PLAN_ID,
                             :new.FECHA_VIG_INICIAL,:new.FECHA_VIG_FINAL);

        FETCH cuLdcCTTaricomi INTO nuOk;
        CLOSE cuLdcCTTaricomi;

        IF nuOk > 0 THEN
          rollback;
           errors.seterror(2741, 'Los rangos que esta ingresando se traslapan con otros.  ver registro id :'||nuOk||' Pesta?a: Tarifa para vendedores');
           RAISE ex.controlled_error;
        END IF;
        IF  (:new.PORC_TOTAL_COMI is null) THEN
            errors.seterror(2741, 'El porcertanje de la comision no puede ser nulo.  ver registro id :'||:new.COMI_TARIFA_ID||' Pesta?a: Tarifa para vendedores');
            RAISE ex.controlled_error;
        END IF;
        IF  nvl(:new.PORC_TOTAL_COMI,0) > 0 and ((nvl(:new.PORC_ALINICIO,0) + nvl(:new.PORC_ALFINAL,0)) <> 100) THEN
            errors.seterror(2741, 'La suma de porcentajes debe ser igual a 100 %.  ver registro id :'||:new.COMI_TARIFA_ID||' Pesta?a: Tarifa para vendedores');
            RAISE ex.controlled_error;
        END IF;
        IF  nvl(:new.PORC_TOTAL_COMI,0) = 0 and ((nvl(:new.PORC_ALINICIO,0) + nvl(:new.PORC_ALFINAL,0)) > 0) THEN
            errors.seterror(2741, 'si el % total de la comision es zero los porcentajes de aplicacion deben ser igual a zero.  ver registro id :'||
                                  :new.COMI_TARIFA_ID||' Pesta?a: Tarifa para vendedores');
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
