CREATE OR REPLACE trigger ADM_PERSON.LDC_TRGA_TEMPLOCFACO
  after insert on ldc_templocfaco
  for each row
  /*****************************************************************
    Propiedad intelectual de Gases del Caribe S.A.

    Unidad         : LDC_TRGA_TEMPLOCFACO
    Descripcion    : Despues que se haga insert a la tabla ldc_templocfaco
                     se valida: que la localida tenga configurada las variables fijas
                     de LDC_VARIFACOLO, si esto es asi almacenara el valor de las variables
                     fijas con la de temperatura en ldc_templocacapi
    Autor          : Ronald Colpas Cantillo
    Fecha          : 04/01/2018

    Historia de Modificaciones
      Fecha             Autor               Modificacion
    =========           =========           ====================
    22-jun-2018         Roncol              Se modifica para que valide la si existe configuracion registrado
                                            para el periodo a?o mes.
    18-oct-2024         jpinedc             OSF-3383: Se migra a ADM_PERSON
  ******************************************************************/

declare

  nuExL Number;
  --Consultamos las localidades asociadas a la ciudad capital
  cursor culdc_capilocafaco is
    select *
      from ldc_capilocafaco c
     where c.capital = :new.capital
     order by c.localidad;

  --Consulta si la localida tiene configurada las variables fijas
  /*
  cursor cuLdc_varifacolo(nuLoca Ldc_varifacolo.Ubicacion_Localidad%type) is
    select * from ldc_varifacolo v where v.ubicacion_localidad = nuLoca;
  */
begin

  ut_trace.trace('Inicio LDC_TRGA_TEMPLOCFACO', 10);

  --Validamos si la ciudad capital tenga localidades asociadas
  select count(*)
    into nuExL
    from ldc_capilocafaco c
   where c.capital = :new.capital;
  if nuExL = 0 then
    Errors.SetError(2741,
                    'No se encontro localidades configuradas para la localidad capital: '|| :new.capital || ' (Ldc_capilocafaco)');
    raise ex.controlled_error;

  end if;

  --Validad que hayan variables configuradas para la localidad
  select count(*)
    into nuExL
    from ldc_capilocafaco, Ldc_varifacolo
   where (capital = :new.capital or localidad = :new.capital)
     and ubicacion_localidad = localidad;
  if nuExL = 0 or nuExL is null then
    Errors.SetError(2741,
                    'La localidad Capital: ' || :new.capital || ', no tiene ' ||
                    'configurada localidades con variables fijas (Ldc_varifacolo)');
    raise ex.controlled_error;
  end if;

  --Valida que las variables fijas para la localidad esten configuradas con sus valores
  select count(*)
    into nuExL
    from ldc_capilocafaco, Ldc_varifacolo
   where (capital = :new.capital or localidad = :new.capital)
     and ubicacion_localidad = localidad
     and valor_variable is null
     and promedio_variable is null;
  if nuExL > 0 or nuExL is null then
    Errors.SetError(2741,
                    'Las localidades asociadas a la ciudad capital: ' ||
                    :new.capital || ', no tienen ' ||
                    'configurados los valores de las variables fijas (Ldc_varifacolo)');
    raise ex.controlled_error;
  end if;

  --Se procesa la informacion si las validaciones son correctas
  for rg in culdc_capilocafaco loop

    --Inserta la temperatura de las localidades asociadas a la capital.
    insert into Ldc_Templocacapi
        (temp_ano,
         temp_mes,
         localidad,
         capital,
         fech_reg,
         estado_apro,
         fech_apro,
         usuario,
         terminal)
      values
        (:new.temp_ano,
         :new.temp_mes,
         rg.localidad,
         :new.capital,
         trunc(sysdate),
         'P',
         null,
         user,
         userenv('TERMINAL'));

  end loop;

  ut_trace.trace('Fin LDC_TRGA_TEMPLOCFACO', 10);

EXCEPTION
  when ex.CONTROLLED_ERROR then
    pkErrors.Pop;
    raise;

end LDC_TRGA_TEMPLOCFACO;
/
