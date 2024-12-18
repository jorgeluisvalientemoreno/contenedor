CREATE OR REPLACE PROCEDURE ldc_prFillOTREVcertifi
IS
/*****************************************************************
   Propiedad intelectual de Gases del Caribe

   Unidad         : ldc_prFillOTREVcertifi
   Descripcion    : 
   Autor          :
   Fecha          : 

   Parametros              Descripcion
   ============         ===================

   Fecha             Autor             Modificacion
   =========       =========           ====================
   26/06/2024       jpinedc            OSF-2606: * Se usa pkg_Correo
                                       * Ajustes por estándares
   ******************************************************************/

    csbMetodo        CONSTANT VARCHAR2(70) :=  'ldc_prFillOTREVcertifi';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
        
    CURSOR r IS SELECT * FROM ldc_rangogenint;

    sw          BOOLEAN;
    dtFecha     DATE;
    X           NUMBER;

    CURSOR curservgas IS
          SELECT sesunuse
            FROM servsusc
           WHERE sesuserv = 7014
        ORDER BY sesunuse ASC;

    n           NUMBER := 0;
    ri          NUMBER := 1;
    rf          NUMBER;
    sr          NUMBER := 1;
    v           NUMBER;
    sbQuery     VARCHAR2 (2000);
    sbDestinatarios      VARCHAR2 (2000);
    sbAsunto   VARCHAR2 (255) := '';

    CURSOR cuCorreo 
    IS
    SELECT P.E_MAIL
    FROM ge_person p
    WHERE p.person_id = pkg_BOPersonal.fnuGetPersonaID; 
         
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    OPEN cuCorreo;
    FETCH cuCorreo INTO sbDestinatarios;
    CLOSE cuCorreo;

    IF sbDestinatarios IS NOT NULL
    THEN
        sbAsunto := 'Notificacion: Procesos de Revisión Periodica ';
        
        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbDestinatarios,
            isbAsunto           => sbAsunto,
            isbMensaje          => 'Inicia La ejecucion del Proceso: ldc_prFillOTREVcertifi'
        );
            
    END IF;

    DELETE FROM PRUTIME;

    -- A MANERA DE PRUEBA Y VERIFICACION DE CUANTO DEMORA LA GENERACION DINAMICA DE LOS RANGOS DE A 100.000 USUARIOS,
    --REGISTRA LA FECHA (FECHA/HORA) EN QUE EMPIEZA LA GENERACION DINAMICA DE LOS RANGOS
    INSERT INTO prutime
         VALUES ('EMPIEZA', SYSDATE);

    -- BORRA LOS RANGOS QUE SE HUBIEREN GENERADO DE MANERA DINAMICA LA ULTIMA VEZ QUE SE EJECUTO EL PROCEDIMIENTO
    DELETE FROM ldc_rangogenint;

    COMMIT;

    FOR u IN curservgas
    LOOP
        n := n + 1;
        v := u.sesunuse;

        IF n = 100000
        THEN
            n := 0;
            rf := u.sesunuse;

            INSERT INTO ldc_rangogenint (codrango,
                                         rangoini,
                                         rangofin,
                                         ejecutado,
                                         inicia,
                                         finaliza,
                                         observacion)
                 VALUES (sr,
                         ri,
                         rf,
                         1,
                         NULL,
                         NULL,
                         'EMPEZO');

            ri := rf + 1;
            sr := sr + 1;
        END IF;
    END LOOP;

    IF n > 0
    THEN
        INSERT INTO ldc_rangogenint (codrango,
                                     rangoini,
                                     rangofin,
                                     ejecutado,
                                     inicia,
                                     finaliza,
                                     observacion)
             VALUES (sr,
                     ri,
                     v,
                     1,
                     NULL,
                     NULL,
                     'EMPEZO');
    END IF;

    -- A MANERA DE PRUEBA Y VERIFICACION DE CUANTO DEMORA LA GENERACION DINAMICA DE LOS RANGOS DE A 100.000 USUARIOS,
    --REGISTRA LA FECHA (FECHA/HORA) EN QUE TERMINA LA GENERACION DE LOS RANGOS
    INSERT INTO prutime
         VALUES ('TERMINA RANGOS', SYSDATE);

    COMMIT;
    sbQuery := 'truncate table LDC_OTREV_CERTIF';

    EXECUTE IMMEDIATE sbQuery;

    FOR a IN r
    LOOP
        dtFecha := (SYSDATE);
        DBMS_JOB.SUBMIT (
            x,
               'ldc_prFillOTREVcertifiDdet('
            || TO_CHAR (a.codrango)
            || ','
            || TO_CHAR (a.rangoini)
            || ','
            || TO_CHAR (a.rangofin)
            || ');',
            dtfecha);
        COMMIT;
    END LOOP;

    sw := TRUE;

    WHILE sw
    LOOP
        SELECT COUNT (1)
          INTO n
          FROM ldc_rangogenint
         WHERE ejecutado = 1;

        IF n = 0
        THEN
            sw := FALSE;
        END IF;
    END LOOP;

    INSERT INTO prutime
         VALUES ('TERMINA PROC.', SYSDATE);

    COMMIT;

    IF sbDestinatarios IS NOT NULL
    THEN
        sbAsunto := 'Notificacion: Procesos de Revisión Periodica ';

        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbDestinatarios,
            isbAsunto           => sbAsunto,
            isbMensaje          => 'Termina La ejecucion del Proceso: ldc_prFillOTREVcertifi'
        );        
        
    END IF;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
EXCEPTION
    WHEN OTHERS
    THEN
        INSERT INTO prutime
             VALUES ('PROC TERMINO CON ERRORES.', SYSDATE);
END ldc_prFillOTREVcertifi;
/

GRANT EXECUTE ON LDC_PRFILLOTREVCERTIFI TO SYSTEM_OBJ_PRIVS_ROLE;
/

