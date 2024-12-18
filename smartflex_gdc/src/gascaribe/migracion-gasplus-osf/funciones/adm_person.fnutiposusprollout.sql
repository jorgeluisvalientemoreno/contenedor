CREATE OR REPLACE FUNCTION adm_person.fnutiposusprollout (
    nusesunuse      IN     NUMBER,
    nubasedato      IN     NUMBER,
    complementos    IN     NUMBER
) RETURN NUMBER IS
 /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnutiposusprollout
  Descripcion    : 

  Autor          : 
  Fecha          : 

  Parametros                      Descripcion
  ============                 ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  22-02-2024      Paola Acosta        OSF-2180: Migraci�n del esquema OPEN al esquema ADM_PERSON                                               

  ******************************************************************/
    CURSOR cutiposusp (
        nuprod NUMBER
    ) IS
    SELECT
        osf_tipo_suspension
    FROM
        ldc_estados_serv_homo
    WHERE
            estado_tecnico = (
                SELECT
                    sesueste
                FROM
                    ldc_temp_servsusc_sge
                WHERE
                        sesunuse = nusesunuse - complementos
                    AND basedato = nubasedato
                    AND ROWNUM = 1
            )
        AND estado_financi = (
            SELECT
                sesuesfi
            FROM
                ldc_temp_servsusc_sge
            WHERE
                    sesunuse = nusesunuse - complementos
                AND basedato = nubasedato
                AND ROWNUM = 1
        )
        AND osf_estado_produc = (
            SELECT
                product_status_id
            FROM
                pr_product
            WHERE
                product_id = nuprod
        )
        AND ROWNUM = 1;

    nutipo NUMBER := NULL;
BEGIN
    OPEN cutiposusp(nusesunuse);
    FETCH cutiposusp INTO nutipo;
    
    IF ( cutiposusp%notfound ) OR ( nutipo IS NULL ) THEN
        nutipo := 11; -- Tipo de Suspension Administrativa
    END IF;

    CLOSE cutiposusp;
    
    RETURN ( nutipo );
    
END fnutiposusprollout;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUTIPOSUSPROLLOUT', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON adm_person.fnutiposusprollout TO REXEREPORTES;
/