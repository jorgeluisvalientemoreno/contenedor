CREATE OR REPLACE PACKAGE adm_person.ldc_BOPIConstructora IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : ldc_BOPIConstructora
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    23/07/2024              PAcosta         OSF-2952: Cambio de esquema ADM_PERSON                              
    ****************************************************************/ 
    
    FUNCTION fsbSuscripcion(inuproyecto IN NUMBER) RETURN NUMBER;
    ------------------------------------------------------------------------------------------------
    -- Servicios de busqueda
    ------------------------------------------------------------------------------------------------
    PROCEDURE proServicioBusquedaCliente(isbIdentificacion ge_subscriber.identification%TYPE, -- Identificacion
                                         isbNombre         ge_subscriber.subscriber_name%TYPE, -- Nombre
                                         isbApellido       ge_subscriber.subs_last_name%TYPE, -- Apellido
                                         ocuCursor         OUT CONSTANTS.TYREFCURSOR -- Cursor
                                         );

    PROCEDURE proServicioBusquedaProyecto(inuProyecto  ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                          isbDireccion VARCHAR2, -- Parte de la direccion de un proyecto
                                          isbNombre    VARCHAR2, -- Parte del nombre de un proyecto
                                          inuDepartamento IN ldc_proyecto_constructora.ID_LOCALIDAD%TYPE,--TICKET 200-2213 ELAL-- se filtra por departamento
                                          idtFechaIni  IN ldc_proyecto_constructora.FECHA_CREACION%TYPE, --TICKET 200-2213 ELAL-- se filtra por fehca inicial
                                          idtFechaFin  IN ldc_proyecto_constructora.FECHA_CREACION%TYPE, --TICKET 200-2213 ELAL-- se filtra por fehca final
                                          OCUCURSOR    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                          );

    ------------------------------------------------------------------------------------------------
    -- Servicios de consulta
    ------------------------------------------------------------------------------------------------
    PROCEDURE proServicioConsultaCliente(inuCliente ge_subscriber.subscriber_id%TYPE, -- Identificacion
                                         ocuCursor  OUT CONSTANTS.TYREFCURSOR -- Cursor
                                         );

    PROCEDURE proServicioConsultaProyecto(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                          OCUCURSOR   OUT CONSTANTS.TYREFCURSOR -- Cursor
                                          );

    PROCEDURE proServicioConsultaProyXClie(inuCliente ldc_proyecto_constructora.cliente%TYPE, -- Cliente
                                           OCUCURSOR  OUT CONSTANTS.TYREFCURSOR -- Cursor
                                           );

    PROCEDURE proObtieneClienteXProy(inuProyecto   IN ldc_proyecto_constructora.id_proyecto%TYPE,
                                     onuSubscriber OUT ge_subscriber.subscriber_id%TYPE);

    PROCEDURE proServicioConCotizaDetalladas(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                             ocuDatos    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                             );
    PROCEDURE proServicioCotizaDetallada(inuConsecutivo ldc_cotizacion_construct.id_consecutivo%TYPE, -- Cosecutivo
                                         ocuDatos       OUT CONSTANTS.TYREFCURSOR -- Cursor
                                         );
    PROCEDURE proServicioConSubrogaciones(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                          ocuDatos    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                          );
    PROCEDURE proServicioSubrogacion(inuConsecutivo ldc_equival_unid_pred.consecutivo%TYPE, -- Consecutivo
                                     ocuDatos       OUT CONSTANTS.TYREFCURSOR -- Cursor
                                     );
    PROCEDURE proServicioConCupones(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                    ocuDatos    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                    );
    PROCEDURE proServicioCupon(inuCupon cupon.cuponume%TYPE, -- Numero Cupon
                               ocuDatos OUT CONSTANTS.TYREFCURSOR -- Cursor
                               );
    PROCEDURE proServicioConActas(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                  ocuDatos    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                  );
    PROCEDURE proServicioActa(inuConsecutivo ldc_actas_proyecto.consecutivo%TYPE, -- Consecutivo
                              ocuDatos       OUT CONSTANTS.TYREFCURSOR -- Cursor
                              );
    PROCEDURE proServicioConCheques(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                    ocuDatos    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                    );
    PROCEDURE proServicioCheque(inuConsecutivo ldc_cheques_proyecto.consecutivo%TYPE, -- Consecutivo
                                ocuDatos       OUT CONSTANTS.TYREFCURSOR -- Cursor
                                );
    PROCEDURE proServicioConCuotasDePago(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                         ocuDatos    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                         );
    PROCEDURE proServicioCuotaDePago(sbIdentificador VARCHAR, -- Identificador
                                     ocuDatos        OUT CONSTANTS.TYREFCURSOR -- Cursor
                                     );
    PROCEDURE proServicioConCuotasAdicion(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                          ocuDatos    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                          );
    PROCEDURE proServicioCuotaAdicion(inuConsecutivo ldc_cuotas_adicionales.consecutivo%TYPE, -- Consecutivo
                                      ocuDatos       OUT CONSTANTS.TYREFCURSOR -- Cursor
                                      );
    PROCEDURE proServicioConsultaCuentaXPro(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                            OCUCURSOR   OUT CONSTANTS.TYREFCURSOR -- Informacion de la cuenta de cobro
                                            );

    PROCEDURE proServicioConsultaCuentaCobro(inuCuenta cuencobr.cucocodi%TYPE, -- Cuenta de cobro
                                             OCUCURSOR OUT CONSTANTS.TYREFCURSOR -- Informacion de la cuenta de cobro
                                             );

    PROCEDURE proServicioConsultaCargXCC(inuCuenta cargos.cargcuco%TYPE, -- Cuenta de cobro
                                         OCUCURSOR OUT CONSTANTS.TYREFCURSOR -- Informacion de los cargos
                                         );

    PROCEDURE proServicioConsultaCargos(isbRowid  VARCHAR2, -- Rowid del cargo
                                        OCUCURSOR OUT CONSTANTS.TYREFCURSOR -- Informacion del cargo
                                        );

    PROCEDURE proServicioConsultaDiferido(inuDiferido diferido.difecodi%TYPE, -- Diferido
                                          OCUCURSOR   OUT CONSTANTS.TYREFCURSOR -- Informacion del cargo
                                          );

    PROCEDURE proServicioConsultaDiferXCC(inuCuenta cargos.cargcuco%TYPE, -- Cuenta de cobro
                                          OCUCURSOR OUT CONSTANTS.TYREFCURSOR -- Informacion de los cargos
                                          );

    PROCEDURE proServicioConsultaPagosXCC(inuCuenta cargos.cargcuco%TYPE, -- Cuenta de cobro
                                          OCUCURSOR OUT CONSTANTS.TYREFCURSOR -- Informacion de los cargos
                                          );

    PROCEDURE proServicioConsultaPago(isbCuponSuscriptor VARCHAR2, -- Cupon y suscriptor
                                      OCUCURSOR          OUT CONSTANTS.TYREFCURSOR -- Informacion del cargo
                                      );

    PROCEDURE proServicioConsultaSolic(inuSolicitud IN mo_packages.package_id%TYPE,
                                       ocuCursor    OUT CONSTANTS.TYREFCURSOR);

    PROCEDURE proServicioConsultaSolicXProy(inuProyecto IN ldc_proyecto_constructora.id_proyecto%TYPE,
                                            ocuCursor   OUT CONSTANTS.TYREFCURSOR);

    PROCEDURE proPYG(inuProyecto NUMBER, -- Proyecto
                     OCUCURSOR   OUT CONSTANTS.TYREFCURSOR -- Informacion del cargo
                     );

    PROCEDURE proInfoCartera(inuProyecto NUMBER, -- Proyecto
                             ocucursor   OUT CONSTANTS.TYREFCURSOR -- Informacion de cartera
                             );

    PROCEDURE PROOBTSOLIPORPROYE(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                    ocuDatos    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                    );

    PROCEDURE proCargaInfoProyecto(inuProyecto IN ldc_proyecto_constructora.id_proyecto%TYPE);

    PROCEDURE proCargaInfoCupon(inuCupon IN cupon.cuponume%TYPE);

    PROCEDURE proCargaInfoActa(inuConsecutivo IN ldc_actas_proyecto.consecutivo%TYPE);

    PROCEDURE proCargaInfoCotiz(inuConsecutivo IN ldc_cotizacion_construct.id_consecutivo%TYPE);

    -----------------------------------------------------------------------------------------------
    -- Funciones
    -----------------------------------------------------------------------------------------------
   FUNCTION fnuValorAdicional(inuProyecto     IN             ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                              isbOpcion       IN             VARCHAR2
                               ) RETURN NUMBER;


    FUNCTION fnuValor(inuProyecto                    ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                      inuUnidadPredial               ldc_unidad_predial.id_unidad_predial%TYPE, -- Identificador vivienda
                      inuTorre                       ldc_unidad_predial.id_torre%TYPE, -- Torre
                      inuPiso                        ldc_unidad_predial.id_piso%TYPE, -- Piso
                      inuTipoTrabajo                 ldc_tipos_trabajo_cot.id_tipo_trabajo%TYPE, -- Tipo de trabajo
                      inuCotizacionDetalladaAprobada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                      isbCostoOCotizado              VARCHAR2 -- Retorna el costo o el valor cotizado
                      ) RETURN NUMBER;

    FUNCTION fnuValorLegalizado(inuProyecto                    ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                inuCotizacionDetalladaAprobada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion detallada aprobada
                                inuTipoTrabajo                 ldc_tipos_trabajo_cot.id_tipo_trabajo%TYPE, -- Tipo de trabajo
                                inuProducto                    pr_product.product_id%TYPE -- Producto
                                ) RETURN NUMBER;

   FUNCTION LDC_FNUCOSTOTALEGA (inuProyecto                    ldc_proyecto_constructora.id_proyecto%TYPE -- Proyecto
                                 ) RETURN NUMBER ;
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: LDC_FNUCOSTOTALEGA
        Descripcion:        Valor legalizado para las  unidad predial

        Autor    : Elkin alvarez
        Fecha    : 26-11-2018

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        ******************************************************************/
    FUNCTION LDC_FNUCALMARGPROY (inuProyecto                    ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                 inuValorAprobado IN NUMBER) RETURN NUMBER ;
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: LDC_FNUCALMARGPROY
        Descripcion:        Calcula valor del margen

        Autor    : Elkin alvarez
        Fecha    : 26-11-2018

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        ******************************************************************/
     FUNCTION LDC_FNUCALUTILPROY (inuProyecto                    ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                  inuValorAprobado  IN NUMBER
                                 ) RETURN NUMBER ;
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: LDC_FNUCALUTILPROY
        Descripcion:        Calcula valor de la utilidad

        Autor    : Elkin alvarez
        Fecha    : 26-11-2018

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        ******************************************************************/

          FUNCTION LDC_FNUGETVALORAPROBADO ( inuProyecto   ldc_proyecto_constructora.id_proyecto%TYPE -- Proyecto
                                       ) RETURN NUMBER ;
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: LDC_FNUGETVALORAPROBADO
        Descripcion:        Calcula valor aprobado del proyecto

        Autor    : Elkin alvarez
        Fecha    : 26-11-2018

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        ******************************************************************/
END ldc_BOPIConstructora;
/
CREATE OR REPLACE PACKAGE BODY adm_person.ldc_BOPIConstructora IS

    ------------------------------------------------------------------------------------------------
    -- Datos de paquete
    ------------------------------------------------------------------------------------------------
    gsbPaquete          VARCHAR2(30) := 'ldc_BOPIConstructora';
    gnuTipoConstructora ge_subscriber.subscriber_type_id%TYPE := 1106; -- Clientes tipo constructora
  SBPACKAGEATTRIBUTES     VARCHAR2(4000);
  sbWhereSolici          VARCHAR2(4000);
  sbFromSolici           VARCHAR2(4000);
    ------------------------------------------------------------------------------------------------
    -- Errores
    ------------------------------------------------------------------------------------------------
    gnuDescripcionError NUMBER := 2741; -- Descripcion del error

    ------------------------------------------------------------------------------------------------
    -- Otros Datos
    ------------------------------------------------------------------------------------------------

    gnuSoliSubrogacion NUMBER := 100221;
    gnuEstadoSolicitud NUMBER := 14;

    FUNCTION fsbSuscripcion(inuproyecto IN NUMBER) RETURN NUMBER IS
        nuSuscripcion NUMBER(8);
        sbProceso     VARCHAR2(4000) := 'fsbSuscripcion';
        nuPaso        NUMBER;
        sbError       VARCHAR2(4000);
    BEGIN
        SELECT a.suscripcion
        INTO   nuSuscripcion
        FROM   LDC_PROYECTO_CONSTRUCTORA a
        WHERE  a.id_proyecto = inuproyecto;

        RETURN(nuSuscripcion);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proInfoCliente(isbServicio       VARCHAR2, -- C-onsulta o B-Busqueda
                             isbIdentificacion ge_subscriber.identification%TYPE, -- Identificacion
                             isbNombre         ge_subscriber.subscriber_name%TYPE, -- Nombre
                             isbApellido       ge_subscriber.subs_last_name%TYPE, -- Apellido
                             inuCliente        ge_subscriber.subscriber_id%TYPE, -- Codigo del cliente
                             ocrInformacion    OUT CONSTANTS.TYREFCURSOR -- Informacion
                             ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proInfoProyecto
        Descripcion:        Obtiene del cliente

        Autor    : Sandra Mu?oz
        Fecha    : 16-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        16-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proInfoCliente';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000); -- Error

        sbCampos    VARCHAR2(4000); -- Campos del select
        sbFrom      VARCHAR2(4000); -- Tablas a consultar
        sbWhere     VARCHAR2(4000); -- Union de tablas a consultar
        sbCondicion VARCHAR2(4000); -- Filtro a aplicar
        sbSql       VARCHAR2(4000); -- Consulta a aplicar
        sbOrden     VARCHAR2(4000); -- Orden

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 1);

        -- Listado de campos
        nuPaso   := 80;
        sbCampos := '
                     subscriber_id ,
                     (select git.ident_type_id ' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                    ' description
                      from   ge_identifica_type git
                      where  git.ident_type_id = gs.ident_type_id)  desc_identification,
                     Identification,
                     subscriber_name,
                     subs_last_name,
                     address,
                     phone,
                     vinculate_date,
                     is_corporative,
                     :parent_id parent_id';

        -- Tablas a consultar
        nuPaso := 90;
        sbFrom := ' ge_subscriber gs';

        -- Inicializa la consulta
        sbWhere := '1 = 1';

        -- Filtro
        IF isbServicio = 'C' THEN
            nuPaso := 130;

            sbCondicion := ' gs.subscriber_id = nvl(:inuCliente, -1)';

        ELSIF isbServicio = 'B' THEN

            sbCondicion := sbCondicion ||
                           ' (UPPER(gs.identification) LIKE UPPER(''%''||:isbIdentificacion||''%'') OR :isbIdentificacion IS NULL )';

            sbCondicion := sbCondicion ||
                           ' AND (gs.subscriber_name LIKE UPPER(''%''||:isbNombre||''%'') OR :isbNombre IS NULL)';

            sbCondicion := sbCondicion ||
                           ' AND (gs.subs_last_name LIKE UPPER(''%''||:isbApellido||''%'')  OR :isbApellido is NULL)';

        END IF;

        -- Solo mostrar clientes tipo constructora
        sbCondicion := sbCondicion || '
                 AND gs.subscriber_type_id = ' || gnuTipoConstructora;

        -- Ordenamiento
        nuPaso  := 150;
        sbOrden := ' subscriber_id ';

        -- Construccion de la consulta
        sbSql := '
              SELECT   ' || sbCampos || '
              FROM     ' || sbFrom || '
              WHERE    ' || sbWhere || '
              AND      ' || sbCondicion || '
              ORDER BY ' || sbOrden;

        -- REtornar el cursor referenciado
        nuPaso := 160;

        dbms_output.put_line(sbSql);
        ut_trace.trace(sbSql, 1);

        nuPaso := 130;

        IF isbServicio = 'C' THEN
            OPEN ocrInformacion FOR sbSql
                USING cc_bobossutil.cnunull, inuCliente;

        ELSIF isbServicio = 'B' THEN

            OPEN ocrInformacion FOR sbSql
                USING cc_bobossutil.cnunull, isbIdentificacion, isbIdentificacion, isbNombre, isbNombre, isbApellido, isbApellido;

        END IF;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioBusquedaCliente(isbIdentificacion ge_subscriber.identification%TYPE, -- Identificacion
                                         isbNombre         ge_subscriber.subscriber_name%TYPE, -- Nombre
                                         isbApellido       ge_subscriber.subs_last_name%TYPE, -- Apellido
                                         ocuCursor         OUT CONSTANTS.TYREFCURSOR -- Cursor
                                         ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioBusquedaCliente
        Descripcion:        Ejecuta la consulta del cliente desde el PI

        Autor    : Sandra Mu?oz
        Fecha    : 31-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proServicioBusquedaCliente';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        proInfoCliente(isbServicio       => 'B',
                       isbIdentificacion => isbIdentificacion,
                       isbNombre         => isbNombre,
                       isbApellido       => isbApellido,
                       inucliente        => NULL,
                       ocrInformacion    => ocuCursor);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    /* PROCEDURE proServicioBusquedaProyecto(inuProyecto  ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                          isbNombre    ldc_proyecto_constructora.nombre%TYPE, -- Nombre proyecto
                                          isbDireccion ab_address.address_parsed%TYPE, -- Direccion proyecto
                                          ocuDatos     OUT CONSTANTS.TYREFCURSOR -- Cursor
                                          ) IS
        \*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioBusquedaProyecto
        Descripcion:        Obtiene los proyecto que cumplan con los criterios ingresados

        Autor    : Sandra Mu?oz
        Fecha    : 31-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************\

        sbProceso   VARCHAR2(4000) := 'proServicioBusquedaProyecto';
        nuPaso      NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError     VARCHAR2(4000);
        sbCampos    VARCHAR2(4000);
        sbCondicion VARCHAR2(4000);
        sbSentencia VARCHAR2(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Obtener las columnas a mostrar
        sbCampos := 'id_proyecto,
                    nombre  ,
                    descripcion ,
                    cliente,
                    (select gs.subscriber_name ||'' '' || gs.subs_last_name
                     from ge_subscriber gs
                     where gs.subscriber_id = cliente) nombre_cliente,
                    tipo_construccion,
                    (select tc.desc_tipo_construcion
                     from ldc_tipo_construccion tc
                     where tc.id_tipo_construccion = tipo_construccion ) descripcion_tipo_construccion';

        -- Aplicar los filtros
        sbCondicion := '1 = 1';

        IF inuProyecto IS NOT NULL THEN
            sbCondicion := sbCondicion || ' AND lpc.id_proyecto = ' || inuProyecto;
        END IF;

        IF isbDireccion IS NOT NULL THEN
            sbCondicion := sbCondicion ||
                           ' AND lpc.id_direccion IN ( SELECT address_id aa
                                                                      FROM   aa.address_parsed LIKE UPPER(''%' ||
                           isbDireccion || '%'')';
        END IF;

        IF isbNombre IS NOT NULL THEN
            sbCondicion := sbCondicion || ' AND upper(lpc.nombre) LIKE UPPER(''%' || isbNombre ||
                           '%'')';
        END IF;

        -- Construir la sentencia
        sbSentencia := 'SELECT ' || sbCampos || '
                        FROM   ldc_proyecto_constructora lpc
                        WHERE  ' || sbCondicion || '
                        ORDER BY 1';

        ut_trace.trace(sbSentencia);
        dbms_output.put_line(sbSentencia);

        OPEN ocuDatos FOR sbSentencia;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
    END;*/

    PROCEDURE proServicioConsultaCliente(inuCliente ge_subscriber.subscriber_id%TYPE, -- Identificacion
                                         ocuCursor  OUT CONSTANTS.TYREFCURSOR -- Cursor
                                         ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConsultaCliente
        Descripcion:

        Autor    : Sandra Mu?oz
        Fecha    : 31-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso   VARCHAR2(4000) := 'proServicioConsultaCliente';
        nuPaso      NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError     VARCHAR2(4000);
        sbCampos    VARCHAR2(4000); -- Campos del select
        sbCondicion VARCHAR2(4000); -- Condiciones del where
        sbSentencia VARCHAR2(4000); -- Consulta a ejecutar

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        proInfoCliente(isbServicio       => 'C',
                       isbIdentificacion => NULL,
                       isbNombre         => NULL,
                       isbApellido       => NULL,
                       inucliente        => inuCliente,
                       ocrInformacion    => ocuCursor);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proInfoProyecto(inuDato             NUMBER, -- Cliente o proyecto
                              isbClienteOProyecto VARCHAR2, -- C-liente o P-Proyecto,
                              isbServicio         VARCHAR2, -- C-onsulta o B-Busqueda
                              isbDireccion        VARCHAR2, -- Direccion
                              isbNombre           VARCHAR2, -- Direccion
                              inuDepartamento IN ldc_proyecto_constructora.ID_LOCALIDAD%TYPE DEFAULT NULL,--TICKET 200-2213 ELAL-- se filtra por departamento
                              idtFechaIni  IN ldc_proyecto_constructora.FECHA_CREACION%TYPE DEFAULT NULL, --TICKET 200-2213 ELAL-- se filtra por fehca inicial
                              idtFechaFin  IN ldc_proyecto_constructora.FECHA_CREACION%TYPE DEFAULT NULL, --TICKET 200-2213 ELAL-- se filtra por fehca final
                              ocrInformacion      OUT CONSTANTS.TYREFCURSOR -- Informacion
                              ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proInfoProyecto
        Descripcion:        Obtiene la informacion de los proyectos

        Autor    : Sandra Mu?oz
        Fecha    : 16-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        16-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proInfoProyecto';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000); -- Error

        sbCampos    VARCHAR2(4000); -- Campos del select
        sbFrom      VARCHAR2(4000); -- Tablas a consultar
        sbWhere     VARCHAR2(4000); -- Union de tablas a consultar
        sbCondicion VARCHAR2(4000); -- Filtro a aplicar
        sbSql       VARCHAR2(4000); -- Consulta a aplicar
        sbOrden     VARCHAR2(4000); -- Orden


		sbConsuCosto VARCHAR2(2) :='S';

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 1);
       IF isbClienteOProyecto = 'P' AND isbServicio = 'B' THEN
	          sbCampos := '
                    id_proyecto,
                    nombre  ,
                    descripcion ,
                    (select gs.subscriber_name ||'' ''|| ' ||
                    ' gs.subs_last_name
                     from ge_subscriber gs
                     where gs.subscriber_id = cliente) nombre_cliente,
                    (select tc.id_tipo_construccion' ||
                    CC_BOBOSSUTIL.CSBSEPARATOR ||
                    ' tc.desc_tipo_construcion
                     from ldc_tipo_construccion tc
                     where tc.id_tipo_construccion = tipo_construccion ) tipo_construccion,
                    (Select aa.address_parsed from ab_address aa where aa.address_id = id_direccion) direccion,
                     suscripcion,
                     id_solicitud,
                     decode(forma_pago, ''CH'', ''Cheque'',''CU'',''Cuota'',''AV'',''Avance de Obra'','''') forma_pago,
                     pagare,
                     contrato,
                     fecha_creacion,
                     usu_creacion,
                     fech_ult_modif,
                     cantidad_pisos,
                     cantidad_torres,
                     cant_unid_predial,
                     cant_tip_unid_pred,
                     (valor_final_aprob+ ldc_BOPIConstructora.LDC_FNUGETVALORAPROBADO(id_proyecto)) valor_final_aprob,
                     decode(id_localidad,null,'''',id_localidad' ||
                    CC_BOBOSSUTIL.CSBSEPARATOR || 'dage_geogra_location.fsbgetdescription(id_localidad)) localidad,
                     decode(id_localidad,null,'''',DAGE_GEOGRA_LOCATION.FNUGETGEO_LOCA_FATHER_ID(id_localidad,null)' ||
                    CC_BOBOSSUTIL.CSBSEPARATOR || 'dage_geogra_location.fsbgetdescription( DAGE_GEOGRA_LOCATION.FNUGETGEO_LOCA_FATHER_ID(id_localidad,null) )) Departamento,


                     usuario_ult_modif,
                     ';


		ELSE


		   sbCampos := '
                    id_proyecto,
                    nombre  ,
                    descripcion ,
                    (select gs.subscriber_name ||'' ''|| ' ||
                    ' gs.subs_last_name
                     from ge_subscriber gs
                     where gs.subscriber_id = cliente) nombre_cliente,
                    (select tc.id_tipo_construccion' ||
                    CC_BOBOSSUTIL.CSBSEPARATOR ||
                    ' tc.desc_tipo_construcion
                     from ldc_tipo_construccion tc
                     where tc.id_tipo_construccion = tipo_construccion ) tipo_construccion,
                    (Select aa.address_parsed from ab_address aa where aa.address_id = id_direccion) direccion,
                     suscripcion,
                     id_solicitud,
                     decode(forma_pago, ''CH'', ''Cheque'',''CU'',''Cuota'',''AV'',''Avance de Obra'','''') forma_pago,
                     pagare,
                     contrato,
                     fecha_creacion,
                     usu_creacion,
                     fech_ult_modif,
                     cantidad_pisos,
                     cantidad_torres,
                     cant_unid_predial,
                     cant_tip_unid_pred,
                     (valor_final_aprob+ ldc_BOPIConstructora.LDC_FNUGETVALORAPROBADO(id_proyecto)) valor_final_aprob,
                     decode(id_localidad,null,'''',id_localidad' ||
                    CC_BOBOSSUTIL.CSBSEPARATOR || 'dage_geogra_location.fsbgetdescription(id_localidad)) localidad,
                     decode(id_localidad,null,'''',DAGE_GEOGRA_LOCATION.FNUGETGEO_LOCA_FATHER_ID(id_localidad,null)' ||
                    CC_BOBOSSUTIL.CSBSEPARATOR || 'dage_geogra_location.fsbgetdescription( DAGE_GEOGRA_LOCATION.FNUGETGEO_LOCA_FATHER_ID(id_localidad,null) )) Departamento,
                     ''$''||to_char(ldc_BOPIConstructora.LDC_FNUCOSTOTALEGA(id_proyecto),''FM999,999,999,990.00'') Costo_Total,
                     ''$''||to_char(ldc_BOPIConstructora.LDC_FNUCALUTILPROY(id_proyecto, valor_final_aprob ),''FM999,999,999,990.00'')  Utilidad,
                     ldc_BOPIConstructora.LDC_FNUCALMARGPROY(id_proyecto, valor_final_aprob) Margen,
                     usuario_ult_modif,
                     ';





	   END IF;


          -- Listado de campos
        nuPaso   := 80;







        IF isbServicio = 'B' THEN
            sbCampos := sbCampos || 'cliente';
        ELSIF isbServicio = 'C' THEN
            sbCampos := sbCampos || 'cliente parent_id';
        END IF;

        -- Tablas a consultar
        nuPaso := 90;
        sbFrom := 'ldc_proyecto_constructora lpc';

        -- Inicializa las condicione
        sbWhere := '1 = 1';

        -- Filtro
        IF isbServicio = 'C' THEN
            nuPaso := 130;

            IF isbClienteOProyecto = 'C' THEN

                sbCondicion := '
                     lpc.cliente = nvl(:inuDato, -1)';

            ELSIF isbClienteOProyecto = 'P' THEN

                sbCondicion := ' lpc.id_proyecto = nvl(:inuDato, -1)';

            END IF;
        ELSIF isbServicio = 'B' THEN

            sbCondicion := ' (lpc.id_proyecto = :inuDato OR :inuDato IS NULL)';
            sbCondicion := sbCondicion ||
                           ' AND ((lpc.id_direccion IN ( SELECT address_id aa
                                                         FROM   ab_address aa
                                                         WHERE  aa.address_parsed LIKE UPPER(''%''||:isbDireccion||''%'')))
                                                         OR     :isbDireccion IS NULL
                                                         )';
            sbCondicion := sbCondicion ||
                           ' AND (upper(lpc.nombre) LIKE UPPER(''%''||:isbNombre||''%'') OR :isbNombre IS NULL)';
            --se valida que la fecha no este vacia
            IF idtFechaIni IS NOT NULL THEN
               sbCondicion := sbCondicion || ' AND lpc.FECHA_CREACION between to_date('''||to_char(idtFechaIni,'dd/mm/yyyy')||' 00:00:00'',''dd/mm/yyyy hh24:mi:ss'') and to_date('''||to_char(idtFechaFin,'dd/mm/yyyy')||' 23:59:59'',''dd/mm/yyyy hh24:mi:ss'')';
            END IF;
            --Se valida que el deparatmento no este vacio
            IF inuDepartamento IS NOT NULL THEN
                 sbCondicion := sbCondicion || ' AND decode(lpc.id_localidad,null,NULL,DAGE_GEOGRA_LOCATION.FNUGETGEO_LOCA_FATHER_ID(lpc.id_localidad,null)) = '||inuDepartamento;
            END IF;
        END IF;

        -- Ordenamiento
        nuPaso  := 150;
        sbOrden := ' id_proyecto ';

        -- Construccion de la consulta
        sbSql := '
              SELECT   ' || sbCampos || '
              FROM     ' || sbFrom || '
              WHERE    ' || sbWhere || '
              AND      ' || sbCondicion || '
              ORDER BY ' || sbOrden;

        -- REtornar el cursor referenciado
        nuPaso := 160;

        dbms_output.put_line(sbSql);
        ut_trace.trace(sbSql, 1);

        nuPaso := 130;

        IF isbClienteOProyecto = 'C' THEN
            OPEN ocrInformacion FOR sbSql
                USING inuDato;
        ELSIF isbClienteOProyecto = 'P' THEN
            IF isbServicio = 'B' THEN
                OPEN ocrInformacion FOR sbSql
                    USING inuDato, inuDato, isbDireccion, isbDireccion, isbNombre, isbNombre;
            ELSE
                OPEN ocrInformacion FOR sbSql
                    USING inuDato;
            END IF;
        END IF;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            sbError := 'TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM;
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
           -- ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConsultaProyecto(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                          OCUCURSOR   OUT CONSTANTS.TYREFCURSOR -- Cursor
                                          ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConsultaProyecto
        Descripcion:        Obtiene los proyecto que cumplan con los criterios ingresados

        Autor    : Sandra Mu?oz
        Fecha    : 03-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        03-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso   VARCHAR2(4000) := 'proServicioConsultaProyecto';
        nuPaso      NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError     VARCHAR2(4000);
        sbCondicion VARCHAR2(4000);
        sbSentencia VARCHAR2(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        ldc_boVentaConstructora.proMarcaCuotaPagada(inuProyecto);

        proInfoProyecto(inuDato             => inuProyecto,
                        isbClienteOProyecto => 'P', -- Proyecto
                        isbServicio         => 'C', -- Consulta
                        isbDireccion        => NULL,
                        isbNombre           => NULL,
                        ocrInformacion      => OCUCURSOR);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConsultaProyXClie(inuCliente ldc_proyecto_constructora.cliente%TYPE, -- Cliente
                                           OCUCURSOR  OUT CONSTANTS.TYREFCURSOR -- Cursor
                                           ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConsultaProyXClie
        Descripcion:        Obtiene los proyectos de un cliente

        Autor    : Sandra Mu?oz
        Fecha    : 03-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        03-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso   VARCHAR2(4000) := 'proServicioConsultaProyXClie';
        nuPaso      NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError     VARCHAR2(4000);
        sbCondicion VARCHAR2(4000);
        sbSentencia VARCHAR2(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        proInfoProyecto(inuDato             => inuCliente,
                        isbClienteOProyecto => 'C', -- Proyecto
                        isbServicio         => 'C', -- Consulta
                        isbDireccion        => NULL,
                        isbNombre           => NULL,
                        ocrInformacion      => OCUCURSOR);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proObtieneClienteXProy(inuProyecto   IN ldc_proyecto_constructora.id_proyecto%TYPE,
                                     onuSubscriber OUT ge_subscriber.subscriber_id%TYPE) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proObtieneClienteXProy
        Descripcion:        Obtiene el cliente del proyecto.

        Autor    : KCienfuegos
        Fecha    : 23-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        23-06-2016   KCienfuegos           Creacion
        ******************************************************************/
        sbProceso VARCHAR2(4000) := 'proObtieneClienteXProy';
        nuPaso    NUMBER;
        sbError   VARCHAR2(4000);
    BEGIN
        IF inuProyecto IS NULL THEN
            onuSubscriber := NULL;
            RETURN;
        END IF;

        daldc_proyecto_constructora.AccKey(inuProyecto);
        onuSubscriber := daldc_proyecto_constructora.fnuGetCLIENTE(inuID_PROYECTO => inuProyecto);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            onuSubscriber := NULL;
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioBusquedaProyecto(inuProyecto  ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                          isbDireccion VARCHAR2, -- Parte de la direccion de un proyecto
                                          isbNombre    VARCHAR2, -- Parte del nombre de un proyecto
                                          inuDepartamento IN ldc_proyecto_constructora.ID_LOCALIDAD%TYPE,--TICKET 200-2213 ELAL-- se filtra por departamento
                                          idtFechaIni  IN ldc_proyecto_constructora.FECHA_CREACION%TYPE, --TICKET 200-2213 ELAL-- se filtra por fehca inicial
                                          idtFechaFin  IN ldc_proyecto_constructora.FECHA_CREACION%TYPE, --TICKET 200-2213 ELAL-- se filtra por fehca final
                                          OCUCURSOR    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                          ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioBusquedaProyecto
        Descripcion:        Obtiene los proyectos que cumplen con ciertos criterios

        Autor    : Sandra Mu?oz
        Fecha    : 03-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        03-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso   VARCHAR2(4000) := 'proServicioBusquedaProyecto';
        nuPaso      NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError     VARCHAR2(4000);
        sbCondicion VARCHAR2(4000);
        sbSentencia VARCHAR2(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);
        --se validan fechas
        IF idtFechaIni IS NULL AND idtFechaFin IS NOT NULL THEN
            eRRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => 'La Fecha Inicial no puede estar Vacia');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

         IF idtFechaIni IS NOT NULL AND idtFechaFin IS NULL THEN
            eRRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => 'La Fecha Final no puede estar Vacia');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        proInfoProyecto(inuDato             => inuProyecto,
                        isbClienteOProyecto => 'P', -- Proyecto
                        isbServicio         => 'B', -- Busqueda
                        isbDireccion        => isbDireccion,
                        isbNombre           => isbNombre,
                        inuDepartamento     => inuDepartamento,
                        idtFechaIni         => idtFechaIni,
                        idtFechaFin         => idtFechaFin,
                        ocrInformacion      => OCUCURSOR);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.gETERROR(gnuDescripcionError,sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConCotizaDetalladas(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                             ocuDatos    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                             ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConCotizaDetalladas
        Descripcion:        Obtiene las cotizaciones detalladas por proyecto

        Autor    : Caren Berdejo
        Fecha    : 15-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-06-2016   Caren Berdejo          Creacion
        ******************************************************************/

        sbProceso            VARCHAR2(4000) := 'proServicioConCotizaDetalladas';
        nuPaso               NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError              VARCHAR2(4000);
        sbCondicion          VARCHAR2(4000);
        sbSentencia          VARCHAR2(4000);
        sbCamposConstDetalle VARCHAR(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        sbCamposConstDetalle := 'a.id_cotizacion_detallada id_cotizacion_detallada, a.id_proyecto parent_id,
                             a.id_proyecto || '' - '' || initcap(b.nombre) as proyecto,
                             decode(a.estado,''R'',''Registrada'',''P'',''Pre-Aprobada'',''A'',''Aprobada'',''N'',''Anulada'') as estado,
                             a.observacion as obser,
                             a.lista_costo || '' - '' || initcap(c.description) as lista_de_costo,
                             a.id_cotizacion_osf as id_cotizacion_osf,
                             a.valor_cotizado as valor,
                             a.fecha_vigencia as fecha_vigencia,
                             a.fecha_aprobacion as fecha_aprobacion,
                             a.fecha_creacion as fecha_creacion,
                             a.usua_creacion as usuario_creacion,
                             a.fecha_ult_modif as fecha_modifica,
                             a.usua_ult_modif as usuario_modifica,
                             a.id_consecutivo as consecutivo,
                             a.plan_comercial_espcl as plan_comercial_especial';

        -- Aplicar los filtros
        sbCondicion := 'a.id_proyecto = b.id_proyecto
                           and a.lista_costo = c.list_unitary_cost_id
                           and a.id_proyecto = ' || 'nvl(:inuProyecto,-1)';

        -- Construir la sentencia
        sbSentencia := 'SELECT ' || sbCamposConstDetalle || '
                        FROM   LDC_COTIZACION_CONSTRUCT a,
                               LDC_PROYECTO_CONSTRUCTORA b,
                               GE_LIST_UNITARY_COST c
                        WHERE  ' || sbCondicion || '
                        ORDER BY 1';

        ut_trace.trace(sbSentencia);
        dbms_output.put_line(sbSentencia);

        OPEN ocuDatos FOR sbSentencia
            USING inuProyecto;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioCotizaDetallada(inuConsecutivo ldc_cotizacion_construct.id_consecutivo%TYPE, -- Cosecutivo
                                         ocuDatos       OUT CONSTANTS.TYREFCURSOR -- Cursor
                                         ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioCotizaDetallada
        Descripcion:        Obtiene la informacion de una cotizacion detallada

        Autor    : Caren Berdejo
        Fecha    : 16-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        16-06-2016   Caren Berdejo          Creacion
        19-07-2018   Sebastian Tapias       Se agregan datos adicionales.
        ******************************************************************/

        sbProceso            VARCHAR2(4000) := 'proServicioCotizaDetallada';
        nuPaso               NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError              VARCHAR2(4000);
        sbCondicion          VARCHAR2(4000);
        sbSentencia          VARCHAR2(4000);
        sbCamposConstDetalle VARCHAR(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);
        --REQ.2001640: Se agrega unidad operativa
        sbCamposConstDetalle := 'a.id_cotizacion_detallada id_cotizacion_detallada,
                                 a.id_proyecto parent_id,
                                 a.id_proyecto || '' - '' || initcap(b.nombre) as proyecto,
                                 decode(a.estado,''R'',''Registrada'',''P'',''Pre-Aprobada'',''A'',''Aprobada'',''N'',''No Aprobada'') as estado,
                                 a.observacion as obser,
                                 a.lista_costo || '' - '' || initcap(c.description) as lista_de_costo,
                                 a.id_cotizacion_osf as id_cotizacion_osf,
                                 a.valor_cotizado as valor,
                                 a.fecha_vigencia as fecha_vigencia,
                                 a.fecha_aprobacion as fecha_aprobacion,
                                 a.fecha_creacion as fecha_creacion,
                                 a.usua_creacion as usuario_creacion,
                                 a.fecha_ult_modif as fecha_modifica,
                                 a.usua_ult_modif as usuario_modifica,
                                 a.id_consecutivo as consecutivo,
                                 TO_CHAR((SELECT o.operating_unit_id || '' - '' || o.name FROM or_operating_unit o WHERE o.operating_unit_id = ca.unidad_operativa)) unidad_operativa,
                                 a.plan_comercial_espcl as plan_comercial_especial,
                                 a.UND_INSTALADORA_ID as unidad_instaladora,
                                 a.UND_CERTIFICADORA_ID as unidad_certificadora';

        --REQ.2001640: Se agrega filtro con la tabla de datos adicionales LDC_COTICONSTRUCTORA_ADIC
        -- Aplicar los filtros
        sbCondicion := 'a.id_proyecto = b.id_proyecto
                           and a.id_cotizacion_detallada = ca.id_cotizacion
                           and a.id_proyecto = ca.id_proyecto
                           and a.lista_costo = c.list_unitary_cost_id
                           and a.id_consecutivo = ' ||
                       'nvl(:inuConsecutivo,-1)';
        --REQ.2001640: Se agrega FROM de la tabla de datos adicionales LDC_COTICONSTRUCTORA_ADIC
        -- Construir la sentencia
        sbSentencia := 'SELECT ' || sbCamposConstDetalle || '
                        FROM   LDC_COTIZACION_CONSTRUCT a, LDC_COTICONSTRUCTORA_ADIC ca,
                               LDC_PROYECTO_CONSTRUCTORA b,
                               GE_LIST_UNITARY_COST c
                        WHERE  ' || sbCondicion || '
                        ORDER BY 1';

        ut_trace.trace(sbSentencia);
        dbms_output.put_line(sbSentencia);

        OPEN ocuDatos FOR sbSentencia
            USING inuConsecutivo;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConSubrogaciones(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                          ocuDatos    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                          ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConSubrogaciones
        Descripcion:        Obtiene las cotizacione detalladas que cumplan con los criterios ingresados

        Autor    : Caren Berdejo
        Fecha    : 17-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        17-06-2016   Caren Berdejo          Creacion
        ******************************************************************/

        sbProceso            VARCHAR2(4000) := 'proServicioConSubrogaciones';
        nuPaso               NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError              VARCHAR2(4000);
        sbCondicion          VARCHAR2(4000);
        sbSentencia          VARCHAR2(4000);
        sbCamposConstDetalle VARCHAR(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        sbCamposConstDetalle := 'distinct a.consecutivo AS consecutivo,
                                 a.id_direccion AS id_direccion,
                                 a.id_direccion || '' - '' || c.address AS direccion,
                                 decode(a.subrog_aprob, ''N'', ''No'', ''S'', ''Si'') AS subrog_aprob,
                                 a.fecha_aprob AS fecha_aprob,
                                 a.id_proyecto AS parent_id,
                                 a.id_proyecto || '' - '' || initcap(b.nombre) AS proyecto,
                                 (SELECT MIN(t.package_id)
                                  FROM mo_motive t, mo_packages p
                                  WHERE t.subscription_id = d.susccodi
                                       AND t.package_id = p.package_id
                                       AND p.package_type_id = :gnuSoliSubrogacion
                                       AND p.motive_status_id = :gnuEstadoSolicitud) sol_subrogacion';

        -- Aplicar los filtros
        sbCondicion := 'a.id_proyecto = b.id_proyecto
                        AND a.id_direccion = c.address_id
                        AND a.id_direccion = d.susciddi(+)
                        AND a.activa = ''S''
                        AND a.id_proyecto = ' || 'nvl(:inuProyecto,-1)';

        -- Construir la sentencia
        sbSentencia := 'SELECT ' || sbCamposConstDetalle || '
                        FROM   LDC_EQUIVAL_UNID_PRED     a,
                        LDC_PROYECTO_CONSTRUCTORA b,
                        AB_ADDRESS                c,
                        SUSCRIPC                  d
                        WHERE  ' || sbCondicion || '
                        ORDER BY 1';

        ut_trace.trace(sbSentencia);
        dbms_output.put_line(sbSentencia);

        OPEN ocuDatos FOR sbSentencia
            USING gnuSoliSubrogacion, gnuEstadoSolicitud, inuProyecto;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioSubrogacion(inuConsecutivo ldc_equival_unid_pred.consecutivo%TYPE, -- Consecutivo
                                     ocuDatos       OUT CONSTANTS.TYREFCURSOR -- Cursor
                                     ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioSubrogacion
        Descripcion:        Obtiene las cotizacione detalladas que cumplan con los criterios ingresados

        Autor    : Caren Berdejo
        Fecha    : 17-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        17-06-2016   Caren Berdejo          Creacion
        ******************************************************************/

        sbProceso            VARCHAR2(4000) := 'proServicioSubrogacion';
        nuPaso               NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError              VARCHAR2(4000);
        sbCondicion          VARCHAR2(4000);
        sbSentencia          VARCHAR2(4000);
        sbCamposConstDetalle VARCHAR(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        sbCamposConstDetalle := 'a.consecutivo AS consecutivo,
                                 a.id_direccion AS id_direccion,
                                 a.id_direccion || '' - '' || c.address AS direccion,
                                 decode(a.subrog_aprob, ''N'', ''No'', ''S'', ''Si'') AS subrog_aprob,
                                 a.fecha_aprob AS fecha_aprob,
                                 a.id_proyecto AS parent_id,
                                 a.id_proyecto || '' - '' || initcap(b.nombre) AS proyecto,
                                 (SELECT MIN(t.package_id)
                                  FROM mo_motive t, mo_packages p
                                  WHERE t.subscription_id = d.susccodi
                                       AND t.package_id = p.package_id
                                       AND p.package_type_id = :gnuSoliSubrogacion
                                       AND p.motive_status_id = :gnuEstadoSolicitud) sol_subrogacion';

        -- Aplicar los filtros
        sbCondicion := 'a.id_proyecto = b.id_proyecto
                        AND a.id_direccion = c.address_id
                        AND a.id_direccion = d.susciddi
                        AND a.activa = ''S''
                        AND a.consecutivo = ' || 'nvl(:inuConsecutivo,-1)';

        -- Construir la sentencia
        sbSentencia := 'SELECT ' || sbCamposConstDetalle || '
                        FROM   LDC_EQUIVAL_UNID_PRED     a,
                        LDC_PROYECTO_CONSTRUCTORA b,
                        AB_ADDRESS                c,
                        SUSCRIPC                  d
                        WHERE  ' || sbCondicion || '
                        ORDER BY 1';

        ut_trace.trace(sbSentencia);
        dbms_output.put_line(sbSentencia);

        OPEN ocuDatos FOR sbSentencia
            USING gnuSoliSubrogacion, gnuEstadoSolicitud, inuConsecutivo;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConCupones(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                    ocuDatos    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConCupones
        Descripcion:        Obtiene la informacion los cupones por proyecto

        Autor    : Caren Berdejo
        Fecha    : 15-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-06-2016   Caren Berdejo          Creacion
        ******************************************************************/

        sbProceso       VARCHAR2(4000) := 'proServicioConCupones';
        nuPaso          NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError         VARCHAR2(4000);
        sbCondicion     VARCHAR2(4000);
        sbSentencia     VARCHAR2(4000);
        sbCamposCupones VARCHAR(4000);
        nuContrato      NUMBER(8);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        BEGIN
            nuContrato := ldc_BOPIConstructora.fsbSuscripcion(inuProyecto);
        EXCEPTION
            WHEN OTHERS THEN
                nuContrato := NULL;
        END;
        sbCamposCupones := 'a.cuponume as cuponume,
                            a.cupotipo as cupotipo,
                            a.cupodocu as cupodocu,
                            ''$''||to_char( nvl(a.cupovalo,0),''FM999,999,990.00'') as cupovalo,
                            a.cupofech as cupofech,
                            a.cupoprog as cupoprog,
                            a.cupocupa as cupocupa,
                            a.cuposusc as cuposusc,
                            decode(a.cupoflpa,''S'',''Si'',''N'',''No'') as cupoflpa,
                            b.id_proyecto as parent_id';

        -- Aplicar los filtros
        sbCondicion := 'a.cuposusc = b.suscripcion
                        and a.cuposusc = ' || 'nvl(:nuContrato,-1)';

        -- Construir la sentencia
        sbSentencia := 'SELECT ' || sbCamposCupones || '
                        FROM   CUPON a,
                               LDC_PROYECTO_CONSTRUCTORA b
                        WHERE  ' || sbCondicion || '
                        ORDER BY 1';

        ut_trace.trace(sbSentencia);
        dbms_output.put_line(sbSentencia);

        OPEN ocuDatos FOR sbSentencia
            USING nuContrato;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioCupon(inuCupon cupon.cuponume%TYPE, -- numero del cupon
                               ocuDatos OUT CONSTANTS.TYREFCURSOR -- Cursor
                               ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioCupon
        Descripcion:        Obtiene la informacion de un cupon

        Autor    : Caren Berdejo
        Fecha    : 16-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        16-06-2016   Caren Berdejo          Creacion
        ******************************************************************/

        sbProceso       VARCHAR2(4000) := 'proServicioCupon';
        nuPaso          NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError         VARCHAR2(4000);
        sbCondicion     VARCHAR2(4000);
        sbSentencia     VARCHAR2(4000);
        sbCamposCupones VARCHAR(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        sbCamposCupones := 'a.cuponume as cuponume,
                            a.cupotipo as cupotipo,
                            a.cupodocu as cupodocu,
                            ''$''||to_char( nvl(a.cupovalo,0),''FM999,999,990.00'') as cupovalo,
                            a.cupofech as cupofech,
                            a.cupoprog as cupoprog,
                            a.cupocupa as cupocupa,
                            a.cuposusc as cuposusc,
                            decode(a.cupoflpa,''S'',''Si'',''N'',''No'') as cupoflpa,
                            b.id_proyecto as parent_id';

        -- Aplicar los filtros
        sbCondicion := 'a.cuposusc = b.suscripcion
                        and a.cuponume = ' || 'nvl(:inuCupon,-1)';

        -- Construir la sentencia
        sbSentencia := 'SELECT ' || sbCamposCupones || '
                        FROM   CUPON a,
                               LDC_PROYECTO_CONSTRUCTORA b
                        WHERE  ' || sbCondicion || '
                        ORDER BY 1';

        ut_trace.trace(sbSentencia);
        dbms_output.put_line(sbSentencia);

        OPEN ocuDatos FOR sbSentencia
            USING inuCupon;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConActas(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                  ocuDatos    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                  ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConActas
        Descripcion:        Obtiene la informacion de las actas por proyecto

        Autor    : Caren Berdejo
        Fecha    : 16-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        16-06-2016   Caren Berdejo          Creacion
        ******************************************************************/

        sbProceso          VARCHAR2(4000) := 'proServicioConActas';
        nuPaso             NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError            VARCHAR2(4000);
        sbCondicion        VARCHAR2(4000);
        sbSentencia        VARCHAR2(4000);
        sbCamposConstActas VARCHAR(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        sbCamposConstActas := 'a.consecutivo as consecutivo,
                               a.id_acta as id_acta,
                               a.id_proyecto as parent_id,
                               a.id_proyecto || '' - '' || initcap(b.nombre) as proyecto,
                               a.id_cuota as id_cuota,
                               a.fecha_registro as fecha_registro,
                               a.tipo_trabajo as tipo_trabajo,
                               ''$''||to_char(nvl(a.valor_unit,0),''FM999,999,990.00'')  as Valor_Unitario,
                               a.cant_trabajo as cant_trabajo,
                               ''$''||to_char(nvl(a.valor_total,0),''FM999,999,990.00'')  as Valor_Total';

        -- Aplicar los filtros
        sbCondicion := 'a.id_proyecto = b.id_proyecto
                        and a.id_proyecto = ' || 'nvl(:inuProyecto,-1)';

        -- Construir la sentencia
        sbSentencia := 'SELECT ' || sbCamposConstActas || '
                        FROM   LDC_ACTAS_PROYECTO a,
                               LDC_PROYECTO_CONSTRUCTORA b
                        WHERE  ' || sbCondicion || '
                        ORDER BY 1';

        ut_trace.trace(sbSentencia);
        dbms_output.put_line(sbSentencia);

        OPEN ocuDatos FOR sbSentencia
            USING inuProyecto;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioActa(inuConsecutivo ldc_actas_proyecto.consecutivo%TYPE, -- Consecutivo
                              ocuDatos       OUT CONSTANTS.TYREFCURSOR -- Cursor
                              ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioActa
        Descripcion:        Obtiene la informacion de un Acta

        Autor    : Caren Berdejo
        Fecha    : 16-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        16-06-2016   Caren Berdejo          Creacion
        ******************************************************************/

        sbProceso          VARCHAR2(4000) := 'proServicioActa';
        nuPaso             NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError            VARCHAR2(4000);
        sbCondicion        VARCHAR2(4000);
        sbSentencia        VARCHAR2(4000);
        sbCamposConstActas VARCHAR(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        sbCamposConstActas := 'a.consecutivo as consecutivo,
                               a.id_acta as id_acta,
                               a.id_proyecto as parent_id,
                               a.id_proyecto || '' - '' || initcap(b.nombre) as proyecto,
                               a.id_cuota as id_cuota,
                               a.fecha_registro as fecha_registro,
                               a.tipo_trabajo as tipo_trabajo,
                               ''$''||to_char(nvl(a.valor_unit,0),''FM999,999,990.00'') as Valor_Unitario,
                               a.cant_trabajo as cant_trabajo,
                               ''$''||to_char(nvl(a.valor_total,0),''FM999,999,990.00'') as Valor_Total';

        -- Aplicar los filtros
        sbCondicion := 'a.id_proyecto = b.id_proyecto
                        and a.consecutivo = ' || 'nvl(:inuConsecutivo,-1)';

        -- Construir la sentencia
        sbSentencia := 'SELECT ' || sbCamposConstActas || '
                        FROM   LDC_ACTAS_PROYECTO a,
                               LDC_PROYECTO_CONSTRUCTORA b
                        WHERE  ' || sbCondicion || '
                        ORDER BY 1';

        ut_trace.trace(sbSentencia);
        dbms_output.put_line(sbSentencia);

        OPEN ocuDatos FOR sbSentencia
            USING inuConsecutivo;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConCheques(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                    ocuDatos    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConCheques
        Descripcion:        Obtiene la informacion de los cheques por proyecto

        Autor    : Caren Berdejo
        Fecha    : 15-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-06-2016   Caren Berdejo          Creacion
        ******************************************************************/

        sbProceso       VARCHAR2(4000) := 'proServicioConCheques';
        nuPaso          NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError         VARCHAR2(4000);
        sbCondicion     VARCHAR2(4000);
        sbSentencia     VARCHAR2(4000);
        sbCamposCheques VARCHAR(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        sbCamposCheques := 'a.consecutivo as consecutivo,
                            a.id_proyecto as parent_id,
                            a.id_proyecto || '' - '' || initcap(b.nombre) as proyecto,
                            a.numero_cheque as numero_cheque,
                            a.entidad || '' - '' || initcap(c.bancnomb) as entidad,
                            decode(a.estado,''R'',''Registrado'',''A'',''Anulado'',''C'',''Consignado'',''D'',''Devuelto'',''L'',''Liberado'') as estado,
                            a.fecha_cheque as fecha_cheque,
                            a.fecha_alarma as fecha_alarma,
                            ''$''||to_char(nvl(a.valor,0),''FM999,999,990.00'') as Valor,
                            a.nuevo_cheque as nuevo_cheque,
                            a.cupon as cupon,
                            a.usua_registra as usua_registra,
                            a.fecha_registro as Fecha_de_Registro,
                            a.cuenta as cuenta';

        -- Aplicar los filtros
        sbCondicion := 'a.id_proyecto = b.id_proyecto
                        and a.entidad = c.banccodi
                        and a.id_proyecto = ' || 'nvl(:inuProyecto,-1)';

        -- Construir la sentencia
        sbSentencia := 'SELECT ' || sbCamposCheques || '
                        FROM   LDC_CHEQUES_PROYECTO a,
                               LDC_PROYECTO_CONSTRUCTORA b,
                               BANCO c
                        WHERE  ' || sbCondicion || '
                        ORDER BY 1';

        ut_trace.trace(sbSentencia);
        dbms_output.put_line(sbSentencia);

        OPEN ocuDatos FOR sbSentencia
            USING inuProyecto;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);

            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioCheque(inuConsecutivo ldc_cheques_proyecto.consecutivo%TYPE, -- Consecutivo
                                ocuDatos       OUT CONSTANTS.TYREFCURSOR -- Cursor
                                ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioCheque
        Descripcion:        Obtiene la informacion de un cheque

        Autor    : Caren Berdejo
        Fecha    : 16-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        16-06-2016   Caren Berdejo          Creacion
        ******************************************************************/

        sbProceso       VARCHAR2(4000) := 'proServicioCheque';
        nuPaso          NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError         VARCHAR2(4000);
        sbCondicion     VARCHAR2(4000);
        sbSentencia     VARCHAR2(4000);
        sbCamposCheques VARCHAR(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        sbCamposCheques := 'a.consecutivo as consecutivo,
                            a.id_proyecto as parent_id,
                            a.id_proyecto || '' - '' || initcap(b.nombre) as proyecto,
                            a.numero_cheque as numero_cheque,
                            a.entidad || '' - '' || initcap(c.bancnomb) as entidad,
                            decode(a.estado,''R'',''Registrado'',''A'',''Anulado'',''C'',''Consignado'',''D'',''Devuelto'',''L'',''Liberado'') as estado,
                            a.fecha_cheque as fecha_cheque,
                            a.fecha_alarma as fecha_alarma,
                            ''$''||to_char(nvl(a.valor,0),''FM999,999,990.00'') as Valor,
                            a.nuevo_cheque as nuevo_cheque,
                            a.cupon as cupon,
                            a.usua_registra as usua_registra,
                            a.fecha_registro as Fecha_de_Registro,
                            a.cuenta as cuenta';

        -- Aplicar los filtros
        sbCondicion := 'a.id_proyecto = b.id_proyecto
                        and a.entidad = c.banccodi
                        and a.consecutivo = ' || 'nvl(:inuConsecutivo,-1)';

        -- Construir la sentencia
        sbSentencia := 'SELECT ' || sbCamposCheques || '
                        FROM   LDC_CHEQUES_PROYECTO a,
                               LDC_PROYECTO_CONSTRUCTORA b,
                               BANCO c
                        WHERE  ' || sbCondicion || '
                        ORDER BY 1';

        ut_trace.trace(sbSentencia);
        dbms_output.put_line(sbSentencia);

        OPEN ocuDatos FOR sbSentencia
            USING inuConsecutivo;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConCuotasDePago(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                         ocuDatos    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                         ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConCuotasDePago
        Descripcion:        Obtiene la informacion de las cuotas de pago por proyecto

        Autor    : Caren Berdejo
        Fecha    : 15-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-06-2016   Caren Berdejo          Creacion
        ******************************************************************/

        sbProceso         VARCHAR2(4000) := 'proServicioConCuotasDePago';
        nuPaso            NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError           VARCHAR2(4000);
        sbCondicion       VARCHAR2(4000);
        sbSentencia       VARCHAR2(4000);
        sbCamposCuotaPago VARCHAR(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        sbCamposCuotaPago := 'a.consecutivo as consecutivo,
                              to_char(a.consecutivo||'';''||a.id_proyecto) as identificador,
                              a.id_proyecto as parent_id,
                              a.id_proyecto || '' - '' || initcap(b.nombre) as Proyecto,
                              a.fecha_cobro as fecha_cobro,
                              ''$''||to_char(nvl(a.valor,0),''FM999,999,990.00'') as Valor,
                              a.fecha_alarma as fecha_alarma,
                              decode(a.estado,''R'',''Registrada'',''F'',''Facturada'',''P'',''Pagada'') as Estado,
                              a.cupon as Cupon,
                              a.fecha_registro as Fecha_de_Registro,
                              a.usua_registra as usua_registra';

        -- Aplicar los filtros
        sbCondicion := 'a.id_proyecto = b.id_proyecto
                        and a.id_proyecto = ' || 'nvl(:inuProyecto,-1)';

        -- Construir la sentencia
        sbSentencia := 'SELECT ' || sbCamposCuotaPago || '
                        FROM   LDC_CUOTAS_PROYECTO a,
                               LDC_PROYECTO_CONSTRUCTORA b
                        WHERE  ' || sbCondicion || '
                        ORDER BY 1';

        ut_trace.trace(sbSentencia);
        dbms_output.put_line(sbSentencia);

        OPEN ocuDatos FOR sbSentencia
            USING inuProyecto;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioCuotaDePago(sbIdentificador VARCHAR, -- Identificador
                                     ocuDatos        OUT CONSTANTS.TYREFCURSOR -- Cursor
                                     ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioCuotaDePago
        Descripcion:        Obtiene la informacion de una cuota de pago

        Autor    : Caren Berdejo
        Fecha    : 15-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-06-2016   Caren Berdejo          Creacion
        ******************************************************************/

        sbProceso         VARCHAR2(4000) := 'proServicioCuotaDePago';
        nuPaso            NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError           VARCHAR2(4000);
        sbCondicion       VARCHAR2(4000);
        sbSentencia       VARCHAR2(4000);
        sbCamposCuotaPago VARCHAR(4000);
        nuConsecutivo     NUMBER;
        nuProyecto        NUMBER;

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        BEGIN
            nuConsecutivo := TO_NUMBER(UT_STRING.EXTSTRFIELD(sbIdentificador, ';', 1));
            nuProyecto    := TO_NUMBER(UT_STRING.EXTSTRFIELD(sbIdentificador, ';', 2));
        EXCEPTION
            WHEN OTHERS THEN
                nuConsecutivo := NULL;
                nuProyecto    := NULL;
        END;

        sbCamposCuotaPago := 'a.consecutivo as consecutivo,
                              a.consecutivo||'';''||a.id_proyecto as identificador,
                              a.id_proyecto as parent_id,
                              a.id_proyecto || '' - '' || initcap(b.nombre) as Proyecto,
                              a.fecha_cobro as fecha_cobro,
                              ''$''||to_char(nvl(a.valor,0),''FM999,999,990.00'') as Valor,
                              a.fecha_alarma as fecha_alarma,
                              decode(a.estado,''R'',''Registrada'',''F'',''Facturada'',''P'',''Pagada'') as Estado,
                              a.cupon as Cupon,
                              a.fecha_registro as Fecha_de_Registro,
                              a.usua_registra as usua_registra';

        -- Aplicar los filtros
        sbCondicion := 'a.id_proyecto = b.id_proyecto
                        and a.consecutivo = ' ||
                       'nvl(:nuConsecutivo,-1) and a.id_proyecto = ' || 'nvl(:nuProyecto,-1)';

        -- Construir la sentencia
        sbSentencia := 'SELECT ' || sbCamposCuotaPago || '
                        FROM   LDC_CUOTAS_PROYECTO a,
                               LDC_PROYECTO_CONSTRUCTORA b
                        WHERE  ' || sbCondicion || '
                        ORDER BY 1';

        ut_trace.trace(sbSentencia);
        dbms_output.put_line(sbSentencia);

        OPEN ocuDatos FOR sbSentencia
            USING nuConsecutivo, nuProyecto;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConCuotasAdicion(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                          ocuDatos    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                          ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConCuotasAdicionales
        Descripcion:        Obtiene la informacion de las cuotas adicionales por proyecto

        Autor    : Caren Berdejo
        Fecha    : 15-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-06-2016   Caren Berdejo          Creacion
        ******************************************************************/

        sbProceso                VARCHAR2(4000) := 'proServicioConCuotasAdicion';
        nuPaso                   NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError                  VARCHAR2(4000);
        sbCondicion              VARCHAR2(4000);
        sbSentencia              VARCHAR2(4000);
        sbCamposCuotaAdicionales VARCHAR(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        sbCamposCuotaAdicionales := 'a.consecutivo as consecutivo,
                                     a.id_proyecto as parent_id,
                                     a.id_proyecto ||'' - ''|| initcap(b.nombre)as proyecto,
                                     ''$''||to_char(nvl(a.valor,0),''FM999,999,990.00'') as Valor,
                                     a.cupon as cupon,
                                     decode(a.tipo_cuota,''E'',''Extraordinaria'',''A'',''Avance de Obra'') as tipo_cuota,
                                     a.fecha_registro as fecha_registro,
                                     a.usua_registra as usua_registra';

        -- Aplicar los filtros
        sbCondicion := 'a.id_proyecto = b.id_proyecto
                        and a.id_proyecto = ' || 'nvl(:inuProyecto,-1)';

        -- Construir la sentencia
        sbSentencia := 'SELECT ' || sbCamposCuotaAdicionales || '
                        FROM   LDC_CUOTAS_ADICIONALES a,
                               LDC_PROYECTO_CONSTRUCTORA b
                        WHERE  ' || sbCondicion || '
                        ORDER BY 1';

        ut_trace.trace(sbSentencia);
        dbms_output.put_line(sbSentencia);

        OPEN ocuDatos FOR sbSentencia
            USING inuProyecto;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioCuotaAdicion(inuConsecutivo ldc_cuotas_adicionales.consecutivo%TYPE, -- Consecutivo
                                      ocuDatos       OUT CONSTANTS.TYREFCURSOR -- Cursor
                                      ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioCuotaAdicion
        Descripcion:        Obtiene la informacion de una Cuota adicional

        Autor    : Caren Berdejo
        Fecha    : 15-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-06-2016   Caren Berdejo          Creacion
        ******************************************************************/

        sbProceso                VARCHAR2(4000) := 'proServicioCuotaAdicion';
        nuPaso                   NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError                  VARCHAR2(4000);
        sbCondicion              VARCHAR2(4000);
        sbSentencia              VARCHAR2(4000);
        sbCamposCuotaAdicionales VARCHAR(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        sbCamposCuotaAdicionales := 'a.consecutivo as consecutivo,
                                     a.id_proyecto as parent_id,
                                     a.id_proyecto ||'' - ''|| initcap(b.nombre)as proyecto,
                                     ''$''||to_char(nvl(a.valor,0),''FM999,999,990.00'') as Valor,
                                     a.cupon as cupon,
                                     decode(a.tipo_cuota,''E'',''Extraordinaria'',''A'',''Avance de Obra'') as tipo_cuota,
                                     a.fecha_registro as fecha_registro,
                                     a.usua_registra as usua_registra';

        -- Aplicar los filtros
        sbCondicion := 'a.id_proyecto = b.id_proyecto
                        and a.consecutivo = ' || 'nvl(:inuConsecutivo,-1)';

        -- Construir la sentencia
        sbSentencia := 'SELECT ' || sbCamposCuotaAdicionales || '
                        FROM   LDC_CUOTAS_ADICIONALES a,
                               LDC_PROYECTO_CONSTRUCTORA b
                        WHERE  ' || sbCondicion || '
                        ORDER BY 1';

        ut_trace.trace(sbSentencia);
        dbms_output.put_line(sbSentencia);

        OPEN ocuDatos FOR sbSentencia
            USING inuConsecutivo;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proInfoCuentaCobro(inuDato        NUMBER, -- Cuenta de cobro
                                 isbProyoCuenta VARCHAR2, -- Proyecto o Cuenta
                                 ocrCuentas     OUT CONSTANTS.TYREFCURSOR -- Informacion de la cuenta de cobro
                                 ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proInfoCuentaCobro
        Descripcion:        Obtiene la informacion de la/las cuentas

        Autor    : Sandra Mu?oz
        Fecha    : 15-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso      VARCHAR2(4000) := 'proInfoCuentaCobro';
        nuPaso         NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError        VARCHAR2(4000); -- Error
        sbPeriodo      VARCHAR2(200); -- Periodo
        sbPlan         VARCHAR2(200); -- Plan de facturacion
        sbLocalidad    VARCHAR2(800); -- Localidad
        sbCliente      VARCHAR2(200); -- Cliente
        sbDepartamento VARCHAR2(800); -- Departamento
        sbCiclo        VARCHAR2(200); -- Ciclo de facturacion
        sbCategoria    VARCHAR2(200); -- Categoria
        sbSubcategoria VARCHAR2(200); -- Subcategoria
        sbCampos       VARCHAR2(4000); -- Campos del select
        sbFrom         VARCHAR2(4000); -- Tablas a consultar
        sbWhere        VARCHAR2(4000); -- Union de tablas a consultar
        sbCondicion    VARCHAR2(4000); -- Filtro a aplicar
        sbSql          VARCHAR2(4000); -- Consulta a aplicar
        sbOrden        VARCHAR2(4000); -- Orden

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Campos calculados
        nuPaso         := 10;
        sbPeriodo      := 'f.factpefa' || CC_BOBOSSUTIL.CSBSEPARATOR || 'pefadesc';
        nuPaso         := 20;
        sbPlan         := 'cc.cucoplsu' || CC_BOBOSSUTIL.CSBSEPARATOR || 'plsudesc';
        nuPaso         := 30;
        sbLocalidad    := 'daab_address.fnuGetGeograp_Location_Id( cc.cucodiin )' ||
                          CC_BOBOSSUTIL.CSBSEPARATOR ||
                          'dage_geogra_location.fsbGetDescription( daab_address.fnuGetGeograp_Location_Id( cc.cucodiin ) )';
        nuPaso         := 40;
        sbDepartamento := 'decode( GE_BCGeogra_Location.fnuGetFirstUpperLevel( daab_address.fnuGetGeograp_Location_Id( cc.cucodiin  ), ' ||
                          CHR(39) || AB_BOCONSTANTS.CSBTOKEN_DEPARTAMENTO || CHR(39) || '),
                        null,' || CHR(39) || CHR(39) || ',
                        GE_BCGeogra_Location.fnuGetFirstUpperLevel( daab_address.fnuGetGeograp_Location_Id( cc.cucodiin  ), ' ||
                          CHR(39) || AB_BOCONSTANTS.CSBTOKEN_DEPARTAMENTO || CHR(39) || ')' ||
                          CC_BOBOSSUTIL.CSBSEPARATOR ||
                          'dage_geogra_location.fsbGetDescription (
                                    GE_BCGeogra_Location.fnuGetFirstUpperLevel(
                                            daab_address.fnuGetGeograp_Location_Id( cc.cucodiin ), ' ||
                          CHR(39) || AB_BOCONSTANTS.CSBTOKEN_DEPARTAMENTO || CHR(39) || '))
                      )';
        nuPaso         := 50;
        sbCiclo        := 'pf.pefacicl' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                          'cc_boBssDescription.fsbCicle (pf.pefacicl)';
        nuPaso         := 60;
        sbCategoria    := 'cc.cucocate' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                          'cc_boBssDescription.fsbCategory (cc.cucocate)';
        nuPaso         := 70;
        sbSubcategoria := 'cc.cucosuca' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                          'cc_boBssDescription.fsbSubcategory (cc.cucocate, cc.cucosuca)';

        -- Listado de campos
        nuPaso   := 80;
        sbCampos := 'cc.cucocodi cucocodi,
                     cc.cucofact cucofact,
                     cc.cuconuse cuconuse,
                     cc.cucofepa cucofepa,
                     cc.cucofeve cucofeve,
                     ''$''||to_char(nvl(cc.cucovato,0),''FM999,999,990.00'') cucovato,
                     ''$''||to_char(nvl(cc.cucovaab,0),''FM999,999,990.00'') cucovaab,
                     ''$''||to_char(nvl(cc.cucovare,0),''FM999,999,990.00'') cucovare,
                     ''$''||to_char(nvl(cc.cucovrap,0),''FM999,999,990.00'') cucovrap,
                     ''$''||to_char(nvl(cc.cucosacu,0),''FM999,999,990.00'') cucosacu,' || sbPlan || ' plan,
                    ' || sbPeriodo || ' periodo,
                    ' || sbLocalidad || ' localidad,
                    ' || sbDepartamento || ' departamento,
                    ' || sbCiclo || ' ciclo,
                    ' || sbCategoria || ' categoria,
                    ' || sbSubcategoria ||
                    'subcategoria,
                     f.factsusc factsusc,
                     ''$''||to_char(nvl(cc.cucoimfa,0),''FM999,999,990.00'') cucoimfa,
                     f.factpref factpref,
                     f.factnufi factnufi,
                     lpc.id_proyecto parent_id';

        -- Tablas a consultar
        nuPaso := 90;
        sbFrom := '
                       cuencobr                  cc,
                       factura                   f,
                       perifact                  pf,
                       plansusc                  ps,
                       ldc_proyecto_constructora lpc,
                       servsusc                  ss';

        -- Union de tablas
        nuPaso  := 110;
        sbWhere := '
                              f.factcodi = cc.cucofact
                       AND    pf.pefacodi = f.factpefa
                       AND    ps.plsucodi = cc.cucoplsu
                       AND    lpc.suscripcion = ss.sesususc
                       AND    ss.sesunuse = cc.cuconuse
                                 ';

        -- Filtro
        IF isbProyoCuenta = 'C' THEN
            nuPaso      := 130;
            sbCondicion := 'cc.cucocodi';
        ELSIF isbProyoCuenta = 'P' THEN
            nuPaso      := 140;
            sbCondicion := 'lpc.id_proyecto';
        END IF;

        sbCondicion := sbCondicion || ' = nvl(:inuDato, -1)'; --nvl(' || inuCuenta||', -1)';

        -- Ordenamiento
        nuPaso  := 150;
        sbOrden := ' cc.cucocodi desc';

        -- Construccion de la consulta
        sbSql := '
              SELECT   ' || sbCampos || '
              FROM     ' || sbFrom || '
              WHERE    ' || sbWhere || '
              AND      ' || sbCondicion || '
              ORDER BY ' || sbOrden;

        -- REtornar el cursor referenciado
        nuPaso := 160;

        dbms_output.put_line(sbSql);
        ut_trace.trace(sbSql, 1);

        OPEN ocrCuentas FOR sbSql
            USING inuDato;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConsultaCuentaXPro(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                            OCUCURSOR   OUT CONSTANTS.TYREFCURSOR -- Informacion de la cuenta de cobro
                                            ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConsultaCuentaXPro
        Descripcion:        Obtiene las cuentas de cobro asociadas a un proyecto

        Autor    : Sandra Mu?oz
        Fecha    : 15-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proServicioConsultaCuentaXPro';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000); -- Error

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        proInfoCuentaCobro(inuDato => inuProyecto, isbProyOCuenta => 'P', ocrcuentas => OCUCURSOR);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConsultaCuentaCobro(inuCuenta cuencobr.cucocodi%TYPE, -- Cuenta de cobro
                                             OCUCURSOR OUT CONSTANTS.TYREFCURSOR -- Informacion de la cuenta de cobro
                                             ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConsultaCuentaCobro
        Descripcion:        Obtiene la informacion de una cuenta de cobro

        Autor    : Sandra Mu?oz
        Fecha    : 15-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proServicioConsultaCuenCobr';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000); -- Error

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        proInfoCuentaCobro(inuDato => inuCuenta, isbProyOCuenta => 'C', ocrcuentas => OCUCURSOR);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proInfoCargos(isbDato         VARCHAR2, -- Cuenta de cobro/Cargo
                            isbCuentaOCargo VARCHAR2, -- Proyecto o Cuenta
                            ocrInformacion  OUT CONSTANTS.TYREFCURSOR -- Informacion de los cargos
                            ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proInfoCargos
        Descripcion:        Obtiene la informacion de los cargos

        Autor    : Sandra Mu?oz
        Fecha    : 15-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso       VARCHAR2(4000) := 'proInfoCargos';
        nuPaso          NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError         VARCHAR2(4000); -- Error
        sbRowId         VARCHAR2(300);
        SBCONCEPT       VARCHAR2(300);
        SBCONCEPTTYPE   VARCHAR2(300);
        SBINVOICEPERIOD VARCHAR2(300);
        SBCAUSE         VARCHAR2(300);
        SBORIGEN        VARCHAR2(300);
        SBAUTOMAT       VARCHAR2(1) := PKBILLCONST.AUTOMATICO;
        SBPOSTFACT      VARCHAR2(1) := PKBILLCONST.POST_FACTURACION;
        SBDIFERIDO      VARCHAR2(3) := PKBILLCONST.CSBTOKEN_DIFERIDO;
        SBCUOTAEXTRA    VARCHAR2(3) := PKBILLCONST.CSBTOKEN_CUOTA_EXTRA;
        sbCampos        VARCHAR2(4000); -- Campos del select
        sbFrom          VARCHAR2(4000); -- Tablas a consultar
        sbWhere         VARCHAR2(4000); -- Union de tablas a consultar
        sbCondicion     VARCHAR2(4000); -- Filtro a aplicar
        sbSql           VARCHAR2(4000); -- Consulta a aplicar
        sbOrden         VARCHAR2(4000); -- Orden

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 1);
        SBROWID         := 'rowidtochar (cargos.rowid)';
        SBCONCEPT       := 'cargos.cargconc' || CC_BOBOSSUTIL.CSBSEPARATOR || 'concepto.concdesc';
        SBCONCEPTTYPE   := 'concepto.conctico' || CC_BOBOSSUTIL.CSBSEPARATOR || 'tipoconc.ticodesc';
        SBINVOICEPERIOD := 'cargos.cargpefa' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                           'cc_boBssDescription.fsbInvoicePeriod (cargos.cargpefa)';
        SBCAUSE         := 'cargos.cargcaca' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                           'cc_boBssDescription.fsbChargeCause   (cargos.cargcaca)';
        SBORIGEN        := 'decode(cargtipr,''' || SBAUTOMAT ||
                           ''', decode(substr(cargdoso,1,3),''' || SBCUOTAEXTRA || ''',''' ||
                           SBPOSTFACT || ''',''' || SBDIFERIDO || ''',''' || SBPOSTFACT ||
                           ''', ''F''),  ''M'',''F'',  ''' || SBPOSTFACT || ''')';

        -- Listado de campos
        nuPaso   := 80;
        sbCampos := SBROWID || ' rowid_,
                    cargos.cargnuse Producto,
                    ' || SBCONCEPT || ' Concepto,
                    ' || SBCONCEPTTYPE || ' tipo_concepto,
                    cargos.cargsign cargsign,
                    cargos.cargfecr cargfecr,
                    ''$''||to_char(nvl(cargos.cargvalo,0),''FM999,999,990.00'') Valor,
                    procesos.proccodi Programa,
                    sa_user.mask Usuario,
                    cargos.cargunid Unidades,
                    ' || SBINVOICEPERIOD || ' periodo_facturacion,
                    ' || SBCAUSE || ' Causa,
                    cargos.cargdoso cargdoso,
                    cargos.cargcoll cargcoll,
                    cargos.cargcuco cargcuco,
                    ' || SBORIGEN ||
                    ' origen,
                    cargos.cargtaco cargtaco,
                    ta_tariconc.tacotimo tacotimo,
                    cargos.cargcuco parent_id';

        -- Tablas a consultar
        nuPaso := 90;
        sbFrom := '
                      cargos,
                      concepto,
                      procesos,
                      sa_user,
                      ta_tariconc,
                      tipoconc';

        -- Union de tablas
        nuPaso  := 110;
        sbWhere := '
                              concepto.conccodi = cargos.cargconc' || CHR(10) || '
                          and cargos.cargprog = procesos.proccons' || CHR(10) || '
                          and cargos.cargusua = sa_user.user_id' || CHR(10) || '
                          and cargos.cargtaco = ta_tariconc.tacocons(+)' ||
                   CHR(10) || '
                          and concepto.conctico = tipoconc.ticocodi(+)
                                 ';

        -- Filtro
        IF isbCuentaOCargo = 'CU' THEN
            nuPaso      := 130;
            sbCondicion := 'cargos.cargcuco = nvl(to_number(:isbDato), -1)';
        ELSIF isbCuentaOCargo = 'CA' THEN
            nuPaso      := 140;
            sbCondicion := 'cargos.rowid = :isbDato';
        END IF;

        -- Ordenamiento
        nuPaso  := 150;
        sbOrden := ' cargos.cargfecr ';

        -- Construccion de la consulta
        sbSql := '
              SELECT   ' || sbCampos || '
              FROM     ' || sbFrom || '
              WHERE    ' || sbWhere || '
              AND      ' || sbCondicion || '
              ORDER BY ' || sbOrden;

        -- REtornar el cursor referenciado
        nuPaso := 160;

        dbms_output.put_line(sbSql);
        ut_trace.trace(sbSql, 1);

        nuPaso := 130;
        OPEN ocrInformacion FOR sbSql
            USING isbDato;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConsultaCargXCC(inuCuenta cargos.cargcuco%TYPE, -- Cuenta de cobro
                                         OCUCURSOR OUT CONSTANTS.TYREFCURSOR -- Informacion de los cargos
                                         ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConsultaCuentaXPro
        Descripcion:        Cargos por cuenta de cobro

        Autor    : Sandra Mu?oz
        Fecha    : 15-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proServicioConsultaCargXCC';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000); -- Error

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 1);

        proInfoCargos(isbDato         => to_char(inuCuenta),
                      isbCuentaOCargo => 'CU',
                      ocrInformacion  => OCUCURSOR);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConsultaCargos(isbRowid  VARCHAR2, -- Rowid del cargo
                                        OCUCURSOR OUT CONSTANTS.TYREFCURSOR -- Informacion del cargo
                                        ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConsultaCargos
        Descripcion:        Obtiene la informacion de una cuenta de cobro

        Autor    : Sandra Mu?oz
        Fecha    : 15-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proServicioConsultaCargos';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000); -- Error

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 1);

        proInfoCargos(isbDato => isbRowid, isbCuentaOCargo => 'CA', ocrInformacion => OCUCURSOR);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proInfoDiferidos(inuDato            NUMBER, -- Cuenta de cobro/diferido
                               isbCuentaODiferido VARCHAR2, -- C-uenta de cobro o D-iferido
                               ocrInformacion     OUT CONSTANTS.TYREFCURSOR -- Informacion
                               ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proInfoDiferidos
        Descripcion:        Obtiene la informacion de los diferidos

        Autor    : Sandra Mu?oz
        Fecha    : 16-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        28-06-2016   Sandra Mu?oz           Se mejora el rendimiento de las consultas
        16-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso        VARCHAR2(4000) := 'proInfoDiferidos';
        nuPaso           NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError          VARCHAR2(4000); -- Error
        SBDEFERREDPLAN   VARCHAR2(400);
        SBCONCEPT        VARCHAR2(400);
        SBRATE           VARCHAR2(400);
        SBPENDIND        VARCHAR2(400);
        SBDEFERREDMETHOD VARCHAR2(400);
        SBBILL           VARCHAR2(400);
        SBPRODTYPE       VARCHAR2(400);
        SBINTERESTCONC   VARCHAR2(400);
        sbCampos         VARCHAR2(4000); -- Campos del select
        sbFrom           VARCHAR2(4000); -- Tablas a consultar
        sbWhere          VARCHAR2(4000); -- Union de tablas a consultar
        sbCondicion      VARCHAR2(4000); -- Filtro a aplicar
        sbSql            VARCHAR2(4000); -- Consulta a aplicar
        sbOrden          VARCHAR2(4000); -- Orden

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 1);
        SBDEFERREDPLAN   := 'difepldi' || CC_BOBOSSUTIL.CSBSEPARATOR || 'pldidesc';
        SBCONCEPT        := 'difeconc' || CC_BOBOSSUTIL.CSBSEPARATOR || 'concdesc';
        SBRATE           := 'difetain' || CC_BOBOSSUTIL.CSBSEPARATOR || 'taindesc';
        SBDEFERREDMETHOD := 'difemeca' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                            'cc_boBssDescription.fsbDeferredMethod (difemeca)';
        SBPENDIND        := 'case when difenucu - difecupa < 0 then 0 else difenucu - difecupa END ';
        SBBILL           := 'cc_boBssDeferredData.fnuBill(diferido.difecodi)';
        SBPRODTYPE       := 'dapr_product.fnuGetProduct_type_id(diferido.difenuse)';
        SBPRODTYPE       := SBPRODTYPE || CC_BOBOSSUTIL.CSBSEPARATOR ||
                            'cc_boOssDescription.fsbProductType(' || SBPRODTYPE || ')';
        SBINTERESTCONC   := 'difecoin' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                            'cc_boBssDescription.fsbConcept(difecoin)';

        -- Listado de campos
        nuPaso   := 80;
        sbCampos := 'diferido.difecodi Diferido,
                     diferido.difesusc Contrato,
                     diferido.difenuse Producto,
                     ' || SBDEFERREDPLAN || '
                     deferred_plan,
                     diferido.difeenre difeenre,
                     ' || SBCONCEPT || ' Concepto,
                     diferido.difeinte Interes,
                     diferido.difespre Spread,
                     ''$''||to_char(nvl(diferido.difevatd,0),''FM999,999,990.00'') Total,
                     ''$''||to_char(nvl(diferido.difevacu,0),''FM999,999,990.00'') Valor_Cuota,
                     diferido.difecupa difecupa,
                     ' || SBPENDIND || ' pendind,
                     ''$''||to_char(nvl(diferido.difesape,0),''FM999,999,990.00'') difesape,
                     cc_boBssDeferredData.fnuCount(diferido.difecodi) count,
                     cc_boBssDeferredData.fnuValue(diferido.difecodi) value_,
                     ' || SBRATE || ' rate,
                     diferido.difefein difefein,
                     diferido.difefumo difefumo,
                     ' || SBDEFERREDMETHOD || ' deferred_method,
                     diferido.difetire difetire,
                     ' || SBBILL || '  parent_id,
                     diferido.difeusua difeusua,
                     ' || SBPRODTYPE || ' product_type,
                     diferido.difesign difesign,
                     ' || SBINTERESTCONC || ' difecoin,
                     diferido.difenucu difenucu,
                     ''$''||to_char(nvl(diferido.difeinac,0),''FM999,999,990.00'') difeinac,
                     diferido.difenudo difenudo
                     ';

        -- Tablas a consultar
        nuPaso := 90;
        sbFrom := '
                     diferido,
                     concepto,
                     plandife,
                     tasainte';

        -- Union de tablas
        nuPaso  := 110;
        sbWhere := '
                     conccodi = difeconc
              AND    pldicodi = difepldi
              AND    taincodi = difetain';

        -- Filtro
        IF isbCuentaODiferido = 'C' THEN
            nuPaso      := 130;
            sbCondicion := 'EXISTS (SELECT 1
                                           FROM   cargos
                                           WHERE  (cargdoso LIKE ''FD%'' OR cargdoso LIKE ''DF%'' OR cargdoso LIKE ''ID%'' OR
                                                   cargdoso LIKE ''CX%'')
                                           AND    cargnuse = difenuse
                                           AND    cargcuco = nvl(:inuDato, -1))';
        ELSIF isbCuentaODiferido = 'D' THEN
            nuPaso      := 140;
            sbCondicion := sbCondicion || ' diferido.difecodi = nvl(:inuDato, -1)';
        END IF;

        --        sbCondicion := sbCondicion || ' = nvl(:inuDato, -1)';

        -- Ordenamiento
        nuPaso  := 150;
        sbOrden := ' diferido.difecodi ';

        -- Construccion de la consulta
        sbSql := '
              SELECT   ' || sbCampos || '
              FROM     ' || sbFrom || '
              WHERE    ' || sbWhere || '
              AND      ' || sbCondicion || '
              ORDER BY ' || sbOrden;

        -- REtornar el cursor referenciado
        nuPaso := 160;

        dbms_output.put_line(sbSql);
        ut_trace.trace(sbSql, 1);

        nuPaso := 130;
        OPEN ocrInformacion FOR sbSql
            USING inuDato;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConsultaDiferXCC(inuCuenta cargos.cargcuco%TYPE, -- Cuenta de cobro
                                          OCUCURSOR OUT CONSTANTS.TYREFCURSOR -- Informacion de los cargos
                                          ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConsultaDiferXCC
        Descripcion:        Diferidos por cuenta de cobro

        Autor    : Sandra Mu?oz
        Fecha    : 16-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        16-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proServicioConsultaDiferXCC';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000); -- Error

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 1);

        proInfoDiferidos(inuDato            => inuCuenta,
                         isbCuentaODiferido => 'C',
                         ocrInformacion     => OCUCURSOR);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConsultaDiferido(inuDiferido diferido.difecodi%TYPE, -- Diferido
                                          OCUCURSOR   OUT CONSTANTS.TYREFCURSOR -- Informacion del cargo
                                          ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConsultaDiferido
        Descripcion:        Obtiene la informacion de un diferido

        Autor    : Sandra Mu?oz
        Fecha    : 16-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        16-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proServicioConsultaDiferido';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000); -- Error

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 1);

        proInfoDiferidos(inuDato            => inuDiferido,
                         isbCuentaODiferido => 'D',
                         ocrInformacion     => OCUCURSOR);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proInfoPagos(isbDato        VARCHAR2, -- Cuenta de cobro/Cargo
                           isbCuentaOPago VARCHAR2, -- C-uenta o P-Pago
                           ocrInformacion OUT CONSTANTS.TYREFCURSOR -- Informacion
                           ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proInfoPagos
        Descripcion:        Obtiene la informacion de los diferidos

        Autor    : Sandra Mu?oz
        Fecha    : 16-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        28-06-2016   Sandra Mu?oz           Se mejora el rendimiento de las consultas
        16-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso    VARCHAR2(4000) := 'proInfoPagos';
        nuPaso       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError      VARCHAR2(4000); -- Error
        SBBANCO      VARCHAR2(200);
        SBSUCURSAL   VARCHAR2(200);
        SBTIPOCOMP   VARCHAR2(200);
        SBVALOREACT  VARCHAR(500);
        SBVALOID     VARCHAR2(500);
        NUCUPONID    NUMBER;
        NUCONTRATOID NUMBER;
        sbCampos     VARCHAR2(4000); -- Campos del select
        sbFrom       VARCHAR2(4000); -- Tablas a consultar
        sbWhere      VARCHAR2(4000); -- Union de tablas a consultar
        sbCondicion  VARCHAR2(4000); -- Filtro a aplicar
        sbSql        VARCHAR2(4000); -- Consulta a aplicar
        sbOrden      VARCHAR2(4000); -- Orden

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 1);

        nuPaso := 10;

        ut_trace.trace('isbDato ' || isbDato, 1);

        BEGIN
            NUCUPONID := TO_NUMBER(UT_STRING.EXTSTRFIELD(isbDato, ';', 1));
        EXCEPTION
            WHEN OTHERS THEN
                nuCuponId := NULL;
        END;

        nuPaso := 20;
        BEGIN
            NUCONTRATOID := TO_NUMBER(UT_STRING.EXTSTRFIELD(isbDato, ';', 2));
        EXCEPTION
            WHEN OTHERS THEN
                nuContratoID := NULL;
        END;

        nuPaso  := 20;
        SBBANCO := 'pagobanc' || CC_BOBOSSUTIL.CSBSEPARATOR || 'bancnomb';

        nuPaso     := 40;
        SBSUCURSAL := 'pagosuba' || CC_BOBOSSUTIL.CSBSEPARATOR || 'subanomb';

        nuPaso     := 50;
        SBTIPOCOMP := 'RC_BCInformacionPagos.fsbGetTipoComp(pagocupo)';

        nuPaso      := 60;
        SBVALOREACT := '(
        SELECT NVL(sum(crcdvacu),0)
        FROM curechde
        WHERE crcdcupo = pagocupo)';

        nuPaso   := 70;
        SBVALOID := 'pagocupo||'';''||pagosusc';

        -- Listado de campos
        nuPaso   := 80;
        sbCampos := '/*+ leading (cargos) index(cargos IX_CARG_CODO)
                    use_nl_with_index(cuencobr PK_CUENCOBR)
                    use_nl_with_index(servsusc PK_SERVSUSC)
                    use_nl_with_index(perifact PK_PERIFACT)
                    use_nl_with_index(factura PK_FACTURA)
                    use_nl_with_index(ta_tariconc PK_TA_TARICONC)*/
                    pagocupo Cupon_de_Pago,
                    pagofegr Fecha_de_Grabacion,
                    pagofepa Fecha_de_Pago,
                     ' || SBBANCO || ' Entidad_de_Recaudo,
                     ' || SBSUCURSAL || ' Sucursal_de_Recaudo,
                     ''$''||to_char(nvl(pagovapa,0),''FM999,999,990.00'') Valor ,
                     pagousua Usuario,
                     pagotipa Tipo_de_Pago,
                     pagosusc Contrato,
                     pagopref Prefijo,
                     pagonufi Numero_Fiscal,
                     ' || SBTIPOCOMP || ' pagotico,
                     pagonutr Numero_de_Transaccion,
                     pagoconc Conciliacion,
                     ' || SBVALOREACT || 'ValorReactivado,
                     cupotipo,
                     cupotipo,
                     ' || SBVALOID || ' id,
                     cargcuco parent_id';

        -- Tablas a consultar
        nuPaso := 90;

        sbFrom := '(
                        SELECT/*+ leading(cargos) IX_CARG_CUCO_CONC
                        use_nl(servsusc)*/ *
                        FROM cargos, servsusc, pagos
                        WHERE pagocupo = cargcodo
                        AND cargos.cargnuse = servsusc.sesunuse
                        AND servsusc.sesususc = pagosusc
                        AND cargsign = ''PA''';

        -- Filtro
        IF isbCuentaOPago = 'C' THEN
            nuPaso := 130;
            sbFrom := sbFrom || '
                        AND cargcuco = nvl(to_number(:isbDato), ''-1'')';

        ELSIF isbCuentaOPago = 'P' THEN
            nuPaso := 140;
            sbFrom := sbFrom || '
                        AND pagocupo = nvl(:nuCuponId, -1)
                        AND pagosusc = nvl(:nuContratoId, -1)';
        END IF;

        sbFrom := sbFrom || ') pay_data,
                        banco, sucubanc, cupon';

        -- Union de tablas
        nuPaso := 110;

        sbWhere := '    pagobanc = banccodi
                      and pagobanc = subabanc
                      and pagosuba = subacodi
                      and pagocupo = cuponume';


        -- Ordenamiento
        nuPaso  := 150;
        sbOrden := ' pagocupo ';

        -- Construccion de la consulta
        sbSql := '
              SELECT   ' || sbCampos || '
              FROM     ' || sbFrom || '
              WHERE    ' || sbWhere || '
              ORDER BY ' || sbOrden;

        -- REtornar el cursor referenciado
        nuPaso := 160;

        dbms_output.put_line(sbSql);
        ut_trace.trace(sbSql, 1);

        nuPaso := 130;

        IF isbCuentaOPago = 'P' THEN
            OPEN ocrInformacion FOR sbSql
                USING NUCUPONID, NUCONTRATOID;
        ELSIF isbCuentaOPago = 'C' THEN
            OPEN ocrInformacion FOR sbSql
                USING IN isbDato;
        END IF;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConsultaPagosXCC(inuCuenta cargos.cargcuco%TYPE, -- Cuenta de cobro
                                          OCUCURSOR OUT CONSTANTS.TYREFCURSOR -- Informacion de los cargos
                                          ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConsultaPagosXCC
        Descripcion:        Pagos por cuenta de cobro

        Autor    : Sandra Mu?oz
        Fecha    : 16-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        16-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proServicioConsultaPagosXCC';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000); -- Error

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 1);

        proInfoPagos(isbDato        => to_char(inuCuenta),
                     isbCuentaOPago => 'C',
                     ocrInformacion => OCUCURSOR);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConsultaPago(isbCuponSuscriptor VARCHAR2, -- Cupon y suscriptor
                                      OCUCURSOR          OUT CONSTANTS.TYREFCURSOR -- Informacion del cargo
                                      ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConsultaPago
        Descripcion:        Obtiene la informacion de un pago

        Autor    : Sandra Mu?oz
        Fecha    : 16-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        16-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proServicioConsultaPago';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000); -- Error

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 1);

        proInfoPagos(isbDato        => isbCuponSuscriptor,
                     isbCuentaOPago => 'P',
                     ocrInformacion => OCUCURSOR);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proInfoSolicitud(isbServicio      VARCHAR2, -- Consulta o B-Busqueda
                               inuSolicitud     mo_packages.package_id%TYPE, -- Id solicitud
                               inuEstado        mo_packages.Motive_Status_Id%TYPE, -- Estado
                               inuTipoSolicitud mo_packages.package_type_id%TYPE, -- Tipo de solicitud
                               inuProyecto      ge_subscriber.subscriber_id%TYPE, -- Codigo del proyecto
                               ocrInformacion   OUT CONSTANTS.TYREFCURSOR -- Informacion
                               ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proInfoSolicitud
        Descripcion:        Obtiene la informacion de la solicitud

        Autor    : KCienfuegos
        Fecha    : 26-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        26-06-2016   KCienfuegos           Creacion.
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proInfoSolicitud';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000); -- Error

        sbHints     VARCHAR2(6000);
        sbCampos    VARCHAR2(4000); -- Campos del select
        sbFrom      VARCHAR2(4000); -- Tablas a consultar
        sbWhere     VARCHAR2(4000); -- Union de tablas a consultar
        sbCondicion VARCHAR2(4000); -- Filtro a aplicar
        sbSql       VARCHAR2(4000); -- Consulta a aplicar
        sbOrden     VARCHAR2(4000); -- Orden

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 1);

        sbHints := '/*+ index (a PK_MO_PACKAGES) */';

        -- Listado de campos
        nuPaso   := 80;
        sbCampos := 'a.subscriber_id ,
                     a.package_type_id,' || CHR(10) || 'a.package_type_id' ||
                    CC_BOBOSSUTIL.CSBSEPARATOR || 'b.description tipo_solicitud,' ||
                    'a.motive_status_id,' || CHR(10) || 'a.motive_status_id' ||
                    CC_BOBOSSUTIL.CSBSEPARATOR || 'c.description estado,' || 'a.reception_type_id,' ||
                    CHR(10) || 'a.reception_type_id' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                    'e.description tipo_recepcion,' || 'a.person_id,' || CHR(10) || 'a.person_id ' ||
                    CC_BOBOSSUTIL.CSBSEPARATOR || 'f.name_ vendor, ' || 'a.organizat_area_id,' ||
                    CHR(10) || 'a.organizat_area_id' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                    'g.display_description area_organizacional, ' ||
                    'a.request_date fecha_registro,
                     a.Expect_Atten_Date,
                     a.user_id usuario,
                     a.attention_date fecha_atencion,
                     a.comment_ observacion,
                     pc.id_proyecto parent_id';

        -- Tablas a consultar
        nuPaso := 90;
        sbFrom := 'mo_packages a, ps_package_type b, ps_motive_status c,' || CHR(10) ||
                  'ge_reception_type e, ge_person f, ge_organizat_area g,' || CHR(10) ||
                  'or_operating_unit k, pm_project l, cc_answer_mode m,' || CHR(10) ||
                  'cc_refer_mode n, ge_subscriber o, ab_Address p,' || CHR(10) ||
                  'tipocomp q, ge_subscriber r, ab_address s,' || CHR(10) ||
                  'ge_organizat_area t, ge_geogra_location u, ldc_proyecto_constructora pc';
        -- Inicializa la consulta
        sbWhere := '1 = 1';

        sbCondicion := 'a.package_type_id = b.package_type_id' || CHR(10) ||
                       'AND a.motive_status_id = c.motive_status_id' || CHR(10) ||
                       'AND a.reception_type_id = e.reception_type_id (+)' || CHR(10) ||
                       'AND a.person_id = f.person_id (+)' || CHR(10) ||
                       'AND a.organizat_area_id = g.organizat_area_id (+)' || CHR(10) ||
                       'AND a.management_area_id = t.organizat_area_id (+)' || CHR(10) ||
                       'AND a.subscriber_id = r.subscriber_id (+)' || CHR(10) ||
                       'AND r.address_id = s.address_id (+)' || CHR(10) ||
                       'AND s.neighborthood_id = u.geograp_location_id (+)' || CHR(10) ||
                       'AND a.POS_Oper_Unit_Id = k.operating_unit_id (+)' || CHR(10) ||
                       'AND a.Project_Id = l.Project_Id (+)' || CHR(10) ||
                       'AND a.answer_mode_id = m.answer_mode_id (+)' || CHR(10) ||
                       'AND a.refer_mode_id = n.refer_mode_id (+)' || CHR(10) ||
                       'AND a.contact_id = o.subscriber_id (+)' || CHR(10) ||
                       'AND a.address_id = p.address_id (+)' || CHR(10) ||
                       'AND a.document_type_id = q.ticocodi (+)' || CHR(10) ||
                       'AND pc.id_solicitud = a.package_id';

        -- Filtro
        IF isbServicio = 'C' THEN
            nuPaso := 130;

            IF inuSolicitud IS NOT NULL THEN
                sbCondicion := sbCondicion || ' AND a.package_id = nvl(:inuSolicitud, -1)';
            ELSIF inuProyecto IS NOT NULL THEN
                sbCondicion := sbCondicion || ' AND pc.id_proyecto = :inuProyecto';
            END IF;

        ELSIF isbServicio = 'B' THEN

            sbCondicion := sbCondicion ||
                           ' AND a.motive_status_id= :inuEstado  OR :inuEstado IS NULL )';

            sbCondicion := sbCondicion ||
                           ' AND a.package_type_id = :inuTipoSolicitud OR :inuTipoSolicitud IS NULL)';

            sbCondicion := sbCondicion ||
                           ' AND a.package_id = :inuProyecto OR :inuProyecto IS NULL)';
        END IF;

        -- Ordenamiento
        nuPaso  := 150;
        sbOrden := ' a.package_id';

        -- Construccion de la consulta
        sbSql := '
              SELECT   ' || sbHints || CHR(10) || sbCampos || CHR(10) || '
              FROM     ' || sbFrom || '
              WHERE    ' || sbWhere || '
              AND      ' || sbCondicion || '
              ORDER BY ' || sbOrden;

        -- REtornar el cursor referenciado
        nuPaso := 160;

        dbms_output.put_line(sbSql);
        ut_trace.trace(sbSql, 1);

        nuPaso := 130;

        IF isbServicio = 'C' THEN

            IF inuSolicitud IS NOT NULL THEN
                OPEN ocrInformacion FOR sbSql
                    USING inuSolicitud;
            ELSIF inuProyecto IS NOT NULL THEN
                OPEN ocrInformacion FOR sbSql
                    USING inuProyecto;
            END IF;

        ELSIF isbServicio = 'B' THEN

            OPEN ocrInformacion FOR sbSql
                USING inuEstado, inuTipoSolicitud, inuProyecto;

        END IF;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConsultaSolic(inuSolicitud IN mo_packages.package_id%TYPE,
                                       ocuCursor    OUT CONSTANTS.TYREFCURSOR) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConsultaSolic
        Descripcion:        Obtiene la informacion de la solicitud

        Autor    : KCienfuegos
        Fecha    : 27-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        27-06-2016   KCienfuegos           Creacion
        ******************************************************************/
        sbProceso VARCHAR2(4000) := 'proServicioConsultaSolic';
        nuPaso    NUMBER;
        sbError   VARCHAR2(4000);

    BEGIN

        proInfoSolicitud('C', inuSolicitud, NULL, NULL, NULL, ocuCursor);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proServicioConsultaSolicXProy(inuProyecto IN ldc_proyecto_constructora.id_proyecto%TYPE,
                                            ocuCursor   OUT CONSTANTS.TYREFCURSOR) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proServicioConsultaSolicXProy
        Descripcion:        Obtiene las solicitudes del proyecto

        Autor    : KCienfuegos
        Fecha    : 27-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        27-06-2016   KCienfuegos           Creacion
        ******************************************************************/
        sbProceso VARCHAR2(4000) := 'proServicioConsultaSolicXProy';
        nuPaso    NUMBER;
        sbError   VARCHAR2(4000);

    BEGIN

        proInfoSolicitud('C', NULL, NULL, NULL, inuProyecto, ocuCursor);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proCargaInfoProyecto(inuProyecto IN ldc_proyecto_constructora.id_proyecto%TYPE)
    /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCargaInfoProyecto
        Descripcion:        Carga la informacion del proyecto

        Autor    : KCienfuegos
        Fecha    : 21-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        21-06-2016   KCienfuegos           Creacion
        ******************************************************************/
     IS
        sbProceso     VARCHAR2(4000) := 'proCargaInfoProyecto';
        sbInstance    VARCHAR2(2000) := MO_BOUNCOMPOSITIONCONSTANTS.CSBWORK_INSTANCE;
        rcProyecto    daldc_proyecto_constructora.styLDC_PROYECTO_CONSTRUCTORA;
        sbEntProyecto VARCHAR2(2000) := 'LDC_PROYECTO_CONSTRUCTORA';
        nuGrupo       NUMBER := NULL;
        sbError       VARCHAR2(4000);
        nuPaso        NUMBER;
    BEGIN

        daldc_proyecto_constructora.AccKey(inuProyecto);

        ldc_boVentaConstructora.proMarcaCuotaPagada(inuProyecto);

        rcProyecto := daldc_proyecto_constructora.frcGetRecord(inuProyecto);

        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'ID_PROYECTO',
                                          inuProyecto,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'NOMBRE',
                                          rcProyecto.nombre,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'DESCRIPCION',
                                          rcProyecto.descripcion,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'CLIENTE',
                                          rcProyecto.cliente,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'FORMA_PAGO',
                                          rcProyecto.forma_pago,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'FECHA_CREACION',
                                          rcProyecto.fecha_creacion,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'FECH_ULT_MODIF',
                                          rcProyecto.fech_ult_modif,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'TIPO_CONSTRUCCION',
                                          rcProyecto.tipo_construccion,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'CANTIDAD_PISOS',
                                          rcProyecto.cantidad_pisos,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'CANTIDAD_TORRES',
                                          rcProyecto.cantidad_torres,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'CANT_UNID_PREDIAL',
                                          rcProyecto.cant_unid_predial,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'CANT_TIP_UNID_PRED',
                                          rcProyecto.cant_tip_unid_pred,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'VALOR_FINAL_APROB',
                                          rcProyecto.valor_final_aprob,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'ID_DIRECCION',
                                          rcProyecto.id_direccion,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'ID_LOCALIDAD',
                                          rcProyecto.id_localidad,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'PAGARE',
                                          rcProyecto.pagare,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'CONTRATO',
                                          rcProyecto.contrato,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'ID_PROYECTO_ORIGEN',
                                          rcProyecto.id_proyecto_origen,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'SUSCRIPCION',
                                          rcProyecto.suscripcion,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'PORC_CUOT_INI',
                                          rcProyecto.porc_cuot_ini,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntProyecto,
                                          'ID_SOLICITUD',
                                          rcProyecto.id_solicitud,
                                          TRUE);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END proCargaInfoProyecto;

    PROCEDURE proCargaInfoCupon(inuCupon IN cupon.cuponume%TYPE)
    /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCargaInfoCupon
        Descripcion:        Carga la informacion del cupon

        Autor    : KCienfuegos
        Fecha    : 22-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        22-06-2016   KCienfuegos           Creacion
        ******************************************************************/
     IS
        sbProceso  VARCHAR2(4000) := 'proCargaInfoCupon';
        sbInstance VARCHAR2(2000) := MO_BOUNCOMPOSITIONCONSTANTS.CSBWORK_INSTANCE;
        rcCupon    cupon%ROWTYPE;
        sbEntCupon VARCHAR2(2000) := 'CUPON';
        nuGrupo    NUMBER := NULL;
        sbError    VARCHAR2(4000);
        nuPaso     NUMBER;

    BEGIN

        pktblcupon.acckey(inuCupon);
        rcCupon := pktblcupon.frcgetrecord(inuCuponume => inuCupon);

        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntCupon,
                                          'CUPONUME',
                                          inuCupon,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntCupon,
                                          'CUPOFECH',
                                          rcCupon.Cupofech,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntCupon,
                                          'CUPOSUSC',
                                          rcCupon.Cuposusc,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntCupon,
                                          'CUPOVALO',
                                          rcCupon.Cupovalo,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntCupon,
                                          'CUPODOCU',
                                          rcCupon.Cupodocu,
                                          TRUE);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END proCargaInfoCupon;

    PROCEDURE proCargaInfoActa(inuConsecutivo IN ldc_actas_proyecto.consecutivo%TYPE)
    /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCargaInfoActa
        Descripcion:        Carga la informacion del acta

        Autor    : KCienfuegos
        Fecha    : 23-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        23-06-2016   KCienfuegos           Creacion
        ******************************************************************/
     IS
        sbProceso  VARCHAR2(4000) := 'proCargaInfoActa';
        sbInstance VARCHAR2(2000) := MO_BOUNCOMPOSITIONCONSTANTS.CSBWORK_INSTANCE;
        rcActa     daldc_actas_proyecto.styLDC_ACTAS_PROYECTO;
        sbEntActa  VARCHAR2(2000) := 'LDC_ACTAS_PROYECTO';
        nuGrupo    NUMBER := NULL;
        sbError    VARCHAR2(4000);
        nuPaso     NUMBER;

    BEGIN

        daldc_actas_proyecto.AccKey(inuConsecutivo);
        rcActa := daldc_actas_proyecto.frcGetRecord(inuCONSECUTIVO => inuConsecutivo);

        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntActa,
                                          'CONSECUTIVO',
                                          inuConsecutivo,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntActa,
                                          'ID_ACTA',
                                          rcActa.id_acta,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntActa,
                                          'ID_PROYECTO',
                                          rcActa.id_proyecto,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntActa,
                                          'ID_CUOTA',
                                          rcActa.id_cuota,
                                          TRUE);
        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntActa,
                                          'TIPO_TRABAJO',
                                          rcActa.tipo_trabajo,
                                          TRUE);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END proCargaInfoActa;

    PROCEDURE proCargaInfoCotiz(inuConsecutivo IN ldc_cotizacion_construct.id_consecutivo%TYPE)
    /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCargaInfoCliente
        Descripcion:        Carga la informacion del cliente a partir del consecutivo de la cotizacion.

        Autor    : KCienfuegos
        Fecha    : 24-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        24-06-2016   KCienfuegos           Creacion
        ******************************************************************/
     IS
        sbProceso  VARCHAR2(4000) := 'proCargaInfoCotiz';
        sbInstance VARCHAR2(2000) := MO_BOUNCOMPOSITIONCONSTANTS.CSBWORK_INSTANCE;
        nuGrupo    NUMBER := NULL;
        sbEntCoti  VARCHAR2(2000) := 'LDC_COTIZACION_DETALLADA';
        nuCotizac  ldc_cotizacion_construct.id_cotizacion_detallada%TYPE;
        rcCotizac  daldc_cotizacion_construct.styLDC_COTIZACION_CONSTRUCT;
        nuProyecto ldc_proyecto_constructora.id_proyecto%TYPE;
        nuCliente  ldc_proyecto_constructora.cliente%TYPE;
        sbProyecto ldc_proyecto_constructora.nombre%TYPE;
        sbError    VARCHAR2(4000);
        nuPaso     NUMBER;

        CURSOR cuObtieneCotProyecto IS
            SELECT c.id_cotizacion_detallada,
                   c.id_proyecto
            FROM   ldc_cotizacion_construct c
            WHERE  c.id_consecutivo = inuConsecutivo;

    BEGIN

        OPEN cuObtieneCotProyecto;
        FETCH cuObtieneCotProyecto
            INTO nuCotizac,
                 nuProyecto;
        CLOSE cuObtieneCotProyecto;

        daldc_cotizacion_construct.AccKey(inuID_COTIZACION_DETALLADA => nuCotizac,
                                          inuID_PROYECTO => nuProyecto);

        rcCotizac := daldc_cotizacion_construct.frcGetRecord(inuID_COTIZACION_DETALLADA => nuCotizac,
                                                             inuID_PROYECTO => nuProyecto);

        daldc_proyecto_constructora.AccKey(inuID_PROYECTO => nuProyecto);

        nuCliente := daldc_proyecto_constructora.fnuGetCLIENTE(nuProyecto);

        sbProyecto := daldc_proyecto_constructora.fsbGetNOMBRE(nuProyecto);

        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntCoti,
                                          'ID_PROYECTO',
                                          nuProyecto,
                                          TRUE);

        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntCoti,
                                          'ID_COTIZACION_DETALLADA',
                                          nuCotizac,
                                          TRUE);

        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntCoti,
                                          'PROYECTO',
                                          sbProyecto,
                                          TRUE);

        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntCoti,
                                          'ESTADO',
                                          rcCotizac.estado,
                                          TRUE);

        ge_boinstancecontrol.addattribute(sbInstance,
                                          nuGrupo,
                                          sbEntCoti,
                                          'ID_COTIZACION_OSF',
                                          rcCotizac.id_cotizacion_osf,
                                          TRUE);

        IF (nuCliente IS NOT NULL) THEN
            GI_BOInstanceData.LoadClientInformation(nuCliente);
        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END proCargaInfoCotiz;

    FUNCTION fnuValorAdicional(inuProyecto      IN            ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                               isbOpcion        IN            VARCHAR2
                               ) RETURN NUMBER IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: fnuValorAdicional
        Descripcion:        Obtiene el valor adicional: ya se el cotizado adicional o el costo, de acuerdo
                            a la opcion recibida por parametro

        Autor    : KCienfuegos
        Fecha    : 08-07-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        08-07-2016   KCienfuegos           Creacion.
        ******************************************************************/

        sbProceso    VARCHAR2(4000) := 'fnuValorAdicional';
        nuPaso       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError      VARCHAR2(4000);
        nuValor      NUMBER := 0; -- Valor
        nuCantUnit   NUMBER:=0;

        /*CURSOR cuCantUnidadesAct IS
          SELECT COUNT(*)
            FROM ldc_equival_unid_pred e
           WHERE e.id_proyecto = inuProyecto
             AND e.activa = 'S';*/

       CURSOR cuCantUnidadesAct is
       SELECT COUNT(*)
       FROM  MO_MOTIVE  m,
             ldc_proyecto_constructora lpc,
             pr_product p
       WHERE M.PACKAGE_ID = lpc.id_solicitud
          AND lpc.id_proyecto = inuProyecto
          AND p.product_id = m.product_id
          AND p.product_type_id = 7014;

        CURSOR cuObtValor IS
          SELECT (NVL(SUM(decode(isbOpcion,'CO', v.valor_costo, v.valor)),0)/nuCantUnit) valor
            FROM ldc_valor_adicional_proy v
           WHERE v.id_proyecto = inuProyecto ;

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        OPEN cuCantUnidadesAct;
        FETCH cuCantUnidadesAct INTO nuCantUnit;
        CLOSE cuCantUnidadesAct;

        IF (nuCantUnit = 0)THEN
          nuCantUnit := 1;
        END IF;

        OPEN cuObtValor;
        FETCH cuObtValor INTO nuValor;
        CLOSE cuObtValor;

        nuValor := NVL(nuValor,0);

        RETURN nuValor;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR;
            RETURN 0;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RETURN 0;
    END;

    FUNCTION fnuValor(inuProyecto                    ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                      inuUnidadPredial               ldc_unidad_predial.id_unidad_predial%TYPE, -- Identificador vivienda
                      inuTorre                       ldc_unidad_predial.id_torre%TYPE, -- Torre
                      inuPiso                        ldc_unidad_predial.id_piso%TYPE, -- Piso
                      inuTipoTrabajo                 ldc_tipos_trabajo_cot.id_tipo_trabajo%TYPE, -- Tipo de trabajo
                      inuCotizacionDetalladaAprobada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                      isbCostoOCotizado              VARCHAR2 -- Retorna el costo o el valor cotizado
                      ) RETURN NUMBER IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: fnuValorCotizado
        Descripcion:        Valor cotizado para el tipo de trabajo

        Autor    : Sandra Mu?oz
        Fecha    : 17-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        17-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'fnuValorCotizado';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);

        nuValorCotizado NUMBER; -- Valor cotizado

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Busca el valor cotizado para el tipo de trabajo
        BEGIN

            /*SELECT SUM(nvl(decode(isbCostoOCotizado,
                                  'COTIZADO',
                                  lipup.precio_total,
                                  'COSTO',
                                  lipup.costo_total),
                           0))
            INTO   nuValorCotizado
            FROM   ldc_items_por_unid_pred lipup
            WHERE  lipup.id_proyecto = inuProyecto
            AND    lipup.id_cotizacion_detallada = inuCotizacionDetalladaAprobada
            AND    lipup.id_unidad_predial = inuUnidadPredial
            AND    lipup.id_torre = inuTorre
            AND    lipup.id_piso = inuPiso
            AND    lipup.id_tipo_trabajo = inuTipoTrabajo;*/

            SELECT nvl(decode(isbCostoOCotizado,
                          'COTIZADO',
                          lcc.precio_total,
                          'COSTO',
                          lcc.costo),0)
              INTO nuValorCotizado
              FROM ldc_consolid_cotizacion lcc
             WHERE lcc.id_cotizacion_detallada = inuCotizacionDetalladaAprobada
               AND lcc.id_proyecto = inuProyecto
               AND lcc.id_tipo_trabajo = inuTipoTrabajo;

        EXCEPTION
            WHEN no_data_found THEN
                nuValorCotizado := 0;
        END;

        RETURN nuValorCotizado;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR;
            RETURN 0;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RETURN 0;
    END;

    FUNCTION fnuValorLegalizado(inuProyecto                    ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                inuCotizacionDetalladaAprobada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion detallada aprobada
                                inuTipoTrabajo                 ldc_tipos_trabajo_cot.id_tipo_trabajo%TYPE, -- Tipo de trabajo
                                inuProducto                    pr_product.product_id%TYPE -- Producto
                                ) RETURN NUMBER IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: fnuValorLegalizado
        Descripcion:        Valor legalizado para el tipo de trabajo para la unidad predial

        Autor    : Sandra Mu?oz
        Fecha    : 17-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        17-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso         VARCHAR2(4000) := 'fnuValorLegalizado';
        nuPaso            NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError           VARCHAR2(4000);
        nuValorLegalizado NUMBER := 0; -- Valor cotizado
        sbOTCerrada       ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('ESTADO_CERRADO');

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Busca el valor cotizado para el tipo de trabajo
        SELECT  nvl(SUM(nvl(oo.value, 0)),0)
          INTO  nuValorLegalizado
          FROM  or_order_items oo, or_order o
         WHERE  o.order_id = oo.order_id
           AND  oo.order_id IN (SELECT DISTINCT ooa.order_id
                                  FROM or_order_activity ooa
                                 WHERE ooa.product_id = inuProducto
                                   AND ooa.task_type_id = inuTipoTrabajo)
           AND  o.order_status_id = sbOTCerrada;

        RETURN nuValorLegalizado;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR;
            RETURN 0;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RETURN 0;
    END;

    PROCEDURE proPYG(inuProyecto NUMBER, -- Proyecto
                     OCUCURSOR   OUT CONSTANTS.TYREFCURSOR -- Informacion del cargo
                     ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proPYG
        Descripcion:        Muestra el estado de perdidas y ganancias por cada apartamento

        Autor    : Sandra Mu?oz
        Fecha    : 17-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        17-06-2016   Sandra Mu?oz           Creacion
        31/01/2019   LJLB                   CA 274 se quita filtro de tipo de producto de gas
        ******************************************************************/

        sbProceso                      VARCHAR2(4000) := 'proPYG';
        nuPaso                         NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError                        VARCHAR2(4000); -- Error
        sbSQL                          VARCHAR2(10000); -- Sql a ejecutar
        sbSelect                       VARCHAR2(10000); -- Campos
        sbFrom                         VARCHAR2(4000); -- Tablas
        sbWhere                        VARCHAR2(4000); -- Union de tablas
        sbCondicion                    VARCHAR2(4000); -- Filtro
        sbOrder                        VARCHAR2(4000); -- Ordenamiento
        nuProductoGas                  ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS'); -- Producto de gas
        sbValorCostoInterna            VARCHAR2(4000); -- Valor costo para interna
        sbValorCostoCargoXConexion     VARCHAR2(4000); -- Valor costo para cargo por conexion
        sbValorCostoCertificacion      VARCHAR2(4000); -- Valor costo para certificacion
        sbValorCotizadoInterna         VARCHAR2(4000); -- Valor cotizado para interna
        sbValorCotizadoCargoXConexion  VARCHAR2(4000); -- Valor cotizado para cargo por conexion
        sbValorCotizadoCertificacion   VARCHAR2(4000); -- Valor cotizado para certificacion
        sbValorLegalizadoInterna       VARCHAR2(4000); -- Valor legalizado para interna
        sbValorLegalizadoCargoXConexio VARCHAR2(4000); -- Valor legalizado para cargo por conexion
        sbValorLegalizadoCertificacion VARCHAR2(4000); -- Valor legalizado para certificacion
        nuCotizacionDetalladaAprobada  ldc_cotizacion_construct.id_cotizacion_detallada%TYPE; -- Cotizacion detallada aprobada
        nuTipoTrabajoInterna           ldc_tipos_trabajo_cot.id_tipo_trabajo%TYPE; -- Tipo de trabajo de interna
        nuTipoTrabajoCargoXConexion    ldc_tipos_trabajo_cot.id_tipo_trabajo%TYPE; -- Tipo de trabajo de cargo por conexion
        nuTipoTrabajoCertificacion     ldc_tipos_trabajo_cot.id_tipo_trabajo%TYPE; -- Tipo de trabajo de certificacion
        nuCostoAdicional               ldc_valor_adicional_proy.valor_costo%TYPE; --Costo por valor adicional
        nuValorAdicional               ldc_valor_adicional_proy.valor%TYPE; --Valor adicional
        exError EXCEPTION; -- Error controlado
        nuSolicitud                    mo_packages.package_id%TYPE;

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Identifica la cotizacion detallada aprobada para el proyecto
        BEGIN
            ldc_bccotizacionconstructora.proCotizacionDetalladaAprobada(inuProyecto            => inuProyecto,
                                                                        onuCotizacionDetallada => nuCotizacionDetalladaAprobada);
        EXCEPTION
            WHEN OTHERS THEN
                nuCotizacionDetalladaAprobada := NULL;
        END;

        nuSolicitud:= daldc_proyecto_constructora.fnuGetID_SOLICITUD(inuProyecto, 0);

        -- Obtener el tipo de trabajo de interna
        IF ldc_boCotizacionConstructora.csbTipoTrabajoInterna IS NOT NULL THEN
            BEGIN
                SELECT lttc.id_tipo_trabajo
                INTO   nuTipoTrabajoInterna
                FROM   ldc_tipos_trabajo_cot lttc
                WHERE  lttc.id_cotizacion_detallada = nuCotizacionDetalladaAprobada
                AND    lttc.id_proyecto = inuProyecto
                AND    lttc.tipo_trabajo_desc = ldc_boCotizacionConstructora.csbTipoTrabajoInterna;
            EXCEPTION
                WHEN no_data_found THEN
                    NULL;
            END;
        END IF;

        dbms_output.put_line('nuTipoTrabajoInterna ' || nuTipoTrabajoInterna);

        -- Obtener el tipo de trabajo de cargo por conexion
        IF ldc_boCotizacionConstructora.csbTipoTrabajoCargoXConexion IS NOT NULL THEN
            BEGIN
                SELECT lttc.id_tipo_trabajo
                INTO   nuTipoTrabajoCargoXConexion
                FROM   ldc_tipos_trabajo_cot lttc
                WHERE  lttc.id_cotizacion_detallada = nuCotizacionDetalladaAprobada
                AND    lttc.id_proyecto = inuProyecto
                AND    lttc.tipo_trabajo_desc =
                       ldc_boCotizacionConstructora.csbTipoTrabajoCargoXConexion;
            EXCEPTION
                WHEN no_data_found THEN
                    NULL;
            END;
        END IF;

        dbms_output.put_line('nuTipoTrabajoCargoXConexion ' || nuTipoTrabajoCargoXConexion);

        -- Obtener el tipo de trabajo de certificacion
        IF ldc_boCotizacionConstructora.csbTipoTrabajoCertificacion IS NOT NULL THEN
            BEGIN
                SELECT lttc.id_tipo_trabajo
                INTO   nuTipoTrabajoCertificacion
                FROM   ldc_tipos_trabajo_cot lttc
                WHERE  lttc.id_cotizacion_detallada = nuCotizacionDetalladaAprobada
                AND    lttc.id_proyecto = inuProyecto
                AND    lttc.tipo_trabajo_desc =
                       ldc_boCotizacionConstructora.csbTipoTrabajoCertificacion;
            EXCEPTION
                WHEN no_data_found THEN
                    NULL;
            END;
        END IF;

        dbms_output.put_line('nuTipoTrabajoCertificacion ' || nuTipoTrabajoCertificacion);

        -- Construye la consulta
        sbValorCostoInterna := '''$''||to_char(ldc_BOPIConstructora.fnuValor(inuproyecto => lpc.id_proyecto,
                                                              inuunidadpredial => NULL/*leup.id_unidad_predial */ ,
                                                              inuCotizacionDetalladaAprobada => nvl(:nuCotizacionDetalladaAprobada, -1),
                                                              inuTipoTrabajo => nvl(:nuTipoTrabajoInterna, -1),
                                                              isbcostoocotizado => ''COSTO'',

                                                              inutorre => NULL/*leup.id_torre*/ ,
                                                              inupiso => NULL/*leup.id_piso*/),''FM999,999,990.00'')';

        sbValorCostoCargoXConexion := '''$''||to_char(ldc_BOPIConstructora.fnuValor(inuProyecto => lpc.id_proyecto,
                                                                     inuunidadpredial => NULL/*leup.id_unidad_predial */ ,
                                                                     inuCotizacionDetalladaAprobada => nvl(:nuCotizacionDetalladaAprobada, -1),
                                                                     inuTipoTrabajo => nvl(:nuTipoTrabajoCargoXConexion, -1),
                                                                     isbCostoOCotizado => ''COSTO'',

                                                                     inutorre =>NULL/*leup.id_torre*/ ,
                                                                     inupiso => NULL/*leup.id_piso*/),''FM999,999,990.00'')';

        sbValorCostoCertificacion := '''$''||to_char(ldc_BOPIConstructora.fnuValor(inuproyecto => lpc.id_proyecto,
                                                              inuunidadpredial => NULL/*leup.id_unidad_predial */ ,
                                                              inuCotizacionDetalladaAprobada => nvl(:nuCotizacionDetalladaAprobada, -1),
                                                              inuTipoTrabajo => nvl(:nuTipoTrabajoCertificacion, -1),
                                                              isbcostoocotizado => ''COSTO'',

                                                              inutorre =>NULL/*leup.id_torre*/ ,
                                                              inupiso => NULL/*leup.id_piso*/),''FM999,999,990.00'')';

        sbValorCotizadoInterna := '''$''||to_char(ldc_BOPIConstructora.fnuValor(inuProyecto => lpc.id_proyecto,
                                                                 inuunidadpredial => NULL/*leup.id_unidad_predial */ ,
                                                                 inuCotizacionDetalladaAprobada => nvl(:nuCotizacionDetalladaAprobada, -1),
                                                                 inuTipoTrabajo => nvl(:nuTipoTrabajoInterna,-1),
                                                                 isbCostoOCotizado => ''COTIZADO'',

                                                                 inutorre => NULL/*leup.id_torre*/ ,
                                                                 inupiso => NULL/*leup.id_piso*/),''FM999,999,990.00'')';

        sbValorCotizadoCargoXConexion := '''$''||to_char(ldc_BOPIConstructora.fnuValor(inuProyecto => lpc.id_proyecto,
                                                                       inuunidadpredial => NULL/*leup.id_unidad_predial */,
                                                                       inuCotizacionDetalladaAprobada => nvl(:nuCotizacionDetalladaAprobada, -1),
                                                                       inuTipoTrabajo => nvl(:nuTipoTrabajoCargoXConexion, -1),
                                                                       isbCostoOCotizado => ''COTIZADO'',

                                                                       inutorre => NULL/*leup.id_torre*/,
                                                                       inupiso => NULL/*leup.id_piso*/),''FM999,999,990.00'')';

        sbValorCotizadoCertificacion := '''$''||to_char(ldc_BOPIConstructora.fnuValor(inuProyecto => lpc.id_proyecto,
                                                                      inuunidadpredial => NULL/*leup.id_unidad_predial */,
                                                                      inuCotizacionDetalladaAprobada => nvl(:nuCotizacionDetalladaAprobada, -1),
                                                                      inuTipoTrabajo => nvl(:nuTipoTrabajoCertificacion, -1),
                                                                      isbCostoOCotizado => ''COTIZADO'',

                                                                      inutorre => NULL/*leup.id_torre*/ ,
                                                                      inupiso => NULL/*leup.id_piso*/),''FM999,999,990.00'')';

        sbValorLegalizadoInterna := '''$''||to_char(ldc_BOPIConstructora.fnuValorLegalizado(inuProyecto => lpc.id_proyecto,
                                                                            inuCotizacionDetalladaAprobada => nvl(:nuCotizacionDetalladaAprobada, -1),
                                                                            inuTipoTrabajo => nvl(:nuTipoTrabajoInterna, -1),
                                                                            inuProducto => pp.product_id),''FM999,999,990.00'')';

        sbValorLegalizadoCargoXConexio := '''$''||to_char(ldc_BOPIConstructora.fnuValorLegalizado(inuProyecto => lpc.id_proyecto,
                                                                               inuCotizacionDetalladaAprobada => nvl(:nuCotizacionDetalladaAprobada, -1),
                                                                               inuTipoTrabajo => nvl(:nuTipoTrabajoCargoXConexion, -1),
                                                                               inuProducto => pp.product_id),''FM999,999,990.00'')';

        sbValorLegalizadoCertificacion := '''$''||to_char(ldc_BOPIConstructora.fnuValorLegalizado(inuProyecto => lpc.id_proyecto,
                                                                              inuCotizacionDetalladaAprobada => nvl(:nuCotizacionDetalladaAprobada, -1),
                                                                              inuTipoTrabajo => nvl(:nuTipoTrabajoCertificacion, -1),
                                                                              inuProducto => pp.product_id),''FM999,999,990.00'')';
        nuValorAdicional := fnuValorAdicional(inuProyecto => inuProyecto,
                                              isbOpcion => 'VA');

        nuCostoAdicional := fnuValorAdicional(inuProyecto => inuProyecto,
                                              isbOpcion => 'CO');

        sbSelect := ' lpc.id_proyecto parent_id,
                      pp.product_id producto,
                              aa.address_parsed direccion_producto,
                              ' || sbValorCostoCargoXConexion ||
                    ' cargoXconexion_costo,
                              ' || sbValorCotizadoCargoXConexion ||
                    ' cargoXconexion_cotizado,
                              ' || sbValorLegalizadoCargoXConexio ||
                    ' cargoXconexion_legalizado,
                              ' || sbValorCostoInterna ||
                    ' interna_costo,
                               ''$''||to_char(' || nuCostoAdicional ||
                    ',''FM999,999,990.00'') costo_adicional_interna,
                               ' || sbValorCotizadoInterna ||
                    ' interna_cotizado,
                               ''$''||to_char(' || nuValorAdicional ||
                    ',''FM999,999,990.00'') valor_adicional_interna,
                              ' || sbValorLegalizadoInterna ||
                    ' interna_legalizado,
                              ' || sbValorCostoCertificacion ||
                    ' certificacion_costo,
                              ' || sbValorCotizadoCertificacion ||
                    ' certificacion_cotizado,
                              ' || sbValorLegalizadoCertificacion ||
                    ' certificacion_legalizado';


        /*sbFrom := 'ab_address                aa,
                              pr_product                pp,
                              ldc_equival_unid_pred     leup,
                              ldc_proyecto_constructora lpc';*/
        sbFrom := 'ab_address                aa,
                              pr_product                pp,
                              MO_MOTIVE     m,
                              ldc_proyecto_constructora lpc';


        /*sbWhere := 'aa.address_id = pp.address_id
                  AND        lpc.id_proyecto = leup.id_proyecto
                  AND        leup.id_direccion (+)= pp.address_id
                  AND        leup.activa = ''S''';*/
        sbWhere := 'aa.address_id = pp.address_id
                  AND        m.package_id = lpc.ID_SOLICITUD
                  AND        pp.product_id = m.product_id
                  ';
       --inicio ca 274
        /*sbCondicion := 'pp.product_type_id = :nuProductoGas
                 AND    lpc.id_proyecto = nvl(:inuProyecto, -1)
                 AND    lpc.id_solicitud = nvl(:nuSolicitud,-1) ';*/

           sbCondicion := ' lpc.id_proyecto = nvl(:inuProyecto, -1)
           AND    lpc.id_solicitud = nvl(:nuSolicitud,-1)';

        sbOrder := 'aa.address_parsed ';

        sbSQL := '
                  SELECT    ' || sbSelect || '
                  FROM      ' || sbFrom || '
                  WHERE     ' || sbWhere || '
                  AND       ' || sbCondicion || '
                  oRDER  BY ' || sbOrder;

        ut_trace.trace(sbSQL,10);
        dbms_output.put_line(sbSQL);

        OPEN OCUCURSOR FOR sbSql
            USING nuCotizacionDetalladaAprobada, nuTipoTrabajoCargoXConexion, nuCotizacionDetalladaAprobada, nuTipoTrabajoCargoXConexion, nuCotizacionDetalladaAprobada, nuTipoTrabajoCargoXConexion, nuCotizacionDetalladaAprobada, nuTipoTrabajoInterna, nuCotizacionDetalladaAprobada, nuTipoTrabajoInterna, nuCotizacionDetalladaAprobada, nuTipoTrabajoInterna, nuCotizacionDetalladaAprobada, nuTipoTrabajoCertificacion, nuCotizacionDetalladaAprobada, nuTipoTrabajoCertificacion, nuCotizacionDetalladaAprobada, nuTipoTrabajoCertificacion, /*nuProductoGas,*/ inuProyecto,nuSolicitud;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proInfoCartera(inuProyecto NUMBER, -- Proyecto
                             ocucursor   OUT CONSTANTS.TYREFCURSOR -- Informacion de cartera
                             ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proInfoCartera
        Descripcion:        Muestra la informacion de cartera de un proyecto constructora

        Autor    : KCienfuegos
        Fecha    : 14-10-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        14-10-2016   KCienfuegos           Creacion
        ******************************************************************/

        sbProceso                      VARCHAR2(4000) := 'proInfoCartera';
        nuPaso                         NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError                        VARCHAR2(4000); -- Error
        sbSQL                          VARCHAR2(10000); -- Sql a ejecutar
        sbSelect                       VARCHAR2(10000); -- Campos
        sbFrom                         VARCHAR2(4000); -- Tablas
        sbWhere                        VARCHAR2(4000); -- Union de tablas
        sbCondicion                    VARCHAR2(4000); -- Filtro
        sbOrder                        VARCHAR2(4000); -- Ordenamiento
        nuSuscripcion                  suscripc.susccodi%TYPE;
        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        --inuProyecto := nvl(inuProyecto,-1);

        nuSuscripcion := daldc_proyecto_constructora.fnuGetSUSCRIPCION(inuProyecto,0);

        nuSuscripcion := nvl(nuSuscripcion,-1);

        sbSelect := '(''$''||to_char(nvl((daldc_proyecto_constructora.fnuGetVALOR_FINAL_APROB(:inuProyecto,0)),0),''FM999,999,990.00'')) valor_venta,
                    (SELECT ''$''||to_char(sum(cupovalo),''FM999,999,990.00'')
                        FROM cupon
                       WHERE cuposusc = :nuSuscripcion
                         AND cupoflpa = ''S'') total_pagos,
                     (SELECT ''$''||to_char(SUM(nvl(difesape, 0)),''FM999,999,990.00'')
                        FROM diferido
                       WHERE difesusc = :nuSuscripcion) cartera_diferida,
                     (SELECT ''$''||to_char(SUM(nvl(cucosacu, 0)),''FM999,999,990.00'')
                      FROM cuencobr, servsusc
                     WHERE cuconuse = sesunuse
                       AND sesususc = :nuSuscripcion
                       and cucosacu > 0) cartera_corriente,
                     (SELECT ''$''||to_char(SUM(nvl(cucosacu, 0)),''FM999,999,990.00'')
                        FROM cuencobr, servsusc
                       WHERE cuconuse = sesunuse
                         AND sesususc = :nuSuscripcion
                         AND cucosacu > 0
                         AND cucofeve < sysdate) cartera_corr_vencida,
                     (SELECT COUNT(*)
                        FROM cuencobr, servsusc
                       WHERE cuconuse = sesunuse
                         AND sesususc = :nuSuscripcion
                         AND cucosacu > 0
                         AND cucofeve < sysdate) cuentas_vencidas,
                         :nuSuscripcion contrato,
                         :inuProyecto  parent_id ';

        sbFrom := 'dual';

        sbSQL := '
                  SELECT    ' || sbSelect || '
                  FROM      ' || sbFrom;

        ut_trace.trace(sbSQL,10);
        dbms_output.put_line(sbSQL);

        OPEN OCUCURSOR FOR sbSql
            USING inuProyecto, nuSuscripcion, nuSuscripcion, nuSuscripcion, nuSuscripcion, nuSuscripcion ,nuSuscripcion, inuProyecto;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

  PROCEDURE fillCamposSolicitud
IS

sbTipoSolicitud           VARCHAR2(300);

sbEstadoSoli         VARCHAR2(300);
sbMedioRecepcion         VARCHAR2(300);
sbVendedor                VARCHAR2(300);
sbbarrios         VARCHAR2(300);
sbClientes            VARCHAR2(300);
sbTelefono    VARCHAR2(300);


sbAreaOrga        VARCHAR2(300);
sbAreaOrgaMan       VARCHAR2(300);
sbPuntoAtencion           VARCHAR2(300);
sbCampania              VARCHAR2(300);


sbRespuesta            VARCHAR2(300);
sbModoReferencia             VARCHAR2(300);
sbContacto               VARCHAR2(300);


sbFormaTipo              VARCHAR2(300);
SBFORM                  VARCHAR2(300);


sbDireccion               VARCHAR2(300);
sbLocalizacion        VARCHAR2(300);
sbDireccionBar       VARCHAR2(300);


sbDetalleCambio         VARCHAR2(300);


sbMetodoLiquida     VARCHAR2(300);

BEGIN

   -- CC_BOOSSPACKAGEDATA.INIT;
   IF SBPACKAGEATTRIBUTES IS NOT NULL THEN
     RETURN;
   END IF;
    sbClientes        := 'a.subscriber_id'      || CC_BOBOSSUTIL.CSBSEPARATOR || 'r.subscriber_name||'' ''||r.subs_last_name';
    sbTipoSolicitud       := 'a.package_type_id'    || CC_BOBOSSUTIL.CSBSEPARATOR || 'b.description';
    sbEstadoSoli     := 'a.motive_status_id'   || CC_BOBOSSUTIL.CSBSEPARATOR || 'c.description';
    sbMedioRecepcion     := 'a.reception_type_id'  || CC_BOBOSSUTIL.CSBSEPARATOR || 'e.description';
    sbVendedor            := 'a.person_id'          || CC_BOBOSSUTIL.CSBSEPARATOR || 'f.name_';
    sbAreaOrga    := 'a.organizat_area_id'  || CC_BOBOSSUTIL.CSBSEPARATOR || 'g.display_description';
    sbAreaOrgaMan   := 'a.management_area_id' || CC_BOBOSSUTIL.CSBSEPARATOR || 't.display_description';
    sbPuntoAtencion       := 'a.POS_Oper_Unit_Id'   || CC_BOBOSSUTIL.CSBSEPARATOR || 'k.name';
    sbCampania          := 'a.Project_Id'         || CC_BOBOSSUTIL.CSBSEPARATOR || 'l.project_description';

    sbbarrios     := 'u.geograp_location_id'|| CC_BOBOSSUTIL.CSBSEPARATOR || 'u.description';

    sbDireccion           := 'S.ADDRESS';
    sbLocalizacion    := '(SELECT LOC.DESCRIPTION FROM ge_geogra_location LOC WHERE S.geograp_location_id = LOC.geograp_location_id )';
    --sbDireccionBar   := 'cc_boOssPackageData.fsbDireccionNeighbor(a.package_id)';

  --  sbDetalleCambio     := 'cc_boOssPackageData.fsbGetPackChanDetail(a.package_id, a.package_type_id)';


    sbRespuesta        := 'a.answer_mode_id'     || CC_BOBOSSUTIL.CSBSEPARATOR || 'm.description';
    sbModoReferencia         := 'a.refer_mode_id'      || CC_BOBOSSUTIL.CSBSEPARATOR || 'n.description';
    sbContacto           := 'a.contact_id'         || CC_BOBOSSUTIL.CSBSEPARATOR || 'o.subscriber_name||'' ''||o.subs_last_name';
    sbFormaTipo          := 'a.document_type_id'   || CC_BOBOSSUTIL.CSBSEPARATOR || 'q.ticodesc';

    sbMetodoLiquida := 'decode(a.liquidation_method, null, b.liquidation_method, a.liquidation_method)'
                           || CC_BOBOSSUTIL.CSBSEPARATOR ||
                           ' cc_boquotationutil.fsbGetLiquidMethod(decode(a.liquidation_method, null, b.liquidation_method, a.liquidation_method))';


     CC_BOBOSSUTIL.ADDATTRIBUTE ('m1.SUBSCRIPTION_ID',              'SUBSCRIPTION_ID',               SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('m1.PRODUCT_ID',              'PRODUCT_ID',               SBPACKAGEATTRIBUTES);

    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.package_id',              'package_id',               SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (sbClientes,                'subscriber',               SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (sbTipoSolicitud,               'package_type',             SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.package_type_id',         'package_type_id',          SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.request_date',            'request_date',             SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.Expect_Atten_Date',       'Expect_Atten_Date',        SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (sbEstadoSoli,             'package_status',           SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.user_id',                 'user_id',                  SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.attention_date',          'attention_date',           SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.comment_',                'comment_',                 SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (sbMedioRecepcion,             'reception_type',           SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (sbVendedor,                    'vendor',                   SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (sbAreaOrga,            'organizat_area_id',        SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (sbAreaOrgaMan,           'management_area',          SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.number_of_prod',          'number_of_prod',           SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('s.address_parsed',          'client_address',           SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (sbbarrios,             'client_neighborthood',     SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('o.phone',                   'contact_phone_number',     SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.cust_care_reques_num',    'cust_care_reques_num',     SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (sbPuntoAtencion,               'POS_Oper_Unit_Id',         SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (sbCampania,                  'Project_Id',               SBPACKAGEATTRIBUTES);

    CC_BOBOSSUTIL.ADDATTRIBUTE (sbDireccion,                   'address',                  SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (sbLocalizacion,            'add_geo_loc_id',           SBPACKAGEATTRIBUTES);
   -- CC_BOBOSSUTIL.ADDATTRIBUTE (sbDireccionBar,           'add_neighbor_id',          SBPACKAGEATTRIBUTES);

 --   CC_BOBOSSUTIL.ADDATTRIBUTE (sbDetalleCambio,             'change_detail',            SBPACKAGEATTRIBUTES);

    CC_BOBOSSUTIL.ADDATTRIBUTE (sbRespuesta,                'answer_mode',              SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (sbModoReferencia,                 'refer_mode',               SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (sbContacto,                   'contact',                  SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('p.address_parsed',          'answer_address',           SBPACKAGEATTRIBUTES);

    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.document_key',            'form_number',              SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (sbFormaTipo,                  'form_type',                SBPACKAGEATTRIBUTES);

    CC_BOBOSSUTIL.ADDATTRIBUTE (sbMetodoLiquida,         'liquidation_method',       SBPACKAGEATTRIBUTES);

    CC_BOBOSSUTIL.ADDATTRIBUTE ('py.id_proyecto',                'parent_id',                SBPACKAGEATTRIBUTES);

    sbFromSolici   :=  'mo_packages a, ps_package_type b, ps_motive_status c,'  ||CHR(10)||
                        'ge_reception_type e, ge_person f, ge_organizat_area g,' ||CHR(10)||
                        'or_operating_unit k, pm_project l, cc_answer_mode m,'   ||CHR(10)||
                        'cc_refer_mode n, ge_subscriber o, ab_Address p,'        ||CHR(10)||
                        'tipocomp q, ge_subscriber r, ab_address s,'             ||CHR(10)||
                        'ge_organizat_area t, ge_geogra_location u,'  ||CHR(10)||
                        'LDC_PROYSOLES py, mo_motive m1';

    sbWhereSolici  :=  'a.package_id = py.PACKAGE_ID' ||CHR(10)||
                        'AND m1.package_id = a.package_id' ||CHR(10)||
                        'AND a.package_type_id = b.package_type_id'              ||CHR(10)||
                        'AND a.motive_status_id = c.motive_status_id'        ||CHR(10)||
                        'AND a.reception_type_id = e.reception_type_id (+)'  ||CHR(10)||
                        'AND a.person_id = f.person_id (+)'                  ||CHR(10)||
                        'AND a.organizat_area_id = g.organizat_area_id (+)'  ||CHR(10)||
                        'AND a.management_area_id = t.organizat_area_id (+)' ||CHR(10)||
                        'AND a.subscriber_id = r.subscriber_id (+)'          ||CHR(10)||
                        'AND r.address_id = s.address_id (+)'                ||CHR(10)||
                        'AND s.neighborthood_id = u.geograp_location_id (+)' ||CHR(10)||
                        'AND a.POS_Oper_Unit_Id = k.operating_unit_id (+)'   ||CHR(10)||
                        'AND a.Project_Id = l.Project_Id (+)'                ||CHR(10)||
                        'AND a.answer_mode_id = m.answer_mode_id (+)'        ||CHR(10)||
                        'AND a.refer_mode_id = n.refer_mode_id (+)'          ||CHR(10)||
                        'AND a.contact_id = o.subscriber_id (+)'             ||CHR(10)||
                        'AND a.address_id = p.address_id (+)'                ||CHR(10)||
                        'AND a.document_type_id = q.ticocodi (+)';


EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END fillCamposSolicitud;


    PROCEDURE PROOBTSOLIPORPROYE(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                    ocuDatos    OUT CONSTANTS.TYREFCURSOR -- Cursor
                                    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: PROOBTSOLIPORPROYE
        Descripcion:        Obtiene la informacion los solicitudes 100354 por proyecto

        Autor    : Josh Brito
        Fecha    : 18/10/2018

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        18/10/2018   Josh Brito             Creacion
        ******************************************************************/

        sbProceso       VARCHAR2(4000) := 'PROOBTSOLIPORPROYE';
        nuPaso          NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError         VARCHAR2(4000);
        sbCondicion     VARCHAR2(4000);
        sbSentencia     VARCHAR2(4000);
        sbCamposCupones VARCHAR(4000);
        nuContrato      NUMBER(8);

        sbHintSolici    VARCHAR2(6000);

		sbcontrato  VARCHAR2(100);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        BEGIN
            nuContrato := ldc_BOPIConstructora.fsbSuscripcion(inuProyecto);
        EXCEPTION
            WHEN OTHERS THEN
                nuContrato := NULL;
        END;

        fillCamposSolicitud;

	       sbHintSolici :=  '/*+ leading (mo_motive) use_nl(mo_motive a)'                        ||CHR(10)||
                            'use_nl(a b) use_nl(a c) use_nl(a e) use_nl(a f)'                   ||CHR(10)||
                            'use_nl(a g) use_nl(a r) use_nl(r s) use_nl(a k)'                   ||CHR(10)||
                            'use_nl(a l) use_nl(a m) use_nl(a n) use_nl(a o)'                   ||CHR(10)||
                            'use_nl(a p) use_nl(a q) use_nl(s u)' ||CHR(10)||
                            'index (mo_motive IDX_MO_MOTIVE_03) index (a PK_MO_PACKAGES)'       ||CHR(10)||
                            'index (f PK_GE_PERSON) index (g PK_GE_ORGANIZAT_AREA)'             ||CHR(10)||
                            'index (r PK_GE_SUBSCRIBER) index (s PK_AB_ADDRESS)'                ||CHR(10)||
                            'index (k PK_OR_OPERATING_UNIT) index (l PK_PM_PROJECT)'            ||CHR(10)||
                            'index (o PK_GE_SUBSCRIBER) index (p PK_AB_ADDRESS) index (u PK_GE_GEOGRA_LOCATION)*/';

       /* sbCamposCupones := 'a.cuponume as cuponume,
                            a.cupotipo as cupotipo,
                            a.cupodocu as cupodocu,
                            ''$''||to_char( nvl(a.cupovalo,0),''FM999,999,990.00'') as cupovalo,
                            a.cupofech as cupofech,
                            a.cupoprog as cupoprog,
                            a.cupocupa as cupocupa,
                            a.cuposusc as cuposusc,
                            decode(a.cupoflpa,''S'',''Si'',''N'',''No'') as cupoflpa,
                            b.id_proyecto as parent_id';*/

       /* -- Aplicar los filtros
        sbCondicion := 'a.PACKAGE_ID = MO_MOTIVE.PACKAGE_ID
                        AND MO_MOTIVE.SUBSCRIPTION_ID = b.SUSCRIPCION
                        AND a.PACKAGE_TYPE_ID = 100354
                        and MO_MOTIVE.SUBSCRIPTION_ID = ' || 'nvl(:nuContrato,-1)';*/

        -- Construir la sentencia
        sbSentencia := 'SELECT '|| sbHintSolici                                             ||CHR(10)||
                                   SBPACKAGEATTRIBUTES                        ||CHR(10)||
                       'FROM '  || sbFromSolici ||CHR(10)||
                	      'WHERE '||sbWhereSolici  ||CHR(10)||
                        ' AND PY.id_proyecto = nvl(:inuProyecto, -1) ' ||CHR(10)||
                 'order by 1 desc';



        /*'SELECT ' || sbCamposCupones || '
                        FROM   MO_PACKAGES a,
                               MO_MOTIVE,
                               LDC_PROYECTO_CONSTRUCTORA b
                        WHERE  ' || sbCondicion || '
                        ORDER BY 1';*/

        ut_trace.trace(sbSentencia);
        dbms_output.put_line(sbSentencia);

        OPEN ocuDatos FOR sbSentencia
            using inuProyecto;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proPlantilla(nuDato NUMBER) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:
        Descripcion:

        Autor    : Sandra Mu?oz
        Fecha    : 31-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proPlantilla';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => gnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    FUNCTION LDC_FNUCOSTOTALEGA (inuProyecto                    ldc_proyecto_constructora.id_proyecto%TYPE -- Proyecto

                                 ) RETURN NUMBER IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: LDC_FNUCOSTOTALEGA
        Descripcion:        Valor legalizado para las  unidad predial

        Autor    : Elkin alvarez
        Fecha    : 26-11-2018

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------

        ******************************************************************/

        sbProceso         VARCHAR2(4000) := 'LDC_FNUCOSTOTALEGA';
        nuPaso            NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError           VARCHAR2(4000);
        nuValorLegalizado NUMBER := 0; -- Valor cotizado
        sbOTCerrada       ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('ESTADO_CERRADO');

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        SELECT  nvl(SUM(nvl(oo.value, 0)),0) INTO  nuValorLegalizado
          FROM  or_order_items oo, or_order o
          WHERE  o.order_id = oo.order_id
          AND  oo.order_id IN (SELECT DISTINCT ooa.order_id
                              FROM or_order_activity ooa
                             WHERE ooa.product_id IN (SELECT m.product_id
                                                        FROM ldc_proyecto_constructora p, ldc_cotizacion_construct lcc, mo_motive m, pr_product pp--, ldc_equival_unid_pred leup
                                                        WHERE lcc.estado IN   ('A', 'P')
                                                          and lcc.ID_PROYECTO = inuProyecto
                                                         AND lcc.id_proyecto = p.id_proyecto
                                                         and m.package_id = P.ID_SOLICITUD
                                                         AND pp.product_id = m.product_id
                                                         AND pp.product_type_id = 7014
                                                       /*

                                                   SELECT pp.product_id
                                                        FROM ldc_cotizacion_construct lcc, pr_product pp, ldc_equival_unid_pred leup
                                                        where lcc.estado IN   ('A', 'P')
                                                          and lcc.ID_PROYECTO = inuProyecto
                                                          AND lcc.id_proyecto = leup.id_proyecto
                                                          AND leup.id_direccion (+)= pp.address_id

                                                          AND leup.activa = 'S'*/)
                               )
          AND  o.order_status_id = sbOTCerrada;


        RETURN nuValorLegalizado;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR;
            RETURN 0;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RETURN 0;
    END;

     FUNCTION LDC_FNUCALUTILPROY (inuProyecto   ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                  inuValorAprobado  IN NUMBER) RETURN NUMBER IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: LDC_FNUCALUTILPROY
        Descripcion:        Calcula valor de la utilidad

        Autor    : Elkin alvarez
        Fecha    : 26-11-2018

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        ******************************************************************/

      begin

        return (inuValorAprobado+  LDC_FNUGETVALORAPROBADO(inuProyecto)) - LDC_FNUCOSTOTALEGA(inuProyecto);
      EXCEPTION
        WHEN OTHERS THEN
           RETURN 0;
      end LDC_FNUCALUTILPROY;

       FUNCTION LDC_FNUCALMARGPROY (inuProyecto                    ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                    inuValorAprobado IN NUMBER) RETURN NUMBER IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: LDC_FNUCALMARGPROY
        Descripcion:        Calcula valor del margen

        Autor    : Elkin alvarez
        Fecha    : 26-11-2018

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
         ******************************************************************/
    BEGIN
         IF (NVL(inuValorAprobado,0) + LDC_FNUGETVALORAPROBADO(inuProyecto)) > 0 THEN
           RETURN ROUND((LDC_FNUCALUTILPROY(inuProyecto,inuValorAprobado) / (NVL(inuValorAprobado,0) + LDC_FNUGETVALORAPROBADO(inuProyecto)) ) *100,0);
         ELSE
           RETURN 0;
         END IF;
    EXCEPTION
        WHEN OTHERS THEN
           RETURN 0;
    END LDC_FNUCALMARGPROY;

    FUNCTION LDC_FNUGETVALORAPROBADO ( inuProyecto   ldc_proyecto_constructora.id_proyecto%TYPE -- Proyecto
                                       ) RETURN NUMBER IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: LDC_FNUGETVALORAPROBADO
        Descripcion:        Calcula valor aprobado del proyecto

        Autor    : Elkin alvarez
        Fecha    : 26-11-2018

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        ******************************************************************/
        nuvalorAdicional NUMBER;
      begin
         SELECT Nvl(sum(nvl(va.VALOR,0)),0) INTO nuvalorAdicional
         from LDC_VALOR_ADICIONAL_PROY va
         WHERE va.ID_PROYECTO = inuProyecto;

        return nuvalorAdicional;
      EXCEPTION
        WHEN OTHERS THEN
           RETURN 0;
      end LDC_FNUGETVALORAPROBADO;

END ldc_BOPIConstructora;
/
PROMPT Otorgando permisos de ejecucion a LDC_BOPICONSTRUCTORA
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BOPICONSTRUCTORA', 'ADM_PERSON');
END;
/