CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGINSLDC_PLANDIFE BEFORE INSERT or update
ON LDC_PLANDIFE
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW

/************************************************************************
PROPIEDAD INTELECTUAL DE PETI . 2013
PROCEDIMIENTO        : LDC_TRGINSLDC_PLANDIFE
AUTOR                : EMIRO LEYVA
FECHA                : 20 de Noviembre de 2013
DESCRIPCION          : Valida que no se traslapen los rangos de saldo

                       Valida tambien que el % no se mayor a 100 %

Parametros de Entrada
Parametros de Salida

Historia de Modificaciones
Autor                   Fecha           Descripcion
acardenas.NC3085        22-10-2014      Se modifica el CURSOR cuLDCPlandife
                                        por impacto en la tabla LDC_PLANDIFE.
Lubin Pineda            18-10-2024      OSF-3383: Se migra a ADM_PERSON                                        
************************************************************************/
DECLARE

    nuOK                number;
    gsberrmsg           ge_error_log.description%TYPE; /*variable para error de excepción*/
    cnunull_attribute   CONSTANT NUMBER := 2741; /*constante*/
    nuCodigoError       NUMBER;
    sbMensajeError      VARCHAR2(4000);

    CURSOR cuLdcplandife
    (
        inuPLDICODI         IN  LDC_PLANDIFE.PLDICODI%type,
        inuRANG_SALDO_INI   IN  LDC_PLANDIFE.RANG_SALDO_INI%type,
        inuRANG_SALDO_FIN   IN  LDC_PLANDIFE.RANG_SALDO_FIN%type,
        inuNIVEL_SUSP       IN  LDC_PLANDIFE.NIVEL_SUSP%type
    )
    IS
      SELECT COUNT(1)
      FROM   LDC_PLANDIFE
      WHERE  PLDICODI = inuPLDICODI
             AND ((inuRANG_SALDO_INI   between RANG_SALDO_INI and RANG_SALDO_FIN) or
                 (inuRANG_SALDO_FIN   between RANG_SALDO_INI and RANG_SALDO_FIN))
             AND  nvl(NIVEL_SUSP,-1) = nvl(inuNIVEL_SUSP,-1);


BEGIN
     if INSERTING  then
        IF cuLdcplandife%ISOPEN
        THEN
            CLOSE cuLdcplandife;
        END IF;

        OPEN cuLdcplandife(:new.PLDICODI, :new.RANG_SALDO_INI, :new.RANG_SALDO_FIN, :new.NIVEL_SUSP);

        FETCH cuLdcplandife INTO nuOk;
        CLOSE cuLdcplandife;

        IF nuOk > 0 THEN
           errors.seterror(2741, 'Los rangos de saldo que está ingresando se traslapan con otros.  ver registro id :'
		                        ||:new.PLANDIFE_ID||' Pestaña: Politicas Cuota Inicial');
           RAISE ex.controlled_error;
        END IF;

        IF  :new.PORC_CUOTA > 100 THEN
            errors.seterror(2741, 'El % de cuota inicial no puede ser mayor a 100 %.  ver registro id :'
			                 ||:new.PLANDIFE_ID||' Pestaña: Politicas Cuota Inicial');
            RAISE ex.controlled_error;
        END IF;

        if nvl(:new.PORC_CUOTA,0) > 0 and nvl(:new.VALOR_CUOTA_FIJA,0) > 0  then
            errors.seterror(2741, 'La cuota inicial solo se debe definir por un solo concepto ya sea por porcentaje o por valor.  ver registro id :'||
                                   :new.PLANDIFE_ID||' Pestaña: Politicas Cuota Inicial');
            RAISE ex.controlled_error;
        END IF;

        if  nvl(:new.VALOR_CUOTA_FIJA,0) > 0 and nvl(:new.PORC_CUOTA,0) > 0 then
           errors.seterror(2741, 'La cuota inicial solo se debe definir por un solo concepto ya sea por porcentaje o por valor.  ver registro id :'||
                                   :new.PLANDIFE_ID||' Pestaña: Politicas Cuota Inicial');
            RAISE ex.controlled_error;
        END IF;
        if (nvl(:new.VALOR_CUOTA_FIJA,0) + nvl(:new.PORC_CUOTA,0)) = 0 then
            errors.seterror(2741, 'Debe definir el valor de cuota inicial ya sea por % o por valor.  ver registro id :'||
                                   :new.PLANDIFE_ID||' Pestaña: Politicas Cuota Inicial');
            RAISE ex.controlled_error;
        END IF;
        if  nvl(:new.PORC_CUOTA,0) > 0 and :new.TIPO_CARTERA is null then
            errors.seterror(2741, 'Debe definir el tipo de cartera.  ver registro id :'||
                                   :new.PLANDIFE_ID||' Pestaña: Politicas Cuota Inicial');
            RAISE ex.controlled_error;
        END IF;
        if  nvl(:new.VALOR_CUOTA_FIJA,0) >  nvl(:new.RANG_SALDO_FIN,0) then
            errors.seterror(2741, 'El valor de la cuota fija no debe ser mayor al rango del saldo final.  ver registro id :'||
                                   :new.PLANDIFE_ID||' Pestaña: Politicas Cuota Inicial');
            RAISE ex.controlled_error;
        END IF;
     elsif UPDATING then
        if :OLD.RANG_SALDO_INI <> :new.RANG_SALDO_INI or :OLD.RANG_SALDO_FIN <> :new.RANG_SALDO_FIN then
            errors.seterror(2741, 'No se puede modificar los valores a los rangos, si quiere modificarlo debe borrarlo y crear el nuevo.  ver registro id :'||
                                  :new.PLANDIFE_ID||' Pestaña: Politicas Cuota Inicial');
            RAISE ex.controlled_error;
        END IF;
        IF  :new.PORC_CUOTA > 100 THEN
            errors.seterror(2741, 'El % de cuota inicial no puede ser mayor a 100 %.  ver registro id :'
			                 ||:new.PLANDIFE_ID||' Pestaña: Politicas Cuota Inicial');
            RAISE ex.controlled_error;
        END IF;

        if nvl(:new.PORC_CUOTA,0) > 0 and nvl(:new.VALOR_CUOTA_FIJA,0) > 0  then
            errors.seterror(2741, 'La cuota inicial solo se debe definir por un solo concepto ya sea por porcentaje o por valor.  ver registro id :'||
                                   :new.PLANDIFE_ID||' Pestaña: Politicas Cuota Inicial');
            RAISE ex.controlled_error;
        END IF;

        if nvl(:new.VALOR_CUOTA_FIJA,0) > 0 and nvl(:new.PORC_CUOTA,0) > 0 then
           errors.seterror(2741, 'La cuota inicial solo se debe definir por un solo concepto ya sea por porcentaje o por valor.  ver registro id :'||
                                   :new.PLANDIFE_ID||' Pestaña: Politicas Cuota Inicial');
            RAISE ex.controlled_error;
        END IF;
        if (nvl(:new.VALOR_CUOTA_FIJA,0) + nvl(:new.PORC_CUOTA,0)) = 0 then
            errors.seterror(2741, 'Debe definir el valor de cuota inicial ya sea por % o por valor.  ver registro id :'||
                                   :new.PLANDIFE_ID||' Pestaña: Politicas Cuota Inicial');
            RAISE ex.controlled_error;
        END IF;
        if  nvl(:new.PORC_CUOTA,0) > 0 and :new.TIPO_CARTERA is null then
            errors.seterror(2741, 'Debe definir el tipo de cartera.  ver registro id :'||
                                   :new.PLANDIFE_ID||' Pestaña: Politicas Cuota Inicial');
            RAISE ex.controlled_error;
        END IF;
        if  nvl(:new.VALOR_CUOTA_FIJA,0) >  nvl(:new.RANG_SALDO_FIN,0) then
            errors.seterror(2741, 'El valor de la cuota fija no debe ser mayor al rango del saldo final.  ver registro id :'||
                                   :new.PLANDIFE_ID||' Pestaña: Politicas Cuota Inicial');
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
