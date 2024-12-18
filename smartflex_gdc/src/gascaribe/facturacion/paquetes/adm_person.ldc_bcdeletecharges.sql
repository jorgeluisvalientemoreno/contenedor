CREATE OR REPLACE package adm_person.ldc_bcdeletecharges is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  20/06/2024   Adrianavg   OSF-2848: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
  
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BCDeleteCharges
    Descripcion    : Paquete donde se implementa la lógica eliminar cargos con cuentas de cobro -1
					 de un ciclo de facturación registrados a través de la interfaz de archivos para
					 clientes de mercado no regulado.

    Autor          : Sayra Ocoró
    Fecha          : 07/03/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

 /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrDeleteCharges
  Descripcion    : Procedimiento para eliminar cargos por ciclo de facturación
  Autor          :
  Fecha          : 07/03/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

Procedure PrDeleteCharges;

end LDC_BCDeleteCharges;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BCDeleteCharges IS

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BCDeleteCharges
    Descripcion    : Paquete donde se implementa la lógica eliminar cargos con cuentas de cobro -1
					 de un ciclo de facturación registrados a través de la interfaz de archivos para
					 clientes de mercado no regulado.

    Autor          : Sayra Ocoró
    Fecha          : 07/03/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

 /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrDeleteCharges
  Descripcion    : Procedimiento para eliminar cargos por ciclo de facturación
  Autor          :
  Fecha          : 07/03/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

Procedure PrDeleteCharges is

	cnuNULL_ATTRIBUTE constant number := 2126;
    sbCOCICICL ge_boInstanceControl.stysbValue;

BEGIN
   ut_trace.Trace('INICIO LDC_BCDeleteCharges.PrDeleteCharges', 10);

    sbCOCICICL := ge_boInstanceControl.fsbGetFieldValue ('CONCCICL', 'COCICICL');

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    if (sbCOCICICL is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'Ciclo Facturacion:');
        raise ex.CONTROLLED_ERROR;
    end if;

    ------------------------------------------------
    -- User code
    ------------------------------------------------
	delete from cargos
	where CARGNUSE in (select sesunuse from servsusc where sesucate in (SELECT TO_NUMBER(COLUMN_VALUE)
                FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('CATEGORIAS_CARGOS_1',NULL),',')))) --6,7,8,9
	and CARGPEFA = (select PEFACODI  from perifact where PEFACICL = to_number(sbCOCICICL) and PEFAACTU = 'S')
	and CARGPROG in (SELECT TO_NUMBER(COLUMN_VALUE)
                FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('ID_PROG_1',NULL),',')))
	and CARGCUCO = -1;
	commit;

	ut_trace.Trace('FIN LDC_BCDeleteCharges.PrDeleteCharges', 10);
EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise;

    when OTHERS then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END PrDeleteCharges;

END LDC_BCDeleteCharges;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_BCDELETECHARGES
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BCDELETECHARGES', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS a REXEREPORTES sobre LDC_BCDELETECHARGES
GRANT EXECUTE ON ADM_PERSON.LDC_BCDELETECHARGES TO REXEREPORTES;
/