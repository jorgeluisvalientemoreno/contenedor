CREATE OR REPLACE FUNCTION adm_person.FNUGETTIEMPOFUERAMEDI (
                        idtFechaInicial in date,
                        idtFechaFinal in date)
RETURN NUMBER IS

  /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     : fnuGetTiempoFueraMedi
    Descripcion : Funcion para hallar la diferencia de horas y minutos entre la
                  la fecha INICIO_BYPASS y FINAL_BYPASS

    Autor       : Alexandra Gordillo
    Fecha       : 16-05-2013

    Historia de Modificaciones
      Fecha     Autor           Modificacion
    =========   =========       ====================
    16-05-2013  agordillo       Creacion.
	02/01/2024	cgonzalez		OSF-2095: Migrar del esquema OPEN al esquema ADM_PERSON
    **************************************************************************/

    nuTiempoFuera number;
    sbTiempo      varchar2(100);
    sbTiempo1      varchar2(100);
    sbTiempo2      varchar2(100);
BEGIN

    pkg_traza.Trace('Inicia Funcion fnuGetTiempoFueraMedi',15);

    pkg_traza.Trace('Fecha Inicial '||idtFechaInicial, 15);
    pkg_traza.Trace('Fecha Inicial '||idtFechaFinal, 15);

    IF (idtFechaFinal is null and idtFechaFinal is null) then
        nuTiempoFuera := 0.0;
    ELSE
        select
            floor((to_date(idtFechaFinal) - to_date(idtFechaInicial) )*24) ,
            floor(((to_date(idtFechaFinal) - to_date(idtFechaInicial))*24-(floor((to_date(idtFechaFinal) - to_date(idtFechaInicial))*24)))*60)
        into sbTiempo1,sbTiempo2
        from dual;

        if sbTiempo2 in ('1','2','3','4','5','6','7','8','9') then
           sbTiempo2 := '0'||sbTiempo2;
        end if;

        sbTiempo := sbTiempo1 ||'.'||sbTiempo2;

        nuTiempoFuera := to_number(sbTiempo);

    END IF;

    pkg_traza.Trace('Tiempo '||nuTiempoFuera, 15);

RETURN nuTiempoFuera;
END fnuGetTiempoFueraMedi;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUGETTIEMPOFUERAMEDI', 'ADM_PERSON');
END;
/