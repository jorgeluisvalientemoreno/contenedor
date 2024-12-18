CREATE OR REPLACE trigger ADM_PERSON.LDC_UPTRGB_TEMPLOCFACO
  before update on ldc_templocfaco
  for each row

  /*****************************************************************
    Propiedad intelectual de Gases del Caribe S.A.

    Unidad         : LDC_UPTRGB_TEMPLOCFACO
    Descripcion    : Cada vez que se haga UPDATE a la tabla ldc_templocfaco
                     se debe hacer update a la tabla LDC_TEMP_VAVAFACO, con la informacion de
                     la temperatura
    Autor          : Ronald Colpas Cantillo
    Fecha          : 04/01/2018

    Historia de Modificaciones
      Fecha             Autor             Modificacion
    =========         =========         ====================
    22-jun-2018       Roncol            Se modifica para que solo se permita actualizar el valor de la tempertura
                                        siempre y cuando esta no este aprovada
    29-abr-2019       Roncol            C2002551 para que pueda actualizar la fecha final de vigencia de las temperaturas aprobadas
    18-oct-2024       jpinedc           OSF-3383: Se migra a ADM_PERSON           
  ******************************************************************/

declare

  nuValtemp cm_vavafaco.vvfcvalo%type;

  -- local variables here
  cursor cuTemperatura is
    Select *
      from (select v.vvfcvalo
              from cm_vavafaco v
             where v.vvfcvafc = 'TEMPERATURA'
               and v.vvfcubge = :old.capital
             order by v.vvfccons desc)
     where rownum = 1;

begin

  ut_trace.trace('Inicio LDC_UPTRGB_TEMPLOCFACO', 10);


  /*Valida los datos antes de actualizar*/
  if :old.estado_apro != 'A' then
    if :new.temp_ano != :old.temp_ano or :new.temp_mes != :old.temp_mes or
       :new.capital != :old.capital or :new.variable_temperatura != :old.variable_temperatura then
      Errors.SetError(2741,
                    'Solo es permitido cambiar el valor de la variable TEMPERATURA');
      raise ex.controlled_error;
    end if;
  elsif :new.fecha_fin != :old.fecha_fin then
    goto fim_proc;
  else
    Errors.SetError(2741,
                    'No se puede actualizar los datos, la temperatura para la capital: '||:old.capital||' se encuentra aprobada');
    raise ex.controlled_error;
  end if;

  --Realiza calculo de la temperatura promedio
  --Calcular valor promedio de la temperatura
  open cuTemperatura;
  fetch cuTemperatura into nuValTemp;
  if cuTemperatura%notfound then
    close cuTemperatura;
    Errors.SetError(2741,
                    'No se encontro valor de temperatura anterior, para la capital: ' || :new.capital );
    raise ex.controlled_error;
  else
    close cuTemperatura;
  end if;

  :new.valor_prom := (:new.valor + nuValtemp) / 2;

  if :old.estado_apro = 'R' then
    :new.estado_apro := 'P';
    update ldc_templocacapi
       set estado_apro = 'P'
     where temp_ano = :old.temp_ano
       and temp_mes = :old.temp_mes
       and capital = :old.capital;
  end if;

  <<fim_proc>>
  ut_trace.trace('Fin LDC_UPTRGB_TEMPLOCFACO', 10);

EXCEPTION
  when ex.CONTROLLED_ERROR then
    pkErrors.Pop;
    raise;
end LDC_UPTRGB_TEMPLOCFACO;
/
