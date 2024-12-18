CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIDURLD_SUBSIDY_DETAILVAL
  before insert or delete or update on ld_subsidy_detail
  referencing old as old new as new for each row
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  trgbidurld_subsidy_detailval

Descripción  : Realiza las validaciones necesarias para
               registrar los conceptos a subsidiar por
               un subsidio determinado.

Autor  : Nombre del desarrollador
Fecha  : 05-10-2012

Historia de Modificaciones
Fecha        IDEntrega             Modificación
05-10-2012   jconsuegra.SAO156577  Creación
**************************************************************/
declare
  /******************************************
      Declaración de variables y Constantes
  ******************************************/
  rcsubsidy      dald_subsidy.styLD_subsidy;
  rcubication    dald_ubication.styLD_ubication;
  nuIndex        number;
  nuUbiIndex     number;
begin

  --{
    -- Logica del Negocio
  --}

  if INSERTING or UPDATING then
    /*Obtener datos de la población beneficiada*/
    DALD_ubication.getRecord (:new.ubication_id, rcubication);

    --:new.subsidy_id := rcubication.subsidy_id;

    /*Obtener datos del subsidio*/
    DALD_subsidy.getRecord (rcubication.subsidy_id, rcsubsidy);

    /*Validar que los conceptos a subsidiar sean diferentes del concepto del subsidio*/
    if :new.conccodi = rcsubsidy.conccodi then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El concepto a subsidiar debe ser diferente al concepto de aplicación del subsidio');
    end if;

    /*Validar el ingreso de los conceptos a subsidiar*/
    if :new.conccodi is null then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Debe ingresar el código del concepto a subsidiar');
    end if;

    /*Validar el ingreso del valor del porcentaje de subsidio*/
    if :new.subsidy_percentage is null and :new.subsidy_value is null then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Debe ingresar el porcentaje de subsidio o el valor subsidiado');
    end if;

    /*Validar el ingreso del valor del porcentaje de subsidio*/
    if :new.subsidy_percentage is not null and :new.subsidy_value is not null then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Se debe ingresar uno de los dos campos [Valor subsidiado o Porcentaje de subsidio], no ambos.');
    end if;

    if :new.subsidy_percentage is not null and
       :new.subsidy_percentage <= LD_BOConstans.cnuCero_Value then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El porcentaje de subsidio del concepto debe ser mayor a cero');
    end if;

    if :new.subsidy_percentage is not null and
       :new.subsidy_percentage > LD_BOConstans.cnuCien_Value then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El porcentaje de subsidio del concepto debe ser menor o igual a 100');
    end if;

    /*Validar el ingreso del valor a subsidiar por el concepto*/
    if :new.subsidy_value is not null and
       :new.subsidy_value <= LD_BOConstans.cnuCero_Value then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El valor a subsidiar para un concepto debe ser mayor a cero');
    end if;

    /*Validar que el valor a subsidiar para el concepto no supere el valor autorizado para la población*/
    if :new.subsidy_value is not null and
       :new.subsidy_value > rcubication.authorize_value then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El valor a subsidiar para un concepto no puede superar el valor autorizado para la población');
    end if;

    nuIndex := ld_boconstans.nuSubdetailindex;

    nuIndex := nuIndex + LD_BOConstans.cnuonenumber;
    --ld_boconstans.nuSubdetailindex := ld_boconstans.nuSubdetailindex + LD_BOConstans.cnuonenumber;--1;

    /*Limpiar los datos de la tabla en el índice que se va a usar*/
    LD_BOConstans.tbSub_Detail(nuIndex) := null;

    LD_BOConstans.tbSub_Detail(nuIndex).ubication_id       := :new.ubication_id;
    LD_BOConstans.tbSub_Detail(nuIndex).subsidy_value      := :new.subsidy_value;
    LD_BOConstans.tbSub_Detail(nuIndex).subsidy_percentage := :new.subsidy_percentage;
    LD_BOConstans.tbSub_Detail(nuIndex).conccodi           := :new.conccodi;


    nuUbiIndex := ld_boconstans.nuUbiIndex;

    nuUbiIndex := nuUbiIndex + LD_BOConstans.cnuonenumber;
    --ld_boconstans.nuUbiIndex := ld_boconstans.nuUbiIndex + LD_BOConstans.cnuonenumber;--1;

    LD_BOConstans.tbubisubsidy(nuUbiIndex) := null;

    LD_BOConstans.tbubisubsidy(nuUbiIndex).sucacate            := rcubication.sucacate;
    LD_BOConstans.tbubisubsidy(nuUbiIndex).sucacodi            := rcubication.sucacodi;
    LD_BOConstans.tbubisubsidy(nuUbiIndex).geogra_location_id  := rcubication.geogra_location_id;

  end if;

Exception
  When ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  When others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;

end TRGBIDURLD_SUBSIDY_DETAILVAL;
/
