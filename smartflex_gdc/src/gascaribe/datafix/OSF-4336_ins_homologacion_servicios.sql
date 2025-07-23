/***************************************************************************
Propiedad Intelectual de Gases del Caribe
Autor           : Paola Acosta
Fecha           : 13-05-2025
Descripción     : Insert homologaciones
Autor       Fecha           Caso        Descripcion
pacosta     13-05-2025      OSF-4336    Creacion
***************************************************************************/

DECLARE 
    
    nuCant  NUMBER;
    
    CURSOR cuExisteReg(isbservicio_origen IN homologacion_servicios.servicio_origen%TYPE,
                       isbservicio_destino IN homologacion_servicios.servicio_destino%TYPE)
    IS
    SELECT COUNT(*)    
    FROM   homologacion_servicios 
    WHERE  servicio_origen = isbservicio_origen
    AND    servicio_destino = isbservicio_destino;    

BEGIN
    -------1
    OPEN cuExisteReg('PKTBLSERVSUSC.FNUGETCATEGORY', 'PKG_BCPRODUCTO.FNUCATEGORIA');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
        
    IF nuCant = 0 THEN     
        INSERT INTO homologacion_servicios (
            esquema_origen,
            servicio_origen,
            descripcion_origen,
            esquema_destino,
            servicio_destino,
            descripcion_destino,
            observacion
        ) VALUES (
            'OPEN',
            'PKTBLSERVSUSC.FNUGETCATEGORY',
            'Obtiene la categoria del sevicio',
            'ADM_PERSON',
            'PKG_BCPRODUCTO.FNUCATEGORIA',
            NULL,
            'Obtiene la categoria del sevicio'
        );
    END IF;
    
    -------2
    OPEN cuExisteReg('PKTBLSERVSUSC.FNUGETSUBCATEGORY', 'PKG_BCPRODUCTO.FNUSUBCATEGORIA');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN     
        INSERT INTO homologacion_servicios (
            esquema_origen,
            servicio_origen,
            descripcion_origen,
            esquema_destino,
            servicio_destino,
            descripcion_destino,
            observacion
        ) VALUES (
            'OPEN',
            'PKTBLSERVSUSC.FNUGETSUBCATEGORY',
            'Obtiene la subcategoria del sevicio',
            'ADM_PERSON',
            'PKG_BCPRODUCTO.FNUSUBCATEGORIA',
            NULL,
            'Obtiene la subcategoria del sevicio'
        );
    END IF;
    
    -------3 
    OPEN cuExisteReg('PKTBLPLANDIFE.FNUGETPAYMENTMETHOD', 'PKG_PLANDIFE.FNUOBTPLDIMCCD');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN     
        INSERT INTO homologacion_servicios (
            esquema_origen,
            servicio_origen,
            descripcion_origen,
            esquema_destino,
            servicio_destino,
            descripcion_destino,
            observacion
        ) VALUES (
            'OPEN',
            'PKTBLPLANDIFE.FNUGETPAYMENTMETHOD',
            'Obtiene campo PLDIMCCD de la tabla PLANDIFE',
            'ADM_PERSON',
            'PKG_PLANDIFE.FNUOBTPLDIMCCD',
            NULL,
            'Obtiene campo PLDIMCCD de la tabla PLANDIFE'
        );
    END IF;
    
    -------4 
    OPEN cuExisteReg('PKTBLPLANDIFE.FNUGETINTERESTRATECOD', 'PKG_PLANDIFE.FNUOBTPLDITAIN');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN     
        INSERT INTO homologacion_servicios (
            esquema_origen,
            servicio_origen,
            descripcion_origen,
            esquema_destino,
            servicio_destino,
            descripcion_destino,
            observacion
        ) VALUES (
            'OPEN',
            'PKTBLPLANDIFE.FNUGETINTERESTRATECOD',
            'Obtiene campo PLDITAIN de la tabla PLANDIFE',
            'ADM_PERSON',
            'PKG_PLANDIFE.FNUOBTPLDITAIN',
            NULL,
            'Obtiene campo PLDITAIN de la tabla PLANDIFE'
        );
    END IF;
    
    -------5
    OPEN cuExisteReg('FNUGETINTERESTRATE', 'PKG_BOGESTION_FINANCIACION.FNUOBTENERTASAINTERES');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN     
        INSERT INTO homologacion_servicios (
            esquema_origen,
            servicio_origen,
            descripcion_origen,
            esquema_destino,
            servicio_destino,
            descripcion_destino,
            observacion
        ) VALUES (
            'OPEN',
            'FNUGETINTERESTRATE',
            'Obtiene tasa interés',
            'ADM_PERSON',
            'PKG_BOGESTION_FINANCIACION.FNUOBTENERTASAINTERES',
            NULL,
            'Obtiene tasa interés'
        );
    END IF;
END;
/