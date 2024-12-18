CREATE OR REPLACE PACKAGE adm_person.LD_bcLegalizeSale IS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_bolegalizeSale
  Descripcion    :
  Autor          :
  Fecha          : 16/07/2012

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========   ========= ====================
  20/06/2024          PAcosta            OSF-2845: Cambio de esquema ADM_PERSON   
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuHistoricSales
  Descripcion    : Retorna el consecutivo de historico a partir de la solicitud
                   de consecutivo.
  Autor          : AAcuna
  Fecha          : 06/02/2013

  Parametros              Descripcion
  ============         ===================
  inuPackage:      Número de solicitud


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  FUNCTION fnuHistoricSales(inuPackage mo_packages.package_id%TYPE)

   return ld_conse_historic_sales.conse_historic_sales_id%type;

END LD_bcLegalizeSale;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LD_bcLegalizeSale IS
  -- Declaracion de variables y tipos globales privados del paquete

  -- Definicion de metodos publicos y privados del paquete

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : legalizeDelivery
  Descripcion    : .

  Autor          : AAcuna
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================
  inuOrdeNum           Identificador de la orden.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuHistoricSales
  Descripcion    : Retorna el consecutivo de historico a partir de la solicitud
                   de consecutivo.
  Autor          : AAcuna
  Fecha          : 06/02/2013

  Parametros              Descripcion
  ============         ===================
  inuPackage:      Número de solicitud


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  FUNCTION fnuHistoricSales(inuPackage mo_packages.package_id%TYPE)

   return ld_conse_historic_sales.conse_historic_sales_id%type

   IS

    nuHistoricSal ld_conse_historic_sales.conse_historic_sales_id%type;

  BEGIN

    SELECT conse_historic_sales_id
      INTO nuHistoricSal
      FROM ld_conse_historic_sales
     WHERE package_id_ = inuPackage;

     return nuHistoricSal;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return 0;
    when others then
      return 0;
  END fnuHistoricSales;

END LD_bcLegalizeSale;
/
PROMPT Otorgando permisos de ejecucion a LD_BCLEGALIZESALE
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BCLEGALIZESALE', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LD_BCLEGALIZESALE para reportes
GRANT EXECUTE ON adm_person.LD_BCLEGALIZESALE TO rexereportes;
/
