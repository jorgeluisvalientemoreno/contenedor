CREATE OR REPLACE PROCEDURE ADM_PERSON.CAMBIOCATEGORIAPROD  IS

  /*****************************************************************************************************************
  Propiedad intelectual de PETI.

  Unidad         : CAMBIOCATEGORIAPROD
  Descripcion    : Proceso para registrar tramite 100225  - Cambio de Uso del Servicio


  Autor          : diana.montes@globalmvm.com
  Fecha          : 30/08/2023

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/09/2023       jose.pineda        OSF-1478: * Se crean parámetros
                                      para ejecutar OAL_CAMBIOCATEGORIAPROD
                                      * Se cambia el manejo de errores
                                      * Se obtiene la causal de la orden
                                      en las excepciones para hacer raise
  07/09/2023       diana.montes       OSF-1478: Creación
  *******************************************************************************************************************/

    nuOrden             NUMBER;
    nuCausal            NUMBER;
    nuPersona           NUMBER;
    dtFechIniEje        DATE;
    dtFechaFinEje       DATE;
    sbDatosAdic         VARCHAR2(2000);
    sbActividades       VARCHAR2(2000);
    sbItemsElementos    VARCHAR2(2000);
    sbLecturaElementos  VARCHAR2(2000);
    sbComentariosOrden  VARCHAR2(2000);      
    
BEGIN
    ut_trace.trace('INICIO CAMBIOCATEGORIAPROD ', 10);

    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuOrden := or_bolegalizeorder.fnuGetCurrentOrder;
    
    if nuOrden is not null then
        nuCausal := to_number(LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('or_order','order_id ','causal_id ',nuOrden));
    else
        pkg_error.setErrorMessage( isbMsgErrr => 'No se encontró identificador de la orden' );
    end if;
    
    ut_trace.trace('nuOrden => ' || nuOrden, 10);

    ut_trace.trace('nuCausal => ' || nuCausal, 10);
    
    OAL_CAMBIOCATEGORIAPROD
    ( 
        nuOrden	            ,
        nuCausal	        ,
        nuPersona	        ,
        dtFechIniEje	    ,
        dtFechaFinEje	    ,
        sbDatosAdic	        ,
        sbActividades	    ,
        sbItemsElementos	,
        sbLecturaElementos	,
        sbComentariosOrden	
    );
    ut_trace.trace('FIN CAMBIOCATEGORIAPROD ', 10);

    EXCEPTION
        when pkg_error.CONTROLLED_ERROR then
            RAISE pkg_error.CONTROLLED_ERROR;
        when OTHERS then
            Pkg_Error.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
END CAMBIOCATEGORIAPROD ;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('CAMBIOCATEGORIAPROD', 'ADM_PERSON');
END;
/
