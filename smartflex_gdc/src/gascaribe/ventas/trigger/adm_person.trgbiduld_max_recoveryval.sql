CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIDULD_MAX_RECOVERYVAL
  after insert or delete or update on ld_max_recovery
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  trgbiduld_max_recoveryval

Descripción  : Realiza las validaciones necesarias para
               registrar un tope de cobro correctamente y
               evitar errores de tabla mutante.

Autor  : Nombre del desarrollador
Fecha  : 14-10-2012

Historia de Modificaciones
Fecha        IDEntrega             Modificación
14-10-2012   jconsuegra.SAO156577  Creación
**************************************************************/
declare
  /******************************************
      Declaración de variables y Constantes
  ******************************************/
  rcubication      dald_ubication.styld_ubication;
  nutotcantsub     ld_max_recovery.total_sub_recovery%type;
  nutotvalcob      ld_max_recovery.recovery_value%type;
  nuquantityindex  number;
begin

  --{
    -- Logica del Negocio
  --}
  nuquantityindex := LD_BOConstans.tbMaxrecovery.count;

  if INSERTING or UPDATING then

    FOR rgMaxRecovery in ld_boconstans.cnuInitial_Year..nuquantityindex LOOP

      /*Obtener datos de la ubicación geográfica*/
      DAld_ubication.getRecord (LD_BOConstans.tbMaxrecovery(rgMaxRecovery).ubication_id, rcubication);

      /*Validar que la sumatoria de cantidades a cobrar no supera la cantidad de subsidios a otorgar de la población*/
      nutotcantsub := Ld_Bcsubsidy.Fnutotquantityrecover(LD_BOConstans.tbMaxrecovery(rgMaxRecovery).ubication_id);

      if nutotcantsub > nvl(rcubication.authorize_quantity, LD_BOConstans.cnuCero_Value) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La sumatoria de los subsidios a cobrar supera la cantidad de subsidios a distribuir de la población');
      end if;

      /*Validar que la sumatoria de los valores a cobrar no supere el valor autorizado de la población*/
      nutotvalcob := Ld_Bcsubsidy.Fnutottorecover(LD_BOConstans.tbMaxrecovery(rgMaxRecovery).ubication_id);

      IF rcubication.authorize_value IS NOT NULL THEN
        if nutotvalcob > nvl(rcubication.authorize_value ,LD_BOConstans.cnuCero_Value) then
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La sumatoria de los valores a cobrar superan el monto delegado para la población');
        end if;
      END IF;

    END LOOP;

  end if;

  if DELETING then
    null;
  end if;

Exception
  When ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  When others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;

end TRGBIDULD_MAX_RECOVERYVAL;
/
