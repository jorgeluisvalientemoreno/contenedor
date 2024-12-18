CREATE OR REPLACE FUNCTION adm_person.ldc_tecnicos_certificado (
    inuperson_id IN ge_person.person_id%TYPE
) RETURN NUMBER IS
  /***********************************************************************************************************
    Funcion     : ldc_tecnicos_certificado
    Descripcion : 
    Autor       : 
    Fecha       : 

    Historia de Modificaciones
    Fecha               Autor              Modificacion
    =========           =========          ====================
    06/03/2024          Paola Acosta       OSF-2104: Se agregan permisos para REXEREPORTES por solicitud de CGonzalez
    29/02/2024          Paola Acosta       OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON 
  ************************************************************************************************************/
  
    nuperson_id ge_person.person_id%TYPE;
BEGIN
    SELECT /*+ INDEX(o IX_OR_OPER_UNIT_PERSONS02) INDEX(p PK_GE_PERSON)*/ DISTINCT
        p.person_id
    INTO nuperson_id
    FROM
        or_oper_unit_persons o,
        ge_person            p
    WHERE
            p.person_id = inuperson_id
        AND o.person_id = p.person_id
        AND o.operating_unit_id IN (
            SELECT
                to_number(column_value)
            FROM
                TABLE ( ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_UNI_OPE_LDCTA', NULL), ',') )
        )
    ORDER BY
        p.person_id;

    RETURN nuperson_id;
EXCEPTION
    WHEN OTHERS THEN
        RETURN ( 0 );
END ldc_tecnicos_certificado;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_TECNICOS_CERTIFICADO', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_TECNICOS_CERTIFICADO TO REXEREPORTES;
/