CREATE OR REPLACE PROCEDURE prcReglaCrearTerceraNotifica
IS
/*
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Unidad:       prcReglaCrearTerceraNotifica
    Descripcion:  procedimiento que ejecuta el procedimiento que crea la actividad de impresión tercera notificación
    Autor:        German Dario Guevara Alzate - GlobalMVM
    
    Caso:         OSF-2647
    Fecha:        20/may/2024
    
    Modificaciones
    11/jun/2024   GDGuevara   Se incluye la validacion del comentario por revision tecnica
*/
    nuProducto          NUMBER;
    nuError             NUMBER;
    sbProducto          VARCHAR2(100);    
    sbInstanciaActual   VARCHAR2(4000);   
    sbInstanciaPadre    VARCHAR2(4000);
    sbComment           VARCHAR2(4000);
    sbError             VARCHAR2(4000);
BEGIN
    -- Obtener instancia actual
    GE_BOINSTANCECONTROL.GETCURRENTINSTANCE (sbInstanciaActual);

    -- Consultar campo MO_MOTIVE.PRODUCT_ID de la instancia current
    GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE (sbInstanciaActual, NULL, 'MO_MOTIVE', 'PRODUCT_ID', sbProducto);
    nuProducto := to_number(sbProducto);
    
    -- Consultar campo MO_PACKAGE.COMMENT_ de la instancia padre
    GE_BOINSTANCECONTROL.GETFATHERINSTANCE (sbInstanciaActual, sbInstanciaPadre);

    GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE (sbInstanciaPadre, NULL, 'MO_PACKAGES', 'COMMENT_', sbComment);

    -- Valida que el producto de MO_MOTIVE no sea null
    IF (nvl(nuProducto,0) = 0) THEN
        pkg_error.setErrorMessage(isbMsgErrr => 'PRODUCT_ID de la instancia no puede ser null');
    END IF;
    
    IF (INSTR(sbComment,'SE GENERAN DESDE JOB (JOB_SUSPENSION_XNO_CERT)',1) > 0) THEN
        -- Crea la actividad de notificacion
        prcCrearActividadNotifica (nuProducto);
    END IF;

EXCEPTION
    WHEN pkg_error.controlled_error THEN
        pkg_error.getError(nuError, sbError);    
        pkg_traza.trace('Error controlado en procedimiento prcReglaCrearTerceraNotifica '||sbError, 10);
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError, sbError);
        pkg_traza.trace('Error en procedimiento prcReglaCrearTerceraNotifica '||sbError, 10);
END prcReglaCrearTerceraNotifica;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('PRCREGLACREARTERCERANOTIFICA','OPEN');
END;
/