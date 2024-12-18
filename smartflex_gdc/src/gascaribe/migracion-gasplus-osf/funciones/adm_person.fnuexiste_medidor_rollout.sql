CREATE OR REPLACE FUNCTION adm_person.fnuexiste_medidor_rollout (

    inumedidor  IN NUMBER,
    inubasedato IN NUMBER
) RETURN NUMBER AS
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuexiste_medidor_rollout
  Descripcion    : 

  Autor          : 
  Fecha          : 

  Parametros                      Descripcion
  ============                 ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  06/03/2023      Paola Acosta        OSF-2180: Se agregan permisos para REXEREPORTES
  21-02-2024      Paola Acosta        OSF-2180: Migraci�n del esquema OPEN al esquema ADM_PERSON    
  ******************************************************************/
    CURSOR cumedidor IS
    SELECT
        *
    FROM
        ldc_temp_medicaja_sge
    WHERE
            mecjitem = inumedidor
        AND basedato = inubasedato;

    rtmedidor cumedidor%rowtype;
    nuretorno NUMBER := 0;
BEGIN
    OPEN cumedidor;
    FETCH cumedidor INTO rtmedidor;
    IF cumedidor%found THEN
        nuretorno := 1;
    END IF;
    CLOSE cumedidor;
    RETURN nuretorno;
END fnuexiste_medidor_rollout;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUEXISTE_MEDIDOR_ROLLOUT', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON adm_person.fnuexiste_medidor_rollout TO REXEREPORTES;
/
