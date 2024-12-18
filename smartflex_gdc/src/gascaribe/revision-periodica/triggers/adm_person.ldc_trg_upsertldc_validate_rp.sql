CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_UPSERTLDC_VALIDATE_RP
BEFORE insert or update ON  LDC_VALIDATE_RP
 FOR EACH ROW
BEGIN

/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : ldc_trg_upsertLDC_VALIDATE_RP
    Descripcion    : Trigger para validar la configuraciób de LDC_VALIDATE_RP
    Autor          : Sayra Ocoro
    Fecha          : 28/10/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
******************************************************************/

   ut_trace.trace('Inicio ldc_trg_upsertLDC_VALIDATE_RP', 10);
   if :new.DEFECT = 'N' and :new.CRITICAL_DEFECT ='Y'  then
		 ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'Si no existe Defecto [Existe Defecto?], no se debe indicar Criticidad [Es Critico?]');
         raise ex.CONTROLLED_ERROR;
   end if;
   if :new.RESULT_RP <> '1 INSTALACION CERTIFICADA'
       and :new.RESULT_RP <> '2 INSTALACION PENDIENTE POR CERTIFICAR'
       and :new.RESULT_RP <> '3 INSTALACION APTA PARA SERVICIO'
       and :new.RESULT_RP <> '4 PENDIENTE POR CERTIFICAR NO ACEPTA TRABAJOS'then
                 ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                 'Los valores permitidos para el campo "Resultado de la Revisión" son: '|| chr(10) || chr(13)||'1 INSTALACION CERTIFICADA '|| chr(10) || chr(13)||' 2 INSTALACION PENDIENTE POR CERTIFICAR '|| chr(10) || chr(13)||' 3 INSTALACION APTA PARA SERVICIO');
                 raise ex.CONTROLLED_ERROR;
   end if;

   ut_trace.trace('Fin ldc_trg_upsertLDC_VALIDATE_RP', 10);
END LDC_TRG_UPSERTLDC_VALIDATE_RP;
/
