CREATE OR REPLACE FUNCTION "ADM_PERSON"."FBLGENERATRAMITEREPARA" (Inutipotrab   In number,
												  Inuproduct_id In number,
												  IdtfechEjec in date) return boolean is

  /**************************************************************************
        Autor       : Horbath
        Fecha       : 2021-08-10
        Caso        : 767
        Descripcion : Funcion que validar la creacion del tramite de reparacion

        nuError  codigo del error
        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
      ***************************************************************************/

  -- Variables
  sbCadTypetask  ldc_pararepe.PARAVAST%Type := ','||open.DALDC_PARAREPE.fsbGetPARAVAST ('LDC_VAL_TRAMNEXT767',null)||',' ;
  sbCadTypeSuspe ldc_pararepe.PARAVAST%Type := open.DALDC_PARAREPE.fsbGetPARAVAST ('LDC_VAL_TIPOSUSP767',null) ;


  blsw           boolean:=true;
  nuCu_tipo_susp number;

  --se valida aplicacion de entrega
	CURSOR Cu_tipo_susp (prod number) IS
		select count(1) from PR_PROD_SUSPENSION
		where active='Y'
		and product_id = prod
		AND dapr_product.fnugetPRODUCT_STATUS_ID(product_id,NULL)=2
		and SUSPENSION_TYPE_ID in (SELECT to_number (column_value) tipo_susp
									FROM TABLE (open.ldc_boutilities.splitstrings(sbCadTypeSuspe,',')));

BEGIN

	If FBLAPLICAENTREGAXCASO('0000767') then

		if INSTR(sbCadTypetask, ','||Inutipotrab||',')>=1 and LDC_PKGESTIONLEGAORRP.FBLGETPRODUCTOVENC(Inuproduct_id,IdtfechEjec) then

			OPEN Cu_tipo_susp(Inuproduct_id);
			FETCH Cu_tipo_susp INTO nuCu_tipo_susp;
			CLOSE Cu_tipo_susp;

			if nuCu_tipo_susp > 0  then
				blsw := true;
			else
				blsw:=false;
			end if;

		end if;


	end if;
	return blsw;

exception
  when others then
    return true;
END FBLGENERATRAMITEREPARA;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FBLGENERATRAMITEREPARA', 'ADM_PERSON');
END;
/
