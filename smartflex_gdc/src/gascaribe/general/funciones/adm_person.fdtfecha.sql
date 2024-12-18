CREATE OR REPLACE FUNCTION adm_person.fdtfecha (
    nusesunuse   NUMBER,
    nubasedato   NUMBER,
    complementos NUMBER
) RETURN DATE IS
 /**************************************************************
  Propiedad intelectual de GC.
  
  Unidad       : fdtfecha  
  Descripci�n  : 
  Autor        : 
  Fecha        : 

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  06/03/2023      Paola Acosta        OSF-2180: Se agregan permisos para REXEREPORTES
  19/02/2023      Paola Acosta        OSF-2180: Migraci�n del esquema OPEN al esquema ADM_PERSON                                      
  **************************************************************/

    CURSOR cufecha IS
    SELECT
        MAX(cetsfech)
    FROM
        ldc_temp_caestese_sge
    WHERE
            cetsnuse = nusesunuse - complementos
        AND basedato = nubasedato;

    dtfecha DATE;
BEGIN
    dtfecha := sysdate;
    OPEN cufecha;
    FETCH cufecha INTO dtfecha;
    IF ( cufecha%notfound ) OR ( dtfecha IS NULL ) THEN
        dtfecha := sysdate;
    END IF;

    CLOSE cufecha;
    RETURN ( dtfecha );
END fdtfecha;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FDTFECHA', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.FDTFECHA TO REXEREPORTES;
/