CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGINSLDC_CT_TARIBOVE BEFORE INSERT OR UPDATE ON LDC_CT_TARIBOVE
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
/************************************************************************
PROPIEDAD INTELECTUAL DE PETI . 2013
PROCEDIMIENTO           : LDC_TRGINSLDC_CT_TARIBOVE
AUTOR                : EMIRO LEYVA
FECHA                 : 23 de ENERO de 2013
DESCRIPCION   : Valida que no se traslapen los rangos parametrizados para la cantidad de ventas

Parametros de Entrada
Parametros de Salida
Historia de Modificaciones
Autor   Fecha   Descripcion
************************************************************************/

DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    nuOK                number;
    gsberrmsg           ge_error_log.description%TYPE; /*variable para error de excepci¿n*/
    cnunull_attribute   CONSTANT NUMBER := 2741; /*constante*/
    nuCodigoError       NUMBER;
    sbMensajeError      VARCHAR2(4000);
    CURSOR cuLdcCTTaribove
    (
        inuAnyo             IN  ldc_ct_taribove.ano%type,
        inuMes              IN  ldc_ct_taribove.mes%type,
        inuGeogLocId        IN  ldc_ct_taribove.geograp_location_id%type,
        inuPersonId         IN  ldc_ct_taribove.person_id%type,
        inuZona             IN  ldc_ct_taribove.zona_venta%type,
        inuEdadIngreso      IN  ldc_ct_taribove.edad_ingreso_vendedor%type,
        inuRangoInicial     IN  ldc_ct_taribove.rango_inicial%type,
        inuRangoFinal       IN  ldc_ct_taribove.rango_final%type
    )
    IS
      SELECT COUNT(1)
      from LDC_CT_TARIBOVE
      where ano = inuAnyo
      and   mes = inuMes
      and   GEOGRAP_LOCATION_ID = inuGeogLocId
      and   PERSON_ID =  inuPersonId
      and   ZONA_VENTA = inuZona
      and   EDAD_INGRESO_VENDEDOR = inuEdadIngreso
      AND   ((inuRangoInicial between RANGO_INICIAL and RANGO_FINAL) or
                     (inuRangoFinal   between RANGO_INICIAL and RANGO_FINAL) or
                     (RANGO_INICIAL between inuRangoInicial and inuRangoFinal) or
             (RANGO_FINAL   between inuRangoFinal and inuRangoFinal));

BEGIN
     if inserting then
        IF cuLdcCTTaribove%ISOPEN
        THEN
           CLOSE cuLdcCTTaribove;
        END IF;

        OPEN cuLdcCTTaribove(:new.ano, :new.mes, :new.GEOGRAP_LOCATION_ID, :new.PERSON_ID,
                          :new.ZONA_VENTA,:new.EDAD_INGRESO_VENDEDOR, :new.RANGO_INICIAL,
                          :new.RANGO_FINAL);

        FETCH cuLdcCTTaribove INTO nuOk;
        CLOSE cuLdcCTTaribove;

        IF nuOk > 0 THEN
           errors.seterror(2741, 'Los rangos que est¿ ingresando se traslapan con otros');
           RAISE ex.controlled_error;
        END IF;
      end if;
EXCEPTION

    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 THEN
        pkErrors.GetErrorVar( nuCodigoError, sbMensajeError );
        RAISE;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbMensajeError );
        RAISE;
END;
/
