CREATE OR REPLACE TRIGGER ADM_PERSON.TRGIURLD_DEAL
BEFORE INSERT OR UPDATE ON LD_DEAL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE

	csbAction_Ok      constant varchar2(1) := 'Y';

	nutotdistribute		ld_deal.total_value%type;
	nudealinsubsidy		number;
	dtminstardate		  date;
	dtmaxenddate		  date;
	nutotValueSubs      number;
  nutotautorize     ld_subsidy.authorize_value%type;
  nutotbyquantity   ld_subsidy.authorize_value%type;

BEGIN

	if inserting then

		/*Si el convenio se creó inactivo se asigna fecha de inactivación */
		if (:new.disable_deal = csbAction_Ok) then
			:new.disable_date := sysdate;
		end if;

		/*Validar que al menos la fecha fin del convenio sea mayor a la fecha actual*/
		if (:new.final_date < sysdate) then
			Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,'El valor de la fecha final debe ser mayor a la fecha actual');
			raise ex.CONTROLLED_ERROR;
		end if;

		/*Validar ingreso de caracter que determina si un convenio será inactivo*/
		if (:new.Disable_Deal <> csbAction_Ok and :new.Disable_Date is not null) then
			Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,'El valor para inactivar un convenio deber ser ' ||csbAction_Ok);
			raise ex.CONTROLLED_ERROR;
		end if;

		/*Validar ingreso de fecha de inactivación*/
		if (:new.Disable_Deal = csbAction_Ok and :new.Disable_Date is null) then
			Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,'La fecha para registrar el convenio como inactivo no puede ser nula');
			raise ex.CONTROLLED_ERROR;
		end if;

		/*Validar que fecha de inactivación esté comprendida entre el rango de vigencia del convenio*/
		If (:new.Disable_Deal = csbAction_Ok) and
			(:new.Disable_Date not between :new.Initial_Date and :new.Final_Date) then
			Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
							'La fecha de inactivación del convenio debe estar entre ' ||
							:new.Initial_Date || ' y ' || :new.Final_Date);
			raise ex.CONTROLLED_ERROR;
		End if;
	end if;

	if updating then

		/*Si el convenio se cambió a inactivo se asigna fecha de inactivación */
		if (:new.disable_deal = csbAction_Ok and :old.disable_deal != csbAction_Ok) then
			:new.disable_date := sysdate;
		end if;

		/*Determinar si un convenio ya se encuentra inactivo*/
		if (:old.disable_deal = csbAction_Ok and :old.disable_date is not null) then
			Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,'El convenio no se puede modificar porque se encuentra inactivo');
			raise ex.CONTROLLED_ERROR;
		end if;

		/*Validar que no se pueda actualizar el convenio si
		ha caducado si vigencia*/
		if :old.final_date < sysdate then
			Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,'No se puede actualizar los datos del convenio porque ha caducado su vigencia');
			raise ex.CONTROLLED_ERROR;
		end if;

		/*Se valida que se exija fecha de inactivación cuando
		el flag de inactivacion está en Y*/
		if (:new.Disable_Deal = csbAction_Ok and :new.Disable_Date is null) then
			Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,'La fecha para registrar el convenio como inactivo no puede ser nula');
			raise ex.CONTROLLED_ERROR;
		end if;

		/*Se valida que si se seleccionó no desactivar el convenio, no se
		ingrese fecha de desactivación*/
		If ((:new.Disable_Deal != csbAction_Ok) and	:new.Disable_Date is not null) then
			Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,'El valor para inactivar un convenio deber ser '||csbAction_Ok);
			raise ex.CONTROLLED_ERROR;
		End if;

		/*Verificar que la fecha de inactivación se encuentre entre las fechas de inicio y fin del convenio*/
		If (:new.Disable_Deal = csbAction_Ok) and (:new.Disable_Date not between :new.initial_date and :new.final_date) then
			Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,'La fecha de inactivación del convenio debe estar entre '||:new.Initial_Date||' y '||:new.Final_Date);
			raise ex.CONTROLLED_ERROR;
		End if;

		/*Verificar si el convenio se encuentra asociado a por lo menos un
		subsidio*/
		nudealinsubsidy := Ld_BcSubsidy.Fnuquantitydealinsunsidy(:old.deal_id);

		if nudealinsubsidy > 0 then

			/*Obtener la fecha mínima de inicio de vigencia de un subsidio
			asociado al convenio*/
			dtminstardate := Ld_BcSubsidy.Fdtminsubstardate(:old.deal_id);

			/*Validar que la nueva fecha de inicio de vigencia del convenio
			no supere la mínima fecha de inicio de vigencia de un subsidio
			asociado al convenio*/
			if :new.Initial_Date > dtminstardate then
				Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,'La fecha de inicio de vigencia no puede superar la mínima fecha, ' ||
								dtminstardate ||', de inicio de vigencia de un subsidio asociado al convenio');
				raise ex.CONTROLLED_ERROR;
			end if;

			/*Obtener la fecha máxima de fin de vigencia de un subsidio asociado al convenio*/
			dtmaxenddate := Ld_BcSubsidy.Fdtmaxsubenddate(:old.deal_id);

			/*Validar que la nueva fecha de fin de vigencia del convenio no sea
			menor a la máxima fecha	de fin de vigencia de un subsidio asociado
			al convenio*/
			if :new.Final_Date < dtmaxenddate then
				Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
								'La fecha de fin de vigencia no puede ser menor a la máxima fecha, ' ||
								dtmaxenddate ||
								', de fin de vigencia de un subsidio asociado al convenio');
				raise ex.CONTROLLED_ERROR;
			end if;
		end if;

		/*Obtener el total de los valores autorizados por subsidios de un mismo convenio*/
    nutotautorize := nvl(ld_bcsubsidy.fnutotdeliversub(:new.deal_id),
                         ld_boconstans.cnuCero_Value
                        );

    /*Obtener el total de los valores autorizados de los conceptos de los subsidios parametruzados por
      cantidad de un convenio */
    nutotbyquantity := nvl(ld_bcsubsidy.fnugettotquantitybysub(:new.deal_id,
                                                               null
                                                              ),
                           ld_boconstans.cnuCero_Value
                          );


    /*Obtener la suma del total de los valores autorizados por subsidios de un mismo convenio más
      el total de los valores autorizados de los conceptos de los subsidios parametruzados por
      cantidad de un convenio
    */
		nutotdistribute := nutotautorize + nutotbyquantity;

		/*Validar que la suma del total de todos los conceptos subsidiados para el convenio más el total de todos los valores autorizados del convenio
		no superen el valor del convenio*/
		IF :new.total_value < nutotdistribute then
			ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
			'Los valores de los subsidios asociados al convenio superan el valor del convenio');
			raise ex.CONTROLLED_ERROR;
		END IF;

     /*Obtiene la suma del total de los valores autorizados de un mismo convenio*/

     nutotValueSubs := ld_bcsubsidy.fnutotauthorize_value(:old.deal_id);

        if :new.total_value < nutotValueSubs then
         ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El valor ingresado para el convenio es menor que la suma de valores autorizados para los subsidios.');
         END if;

  END IF;

END;
/
