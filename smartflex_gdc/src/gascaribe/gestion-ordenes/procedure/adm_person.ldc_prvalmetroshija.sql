create or replace PROCEDURE adm_person.ldc_prvalmetroshija AS
    /**************************************************************************

    Funcion     :  LDC_PRVALMETROSHIJA
    Descripcion :  PLUGIN PARA LA VALIDACION DE LOSMETRO DE TUBERIA UTILIZADOS.
    Autor       : esantiago
    Fecha       : 14-04-2020

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    24/04/2024          Adrianavg          OSF-2597: Se migra del esquema OPEN al esquema ADM_PERSON
    **************************************************************************/

    nuOrderId           OR_ORDER.ORDER_ID%type;
    nuCausalId          or_order.causal_id%type;
    nuClassCausalId     GE_CAUSAL.CLASS_CAUSAL_ID%type;
    VSBDATO_ADIC_MET_TUBERIA OR_REQU_DATA_VALUE.Name_1%type;

    vnuvalue       NUMBER(10,3);
    sbErrorMessage       VARCHAR2(4000);
    nuErrorCode          NUMBER;
	SBSSQLDATOADICIONAL   VARCHAR2(4000);

	cursor cumtshija (nuorden number) is
    select metro_lineal
    from LDC_ORDENES_OFERTADOS_REDES
	where orden_nieta is null
	and orden_hija=nuorden;

    RFCUMTSHIJA cumtshija%rowtype;



BEGIN

	if fblaplicaentregaxcaso('0000287') then

		nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;

		nuCausalId := daor_order.fnugetcausal_id(nuOrderId);

		nuClassCausalId := dage_causal.fnugetclass_causal_id(nuCausalId);


		/*se valida si la cusal es de clase exito*/
		if nuClassCausalId = 1 then

			VSBDATO_ADIC_MET_TUBERIA:= DALD_PARAMETER.FSBGETVALUE_CHAIN('DATO_ADIC_MET_TUBERIA');
			if VSBDATO_ADIC_MET_TUBERIA is null then
                sbErrorMessage := 'El parametro DATO_ADIC_MET_TUBERIA esta vacio';
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbErrorMessage);
                raise ex.CONTROLLED_ERROR;
            end if;

			OPEN cumtshija(nuOrderId);
			FETCH cumtshija INTO RFCUMTSHIJA;
			CLOSE cumtshija;

			if RFCUMTSHIJA.metro_lineal is not null then

			    --------------------------------------------------------------

				for i in 1 .. 20 loop


					if VNUVALUE is null then


						SBSSQLDATOADICIONAL := 'select VALUE_' || i || '
						  from OR_REQU_DATA_VALUE
						 where NAME_' || i || ' = ''' ||
						VSBDATO_ADIC_MET_TUBERIA || ''' and order_id = ' ||
						NUORDERID;


						begin
							--/*
							execute immediate SBSSQLDATOADICIONAL
							into VNUVALUE;
							--*/
							exception
							when others then
							VNUVALUE  := null;
							null;
						end;


					end if;
				end loop;
				--------------------------------------------------------------


				if VNUVALUE <> RFCUMTSHIJA.metro_lineal then
					sbErrorMessage := 'Las cantidades legalizadas de METROS DE TUBERIA no coinciden con los MTS configurados de la orden HIJA en LDCDEORREOF';
					ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbErrorMessage);
					raise ex.CONTROLLED_ERROR;
				end if;


			end if;


		end if;
	end if;



EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

END LDC_PRVALMETROSHIJA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDC_PRVALMETROSHIJA
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRVALMETROSHIJA', 'ADM_PERSON'); 
END;
/