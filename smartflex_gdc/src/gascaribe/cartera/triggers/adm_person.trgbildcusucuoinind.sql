CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBILDCUSUCUOININD

BEFORE INSERT OR UPDATE ON ldc_usucuoinind

FOR EACH ROW

DECLARE

  nuExiste    suscripc.susccodi%type;

BEGIN



  IF :new.porc_cuotaini <= 0  THEN

      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,

                                       'Porcentaje debe ser mayor a cero(0)');

  END IF;



  IF :new.porc_cuotaini is null  THEN

      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,

                                       'Porcentaje no puede ser nulo');

  END IF;

  IF :new.FECHA_VENCIMIENTO is null  THEN

      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,

                                       'Fecha no puede ser nula');

  END IF;



  if :new.producto > 0 then

    BEGIN

        select 1 into nuExiste

        from servsusc

        where sesunuse = :new.producto

          and sesucate = 2;

    EXCEPTION WHEN NO_DATA_FOUND THEN

        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,

                                         'Producto debe ser categoria 2-Comercial');

    END;

  else



    if (:new.contrato > 0)  then

      BEGIN

          select 1 into nuExiste

          from servsusc

          where sesususc = :new.contrato

            and sesucate = 2

            and rownum = 1;

          :new.producto := null;

      EXCEPTION WHEN NO_DATA_FOUND THEN

          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,

                                           'Contrato debe ser categoria 2-Comercial');

      END;

    else

      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,

                                       'Numero de Contrato inv?lido');

    end if;

  end if;



  EXCEPTION

    WHEN ex.CONTROLLED_ERROR THEN

      RAISE ex.CONTROLLED_ERROR;

    WHEN OTHERS THEN

      Errors.setError;

      RAISE ex.CONTROLLED_ERROR;

END;
/
