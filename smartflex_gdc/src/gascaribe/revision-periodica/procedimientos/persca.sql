CREATE OR REPLACE PROCEDURE PERSCA(inuProgramacion in ge_process_schedule.process_schedule_id%type) IS
  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PERSCA
  Descripcion    : metodo del Proceso Batch PERSCA para seleccionar los usuarios posibles a generale ordenes de persecucion por variacion de lectura
  Autor          : Emiro Leyva H.
  Fecha          : 06/11/2013

  Parametros              Descripcion
  ============         ===================
  nuExternalId:


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  23/12/2013       llozada             Se modifica la lógica para que evalue el consumo
                                       dependiendo de la última lectura de suspensión del
                                       producto.

   09/05/2014      carlossp           se suprimi la condición AND LEEMOBLE = 65 y se  cambia por
                                      se crea parametro TIPO_TRAB_REPESCA en LDPAR donde el funcional parametrizará
                                      los Tipos de Trabajos para el proceso de repesca.

   14/05/2014      carlossp           adciona el estado del producto  =2  y el tipo  de suspension activa 2 falta de pago
   20/Sep/2014     Jorge Valiente     RNP1005: Modificacion del proceso de persecuion para la generacion de suscenciones
                                               se modificara la logica de como se obtienen los datos para identificar de forma
                                               especifica los procesos que obtendran los servicios suspendidos.
                                               Se adiciono el proceso de consumo CERO para GDO.

   28/01/2015    agordillo          NC 3468. Se agrega una condicion en el cursor cuproductossuspendidos
                                    de que no exista una orden de suspencion en estado registra o asignada para un producto
   19-03-2015    LDiuza             ARA 6598. Se modifican las sentencias de borrado de productos procesados previamente para que cuando se ejecute
                                        el proceso con el ciclo -1, borre por todos los ciclos.
  17/06/2015     Jorge Valiente     Cambio 3995: Modificación del proceso de identificar los suscriptores
                                                 con consumo CERO replanteada por los funcionarios de cartera
                                                 validación de los ing. Eliana R. y Carlos Salcedo y
                                                 modificación  autorizada por el Ing. Alvaro Zapata.
                                    La nueva validación consiste en modificar el cursor llamado CUCONSUMOCEROGDO:
                                    * Retirar el filtro el cual obtiene la última orden de tipo de trabajo 10122 dentro de los últimos 30 días.
                                    * Es su lugar se identificara la última orden que tenga al menos una orden de tipo de trabajo 10122 siendo esta la más reciente.
                                    * Retirar campos de la consulta que nos eran de utilizada ya que se estaban llamado basados en la lógica de órdenes con tipo de trabajo 10122 generadas en los últimos 30 días.
                                    * Se deberá actualizar el filtro de cantidades de cuentas de cobro con saldo; para que sea mayor o igual a 2.
                                    *         Retirar la validación de los campos retirados del cursor CUCONSUMOCEROGDO  ya que eso se tenía contemplado  para la lógica de órdenes con tipo de trabajo 10122 generadas en los últimos 30 días.

  03/06/2016     Jorge Valiente     CASO 200-216: * El CULECTURAS será modificado adicionando una validación donde realice la
                                                    comparación de los campo LEEMOBLE =-1 o LEEMOBLE IS NULL y LEEMLETO >0.
                                                    est con el fin qeu no incluya la observacion de 76- LECTURA PROYECTADA POR RELECT
                                                  * Nuevo parámetro llamado PCAR_TOPE_FACT_SUSP
                                                    Se utilizara para validar el tope de la diferencia de la lectura
                                                    de la facturación y de la suspensión.
                                                    En el cual inicialmente se va a tener un valor de -3 mt3
                                                    En esta configuración y validacion del TOPE se establecerá
                                                    la lógica de utilizar la validación original o la que se aplicara
                                                    en este desarrollo validando a que gasera pertenece.
                                                       En caso de ser EFIGAS se dejara la lógica que existe en la versión de
                                                       PERSCA de EFIGAS.
                                                       En case de ser GDC se utilizar esta nueva lógica

  25/08/2016     Jorge Valiente     CASO 200-734: * Comentariar las varaibles que almacenan informacion
                                                    que probocan errores al no permitir guardar mas
                                                    informacion mayor a su capacidad

  15/06/2018     Josh Brito         Caso 200-1940: Se crean los atributos departamento y localidad para mejorar la generación de este proceso de persecucion,
                                                    Se agregaran condicionales para validar si el campo departamento es igual a (-1) entonces realice las
                                                    consultas originales son filtros de departamento y localidad.
                                                    Esto se hace con el fin de evitar utilizar la función decode() los cuales pueden degradar las consultas
                                                    provocando que su tiempo de ejecución se alargue.

	24/01/2019    ELAl              caso 200-2231   se quita logica y se traslada a paquete 	LDC_PKGENEORDEAUTORECO

    12/07/2020    OLSoftware        Caso 47         Se ajusta para que llame al proc. Se elimina todo el código comentado.

    05/05/2023    jpinedc - MVM     OSF-1075        * Se corrigen caracteres extraños en este encabezado
                                                    * Se borran variables que no se usan
                                                    * Se agrega al asunto de los correos electrónicos la
                                                      base de datos 
    24/05/2023    jpinedc - MVM     OSF-1075        * Se quita del asunto de los correos electrónicos la
                                                      base de datos ya que se va a manejar en el paquete
													  de envio de correo
    21/02/2024    jpinedc - MVM     OSF-2341        * Se cambio el uso de pro*C por cadena de Jobs
    02/04/2024    jpinedc - MVM     OSF-2341        * Se usa PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO
  ******************************************************************/
  
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;  
    
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    
    csbMetodo       CONSTANT VARCHAR2(105) := csbSP_NAME || '.PERSCA';
                  
    nuHilo              number := 1;
    nuLogProcessId      ge_log_process.log_process_id%TYPE; 

    sbParametros        GE_PROCESS_SCHEDULE.PARAMETERS_%type;

    sbOrder_Comment     ge_boInstanceControl.stysbValue;
        
    sbCiclo             ge_boInstanceControl.stysbValue;
    sbDepartamento      ge_boInstanceControl.stysbValue;
    sbLocalidad         ge_boInstanceControl.stysbValue;
    sbProgram           VARCHAR2(2000); -- := 'PERSCA';
    nuIdProceso        NUMBER;

    nuTotalThreads      number;
    
    nuError             NUMBER;
    sbError             VARCHAR2(4000);
    
    CURSOR culdc_Proceso
    (
        inuProcesId LDC_PROCESO.PROCESO_ID%TYPE
    )
    IS
    SELECT LP.*
    FROM LDC_PROCESO LP
    WHERE LP.PROCESO_ID = inuProcesId;

    rcldc_Proceso          culdc_Proceso%ROWTYPE;
    
    sbMensajeError          varchar2(2000);      
 
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

    Ge_Boschedule.Addlogtoscheduleprocess(inuProgramacion, nuHilo, nuLogProcessId);    
        
    sbParametros := dage_process_schedule.fsbGetParameters_(inuProgramacion,0);

    sbCiclo := ut_string.getparametervalue(sbParametros, 'CICLCICO', '|', '=');

    sbOrder_Comment := ut_string.getparametervalue(sbParametros, 'ORDER_COMMENT', '|', '=');

    nuIdProceso := TO_NUMBER(sbOrder_Comment);
        
    OPEN culdc_Proceso(nuIdProceso);
    FETCH culdc_Proceso INTO rcldc_Proceso;
    CLOSE culdc_Proceso;
        
    IF rcldc_Proceso.EMAIL IS NULL THEN
        sbMensajeError := 'No existe E-mail configurado de los funcionarios encargado del proceso de persecucion para ' ||
                      rcldc_Proceso.PROCESO_DESCRIPCION || ',' || chr(10) ||
                      'Si hay mas de un e-mail seran separados por punto coma (;)' ||
                      chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                      chr(10);
        pkg_error.setErrorMessage( isbMsgErrr => sbMensajeError );
    END IF;
    
    sbDepartamento := ut_string.getparametervalue(sbParametros, 'GEO_LOCA_FATHER_ID', '|', '=');
    
    sbLocalidad := ut_string.getparametervalue(sbParametros, 'GEOGRAP_LOCATION_ID', '|', '=');
           
    nuTotalThreads := nvl(pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_NUM_HILOS_PERSCA'),1);        
    
    sbProgram := 'PERSCA_'||sqesprprog.nextval; 
    
    LDC_PKGENEORDEAUTORECO.prgeneraPerscaCadJobs
    (
        sbProgram       , 
        nuIdProceso     , 
        sbCiclo         , 
        sbDepartamento  , 
        sbLocalidad     , 
        nuTotalThreads  ,
        nuLogProcessId
    );        

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);   
    
EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_Error.getError(nuError,sbError);        
        pkg_traza.trace('sbError :' || sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
        pkg_error.setError;
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError :' || sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;            
END PERSCA;
/