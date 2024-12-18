CREATE OR REPLACE FUNCTION adm_person.ld_fa_fnu_area_type (
    inuparametro IN ld_fa_paragene.pagedesc%TYPE
) RETURN NUMBER IS
 /**************************************************************
  Propiedad intelectual de de PETI (c).
  
  Unidad       : ld_fa_fnu_area_type  
  Descripcion  : 
  Autor        : 
  Fecha        : 

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  06/03/2024      Paola Acosta        OSF-2104: Se agregan permisos para REXEREPORTES por solicitud de CGonzalez
  27/02/2024      Paola Acosta        OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON                                      
  **************************************************************/
  
    valor     ld_fa_paragene.pagevanu%TYPE;
    gsberrmsg ge_error_log.description%TYPE;
BEGIN
    pkerrors.push('ld_fa_fnu_area_type');
    BEGIN
        SELECT
            x.pagevanu
        INTO valor
        FROM
            ld_fa_paragene x
        WHERE
            x.pagedesc = inuparametro;

    EXCEPTION
        WHEN OTHERS THEN
            pkerrors.notifyerror(pkerrors.fsblastobject, sqlerrm, gsberrmsg);
            pkerrors.pop;
            raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
    END;

    RETURN ( valor );
END ld_fa_fnu_area_type;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LD_FA_FNU_AREA_TYPE', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LD_FA_FNU_AREA_TYPE TO REXEREPORTES;
/