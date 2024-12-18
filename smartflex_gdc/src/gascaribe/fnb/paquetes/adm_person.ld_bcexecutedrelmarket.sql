CREATE OR REPLACE PACKAGE adm_person.LD_BCEXECUTEDRELMARKET IS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Paquete        : LD_BCExecutedRelMarket
  Descripción    : Paquete BC con las funciones y/o procedimientos
                   para el consultar mediante una ubicación geográfica
                   los mercados relevantes y la cantidad ejecutada de las
                   unidades constructivas. para la generacion de un archivo
                   excel atravez de un .NET

  Autor          : jvaliente Sincecomp.
  Fecha  : 06-09-2012   SAO156931

  Historia de Modificaciones

  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  19/06/2024   PAcosta            OSF-2845: Cambio de esquema ADM_PERSON
  02/09/2013   hvera.SAO213585    Se modifica el método <ProLDCreg>
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fsbVersion
  Descripcion    : Obtiene la versión del paquete.
  Autor          : jvaliente
  Fecha          : 14/08/2012 SAO156931

  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  FUNCTION FSBVERSION RETURN VARCHAR2;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  ProRelMarGeoLoc
  Descripcion :  Método que permite agrupar los mercados relevantes
                 por ubicación geográfica.

  Autor          : jvaliente
  Fecha          : 06/09/2012 SAO156931


  Parametros                  Descripcion
  ============            ===================
  inuGeograpLocationId    Codigo de la ubicacion geografica
  inuInitialYear          Año del periodo inicial
  inuInitialMonth         Mes del periodo inicial
  inuFinalYear            Año del periodo final
  inuFinalMonth           Mes del periodo final
  orfRelMarkBudget        Registro del presupuesto de mercado relevante

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  PROCEDURE ProRelMarGeoLoc(inuRelevantMarketId in LD_Rel_Mark_Budget.Rel_Mark_Budget_Id%TYPE,
                            inuInitialYear      in LD_Rel_Mark_Budget.Year%TYPE,
                            inuInitialMonth     in LD_Rel_Mark_Budget.Month%TYPE,
                            inuFinalYear        in LD_Rel_Mark_Budget.Month%TYPE,
                            inuFinalMonth       in LD_Rel_Mark_Budget.Year%TYPE,
                            orfRelMarkBudget    out constants.tyRefCursor);

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  ProConsUnitBudget
  Descripcion :  Método que permite agrupar la cantidad ejecutada de
                 unidades constrcutivas por mercado relevante.

  Autor       :  SINCECOMP
  Fecha       :  06-09-2012

  Parametros                  Descripcion
  ============            ===================
  inuRMB                 Codigo del Mercado Rlevante
  orfConUniBudget        Registro de unidades constrcutivas ejecutadas

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  PROCEDURE ProConsUnitBudget(inuRelMarkBudgetId in LD_Con_Uni_Budget.Rel_Mark_Budget_Id%TYPE,
                              orfConUniBudget    out constants.tyRefCursor);

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  ProLDCreg
  Descripcion :  Método que permite consultar los registros de la entidad LD_CREG. .

  Autor       :  SINCECOMP
  Fecha       :  06-09-2012

  Parametros                  Descripcion
  ============            ===================
  orfCREG                Registro de la entidad LD_CREG

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  PROCEDURE ProLDCreg(inuTypeQuery          IN Number,
                      inuYear               Ld_Creg.year%type,
                      inuDescRelevantMarket Ld_Creg.Desc_relevant_market%type,
                      inuDescConstructUnit  Ld_Creg.Desc_construct_unit%type,
                      orfCREG               OUT constants.tyRefCursor);

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  ProLDCreg
  Descripcion :  Método que permite consultar los registros de la entidad LD_CREG.

  Autor       :  SINCECOMP
  Fecha       :  06-09-2012

  Parametros                  Descripcion
  ============            ===================
  orfCREG                Registro de la entidad LD_CREG

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  PROCEDURE ProGeograLocation(orfGeograLocation OUT constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Unidad      : ProLdRelevantMarket
  Descripcion : Obtiene los registros de los Mercados Relevantes.

  Autor          : jvaliente
  Fecha          : 25/09/2012 SAO156931

  Parametros             Descripcion
  ============         ===================
  orfLdRelevantMarket  Registros de las Demandas de Gas

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================

  ******************************************************************/
  PROCEDURE ProLdRelevantMarket(orfLdRelevantMarket out constants.tyRefCursor);

END LD_BCExecutedRelMarket;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LD_BCEXECUTEDRELMARKET IS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Paquete        : LD_BCExecutedRelMarket
  Descripción    : Paquete BC con las funciones y/o procedimientos
                   para el consultar mediante una ubicación geográfica
                   los mercados relevantes y la cantidad ejecutada de las
                   unidades constructivas. para la generacion de un archivo
                   excel atravez de un .NET

  Autor          : jvaliente Sincecomp.
  Fecha  : 06-09-2012   SAO156931

  Historia de Modificaciones

  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  --------------------------------------------
  -- Constantes VERSION DEL PAQUETE
  --------------------------------------------
  csbVERSION CONSTANT VARCHAR2(10) := 'SAO213585';

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fsbVersion
  Descripcion    : Obtiene la versión del paquete.
  Autor          : jvaliente
  Fecha          : 14/08/2012 SAO156931

  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  FUNCTION FSBVERSION RETURN VARCHAR2 IS
  BEGIN
    return CSBVERSION;
  END FSBVERSION;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  ProRelMarGeoLoc
  Descripcion :  Método que permite agrupar los mercados relevantes
                 por ubicación geográfica.

  Autor          : jvaliente
  Fecha          : 06/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  inuGeograpLocationId    Codigo de la ubicacion geografica
  inuInitialYear          Año del periodo inicial
  inuInitialMonth         Mes del periodo inicial
  inuFinalYear            Año del periodo final
  inuFinalMonth           Mes del periodo final
  orfRelMarkBudget        Registro del presupuesto de mercado relevante

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  PROCEDURE ProRelMarGeoLoc(inuRelevantMarketId in LD_Rel_Mark_Budget.Rel_Mark_Budget_Id%TYPE,
                            inuInitialYear      in LD_Rel_Mark_Budget.Year%TYPE,
                            inuInitialMonth     in LD_Rel_Mark_Budget.Month%TYPE,
                            inuFinalYear        in LD_Rel_Mark_Budget.Month%TYPE,
                            inuFinalMonth       in LD_Rel_Mark_Budget.Year%TYPE,
                            orfRelMarkBudget    out constants.tyRefCursor) IS
  BEGIN
    ut_trace.Trace('INICIO LD_BCExecutedRelMarket.ProRelMarGeoLoc', 10);

    OPEN orfRelMarkBudget FOR
      SELECT /*+ index (LDRMB IX_LD_REL_MARK_BUDGET_01) */
       Rel_Mark_Budget_ID,
       Relevant_Market_id,
       Geograp_Location_Id,
       Year,
       month
        FROM LD_Rel_Mark_Budget LDRMB
       WHERE LDRMB.Relevant_Market_Id =
             DECODE(inuRelevantMarketId,
                    -1,
                    Relevant_Market_Id,
                    inuRelevantMarketId)
         AND LDRMB.Year * 100 + LDRMB.Month >=
             inuInitialYear * 100 + inuInitialMonth
         AND LDRMB.Year * 100 + LDRMB.Month <=
             inuFinalYear * 100 + inuFinalMonth
       GROUP BY Rel_Mark_Budget_ID,
                Relevant_Market_id,
                Geograp_Location_Id,
                Year,
                month
       ORDER BY Rel_Mark_Budget_ID,
                Relevant_Market_id,
                Geograp_Location_Id,
                Year,
                month;

    ut_trace.Trace('FIN LD_BCExecutedRelMarket.ProRelMarGeoLoc', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;

  END ProRelMarGeoLoc;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  ProConsUnitBudget
  Descripcion :  Método que permite agrupar la cantidad ejecutada de
                 unidades constrcutivas por mercado relevante.

  Autor       :  SINCECOMP
  Fecha       :  06-09-2012

  Parametros                  Descripcion
  ============            ===================
  inuRMB                 Codigo del Mercado Rlevante
  orfConUniBudget        Registro de unidades constrcutivas ejecutadas

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  PROCEDURE ProConsUnitBudget(inuRelMarkBudgetId in LD_Con_Uni_Budget.Rel_Mark_Budget_Id%TYPE,
                              orfConUniBudget    out constants.tyRefCursor) IS
  BEGIN
    ut_trace.Trace('INICIO LD_BCExecutedRelMarket.ProConsUnitBudget', 10);

    OPEN orfConUniBudget FOR
      SELECT /*+ index(Ld_Con_Uni_Budget IX_LD_CON_UNI_BUDGET_02) */
       Construct_Unit_ID, SUM(Amount_executed)
        FROM Ld_Con_Uni_Budget
       WHERE Rel_Mark_Budget_Id = inuRelMarkBudgetId
       GROUP BY Construct_Unit_ID;

    ut_trace.Trace('FIN LD_BCExecutedRelMarket.ProConsUnitBudget', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;

  END ProConsUnitBudget;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  ProLDCreg
  Descripcion :  Método que permite consultar los registros de la entidad LD_CREG.

  Autor       :  SINCECOMP
  Fecha       :  06-09-2012

  Parametros                  Descripcion
  ============            ===================
  orfCREG                Registro de la entidad LD_CREG

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  02/09/2013   hvera.SAO213585    Se modifica para retornar la cantidad
                                  y el valor presupuestado
                                  NC 2980: Se retira el dato quemado de la solucion de OPEN
                                           del SAO hvera.SAO213585. ya que esta comparando una
                                           fecha quemada la cual es 2013
  ***************************************************************/
  PROCEDURE ProLDCreg(inuTypeQuery          IN Number,
                      inuYear               Ld_Creg.year%type,
                      inuDescRelevantMarket Ld_Creg.Desc_relevant_market%type,
                      inuDescConstructUnit  Ld_Creg.Desc_construct_unit%type,
                      orfCREG               OUT constants.tyRefCursor) IS
  BEGIN

    ut_trace.Trace('INICIO LD_BCExecutedRelMarket.ProLDCreg inuTypeQuery ' ||
                   inuTypeQuery,
                   10);

    if inuTypeQuery = 1 then
      OPEN orfCREG FOR
        SELECT /*+ INDEX (LD_CREG PK_LD_CREG)*/
         0 Year,
         Desc_relevant_market,
         '0' Desc_construct_unit,
         0 Amount_Executed
          FROM LD_CREG
         GROUP BY desc_relevant_market
         ORDER BY desc_relevant_market;
    elsif inuTypeQuery = 2 then
      OPEN orfCREG FOR
        SELECT /*+ INDEX (LD_CREG PK_LD_CREG)*/
         0 Year,
         '0' Desc_relevant_market,
         Desc_construct_unit,
         0 Amount_Executed
          FROM LD_CREG
         GROUP BY desc_construct_unit
         ORDER BY desc_construct_unit;
    elsif inuTypeQuery = 3 then
      OPEN orfCREG FOR
        SELECT /*+ INDEX (LD_CREG PK_LD_CREG)*/
         year,
         '0' Desc_relevant_market,
         '0' Desc_construct_unit,
         0 Amount_Executed
          FROM LD_CREG
         GROUP BY year
         ORDER BY year;
    elsif inuTypeQuery = 4 then
      OPEN orfCREG FOR
        SELECT /*+ INDEX (LD_CREG PK_LD_CREG)*/
         0 Year,
         '0' Desc_relevant_market,
         '0' Desc_construct_unit,
         SUM(CUB.amount) Amount_Budget,
         sum(CUB.value_budget_cop) Value_Budget,
         SUM(CG.Amount_Executed) Amount_Executed,
         sum(CUB.value_executed) Value_Executed
          FROM LD_CREG CG, LD_Rel_Mark_Budget RMB, LD_Con_Uni_Budget CUB
        --codigo del hvera.SAO213585
        --WHERE cg.year = 2013
        --fin hvera.SAO213585
         WHERE cg.year = inuYear
           AND cg.Desc_relevant_market = inuDescRelevantMarket
           AND cg.Desc_construct_unit = inuDescConstructUnit
           AND cg.relevant_market_id = RMB.relevant_market_id
           AND RMB.rel_mark_budget_id = CUB.rel_mark_budget_id
           and cg.construct_unit_id = cub.construct_unit_id;
    end if;

    ut_trace.Trace('FIN LD_BCExecutedRelMarket.ProLDCreg', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;

  END ProLDCreg;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  ProLDCreg
  Descripcion :  Método que permite consultar los registros de la entidad LD_CREG.

  Autor       :  SINCECOMP
  Fecha       :  06-09-2012

  Parametros                  Descripcion
  ============            ===================
  orfCREG                Registro de la entidad LD_CREG

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  PROCEDURE ProGeograLocation(orfGeograLocation OUT constants.tyRefCursor) IS
  BEGIN

    ut_trace.Trace('INICIO LD_BCExecutedRelMarket.ProGeograLocation', 10);

    OPEN orfGeograLocation FOR
      select geograp_location_id, description
        from ge_geogra_location ggi
       where ggi.geo_loca_father_id in
             (select geograp_location_id
                from ge_geogra_location ggi
               where ggi.geo_loca_father_id =
                     Dald_Parameter.fnuGetNumeric_Value('COD_GEO_LOC_COL'));

    ut_trace.Trace('FIN LD_BCExecutedRelMarket.ProGeograLocation', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;

  END ProGeograLocation;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Unidad      : ProLdRelevantMarket
  Descripcion : Obtiene los registros de los Mercados Relevantes.

  Autor          : jvaliente
  Fecha          : 25/09/2012 SAO156931

  Parametros             Descripcion
  ============         ===================
  orfLdRelevantMarket  Registros de las Demandas de Gas

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================

  ******************************************************************/
  PROCEDURE ProLdRelevantMarket(orfLdRelevantMarket out constants.tyRefCursor) IS

  BEGIN

    ut_trace.trace('Inicio LD_BCExecutedBudge.ProLdRelevantMarket', 10);

    OPEN orfLdRelevantMarket FOR
      SELECT relevant_market_id Codigo,
             relevant_market    Nombre,
             description        Descripcion
        FROM Ld_Relevant_Market
      UNION ALL
      SELECT -1, 'TODOS', 'TODOS LOS MERCADOS RELEVANTES'
        FROM DUAL
       ORDER BY 1, 2, 3;

    ut_trace.trace('Fin LD_BCExecutedBudge.ProLdRelevantMarket', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;

  END ProLdRelevantMarket;
END LD_BCExecutedRelMarket;
/
PROMPT Otorgando permisos de ejecucion a LD_BCEXECUTEDRELMARKET
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BCEXECUTEDRELMARKET', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LD_BCEXECUTEDRELMARKET para reportes
GRANT EXECUTE ON adm_person.LD_BCEXECUTEDRELMARKET TO rexereportes;
/
