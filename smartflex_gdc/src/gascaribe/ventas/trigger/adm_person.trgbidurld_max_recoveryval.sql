CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIDURLD_MAX_RECOVERYVAL
  before insert or delete or update on ld_max_recovery
  referencing old as old new as new for each row
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  trgbidurld_subsidy_detailval

Descripción  : Realiza las validaciones necesarias para
               registrar los topes de cobro de un
               subsidio determinado.

Autor  : Nombre del desarrollador
Fecha  : 14-10-2012

Historia de Modificaciones
Fecha        IDEntrega             Modificación
21-10-2013   hjgomez.SAO224106     Se adiciona validacion para que solo permita cantidad o valor
14-10-2012   jconsuegra.SAO156577  Creación
**************************************************************/
declare
  /******************************************
      Declaración de variables y Constantes
  ******************************************/
  rcsubsidy      dald_subsidy.styLd_subsidy;
  nuSubsidy_id   ld_subsidy.subsidy_id%type;
  nucollectyear  number;
  nucollectmonth number;
  nucurrentdate  number;
  nucollectdate  number;
  nuindex        number;
  nusubasig      number := ld_boconstans.cnuCero_Value;
  cnumaxmonth    constant number := 12;

begin

  --{
    -- Logica del Negocio
  --}

  if DELETING then

    nusubasig := Ld_Bcsubsidy.Fnugetsubincollectbydate(:old.ubication_id,
                                                       :old.year,
                                                       :old.month
                                                      );

    if nusubasig > ld_boconstans.cnuCero then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'No es posible eliminar un tope de cobro de un período en donde al menos un subsidio se encuentre en estado: COBRADO');
    end if;

    nusubasig := Ld_Bcsubsidy.fnugetsubinpaybydate(:old.ubication_id,
                                                   :old.year,
                                                   :old.month
                                                  );

    if nusubasig > ld_boconstans.cnuCero then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'No es posible eliminar un tope de cobro de un período en donde al menos un subsidio se encuentre en estado: PAGADO');
    end if;

  end if;


  if INSERTING or UPDATING then

    /*Validar que el mes del tope no contenga valor cero*/
    if :new.month = ld_boconstans.cnuCero_Value then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El mes del tope de cobro no puede tener valor cero');
    end if;

    /*Validar que el mes del tope no contenga valor negativo*/
    if :new.month < ld_boconstans.cnuCero_Value then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El mes del tope de cobro no puede tener valor menor a cero');
    end if;

    /*Validar que el mes del tope no contenga valor negativo*/
    if :new.month > cnumaxmonth then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El mes del tope de cobro no puede exceder la cantidad máxima de meses de un año');
    end if;

    /*Obtener el subsidio asociado a la ubicación geográfica*/
    nuSubsidy_id := Dald_ubication.fnuGetSubsidy_Id(:new.ubication_id);

    /*Obtener los datos de un subsidio*/
    Dald_subsidy.getRecord(nuSubsidy_id, rcsubsidy);

    /*Validar que el período, año y mes, de cada tope de cobro no sea inferior al año y mes de la
      fecha de inicio de cobro definida en el encabezado del subsidio*/
    if :new.year < to_char(rcsubsidy.star_collect_date, 'YYYY') then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El año del tope de cobro no puede ser inferior al año de la fecha de inicio de cobro del subsidio');
    end if;

    nucollectyear  := to_number(to_char(rcsubsidy.star_collect_date, 'YYYY'));
    nucollectmonth := to_number(to_char(rcsubsidy.star_collect_date, 'MM'));

    nucurrentdate  := ((:new.year * 100) + :new.month);
    nucollectdate  := ((nucollectyear * 100) + nucollectmonth);

    if  nucurrentdate < nucollectdate then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El mes del tope de cobro no puede ser inferior al mes de la fecha de inicio de cobro del subsidio');
    end if;

    /*Validar concepto de exclusión de la cantidad de subsidios a cobrar y valor del subsidio a cobrar*/
    if :new.total_sub_recovery is null and :new.recovery_value is null then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Debe ingresar la cantidad o el valor de los subsidios a cobrar');
    end if;

    if :new.total_sub_recovery is not null and rcsubsidy.authorize_quantity is null then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'No existe correspondencia entre la cantidad de subsidios a cobrar y la cantidad de subsidios autorizados');
    end if;

    if :new.recovery_value is not null and rcsubsidy.authorize_value is null then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'No existe correspondencia entre el valor de los subsidios a cobrar y el valor autorizado');
    end if;

    if :new.total_sub_recovery <= LD_BOConstans.cnuCero_Value and rcsubsidy.authorize_quantity is not null then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La cantidad de subsidios a cobrar debe ser mayor a cero');
    end if;

    if :new.recovery_value <= LD_BOConstans.cnuCero_Value and rcsubsidy.authorize_value is not null then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El valor a cobrar debe ser mayor a cero');
    end if;

    /*Validar los atributos: cantidad autorizada y valor autorizado*/
    if :new.total_sub_recovery is not null and :new.recovery_value is not null then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Debe ingresar la cantidad de subsidios a cobrar o el valor a cobrar al ente pero ambos al tiempo no es posible');
    end if;

    nuindex := ld_boconstans.nuMaxrecovery;

    nuindex := nuindex + LD_BOConstans.cnuonenumber;
    --ld_boconstans.nuMaxrecovery := ld_boconstans.nuMaxrecovery + LD_BOConstans.cnuonenumber;

    /*Limpiar los datos de la tabla en el índice que se va a usar*/
    LD_BOConstans.tbMaxrecovery(nuIndex) := null;

    LD_BOConstans.tbMaxrecovery(nuIndex).ubication_id       := :new.ubication_id;

    LD_BOConstans.tbMaxrecovery(nuIndex).total_sub_recovery := :new.total_sub_recovery;

    LD_BOConstans.tbMaxrecovery(nuIndex).recovery_value     := :new.recovery_value;

  end if;

Exception
  When ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  When others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;

end TRGBIDURLD_MAX_RECOVERYVAL;
/
