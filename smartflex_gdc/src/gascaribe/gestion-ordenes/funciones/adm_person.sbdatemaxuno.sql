CREATE OR REPLACE FUNCTION adm_person.sbdatemaxuno (
    inutipo      IN NUMBER,
    inupackageid IN NUMBER
) RETURN VARCHAR2 IS
  /***********************************************************************************************************
    Funcion     : sbdatemaxuno
    Descripcion : 
    Autor       : 
    Fecha       : 

    Historia de Modificaciones
    Fecha               Autor              Modificacion
    =========           =========          ====================
    29/02/2024          Paola Acosta       OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON 
  ************************************************************************************************************/
  
    CURSOR cufechamax (
        nusolid NUMBER
    ) IS
    SELECT DISTINCT
        to_char(oc1.stat_chg_date)
    FROM
        or_order_activity    oa1,
        or_order_stat_change oc1
    WHERE
            oa1.order_id = oc1.order_id
        AND oa1.package_id = nusolid
        AND oc1.stat_chg_date = (
            SELECT
                MAX(oc.stat_chg_date)
            FROM
                or_order_activity    oa,
                or_order_stat_change oc
            WHERE
                    oa.order_id = oc.order_id
                AND ( ( oc.initial_status_id = 5
                        AND oc.final_status_id = 7 )
                      OR ( oc.initial_status_id = 5
                           AND oc.final_status_id = 8 ) )
                AND oa.package_id = nusolid
                AND oa.task_type_id IN (
                    SELECT
                        id_trabcert
                    FROM
                        ldc_trab_cert
                    WHERE
                        ldc_boutilities.fsbbuscatoken(dald_parameter.fsbgetvalue_chain('TRAB_NO_GENERA_CERT_ASOCIADOS'), id_trabcert,
                        ',') = 'N'
                )
        )
        AND ROWNUM = 1;

    CURSOR cuuo (
        nusolid NUMBER
    ) IS
    SELECT DISTINCT
        to_char(oc1.final_oper_unit_id
                || ' - '
                ||(
            SELECT
                uod.name
            FROM
                or_operating_unit uod
            WHERE
                uod.operating_unit_id = oc1.final_oper_unit_id
        ))
    FROM
        or_order_activity    oa1,
        or_order_stat_change oc1
    WHERE
            oa1.order_id = oc1.order_id
        AND oa1.package_id = nusolid --b.package_id
        AND oc1.stat_chg_date = (
            SELECT
                MAX(oc.stat_chg_date)
            FROM
                or_order_activity    oa,
                or_order_stat_change oc
            WHERE
                    oa.order_id = oc.order_id
                AND ( ( oc.initial_status_id = 5
                        AND oc.final_status_id = 7 )
                      OR ( oc.initial_status_id = 5
                           AND oc.final_status_id = 8 ) )
                AND oa.package_id = nusolid
                AND oa.task_type_id IN (
                    SELECT
                        id_trabcert
                    FROM
                        ldc_trab_cert
                    WHERE
                        ldc_boutilities.fsbbuscatoken(dald_parameter.fsbgetvalue_chain('TRAB_NO_GENERA_CERT_ASOCIADOS'), id_trabcert,
                        ',') = 'N'
                )
        )
        AND ROWNUM = 1;

    sbvalorreturn VARCHAR2(1000) := NULL;
BEGIN
    IF inutipo = 1 THEN -- obtiene la fecha

        OPEN cufechamax(inupackageid);
        FETCH cufechamax INTO sbvalorreturn;
        CLOSE cufechamax;
    ELSE
        OPEN cuuo(inupackageid);
        FETCH cuuo INTO sbvalorreturn;
        CLOSE cuuo;
    END IF;

    RETURN sbvalorreturn;
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END sbdatemaxuno;
/

BEGIN
    pkg_utilidades.praplicarpermisos('SBDATEMAXUNO', 'ADM_PERSON');
END;
/