CREATE OR REPLACE trigger ADM_PERSON.LDC_DETRGB_TEMPLOCFACO
  before delete on ldc_templocfaco
  for each row
/*****************************************************************
    Propiedad intelectual de Gases del Caribe S.A.

    Unidad         : LDC_UPTRGB_TEMPLOCFACO
    Descripcion    : Cada vez que se elimine registro de la tabla ldc_templocfaco
                     se debe eliminar los registros asociados de la tabla ldc_templocacapi, con la informacion de
                     la temperatura
    Autor          : Ronald Colpas Cantillo
    Fecha          : 04/01/2018

    Historia de Modificaciones
      Fecha             Autor             Modificacion
    =========         =========         ====================
    22-jun-2018       Roncol            Se modifica para que solo se permita eliminar la configuracion
                                        siempre y cuando esta no este aprobada
    10-oct-2024       jpinedc           OSF-3383: Se migra a ADM_PERSON
  ******************************************************************/

declare
  -- local variables here
begin

  ut_trace.trace('Inicio LDC_DETRGB_TEMPLOCFACO', 10);

  /*Valida los datos antes de actualizar*/
  if :old.estado_apro != 'A' then
    if :new.temp_ano != :old.temp_ano or :new.temp_mes != :old.temp_mes or
       :new.capital != :old.capital or :new.variable_temperatura != :old.variable_temperatura then
      Errors.SetError(2741,
                    'Solo es permitido cambiar el valor de la variable TEMPERATURA');
      raise ex.controlled_error;
    end if;
  else
    Errors.SetError(2741,
                    'No se puede eliminar los datos, la temperatura para la capital: '||:old.capital||' se encuentra aprobada');
    raise ex.controlled_error;
  end if;

  /*Elimina los registros de la tabla ldc_templocacapi*/
  delete from ldc_templocacapi t where capital = :old.capital;

  ut_trace.trace('Fin LDC_DETRGB_TEMPLOCFACO', 10);

EXCEPTION
  when ex.CONTROLLED_ERROR then
    pkErrors.Pop;
    raise;
end LDC_DETRGB_TEMPLOCFACO;
/
