CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIDURLD_UBICATIONVALIDATE
  before insert or delete or update on ld_ubication
  referencing old as old new as new for each row
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  trgbidurld_ubicationvalidate

Descripción  : Realiza las validaciones necesarias para
               registrar correctamente las poblaciones
               que serán beneficiadas por un subsidio.

Autor  : Nombre del desarrollador
Fecha  : 05-10-2012

Historia de Modificaciones
Fecha        IDEntrega             Modificación
08-05-2025    felipe.valencia      OSF-3909: Se agrega validación para no actualizar el campo
                                   TOTAL_DELIVER desde LDISP y adicionalemente se hacen cambios
                                  por estandares
05-10-2012   jconsuegra.SAO156577  Creación
**************************************************************/
declare
  /******************************************
      Declaración de variables y Constantes
  ******************************************/
  rcsubsidy       dald_subsidy.styLD_subsidy;
  nuindex         number;
  nuubiasig       number := Ld_Boconstans.cnuCero;
  nupromo         Ld_Subsidy.Promotion_Id%type;
  csbNombreTrigger    VARCHAR2(100) := $$PLSQL_UNIT;
  sbError             VARCHAR2(4000);
  nuError             NUMBER;
begin
  pkg_traza.trace(csbNombreTrigger, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

  if DELETING then
    /*Validar que no se haya asignado un subsidio asociado a esa población*/
    nuubiasig := Ld_BcSubsidy.Fnugetubiactiveasig(:old.ubication_id);

    if nuubiasig > Ld_Boconstans.cnuCero then
      pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'No se puede borrar la ubicación porque ya se han asignado subsidios de ese tipo');
    end if;
  end if;

  if INSERTING or UPDATING then

    if :new.sucacate is null then
      pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'Debe ingresar la categoría');
    end if;

    if :new.authorize_quantity is null and :new.authorize_value is null then
      pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'Debe ingresar la cantidad autorizada o el valor autorizado');
    end if;

    /*Validar el concepto de exclusión de los atributos: cantidad autorizada y valor autorizado*/
    if :new.authorize_quantity is not null and :new.authorize_value is not null then
      pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'Debe ingresar la cantidad autorizada o el valor autorizado pero ambos al tiempo no es posible');
    end if;

    /*Obtener los datos de un subsidio*/
    Dald_subsidy.getRecord(:new.subsidy_id, rcsubsidy);

    /*Validar que se ingrese el mismo concepto de cantidad autorizada parametrizada en el subsidio*/
    if :new.authorize_quantity is not null and rcsubsidy.authorize_quantity is null then
      pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'No existe correspondencia entre la cantidad autorizada de la población y del subsidio');
    end if;

    if :new.authorize_quantity is not null and rcsubsidy.authorize_quantity < :new.authorize_quantity then
      pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'La cantidad autorizada de la población no puede ser mayor a la cantidad autorizada del subsidio');
    end if;

    nuindex := ld_boconstans.nuUbiIndex;

    nuindex := nuindex + ld_boconstans.cnuonenumber;

    --ld_boconstans.nuUbiIndex := ld_boconstans.nuUbiIndex + ld_boconstans.cnuonenumber;

    /*Limpiar los datos de la tabla en el índice que se va a usar*/
    LD_BOConstans.tbubisubsidy(nuindex) := null;

    LD_BOConstans.tbubisubsidy(nuindex).authorize_quantity := :new.authorize_quantity;
    LD_BOConstans.tbubisubsidy(nuindex).subsidy_id         := :new.subsidy_id;
    LD_BOConstans.tbubisubsidy(nuindex).geogra_location_id := :new.geogra_location_id;
    LD_BOConstans.tbubisubsidy(nuindex).sucacate           := :new.sucacate;
    LD_BOConstans.tbubisubsidy(nuindex).sucacodi           := :new.sucacodi;
    LD_BOConstans.tbubisubsidy(nuindex).ubication_id       := :new.ubication_id;


    /*Validar que se ingrese el mismo concepto de valor autorizado parametrizada en el subsidio*/
    if :new.authorize_value is not null and rcsubsidy.authorize_value is null then
      pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'No existe correspondencia entre el valor autorizado de la población y del subsidio');
    end if;

    if :new.authorize_value is not null and rcsubsidy.authorize_value < :new.authorize_value then
      pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'El valor autorizado de la población no puede ser mayor al valor autorizado del subsidio');
    end if;

    LD_BOConstans.tbubisubsidy(nuindex).authorize_value := :new.authorize_value;


    /*Validar que la cantidad autorizada sea mayor a cero*/
    if :new.authorize_quantity is not null and
       :new.authorize_value    is null and
       :new.authorize_quantity <= LD_BOConstans.cnuCero_Value then
      pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'La cantidad autorizada debe ser mayor a cero');
    end if;

    /*Validar que el valor autorizado sea mayor a cero*/
    if :new.authorize_quantity is null and
       :new.authorize_value    is not null and
       :new.authorize_value    <= LD_BOConstans.cnuCero_Value then
      pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'El valor autorizado debe ser mayor a cero');
    end if;

    /*Validar que no se incluyan poblaciones dependientes*/
    if :new.geogra_location_id is null and (:new.sucacate is not null or :new.sucacodi is not null ) then
      if :new.sucacate is not null then
         pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'No se puede asignar un valor fijo en la categoría mientras la ubicación geográfica no tenga un valor definido');
      end if;
      if :new.sucacodi is not null then
         pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'No se puede asignar un valor fijo en la subcategoría cuando la ubicación geográfica no tenga un valor definido');
      end if;
    end if;

    if :new.geogra_location_id is not null and :new.sucacate is null and :new.sucacodi is not null then
      pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'No se puede asignar un valor fijo en la subcategoría mientras no se defina un valor en la categoría');
    end if;

    if :new.geogra_location_id is null and :new.sucacate is null and :new.sucacodi is not null then
      pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'No se puede asignar un valor fijo en la subcategoría mientras no se defina un valor en la categoría y la ubicación geográfica');
    end if;

    /*Validar que no se pueda ingresar una categoría con valor -1*/
    if :new.sucacate = Ld_Boconstans.cnuallrows then
      pkg_Error.SetErrorMessage(pkg_Error.cnuGeneric_message, 'No se puede ingresar una categoría con valor -1');
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

  /*Realizar la segmentación comercial de la promoción por población*/
  if INSERTING then

    /*Obtener promoción del subsidio*/
    nupromo := Dald_Subsidy.fnuGetPromotion_Id(:new.subsidy_id, null);

    Ld_BoSubsidy.Proccommercialsegmenpromo(:new.subsidy_id,
                                           nupromo,
                                           :new.geogra_location_id,
                                           :new.sucacate,
                                           nvl(:new.sucacodi, -1)
                                          );
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
end TRGBIDURLD_UBICATIONVALIDATE;
/
