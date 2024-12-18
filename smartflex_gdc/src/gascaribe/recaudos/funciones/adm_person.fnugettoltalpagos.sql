CREATE OR REPLACE FUNCTION adm_person.fnuGetToltalPagos
(
	inusubscriptionid suscripc.susccodi%type, 
	inuproductid servsusc.sesunuse%type, 
	inuFecha pagos.pagofegr%type
)
RETURN number
	/**************************************************************************
    Propiedad Intelectual de Gas Caribe

    Funcion     : fnuGetToltalPagos
    Historia de Modificaciones
      Fecha     Autor           Modificacion
    =========   =========       ====================
	02/01/2024	cgonzalez		OSF-2095: Migrar del esquema OPEN al esquema ADM_PERSON
    **************************************************************************/
IS
    nuTotal number;
BEGIN
    pkg_traza.Trace('INICIO fnuGetToltalPagos', 15);

    BEGIN
        SELECT sum(pagovapa)
        INTO  nuTotal
        FROM(
        SELECT  distinct pagocupo, pagovapa
        FROM pagos, cargos
        WHERE pagocupo = cargcodo
        AND pagosusc = inusubscriptionid
        AND cargnuse = inuproductid
        AND pagofegr > inuFecha);

    EXCEPTION
        when no_data_found then
            return 0;
    END;

    pkg_traza.Trace('RETURN Total = '||nuTotal, 15);

    return nuTotal;


EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END fnuGetToltalPagos;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUGETTIEMPOFUERAMEDI', 'ADM_PERSON');
END;
/