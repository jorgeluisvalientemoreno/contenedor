CREATE OR REPLACE FUNCTION adm_person.fnugetttotrecone (
    nuorderid IN NUMBER
) RETURN NUMBER IS
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnugetttotrecone
  Descripcion    : 

  Autor          : 
  Fecha          : 

  Parametros                      Descripcion
  ============                 ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  21-02-2024      Paola Acosta        OSF-2180: Migraci�n del esquema OPEN al esquema ADM_PERSON    

  ******************************************************************/
    result    NUMBER;
    sbtitr    ld_parameter.value_chain%TYPE;
    nuproduct pr_product.product_id%TYPE;
BEGIN
    sbtitr := dald_parameter.fsbgetvalue_chain('COD_TIPOS_TRABAJO_RECONEXION');
    SELECT
        COUNT(*)
    INTO result
    FROM
        or_order          o,
        or_order_activity a,
        servsusc          s
    WHERE
            o.order_id = a.order_id
        AND a.product_id = s.sesunuse
        AND o.order_id = nuorderid
        AND s.sesuesfn = 'C'
        AND regexp_instr(sbtitr, o.task_type_id) > 0;

    RETURN ( result );
EXCEPTION
    WHEN ex.controlled_error THEN
        RAISE ex.controlled_error;
    WHEN no_data_found THEN
        result := 0;
    WHEN OTHERS THEN
        errors.seterror;
        RAISE ex.controlled_error;
END fnugetttotrecone;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUGETTTOTRECONE', 'ADM_PERSON');
END;
/