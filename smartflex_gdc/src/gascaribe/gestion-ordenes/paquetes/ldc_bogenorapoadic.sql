CREATE OR REPLACE PACKAGE      LDC_BOGENORAPOADIC IS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LDC_GENORAPOADIC
  Descripcion    : Paquete BO con las funciones y/o
                   procedimientos para generacion masiva de ordenes masiva o apoyo
  Autor          : AAcuna
  Fecha          : 14/04/2016

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha          Autor              Modificacion
  =========   =========             ====================
  31-10-2016   KBaquero             se modifica <<fnuGetActSupport>>
  31-10-2016   KBaquero             se modifica <<PROCGENORAPOADIC>>
  27-03-2024   Adrianavg            OSF-2380: Se aplican pautas técnicas y se reemplazan servicios homólogos
                                    Se declaran variables de gestion de traza  
  29-10-2024   felipe.valencia      OSF-3529 : Se modifica el procedimiento
                                    PROCGENORAPOADIC
  ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbNOMPKG            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;
  -- Declaracion de Tipos de datos publicos

  -- Declaracion de variables publicas

  --------------------------------------------------------------------
  -- Variables
  --------------------------------------------------------------------
  --------------------------------------------------------------------
  -- Cursores
  --------------------------------------------------------------------

  -- Declaracion de metodos publicos

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure      :  fsbVersion
  Descripcion    :  Obtiene la Version actual del Paquete

  Parametros     :  Descripcion
  Retorno        :
  csbVersion        Version del Paquete

  Autor          :  AAcuna
  Fecha          :  14/04/2016

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  *****************************************************************/

  FUNCTION fsbversion RETURN VARCHAR2;
  sbconsultation VARCHAR2(4000);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCGENORAPOADIC
  Descripcion    : Procedimiento que se encarga de generar las ordenes de adicionales y apoyo de
                   manera masiva
  Autor          : AAcuna
  Fecha          : 14/04/2016

  Parametros         Descripcion
  ============   ===================

  Historia de Modificaciones
  Fecha            Autor            Modificacion
  =========      =========          ====================
  14-04-2016     AAcuna             Creaci?n

  ******************************************************************/

  PROCEDURE PROCGENORAPOADIC;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuGetPath
  Descripcion    : Obtiene la ruta a partir del id del directorio
  Autor          : AAcuna
  Fecha          : 14/04/2016

  Parametros         Descripcion
  ============   ===================

  Historia de Modificaciones
  Fecha            Autor            Modificacion
  =========      =========          ====================
  14-04-2016     AAcuna             Creaci?n
  ******************************************************************/

  FUNCTION fnuGetPath(inuDirectorId IN ge_directory.directory_id%TYPE)
    RETURN VARCHAR2;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuGetActSupport
  Descripcion    : Valida que la actividad a relacionar tenga relacion con la atividad en la tabla
                   OR_SUPPORT_ACTIVITY
  Autor          : AAcuna
  Fecha          : 14/04/2016

  Parametros         Descripcion
  ============   ===================

  Historia de Modificaciones
  Fecha            Autor            Modificacion
  =========      =========          ====================
  14-04-2016     AAcuna             Creaci?n
  ******************************************************************/

  FUNCTION fnuGetActSupport(nuActRelacionar IN OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE,
                            nuActOrden      IN OR_ORDER_ACTIVITY.ORDER_ID%TYPE)
    RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuGetStatus
  Descripcion    : Valida que el estado de la orden se encuentre en 5 o 7
  Autor          : AAcuna
  Fecha          : 14/04/2016

  Parametros         Descripcion
  ============   ===================

  Historia de Modificaciones
  Fecha            Autor            Modificacion
  =========      =========          ====================
  14-04-2016     AAcuna             Creaci?n
  ******************************************************************/

  FUNCTION fnuGetStatus(inuOrder IN OR_ORDER_ACTIVITY.Order_Id%TYPE)
    RETURN NUMBER;
END LDC_BOGENORAPOADIC;
/


CREATE OR REPLACE PACKAGE BODY      LDC_BOGENORAPOADIC IS

  -----------------------
  -- Constants
  -----------------------
  -- Constante con el SAO de la ultima version aplicada
  csbVERSION CONSTANT VARCHAR2(10) := 'OSF-2380';

  -- Definicion de metodos publicos y privados del paquete

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure      :  fsbVersion
  Descripcion    :  Obtiene la Version actual del Paquete

  Parametros     :  Descripcion
  Retorno        :
  csbVersion        Version del Paquete

  Autor          :  AAcu?a
  Fecha          :  13/11/2012 SAO 159764

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ==================== 
  27/03/2024     Adrianavg  OSF-2380: Se declara variable para nombre del método
                            Se reemplaza pkErrors.Push por pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
                            Se reemplaza pkErrors.Pop por pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  *****************************************************************/

  FUNCTION fsbVersion RETURN VARCHAR2 IS 
    --Se declara variable para nombre del método
    csbMetodo  		 CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbVersion';
    
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_traza.trace(csbMetodo ||' csbVersion: ' || csbVersion, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    -- Retorna el SAO con que se realizo la ultima entrega
    RETURN(csbVersion);
  END fsbVersion;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCGENORAPOADIC
  Descripcion    : Procedimiento que se encarga de generar las ordenes de adicionales y apoyo de
                   manera masiva
  Autor          : AAcuna
  Fecha          : 14/04/2016

  Parametros         Descripcion
  ============   ===================

  Historia de Modificaciones
  Fecha            Autor            Modificacion
  =========      =========          ====================
  31/11/2020     olsoftware         ca 416 se coloca proceso para que busque producto de gas siempre ty cuando el tipo de trabajo
                                    este en el parametro LDC_TITRCOPR
  12-08-2019     dsaltarin 			CA 200-2686 Se modifica para que guarde cero en el numero de intentos y el order_Activity_id
  31/10/2016     KBaquero           Caso [200838] Se modifica para que en el momento en que se genere la
                                    orden no se le cambie el tipo de trabajo.
  14-04-2016     AAcuna             Creación
  27/03/2024     Adrianavg          OSF-2380: Se declara variable para nombre del método
                                    Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo
                                    Se reemplaza dald_parameter.fnuGetNumeric_Value por pkg_bcld_parameter.fnuobtienevalornumerico
                                    Se reemplaza pkUtlFileMgr.Fopen por pkg_gestionarchivos.ftabrirarchivo_smf
                                    Se reemplaza pkUtlFileMgr.Put_Line por pkg_gestionarchivos.prcescribirlinea_smf
                                    Se reemplaza ge_boerrors.seterrorcodeargument por pkg_error.seterrormessage
                                    Se reemplaza ERRORS.SETERROR por PKG_ERROR.SETERROR
                                    Se reemplaza ld_boconstans.cnugeneric_error por pkg_error.cnugeneric_message                                    
                                    Se añade BEGIN-END al llamado de pkg_gestionarchivos.fsbobtenerlinea_smf() para manejar
                                    la exception de fin de archivo y asignar valor a nuCodigo
                                    Se reemplaza SELECT-INTO por cuSolicitudOrden, cuDireccionSuscrip, cuSegundaVisita
                                    Se retira del IF-ENDIF el llamado al FBLAPLICAENTREGAXCASO('0000416'), en producción se encuentra activa así
                                    que se mantiene la lógica interna al IF-ENDIF
                                    Se reemplaza or_boorderactivities.createactivity por api_createorder
                                    Se reemplaza os_assign_order por api_assign_order
                                    Se reemplaza pkUtlFileMgr.fClose por pkg_gestionarchivos.prccerrararchivo_smf
                                    Se ajusta bloque de exception según pautas técnicas
  29/10/2024    felipe.valencia     OSF-3529: Se modifica la forma en que se obtiene el valor del parametro
                                    LDC_TITRCOPR
  ******************************************************************/
  PROCEDURE PROCGENORAPOADIC IS
    --Se declara variable para nombre del método
    csbMetodo  		    CONSTANT VARCHAR2(100) := csbNOMPKG||'Procgenorapoadic';
    
    sbRuta              GE_DIRECTORY.Description%TYPE;
    sbFileName          VARCHAR2(3200);

    -- Local variables here
    i                   INTEGER;
    sbFileManagement    pkg_gestionarchivos.styarchivo;
    sbRutLogs           ld_parameter.value_chain%TYPE; -- Parametro de la ruta de seguro
    nuIndexArray        BINARY_INTEGER;
    sbOnline            VARCHAR2(5000);
    nuLinea             NUMBER;
    nuCodigo            NUMBER;
    cnuend_of_file      CONSTANT NUMBER := 1;
    sbL_nom             VARCHAR2(500);
    sbL_ext             VARCHAR2(50);
    vArray              t_string_table := t_string_table();

    nuOrden             or_order.order_id%TYPE;
    nuActOrden          OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
    nuTipRela           OR_ORDER_ACTIVITY.OPERATING_UNIT_ID%TYPE;
    nuActRelac          OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE;
    nuOrOpUnit          or_order.operating_unit_id%TYPE;
    sbComment           OR_ORDER_ACTIVITY.COMMENT_%TYPE;

    --Creacion de log
    sbLineLog           VARCHAR2(1000);
    sbTimeProc          VARCHAR2(100);
    sbLog               VARCHAR2(500);
    sbFileManagementLog pkg_gestionarchivos.styarchivo;
    sbMessage           VARCHAR2(100);

    ---Vbles de la orden
    nuPackage             or_order_activity.package_id%TYPE;
    nuMotive              or_order_activity.motive_id%TYPE;
    nuProduct             or_order_activity.product_id%TYPE;
    nuComponent           or_order_activity.component_id%TYPE;
    nuInstance            or_order_activity.instance_id%TYPE;
    nuSuscriber           or_order_activity.subscriber_id%TYPE;
    nuSuscription         or_order_activity.subscription_id%TYPE;
    nuAdrees              or_order_activity.address_id%TYPE;
    nuElement             or_order_activity.element_id%TYPE;
    nuNewOrder            or_order.order_id%TYPE;
    nuNewActivity         or_order_activity.order_activity_id%TYPE;
    dtExec                or_order_activity.exec_estimate_date%TYPE;
    nuOperating_sector_id or_order_activity.Operating_sector_id%TYPE;
    nuTaskType            or_order_activity.task_type_id%TYPE;
    nuRela_order_type_id  or_related_order.rela_order_type_id%TYPE;
    nuContEstado          NUMBER := 0;
    nuContVal             NUMBER := 0;
    nuContExi             NUMBER := 0;

    onuerrorcode          NUMBER;
    osberrormessage       VARCHAR2(4000);

    --INICIA CA 416
    sbTitrCons            VARCHAR2(4000) := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_TITRCOPR');

    CURSOR cugetProducto iS
    SELECT sesunuse
      FROM servsusc
     WHERE sesususc = nuSuscription
       AND SESUSERV = pkg_bcld_parameter.fnuobtienevalornumerico('COD_TIPO_SERV');

    nuExiste              NUMBER;
    --FIN CA 416
    
    CURSOR cuSolicitudOrden(p_nuorden or_order_activity.order_id%TYPE)
    IS
    SELECT package_id, o.motive_id, o.product_id, o.component_id, o.instance_id, o.subscription_id, o.subscriber_id, o.address_id, o.element_id,
           o.exec_estimate_date, o.operating_sector_id, o.task_type_id
      FROM or_order_activity o
     WHERE o.order_id = p_nuorden;
    
    CURSOR cuDireccionSuscrip( p_nususcription servsusc.sesususc%TYPE)
    IS
    SELECT P.address_id 
      FROM servsusc S, pr_product P
     WHERE S.sesususc = nususcription
       AND P.product_type_id = pkg_bcld_parameter.fnuobtienevalornumerico('COD_TIPO_SERV')
       AND P.product_id = S.sesunuse;

    CURSOR cuSegundaVisita( p_nuActRelac or_task_types_items.items_id%TYPE)
    IS
    SELECT COUNT(1)
      FROM ( SELECT TO_NUMBER(regexp_substr(sbTitrCons,'[^,]+', 1, LEVEL)) titr
               FROM dual
            CONNECT BY regexp_substr(sbTitrCons, '[^,]+', 1, LEVEL) IS NOT NULL) , OR_TASK_TYPES_ITEMS TC
     WHERE TITR = TC.TASK_TYPE_ID
       AND TC.ITEMS_ID = p_nuActRelac;
       
       
       
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    
    sbRuta := ge_boInstanceControl.fsbGetFieldValue('GE_DIRECTORY', 'DIRECTORY_ID');
    pkg_traza.trace(csbMetodo ||' Directorio: ' || sbRuta, csbNivelTraza);
    
    sbRutLogs := fnuGetPath(sbRuta);
    pkg_traza.trace(csbMetodo ||' Directorio del LOG: ' || sbRutLogs, csbNivelTraza);    

    sbFileName := ge_boInstanceControl.fsbGetFieldValue('LD_ACCOUNT_STATUS_CF', 'ACCOUNT_STATE_DESC');
    pkg_traza.trace(csbMetodo ||' Nombre archivo: ' || sbFileName, csbNivelTraza);

    /* Crea archivo Log */

    sbLineLog := 'INICIO PROCESO DE LECTURAS DE ORDENES DE APOYO O ADICIONALES ' || TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS');
    pkg_traza.trace(csbMetodo ||' sbLineLog: ' || sbLineLog, csbNivelTraza);
    
    sbTimeProc := to_char(sysdate, 'yyyymmdd_hh24miss');
    pkg_traza.trace(csbMetodo ||' Tiempo: ' || sbTimeProc, csbNivelTraza);
    
    /* Arma nombre del archivo LOG */

    sbLog := 'ORMAPA_FECHA EJECUCION_' || sbTimeProc || '.LOG';
    pkg_traza.trace(csbMetodo ||' Nombre archivo Log: ' || sbLog, csbNivelTraza);

    sbFileManagementLog := pkg_gestionarchivos.ftabrirarchivo_smf(sbRutLogs, sbLog, 'w');
    pkg_traza.trace(csbMetodo ||' Crea archivo Log: ' || sbLog||' en la ruta: '||sbRutLogs, csbNivelTraza);

    pkg_gestionarchivos.prcescribirlinea_smf(sbFileManagementLog, sbLineLog);

    sbLineLog := ' Inicio el recorrido del archivo ';
    pkg_traza.trace(csbMetodo ||' sbLineLog: '||sbLineLog, csbNivelTraza);

    pkg_gestionarchivos.prcescribirlinea_smf(sbFileManagementLog, sbLineLog);
            
    pkg_traza.trace(csbMetodo ||' Parámetro COD_TIP_ADI_ORMAP: '||pkg_bcld_parameter.fnuobtienevalornumerico('COD_TIP_ADI_ORMAP'), csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' Parámetro COD_REL_ADI_ORMAP: '||pkg_bcld_parameter.fnuobtienevalornumerico('COD_REL_ADI_ORMAP'), csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' Parámetro COD_TIP_APO_ORMAP: '||pkg_bcld_parameter.fnuobtienevalornumerico('COD_TIP_APO_ORMAP'), csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' Parámetro COD_REL_APO_ORMAP: '||pkg_bcld_parameter.fnuobtienevalornumerico('COD_REL_APO_ORMAP'), csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' Parámetro sbTitrCons: ' || sbTitrCons, csbNivelTraza);
    
    IF (sbruta IS NULL) THEN
      onuerrorcode:=pkg_error.CNUGENERIC_MESSAGE;
      osberrormessage:= ' El campo ruta es obligatorio ';
      pkg_traza.trace(csbMetodo ||osberrormessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
      pkg_error.seterrormessage(pkg_error.CNUGENERIC_MESSAGE, osberrormessage);
    END IF;

    IF (sbfilename IS NULL) THEN
      onuerrorcode:=pkg_error.CNUGENERIC_MESSAGE;
      osberrormessage:= ' El campo nombre del archivo es obligatorio ';
      pkg_traza.trace(csbMetodo ||osberrormessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
      pkg_error.seterrormessage(onuerrorcode,  osberrormessage);
    ELSE

      --Iniciamos con el recorrido del archivo plano

      ld_file_api.ProcGetDirList(sbRutLogs, '.txt', vArray);

      nuIndexArray := vArray.first;

      ---Validamos que el archivo exista

      WHILE nuindexarray IS NOT NULL LOOP

        IF (UPPER(VARRAY(nuindexarray)) LIKE '%' || sbfilename || '%') THEN

          BEGIN
            pkg_traza.trace(csbMetodo ||' vArray(nuIndexArray):'||vArray(nuIndexArray), csbNivelTraza);
            sbFileManagement := pkg_gestionarchivos.ftabrirarchivo_smf(sbRutLogs,             -- Ruta del Archivo
                                                                       vArray(nuIndexArray),  -- Nombre del Archivo
                                                                       'r');                  -- [Read]                                                   

          EXCEPTION
            WHEN OTHERS THEN
              sblinelog := NULL;
              sblinelog := '     Error ... No se pudo abrir archivo ';
              pkg_traza.trace(csbMetodo ||' sblinelog: '||sblinelog, csbNivelTraza);
              pkg_gestionarchivos.prcescribirlinea_smf(sbfilemanagementlog, sblinelog);
              GOTO nextfile;
              NULL;
          END;

          nuLinea := 0;

          LOOP
            ------------------------------------------------------------
            -- Inicia Ciclo de Lineas
            ------------------------------------------------------------            
            BEGIN
              sbOnline := pkg_gestionarchivos.fsbobtenerlinea_smf(sbFileManagement);
              pkg_traza.trace(csbMetodo ||' Se obtiene linea: ' || sbOnline, csbNivelTraza);
              nucodigo:=0;
            EXCEPTION WHEN NO_DATA_FOUND THEN
              nucodigo:=1;
            END;
            pkg_traza.trace(csbMetodo ||' nucodigo: ' || nucodigo, csbNivelTraza);              
            
            nuLinea  := nuLinea + 1;
            pkg_traza.trace(csbMetodo ||' nuLinea: ' || nuLinea, csbNivelTraza);
            EXIT WHEN(nuCodigo = cnuend_of_file);

            nuOrden    := NULL;
            nuActOrden := NULL;
            nuTipRela  := NULL;
            nuActRelac := NULL;
            nuOrOpUnit := NULL;
            sbComment  := NULL;
            
            -- Número de la orden
            nuOrden := TO_NUMBER(substr(sbOnline, 1,
                                        instr(sbOnline, '|', 1, 1) - 1));
            pkg_traza.trace(csbMetodo ||' Número de la orden: ' || nuOrden, csbNivelTraza); 
            
            -- Actividad de la orden
            nuActOrden := TO_NUMBER(substr(sbOnline,
                                           instr(sbOnline, '|', 1, 1) + 1,
                                           (instr(sbOnline, '|', 1, 2)) -
                                           (instr(sbOnline, '|', 1, 1) + 1)));
            pkg_traza.trace(csbMetodo ||' Actividad de la orden: ' || nuActOrden, csbNivelTraza); 
            
            -- Tipo de relacion
            nuTipRela := TO_NUMBER(substr(sbOnline,
                                          instr(sbOnline, '|', 1, 2) + 1,
                                          (instr(sbOnline, '|', 1, 3)) -
                                          (instr(sbOnline, '|', 1, 2) + 1)));
            pkg_traza.trace(csbMetodo ||' Tipo de relacion: ' || nuTipRela, csbNivelTraza);
            
            --Actividad a relacionar
            nuActRelac := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 3) + 1,
                                 (instr(sbOnline, '|', 1, 4)) -
                                 (instr(sbOnline, '|', 1, 3) + 1));
            pkg_traza.trace(csbMetodo ||' Actividad a relacionar: ' || nuActRelac, csbNivelTraza);
            
            -- Unidad operativa
            nuOrOpUnit := TO_NUMBER(substr(sbOnline,
                                           instr(sbOnline, '|', 1, 4) + 1,
                                           (instr(sbOnline, '|', 1, 5)) -
                                           (instr(sbOnline, '|', 1, 4) + 1)));
            pkg_traza.trace(csbMetodo ||' Unidad operativa: ' || nuOrOpUnit, csbNivelTraza);
            
            -- Comentario
            sbComment := substr(sbOnline,
                                instr(sbOnline, '|', 1, 5) + 1,
                                (instr(sbOnline, '|', 1, 6)) -
                                (instr(sbOnline, '|', 1, 5) + 1));
            pkg_traza.trace(csbMetodo ||' Comentario: ' || sbComment, csbNivelTraza);
            
            ---Proceso de validacion
            IF (nutiprela = 1) THEN
              sbmessage := 'Actividad de apoyo';
            ELSE
              sbmessage := 'Actividad adicional';
            END IF;
            pkg_traza.trace(csbMetodo ||' Proceso de validacion: ' || sbmessage, csbNivelTraza);
            
            --Se valida el estado de la orden este en estado 5 o 7
            
            sbLineLog := NULL;

            IF (fnugetstatus(nuorden) = 0) THEN
              pkg_traza.trace(csbMetodo ||' Inicia validación estado de la orden este en estado 5 o 7 ', csbNivelTraza);
              
              nucontestado := nucontestado + 1;
              sblinelog    := '     El estado de la orden no valido.. Orden Padre: ' || nuorden || ' Tipo relacion: ' || sbmessage;
              pkg_traza.trace(csbMetodo ||' sblinelog: ' || sblinelog, csbNivelTraza);
              pkg_gestionarchivos.prcescribirlinea_smf(sbfilemanagementlog, sblinelog);
              
              pkg_traza.trace(csbMetodo ||' Fin validación estado de la orden este en estado 5 o 7 ', csbNivelTraza);
              GOTO nextline;

            END IF;            

            ---Se valida que la actividad a relacionar exista en la tabla exista
            --relación entre esta actividad y  la actividad de la orden (activity_id)  en la tabla OR_SUPPORT_ACTIVITY.
            
            sbLineLog := NULL;

            IF (fnugetactsupport(nuactrelac, nuactorden) = 0) THEN
              pkg_traza.trace(csbMetodo ||' Inicia validación actividad a relacionar exista en la tabla OR_SUPPORT_ACTIVITY ', csbNivelTraza);
              
              nucontval := nucontval + 1;
              sblinelog := '     Actividad a relacionar no es valida.. Orden Padre: ' || nuorden || ' Actividad relacionar: ' ||
                           nuactrelac || ' Actividad: ' || nuactorden || ' Tipo relacion: ' || sbmessage;
              pkg_traza.trace(csbMetodo ||' sblinelog: ' || sblinelog, csbNivelTraza);
              pkg_gestionarchivos.prcescribirlinea_smf(sbfilemanagementlog, sblinelog);
              
              pkg_traza.trace(csbMetodo ||' Fin validación actividad a relacionar exista en la tabla exista ', csbNivelTraza);
              GOTO nextline;

            END IF;            

            --Se crea la orden dependiendo la actividad
            --Se consulta la solicitud asociada a la orden

            nuPackage             := NULL;
            nuMotive              := NULL;
            nuSuscriber           := NULL;
            nuMotive              := NULL;
            nuProduct             := NULL;
            nuComponent           := NULL;
            nuInstance            := NULL;
            nuSuscription         := NULL;
            nuAdrees              := NULL;
            nuElement             := NULL;
            dtExec                := NULL;
            nuOperating_sector_id := NULL;
            nuTaskType            := NULL;

            OPEN cuSolicitudOrden(nuOrden);
            FETCH cuSolicitudOrden INTO nuPackage,
                                       nuMotive,
                                       nuProduct,
                                       nuComponent,
                                       nuInstance,
                                       nuSuscription,
                                       nuSuscriber,
                                       nuAdrees,
                                       nuElement,
                                       dtExec,
                                       nuOperating_sector_id,
                                       nuTaskType;
            CLOSE cuSolicitudOrden;
            pkg_traza.trace(csbMetodo ||' cuSolicitudOrden--> nuPackage:        ' || nuPackage, csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' cuSolicitudOrden--> nuMotive:         ' || nuMotive, csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' cuSolicitudOrden--> nuProduct:        ' || nuProduct, csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' cuSolicitudOrden--> nuComponent:      ' || nuComponent, csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' cuSolicitudOrden--> nuInstance:       ' || nuInstance, csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' cuSolicitudOrden--> nuSuscription:    ' || nuSuscription, csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' cuSolicitudOrden--> nuSuscriber:      ' || nuSuscriber, csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' cuSolicitudOrden--> nuAdrees:         ' || nuAdrees, csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' cuSolicitudOrden--> nuElement:        ' || nuElement, csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' cuSolicitudOrden--> dtExec:           ' || dtExec, csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' cuSolicitudOrden--> nuOperating_sector_id: ' || nuOperating_sector_id, csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' cuSolicitudOrden--> nuTaskType:       ' || nuTaskType, csbNivelTraza);

            --Consultamos la direccion asociada a la orden sino buscamos la direccion asociada al producto de gas

            IF (nuadrees IS NULL) THEN

              OPEN cuDireccionSuscrip(nususcription);
              FETCH cuDireccionSuscrip INTO nuadrees;
              CLOSE cuDireccionSuscrip;
              pkg_traza.trace(csbMetodo ||' cuDireccionSuscrip--> nuadrees:' || nuadrees, csbNivelTraza);
             
            END IF;
            
            --INICIA CA 416
            IF nuProduct IS NULL THEN
                
               --se valida si es segunda visita
                OPEN cuSegundaVisita(nuActRelac);
                FETCH cuSegundaVisita INTO nuExiste;
                CLOSE cuSegundaVisita;
                pkg_traza.trace(csbMetodo ||' cugetProducto-->nuExiste: ' || nuExiste, csbNivelTraza);
                
                IF nuExiste > 0 THEN

                  IF cugetProducto%ISOPEN THEN
                     CLOSE cugetProducto;
                  END IF;

                  OPEN cugetProducto;
                  FETCH cugetProducto INTO nuProduct;
                  CLOSE cugetProducto;
                  pkg_traza.trace(csbMetodo ||' cugetProducto-->nuProduct: ' || nuProduct, csbNivelTraza);
                  
                END IF;

            END IF;
            --FIN CA 416
            
            --Creacion de la orden
            nuNewOrder    := NULL;
            nuNewActivity := NULL;

      
           api_createorder( nuActRelac,     --inuItemsid 
                            nuPackage,      --inuPackageid
                            nuMotive,       --inuMotiveid
                            NULL,           --inuComponentid
                            NULL,           --inuInstanceid
                            nuAdrees,       --inuAddressid
                            NULL,           --inuElementid
                            NULL,           --inuSubscriberid
                            nuSuscription,  --inuSubscriptionid
                            nuProduct,      --inuProductid
                            NULL,           --inuOperunitid
                            NULL,           --idtExecestimdate
                            NULL,           --inuProcessid
                            sbComment,      --isbComment
                            NULL,           --iblProcessorder
                            NULL,           --inuPriorityid
                            null,           --inuOrdertemplateid
                            NULL,           --isbCompensate
                            NULL,           --inuConsecutive
                            NULL,           --inuRouteid
                            NULL,           --inuRouteConsecutive
                            0,              --inuLegalizetrytimes
                            NULL,           --isbTagname
                            NULL,           --iblIsacttoGroup
                            NULL,           --inuRefvalue
                            NULL,           --inuActionid
                            nuNewOrder,     --ionuOrderid
                            nuNewActivity,  --ionuOrderactivityid
                            onuErrorCode,
                            osbErrorMessage);   
            
            pkg_traza.trace(csbMetodo ||' api_createorder-->osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' api_createorder-->nuNewOrder: ' || nuNewOrder, csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' api_createorder-->nuNewActivity: ' || nuNewActivity, csbNivelTraza);
            
            sbLineLog := NULL;

            IF (nuneworder IS NULL) THEN

              sblinelog := '   No se pudo crear la nueva orden... Orden Padre: ' || nuorden || ' Actividad: ' || nuactorden||', '||osbErrorMessage;
              pkg_traza.trace(csbMetodo ||' No se pudo crear la nueva orden... Orden Padre: ' || nuorden || ' Actividad: ' || nuactorden||', '||osbErrorMessage, csbNivelTraza);
              pkg_gestionarchivos.prcescribirlinea_smf(sbfilemanagementlog, sblinelog);
              GOTO nextline;

            END IF;

            --Se actualizan los valores si la solicitud es diferente a NULL.

            IF (nuneworder IS NOT NULL) THEN

              IF (nupackage IS NOT NULL) THEN
                pkg_traza.trace(csbMetodo ||' Se actualizan los valores si la solicitud es diferente a NULL.', csbNivelTraza);
                pkg_gestionarchivos.prcescribirlinea_smf(sbFileManagementLog, sbLineLog);

                daor_order_activity.updcomponent_id(daor_order_activity.fnugetorder_activity_id(nuNewActivity), nuComponent);
                daor_order_activity.updinstance_id(daor_order_activity.fnugetorder_activity_id(nuNewActivity), nuInstance);
                daor_order_activity.updelement_id(daor_order_activity.fnugetorder_activity_id(nuNewActivity), nuElement);
                daor_order_activity.updsubscriber_id(daor_order_activity.fnugetorder_activity_id(nuNewActivity), nuSuscriber);
                daor_order_activity.updexec_estimate_date(daor_order_activity.fnugetorder_activity_id(nuNewActivity), dtExec);
                daor_order_activity.updoperating_sector_id(daor_order_activity.fnugetorder_activity_id(nuNewActivity), nuOperating_sector_id);
				daor_order_activity.updorigin_activity_id(daor_order_activity.fnugetorder_activity_id(nuNewActivity),  nuActOrden);--200-2686

              END IF;
            END IF;

            COMMIT;

            IF (nutiprela = pkg_bcld_parameter.fnuobtienevalornumerico('COD_TIP_ADI_ORMAP')) THEN
            
                nurela_order_type_id := pkg_bcld_parameter.fnuobtienevalornumerico('COD_REL_ADI_ORMAP');
                
            ELSIF (nutiprela = pkg_bcld_parameter.fnuobtienevalornumerico('COD_TIP_APO_ORMAP')) THEN
            
                nurela_order_type_id := pkg_bcld_parameter.fnuobtienevalornumerico('COD_REL_APO_ORMAP');
            
            END IF;
            pkg_traza.trace(csbMetodo ||' nurela_order_type_id: '||nurela_order_type_id, csbNivelTraza);
            
            --Relacion de la orden creada
            INSERT INTO or_related_order
              (order_id, related_order_id, rela_order_type_id)
            VALUES
              (nuorden, nuneworder, nurela_order_type_id);
            pkg_traza.trace(csbMetodo ||' INSERT INTO or_related_order, order_id: '||nuorden||', related_order_id: '||nuneworder
                                      ||', rela_order_type_id: '||nurela_order_type_id, csbNivelTraza);
            
            sblinelog := NULL;

            sbLineLog := '    Relacion Creada de ...' || sbMessage ||  ' Orden Padre: ' || nuOrden || ' Orden Hija: ' || nuNewOrder;
            pkg_traza.trace(csbMetodo ||' Relacion Creada de ...' || sbMessage ||  ' Orden Padre: ' || nuOrden || ' Orden Hija: ' || nuNewOrder, csbNivelTraza);
            
            pkg_gestionarchivos.prcescribirlinea_smf(sbFileManagementLog, sbLineLog);
            nuContExi := nuContExi + 1;

            --Se asigna a la unidad operativa
            IF (nuOrOpUnit IS NOT NULL) THEN

              api_assign_order(TO_NUMBER(nuNewOrder),   --inuOrder
                               nuOrOpUnit,              --inuOperatingUnit
                               onuerrorcode,            --onuErrorCode
                               osberrormessage);        --osbErrorMessage 
              
              pkg_traza.trace(csbMetodo ||' api_assign_order-->osberrormessage: '||osberrormessage, csbNivelTraza);
              sbLineLog := NULL;

              IF (osberrormessage IS NOT NULL) THEN
                sbLineLog := ' Error..' || osberrormessage || ' Orden: ' || nuNewOrder || ' Actividad: ' || nuNewActivity;
                pkg_traza.trace(csbMetodo ||' Error..' || osberrormessage || ' Orden: ' || nuNewOrder || ' Actividad: ' || nuNewActivity, csbNivelTraza);
                pkg_gestionarchivos.prcescribirlinea_smf(sbFileManagementLog, sbLineLog);
              END IF;

            END IF;

            <<nextLine>>
            NULL;
            COMMIT;

          END LOOP;

        END IF;

        <<nextFile>>
        nuIndexArray := vArray.next(nuIndexArray);

      END LOOP;

      sbLineLog := '   Proceso Finalizado exitosamente .. Exito: ' || nuContExi || ' Rechazadas por estado: ' || nuContEstado ||' Rechazadas por actividad: ' || nuContVal;
      pkg_traza.trace(csbMetodo ||' Proceso Finalizado exitosamente .. Exito: ' || nuContExi || ' Rechazadas por estado: ' || nuContEstado ||' Rechazadas por actividad: ' || nuContVal, csbNivelTraza);
      pkg_gestionarchivos.prcescribirlinea_smf(sbFileManagementLog, sbLineLog);

      pkg_gestionarchivos.prccerrararchivo_smf(sbFileManagement);
      pkg_gestionarchivos.prccerrararchivo_smf(sbFileManagementLog);

    END IF;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    EXCEPTION
        WHEN pkg_error.controlled_error THEN 
            ROLLBACK;
            pkg_gestionarchivos.prccerrararchivo_smf(sbfilemanagement);
            pkg_gestionarchivos.prccerrararchivo_smf(sbfilemanagementlog);
            pkg_error.geterror(onuerrorcode, osberrormessage);
            pkg_traza.trace(csbmetodo ||' osberrormessage: ' || osberrormessage, csbniveltraza);
            pkg_traza.trace(csbmetodo, csbniveltraza, pkg_traza.csbfin_erc);
            RAISE pkg_error.controlled_error;             
        WHEN OTHERS THEN 
            ROLLBACK;
            pkg_gestionarchivos.prccerrararchivo_smf(sbfilemanagement);
            pkg_gestionarchivos.prccerrararchivo_smf(sbfilemanagementlog);
            pkg_error.seterror;
            pkg_error.geterror(onuerrorcode, osberrormessage);
            pkg_traza.trace(csbmetodo ||' osberrormessage: ' || osberrormessage, csbniveltraza);
            pkg_traza.trace(csbmetodo, csbniveltraza, pkg_traza.csbfin_err);
            RAISE pkg_error.controlled_error; 

  END PROCGENORAPOADIC;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuGetPath
  Descripcion    : Obtiene la ruta del path a partir del id del directorio
  Autor          : AAcuna
  Fecha          : 14/04/2016

  Parametros         Descripcion
  ============   ===================

  Historia de Modificaciones
  Fecha            Autor            Modificacion
  =========      =========          ====================
  14-04-2016     AAcuna             Creación
  27/03/2024     Adrianavg          OSF-2380: Se declara variable para nombre del método
                                    Se declaran variables para gestionar el error
                                    Se reemplaza SELECT-INT por cursor cuDirectorio
                                    Se ajusta bloque de exception según pautas técnicas
  04/04/2024    pacosta             Se elimina "RETURN NULL;" despues de llamados a "RAISE pkg_Error.Controlled_Error;" 
                                    debido a que el return null nunca se ejecutaría
  ******************************************************************/

  FUNCTION fnuGetPath(inuDirectorId IN ge_directory.directory_id%TYPE)
    RETURN VARCHAR2 IS
    --Se declara variable para nombre del método
    csbMetodo  		    CONSTANT VARCHAR2(100)  := csbNOMPKG||'fnuGetPath';
    --Se declaran variables para gestionar el error
    Onuerrorcode        NUMBER                  := pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage     VARCHAR2(2000);    
    
    sbPath ge_directory.path%TYPE;
    
    CURSOR cuDirectorio
    IS
    SELECT PATH 
      FROM ge_directory G
     WHERE G.directory_id = inudirectorid;
     
  BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inuDirectorId: ' || inuDirectorId, csbNivelTraza);
    
    OPEN cuDirectorio;
    FETCH cuDirectorio INTO sbPath;
    CLOSE cuDirectorio; 
    pkg_traza.trace(csbMetodo ||' sbPath: ' || sbPath, csbNivelTraza);
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN sbPath;

  EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR THEN
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.Controlled_Error;        
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.Controlled_Error;         
  END fnuGetPath;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuGetActSupport
  Descripcion    : Valida que la actividad a relacionar tenga relacion con la atividad en la tabla
                   OR_SUPPORT_ACTIVITY
  Autor          : AAcuna
  Fecha          : 14/04/2016

  Parametros         Descripcion
  ============   ===================

  Historia de Modificaciones
  Fecha            Autor            Modificacion
  =========      =========          ====================
  31-10-2016     KBaquero           Se modifica la consulta para colocarle un cruce entre entidades
  14-04-2016     AAcuna             Creación
  27/03/2024     Adrianavg          OSF-2380: Se declara variable para nombre del método
                                    Se declaran variables para gestionar el error
                                    Se reemplaza SELECT-INT por cursor cuActivOrden
                                    Se ajusta bloque de exception según pautas técnicas
  04/04/2024    pacosta             Se elimina "RETURN NULL;" despues de llamados a "RAISE pkg_Error.Controlled_Error;" 
                                    debido a que el return null nunca se ejecutaría
  ******************************************************************/

  FUNCTION fnuGetActSupport(nuActRelacionar IN OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE,
                            nuActOrden      IN OR_ORDER_ACTIVITY.ORDER_ID%TYPE)
    RETURN NUMBER IS
    --Se declara variable para nombre del método
    csbMetodo  		    CONSTANT VARCHAR2(100)  := csbNOMPKG||'fnuGetActSupport';
    --Se declaran variables para gestionar el error
    Onuerrorcode        NUMBER                  := pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage     VARCHAR2(2000);
    
    nuActOr NUMBER;
    
    CURSOR cuActivOrden
    IS
    SELECT COUNT(*) 
     FROM or_support_activity O,or_order_activity A
    WHERE O.activity_id=A.activity_id
      AND A.order_activity_id = nuActOrden
      AND O.support_activity_id = nuActRelacionar;    
  BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' nuActRelacionar: ' || nuActRelacionar, csbNivelTraza);  
    pkg_traza.trace(csbMetodo ||' nuActOrden: ' || nuActOrden, csbNivelTraza);  

    OPEN cuActivOrden;
    FETCH cuActivOrden INTO nuActOr;
    CLOSE cuActivOrden;
    
    pkg_traza.trace(csbMetodo ||' La actividad a relacionar '||nuActRelacionar||' tiene relacion con la actividad de orden: ' || nuActOr, csbNivelTraza);  
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN nuActOr;

  EXCEPTION
    WHEN pkg_Error.controlled_error THEN
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.Controlled_Error;  
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.Controlled_Error; 
  END fnuGetActSupport;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FNUGETSTATUS
  Descripcion    : Valida que el estado de la orden se encuentre en 5 o 7
  Autor          : AAcuna
  Fecha          : 14/04/2016

  Parametros         Descripcion
  ============   ===================

  Historia de Modificaciones
  Fecha            Autor            Modificacion
  =========      =========          ====================
  14-04-2016     AAcuna             Creación
  27/03/2024     Adrianavg          OSF-2380: Se declara variable para nombre del método
                                    Se declaran variables para gestionar el error
                                    Se reemplaza dald_parameter.fnuGetNumeric_Value por pkg_bcld_parameter.fnuobtienevalornumerico
                                    Se ajusta bloque de exception según pautas técnicas
  04/04/2024    pacosta             Se elimina "RETURN NULL;" despues de llamados a "RAISE pkg_Error.Controlled_Error;" 
                                    debido a que el return null nunca se ejecutaría
  ******************************************************************/

  FUNCTION fnuGetStatus(inuOrder IN OR_ORDER_ACTIVITY.Order_Id%TYPE)
    RETURN NUMBER IS
    --Se declara variable para nombre del método
    csbMetodo  		    CONSTANT VARCHAR2(100)  := csbNOMPKG||'fnuGetStatus';
    --Se declaran variables para gestionar el error
    Onuerrorcode        NUMBER                  := pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage     VARCHAR2(2000);
    
    nuStatusOr NUMBER;

    CURSOR cuEstadoOrden
    IS
    SELECT COUNT(*) 
      FROM or_order O
     WHERE O.order_status_id IN (pkg_bcld_parameter.fnuobtienevalornumerico('ESTADO_ASIGNADO'), pkg_bcld_parameter.fnuobtienevalornumerico('COD_ESTA_EJEC'))
       AND O.order_id = inuorder;
       
  BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inuOrder: ' || inuOrder, csbNivelTraza);  
    
    pkg_traza.trace(csbMetodo ||' Parámetro ESTADO_ASIGNADO: ' || pkg_bcld_parameter.fnuobtienevalornumerico('ESTADO_ASIGNADO'), csbNivelTraza);  
    pkg_traza.trace(csbMetodo ||' Parámetro COD_ESTA_EJEC: ' || pkg_bcld_parameter.fnuobtienevalornumerico('COD_ESTA_EJEC'), csbNivelTraza);  
    
    OPEN cuEstadoOrden;
    FETCH cuEstadoOrden INTO nuStatusOr;
    CLOSE cuEstadoOrden;
    pkg_traza.trace(csbMetodo ||' nuStatusOr: ' || nuStatusOr, csbNivelTraza);  
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN nuStatusOr;

  EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR THEN
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.Controlled_Error;      
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.Controlled_Error;      
  END fnuGetStatus;

END LDC_BOGENORAPOADIC;
/
