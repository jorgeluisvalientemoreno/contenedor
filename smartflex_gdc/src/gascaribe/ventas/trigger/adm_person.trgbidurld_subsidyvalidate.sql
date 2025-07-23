CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIDURLD_SUBSIDYVALIDATE
  before insert or delete or update on ld_subsidy
  referencing old as old new as new for each row
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  trgbidurld_subsidyvalidate

Descripción  : Realiza las validaciones necesarias para
               registrar un subsidio correctamente.

Autor  : Nombre del desarrollador
Fecha  : 05-10-2012

Historia de Modificaciones
Fecha        IDEntrega             Modificación
08-05-2025    felipe.valencia      OSF-3909: Se agrega validación para no actualizar el campo
                                   TOTAL_DELIVER desde LDISP y adicionalemente se hacen cambios
                                  por estandares
07-10-2013   jrobayo.SAO218889     Se elimina la validación al momento de realizar
                                   la inserción de un nuevo subsidio, la cuál verificaba
                                   si la fecha inicial ingresada para el subsidio era menor o
                                   igual a la fecha del sistema
05-10-2012   jconsuegra.SAO156577  Creación
**************************************************************/
declare
  /******************************************
      Declaración de variables y Constantes
  ******************************************/
  --
  blexist     boolean;
  rcdeal      dald_deal.styLD_deal;
  --
  nuInitial_Year     ld_subsidy.validity_year_means%type;
  nuFinal_Year       ld_subsidy.validity_year_means%type;
  nuGet_Val_tot      ld_subsidy.authorize_value%type;
  nuValdetailrows    number;
  nuIndex            number;
  --
  onuPromId          cc_promotion.promotion_id%type;
  --
  nusubasig          number;
  dtlastdate         ld_asig_subsidy.insert_date%type;
  numaxyear          ld_max_recovery.year%type;
  numaxmonth         ld_max_recovery.month%type;
  dtnewfinaldate     date;
  dtmaxdate          date;
  sbmaxrecovery      varchar2(100);
  nupaysubrows       number;
  --
    csbNombreTrigger    VARCHAR2(100) := $$PLSQL_UNIT;
    sbError             VARCHAR2(4000);
    nuError             NUMBER;
begin
    pkg_traza.trace(csbNombreTrigger, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

  if DELETING then
    nusubasig := Ld_BcSubsidy.Fnuexistactivesubasig(:old.subsidy_id);

    if nusubasig > Ld_Boconstans.cnuCero then
      Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'No se puede borrar el subsidio porque ya se han asignado subsidios de ese tipo');
    end if;

    /*                                Cancelar promoción                  */


    /*Cancelar segmentaciones comerciales de la promoción*/
    Ld_BoSubsidy.Procenabledseg(:old.subsidy_id);

    /*Eliminar la segmentación por promociones*/
    delete from CC_COM_SEG_PROM c where c.promotion_id = :old.promotion_id;

    /*Elimina los detalles de la promoción*/
    Ld_BoSubsidy.Procdeletepromdetails(:old.promotion_id);

    /*Eliminar promoción*/
    dacc_promotion.delRecord(:old.promotion_id);



    /*                          Fin   Cancelar promoción                  */

  end if;

  blexist := DALD_deal.fblExist(:new.deal_id);

  if blexist then

    /*Se determina si una variable que viene del traslado fue seteada
      no se realizan validaciones*/
    if nvl(ld_bosubsidy.globaltransfersub, 'N') = 'N' then

      if INSERTING or UPDATING then

        /*Obtener los datos del convenio*/
        DALD_deal.getRecord (:new.deal_id, rcdeal);

        /*Validar que el convenio se encuentre vigente*/
       if(nvl(pkg_Error.getApplication,'--') not in ('LDANS','LDRSS')) then
        if rcdeal.final_date < sysdate then
          Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'El convenio no se encuentra vigente');
       end if;

       END if;
        /*Validar que el convenio se encuentre activo*/
        if nvl(rcdeal.disable_deal, Ld_Boconstans.csbNo_Action) = Ld_Boconstans.csbAction_Ok and
           rcdeal.disable_date is not null then
          Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'El convenio se encuentra inactivo');
        end if;

        /*Validar fecha de inicio del subsidio no sea menor que la fecha de inicio del convenio*/
        if :new.initial_date < rcdeal.initial_date then
          Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'La fecha inicial del subsidio no puede ser menor a la fecha inicial del convenio');
        end if;

        /*Validar fecha de inicio del subsidio no sea mayor que la fecha de fin del convenio*/
        if :new.initial_date > rcdeal.final_date then
          Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'La fecha inicial del subsidio no puede ser mayor a la fecha final del convenio');
        end if;

        /*Validar fecha de fin del subsidio no sea mayor a la fecha final del convenio*/
        if :new.final_date > rcdeal.final_date  then
          Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'La fecha final del subsidio no puede ser mayor a la fecha final del convenio');
        end if;

        /*Validar fecha de fin del subsidio no sea menor a la fecha inicial del convenio*/
        if :new.final_date < rcdeal.initial_date  then
          Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'La fecha final del subsidio no puede ser menor a la fecha final del convenio');
        end if;

        /*Validar fecha de fin del subsidio no sea menor a la fecha inicial del subsidio*/
        if :new.final_date < :new.initial_date  then
          Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'La fecha final del subsidio no puede ser menor a la fecha inicial del mismo');
        end if;

        /*Validar fecha de inicio de cobro esté dentro del rango de vigencia del subsidio*/
        if :new.star_collect_date not between :new.initial_date and :new.final_date then
          Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'La fecha de inicio de cobro no se encuentra dentro del rango de vigencia del subsidio');
        end if;

        /*Validar año de vigencia de los recursos sea válido*/
        if :new.validity_year_means not between ld_boconstans.cnuInitial_Year and ld_boconstans.cnuFinal_Year then
          Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'El año de vigencia de los recursos no es válido');
        end if;

        /*Validar año de vigencia de los recursos se encuentre dentro del rango de vigencia del subsidio*/
        nuInitial_Year := to_number(to_char(:new.initial_date, 'yyyy'));

        nuFinal_Year   := to_number(to_char(:new.final_date, 'yyyy'));

        if :new.validity_year_means not between nuInitial_Year and nuFinal_Year then
          Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'El año de vigencia de los recursos no se encuentra dentro del rango de vigencia del subsidio');
        end if;

        /*Validar el concepto de exclusión de los atributos: cantidad autorizada y valor autorizado*/
        if :new.authorize_value is null and :new.authorize_quantity is null then
          Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'Debe ingresar la cantidad autorizada o el valor autorizado');
        end if;

        /*Validar el concepto de exclusión de los atributos: cantidad autorizada y valor autorizado*/
        if :new.authorize_value is not null and :new.authorize_quantity is not null then
          Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'Debe ingresar la cantidad autorizada o el valor autorizado pero ambos al tiempo no es posible');
        end if;

        /*Validar el concepto de exclusión de los atributos: cantidad autorizada y valor autorizado*/
        if :new.authorize_quantity <= LD_BOConstans.cnuCero_Value and
           :new.authorize_quantity is not null then
          Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'La cantidad autorizada debe ser mayor a cero');
        end if;

        /*Validar que el valor autorizado sea mayor a cero*/
        if :new.authorize_value <= LD_BOConstans.cnuCero_Value and
           :new.authorize_value is not null then
          Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'El valor autorizado debe ser mayor a cero');
        end if;

        /*Validar que el valor autorizado no supere el total del convenio*/
        if :new.authorize_value > rcdeal.total_value and
           :new.authorize_value is not null then
          Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'El valor autorizado no debe superar el total del convenio');
        end if;

        IF (NVL(pkg_Error.getApplication,'--') in ('LDISP')) THEN
            IF (NVL(:old.TOTAL_DELIVER,0) <> 0 AND (:old.TOTAL_DELIVER <> :new.TOTAL_DELIVER)) THEN
                :new.TOTAL_DELIVER := :old.TOTAL_DELIVER;
            END IF;
        END IF;

        if :new.authorize_quantity IS not null then
	        :new.TOTAL_AVAILABLE := :new.authorize_quantity - nvl(:new.TOTAL_DELIVER,0);
        elsif :new.AUTHORIZE_VALUE IS not null then
            :new.TOTAL_AVAILABLE := :new.AUTHORIZE_VALUE - nvl(:new.TOTAL_DELIVER,0);
        END if;

      end if;

      /*Crear promoción de tipo subsidio*/
      if INSERTING then





        ld_bosubsidy.RegisterPromo('PROMOCION '||:new.description,
                                            LD_BOConstans.cnuPromotionType,
                                            LD_BOConstans.cnuPromotionPriority,
                                            LD_BOConstans.cnuGasService,
                                            :new.initial_date,
                                            :new.final_date,
                                            :new.conccodi,
                                            onuPromId
                                            );

        :new.promotion_id := onuPromId;

        if onuPromId is null then
          Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'Error al generar la promoción asociada al subsidio: '||:new.subsidy_id);
        end if;
      end if;
      --

      /*Validaciones al momento de actualizar*/
      if UPDATING then

        /*Validaciones valor autorizado*/
        /*Validar que no se pueda colocar un valor en cantidad autorizada si el subsidio posee detalles con el valor autorizado activo*/
        if :new.authorize_quantity is not null then
          nuValdetailrows := Ld_BcSubsidy.fnuexiststotaldetail(:new.subsidy_id);
          if nuValdetailrows > LD_BOConstans.cnuCero_Value then
            Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'No es posible actualizar la cantidad autorizada porque existen poblaciones parametrizadas con valor autorizado');
          end if;
        end if;

        /*Validar que no se pueda disminuir el valor autorizado en el encabezado de un subsidio, a un valor menor a la sumatoria de los valores autorizados en el detalle del subsidio*/
        if :new.authorize_value < :old.authorize_value then
          nuValdetailrows := Ld_BcSubsidy.fnuexiststotaldetail(:new.subsidy_id);
          if nuValdetailrows > LD_BOConstans.cnuCero_Value then
            /*Obtener la sumatoria de los detalles de valores autorizados del subsidio*/
            nuGet_Val_tot := Ld_BcSubsidy.fnutotalvaluedetail(:new.subsidy_id);

            if nuGet_Val_tot > :new.authorize_value then
              Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'No es posible disminuir el valor autorizado porque es menor a la sumatoria de valores autorizados parametrizados en el detalle del subsidio');
            end if;
          end if;
        end if;
        --
        /*Validaciones cantidad autorizada*/
        /*Validar que no se pueda colocar un dato en valor autorizado si el subsidio posee detalles con cantidad autorizada activa*/
        if :new.authorize_value is not null then
          nuValdetailrows := Ld_BcSubsidy.fnuexistsquantitydetail(:new.subsidy_id);
          if nuValdetailrows > LD_BOConstans.cnuCero_Value then
            Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'No es posible actualizar el valor autorizado porque existen poblaciones parametrizadas con cantidad autorizada');
          end if;
        end if;

        /*Validar que no se pueda disminuir la cantidad autorizada en el encabezado de un subsidio, a un valor menor a la sumatoria de las cantidades autorizadas en el detalle del subsidio*/
        if :new.authorize_quantity < :old.authorize_quantity then
          nuValdetailrows := Ld_BcSubsidy.fnuexistsquantitydetail(:new.subsidy_id);
          if nuValdetailrows > LD_BOConstans.cnuCero_Value then
            /*Obtener la sumatoria de los detalles de valores autorizados del subsidio*/
            nuGet_Val_tot := Ld_BcSubsidy.fnutotquantidetail(:new.subsidy_id);

            if nuGet_Val_tot > :new.authorize_quantity then
              Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'No es posible disminuir la cantidad autorizada porque es menor a la sumatoria de las cantidades autorizadas parametrizadas en el detalle del subsidio');
            end if;
          end if;
        end if;

        /*Validar que no se pueda modificar el código del convenio si existe una venta realizada con el subsidio modificado*/
        if :new.deal_id <> :old.deal_id then
          nusubasig := Ld_BcSubsidy.Fnuexistsubasig(:new.subsidy_id);

          if nusubasig > Ld_Boconstans.cnuCero then
            Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'No se puede modificar el convenio porque existen subsidios de este tipo asignados');
          end if;
        end if;

        /*Validaciones con respecto a la fecha final del subsidio*/
        if :new.final_date <> :old.final_date then

          /*Validar que la fecha de fin de vigencia no puede ser menor que la fecha del último subsidio asignado, si hay subsidio asignado*/
          dtlastdate := Ld_BcSubsidy.Fnugetlastdateasigsub(:new.subsidy_id);

          if :new.final_date < dtlastdate then
            Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'La fecha de fin de vigencia no puede ser menor que la fecha del último subsidio asignado');
          end if;

          /*Validar que la fecha de fin de vigencia no puede ser menor al máximo período parametrizado para los topes de cobro*/
          /*Obtener el máximo período de un tope asociado al subsidio*/
          Ld_BcSubsidy.Procgetmaxdaterecovery(:new.subsidy_id,
                                              numaxyear,
                                              numaxmonth
                                             );

          dtmaxdate      := to_date(numaxyear||numaxmonth, 'YYYYMM');

          sbmaxrecovery  := to_char(:new.final_date, 'YYYYMM');

          dtnewfinaldate := to_date(sbmaxrecovery, 'YYYYMM');

          if dtnewfinaldate < dtmaxdate then
            Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'La fecha de fin de vigencia no puede ser menor al máximo período parametrizado para los topes de cobro');
          end if;

        end if;

        /*Validar que no se pueda modificar la fecha de inicio de cobro si al menos uno de los subsidios asignados se encuentra en estado: POR COBRAR, COBRADO o PAGADO*/
        if :new.star_collect_date <> :old.star_collect_date then
          nupaysubrows := Ld_BcSubsidy.Fnugetsubinpaystates(:new.subsidy_id);

          if nupaysubrows > Ld_Boconstans.cnuCero then
            Pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'No se puede modificar la fecha de inicio de cobro si al menos uno de los subsidios asignados se encuentra en estado: POR COBRAR, COBRADO o PAGADO');
          end if;
        end if;

        /*Validar que la nueva promoción no quede con valor nulo*/
        :new.promotion_id := :old.promotion_id;

      end if;



      nuIndex := ld_boconstans.nuSubIndex;

      nuIndex := nuIndex + ld_boconstans.cnuonenumber;
      --ld_boconstans.nuSubIndex := ld_boconstans.nuSubIndex + 1;

      /*Limpiar los datos de la tabla en el índice que se va a usar*/
      LD_BOConstans.tbsubsidy(nuIndex) := null;

      LD_BOConstans.tbsubsidy(nuIndex).subsidy_id := :new.subsidy_id;

      LD_BOConstans.tbsubsidy(nuIndex).deal_id    := :new.deal_id;

      LD_BOConstans.tbsubsidy(nuIndex).authorize_quantity := :new.authorize_quantity;

      LD_BOConstans.tbsubsidy(nuIndex).authorize_value := :new.authorize_value;

      LD_BOConstans.tbsubsidy(nuIndex).initial_date := :new.initial_date;

      LD_BOConstans.tbsubsidy(nuIndex).final_date   := :new.final_date;

      LD_BOConstans.tbsubsidy(nuIndex).description  := :new.description;

      LD_BOConstans.tbsubsidy(nuIndex).origin_subsidy := :new.origin_subsidy;

      Ld_Bosubsidy.sboldsubdesc := :old.description;

    end if;

  end if;
  
    pkg_traza.trace(csbNombreTrigger, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
Exception
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbNombreTrigger, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbNombreTrigger, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.Controlled_Error;  
end TRGBIDURLD_SUBSIDYVALIDATE;
/
