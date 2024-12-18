CREATE OR REPLACE PACKAGE pkBOValidSuspCrit
IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : pkBOValidSuspCrit
    Descripcion    : Paquete Personalizado con metodos (Criterios) de validacion
                     ejecutados sobre el proceso de suspension

    Autor          : Luis Felipe Granada Ramirez
    Fecha          : 11-04-2012

    Historia de Modificaciones
    Fecha             Autor               Modificacion
    ==========        ==================  ======================================
    11-07-2023        ibecerra- jpinedc	   OSF-1320: Se quita fblAplicaEntrega
                                           Casos: CA 200-2085 , CA-200-596
    10-07-2023        ibecerra- jpinedc	   OSF-1320: Se ajusta <fboValidCriterions>
    20-10-2014        acardenas.NC3218     se modifica el metodo <fboValidateSuspendCrit>
    10-10-2014        acardenas.NC2942     Se adiciona el metodo <fnuCurrentRefinan>.
                                           Se modifica el metodo <fboValidateSuspendCrit>.
    08-Ago-2013       jllanoSAO215546      Se modifica <fboValidateZeroCons>
                                           Se cambia el metodo para crear una orden
                                           cerrada por uno que acepte el producto
                                           como un parametro de entrada.

    27-08-2012        lgranada.SAO189197  Se modifica el metodo <fboValidateSuspendCrit>
    28-06-2012        lgranada.SAO184888  Se adiciona el metodo <fboValidateZeroCons>
    11-04-2012        lgranada.SAO179856  Creacion
    ******************************************************************/

    --------------------------------------------
    -- Constantes GLOBALES Y PUBLICAS DEL PAQUETE
    --------------------------------------------

    --------------------------------------------
    -- Variables GLOBALES Y PUBLICAS DEL PAQUETE
    --------------------------------------------
    nuProducto   pr_product.product_id%TYPE;

    --------------------------------------------
    -- Funciones y Procedimientos PUBLICAS DEL PAQUETE
    --------------------------------------------

    FUNCTION FSBVERSION
        RETURN VARCHAR2;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad      :  fnuNextCRSUCOPA
    Descripcion :  Obtiene el proximo consecutivo de la secuencia SQ_CRSUCOPA_172735.
    ***************************************************************/
    FUNCTION fnuNextCRSUCOPA
        RETURN NUMBER;

    /********************************************************************
 Propiedad intelectual de Open Systems (c).

 Unidad  :   fboValidateSuspendCrit
    Descripcion :   Determina si para un producto aplica alguno de los grupos de
                    criterios definidos.
 ********************************************************************/
    FUNCTION fboValidateSuspendCrit (
        inuCategory            IN crsucopa.cscpcate%TYPE,
        inuSubCategory         IN crsucopa.cscpsuca%TYPE,
        inuCutStatus           IN crsucopa.cscpesco%TYPE,
        inuBillCycle           IN crsucopa.cscpcifa%TYPE,
        inuDepartment          IN crsucopa.cscpdepa%TYPE,
        inuLocality            IN crsucopa.cscploca%TYPE,
        inuNeighborthood       IN crsucopa.cscpbarr%TYPE,
        inuOperatingSector     IN crsucopa.cscpseop%TYPE,
        inuProductStatus       IN crsucopa.cscpespr%TYPE,
        inuProductBalance      IN crsucopa.cscpdeco%TYPE,
        inuProductExpBalance   IN crsucopa.cscpdeve%TYPE,
        isbFinancialStatus     IN crsucopa.cscpesfi%TYPE,
        inuQuantFinancings     IN crsucopa.cscpcafi%TYPE,
        inuAccountsbalance     IN crsucopa.cscpcacc%TYPE,
        idtFecVenCuenCobro     IN DATE DEFAULT NULL)
        RETURN BOOLEAN;

    /********************************************************************
 Propiedad intelectual de Open Systems (c).

 Unidad  :   fboValidateZeroCons
    Descripcion :   Determina si un producto se encuentra en consumo cero,
                    y si debe ser generada la orden de traza.
 ********************************************************************/
    FUNCTION fboValidateZeroCons (inuProductId IN pr_product.product_id%TYPE)
        RETURN BOOLEAN;

    /********************************************************************
 Propiedad intelectual de Open Systems (c).

 Unidad  :   fnuCurrentRefinan
    Descripcion :   Determina si un producto tiene un refinanciacion con saldo
                    pendiente.
 ********************************************************************/
    FUNCTION fnuCurrentRefinan (inuProductId IN pr_product.product_id%TYPE)
        RETURN NUMBER;

    FUNCTION fdtGetFecVenCuenCobro (
        inuProductId   IN pr_product.product_id%TYPE)
        RETURN DATE;

    FUNCTION fdtGetFecVenCuenVencida (
        inuCuenSusp   IN ldc_crsucopa.cscpcacc%TYPE)
        RETURN DATE;

    FUNCTION fnuNroCuentasVenc (inuProductId IN servsusc.sesunuse%TYPE)
        RETURN NUMBER;

    PROCEDURE pro_grabalog (isbusua   VARCHAR2,
                            inucicl   NUMBER,
                            inuprod   NUMBER,
                            isbobse   VARCHAR2);
END pkBOValidSuspCrit;
/

CREATE OR REPLACE PACKAGE BODY pkBOValidSuspCrit
IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : pkBOValidSuspCrit
    Descripcion    : Paquete Personalizado con metodos (Criterios) de validacion
                     ejecutados sobre el proceso de suspension

    Autor          : Luis Felipe Granada Ramirez
    Fecha          : 11-04-2012

    Historia de Modificaciones
    Fecha             Autor               Modificacion
    ==========        ==================  ======================================
    02-10-2018        FCastro CA-200-2085  Se agrega funcion fdtGetFecVenCuenVencida para
                                           obtener la fecha de vencimiento de la cuenta de cobro
                                           con saldo correspondiente al numero de cuentas vencidas
                                           para suspender segun tabla de criterios adicionales
                                           ldc_crsucopa (CA 200-2085)
    10-Oct-2014       acardenas.NC2942     Se adiciona el metodo <fnuCurrentRefinan>.
                                           Se modifica el metodo <fboValidateSuspendCrit>.
    12-Sep-2014       agordilloRQ1004 PETI Se agrega la validacion del campo CSCPCACC de la tabla
                                           CRSUCOPA en el metodo fboValidateSuspendCrit
    08-Ago-2013       jllanoSAO215546      Se modifica <fboValidateZeroCons>
                                           Se cambia el metodo para crear una orden
                                           cerrada por uno que acepte el producto
                                           como un parametro de entrada.

    24-07-2013        acanizales.SAO212973 Se modifica el metodo <fboValidateZeroCons>
    27-08-2012        lgranada.SAO189197   Se modifica el metodo <fboValidateSuspendCrit>
    28-06-2012        lgranada.SAO184888   Se adiciona el metodo <fboValidateZeroCons>
    11-04-2012        lgranada.SAO179856   Creacion
    ******************************************************************/


    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    csbVERSION            CONSTANT VARCHAR2 (10) := 'OSF-1320';

    --------------------------------------------
    -- Constantes PRIVADAS DEL PAQUETE
    --------------------------------------------
    -- Secuencia para la entidad CRSUCOPA
    csbSEQ_CRSUCOPA       CONSTANT VARCHAR2 (100) := 'SQ_CRSUCOPA_172735';

    -- Parametro: Informacion para la generacion de la orden de traza
    csbSUSP_TRACE_ORDER   CONSTANT VARCHAR2 (100) := 'SUSP_TRACE_ORDER';

    --------------------------------------------
    -- Tipos PRIVADOS DEL PAQUETE
    --------------------------------------------

    --------------------------------------------
    -- Variables PRIVADAS DEL PAQUETE
    --------------------------------------------

    --------------------------------------------
    -- Funciones y Procedimientos PRIVADAS DEL PAQUETE
    --------------------------------------------

    FUNCTION FSBVERSION
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuNextCRSUCOPA
    Descripcion :  Obtiene el proximo consecutivo de la secuencia SQ_CRSUCOPA_172735.

    Autor       :  Luis Felipe Granada Ramirez
    Fecha       :  11-04-2012
    Parametros  :

    Historia de Modificaciones
    Fecha        Autor                Modificacion
    ==========   ==================   ====================
    11-04-2012   lgranada.SAO179856   Creacion
    ***************************************************************/
    FUNCTION fnuNextCRSUCOPA
        RETURN NUMBER
    IS
        /* Proximo consecutivo de la secuencia SEQ_CRSUCOPA_170868 */
        nuNext   NUMBER;
    BEGIN
        --{
        LOOP
            /* Se obtiene el proximo consecutivo de la secuencia validando que
               no exista un registro en la tabla CRSUCOPA cuya llave primaria
               sea igual al valor retornado por la secuencia */
            nuNext := Seq.GetNext (csbSEQ_CRSUCOPA);
            EXIT WHEN (NOT pktblcrsucopa.fblExist (nuNext));
        END LOOP;

        RETURN nuNext;
    EXCEPTION
        WHEN    LOGIN_DENIED
             OR pkConstante.exERROR_LEVEL2
             OR ex.CONTROLLED_ERROR
        THEN
            RAISE;
        WHEN OTHERS
        THEN
            Errors.SetError;
            RAISE ex.CONTROLLED_ERROR;
    END fnuNextCRSUCOPA;

    -- =============================================================================

    /********************************************************************
 Propiedad intelectual de Open Systems (c).

 Unidad  :   fboValidateSuspendCrit
    Descripcion :   Determina si para un producto aplica alguno de los grupos de
                    criterios definidos.

 Parametros        Descripcion
    ============         ===================
    inuCategory           Identificador de la categoria del producto
    inuSubCategory        Identificador de la subCategoria del producto
    inuCutStatus          Identificador del Estado de corte del producto
    inuBillCycle          Identificador del Ciclo de Facturacion del producto
    inuDepartment         Identificador del departamento asociado a la direccion del producto
    inuLocality           Identificador de la localidad asociada a la direccion del producto
    inuNeighborthood      Identificador del barrio asociado a la direccion del producto
    inuOperatingSector    Identificador del sector operativo asociado a la localidad del producto
    inuProductStatus      Identificador del Estado del producto
    inuProductBalance     Deuda Corriente asociada al producto
    inuProductExpBalance  Deuda Vencida asociada al producto
    isbFinancialStatus    Estado Financiero del Producto
    inuQuantFinancings    Indicador de Refinanciacion con saldo
    inuAccountsbalance    Cantidad de cuentas con saldo del producto

 Autor  :   Luis Felipe Granada Ramirez
 Fecha  :   11-04-2012

 Historia de Modificaciones
 Fecha         Autor                 Modificacion
 ==========    =================     ====================
 10-07-2023    ibecerra- jpinedc	 OSF-1320: Se ajusta fboValidCriterions para
									 calcular la fecha de suspensión por FPCA con
                                     base en la fecha de suspensión de la última 
                                     cuenta de cobro. 									 
  02-10-2018    FCastro CA-200-2085  Se obtiene la fecha de vencimiento de la cuenta de cobro
                                     con saldo correspondiente al numero de cuentas vencidas
                                     para suspender segun tabla de criterios adicionales
                                     ldc_crsucopa, para sumarle los dias adicionales
                                     y saber si se debe suspender o no. Anteriormente se buscaba
                                     la fecha de la cuenta con saldo mas reciente (CA 200-2085)

  04-10-2016    ncarrasquilla         CA-200-596. Se adiciona parametro de la fecha de cuenta de
                                      cobro mas reciente para buscar dias adicionales para la suspensi?n
                                      Se busca en la nueva tabla LDC_CRSUCOPA copia de CRSUCOPA
 20-10-2014    acardenas.NC3218      Se modifica para que valide correctamente si no existe
                                      parametrizacion particular para el producto dado.
 10-10-2014    acardenas.NC2492      Se modifica la logica para aplicar criterios adicionales,
                                      validando si el producto cumple una configuracion particular
                                      para aplicar el criterio de cuentas vencidas y saldo pendiente.
 12-Sep-2014   agordilloRQ1004 PETI  Se agrega la validacion del campo CSCPCACC de la tabla
                                      CRSUCOPA para el contemplar el criterio de numero de cuentas
                                      con saldo
 27-08-2012    lgranada.SAO189197    Se modifica para soportar valores nulos en
                                      los criterios, el cual tendra la misma
                                      connotacion que el -1
   1-04-2012    lgranada.SAO179856    Creacion
 *********************************************************************/

    FUNCTION fboValidateSuspendCrit (
        inuCategory            IN crsucopa.cscpcate%TYPE,
        inuSubCategory         IN crsucopa.cscpsuca%TYPE,
        inuCutStatus           IN crsucopa.cscpesco%TYPE,
        inuBillCycle           IN crsucopa.cscpcifa%TYPE,
        inuDepartment          IN crsucopa.cscpdepa%TYPE,
        inuLocality            IN crsucopa.cscploca%TYPE,
        inuNeighborthood       IN crsucopa.cscpbarr%TYPE,
        inuOperatingSector     IN crsucopa.cscpseop%TYPE,
        inuProductStatus       IN crsucopa.cscpespr%TYPE,
        inuProductBalance      IN crsucopa.cscpdeco%TYPE,
        inuProductExpBalance   IN crsucopa.cscpdeve%TYPE,
        isbFinancialStatus     IN crsucopa.cscpesfi%TYPE,
        inuQuantFinancings     IN crsucopa.cscpcafi%TYPE,
        inuAccountsbalance     IN crsucopa.cscpcacc%TYPE,
        idtFecVenCuenCobro     IN DATE DEFAULT NULL              -- CA-200-596
                                                   )
        RETURN BOOLEAN
    IS
        -- Tabla de criterios adicionales
        TYPE tytbCrsucopa IS TABLE OF ldc_crsucopa%ROWTYPE
            INDEX BY BINARY_INTEGER;

        tbCrsucopa                   tytbCrsucopa;

        -- Fecha de vencimiento de la cuenta correspondiente a la que causa la suspension
        -- segun la tabla de criterios adicionales
        dtFeveCtaparaSusp            DATE;

        -- Indice para recorrer la tabla PL
        nuIndex                      NUMBER;

        -- Registro de Criterios Adicionales de Suspension y Corte por No Pago
        rcCrsucopa                   ldc_crsucopa%ROWTYPE;

        -- Variable para determinar si el producto cumple con los cirterios definidos
        boSuspendProduct             BOOLEAN;

        -- FLAG de suspension
        boSuspendFlag                BOOLEAN;

        -- CURSOR para obtener criterios que aplican al producto
        CURSOR cuRegCrsucopa IS
            SELECT *
              FROM ldc_crsucopa                                    -- crsucopa
             WHERE     inucategory = NVL (cscpcate, inucategory)
                   AND inuSubCategory = NVL (cscpsuca, inuSubCategory)
                   AND inuBillCycle = NVL (cscpcifa, inuBillCycle)
                   AND inuDepartment = NVL (cscpdepa, inuDepartment)
                   AND inuLocality = NVL (cscploca, inuLocality)
                   AND inuNeighborthood = NVL (cscpbarr, inuNeighborthood)
                   AND inuOperatingSector =
                       NVL (cscpseop, inuOperatingSector)
                   AND inuProductStatus = NVL (cscpespr, inuProductStatus)
                   AND inuCutStatus = NVL (cscpesco, inuCutStatus)
                   AND isbFinancialStatus =
                       NVL (cscpesfi, isbFinancialStatus)
                   AND inuQuantFinancings =
                       CASE
                           WHEN cscpcafi = 0 THEN inuQuantFinancings
                           ELSE cscpcafi
                       END;

        -- CA-200-596. Variable dias adicionales
        dtDiasAdic                   DATE;
        nuDiasAdic                   ldc_crsucopa.cscpdive%TYPE;

        sbobse                       ldc_log_fpca.observacion%TYPE;

        -----------------------------------------

        -- Compara los criterios ingresados contra los que se encuentran definidos
        FUNCTION fboValidCriterions (-- Criterios a evaluar
                                     ircCrsucopa ldc_crsucopa%ROWTYPE)
            RETURN BOOLEAN
        IS
        BEGIN
            ut_trace.Trace (
                'pkBOValidSuspCrit.fboValidateZeroCons.fboValidCriterions',
                4);

            -- Valida la deuda Corriente del producto
            IF (   (inuProductBalance IS NULL)
                OR (inuProductBalance < ircCrsucopa.cscpdeco))
            THEN
                ut_trace.Trace (
                    'pkBOValidSuspCrit.fboValidateZeroCons.fboValidCriterions',
                    4);
                            
                sbObse :=
                       'Codigo Tabla Criterios: '
                    || ircCrsucopa.Cscpcodi
                    || ' - '
                    || 'Deuda Corriente Producto: '
                    || inuProductBalance
                    || ' - '
                    || 'Deuda Corriente Criterio: '
                    || ircCrsucopa.cscpdeco;
                pro_grabalog (USER,
                              inuBillCycle,
                              nuProducto,
                              sbobse);
                RETURN FALSE;
            END IF;

            -- Valida la deuda vencida del producto
            IF (   (inuProductExpBalance IS NULL)
                OR (inuProductExpBalance < ircCrsucopa.cscpdeve))
            THEN
                sbObse :=
                       'Codigo Tabla Criterios: '
                    || ircCrsucopa.Cscpcodi
                    || ' - '
                    || 'Deuda Vencida Producto: '
                    || inuProductExpBalance
                    || ' - '
                    || 'Deuda Vencida Criterio: '
                    || ircCrsucopa.cscpdeve;
                pro_grabalog (USER,
                              inuBillCycle,
                              nuProducto,
                              sbobse);
                RETURN FALSE;
            END IF;

            -- Valida el numero de cuentas vencidas
            IF (   (inuAccountsbalance IS NULL)
                OR (inuAccountsbalance < ircCrsucopa.cscpcacc))
            THEN
                sbObse :=
                       'Codigo Tabla Criterios: '
                    || ircCrsucopa.Cscpcodi
                    || ' - '
                    || 'Cuentas Vencidas Producto: '
                    || inuAccountsbalance
                    || ' - '
                    || 'Cuentas Vencidas Criterio: '
                    || ircCrsucopa.cscpcacc;
                pro_grabalog (USER,
                              inuBillCycle,
                              nuProducto,
                              sbobse);
                RETURN FALSE;
            END IF;

            -- Obtiene la fecha de vencimiento de la cuenta de cobro con la que se suspende
            ut_trace.Trace('ircCrsucopa.cscpcacc|' || ircCrsucopa.cscpcacc, 4 );
            dtFeveCtaparaSusp :=
                pkbovalidsuspcrit.fdtGetFecVenCuenVencida (
                    ircCrsucopa.cscpcacc);

            ut_trace.Trace('dtFeveCtaparaSusp|' || TO_CHAR( dtFeveCtaparaSusp, 'dd/mm/yyyy hh24:mi:ss'),4); 

            IF (dtFeveCtaparaSusp IS NOT NULL)
            THEN
                -- Calcula fecha de suspensión en FPCA con días laborales adicionales
                dtDiasAdic :=
                    PKHOLIDAYMGR.FDTGETDATENONHOLIDAY( dtFeveCtaparaSusp, ircCrsucopa.cscpdive ) + ( dtFeveCtaparaSusp - trunc(dtFeveCtaparaSusp));
					
                ut_trace.Trace('dtDiasAdic|' || TO_CHAR( dtDiasAdic, 'dd/mm/yyyy hh24:mi:ss'),4); 
                    
                nuDiasAdic :=
                    dtDiasAdic - dtFeveCtaparaSusp;
                
                ut_trace.Trace('nuDiasAdic|' || nuDiasAdic,4);

                IF ( dtDiasAdic > SYSDATE)
                THEN
                    sbObse :=
                             sbObse
                          || ' - Codigo Tabla Criterios: '
                          || ircCrsucopa.Cscpcodi
                          || ' - '
                          || 'Fecha Vencimiento Cuenta: '
                          || dtFeveCtaparaSusp
                          || ' - '
                          || 'Nro Dias que lleva la Cuenta: '
                          || nuDiasAdic
                          || ' - '
                          || 'Dias Adicionales Criterio: '
                          || ircCrsucopa.cscpdive
                          || ' - '
                          || 'Fecha para suspender: '
                          || dtDiasAdic;
						  
                    pro_grabalog (USER,
                                  inuBillCycle,
                                  nuProducto,
                                  sbobse);
					ut_trace.Trace('NO debe suspender',4);
                    RETURN FALSE;
                END IF;
            END IF;

            -------------------------------------------
			ut_trace.Trace('SÍ debe suspender',4);
            RETURN TRUE;
        EXCEPTION
            WHEN    LOGIN_DENIED
                 OR pkConstante.exERROR_LEVEL2
                 OR ex.CONTROLLED_ERROR
            THEN
                RAISE;
            WHEN OTHERS
            THEN
                Errors.SetError;
                RAISE ex.CONTROLLED_ERROR;
        END fboValidCriterions;
    BEGIN
        ut_trace.Trace ('Inicio pkBOValidSuspCrit.ValidateSuspendCrit', 4);

        -- Obtiene los criterios que cumplan con la parametrizacion particular
        IF cuRegCrsucopa%ISOPEN
        THEN
            CLOSE cuRegCrsucopa;
        END IF;

        OPEN cuRegCrsucopa;

        FETCH cuRegCrsucopa BULK COLLECT INTO tbCrsucopa;

        CLOSE cuRegCrsucopa;

        -- Obtiene la primera posicion para la tabla PL de Criterios
        nuIndex := tbCrsucopa.FIRST;

        -- Si no hay criterios para evaluar retorna TRUE
        IF nuIndex IS NULL OR nuIndex = 0
        THEN
            RETURN TRUE;
        END IF;

        -- Inicializa flag de suspension boSuspendProduct
        boSuspendFlag := FALSE;

        -- Recorre la tabla Pl de los criterios obtenidos
        WHILE (nuIndex IS NOT NULL)
        LOOP
            -- Obtiene el Registro de la tabla PL
            rcCrsucopa := tbCrsucopa (nuIndex);

            -- Compara contra los criterios obtenidos
            boSuspendProduct := fboValidCriterions (rcCrsucopa);

            IF (boSuspendProduct)
            THEN
                boSuspendFlag := TRUE;
            END IF;

            -- Obtiene el siguiente conjunto de criterios
            nuIndex := tbCrsucopa.NEXT (nuIndex);
        END LOOP;

        ut_trace.Trace (
            'Fin pkBOValidSuspCrit.ValidateSuspendCrit - Suspender Producto',
            4);

        RETURN boSuspendFlag;
    EXCEPTION
        WHEN    LOGIN_DENIED
             OR pkConstante.exERROR_LEVEL2
             OR ex.CONTROLLED_ERROR
        THEN
            RAISE;
        WHEN OTHERS
        THEN
            Errors.SetError;
            RAISE ex.CONTROLLED_ERROR;
    END fboValidateSuspendCrit;

    -- =============================================================================



    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fboValidateSuspendCrit
    Descripcion :  Determina si un producto se encuentra en consumo cero,
                   y si debe ser generada la orden de traza.

    Autor       :  Luis Felipe Granada Ramirez
    Fecha       :  28-06-2012
    Parametros  :

    Historia de Modificaciones
    Fecha        Autor                Modificacion
    ==========   ==================   ====================
    08-Ago-2013  jllanoSAO215546      Se cambia el metodo para crear una orden
                                      cerrada por uno que acepte el producto
                                      como un parametro de entrada.

    24-07-2013   acanizales.SAO212973
    Se adiciona transaccion autonoma.

    28-06-2012   lgranada.SAO184888   Creacion
    ***************************************************************/
    FUNCTION fboValidateZeroCons (inuProductId IN pr_product.product_id%TYPE)
        RETURN BOOLEAN
    IS
        /* Marca de consumo cero */
        sbZeroConsMark     cm_marccoce.macccoce%TYPE;

        /* Fecha de la utima orden de traza */
        dtTraceOrderDate   pr_prod_trace_date.trace_order_date%TYPE;

        /* Registro de la ultima orden de traza para el producto */
        rcProdTraceDate    dapr_prod_trace_date.styPR_prod_trace_date;

        /* Informacion parametrizada para las ordenes de traza */
        sbTraceOrderData   VARCHAR2 (2000);

        /* Tabla: Datos extraidos de la informacion parametrizada */
        tbTraceOrderData   ut_string.TyTb_String;

        /* Actividad parametrizada para las ordenes de traza */
        nuTraceActivity    ge_items.items_id%TYPE;

        /* Unidad de trabajo parametrizada para las ordenes de trabajo */
        nuOperatingUnit    or_order.operating_unit_id%TYPE;

        /* Direccion de instalacion del producto */
        /* Identificador de la persona parametrizada */
        nuPersonId         or_order_person.person_id%TYPE;

        nuAddressId        pr_product.address_id%TYPE;

        /* Identificador de la orden de traza generada */
        nuOrderId          or_order.order_id%TYPE;

        /* Codigo del error */
        nuErrorCode        ge_message.message_id%TYPE;

        /* Mensaje de error */
        sbErrorMessage     ge_error_log.description%TYPE;

        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        --{
        ut_trace.Trace ('Inicio pkBOValidSuspCrit.fboValidateZeroCons', 4);
        ut_trace.Trace ('Producto[' || inuProductId || ']', 5);

        /* Obtiene la marca de consumo cero para el ultimo periodo de consumo
           asociado al producto */
        sbZeroConsMark :=
            cm_bozeroconsmgr.fsbGetZeroConsMark (inuProductId, NULL);
        ut_trace.Trace ('Marca de Consumo Cero[' || sbZeroConsMark || ']', 5);

        /* Determina si el producto se encuentra en consumo cero */
        IF (sbZeroConsMark = cm_bczeroconsmgr.csbZEROCONS)
        THEN
            /* Obtiene la fecha de la ultima orden de traza para el producto */
            dtTraceOrderDate :=
                dapr_prod_trace_date.fdtGetTrace_Order_Date (inuProductId, 0);
            ut_trace.Trace (
                   'Fecha de la ultima orden de traza['
                || dtTraceOrderDate
                || ']',
                5);

            /* Si no existe orden de traza para el producto, o ya han transcurridos 30 dias
               desde la ultima orden generada */
            IF    (dtTraceOrderDate IS NULL)
               OR ((SYSDATE - dtTraceOrderDate) >= 30)
            THEN
                /* Se obtiene la informacion de la orden de traza del valor del parametro SUSP_TRACE_ORDER*/
                sbTraceOrderData :=
                    ge_boparameter.fsbGet (csbSUSP_TRACE_ORDER);
                ut_string.ExtString (sbTraceOrderData, '|', tbTraceOrderData);

                /* Extrae informacion de la actividad de traza */
                IF (tbTraceOrderData.EXISTS (1))
                THEN
                    nuTraceActivity := TO_NUMBER (tbTraceOrderData (1));
                    ut_trace.Trace (
                        'Actividad de traza[' || nuTraceActivity || ']',
                        5);
                END IF;

                /* Extrae informacion de la unidad operativa */
                IF (tbTraceOrderData.EXISTS (2))
                THEN
                    nuOperatingUnit := TO_NUMBER (tbTraceOrderData (2));
                    ut_trace.Trace (
                        'Unidad Operativa[' || nuOperatingUnit || ']',
                        5);
                END IF;

                /* Extrae informacion de la persona */
                IF (tbTraceOrderData.EXISTS (3))
                THEN
                    nuPersonId := TO_NUMBER (tbTraceOrderData (3));
                    ut_trace.Trace (
                        'Persona que Legaliza[' || nuPersonId || ']',
                        5);
                END IF;

                /* Obtiene la direccion de instalacion del producto */
                nuAddressId := dapr_product.fnuGetAddress_Id (inuProductId);
                ut_trace.Trace (
                    'Direccion Instalacion Producto[' || nuAddressId || ']',
                    5);

                -- se llama al metodo encargado de validar los datos para la
                -- creacion de la orden de traza.
                or_boorder.ValidCloseOrderData (
                    inuOperUnitId      => nuOperatingUnit,
                    inuActivity        => nuTraceActivity,
                    inuAddressId       => nuAddressId,
                    idtFinishDate      => SYSDATE,
                    inuItemAmount      => 1,
                    inuRefValue        => NULL,
                    inuCausal          => 1,
                    inuRelationType    => NULL,
                    ionuOrderId        => nuOrderId,
                    inuOrderRelaId     => NULL,
                    inuCommentTypeId   => NULL,
                    isbComment         => NULL,
                    inuPersonId        => nuPersonId);

                -- Se crea la orden de traza cerrada.
                or_boorder.CloseOrderWithProduct (
                    inuOperUnitId      => nuOperatingUnit,
                    inuActivity        => nuTraceActivity,
                    inuAddressId       => nuAddressId,
                    idtFinishDate      => SYSDATE,
                    inuItemAmount      => 1,
                    inuRefValue        => NULL,
                    inuCausalId        => 1,
                    inuRelationType    => NULL,
                    ionuOrderId        => nuOrderId,
                    inuOrderRelaId     => NULL,
                    inuCommentTypeId   => NULL,
                    isbComment         => NULL,
                    inuPersonId        => nuPersonId,
                    inuProductId       => inuProductId);

                ut_trace.Trace ('Orden de Traza[' || nuOrderId || ']', 5);

                /* Registra o actualiza la fecha de la ultima orden de traza
                   para el producto */
                IF (dtTraceOrderDate IS NULL)
                THEN
                    /* Inicializa el registro */
                    rcProdTraceDate := NULL;
                    rcProdTraceDate.product_id := inuProductId;
                    rcProdTraceDate.trace_order_date :=
                        daor_order.fdtGetLegalization_Date (nuOrderId);
                    /* Inserta el registro */
                    dapr_prod_trace_date.insRecord (rcProdTraceDate);
                ELSE
                    dapr_prod_trace_date.updTrace_Order_Date (
                        inuProductId,
                        daor_order.fdtGetLegalization_Date (nuOrderId));
                END IF;

                /* Guarda orden de traza */
                COMMIT;
            END IF;

            ut_trace.Trace ('Fin pkBOValidSuspCrit.fboValidateZeroCons', 4);

            RETURN TRUE;
        END IF;

        ut_trace.Trace ('Fin pkBOValidSuspCrit.fboValidateZeroCons', 4);
        RETURN FALSE;
    EXCEPTION
        WHEN    LOGIN_DENIED
             OR pkConstante.exERROR_LEVEL2
             OR ex.CONTROLLED_ERROR
        THEN
            RAISE;
        WHEN OTHERS
        THEN
            Errors.SetError;
            RAISE ex.CONTROLLED_ERROR;
    END fboValidateZeroCons;

    -- =============================================================================


    /********************************************************************
 Propiedad intelectual de Open Systems (c).

 Unidad  :   fnuCurrentRefinan
    Descripcion :   Determina si un producto tiene refinanciaciones con saldo
                    pendiente.
 ********************************************************************/

    FUNCTION fnuCurrentRefinan (inuProductId IN pr_product.product_id%TYPE)
        RETURN NUMBER
    IS
        nuRefinan   NUMBER;

        CURSOR cuCurrentRefinan (nuProduct NUMBER)
        IS
            SELECT COUNT (DISTINCT difecofi)
              FROM diferido
             WHERE     difeprog = 'GCNED'
                   AND difesape > 0
                   AND difenuse = nuProduct;
    BEGIN
        IF cuCurrentRefinan%ISOPEN
        THEN
            CLOSE cuCurrentRefinan;
        END IF;

        OPEN cuCurrentRefinan (inuProductId);

        FETCH cuCurrentRefinan INTO nuRefinan;

        CLOSE cuCurrentRefinan;

        IF nuRefinan > 0
        THEN
            RETURN 1;
        END IF;

        RETURN 2;
    EXCEPTION
        WHEN    LOGIN_DENIED
             OR pkConstante.exERROR_LEVEL2
             OR ex.CONTROLLED_ERROR
        THEN
            RAISE;
        WHEN OTHERS
        THEN
            Errors.SetError;
            RAISE ex.CONTROLLED_ERROR;
    END fnuCurrentRefinan;

    /********************************************************************
     Propiedad intelectual de Gases del Caribe.

     Unidad  :   fdtGetFecVenCuenCobro
      Descripcion :  Obtiene la fecha de vencimiento de la cuenta de cobro
                     con saldo mas reciente.
   ********************************************************************/

    FUNCTION fdtGetFecVenCuenCobro (
        inuProductId   IN pr_product.product_id%TYPE)
        RETURN DATE
    IS
        dtVenCueCob   DATE;

        CURSOR cuFecVenCuenCobro (nuProduct NUMBER)
        IS
            SELECT MAX (c.cucofeve)
              FROM cuencobr c
             WHERE cuconuse = nuProduct AND NVL (cucosacu, 0) > 0;
    BEGIN
        IF cuFecVenCuenCobro%ISOPEN
        THEN
            CLOSE cuFecVenCuenCobro;
        END IF;

        OPEN cuFecVenCuenCobro (inuProductId);

        FETCH cuFecVenCuenCobro INTO dtVenCueCob;

        CLOSE cuFecVenCuenCobro;

        -- asigna variable de paquete para guardar el producto para la
        -- funcion fdtGetFecVenCuenVencida (CA 200-2085)
        pkbovalidsuspcrit.nuProducto := inuProductId;

        RETURN dtVenCueCob;
    EXCEPTION
        WHEN    LOGIN_DENIED
             OR pkConstante.exERROR_LEVEL2
             OR ex.CONTROLLED_ERROR
        THEN
            RAISE;
        WHEN OTHERS
        THEN
            Errors.SetError;
            RAISE ex.CONTROLLED_ERROR;
    END fdtGetFecVenCuenCobro;

    /********************************************************************
       Propiedad intelectual de Gases del Caribe.

       Unidad  :   fdtGetFecVenCuenVencida
        Descripcion :  Obtiene la fecha de vencimiento de la cuenta de cobro
                       con saldo correspondiente al numero de cuentas vencidas
                       para suspender segun tabla de criterios adicionales
                       ldc_crsucopa (CA 200-2085)
     ********************************************************************/

    FUNCTION fdtGetFecVenCuenVencida (
        inuCuenSusp   IN ldc_crsucopa.cscpcacc%TYPE)
        RETURN DATE
    IS
        dtVenCueCob   DATE := NULL;
        nucont        NUMBER := 0;

        CURSOR cuFecVenCuenCobro (nuproductId pr_product.product_id%TYPE)
        IS
              SELECT c.cucofeve
                FROM cuencobr c
               WHERE cuconuse = nuProductId AND NVL (cucosacu, 0) > 0
            ORDER BY cucocodi;
    BEGIN
        FOR rg IN cuFecVenCuenCobro (pkbovalidsuspcrit.nuProducto)
        LOOP
            nucont := nucont + 1;

            IF nucont = inuCuenSusp
            THEN
                dtVenCueCob := rg.cucofeve;
                EXIT;
            END IF;
        END LOOP;

        RETURN dtVenCueCob;
    EXCEPTION
        WHEN    LOGIN_DENIED
             OR pkConstante.exERROR_LEVEL2
             OR ex.CONTROLLED_ERROR
        THEN
            RAISE;
        WHEN OTHERS
        THEN
            Errors.SetError;
            RAISE ex.CONTROLLED_ERROR;
    END fdtGetFecVenCuenVencida;

    /********************************************************************
       Propiedad intelectual de Gases del Caribe.

       Unidad  :   fnuNroCuentasVenc
        Descripcion :  Obtiene el numero de cuentas vencidas (CA 200-2085)
     ********************************************************************/

    FUNCTION fnuNroCuentasVenc (inuProductId IN servsusc.sesunuse%TYPE)
        RETURN NUMBER
    IS
        nuCuentas   NUMBER := 0;
        nucont      NUMBER := 0;

        CURSOR cuCuenVenc IS
            SELECT COUNT (1)
              FROM cuencobr c
             WHERE     cuconuse = inuProductId
                   AND   NVL (cucosacu, 0)
                       - NVL (cucovare, 0)
                       - NVL (cucovrap, 0) >
                       0
                   AND cucofeve < SYSDATE;
    BEGIN
        OPEN cuCuenVenc;

        FETCH cuCuenVenc INTO nuCuentas;

        IF cuCuenVenc%NOTFOUND
        THEN
            nuCuentas := 0;
        END IF;

        CLOSE cuCuenVenc;


        RETURN NVL (nuCuentas, 0);
    EXCEPTION
        WHEN    LOGIN_DENIED
             OR pkConstante.exERROR_LEVEL2
             OR ex.CONTROLLED_ERROR
        THEN
            RAISE;
        WHEN OTHERS
        THEN
            Errors.SetError;
            RAISE ex.CONTROLLED_ERROR;
    END fnuNroCuentasVenc;

    /********************************************************************
       Propiedad intelectual de Gases del Caribe.

       Unidad  :   pro_grabalog
        Descripcion :  Graba log indicando por que no paso criterios (CA 200-2085)
     ********************************************************************/
    PROCEDURE pro_grabalog (isbusua   VARCHAR2,
                            inucicl   NUMBER,
                            inuprod   NUMBER,
                            isbobse   VARCHAR2)
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        INSERT INTO LDC_LOG_FPCA (USUARIO,
                                  FECHA,
                                  CICLO,
                                  PRODUCTO,
                                  OBSERVACION)
             VALUES (isbusua,
                     SYSDATE,
                     inucicl,
                     inuprod,
                     isbobse);

        COMMIT;
    END pro_grabalog;
END pkBOValidSuspCrit;
/

