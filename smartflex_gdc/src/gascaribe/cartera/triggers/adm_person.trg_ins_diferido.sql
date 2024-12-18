CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_INS_DIFERIDO
BEFORE INSERT ON diferido
FOR EACH ROW
/**
    Propiedad intelectual de Open International Systems. (c).

    Trigger	: TRG_INS_DIFERIDO
    Descripcion	: trigger para actualizacion de informacion de una financiacion

    Parametros	:	Descripcion

    Retorno     :

    Autor	: Alejandro Cardenas
    Fecha	: xx-xx-xxxx

    Historia de Modificaciones
    Fecha	   IDEntrega

    16-09-2014  aecheverry.3456     Se modifica para para actualizar el programa,
                                    campo difeprog,  a 'FINAN'  si el plan de
                                    financiacion se encuentra en el parametro
                                    PLAN_NEG_NO_REFINAN y asi evitar que la
                                    financiacion se tome como refinanciacion.

    XX-XX-XXXX  ACardenas           Creacion
**/
DECLARE

    -- Concepto de interes
    cnuConcepto    diferido.difecoin%type := -1;

    -- Tasa de interés
    cnuTasainte     conftain.cotiporc%type := 0;

    -- Mensaje de error
    osbErrorMessage GE_ERROR_LOG.DESCRIPTION%TYPE;

    -- Codigo de error
    onuErrorCode    GE_ERROR_LOG.ERROR_LOG_ID%TYPE;

BEGIN

    ut_trace.trace('INICIO TRG_INS_DIFERIDO',1);
    pkErrors.Push ( 'TRG_INS_DIFERIDO' );

    -- Valida el número de cuotas del diferido
    if(:new.difenucu = 1) then

        ut_trace.trace('Diferido a 1 cuota!',3);

        -- Actualiza datos del diferido
        :new.difecoin :=  cnuConcepto;
        :new.difeinte :=  cnuTasainte;
        :new.difevacu :=  :new.difesape;

        ut_trace.trace('Tasa ['||cnuTasainte||'] Concepto ['||cnuConcepto||'] Cuota ['||:new.difevacu||']',3);

    END if;

    -- se valida si el plan de financiacion se encuentra parametrizado para cambio de programa, cambio.3456
    if (instr( ','||dald_parameter.fsbGetValue_Chain('PLAN_NEG_NO_REFINAN', 0)||',', ','||:new.difepldi||',')  > 0 )then
        :new.difeprog := 'FINAN';
    END if;

    ut_trace.trace('FIN TRG_INS_DIFERIDO',1);
    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
	   pkErrors.GetErrorVar( onuErrorCode, osbErrorMessage );
	   pkErrors.Pop;
	   raise_application_error ( pkConstante.nuERROR_LEVEL2, osbErrorMessage );

    when others then
	   pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbErrorMessage);
	   pkErrors.Pop;
	   raise_application_error( pkConstante.nuERROR_LEVEL2, osbErrorMessage );

END TRG_INS_DIFERIDO;
/
