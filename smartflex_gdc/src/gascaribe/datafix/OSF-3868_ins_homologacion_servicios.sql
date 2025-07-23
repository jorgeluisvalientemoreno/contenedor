/***************************************************************************
Propiedad Intelectual de Gases del Caribe
Autor           : Paola Acosta
Fecha           : 16-01-2025
Modificaciones  : Insert homologacion 'PKTBLSERVSUSC.UPDSESUESCO' a 'PKG_PRODUCTO.PRACTUALIZAESTADOCORTE'
Autor       Fecha           Caso        Descripcion
pacosta     16-01-2025      OSF-3868    Creacion
***************************************************************************/
--

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
    OPEN cuExisteReg('PKTBLSERVSUSC.UPDSESUESCO', 'PKG_PRODUCTO.PRACTUALIZASOLOESTADOCORTE');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    --MO_BOANNULMENT.ANNULWFPLAN
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
            'PKTBLSERVSUSC.UPDSESUESCO',
            'Actualiza el estado de corte del servicio',
            'ADM_PERSON',
            'PKG_PRODUCTO.PRACTUALIZASOLOESTADOCORTE',
            NULL,
            'Actualiza solo el estado de corte del servicio'
        );
    END IF;

END;
/