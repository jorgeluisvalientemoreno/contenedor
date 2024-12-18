create or replace PROCEDURE ADM_PERSON.PRVALLDCREASCO
    IS

/*****************************************************************************************************************
    Autor       : HB
    Fecha       : 2020-01-27
    Descripcion : Procedimiento para validar parametros del PB LDCREASCO (CA90)

    Parametros Entrada

    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        	AUTOR   	DESCRIPCION

	 25/10/2021		Horbath		Ca626: Se modificara para validar si el a¿¿o y mes, se encuentran configurados en la tabla LDC_CIERCOME y que el campo cicoesta sea igual a S

********************************************************************************************************************/

    cnuNULL_ATTRIBUTE constant number := 2126;

    sbOBJECT_TYPE_ID ge_boInstanceControl.stysbValue;
    sbTEPFANO ge_boInstanceControl.stysbValue;
    sbTEPFMES ge_boInstanceControl.stysbValue;
    sbUNIOPER ge_boInstanceControl.stysbValue;

    sbUniOp      varchar2(4000);
    sbErrorEntrada varchar2(1);
	nuValCierre number; -- caso:626

    -- cursores para validar las unidades digitadas separadas por pipe
  cursor cuValor (sbUnidades varchar2) is
 SELECT TO_NUMBER(COLUMN_VALUE) nuUniOp
   FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(sbUnidades,'|'));

 cursor cuUnidOpOfertado (nuunid or_operating_unit.operating_unit_id%type) is
  SELECT xu.unidad_operativa
    FROM ldc_const_unoprl xu
   WHERE xu.tipo_ofertado   IN( -- Caso 0000455
                            SELECT to_number(COLUMN_VALUE)
                              FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbGetValue_Chain('TIPODEOFERTADORANGOXASIG',null),','))
						   )
     AND xu.unidad_operativa = nuunid;

	 cursor CuValCierre (nuTEPFANO Number, nuTepfmes number) is -- caso:626
	 SELECT COUNT(1) FROM LDC_CIERCOME
	 WHERE CICOANO= nuTEPFANO
	 and cicomes = nuTepfmes
	 and cicoesta='S';


    BEGIN

        sbTEPFANO := ge_boInstanceControl.fsbGetFieldValue('LDC_CIERCOME', 'CICOANO');
        sbTEPFMES := ge_boInstanceControl.fsbGetFieldValue('LDC_CIERCOME', 'CICOMES');
        sbUNIOPER := ge_boInstanceControl.fsbGetFieldValue('OR_OPERATING_UNIT', 'ADDRESS');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------


        if (sbTEPFANO is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'A?o');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbTEPFMES is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Mes');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbUNIOPER is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Unidades');
            raise ex.CONTROLLED_ERROR;
        end if;

		IF FBLAPLICAENTREGAXCASO('0000626') THEN

			OPEN CuValCierre(to_number(sbTEPFANO),to_number(sbTEPFMES));
			FETCH CuValCierre INTO nuValCierre;
			CLOSE CuValCierre;

			if nuValCierre = 0 then
			  Errors.SetError (2741, 'El cierre para el a¿¿o '||sbTEPFANO||' Y mes '||sbTEPFMES||' no ha finalizado, favor validar.');
			  raise ex.CONTROLLED_ERROR;
		   end if;

		END IF;


        -- valida si las unidades suministradas separadas por pipe son unidades validas del tipo ofertado 2
		sbErrorEntrada := 'N';
		for rg in cuValor(sbUNIOPER) loop
		 begin
		 open cuUnidOpOfertado(rg.nuuniop);
		 fetch cuUnidOpOfertado into sbUniOp;
		 if cuUnidOpOfertado%notfound then
			sbErrorEntrada := 'S';
		end if;
		close cuUnidOpOfertado;
		exception when others then
		  sbErrorEntrada := 'S';
		end;
	   end loop;

	   if sbErrorEntrada = 'S' then
		  Errors.SetError (cnuNULL_ATTRIBUTE, 'Hay caracteres invalidos o unidades que no son Ofertado Tipo 2');
		  raise ex.CONTROLLED_ERROR;
	   end if;
        ------------------------------------------------
        -- User code
        ------------------------------------------------

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
 END PRVALLDCREASCO;
 /
BEGIN
    pkg_utilidades.prAplicarPermisos('PRVALLDCREASCO', 'ADM_PERSON');
END;
/