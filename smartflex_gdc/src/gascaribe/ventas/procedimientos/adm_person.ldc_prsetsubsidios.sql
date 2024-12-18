CREATE OR REPLACE PROCEDURE adm_person.ldc_prsetsubsidios (nuSolicitud   MO_PACKAGES.PACKAGE_ID%TYPE)
IS

      /*******************************************************************************
     Metodo:       LDC_PRSETSUBSIDIOS
     Descripcion:  Procedimiento que se encarga de llenar la tabla LDC_SUBSIDIOS por medio de una
                   sentencia que obtiene toda la informacion de subsidios al ejecutarse uno de estos
                   tramites (-	271 Venta de Gas por Formulario
                             -	100229 Venta de Gas Cotizada)

     Autor:        Olsoftware/Miguel Ballesteros
     Fecha:        12/12/2019

     Entrada           Descripcion
     nuSolicitud:      Codigo de la solicitud

     Historia de Modificaciones
     FECHA              AUTOR               DESCRIPCION
    =========         =========         ====================
    08/05/2024        Adrianavg         OSF-2668: Se migra del esquema OPEN al esquema ADM_PERSON
    *******************************************************************************/
    nuCaso varchar2(30):='0000198';

    CURSOR CUGETINFORSUBSIDIO IS
        WITH ventatotal AS (
        SELECT  pa.package_id,
                sum(mo.total_value) valor_final_venta
        FROM OPEN.mo_packages pa,
             OPEN.mo_gas_sale_data mo
        WHERE   pa.motive_status_id NOT IN (SELECT to_number(COLUMN_VALUE)
                                             FROM TABLE(ldc_boutilities.splitstrings(OPEN.dald_parameter.fsbgetvalue_chain('LDC_PARCONFMOTIVOS', NULL), ',')))
        AND   mo.package_id = pa.package_id
        AND   pa.package_id = nuSolicitud
        GROUP BY  pa.package_id)
        SELECT v.package_id,
                 CASE WHEN MAX(su.package_id) IS NOT NULL THEN 'Y' ELSE 'N' END aplica_subsidio,
                sum(nvl(subsidy_value,0)) total_subsidio,
               (valor_final_venta + sum(nvl(subsidy_value,0))) valor_bruto_venta,
               valor_final_venta
        FROM  ventatotal v
          LEFT JOIN ld_asig_subsidy su ON su.package_id = v.package_id
        GROUP BY valor_final_venta, v.package_id;



    -- procedimiento pragma para hacer el insert en la tabla LDC_SUBSIDIOS
    procedure prollenaldcsubsidios (sbAplicaSubs        VARCHAR2,
                                    nuTotalSubs         NUMBER,
                                    nuValBrutoVenta     NUMBER,
                                    nuValFinalVenta     NUMBER) is
   -- PRAGMA AUTONOMOUS_TRANSACTION;
    begin
     insert into LDC_SUBSIDIOS
           (PACKAGE_ID,
            APLICASUBSIDIO,
            TOTALSUBSIDIO,
            VALBRUTOVENTA,
            VALFINALVENTA)
            values
            (nuSolicitud,
             sbAplicaSubs,
             nuTotalSubs,
             nuValBrutoVenta ,
             nuValFinalVenta
            );
      --  commit;
    exception
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    end;


BEGIN

   IF fblAplicaEntregaxCaso(nuCaso)THEN

	   -- se recorre el cursor y con los datos obtenidos se hace llama al procedimiento para hacer un insert en la tabla
	   ut_trace.trace('Inicia LDC_PRSETSUBSIDIOS', 10);

	   FOR itemSub IN CUGETINFORSUBSIDIO
		  LOOP
			prollenaldcsubsidios(itemSub.APLICA_SUBSIDIO,itemSub.TOTAL_SUBSIDIO,itemSub.VALOR_BRUTO_VENTA,itemSub.VALOR_FINAL_VENTA);
		END LOOP;

	   ut_trace.trace('Finaliza LDC_PRSETSUBSIDIOS', 10);

    END IF;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END LDC_PRSETSUBSIDIOS;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDC_PRSETSUBSIDIOS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRSETSUBSIDIOS', 'ADM_PERSON'); 
END;
/
