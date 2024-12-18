CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_LDC_INFO_OPER_UNIT_NEL BEFORE INSERT ON LDC_INFO_OPER_UNIT_NEL
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW

/************************************************************************
PROPIEDAD INTELECTUAL DE JM
PROCEDIMIENTO           : LDC_TRGINSLDC_INFO_OPER_UNIT_NEL
AUTOR                : Sebastian Tapias
FECHA                : 05 de mARZO de 2013
DESCRIPCION          : ACTUALIZA EL VALOR DE OPER_UNIT_ID CON EL VALOR OPERATING_UNIT_ID
                       PARA PODER MOSTRAR EL CODIGO Y LA DESCRIPCION YA QUE EL CONFIGURADOR NO LO PERMITE
                       DE OTRA MANERA
Parametros de Entrada
Parametros de Salida
Historia de Modificaciones
Autor   Fecha   Descripcion
************************************************************************/

DECLARE

    nuOK                number;
    gsberrmsg           ge_error_log.description%TYPE; /*variable para error de excepci??n*/
    cnunull_attribute   CONSTANT NUMBER := 2741; /*constante*/
    nuCodigoError       NUMBER;
    sbMensajeError      VARCHAR2(4000);

BEGIN

        :new.OPER_UNIT_ID := :new.OPERATING_UNIT_ID;

EXCEPTION

    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 THEN
        pkErrors.GetErrorVar( nuCodigoError, sbMensajeError );
        RAISE;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbMensajeError );
        RAISE;
END;
/
