CREATE OR REPLACE FUNCTION adm_person.usu_normalizado_vigente (
    ifecha_nor IN DATE
) RETURN VARCHAR2 IS
  /***********************************************************************************************************
    Funcion     : usu_normalizado_vigente
    Descripcion : 
    Autor       : 
    Fecha       : 

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    06/03/2024          Paola Acosta       OSF-2104: Se agregan permisos para REXEREPORTES por solicitud de CGonzalez
    29/02/2024          Paola Acosta       OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON 
  ************************************************************************************************************/
BEGIN
    IF ( ifecha_nor + 365 >= sysdate ) THEN
        RETURN 'S';
    END IF;
    RETURN ( 'N' );
EXCEPTION
    WHEN OTHERS THEN
        RETURN ' ';
END usu_normalizado_vigente;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('USU_NORMALIZADO_VIGENTE', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.USU_NORMALIZADO_VIGENTE TO REXEREPORTES;
/