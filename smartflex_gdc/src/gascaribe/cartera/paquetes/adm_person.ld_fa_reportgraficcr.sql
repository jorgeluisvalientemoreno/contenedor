CREATE OR REPLACE PACKAGE ADM_PERSON.LD_FA_REPORTGRAFICCR IS
    /*****************************************************************************************************************************
        Propiedad intelectual de Ludycom S.A.

        Unidad         : ld_fa_reportGraficCR
        Descripción    : Componente de negocio que lleva a cabo el proceso para generar el grafico de comportamiento de un suscriptor.
        Autor          : javier.rodriguez.SAOJavier Rodríguez.
        Fecha          : 19/01/2013

       Historia de Modificaciones
       29-07-2013      smunozSAO212458
       Se modifica el procedimiento pbreporte

    ***************************************************************************************************************************/

    /* Variables Globales */
    sbcontrato        suscripc.susccodi%TYPE;
    nuproducto        servsusc.sesunuse%TYPE;
    nudiferido        diferido.difecodi%TYPE;
    csbIdentificacion ge_subscriber.identification%TYPE; -- CA 200-792. Identificación

    FUNCTION getproductreport RETURN NUMBER;

    FUNCTION getdifereport RETURN NUMBER;

    /* Procedimeintos */
    PROCEDURE pbreporte;
    PROCEDURE pbreportedife;
    FUNCTION fsbversion RETURN VARCHAR2;
    FUNCTION fsbIdentificacion RETURN ge_subscriber.identification%TYPE ;
END;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LD_FA_REPORTGRAFICCR IS

    csbversion            CONSTANT VARCHAR2(250) := '212516';
    csbBSS_CAR_SMS_200792 CONSTANT VARCHAR2(40) := 'BSS_CAR_SMS_200792_1';

    /**************************************************************************************************************************************

          Nombre         : PBReporte
          Descripción    : Recibiendo como parámetro un suscriptor ejecuta un Gráfico Guardado.

          Autor          : Ludycom.
          Fecha          : 19/01/2013

          Parámetros     : No hay parámetros

         Historia de Modificaciones
         Fecha           IDEntrega
         20-08-2013      kcienfuegos213004
         Se quita el manejo de parámetros para obtener el mnemónico de la forma

         11-08-2013      kcienfuegosSAO212516
         Se cambia el campo contrato por el campo de producto

         09-08-2013      kcienfuegosSAO213256
         Se quita la obtención del executable_id de la parametrización(ld_general_parameters).

         29-07-2013      smunozSAO212458
         Se obtiene el valor del parámetro SA_EXECUTABLE_GRCSG haciendo uso del procedimiento
         provapatapa
    **************************************************************************************************************************************/
    PROCEDURE pbreporte IS
        /* Variable local Asigacion codigo ejecutable de grafico GR */
        cnuapp_executable_id NUMBER(20);

        /* Parametros Proceso en Batch*/
        cnunull_attribute CONSTANT NUMBER := 2126;
        nuproduct_id ge_boinstancecontrol.stysbvalue;

        /*variable para mensaje de error*/
        gsberrmsg ge_error_log.description%TYPE;

        respuesta ld_general_parameters.text_value%TYPE;

        CURSOR cuExecutable(sbname ld_general_parameters.text_value%TYPE) IS
            SELECT executable_id FROM sa_executable WHERE NAME = upper(sbname);

    BEGIN
        pkerrors.push('ld_fa_reportGraficCR.PBReporte');
        ut_trace.trace('Inicia ld_fa_reportGraficCR.PBReporte', 10);

        /* Obtiene el código del ejecutable del gráfico, debe estar registrado en
        LD_GENERAL_PARAMETERS */
        --provapatapa('FORMA_GRCSG', 'S', cnuapp_executable_id,respuesta);
        respuesta := 'GRCSG';
        OPEN cuExecutable(respuesta);
        FETCH cuExecutable
            INTO cnuapp_executable_id;

        IF cuExecutable%NOTFOUND THEN
            cnuapp_executable_id := -1;
        END IF;
        CLOSE cuExecutable;

        /* Control Proceso en Batch*/
        nuproduct_id := ge_boinstancecontrol.fsbgetfieldvalue('PR_PRODUCT', 'PRODUCT_ID');

        -- INICIO CA 200-792.
        -- Ya no se obligará al ingreso del parámetro de producto
        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------
        IF NOT fblaplicaentrega(csbBSS_CAR_SMS_200792) THEN
            IF (nuproduct_id IS NULL) THEN
                errors.seterror(cnunull_attribute, 'Producto');
                RAISE ex.controlled_error;
            END IF;
        END IF;
        -- FIN CA 200-792.

        /* Variable Global para el criterio del gráfico GR */
        nuproducto := nuproduct_id;

        -- Inicio CA 200-792.
        -- Se lee de pantalla el número de identificación
        csbIdentificacion := ge_boinstancecontrol.fsbgetfieldvalue('GE_SUBSCRIBER',
                                                                   'IDENTIFICATION');
        IF NOT fblaplicaentrega(csbBSS_CAR_SMS_200792) THEN
            IF csbIdentificacion IS NOT NULL THEN
                errors.seterror(2741,
                                'La entrega ' || csbBSS_CAR_SMS_200792 ||
                                ' no se encuentra aplicada, por favor deje el campo "Identificación" en blanco');
                RAISE ex.controlled_error;
            END IF;
        END IF;
        -- Fin CA 200-792.

        /* Ejecuta el Reporte Grafico mediante el codigo */
        ge_boiopenexecutable.setonevent(cnuapp_executable_id, 'POST_REGISTER');

        ut_trace.trace('Fin ld_fa_reportGraficCR.PBReporte', 10);
        pkerrors.pop;
    EXCEPTION
        WHEN ex.controlled_error THEN
            pkerrors.pop;
            RAISE;
        WHEN OTHERS THEN
            pkerrors.notifyerror(pkerrors.fsblastobject, SQLERRM, gsberrmsg);
            pkerrors.pop;
            raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
    END;

    /**************************************************************************************************************************************

          Nombre         : PBReportedife
          Descripción    : Recibiendo como parámetro el código del diferido ejecuta un Gráfico Guardado.

          Autor          : Ludycom.
          Fecha          : 11/08/2013

          Parámetros     : No hay parámetros

         Historia de Modificaciones
         Fecha           IDEntrega

    **************************************************************************************************************************************/
    PROCEDURE pbreportedife IS
        /* Variable local Asigacion codigo ejecutable de grafico GR */
        cnuapp_executable_id NUMBER(20);

        /* Parametros Proceso en Batch*/
        cnunull_attribute CONSTANT NUMBER := 2126;
        nudife_id ge_boinstancecontrol.stysbvalue;

        /*variable para mensaje de error*/
        gsberrmsg ge_error_log.description%TYPE;

        respuesta ld_general_parameters.text_value%TYPE;

        CURSOR cuExecutable(sbname ld_general_parameters.text_value%TYPE) IS
            SELECT executable_id FROM sa_executable WHERE NAME = upper(sbname);

    BEGIN
        pkerrors.push('ld_fa_reportGraficCR.PBReporte');
        ut_trace.trace('Inicia ld_fa_reportGraficCR.PBReporte', 10);

        /* Obtiene el código del ejecutable del gráfico, debe estar registrado en
        LD_GENERAL_PARAMETERS */
        -- provapatapa('FORMA_GRCDG', 'S', cnuapp_executable_id,respuesta);
        respuesta := 'GRCDG';
        OPEN cuExecutable(respuesta);
        FETCH cuExecutable
            INTO cnuapp_executable_id;

        IF cuExecutable%NOTFOUND THEN
            cnuapp_executable_id := -1;
        END IF;
        CLOSE cuExecutable;

        /* Control Proceso en Batch*/
        nudife_id := ge_boinstancecontrol.fsbgetfieldvalue('DIFERIDO', 'DIFECODI');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        IF (nudife_id IS NULL) THEN
            errors.seterror(cnunull_attribute, 'Diferido');
            RAISE ex.controlled_error;
        END IF;

        /* Variable Global para el criterio del gráfico GR */
        nudiferido := nudife_id;

        /* Ejecuta el Reporte Grafico mediante el codigo */
        ge_boiopenexecutable.setonevent(cnuapp_executable_id, 'POST_REGISTER');

        ut_trace.trace('Fin ld_fa_reportGraficCR.PBReporte', 10);
        pkerrors.pop;
    EXCEPTION
        WHEN ex.controlled_error THEN
            pkerrors.pop;
            RAISE;
        WHEN OTHERS THEN
            pkerrors.notifyerror(pkerrors.fsblastobject, SQLERRM, gsberrmsg);
            pkerrors.pop;
            raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
    END;

    /**************************************************************************************************************************************
         Nombre         : GetProductReport
         Descripción    : Retorna el numero de producto obtenido de PBReporte

         Autor          : KCienfuegos
         Fecha          : 11/08/2013

         Parámetros     :

         Nombre Parámetro         Tipo de parámetro        Tipo de dato del parámetro                     Descripción


        Historia de Modificaciones
         Fecha             Autor             Modificación
         =========         =========         ====================
    **************************************************************************************************************************************/
    FUNCTION getproductreport RETURN NUMBER IS

        cnunull_attribute CONSTANT NUMBER := 2126;
        /*variable para mensaje de error*/
        gsberrmsg ge_error_log.description%TYPE;

    BEGIN
        pkerrors.push('ld_fa_reportGraficCR.GetProductReport');

        -- No se retorna dato si la entrega está aplicada
        IF NOT fblaplicaentrega(csbBSS_CAR_SMS_200792) THEN
            /* valida que tenga dato */
            IF (nuproducto IS NULL) THEN
                errors.seterror(cnunull_attribute, 'Producto');
                pkerrors.pop;
                RAISE ex.controlled_error;
            END IF;
        END IF;

        /* Retorna el Numero de contrato digitado en el proceso en Batch */
        pkerrors.pop;
        RETURN nuproducto;

    EXCEPTION
        WHEN ex.controlled_error THEN
            pkerrors.pop;
            RAISE;

        WHEN OTHERS THEN
            pkerrors.notifyerror(pkerrors.fsblastobject, SQLERRM, gsberrmsg);
            pkerrors.pop;
            raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
    END;

    FUNCTION fsbIdentificacion RETURN ge_subscriber.identification%TYPE IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: fsbIdentificacion
        Descripción:        Número de identificación

        Autor    : Sandra Muñoz
        Fecha    : 27-10-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        27-10-2016   Sandra Muñoz           CA 200-792. Creación
        ******************************************************************/

        cnunull_attribute CONSTANT NUMBER := 2126;
        /*variable para mensaje de error*/
        gsberrmsg ge_error_log.description%TYPE;

    BEGIN
        pkerrors.push('ld_fa_reportGraficCR.fsbIdentificacion');

        IF fblaplicaentrega(csbBSS_CAR_SMS_200792) THEN

            /* Retorna el Numero de contrato digitado en el proceso en Batch */
            pkerrors.pop;
            RETURN csbIdentificacion;
        END IF;

        RETURN NULL;

    EXCEPTION
        WHEN ex.controlled_error THEN
            pkerrors.pop;
            RAISE;

        WHEN OTHERS THEN
            pkerrors.notifyerror(pkerrors.fsblastobject, SQLERRM, gsberrmsg);
            pkerrors.pop;
            raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
    END;

    /**************************************************************************************************************************************
         Nombre         : GetDifeReport
         Descripción    : Retorna el numero de diferido obtenido de PBReportedife

         Autor          : KCienfuegos
         Fecha          : 11/08/2013

         Parámetros     :

         Nombre Parámetro         Tipo de parámetro        Tipo de dato del parámetro                     Descripción


        Historia de Modificaciones
         Fecha             Autor             Modificación
         =========         =========         ====================
    **************************************************************************************************************************************/
    FUNCTION getdifereport RETURN NUMBER IS

        cnunull_attribute CONSTANT NUMBER := 2126;
        /*variable para mensaje de error*/
        gsberrmsg ge_error_log.description%TYPE;

    BEGIN
        pkerrors.push('ld_fa_reportGraficCR.GetProductReport');
        /* valida que tenga dato */
        IF (nudiferido IS NULL) THEN
            errors.seterror(cnunull_attribute, 'Diferido');
            pkerrors.pop;
            RAISE ex.controlled_error;
        END IF;

        /* Retorna el Numero de contrato digitado en el proceso en Batch */
        pkerrors.pop;
        RETURN nudiferido;

    EXCEPTION
        WHEN ex.controlled_error THEN
            pkerrors.pop;
            RAISE;

        WHEN OTHERS THEN
            pkerrors.notifyerror(pkerrors.fsblastobject, SQLERRM, gsberrmsg);
            pkerrors.pop;
            raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
    END;

    /****************************************************************************
      Funcion       :  fsbVersion

      Descripcion :  Obtiene el SAO que identifica la version asociada a la
                       ultima entrega del paquete

      Retorno     :  csbVersion - Version del Paquete
    *****************************************************************************/

    FUNCTION fsbversion RETURN VARCHAR2 IS
    BEGIN
        --{
        -- Retorna el SAO con que se realizó la última entrega del paquete
        RETURN(csbversion);
        --}
    END fsbversion;

END LD_FA_REPORTGRAFICCR;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LD_FA_REPORTGRAFICCR', 'ADM_PERSON');
END;
/
