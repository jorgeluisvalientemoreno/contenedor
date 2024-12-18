CREATE OR REPLACE FUNCTION adm_person.fnuvalpropersca (
    sbproceso IN ge_boinstancecontrol.stysbvalue,
    sbciclo   IN ge_boinstancecontrol.stysbvalue,
    sbdpto    IN ge_boinstancecontrol.stysbvalue,
    sbloca    IN ge_boinstancecontrol.stysbvalue
) RETURN BOOLEAN IS

    /*******************************************************************************
     Metodo:       FNUVALPROPERSCA
     Descripcion:  Funcion que retorna si se puede realizar el proceso de PERSCA o no, dependiendo si no existe
                   un proceso ya programado o en ejecucion, es decir, si la funcion devuelve TRUE quiere decir
                   que se puede realizar el proceso PERSCA, si devuelve F antes se tuvo que haber visto un mensaje
                   de error indicando que no se puede realizar el proceso.
                   
     Autor:        Olsoftware/Mateo Velez
     Fecha:        20/02/2019

     Entrada        Descripcion
     SBPROCESO:     Codigo del proceso
     SBCICLO:       Codigo del ciclo
     SBDPTO:        Codigo del departamento
     SBLOCA:        Codigo de la localidad

     Salida             Descripcion
     BLVALIDPERSCA       indica si se puede seguir con el proceso de PERSCA o no, depediendo del valor que devuelva

     Historia de Modificaciones
     
     Fecha               Autor                Modificacion
     =========           =========          ====================
     22/02/2024          Paola Acosta       OSF-2180: Migraci�n del esquema OPEN al esquema ADM_PERSON    
        
     22/11/2020                             CA452. Se modifica logica para que valide el proceso sin tener en cuenta
                                            el ESTAPROG.
    *******************************************************************************/

    nuprocesautorec        NUMBER;
    nudepartamento         NUMBER;
    nulocalidad            NUMBER;
    nuciclo                NUMBER;
    nuproceso              NUMBER;
    blfindciclo            BOOLEAN := false;
    blfinddepa             BOOLEAN := false;
    blfindloca             BOOLEAN := false;
    blfinderror            BOOLEAN := false;
    blvalidpersca          BOOLEAN := false;
    nuexecutable_id_persca NUMBER(15, 0) := 500000000002480;

    -- CURSOR QUE OBTIENE LOS DATOS DE LA TABLA E DE PROCESOS GE_PROCESS_SCHEDULE
    CURSOR cugetparprocess (
        isbproceso IN VARCHAR2
    ) IS
    SELECT
        (
            SELECT DISTINCT
                replace(regexp_substr(gp.parameters_, '[^|]+', 1, 2), 'CICLCICO=', '')
            FROM
                dual
        )              ciclo,
        (
            SELECT DISTINCT
                replace(regexp_substr(gp.parameters_, '[^|]+', 1, 3), 'GEO_LOCA_FATHER_ID=', '')
            FROM
                dual
        )              departamento,
        (
            SELECT DISTINCT
                replace(regexp_substr(gp.parameters_, '[^|]+', 1, 4), 'GEOGRAP_LOCATION_ID=', '')
            FROM
                dual
        )              localidad,
        (
            SELECT DISTINCT
                replace(regexp_substr(gp.parameters_, '[^|]+', 1, 1), 'ORDER_COMMENT=', '')
            FROM
                dual
        )              proceso,
        gp.status      estado,
        gp.start_date_ fecha_inicio,
        sa.name        nombrejecutable
    FROM
        ge_process_schedule gp,
        sa_executable       sa
    WHERE
            gp.executable_id = 500000000002480 --nuExecutable_id_PERSCA
        AND sa.executable_id = gp.executable_id
        AND gp.parameters_ LIKE '%'
                                || isbproceso
                                || '%'
        AND gp.status = 'P' --IN ('P','E')
    ORDER BY
        ciclo;

    -- se consulta cual es el estado del proceso que se ejecut� justo despues de la fecha de programacion en la tabla GE_PROCESS_SCHEDULE
    CURSOR cugetestaprog (
        nameexec sa_executable.name%TYPE,
        fechaini ge_process_schedule.start_date_%TYPE
    ) IS
    SELECT
        es.esprporc estadoprocess
    FROM
        estaprog es
    WHERE
        es.esprprog LIKE '%'
                         || nameexec
                         || '%'
        AND es.esprfein BETWEEN fechaini -- si la fecha del proceso ejecutado es mayor a la fecha del programado
         AND fechaini + 1 / 1440;  -- y a la ves es menor a la fecha del programado + 1, se pone mas 1 por la diferencia de segundos que tiene al ejecutarse

    -- CURSOR QUE OBTIENE LOS DATOS DE LOS CICLOS DE LA TABLA CICLO
    CURSOR cugetciclo IS
    SELECT
        ciclcodi codciclo
    FROM
        ciclo
    WHERE
        ciclcodi <> - 1
    ORDER BY
        codciclo;

     -- SENTENCIA PARA OBTENER LA LISTA DE VALORES DE LOS DPTOS
    CURSOR cugetdpto IS
    SELECT
        codigodepa
    FROM
        (
            SELECT
                geograp_location_id codigodepa
            FROM
                ge_geogra_location
            WHERE
                    geograp_location_id <> - 1
                AND geog_loca_area_type = 2
        )
    ORDER BY
        codigodepa;

     -- SENTENCIA PARA OBTENER LA LISTA DE LOCALIDADES
    CURSOR cugetloca (
        nudepa NUMBER
    ) IS
    SELECT
        geograp_location_id codigoloca
    FROM
        ge_geogra_location
    WHERE
            geog_loca_area_type = 3
        AND geo_loca_father_id = decode(nudepa, - 1, geo_loca_father_id, nudepa);

    infoestaprog           cugetestaprog%rowtype;
    infociclo              cugetciclo%rowtype;
    infodpto               cugetdpto%rowtype;
    infoloca               cugetloca%rowtype;
    csbentrega47           VARCHAR2(20) := '0000047';
    sbprocessexec          VARCHAR2(50);
BEGIN
    IF fblaplicaentregaxcaso(csbentrega47) THEN

       --nuProcesautorec := dald_parameter.fnugetnumeric_value('LDC_PROCAUTORECO',NULL);

        nuproceso := to_number(sbproceso);
        nuciclo := to_number(sbciclo);
        nudepartamento := to_number(sbdpto);
        nulocalidad := to_number(sbloca);
        nuprocesautorec := nuproceso;
        sbprocessexec := 'ORDER_COMMENT=' || sbproceso;
      -- se validar� los parametros que se obtienen del PB
      -- SE VALIDA QUE EL PROCESO SEA EL 7-AUTORECONECTADO
        IF instr(','
                 || dald_parameter.fsbgetvalue_chain('LDC_PROCESOS_NO_PARALELO', 0)
                 || ',', ','
                         || sbproceso
                         || ',') > 0 THEN
            FOR fitemprocess IN cugetparprocess(sbprocessexec) LOOP
                --Si el cilo es igual, departamento igual y localidad igual
                IF (
                    fitemprocess.ciclo = nuciclo
                    AND fitemprocess.departamento = nudepartamento
                    AND fitemprocess.localidad = nulocalidad
                    AND fitemprocess.proceso = nuprocesautorec
                ) THEN
                    blfinderror := true;
                END IF;

                --Si el ciclo es -1, departamento -1 y localidad -1
                IF (
                    fitemprocess.ciclo = -1
                    AND fitemprocess.departamento = -1
                    AND fitemprocess.localidad = -1
                    AND fitemprocess.proceso = nuprocesautorec
                ) THEN
                    blfinderror := true;
                END IF;

                --Si el ciclo es igual el departamento igual y localidad -1
                IF (
                    fitemprocess.ciclo = nuciclo
                    AND fitemprocess.departamento = nudepartamento
                    AND fitemprocess.localidad = -1
                    AND fitemprocess.proceso = nuprocesautorec
                ) THEN
                      --DBMS_OUTPUT.PUT_LINE('ERROR NO SE PUEDE EJECUTAR EL PROCESO PORQUE YA ESTA PROGRAMADO!!!');
                    blfinderror := true;
                END IF;

                --Si el ciclo es -1, departamento igual y localidad -1
                IF (
                    fitemprocess.ciclo = -1
                    AND fitemprocess.departamento = nudepartamento
                    AND fitemprocess.localidad = -1
                    AND fitemprocess.proceso = nuprocesautorec
                ) THEN
                    blfinderror := true;
                END IF;

                --Si el cilo es -1 departamento igual y localidad igual.
                IF (
                    fitemprocess.ciclo = -1
                    AND fitemprocess.departamento = nudepartamento
                    AND fitemprocess.localidad = nulocalidad
                    AND fitemprocess.proceso = nuprocesautorec
                ) THEN
                    blfinderror := true;
                END IF;

                --Si el ciclo ingresado es -1 departamento igual y localidad igual.
                IF (
                    nuciclo = -1
                    AND fitemprocess.departamento = nudepartamento
                    AND fitemprocess.localidad = nulocalidad
                    AND fitemprocess.proceso = nuprocesautorec
                ) THEN
                    blfinderror := true;
                END IF;

                --Si el ciclo ingresado es -1 departamento igual y localidad igual.
                IF (
                    nuciclo = -1
                    AND fitemprocess.departamento = nudepartamento
                    AND nulocalidad = -1
                    AND fitemprocess.proceso = nuprocesautorec
                ) THEN
                    blfinderror := true;
                END IF;

                --Si el ciclo es -1, departamento ingresado es -1 y localidad es igual
                IF (
                    nuciclo = -1
                    AND nudepartamento = -1
                    AND fitemprocess.localidad = nulocalidad
                    AND fitemprocess.proceso = nuprocesautorec
                ) THEN
                    blfinderror := true;
                END IF;

                  --Si el ciclo es -1, departamento ingresado es -1 y localidad es igual
                IF (
                    nuciclo = -1
                    AND nudepartamento = -1
                    AND nulocalidad = -1
                    AND fitemprocess.proceso = nuprocesautorec
                ) THEN
                    blfinderror := true;
                END IF;

            END LOOP; -- fin FOR fitemprocess IN CUGETPARPROCESS

            -- aqui se valida que si encontro o no algun ciclo con un depa y con localidad en proceso o programado
            --IF(BLFINDLOCA OR BLFINDERROR)THEN
            IF ( blfinderror ) THEN
                dbms_output.put_line('ERROR NO SE PUEDE EJECUTAR EL PROCESO PORQUE YA ESTA PROGRAMADO ****!!!');
                blvalidpersca := false;
            ELSE
                dbms_output.put_line('EL PROCESO SI SE PUEDE EJECUTAR');
                blvalidpersca := true;
            END IF;

        ELSE
            blvalidpersca := true;
        END IF; -- fin de IF(nuProceso = nuProcesautorec)THEN
    ELSE
        blvalidpersca := true;
    END IF;

    RETURN blvalidpersca;
EXCEPTION
    WHEN ex.controlled_error THEN
        RAISE ex.controlled_error;
    WHEN OTHERS THEN
        errors.seterror;
        RAISE ex.controlled_error;
END fnuvalpropersca;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUVALPROPERSCA', 'ADM_PERSON');
END;
/