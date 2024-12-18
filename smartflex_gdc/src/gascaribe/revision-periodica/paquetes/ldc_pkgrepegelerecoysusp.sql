CREATE OR REPLACE PACKAGE LDC_PKGREPEGELERECOYSUSP IS
  /***************************************************************************
          Propiedad Intelectual de Gases del Caribe
          Programa        : ldc_pkgrepegelerecoysusp
          Descripcion     : paquete para gestion de solicitudes:
                            Trámite reconexión sin certificación por medio de XML
                            Job Legalización de órdenes reconexión y suspensión administrativa
                            Crear solicitud reconexión sin sertificación
                            Crear solicitud suspensión administrativa
                            Generación trámite suspensión
  
                            
          Autor           : 
          Fecha           : 
  
          Historia de Modificaciones
          Fecha               Autor                Modificacion
        =========           =========          ====================
        15/12/2023          epenao            OSF-1866 Proyecto Organización
                                              +Cambio de daab_address.fnugetgeograp_location_id  x pkg_bcdirecciones.fnugetlocalidad
                                              +Cambio os_addordercomment x api_addordercomment
                                              +Cambio dage_causal.fnugetclass_causal_id x pkg_bcordenes.fnuobtieneclasecausal
                                              +Cambio dapr_product.fnugetaddress_id x pkg_bcproducto.fnuiddireccinstalacion
                                              +Cambio ge_bopersonal.fnugetpersonid x pkg_bopersonal.fnugetpersonaid
                                              +Cambio de ut_trace por gestión de traza personalizada
                                              +Cambio daor_order.fnugettask_type_id x pkg_bcordenes.fnuobtienetipotrabajo
                                              +Cambio daor_order.fnugetoperating_unit_id x pkg_bcordenes.fnuobtieneunidadoperativa
                                              +Cambio ldc_proinsertaestaprog x pkg_estaproc.prinsertaestaproc
                                              +Cambio ldc_proactualizaestaprog x pkg_estaproc.prActualizaEstaproc
                                              +Cambio os_registerrequestwithxml x api_registerrequestbyxml
                                              +Cambio daor_order_person.fnugetperson_id x pkg_bcordenes.fnuobtenerpersona
                                              +Cambio de ldc_boutilities.splitstrings por el uso de regexp_substr
                                              +Cambio daor_order.fdtgetexec_initial_date x pkg_bcordenes.fdtobtienefechaejecuini
                                              +Cambio or_bolegalizeorder.fnuGetCurrentOrder x pkg_bcordenes.fnuobtenerotinstancialegal
                                              +Cambio daor_order.fdtgetassigned_date x pkg_bcordenes.fdtobtienefechaasigna
                                              +Cambio os_assign_order x api_assign_order
                                              +Cambio daor_order.fdtgetexecution_final_date x pkg_bcordenes.fdtobtienefechaejecufin
                                              +Cambio os_createorderactivities x api_createorder
                                              +Cambio dage_geogra_location.fnugetgeo_loca_father_id x pkg_bcdirecciones.fnugetubicageopadre
                                              +Cambio daor_order.fnugetcausal_id x pkg_bcordenes.fnuobtienecausal 
                                              +Se elimina la excepción erPrograma y se realiza el manejo de la excepción personalizada PKG_ERROR.CONTROLLED_ERROR
                                              +Corrección de errores de lógica en funciones que no retornan valor por el mal manejo de excepciones. 
                                              +Eliminación de las variables no usadas. 
                                              +Se llevan a constantes las cadenas que se repiten más de 10 veces.
                                              +Cambio de algunos tabs por espacios y ajuste de identación para permitir la legibilidad del código. 
        10/01/2024          epenao            Caso OSF-1866:  En el llamado al método:  api_createorder   se adicionan los parámetros: 
                                                           inuPackageid, inuSubscriptionid, inuProductid
                                              Para que sean utilizados en la creación del registro en OR_ORDER_ACTIVITY.                                               
  ***************************************************************************/

  --Job para legalizar órdenes recnexión y suspensión administrativa
  PROCEDURE JOB_LEGAORDENRECOYSUSPADMI;

  --Crear solicitud suspensión administrativa
  PROCEDURE LDC_PROCREASOLISUSPADMI;

  --Crea solicitud reconexión sin certificado
  PROCEDURE LDC_PRCREASOLIRECOSINCERT;

  --Genera trámite suspensión
  FUNCTION FUNGENTRAMITESUSPE(nuProdcut_ID PR_PRODUCT.PRODUCT_ID%type,
                              nuMarca      LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID%TYPE,
                              nuorden      IN or_order.order_id%type,
                              nuSolicitud  IN mo_packages.package_id%type,
                              sbmensa      OUT VARCHAR2) RETURN NUMBER;

  --Registra log legalización orden reconexión y suspensión
  PROCEDURE proRegistraLogLegOrdRecoSusp(sbProceso    IN LDC_LOGERRLEORRESU.proceso%TYPE,
                                         dtFecha      IN LDC_LOGERRLEORRESU.fechgene%TYPE,
                                         nuOrden      IN LDC_LOGERRLEORRESU.order_id%TYPE,
                                         nuOrdenPadre IN LDC_LOGERRLEORRESU.ordepadre%TYPE,
                                         sbError      IN LDC_LOGERRLEORRESU.menserror%TYPE,
                                         sbUsuario    IN LDC_LOGERRLEORRESU.usuario%TYPE);
  /**************************************************************************
     Autor       : Luis Javier Lopez Barrios / Horbath
     Fecha       : 2018-14-04
     Ticket      :
     Descripcion : Proceso que genera log de errores
  
     Parametros Entrada
     sbProceso  nombre del proceso
     dtFecha    fecha de generacion
     nuProducto producto
     sbError    mensaje de error
     nuSesion   numero de sesion
     sbUsuario  usuario
  
     Valor de salida
  
     Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
   25/10/2018          Eduardo Cerón      Caso 200-2096: Se ajusta para incluir los cursores cuOrdersAcomRP y cuOrderByRepara
   25/05/2018          jbrito             caso 200-1956 JOB_LEGAORDENRECOYSUSPADMI Se valida si la causal de la orden padre que se legaliza
                                          tiene configuración de marca, sino la tiene no debe generar el trámite
   23/12/2019          HORBATH            CA 147 se coloca proceso en la especificacion
  
  ***************************************************************************/

END LDC_PKGREPEGELERECOYSUSP;
/

CREATE OR REPLACE PACKAGE BODY LDC_PKGREPEGELERECOYSUSP IS

  csbNOMPKG         CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.'; -- Constantes para el control de la traza
  cnuCOD_STATUS_REG CONSTANT ld_parameter.numeric_value%type := pkg_bcld_parameter.fnuobtienevalornumerico('COD_STATUS_REG');
																										 
  csbPatronRegex    CONSTANT VARCHAR2(10) := '[^, ]+';
  csbCadError       CONSTANT VARCHAR2(35) := 'Proceso termino con errores : ';
  csbPrintError     CONSTANT VARCHAR2(10) := '], error ';
  csbPrinErrExc     CONSTANT VARCHAR2(10) := 'Error:';
  nuCodError NUMBER;
  sbMensErro VARCHAR2(4000);

  PROCEDURE proRegistraLogLegOrdRecoSusp(sbProceso    IN LDC_LOGERRLEORRESU.proceso%TYPE,
                                         dtFecha      IN LDC_LOGERRLEORRESU.fechgene%TYPE,
                                         nuOrden      IN LDC_LOGERRLEORRESU.order_id%TYPE,
                                         nuOrdenPadre IN LDC_LOGERRLEORRESU.ordepadre%TYPE,
                                         sbError      IN LDC_LOGERRLEORRESU.menserror%TYPE,
                                         sbUsuario    IN LDC_LOGERRLEORRESU.usuario%TYPE) IS
    /**************************************************************************
       Autor       : Luis Javier Lopez Barrios / Horbath
       Fecha       : 2018-14-04
       Ticket      :
       Descripcion : Proceso que genera log de errores
    
       Parametros Entrada
       sbProceso  nombre del proceso
       dtFecha    fecha de generacion
       nuProducto producto
       sbError    mensaje de error
       nuSesion   numero de sesion
       sbUsuario  usuario
    
       Valor de salida
    
       Historia de Modificaciones
       Fecha               Autor                Modificacion
     =========           =========          ====================
     25/10/2018          Eduardo Cerón      Caso 200-2096: Se ajusta para incluir los cursores cuOrdersAcomRP y cuOrderByRepara
     25/05/2018          jbrito             caso 200-1956 JOB_LEGAORDENRECOYSUSPADMI Se valida si la causal de la orden padre que se legaliza
                                            tiene configuración de marca, sino la tiene no debe generar el trámite
     23/12/2019          HORBATH            CA 147 se coloca proceso en la especificacion
    ***************************************************************************/
  
    PRAGMA AUTONOMOUS_TRANSACTION;
    csbMetodo CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                        'proRegistraLogLegOrdRecoSusp'; --Nombre del método en la traza
  
  BEGIN
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    INSERT INTO LDC_LOGERRLEORRESU
      (proceso, fechgene, order_id, ordepadre, menserror, usuario)
    VALUES
      (sbProceso, dtFecha, nuOrden, nuOrdenPadre, sbError, sbUsuario);
    COMMIT;
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
      pkg_error.setError;
      pkg_error.getError(nuCodError, sbMensErro);
      pkg_traza.trace(csbPrinErrExc || nuCodError || '-' || sbMensErro,
                      pkg_traza.cnuNivelTrzDef);
	
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
	
  END proRegistraLogLegOrdRecoSusp;

  PROCEDURE JOB_LEGAORDENRECOYSUSPADMI IS
    /*
       Historia de Modificaciones
         Fecha               Autor                Modificacion
       =========           =========          ====================
       27/07/2018          dsaltarin          CASO 200-2062 se agrega parametro VALIDA_MEDID_ACTUAL para validar si se busca el medidor actual o el de la fecha de ejecucion
                                                            si la fecha final de ejecución de la orden padre no tiene hora se le suma 1 hora.
    
       03/09/2018          dsaltarin          Caso 200-2153 Se modifica para que si el producto ha tenido cambio de medidor envie el medidor actual y lectura actual
    
       18/09/2018          JOSH BRITO         CASO 200-2073 crear suspension segun los usuarios registrados en la tabla LDC_PRODUCTOPARASUSP despues de reconectar el producto
    
       17/01/2019          Jorge Valiente     CASO 200-2390: Se agrega a la losgica del CASO 200-2073 el cursor CUOOR_RELATED_ORDER para
                                                             identificar la OT padre de donde nace la OT Hija del error.
    
    
       30/01/2019          elal               caso 200-2231 se coloca nuevo cursor para legalizacion de VSI del proceso de autoreconectado
       11/06/2019          dsaltarin          caso 200-2680 se corrige registro de error de la orden de vsi de autorectonectados
    
       23/12/2019          horbath            CA 147        se realiza asigancion de ordenes marcadas en LDC_ORDEASIGPROC  con el proceso
                                                            ASIGAUTRP
    
       07/09/2020          dsaltarin          213-          Se elimina validacion de si la entrega aplica para la gasera
    
       07/09/2020          Horbath           caso: 466     Se agregar logica para legalizar la ordenes marcada en la tabla ldc_ordeasigproc con el proceso de plazo minimo.
    
       18/02/2020          Olsoftware        caso 588      Se agrega el proceso de asignacion automatica en la cual cursores buscan las ordenes con TT configurado en los parametros de este caso
                                                           y procede a asignar la unidad operativa que haya legalizado algun ultimo la orden con estos TT.
       19/03/2021          LJLB              CA 472        se adicionan proceso para legalizar ordenes de la tabla LDC_PRODUCTOPARASUSP con nombre de proceso USER_YA_SUSPE_ACO
                                                           modificar cursor CUORDENRECONEXION  para que valide la tabla LDC_ORDEASIGPROC con nombre de proceso RECOSUSPRP
                                                           consultar tabla LDC_ORDEASIGPROC con nombre de proceso SUSPDUMYRP, y valide que la orden este registrada,
                                                           en caso afirmativo, asigne y legalice orden de suspensi¿n
       09/06/2021          Horbath           CASO 753:     Se modifica la logica para establecer la forma de obtenci¿n de las variables ¿nutipoCausal¿ y ¿nuCausal¿,
                                                           Si el desarrollo aplica para la gasera y si el causal de legalizaci¿n de la orden actual es igual a
                                                           la configurada en el par¿metro COD_CAU_DEF_CRIT_PERM_SUSP.
        14/07/2023         jeerazoer        Caso OSF-1260: 
                                                           1. Se reemplaza el llamado del API OS_LEGALIZEORDERS, por el API API_LEGALIZEORDERS.
                                                           2. Se ajusta el manejo de errores por el pkg_Error.
                                                           3. Se elimina las funciones fblAplicaEntregaxCaso y fblaplicaentrega, para las entregas la cual retorna true.
    */
  
    csbPRograma                    CONSTANT VARCHAR2(50) := 'JOB_LEGAORDENRECOYSUSPADMI';
    csbMetodo                      CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                                             csbPRograma; --Nombre del método en la traza
    csbCAU_NO_ASIGAUTO_XFECHMINREV CONSTANT ldc_pararepe.paravast%type := pkg_bcldc_pararepe.fsbobtienevalorcadena('CAU_NO_ASIGAUTO_XFECHMINREV');
    csbTITR_ASIGN_DEFECTOS_REFORMA CONSTANT ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('TITR_ASIGN_DEFECTOS_REFORMAS');
																													
    csbTITR_UNIDAD_ASIG_REFORMAS   CONSTANT ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('TITR_UNIDAD_ASIG_REFORMAS');
																													
    csbTITR_ASIGN_CERT_REFORMAS    CONSTANT ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('TITR_ASIGN_CERT_REFORMAS');
																													
    csbTITR_UNIDAD_ASIG_CERTVISIT  CONSTANT ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('TITR_UNIDAD_ASIG_CERTVISIT');
																													
  
    --CASO 200-2390
    cursor CUOOR_RELATED_ORDER(InuOTHIJA number) is
      select oro.order_id
        from or_related_order oro
       where oro.related_order_id = InuOTHIJA;
    rfCUOOR_RELATED_ORDER CUOOR_RELATED_ORDER%rowtype;
  
    nuOTPadre number;
    --------------------------
  
    nuOrdenGene or_order.order_id%TYPE;
    nuActividad OR_ORDER_ACTIVITY.order_activity_id%TYPE;
  
    dtFechaAsig    or_order.ASSIGNED_DATE%TYPE;
    dtFechaEjecIni or_order.EXEC_INITIAL_DATE%TYPE;
    dtFechaEjecFin or_order.EXECUTION_FINAL_DATE%TYPE;
    sbmensa        VARCHAR2(10000);
  
    nuCausalLegaReco ge_causal.causal_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_CAUSLEGRECSCERT');
																						  
    nuCausalLega     ge_causal.causal_id%type;
    nuClaseCausal    NUMBER;
    sbItemLegaReco   VARCHAR2(1000) := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_CODITEMRECOSCERT');
																			  
    sbItemLegaSusp   VARCHAR2(1000) := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_CODITEMSUSPADMI');
																			  
  
    nuCodigoAtrib NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_CODIATRLECTRECOSCERT');
																	 
  
    nuLectura         NUMBER;
    nuorden           or_order.order_id%type;
    nuunidadoperativa or_order.operating_unit_id%TYPE;
    nuTipoSuspLega    NUMBER;
    nuerrorcode       NUMBER;
    sberrormessage    VARCHAR2(10000);
    nuProductId       NUMBER;
    sbComentario      VARCHAR2(4000);
    sbOrden           VARCHAR2(50);
    nuPosiIni         NUMBER;
    nuOk              NUMBER;
    --------------------
    -- caso 200-1956 -->
    --------------------
    numarcaOtPadre NUMBER;
    --------------------
    -- caso 200-1956 <--
    --------------------
  
    nuCausalLegUsuSup  ge_causal.causal_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_CAUSLEGUSSUSP');
																							
    nuCausalLegUsuNSup ge_causal.causal_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_CAUSLEGUSNSUSP');
																							
  
    nuPersonaLega ge_person.person_id%TYPE := pkg_bopersonal.fnugetpersonaid;
    nuEstado      pr_product.PRODUCT_STATUS_ID%TYPE;
  
    sbpersona     VARCHAR2(100);
    nuEstSolRegis number := pkg_bcld_parameter.fnuobtienevalornumerico('ESTADO_SOL_REGISTRADA');
																							
  
    sbTitrReco    varchar2(1000) := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_TIPO_TRAB_RECO_REV_PER');
																		   
    nuTramiteReco ps_package_type.package_type_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_TRAM_RECO_SIN_CERT');
																								   
  
    nuTramiteSusp ps_package_type.package_type_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_SUSP_ADMIN_XML');
																								   
  
    TBSTRING  ut_string.TYTB_STRING; --Ticket  LJLB-- se crea registro de cadena
    sbLectura VARCHAR2(50);
    numarca   ge_suspension_type.suspension_type_id%type;
    nuMacaant ge_suspension_type.suspension_type_id%type;
    -- 200-2096
    sbTitrReviRp    varchar2(1000) := pkg_bcld_parameter.fnuobtienevalornumerico('ID_TASKTYPE_ACOM_REVI_RP');
																			   
    sbTiSolReviRp   varchar2(1000) := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_SUSP_ADMIN_XML');
																			   
    nuCausalType    NUMBER;
    nuCausal        NUMBER;
    nuReceptionType ge_reception_type.reception_type_id%type;
  
    --472    
    nuCausalAcom  ldc_pararepe.parevanu%type := pkg_bcldc_pararepe.fnuobtienevalornumerico('LDC_CAUSLEGA_ACOM');
    nuPersona1886 ld_parameter.numeric_value%type := pkg_bcld_parameter.fnuobtienevalornumerico('PERID_GEN_CIOR');
    --472
																								  
																					
																										 
																							  
		 
  
    -- se consulta la orden genenerada con la actividad correspondiente
    CURSOR cuOrdenGenerada(INUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE) IS
      SELECT OOA.ORDER_ID, ooa.order_activity_id
        FROM OR_ORDER_ACTIVITY OOA
       WHERE OOA.PACKAGE_ID = INUPACKAGE_ID
         AND ROWNUM = 1;
  
    --Ticket  LJLB -- se valida la clasificacion de la causal
    CURSOR cuTipoCausal(nuCausal ge_causal.CAUSAL_ID%TYPE) IS
      SELECT DECODE(CLASS_CAUSAL_ID, 1, 1, 2, 0) tipo
        FROM ge_causal
       WHERE CAUSAL_ID = nuCausal;
  
    --TICKET  LJLB -- se consultan comentarios de las ordenes
    CURSOR cucomentarios IS
      SELECT ORDER_COMMENT comentarioot
        FROM or_order_comment
       WHERE order_id = nuorden
         and legalize_comment = 'Y';
  
    --Se consulta tipo de suspension para legalizar
    CURSOR cuTipoSuspencion(nuProducto pr_product.product_id%TYPE) IS
      SELECT Ge_Suspension_Type.Suspension_Type_Id Id
        FROM Ge_Suspension_Type, Ps_Sustyp_By_Protyp, Pr_Product
       WHERE Pr_Product.Product_Id = nuProducto
         AND Ps_Sustyp_By_Protyp.Product_Type_Id =
             Pr_Product.Product_Type_Id
			
         AND Ge_Suspension_Type.Class_Suspension = 'A'
         AND Ge_Suspension_Type.Suspension_Type_Id =
             Ps_Sustyp_By_Protyp.Suspension_Type_Id
			
         AND Exists (SELECT 'X'
                FROM Pr_Prod_Suspension PS
               WHERE PS.Product_Id = Pr_Product.Product_Id
					
                 AND PS.Suspension_Type_Id =
                     Ge_Suspension_Type.Suspension_Type_Id
                 AND Active = 'Y');
    -- ses consulta ordenes de reconexion
    CURSOR cuOrdenReconexion IS
	
      SELECT OT.ORDER_ID ORDEN,
             A.ORDER_ACTIVITY_ID ACTIVIDAD,
             m.COMMENT_ comentario,
             A.PACKAGE_ID,
			 
             (SELECT ORAOUNID
                FROM LDC_ORDEASIGPROC
               WHERE ORAOPROC = 'RECOSUSPRP'
					
                 AND ORAPSOGE = A.PACKAGE_ID
                 AND ROWNUM < 2) UNIDAD_DUMMY, -- CA 472 -- se coloca  nueva columna que valide si se crea o no suspension
             (SELECT ORAOPROC
                FROM LDC_ORDEASIGPROC
               WHERE ORAOPROC = 'DEFNREPA'
                 AND ORAPSOGE = A.PACKAGE_ID
                 AND ROWNUM < 2) DEFNOREPA
	  
        FROM MO_PACKAGES m, or_order_activity a, or_order ot
       WHERE m.PACKAGE_TYPE_ID = nuTramiteReco
         AND m.motive_status_id = nuEstSolRegis
         AND INSTR(m.COMMENT_, '[GENERACION PLUGIN]') > 0
         AND M.PACKAGE_ID = A.PACKAGE_ID
         AND ot.order_id = a.order_id
         AND ot.ORDER_STATUS_ID = cnuCOD_STATUS_REG
			
         AND ot.task_type_id IN
             (SELECT (regexp_substr(sbTitrReco, csbPatronRegex, 1, LEVEL)) AS vlrColumna
                FROM dual
              CONNECT BY regexp_substr(sbTitrReco, csbPatronRegex, 1, LEVEL) IS NOT NULL);
  
    -- se consulta ordenes de reconexion
    CURSOR cuOrdenSuspAdmini IS
	
      SELECT OT.ORDER_ID ORDEN,
             A.ORDER_ACTIVITY_ID ACTIVIDAD,
             m.COMMENT_ comentario,
             A.PACKAGE_ID,
			 
             (SELECT ORAOUNID
                FROM LDC_ORDEASIGPROC
               WHERE ORAOPROC = 'SUSPDUMMYRP'
                 AND ORAPSOGE = A.PACKAGE_ID
                 AND ROWNUM < 2) UNIDAD_DUMMY,
             OT.TASK_TYPE_ID
        FROM MO_PACKAGES m, or_order_activity a, or_order ot
       WHERE m.PACKAGE_TYPE_ID = nuTramiteSusp
         AND m.motive_status_id = nuEstSolRegis
         AND INSTR(m.COMMENT_, '[GENERACION PLUGIN]') > 0
         AND M.PACKAGE_ID = A.PACKAGE_ID
         AND ot.order_id = a.order_id
         AND ot.ORDER_STATUS_ID = cnuCOD_STATUS_REG
         AND NOT EXISTS
       (SELECT 1
			  
                FROM mo_packages oa, mo_motive o
               WHERE o.package_id = oa.package_id
                 AND oa.package_type_id = nuTramiteReco
                 AND o.product_id = a.product_id
                 AND oa.motive_status_id = nuEstSolRegis);
  
    --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
    CURSOR cuDatosOrdenPadre(nucuorden NUMBER) IS
      SELECT ot.operating_unit_id,
             oa.product_id,
             ot.ASSIGNED_DATE,
             ot.EXEC_INITIAL_DATE,
             ot.EXECUTION_FINAL_DATE
	  
        FROM or_order_activity oa, or_order ot, mo_packages m
       WHERE oa.order_id = nucuorden
         AND oa.package_id IS NOT NULL
         AND oa.order_id = ot.order_id
			
         AND ot.order_status_id =
             pkg_bcld_parameter.fnuobtienevalornumerico('COD_ORDER_STATUS')
         AND oa.package_id = m.package_id
         AND rownum = 1;
  
    --se consulta estado del producto
    CURSOR cuEstadoProducto(nuProducto pr_product.product_id%type) IS
      SELECT PRODUCT_STATUS_ID
        FROM pr_product
       WHERE product_id = nuProducto;
  
    --se consulta medidor del producto
    CURSOR cuMedidor(dtFechaEjec DATE) IS
      SELECT emsscoem
        FROM elmesesu
       WHERE emsssesu = nuproductid
         AND dtFechaEjec between EMSSFEIN AND EMSSFERE;
  
    CURSOR cuMedidorAct IS
      SELECT emsscoem
        FROM elmesesu
       WHERE emsssesu = nuproductid
         AND sysdate between EMSSFEIN AND EMSSFERE;
  
    --TICKET 200-1968 LJLB-- se consulta lectura de la orden padre
    CURSOR cuLecturaOrdePadre(nuParametro NUMBER) IS
      SELECT decode(s.capture_order,
                    1,
                    value_1,
                    2,
                    value_2,
                    3,
                    value_3,
                    4,
                    value_4,
                    5,
                    value_5,
                    6,
                    value_6,
                    7,
                    value_7,
                    8,
                    value_8,
                    9,
                    value_9,
                    10,
                    value_10,
                    11,
                    value_11,
                    12,
                    value_12,
                    13,
                    value_13,
                    14,
                    value_14,
                    15,
                    value_15,
                    16,
                    value_16,
                    17,
                    value_17,
                    18,
                    value_18,
                    19,
                    value_19,
                    20,
                    value_20,
                    'NA') lectura
        FROM or_tasktype_add_data d,
             ge_attrib_set_attrib s,
             ge_attributes        A,
             or_requ_data_value   r,
             or_order             o
       WHERE d.task_type_id = o.task_type_id
         AND d.attribute_set_id = s.attribute_set_id
         AND s.attribute_id = a.attribute_id
         AND r.attribute_set_id = d.attribute_set_id
         AND r.order_id = o.order_id
         AND o.order_id = nuOrden
         AND d.active = 'Y'
         AND A.attribute_id = nuParametro;
  
    CURSOR cuProductosYaSuspendidos is
      select PRODUCT_ID, ORDER_ID, RESPONSABLE_ID
        from LDC_PRODUCTOPARASUSP
       where PROCESO = 'USER_YA_SUSPE';
  
    nuCausalUserYaSusp number := pkg_bcld_parameter.fnuobtienevalornumerico('CAUSAL_USU_YA_SUSP_CM_RP');
  
    --INICIO CA 472
    CURSOR cuProductosYaSuspendidosAcom is
      select PRODUCT_ID, ORDER_ID, RESPONSABLE_ID
        from LDC_PRODUCTOPARASUSP
       where PROCESO = 'USER_YA_SUSPE_ACO';
  
    nuCausalUserYaSuspAco number := pkg_bcldc_pararepe.fnuobtienevalornumerico('CAUSAL_USU_YA_SUSP_ACO_RP');
																		
  
    CURSOR cuOrdenesSuspDummy IS
      SELECT /*+ INDEX(OP IDX_LDC_ORDEASIGPROC) */
       ORAOPELE persona,
       ORAOUNID unidad,
       ORAOCALE causal,
       ORAOITEM itemsadic,
       o.order_id orden,
       OA.ORDER_ACTIVITY_ID actividad,
       oa.package_id,
       pkg_bcordenes.fdtobtienefechaasigna(ORAPORPA) fecha_asig,
       op.ORAPORPA orden_padre,
       oa.product_id producto
        FROM LDC_ORDEASIGPROC OP, OR_ORDER O, or_order_activity OA
       WHERE op.ORAOPROC = 'SUSPDUMYRP'
         AND OP.ORAPSOGE = OA.PACKAGE_ID
         AND O.ORDER_ID = OA.ORDER_ID
         AND o.order_status_id = cnuCOD_STATUS_REG;
  
    --FIN CA 472
  
    CURSOR cuUltimaLectura(nuProducto number) is
      select leemleto
        from (select leemfele, leemleto
                from lectelme
               where leemsesu = nuProducto
                 and leemleto is not null
               order by leemfele desc)
       where rownum = 1;
  
																						
    nuParaLectSusp NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_CODIATRLECTSUSPAD'); --TICKET 200-1968 LJLB--  se almacena codigo del parametro de lectura pra odenes de suspension
																						   
    nuParaLectReco NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_CODIATRLECTRECOSCERT'); --TICKET 200-1968 LJLB--  se almacena codigo del parametro de lectura pra odenes de reconexion y certificacion
  
    Medidor            varchar2(100);
    sbCadenalega       VARCHAR2(4000);
    MedidorLega        varchar2(100);
    MedidorAct         varchar2(100);
    dtFechaEjecFinLega or_order.EXECUTION_FINAL_DATE%TYPE;
  
    contRow         number := 0;
    nuResultGenSusp number;
  
    --CURSOR PARA OBTENER NOMRES DE DATOS ADICIONALES DE UN GRUPO DEL TIPO DE TRABAJO
    cursor cugrupo(nutask_type_id or_task_type.task_type_id%type,
                   NUCAUSAL_ID    GE_CAUSAL.CAUSAL_ID%TYPE) is
	
      select *
        from or_tasktype_add_data ottd
       where ottd.task_type_id = nutask_type_id
         and ottd.active = 'Y'
         and (ottd.use_ = decode(dage_causal.fnugetcausal_type_id(NUCAUSAL_ID),
                                 1,
                                 'C',
                                 2,
										
			 
                                 'I') or ottd.use_ = 'B');
  
    cursor cudatoadicional(nuattribute_set_id ge_attributes_set.attribute_set_id%type) is
      select *
        from ge_attributes b
       where b.attribute_id in
             (select a.attribute_id
                from ge_attrib_set_attrib a
               where a.attribute_set_id = nuattribute_set_id);
  
    SBDATOSADICIONALES VARCHAR2(2000);
  
    --CURSOR PARA GENERAR CADENA QUE SERA TULIZADA PARA LEGALIZAR LA ORDEN
    CURSOR CUCADENALEGALIZACION(NUORDER_ID          OR_ORDER.ORDER_ID%TYPE,
                                NUCAUSAL_ID         GE_CAUSAL.CAUSAL_ID%TYPE,
                                SBTEXTO             VARCHAR2,
                                SBDATOS             VARCHAR2,
                                TECNICO_UNIDAD      LDC_REGTIPOTRAADI.TECNICO_UNIDAD%TYPE,
                                Isbcadenamateriales VARCHAR2) IS
      SELECT O.ORDER_ID || '|' || NUCAUSAL_ID || '|' || TECNICO_UNIDAD || '|' ||
             SBDATOS || '|' || A.ORDER_ACTIVITY_ID || '>1;;;;|' ||
             Isbcadenamateriales || '||1277;' || SBTEXTO CADENALEGALIZACION
        FROM OR_ORDER O, OR_ORDER_ACTIVITY A
       WHERE O.ORDER_ID = A.ORDER_ID
         AND O.ORDER_ID = TO_NUMBER(NUORDER_ID);
  
    CURSOR cuOrdeSusp(nuproductid pr_product.product_id%type) IS
      select ORDER_ID
        from LDC_PRODUCTOPARASUSP
       where PRODUCT_ID = nuproductid
         and PROCESO = 'CERT_REPA_DEF_CON_SUSPE';
  
    -- 200-2096
    cursor cuOrdersAcomRP IS
      select distinct or_order_activity.order_id,
                      or_order_activity.order_activity_id,
                      or_order_activity.package_id,
                      mo_packages.comment_
        from or_order, or_order_activity, mo_packages
       where or_order.order_id = or_order_activity.order_id
         and or_order_activity.package_id = mo_packages.package_id
         and or_order.order_status_id = 0
         and or_order.task_type_id IN
             (SELECT (regexp_substr(sbTitrReviRp, csbPatronRegex, 1, LEVEL)) AS vlrColumna
			  
                FROM dual
              CONNECT BY regexp_substr(sbTitrReviRp,
                                       csbPatronRegex,
                                       1,
                                       LEVEL) IS NOT NULL)
			
         and mo_packages.package_type_id IN
             (SELECT (regexp_substr(sbTiSolReviRp, csbPatronRegex, 1, LEVEL)) AS vlrColumna
			  
                FROM dual
              CONNECT BY regexp_substr(sbTitrReviRp,
                                       csbPatronRegex,
                                       1,
                                       LEVEL) IS NOT NULL)
			
         and mo_packages.comment_ like
             '[GENERACION PLUGIN] | LEGALIZACION ORDEN[%'
			
         AND NOT EXISTS
       (SELECT 1
			  
                FROM mo_packages oa, mo_motive o
               WHERE o.package_id = oa.package_id
                 AND oa.package_type_id = nuTramiteReco
                 AND o.product_id = or_order_activity.product_id
                 AND oa.motive_status_id = nuEstSolRegis);
  
    cursor cuOrderPerson(inuOrderId in or_order.order_id%type) IS
      select or_order_person.person_id
        from or_order_person
       where or_order_person.order_id = inuOrderId;
  
    cursor cuOrderPersonRela(inuOrderRelaId in or_order.order_id%type) IS
      select or_order_person.person_id, or_related_order.order_id
        from or_order_person, or_related_order
       where or_related_order.order_id = or_order_person.order_id
         and or_related_order.related_order_id = inuOrderRelaId
         and or_related_order.rela_order_type_id = 13;
  
    nuPosIni     number;
    nuPosEnd     number;
    sbCommentAux varchar2(2000);
    nuOrderOri   number;
    nuCausalOri  or_order.causal_id%type;
    nuUnitOper   or_order.operating_unit_id%type;
    nuCausalLeg  or_order.causal_id%type := nvl(pkg_bcld_parameter.fnuobtienevalornumerico('CAUSAL_EXITO_CUMPL_RP'),
                                                0);
  
    sbToken      varchar2(100) := '[GENERACION PLUGIN] | LEGALIZACION ORDEN[';
    nuErr        number;
    sbMsg        varchar2(4000);
    nuClassCausa ge_causal.class_causal_id%type;
    nuCantidad   number;
  
    -- 200-2096
    cursor cuOrderByRepara is
      SELECT or_order.ORDER_ID, OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID
        from LDC_GEN_ORDER_BY_REPARA, OR_ORDER, OR_ORDER_ACTIVITY
       where or_order.order_id = OR_ORDER_ACTIVITY.order_id
         and LDC_GEN_ORDER_BY_REPARA.order_id = or_order.order_id
         and or_order.order_status_id = 5;
  
    CURSOR cuCommentFather(inuOrderId in or_order.order_id%type) IS
      SELECT or_order_comment.order_comment
        FROM or_order_comment
       WHERE or_order_comment.order_id = inuOrderId
         and legalize_comment = 'Y';
  
    --TICKET 200-2231 ELAL -- se consulta ordenes pendiente de vsi del proceso autoreconectado
    CURSOR cuOrdenesSuspAuto IS
      SELECT /*+ INDEX(OP IDX_LDC_ORDEASIGPROC) */
       ORAOPELE persona,
	   
       ORAOUNID unidad,
       ORAOCALE causal,
       ORAOITEM itemsadic,
       o.order_id orden,
       OA.ORDER_ACTIVITY_ID actividad,
       (SELECT DECODE(CLASS_CAUSAL_ID, 1, 1, 2, 0)
          FROM ge_causal
         WHERE CAUSAL_ID = ORAOCALE) tipo,
       oa.package_id,
       pkg_bcordenes.fdtobtienefechaasigna(ORAPORPA) fecha_asig,
       op.ORAPORPA orden_padre
        FROM LDC_ORDEASIGPROC OP, OR_ORDER O, or_order_activity OA
       WHERE op.ORAOPROC = 'AUTORECO'
         AND OP.ORAPSOGE = OA.PACKAGE_ID
         AND O.ORDER_ID = OA.ORDER_ID
         AND o.order_status_id = cnuCOD_STATUS_REG;
  
    SBCADENALEGALIZACION VARCHAR2(4000);
  
    --INICIO CA 147
    --se consultan ordenes asignar de RP
    CURSOR cugetOrdenesRPasig IS
      SELECT o.order_id orden, p.ORAOUNID unidad, p.ORAPSOGE
        FROM LDC_ORDEASIGPROC p, or_order o
       WHERE ORAOPROC = 'ASIGAUTRP'
         AND o.order_id = p.ORAPORPA
         AND o.order_status_id = 0;
    --FIN CA 147
  
    --INICIO CASO:466
    nuUnitop number;
  
    CURSOR cuREG IS
      SELECT oo.order_id,
             pl.plazo_min_revision,
             oo.task_type_id,
             oa.PACKAGE_ID,
             pkg_bcdirecciones.fnugetubicageopadre(pkg_bcdirecciones.fnugetlocalidad(oa.address_id)) departamento
        FROM or_order          oo,
             or_order_activity oa,
             ldc_plazos_cert   pl,
             pr_product        pp,
             ldc_ordeasigproc  lo
       where oo.order_id = oa.order_id
         and oo.order_status_id = 0
         and oa.product_id = pp.product_id
         and oa.product_id = pl.id_producto
         and oo.order_id = lo.ORAPORPA
         and lo.oraoproc = 'ASIGAUTPLAMIN';
  
    CURSOR cuObunit(pAnio number, pMes number, pDep number) IS
      select OPERATING_UNIT_ID
        from LDC_UNIT_RP_PLAMIN
       where ANIO = pAnio
         and MES = pMes
         AND DEPARTAMENTO = pDep;
  
    CURSOR cuValOrdProv(solicitud number) IS
      select 1
        from ldc_asigna_unidad_rev_per la, or_order oo
       where oo.order_id = la.ORDEN_TRABAJO
         and la.solicitud_generada = solicitud
         and oo.task_type_id = 10450
         and oo.CAUSAL_ID in
             (SELECT (regexp_substr(csbCAU_NO_ASIGAUTO_XFECHMINREV,
                                    '[^,]+',
                                    1,
                                    LEVEL)) AS vlrColumna
                FROM dual
              CONNECT BY regexp_substr(csbCAU_NO_ASIGAUTO_XFECHMINREV,
                                       '[^,]+',
                                       1,
                                       LEVEL) IS NOT NULL);
  
    --FIN CASO:466
  
    -----------------  variables y cursores caso 588 ---------------------
    -- consulta que valida que los parametros no esten nulos o vacios
    CURSOR cuValParVaciReform is
      select count(*)
        from ld_parameter p1, ld_parameter p2
       where p1.parameter_id = 'TITR_ASIGN_DEFECTOS_REFORMAS'
         and p2.parameter_id = 'TITR_UNIDAD_ASIG_REFORMAS'
         and p1.value_chain is not null
         and p2.value_chain is not null;
  
    -- consulta que valida que los parametros no esten nulos o vacios
    CURSOR cuValParVaciCert is
      select count(*)
        from ld_parameter p1, ld_parameter p2
       where p1.parameter_id = 'TITR_ASIGN_CERT_REFORMAS'
         and p2.parameter_id = 'TITR_UNIDAD_ASIG_CERTVISIT'
         and p1.value_chain is not null
         and p2.value_chain is not null;
  
    CURSOR cuGetOrderTTAsigDefRef is
      SELECT oo.order_id orden, oa.product_id producto, oa.package_id
        FROM or_order oo, or_order_activity oa
       WHERE oo.order_id = oa.order_id
         AND oo.order_status_id = 0
         AND oo.task_type_id in
             (SELECT (regexp_substr(csbTITR_ASIGN_DEFECTOS_REFORMA,
                                    csbPatronRegex,
                                    1,
                                    LEVEL)) AS vlrColumna
                FROM dual
              CONNECT BY regexp_substr(csbTITR_ASIGN_DEFECTOS_REFORMA,
                                       csbPatronRegex,
                                       1,
                                       LEVEL) IS NOT NULL);
  
    -- Cursor el cual permita traer a la unidad operativa que haya legalizado con causal de ¿xito una ¿ltima orden con
    -- alguno de los tipos de trabajos configurados en el par¿metro TITR_UNIDAD_ASIG_REFORMAS
    CURSOR cuGETUndOpeAsigRef(nuproducto or_order_activity.product_id%type) is
      SELECT oo.operating_unit_id
        FROM or_order          oo,
             ge_causal         ge,
             or_order_activity oa,
             or_operating_unit op
       WHERE oo.causal_id = ge.causal_id
         AND oa.order_id = oo.order_id
         AND ge.class_causal_id = 1 -- causal de exito
         AND oo.order_status_id = 8
         AND oa.product_id = nuproducto
         AND oo.task_type_id in
             (SELECT (regexp_substr(csbTITR_UNIDAD_ASIG_REFORMAS,
                                    csbPatronRegex,
                                    1,
                                    LEVEL)) AS vlrColumna
                FROM dual
              CONNECT BY regexp_substr(csbTITR_UNIDAD_ASIG_REFORMAS,
                                       csbPatronRegex,
                                       1,
                                       LEVEL) IS NOT NULL)
         AND rownum = 1
       ORDER BY oo.legalization_date desc;
  
    CURSOR cuGetOrderTTACERTREF is
      SELECT oo.order_id orden, oa.product_id producto, oa.package_id
        FROM or_order oo, or_order_activity oa
       WHERE oo.order_id = oa.order_id
         AND oo.order_status_id = 0
         AND oo.task_type_id in
             (SELECT (regexp_substr(csbTITR_ASIGN_CERT_REFORMAS,
                                    csbPatronRegex,
                                    1,
                                    LEVEL)) AS vlrColumna
                FROM dual
              CONNECT BY regexp_substr(csbTITR_ASIGN_CERT_REFORMAS,
                                       csbPatronRegex,
                                       1,
                                       LEVEL) IS NOT NULL);
  
    -- Cursor el cual permita traer a la unidad operativa que haya legalizado con causal de ¿xito una ¿ltima orden con
    -- alguno de los tipos de trabajos configurados en el par¿metro TITR_UNIDAD_ASIG_CERTVISIT
    CURSOR cuGETUndOpeAsigCertVis(nuproducto or_order_activity.product_id%type) is
      SELECT oo.operating_unit_id
        FROM or_order          oo,
             ge_causal         ge,
             or_order_activity oa,
             or_operating_unit op
       WHERE oo.causal_id = ge.causal_id
         AND oa.order_id = oo.order_id
         AND ge.class_causal_id = 1 -- causal de exito
         AND oo.order_status_id = 8
         AND oa.product_id = nuproducto
         AND oo.task_type_id in
             (SELECT (regexp_substr(csbTITR_UNIDAD_ASIG_CERTVISIT,
                                    csbPatronRegex,
                                    1,
                                    LEVEL)) AS vlrColumna
                FROM dual
              CONNECT BY regexp_substr(csbTITR_UNIDAD_ASIG_CERTVISIT,
                                       csbPatronRegex,
                                       1,
                                       LEVEL) IS NOT NULL)
         AND rownum = 1
       ORDER BY oo.legalization_date desc;
  
    cursor cupro_order_activity(inuorder in or_order_activity.order_id%type) is
      select product_id from or_order_activity where order_id = inuorder;
  
    nuOpeUnit          or_operating_unit.operating_unit_id%type;
    osbErrorMessage    VARCHAR2(4000);
    onuErrorCode       NUMBER;
    nuError            NUMBER;
    NUVALPARVACIO_REFO NUMBER;
    NUVALPARVACIO_CERT NUMBER;
  
    NOM_PROCESOPAR varchar2(100) := pkg_bcld_parameter.fsbobtienevalorcadena('NOM_PROCESOPAR');
																		   
    -----------------  Fin variables y cursores caso 588 ---------------------
    sbProceso VARCHAR2(100) := csbMetodo ||
                               TO_CHAR(SYSDATE, 'DDMMYYYYHH24MISS');
  
  BEGIN
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    -- Inicializamos el proceso    
    pkg_estaproc.prinsertaestaproc(isbProceso   => sbProceso,
                                   inuTotalRegi => null);
  
    --INICIO CA 472
    nuCausalType    := pkg_bcldc_pararepe.fnuobtienevalornumerico('LDC_TIPO_CAUSAL_DEF_NO_REPARA');
														   
    nuCausal        := pkg_bcldc_pararepe.fnuobtienevalornumerico('LDC_CAUSAL_DEF_NO_REPARA');
														   
    nuReceptionType := pkg_bcld_parameter.fnuobtienevalornumerico('MEDIO_RECEPCION_SUSPADM_PRP');
																
  
    --FIN CA 472
    --667
  
    -- legalzacion de ordenes de reconexion
    FOR reg IN cuOrdenReconexion LOOP
      BEGIN
        nuOk           := 0;
        nuOrdenGene    := NULL;
        nuActividad    := NULL;
        sbComentario   := NULL;
        nuTipoSuspLega := null;
        sbpersona      := null;
      
        sbLectura := null;
        nuLectura := null;
        sbOrden   := null;
        nuOrden   := null;
      
        nuClaseCausal     := null;
        nuunidadoperativa := null;
        dtFechaAsig       := null;
        dtFechaEjecIni    := null;
        dtFechaEjecfIN    := null;
      
        nuOrdenGene  := reg.ORDEN;
        nuActividad  := REG.ACTIVIDAD;
        sbComentario := REG.COMENTARIO;
      
        TBSTRING.DELETE; --Ticket  LJLB -- se limpia tabla pl
        ut_string.EXTSTRING(sbComentario, '|', TBSTRING);
      
        sbOrden   := TBSTRING(2);
        nuPosiIni := INSTR(sbOrden, '[', 1) + 1;
        sbOrden   := substr(sbOrden, nuPosiIni, length(sbOrden));
        nuOrden   := tO_nUmber(substr(sbOrden, 1, length(sbOrden) - 1));
      
        --TICKET 200-1968 LJLB-- se consulta lectura de los datos adicionales
        OPEN cuLecturaOrdePadre(nuParaLectReco);
        FETCH cuLecturaOrdePadre
          INTO nuLectura;
	  
        IF cuLecturaOrdePadre%NOTFOUND THEN
          sbLectura := TBSTRING(3);
          nuPosiIni := INSTR(sbLectura, '[', 1) + 1;
          sbLectura := substr(sbLectura, nuPosiIni, length(sbLectura));
          nuLectura := tO_nUmber(substr(sbLectura, 1, length(sbLectura) - 1));
        END IF;
        CLOSE cuLecturaOrdePadre;
      
        sbpersona     := TBSTRING(4);
        nuPosiIni     := INSTR(sbpersona, '[', 1) + 1;
        sbpersona     := substr(sbpersona, nuPosiIni, length(sbpersona));
        nuPersonaLega := tO_nUmber(substr(sbpersona,
                                          1,
                                          length(sbpersona) - 1));
      
        IF nuOrden IS NOT NULL THEN
        
          OPEN cuDatosOrdenPadre(nuOrden);
          FETCH cuDatosOrdenPadre
            INTO nuunidadoperativa,
                 nuproductid,
                 dtFechaAsig,
                 dtFechaEjecIni,
                 dtFechaEjecfIN;
          IF cuDatosOrdenPadre%NOTFOUND THEN
            sbmensa := 'No existen datos de orden Padre:[' || nuOrden || ']';
            proRegistraLogLegOrdRecoSusp(csbPRograma,
                                         SYSDATE,
                                         NULL,
                                         nuOrden,
                                         sbmensa,
                                         USER);
            nuOk := -1;
          END IF;
		
          CLOSE cuDatosOrdenPadre;
        
          dtFechaEjecfIN := dtFechaEjecfIN + (1 / 60) / 24;
        
          IF nuOk <> -1 THEN
            nuerrorcode    := null;
            sberrormessage := null;
		  
            delete LDC_BLOQ_LEGA_SOLICITUD
             where PACKAGE_ID_GENE = reg.package_id;
            --Ticket  LJLB -- se procede asignar la orden generada
            api_assign_order(inuOrder         => nuOrdenGene,
                             inuOperatingUnit => nuunidadoperativa,
                             onuErrorCode     => nuerrorcode,
                             osbErrorMessage  => sberrormessage);
          
            IF nuerrorcode = 0 THEN
            
              dbms_lock.sleep(1);
              nuerrorcode    := null;
              sberrormessage := null;
              sbmensa        := null;
            
              IF nuCausalLegaReco IS NOT NULL THEN
                pkg_traza.trace('nuCausallega:' || nuCausallega,
                                pkg_traza.cnuNivelTrzDef);
              
                OPEN cuTipoCausal(nuCausalLegaReco);
			  
                FETCH cuTipoCausal
                  INTO nuClaseCausal;
                CLOSE cuTipoCausal;
              
                OPEN cuTipoSuspencion(nuproductid);
                FETCH cuTipoSuspencion
                  INTO nuTipoSuspLega;
			  
                CLOSE cuTipoSuspencion;
              
                IF nuClaseCausal > 0 THEN
                  ---200-2153
                  OPEN cuMedidor(dtFechaEjecfIN);
				
                  FETCH cuMedidor
                    INTO MedidorLega;
                  CLOSE cuMedidor;
                
                  open cuMedidorAct;
                  fetch cuMedidorAct
                    into MedidorAct;
				
                  close cuMedidorAct;
                
                  Medidor := MedidorAct;
                
                  if MedidorLega != MedidorAct then
                    dtFechaEjecFinLega := sysdate;
                    open cuUltimaLectura(nuproductid);
                    fetch cuUltimaLectura
                      into nuLectura;
				  
                    close cuUltimaLectura;
                  else
                    dtFechaEjecFinLega := dtFechaEjecfIN;
                  end if;
                
                  --200-2062------------------------------------
                  sbCadenalega := nuOrdenGene || '|' || nuCausalLegaReco || '|' ||
                                  nuPersonaLega || '||' || nuActividad || '>' ||
                                  nuClaseCausal || ';READING>' ||
                                  NVL(nuLectura, '') ||
                                  '>9>;SUSPENSION_TYPE>' ||
                                  NVL(nuTipoSuspLega, '') || '>>;;|' ||
                                  NVL(sbItemLegaReco, '') || '|' || Medidor ||
                                  ';1=' || NVL(nuLectura, '') || '=T===|' ||
                                  '1277;Orden Legalizada por proceso LDC_PROCREASOLIRECOSINCERT';
				
                ELSE
                  sbCadenalega := nuOrdenGene || '|' || nuCausalLegaReco || '|' ||
                                  nuPersonaLega || '||' || nuActividad || '>' ||
                                  nuClaseCausal ||
                                  ';READING>>>;SUSPENSION_TYPE>>>;;|' ||
                                  NVL(sbItemLegaSusp, '') ||
                                  '||1277;Orden Legalizada por proceso LDC_PROCREASOLIRECOSINCERT';
				
                END IF;
              
                --Ticket LJLB -- se procede a legalizar la orden de trabajo       
                pkg_traza.trace('LLama api_legalizeorders sbCadenalega: ' ||
                                sbCadenalega || chr(10) ||
								
                                'dtFechaEjecIni: ' || dtFechaEjecIni ||
										  
								
                                chr(10) || 'dtFechaEjecFinLega: ' ||
                                dtFechaEjecFinLega,
                                pkg_traza.cnuNivelTrzDef);
                api_legalizeorders(sbCadenalega,
                                   dtFechaEjecIni,
                                   dtFechaEjecFinLega,
                                   NULL,
                                   nuerrorcode,
                                   sberrormessage);
                pkg_traza.trace('Sale api_legalizeorders nuerrorcode: ' ||
                                nuerrorcode || chr(10) ||
								
                                'sberrormessage: ' || sberrormessage,
                                pkg_traza.cnuNivelTrzDef);
                dbms_lock.sleep(2);
                --Ticket  LJLB -- se valida que todo alla terminado bien
			  
                IF nuerrorcode = 0 THEN
                  --agregar comentarios
                  FOR rfcucomentarios IN cucomentarios LOOP
                  
                    api_addordercomment(nuOrdenGene,
                                        3,
                                        substr(rfcucomentarios.comentarioot ||
                                               '. Fecha Fin Ejecución: ' ||
                                               dtFechaEjecfIN,
											   
                                               1,
                                               1900),
                                        nuerrorcode,
                                        sberrormessage);
                    IF nuerrorcode <> 0 THEN
                      sbmensa := 'api_addordercomment: Error asignando comentarios a la orden de reconexion [' ||
                                 nuOrdenGene || csbPrintError ||
                                 nuerrorcode || '-' || sberrormessage;
					
                      proRegistraLogLegOrdRecoSusp(csbPRograma,
                                                   SYSDATE,
                                                   nuOrdenGene,
                                                   nuOrden,
                                                   sbmensa,
                                                   USER);
					
                      rollback;
                    END IF;
                  END LOOP;
                  ---actualiza marca
                  nuMacaant := ldc_fncretornamarcaprod(nuproductid);
                  /******************
                  **INICIO 200-2073**
                  ******************/
                
                  OPEN cuOrdeSusp(nuproductid);
                  FETCH cuOrdeSusp
                    INTO contRow;
				
                  IF cuOrdeSusp%NOTFOUND THEN
                    contRow := 0;
                  END IF;
                  CLOSE cuOrdeSusp;
                
                  if contRow > 0 then
                    nuResultGenSusp := FUNGENTRAMITESUSPE(nuproductid,
                                                          nuMacaant,
                                                          contRow,
                                                          reg.PACKAGE_ID,
                                                          sbmensa);
				  
                    if nuResultGenSusp = 0 then
                      delete from LDC_PRODUCTOPARASUSP
                       where PRODUCT_ID = nuproductid
                         and PROCESO = 'CERT_REPA_DEF_CON_SUSPE';
                    else
                      sbmensa := 'FUNGENTRAMITESUSPE: Error al generar la suapension  ' ||
                                 sbmensa;
					
                      proRegistraLogLegOrdRecoSusp(csbPRograma,
                                                   SYSDATE,
                                                   nuOrdenGene,
                                                   nuOrden,
                                                   sbmensa,
                                                   USER);
					
                      dbms_lock.sleep(2);
                      rollback;
                    end if;
                  end if;
                
                  /*****************
                  **FINAL 200-2073**
                  *****************/
                  numarca := ldc_fnugetnuevamarca(nuorden);
                  --667 se corrige error reportado donde hubo problemas generando la suspension y genero la certificacion
                  nuOK := 0;
                  --INICIO CA 472
                  IF reg.UNIDAD_DUMMY IS NOT NULL THEN
                    --se crea tramite de suspension
                    LDC_PKGESTIONLEGAORRP.PRGENETRAMSUSPADMI(nuproductid,
                                                             numarca,
                                                             nuOrden,
                                                             reg.package_id,
                                                             nuerrorcode,
                                                             sbmensa);
                    IF nuerrorcode <> 0 THEN
                      nuOK    := -1;
                      sbmensa := 'api_legalizeorders: Error legalizando orden de suspension ' ||
                                 nuerrorcode || '-' || sbmensa;
					
                      proRegistraLogLegOrdRecoSusp(csbPRograma,
                                                   SYSDATE,
                                                   nuOrdenGene,
                                                   nuOrden,
                                                   sbmensa,
                                                   USER);
                      dbms_lock.sleep(2);
                      rollback;
					
                    END IF;
                  END IF;
                
                  IF reg.defnorepa is not null then
                    if numarca = -1 then
                      numarca := ldci_pkrevisionperiodicaweb.fnutiposuspension(nuproductid);
                    end if;
                    Begin
                      LDC_BODefectNoRepara.prRegisterRequest(nuproductid,
                                                             nuReceptionType,
                                                             'DEFECTOS CRITICOS NO PERMITE SUSPENDER',
                                                             numarca,
                                                             nuCausalType,
                                                             nuCausal);
                    Exception
                      when others then
                        pkg_Error.seterror;
                        pkg_Error.Geterror(nuerrorcode, sbmensa);
                        nuOK    := -1;
                        sbmensa := 'api_legalizeorders: Error generando orden de suspension x defectos ' ||
                                   nuerrorcode || '-' || sbmensa;
					  
                        proRegistraLogLegOrdRecoSusp(csbPRograma,
                                                     SYSDATE,
                                                     nuOrdenGene,
                                                     nuOrden,
                                                     sbmensa,
                                                     USER);
                        rollback;
					  
                    End;
                  end if;
                
                  if nvl(numarca, -1) != -1 and nuOK = 0 then
                    ldcprocinsactumarcaprodu(nuproductid, numarca, nuorden);
                    ldc_prmarcaproductolog(nuproductid,
                                           nuMacaant,
                                           numarca,
                                           'Legalizacion Reconex OT Padre:' ||
                                           nuorden);
				  
                    LDCPROCREATRAMITESRP(nuorden, numarca, reg.package_id);
                  end if;
                
                  --
                  commit;
                ELSE
                  sbmensa := 'api_legalizeorders: Error legalizando orden de reconexion ' ||
                             nuerrorcode || '-' || sberrormessage;
				
                  proRegistraLogLegOrdRecoSusp(csbPRograma,
                                               SYSDATE,
                                               nuOrdenGene,
                                               nuOrden,
                                               sbmensa,
                                               USER);
				
                  dbms_lock.sleep(2);
                  rollback;
                END IF;
              ELSE
                rollback;
                sbmensa := 'Error no hay causal configurada, por favor valide el parametro LDC_CAUSLEGRECSCERT';
                proRegistraLogLegOrdRecoSusp(csbPRograma,
                                             SYSDATE,
                                             nuOrdenGene,
                                             nuOrden,
                                             sbmensa,
                                             USER);
			  
              END IF;
            
            ELSE
            
              sbmensa := 'API_ASSIGN_ORDER: Error asignando orden de reconexion[' ||
                         nuOrdenGene || csbPrintError || nuerrorcode || '-' ||
                         sberrormessage;
			
              proRegistraLogLegOrdRecoSusp(csbPRograma,
                                           SYSDATE,
                                           nuOrdenGene,
                                           nuOrden,
                                           sbmensa,
                                           USER);
			
              rollback;
              dbms_lock.sleep(2);
            END IF;
          ELSE
            rollback;
            sbmensa := 'No existe orden padre de reconexion, por favor valide';
            proRegistraLogLegOrdRecoSusp(csbPRograma,
                                         SYSDATE,
                                         nuOrdenGene,
                                         nuOrden,
                                         sbmensa,
                                         USER);
		  
          END IF;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          pkg_Error.setError;
      END;
    END LOOP;
    dbms_lock.sleep(8); --sew relaiza espera de 8 segundos para que la solicitud de reconexion  cambie de estado a cumplida
  
    --legalizaciones de suspensiones administrativa
    FOR reg IN cuOrdenSuspAdmini LOOP
      BEGIN
        nuOrdenGene  := NULL;
        nuActividad  := NULL;
        sbComentario := NULL;
      
        sbLectura     := null;
        nuLectura     := null;
        sbpersona     := null;
        sbOrden       := null;
        nuOrden       := null;
        nuCausallega  := null;
        nuClaseCausal := null;
        nuEstado      := null;
      
        nuunidadoperativa := null;
        dtFechaAsig       := null;
        dtFechaEjecIni    := null;
        dtFechaEjecfIN    := null;
      
        nuOrdenGene  := reg.ORDEN;
        nuActividad  := REG.ACTIVIDAD;
        sbComentario := REG.COMENTARIO;
      
        TBSTRING.DELETE; --Ticket  LJLB -- se limpia tabla pl
        ut_string.EXTSTRING(sbComentario, '|', TBSTRING);
      
        sbOrden   := TBSTRING(2);
        nuPosiIni := INSTR(sbOrden, '[', 1) + 1;
        sbOrden   := substr(sbOrden, nuPosiIni, length(sbOrden));
        nuOrden   := tO_nUmber(substr(sbOrden, 1, length(sbOrden) - 1));
      
        --TICKET 200-1968 LJLB-- se consulta lectura de los datos adicionales
        OPEN cuLecturaOrdePadre(nuParaLectSusp);
        FETCH cuLecturaOrdePadre
          INTO nuLectura;
	  
        IF cuLecturaOrdePadre%NOTFOUND THEN
          sbLectura := TBSTRING(3);
          nuPosiIni := INSTR(sbLectura, '[', 1) + 1;
          sbLectura := substr(sbLectura, nuPosiIni, length(sbLectura));
          nuLectura := tO_nUmber(substr(sbLectura, 1, length(sbLectura) - 1));
        END IF;
        CLOSE cuLecturaOrdePadre;
      
        sbpersona     := TBSTRING(4);
        nuPosiIni     := INSTR(sbpersona, '[', 1) + 1;
        sbpersona     := substr(sbpersona, nuPosiIni, length(sbpersona));
        nuPersonaLega := tO_nUmber(substr(sbpersona,
                                          1,
                                          length(sbpersona) - 1));
      
        IF nuOrden IS NOT NULL THEN
        
          OPEN cuDatosOrdenPadre(nuOrden);
          FETCH cuDatosOrdenPadre
            INTO nuunidadoperativa,
                 nuproductid,
                 dtFechaAsig,
                 dtFechaEjecIni,
                 dtFechaEjecfIN;
          IF cuDatosOrdenPadre%NOTFOUND THEN
            sbmensa := 'No existen datos de orden Padre:[' || nuOrden || ']';
            Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE,
                                      sbmensa);
          END IF;
          CLOSE cuDatosOrdenPadre;
		
          --200-2062------------------------------------
          if dtFechaEjecfIN = trunc(dtFechaEjecfIN) then
            dtFechaEjecfIN := dtFechaEjecfIN + 1 / 64;
          end if;
          --200-2062------------------------------------
          nuerrorcode    := null;
          sberrormessage := null;
          sbmensa        := NULL;
		
          delete LDC_BLOQ_LEGA_SOLICITUD
           where PACKAGE_ID_GENE = reg.package_id;
        
          IF reg.UNIDAD_DUMMY IS NOT NULL THEN
            nuunidadoperativa := reg.UNIDAD_DUMMY;
            nuPersonaLega     := nuPersona1886;
          END IF;
        
          --Ticket  LJLB -- se procede asignar la orden generada
          api_assign_order(inuOrder         => nuOrdenGene,
                           inuOperatingUnit => nuunidadoperativa,
                           onuErrorCode     => nuerrorcode,
                           osbErrorMessage  => sberrormessage);
        
          IF nuerrorcode = 0 THEN
          
            dbms_lock.sleep(1);
            nuerrorcode    := null;
            sberrormessage := null;
          
            -- se consulta estado del producto
            OPEN cuEstadoProducto(nuproductid);
            FETCH cuEstadoProducto
              INTO nuEstado;
		  
            IF cuEstadoProducto%NOTFOUND THEN
              nuCausallega := -1;
            END IF;
            CLOSE cuEstadoProducto;
          
            IF nvl(nuCausallega, 0) <> -1 THEN
              IF nuEstado = 2 THEN
                nuCausallega := nuCausalLegUsuSup;
              ELSE
                if reg.task_type_id = 10450 then
                  nuCausallega := nuCausalLegUsuNSup;
                elsif reg.task_type_id = 12457 then
                  nuCausallega := nuCausalAcom;
                end if;
              END IF;
            
              IF nuCausallega IS NOT NULL THEN
                OPEN cuTipoCausal(nuCausallega);
			  
                FETCH cuTipoCausal
                  INTO nuClaseCausal;
                CLOSE cuTipoCausal;
              
                IF nuClaseCausal > 0 THEN
                  ---200-2153
                  OPEN cuMedidor(dtFechaEjecfIN);
                  FETCH cuMedidor
                    INTO MedidorLega;
				
                  CLOSE cuMedidor;
                
                  open cuMedidorAct;
                  fetch cuMedidorAct
                    into MedidorAct;
                  close cuMedidorAct;
                
                  Medidor := MedidorAct;
                
                  if MedidorLega != MedidorAct then
                    dtFechaEjecFinLega := sysdate;
                    open cuUltimaLectura(nuproductid);
                    fetch cuUltimaLectura
                      into nuLectura;
                    close cuUltimaLectura;
                  else
                    dtFechaEjecFinLega := dtFechaEjecfIN;
                  end if;
                
                  --200-2062------------------------------------
                
                  --200-2062------------------------------------
                
                  sbCadenalega := nuOrdenGene || '|' || nuCausallega || '|' ||
                                  nuPersonaLega || '||' || nuActividad || '>' ||
                                  nuClaseCausal || ';READING>' ||
                                  NVL(nuLectura, '') ||
                                  '>9>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|' ||
                                  NVL(sbItemLegaSusp, '') || '|' || Medidor ||
                                  ';1=' || NVL(nuLectura, '') || '=T===|' ||
                                  '1277;Orden Legalizada por proceso LDC_PROCREASOLISUSPADMI';
                ELSE
                  sbCadenalega := nuOrdenGene || '|' || nuCausallega || '|' ||
                                  nuPersonaLega || '||' || nuActividad || '>' ||
                                  nuClaseCausal ||
                                  ';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|' ||
                                  NVL(sbItemLegaSusp, '') ||
                                  '||1277;Orden Legalizada por proceso LDC_PROCREASOLISUSPADMI';
                END IF;
              
                --Ticket LJLB -- se procede a legalizar la orden de trabajo
                pkg_traza.trace('LLama api_legalizeorders sbCadenalega: ' ||
                                sbCadenalega || chr(10) ||
                                'dtFechaEjecIni: ' || dtFechaEjecIni ||
                                chr(10) || 'dtFechaEjecFinLega: ' ||
                                dtFechaEjecFinLega,
                                pkg_traza.cnuNivelTrzDef);
              
                api_legalizeorders(sbCadenalega,
                                   dtFechaEjecIni,
                                   dtFechaEjecFinLega,
                                   null,
                                   nuerrorcode,
                                   sberrormessage);
              
                pkg_traza.trace('Sale api_legalizeorders nuerrorcode: ' ||
                                nuerrorcode || chr(10) ||
								
                                'sberrormessage: ' || sberrormessage,
                                pkg_traza.cnuNivelTrzDef);
              
                dbms_lock.sleep(2);
                --Ticket  LJLB -- se valida que todo alla terminado bien
                IF nuerrorcode = 0 THEN
                  --agregar comentarios
                  FOR rfcucomentarios IN cucomentarios LOOP
                    api_addordercomment(nuOrdenGene,
                                        3,
                                        substr(rfcucomentarios.comentarioot ||
                                               '. Fecha Fin Ejecución: ' ||
                                               dtFechaEjecfIN,
                                               1,
                                               1900),
                                        nuerrorcode,
                                        sberrormessage);
                    IF nuerrorcode <> 0 THEN
					
                      sbmensa := 'api_addordercomment: Error asignando comentarios a la orden: [' ||
                                 nuOrdenGene || ']' || nuerrorcode || '-' ||
                                 sberrormessage;
					
                      proRegistraLogLegOrdRecoSusp(csbPRograma,
                                                   SYSDATE,
                                                   nuOrdenGene,
                                                   nuOrden,
                                                   sbmensa,
                                                   USER);
                      rollback;
                    END IF;
				  
                  END LOOP;
                
                  numarca        := ldc_fncretornamarcaprod(nuproductid);
                  numarcaOtPadre := LDC_FNUGETNUEVAMARCA(nuorden);
				
                  if nvl(numarca, -1) != -1 and
                     nvl(numarcaOtPadre, -1) != -1 then
                    LDCPROCREATRAMITESRP(nuorden, numarca, reg.package_id);
                  end if;
                  commit;
                ELSE
                  sbmensa := 'api_legalizeorders: Error legalizando orden: [' ||
                             nuOrdenGene || ']' || ', error: ' ||
                             nuerrorcode || '-' || sberrormessage;
				
                  proRegistraLogLegOrdRecoSusp(csbPRograma,
                                               SYSDATE,
                                               nuOrdenGene,
                                               nuOrden,
                                               sbmensa,
                                               USER);
				
                  ROLLBACK;
                END IF;
              ELSE
                sbmensa := 'Error no hay causal configurada, por favor valide los parametros LDC_CAUSLEGUSSUSP y LDC_CAUSLEGUSNSUSP.';
                proRegistraLogLegOrdRecoSusp(csbPRograma,
                                             SYSDATE,
                                             nuOrdenGene,
                                             nuOrden,
                                             sbmensa,
                                             USER);
			  
                ROLLBACK;
              END IF;
            
            ELSE
              sbmensa := 'Error el producto : ' || to_char(nuproductid) ||
                         ' no existe ';
			
              proRegistraLogLegOrdRecoSusp(csbPRograma,
                                           SYSDATE,
                                           nuOrdenGene,
                                           nuOrden,
                                           sbmensa,
                                           USER);
			
              ROLLBACK;
			
            END IF;
          ELSE
            sbmensa := 'API_ASSIGN_ORDER: Error asignando orden [' ||
                       nuOrdenGene || csbPrintError || nuerrorcode || '-' ||
                       sberrormessage;
            dbms_lock.sleep(2);
            proRegistraLogLegOrdRecoSusp(csbPRograma,
                                         SYSDATE,
                                         nuOrdenGene,
                                         nuOrden,
                                         sbmensa,
                                         USER);
		  
            ROLLBACK;
          END IF;
        ELSE
          sbmensa := 'No existe orden padre de suspension, por favor valide';
          proRegistraLogLegOrdRecoSusp(csbPRograma,
                                       SYSDATE,
                                       nuOrdenGene,
                                       nuOrden,
                                       sbmensa,
                                       USER);
          ROLLBACK;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          pkg_Error.SETERROR;
      END;
    END LOOP;
  
    /******************
    **INICIO 200-2073**
    ******************/
    FOR n IN cuProductosYaSuspendidos LOOP
      BEGIN
        nuerrorcode    := null;
        sberrormessage := null;
        nuPersonaLega  := n.RESPONSABLE_ID;
        --cadena datos adicionales
        SBDATOSADICIONALES := NULL;
        for rc in cugrupo(pkg_bcordenes.fnuobtienetipotrabajo(n.ORDER_ID),
                          nuCausalUserYaSusp) loop
          pkg_traza.trace('Grupo de dato adicional [' ||
                          rc.attribute_set_id ||
						  
                          '] asociado al tipo de trabajo [' ||
                          rc.task_type_id || ']',
                          pkg_traza.cnuNivelTrzDef);
        
          for rcdato in cudatoadicional(rc.attribute_set_id) loop
            IF SBDATOSADICIONALES IS NULL THEN
              SBDATOSADICIONALES := RCDATO.NAME_ATTRIBUTE || '=';
            ELSE
              SBDATOSADICIONALES := SBDATOSADICIONALES || ';' ||
                                    RCDATO.NAME_ATTRIBUTE || '=';
            END IF;
            pkg_traza.trace('Dato adicional[' || rcdato.name_attribute || ']',
                            pkg_traza.cnuNivelTrzDef);
		  
          end loop;
        end loop;
        --fin cadena datos adicionales
      
        --cadena legalizacion de orden prinipal
        SBCADENALEGALIZACION := NULL;
        OPEN CUCADENALEGALIZACION(n.ORDER_ID,
                                  nuCausalUserYaSusp,
                                  'Orden Legalizada por proceso LDC_PROCREASOLISUSPADMI',
                                  SBDATOSADICIONALES,
                                  nuPersonaLega,
                                  null);
        FETCH CUCADENALEGALIZACION
          INTO SBCADENALEGALIZACION;
        CLOSE CUCADENALEGALIZACION;
        --fin cadena legalizacion de orden prinipal
      
        pkg_traza.trace('Cadena legalizacion orden [' ||
                        SBCADENALEGALIZACION || '] ',
                        pkg_traza.cnuNivelTrzDef);
      
        pkg_traza.trace('LLama api_legalizeorders SBCADENALEGALIZACION: ' ||
                        SBCADENALEGALIZACION || chr(10) ||
                        'dtFechaEjecIni: ' || sysdate || chr(10) ||
                        'dtFechaEjecFinLega: ' || sysdate || chr(10) ||
                        'dtChangeDate: ' || sysdate,
                        pkg_traza.cnuNivelTrzDef);
      
        ---INICIO LEGALIZAR TRABAJO ADICIONAL
        api_legalizeorders(SBCADENALEGALIZACION,
                           sysdate,
                           sysdate,
                           sysdate,
                           nuerrorcode,
                           sberrormessage);
      
        pkg_traza.trace('Sale api_legalizeorders nuerrorcode: ' ||
                        nuerrorcode || chr(10) || 'sberrormessage: ' ||
						
                        sberrormessage,
                        pkg_traza.cnuNivelTrzDef);
      
        IF nuerrorcode <> 0 THEN
          sbmensa := 'api_legalizeorders: Error legalizando orden: [' ||
                     n.ORDER_ID || ']' || ', error: ' || nuerrorcode || '-' ||
                     sberrormessage;
		
          --CASO 200-2390
          nuOTPadre := null;
          open CUOOR_RELATED_ORDER(n.ORDER_ID);
		
          fetch CUOOR_RELATED_ORDER
            into rfCUOOR_RELATED_ORDER;
          if CUOOR_RELATED_ORDER%found then
            if rfCUOOR_RELATED_ORDER.Order_Id is not null then
              nuOTPadre := rfCUOOR_RELATED_ORDER.Order_Id;
            end if;
          end if;
		
          close CUOOR_RELATED_ORDER;
          -----------------------
          proRegistraLogLegOrdRecoSusp(csbPRograma,
                                       SYSDATE,
                                       n.ORDER_ID,
                                       nuOTPadre,
                                       sbmensa,
                                       USER);
		
          ROLLBACK;
        ELSE
          DELETE FROM LDC_PRODUCTOPARASUSP
           WHERE ORDER_ID = n.ORDER_ID
             AND PROCESO = 'USER_YA_SUSPE';
		
          commit;
        END IF;
      
        ---FIN LEGALIZACION TRABAJO ADICIONAL
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          pkg_Error.SETERROR;
      END;
    END LOOP;
    /*****************
    **FINAL 200-2073**
    *****************/
  
    -- 200-2096
  
    pkg_traza.trace('Inicia cursor cuOrdersAcomRP',
                    pkg_traza.cnuNivelTrzDef);
  
    FOR rgOrdersRP IN cuOrdersAcomRP LOOP
      BEGIN
        nuPosIni := instr(rgOrdersRP.comment_, sbToken, 1);
        -- Se valida si la cadena existe
        IF nuPosIni > 0 THEN
        
          nuPosIni     := nuPosIni + length(sbToken);
          sbCommentAux := substr(rgOrdersRP.comment_,
                                 nuPosIni,
                                 length(sbToken));
		
          nuPosEnd     := instr(sbCommentAux, ']', 1);
          nuOrderOri   := to_number(substr(sbCommentAux, 1, nuPosEnd - 1));
          pkg_traza.trace('- nuOrderOri ' || nuOrderOri,
                          pkg_traza.cnuNivelTrzDef);
		
          nuCausalOri    := pkg_bcordenes.fnuobtienecausal(nuOrderOri);
          dtFechaEjecfIN := pkg_bcordenes.fdtobtienefechaejecufin(nuOrderOri);
          dtFechaEjecIni := pkg_bcordenes.fdtobtienefechaejecuini(nuOrderOri);
        
          nuOrden        := nuOrderOri;
          dtFechaEjecfIN := dtFechaEjecfIN + 1 / 24;
        
          --200-2062------------------------------------
        
          --200-2062------------------------------------
        
          --TICKET 200-1968 LJLB-- se consulta lectura de los datos adicionales
          OPEN cuLecturaOrdePadre(nuParaLectReco);
          FETCH cuLecturaOrdePadre
            INTO nuLectura;
          IF cuLecturaOrdePadre%NOTFOUND THEN
            nuLectura := null;
		  
          END IF;
          CLOSE cuLecturaOrdePadre;
        
          -- Se valida que la orden haya sido legalizada con causal del parámetro CAUSAL_FALL_SERVSUSPACOM
						  
          IF nuCausalOri = nvl(pkg_bcld_parameter.fnuobtienevalornumerico('CAUSAL_FALL_SERVSUSPACOM'),
                               0) THEN
		  
            -- Se procede a asignar al orden                 
            nuUnitOper := pkg_bcordenes.fnuobtieneunidadoperativa(nuOrderOri);
          
            delete LDC_BLOQ_LEGA_SOLICITUD
             where PACKAGE_ID_GENE = rgOrdersRP.package_id;
          
            api_assign_order(inuOrder         => rgOrdersRP.order_id,
                             inuOperatingUnit => nuUnitOper,
                             onuErrorCode     => nuErr,
                             osbErrorMessage  => sbMsg);
          
            -- Se valida si la orden se asignó correctamente
            IF nuErr <> 0 THEN
              sbmensa := '';
              sbmensa := 'API_ASSIGN_ORDER: Error asignando orden [' ||
                         rgOrdersRP.order_id || csbPrintError || nuErr || '-' ||
                         sbMsg;
			
              dbms_lock.sleep(2);
              proRegistraLogLegOrdRecoSusp(csbPRograma,
                                           SYSDATE,
                                           rgOrdersRP.order_id,
                                           nuOrderOri,
                                           sbmensa,
                                           USER);
              ROLLBACK;
            
            else
            
              pkg_traza.trace('Orden[' || rgOrdersRP.order_id ||
                              '] asignda correctamente',
                              pkg_traza.cnuNivelTrzDef);
            
              sbCadenalega := '';
              open cuOrderPerson(nuOrderOri);
              fetch cuOrderPerson
                into nuPersonaLega;
              close cuOrderPerson;
            
              nuClassCausa := pkg_bcordenes.fnuobtieneclasecausal(nuCausalLeg);
            
              IF nuClassCausa = 1 THEN
                nuCantidad := 1;
                ---200-2153
              
                open cupro_order_activity(rgOrdersRP.order_id);
                fetch cupro_order_activity
                  into nuproductid;
                IF cupro_order_activity%NOTFOUND THEN
                  nuproductid := null;
                END IF;
                close cupro_order_activity;
              
                OPEN cuMedidor(dtFechaEjecfIN);
                FETCH cuMedidor
                  INTO MedidorLega;
                CLOSE cuMedidor;
                open cuMedidorAct;
                fetch cuMedidorAct
                  into MedidorAct;
                close cuMedidorAct;
              
                Medidor := MedidorAct;
              
                if MedidorLega != MedidorAct then
                  dtFechaEjecFinLega := sysdate;
                  open cuUltimaLectura(nuproductid);
                  fetch cuUltimaLectura
                    into nuLectura;
                  close cuUltimaLectura;
                else
                  dtFechaEjecFinLega := dtFechaEjecfIN;
                end if;
              
                --200-2062------------------------------------
              
                --200-2062------------------------------------
              ELSE
                nuCantidad := 0;
              END IF;
            
              -- Se procede a legalizar las ordenes
              sbCadenalega := rgOrdersRP.order_id || '|' || nuCausalLeg || '|' ||
                              nuPersonaLega || '||' ||
                              rgOrdersRP.order_activity_id || '>' ||
                              nuCantidad || ';READING>' ||
                              NVL(nuLectura, '') ||
                              '>9>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>||' ||
                              Medidor || ';1=' || NVL(nuLectura, '') ||
                              '=T===|' ||
                              '1277;Orden Legalizada por proceso ' ||
                              csbPRograma || ' - cuOrdersAcomRP';
            
              nuErr := null;
              sbMsg := null;
            
              pkg_traza.trace('LLama api_legalizeorders sbCadenalega: ' ||
                              sbCadenalega || chr(10) ||
							  
                              'dtFechaEjecIni: ' || dtFechaEjecIni ||
										
							  
                              chr(10) || 'dtFechaEjecFinLega: ' ||
                              dtFechaEjecFinLega,
                              pkg_traza.cnuNivelTrzDef);
              api_legalizeorders(sbCadenalega,
                                 dtFechaEjecIni,
                                 dtFechaEjecFinLega,
                                 null,
                                 nuErr,
                                 sbMsg);
            
              pkg_traza.trace('Sale api_legalizeorders nuerrorcode: ' ||
												 
							  
                              nuErr || chr(10) || 'sberrormessage: ' ||
                              sbMsg,
                              pkg_traza.cnuNivelTrzDef);
            
              -- Se valida si la orden se cerro correctamente
              IF nuErr <> 0 THEN
                sbmensa := 'api_legalizeorders: Error legalizando orden: [' ||
                           rgOrdersRP.order_id || ']' || ', error: ' ||
                           nuErr || '-' || sbMsg;
			  
                proRegistraLogLegOrdRecoSusp(csbPRograma,
                                             SYSDATE,
                                             rgOrdersRP.order_id,
                                             nuOrderOri,
                                             sbmensa,
                                             USER);
			  
                ROLLBACK;
              else
                -- Se adicionan comentarios de orden padre
                FOR rgComment IN cuCommentFather(nuOrderOri) LOOP
                  nuErr := null;
                  sbMsg := null;
                
                  api_addordercomment(rgOrdersRP.order_id,
                                      3,
                                      rgComment.order_comment ||
                                      '. Fecha Fin Ejecución: ' ||
                                      dtFechaEjecfIN,
                                      nuErr,
                                      sbMsg);
                  IF nuErr <> 0 THEN
                    sbmensa := 'api_addordercomment: Error asignando comentarios a la orden de reconexion [' ||
                               rgOrdersRP.order_id || csbPrintError ||
                               nuErr || '-' || sbMsg;
                    proRegistraLogLegOrdRecoSusp(csbPRograma,
                                                 SYSDATE,
                                                 rgOrdersRP.order_id,
                                                 nuOrderOri,
                                                 sbmensa,
                                                 USER);
                    rollback;
                  else
                    commit;
                  END IF;
                END LOOP;
              END IF;
            
              pkg_traza.trace('Orden[' || rgOrdersRP.order_id ||
                              '] legalizada correctamente',
                              pkg_traza.cnuNivelTrzDef);
            END IF;
		  
          END IF;
        
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          pkg_Error.SETERROR;
      END;
    END LOOP;
  
    pkg_traza.trace('FIN cursor cuOrdersAcomRP', pkg_traza.cnuNivelTrzDef);
    nuCausalLeg  := nvl(pkg_bcld_parameter.fnuobtienevalornumerico('CAUSALPARAUSERSUSP'),
                        0);
  
    nuClassCausa := pkg_bcordenes.fnuobtieneclasecausal(nuCausalLeg);
  
    IF nuClassCausa = 1 THEN
      nuCantidad := 1;
    ELSE
      nuCantidad := 0;
    END IF;
  
    pkg_traza.trace('Inicia cursor cuOrderByRepara',
                    pkg_traza.cnuNivelTrzDef);
  
    FOR rgOrder IN cuOrderByRepara LOOP
    
      nuErr        := null;
      sbMsg        := null;
      sbCadenalega := null;
    
      open cuOrderPersonRela(rgOrder.ORDER_ID);
	
      fetch cuOrderPersonRela
        into nuPersonaLega, nuOrderOri;
      close cuOrderPersonRela;
    
      dtFechaEjecfIN := pkg_bcordenes.fdtobtienefechaejecufin(nuOrderOri);
      dtFechaEjecIni := pkg_bcordenes.fdtobtienefechaejecuini(nuOrderOri);
      nuOrden        := nuOrderOri;
      --TICKET 200-1968 LJLB-- se consulta lectura de los datos adicionales
      OPEN cuLecturaOrdePadre(nuParaLectReco);
      FETCH cuLecturaOrdePadre
        INTO nuLectura;
	
      IF cuLecturaOrdePadre%NOTFOUND THEN
        nuLectura := null;
      END IF;
      CLOSE cuLecturaOrdePadre;
    
      ---200-2153
      open cupro_order_activity(rgOrder.order_id);
      fetch cupro_order_activity
        into nuproductid;
	
      IF cupro_order_activity%NOTFOUND THEN
        nuproductid := null;
      END IF;
      close cupro_order_activity;
    
      OPEN cuMedidor(dtFechaEjecfIN);
	
      FETCH cuMedidor
        INTO MedidorLega;
      CLOSE cuMedidor;
    
      open cuMedidorAct;
      fetch cuMedidorAct
        into MedidorAct;
	
      close cuMedidorAct;
    
      Medidor := MedidorAct;
    
      if MedidorLega != MedidorAct then
        dtFechaEjecFinLega := sysdate;
      
        open cuUltimaLectura(nuproductid);
        fetch cuUltimaLectura
          into nuLectura;
	  
        close cuUltimaLectura;
      else
        dtFechaEjecFinLega := dtFechaEjecfIN;
      end if;
    
      --200-2062------------------------------------
    
      --200-2062------------------------------------
    
      sbCadenalega := rgOrder.ORDER_ID || '|' || nuCausalLeg || '|' ||
                      nuPersonaLega || '||' || rgOrder.ORDER_ACTIVITY_ID || '>' ||
                      nuCantidad || ';READING>' || NVL(nuLectura, '') ||
                      '>9>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>||' ||
                      Medidor || ';1=' || NVL(nuLectura, '') || '=T===|' ||
                      '1277;Orden Legalizada por proceso ' || csbPRograma ||
                      ' - cuOrderByRepara';
    
      pkg_traza.trace('LLama api_legalizeorders sbCadenalega: ' ||
                      sbCadenalega || chr(10) || 'dtFechaEjecIni: ' ||
                      dtFechaEjecIni || chr(10) || 'dtFechaEjecFinLega: ' ||
                      dtFechaEjecFinLega,
                      pkg_traza.cnuNivelTrzDef);
      api_legalizeorders(sbCadenalega,
                         dtFechaEjecIni,
                         dtFechaEjecFinLega,
                         null,
                         nuErr,
                         sbMsg);
    
      pkg_traza.trace('Sale api_legalizeorders nuerrorcode: ' || nuErr ||
                      chr(10) || 'sberrormessage: ' || sbMsg,
                      pkg_traza.cnuNivelTrzDef);
    
      -- Se valida si la orden se cerro correctamente
      IF nuErr <> 0 THEN
        sbmensa := 'api_legalizeorders: Error legalizando orden: [' ||
                   rgOrder.order_id || ']' || ', error: ' || nuErr || '-' ||
                   sbMsg;
        proRegistraLogLegOrdRecoSusp(csbPRograma,
                                     SYSDATE,
                                     rgOrder.order_id,
                                     nuOrderOri,
                                     sbmensa,
                                     USER);
        ROLLBACK;
      else
        -- Se adicionan comentarios de orden padre
        FOR rgComment IN cuCommentFather(nuOrderOri) LOOP
          nuErr := null;
          sbMsg := null;
        
          api_addordercomment(rgOrder.ORDER_ID,
                              3,
                              rgComment.order_comment,
                              nuErr,
                              sbMsg);
          IF nuErr <> 0 THEN
            sbmensa := 'api_addordercomment: Error asignando comentarios a la orden de reconexion [' ||
                       rgOrder.order_id || csbPrintError || nuErr || '-' ||
                       sbMsg;
		  
            proRegistraLogLegOrdRecoSusp(csbPRograma,
                                         SYSDATE,
                                         rgOrder.order_id,
                                         nuOrderOri,
                                         sbmensa,
                                         USER);
		  
            rollback;
          else
            commit;
          END IF;
        END LOOP;
      END IF;
    END LOOP;
  
    pkg_traza.trace('FIN cursor cuOrderByRepara', pkg_traza.cnuNivelTrzDef);
    -- FIN 200-2096
  
    --TICKET 200-2231 ELAL -- se coinsultan ordenes de suspension de autoreconectado
    FOR reg IN cuOrdenesSuspAuto LOOP
      IF reg.orden IS NOT NULL THEN
        nuerrorcode    := null;
	  
        sberrormessage := null;
        nuOrdenGene    := reg.orden;
        nuorden        := reg.orden_padre;
        delete LDC_BLOQ_LEGA_SOLICITUD
         where PACKAGE_ID_GENE = reg.package_id;
        --Ticket  LJLB -- se procede asignar la orden generada
        api_assign_order(inuOrder         => reg.orden,
                         inuOperatingUnit => reg.unidad,
                         onuErrorCode     => nuerrorcode,
                         osbErrorMessage  => sberrormessage);
      
        IF nuerrorcode = 0 THEN
        
          dbms_lock.sleep(1);
          nuerrorcode    := null;
          sberrormessage := null;
          sbmensa        := null;
          --200-2680
          IF reg.causal IS NOT NULL THEN
          
            api_legalizeorders(nuOrdenGene || '|' || reg.causal || '|' ||
                               reg.persona || '|' || '|' || reg.actividad || '>' ||
                               reg.tipo || ';;;;|' || reg.itemsadic || '||' ||
                               '1277;Orden Legalizada por proceso LDC_PKGENEORDEAUTORECO.LDC_PROGENTRAMVSI',
							   
                               SYSDATE,
                               SYSDATE,
                               null,
                               nuerrorcode,
                               sberrormessage);
          
            pkg_traza.trace('Sale api_legalizeorders nuerrorcode: ' ||
                            nuerrorcode || chr(10) || 'sberrormessage: ' ||
							
                            sberrormessage,
                            pkg_traza.cnuNivelTrzDef);
          
            dbms_lock.sleep(2);
            --Ticket  LJLB -- se valida que todo alla terminado bien
            IF nuerrorcode = 0 THEN
              --agregar comentarios
              FOR rfcucomentarios IN cucomentarios LOOP
                api_addordercomment(nuOrdenGene,
                                    3,
                                    substr(rfcucomentarios.comentarioot,
                                           1,
                                           1900),
                                    nuerrorcode,
                                    sberrormessage);
                IF nuerrorcode <> 0 THEN
				
                  sbmensa := 'api_addordercomment: Error asignando comentarios a la orden de VSI [' ||
                             nuOrdenGene || csbPrintError || nuerrorcode || '-' ||
                             sberrormessage;
                  proRegistraLogLegOrdRecoSusp(csbPRograma,
                                               SYSDATE,
                                               nuOrdenGene,
                                               nuOrden,
                                               sbmensa,
                                               USER);
                  rollback;
                END IF;
              END LOOP; --
              commit;
            ELSE
              sbmensa := 'api_legalizeorders: Error legalizando orden de VSI ' ||
                         nuerrorcode || '-' || sberrormessage;
              proRegistraLogLegOrdRecoSusp(csbPRograma,
                                           SYSDATE,
                                           nuOrdenGene,
                                           nuOrden,
                                           sbmensa,
                                           USER);
              dbms_lock.sleep(2);
			
              rollback;
            END IF;
          ELSE
            rollback;
            sbmensa := 'Error no hay causal configurada, por favor valide el parametro LDC_CAUSLEGRECSCERT';
		  
            proRegistraLogLegOrdRecoSusp(csbPRograma,
                                         SYSDATE,
                                         nuOrdenGene,
                                         nuOrden,
                                         sbmensa,
                                         USER);
		  
          END IF;
        ELSE
          sbmensa := 'API_ASSIGN_ORDER: Error asignando orden de VSI[' ||
                     nuOrdenGene || csbPrintError || nuerrorcode || '-' ||
                     sberrormessage;
          proRegistraLogLegOrdRecoSusp(csbPRograma,
                                       SYSDATE,
                                       nuOrdenGene,
                                       nuOrden,
                                       sbmensa,
                                       USER);
          rollback;
          dbms_lock.sleep(2);
		
        END IF;
	  
      END IF;
    END LOOP;
  
    -- INICIO CASO:466
    FOR reg IN cuREG LOOP
    
      BEGIN
      
        OPEN cuObunit(TO_NUMBER(EXTRACT(YEAR FROM reg.plazo_min_revision)),
                      TO_NUMBER(EXTRACT(MONTH FROM reg.plazo_min_revision)),
                      reg.departamento);
	  
        FETCH cuObunit
          INTO nuUnitop;
	  
        CLOSE cuObunit;
      
        IF nuUnitop IS NOT NULL THEN
        
          BEGIN
		  
            delete LDC_BLOQ_LEGA_SOLICITUD
             where PACKAGE_ID_GENE = reg.package_id;
          EXCEPTION
            WHEN OTHERS THEN
              NULL;
          END;
          -- se utiliza el api para Asignar la nuva creada ot
          api_assign_order(inuOrder         => reg.order_id,
                           inuOperatingUnit => nuUnitop,
                           onuErrorCode     => nuerrorcode,
                           osbErrorMessage  => sberrormessage);
        
          IF nvl(nuerrorcode, 0) != 0 THEN
            sbmensa := 'API_ASSIGN_ORDER: Error asignando orden [' ||
                       reg.order_id || csbPrintError || nuerrorcode || '-' ||
                       sberrormessage;
		  
            proRegistraLogLegOrdRecoSusp(csbPRograma,
                                         SYSDATE,
                                         reg.order_id,
                                         NULL,
                                         sbmensa,
                                         USER);
		  
            rollback;
          else
            commit;
          END IF;
        
        END IF;
      
      END;
    
    END LOOP;
  
    --INICIO CASO:466
  
    --INICIO CA 147
    FOR reg IN cugetOrdenesRPasig LOOP
      nuerrorcode    := NULL;
      sberrormessage := NULL;
      sbmensa        := NULL;
      delete LDC_BLOQ_LEGA_SOLICITUD where PACKAGE_ID_GENE = reg.ORAPSOGE;
      -- se procede asignar la orden generada
      api_assign_order(inuOrder         => reg.orden,
                       inuOperatingUnit => reg.unidad,
                       onuErrorCode     => nuerrorcode,
                       osbErrorMessage  => sberrormessage);
      IF nuerrorcode = 0 THEN
        COMMIT;
      ELSE
        sbmensa := 'API_ASSIGN_ORDER: Error asignando orden [' || reg.orden ||
                   csbPrintError || nuerrorcode || '-' || sberrormessage;
	  
        proRegistraLogLegOrdRecoSusp(csbPRograma,
                                     SYSDATE,
                                     reg.orden,
                                     NULL,
                                     sbmensa,
                                     USER);
	  
        rollback;
      END IF;
    
    END LOOP;
    --FIN CA 147
  
    ------------------------------  Inicio Caso 588 --------------------------------------
  
    ----------------------------  PROCESO DE ASIGNACION DE REFORMAS ------------------------------------
  
    --- se valida que los parametros de reformas no este vacio
    IF (cuValParVaciReform%ISOPEN) THEN
      CLOSE cuValParVaciReform;
    END IF;
  
    OPEN cuValParVaciReform;
    FETCH cuValParVaciReform
      INTO NUVALPARVACIO_REFO;
  
    CLOSE cuValParVaciReform;
  
    IF (NUVALPARVACIO_REFO > 0) THEN
    
      IF (cuGetOrderTTAsigDefRef%ISOPEN) THEN
        CLOSE cuGetOrderTTAsigDefRef;
      END IF;
    
      FOR i IN cuGetOrderTTAsigDefRef LOOP
      
        begin
        
          -- se valida la unidad operativa con el cursor
          IF (cuGETUndOpeAsigRef%ISOPEN) THEN
            CLOSE cuGETUndOpeAsigRef;
          END IF;
        
          OPEN cuGETUndOpeAsigRef(i.producto);
          FETCH cuGETUndOpeAsigRef
            INTO nuOpeUnit;
		
          IF (cuGETUndOpeAsigRef%NOTFOUND) THEN
            nuOpeUnit := 0;
          END IF;
          CLOSE cuGETUndOpeAsigRef;
        
          IF (nuOpeUnit != 0) THEN
          
            --- se desbloquea la solicitud ---
		  
            delete LDC_BLOQ_LEGA_SOLICITUD
             where PACKAGE_ID_GENE = i.package_id;
          
            --- se asigna la orden ---
            api_assign_order(inuOrder         => i.orden,
                             inuOperatingUnit => nuOpeUnit,
                             onuErrorCode     => onuerrorcode,
                             osbErrorMessage  => osberrormessage);
          
            IF (onuerrorcode != 0) THEN
              sbmensa := 'API_ASSIGN_ORDER: Error asignando orden [' ||
                         i.orden || csbPrintError || nuerrorcode || '-' ||
                         sberrormessage;
			
              proRegistraLogLegOrdRecoSusp(NOM_PROCESOPAR,
                                           SYSDATE,
                                           i.orden,
                                           NULL,
                                           sbmensa,
                                           USER);
			
              rollback;
            ELSE
              commit;
            END IF;
          
          ELSE
            sbmensa := 'No se Encontro unidad operativa que haya legalizado una ultima orden para los tipos de trabajo configurado en el parametro [TITR_UNIDAD_ASIG_REFORMAS]';
            proRegistraLogLegOrdRecoSusp(NOM_PROCESOPAR,
                                         SYSDATE,
                                         i.orden,
                                         NULL,
                                         sbmensa,
                                         USER);
		  
            rollback;
          END IF;
        
        EXCEPTION
          when PKG_ERROR.CONTROLLED_ERROR then
            rollback;
            Pkg_Error.geterror(nuError, sbmensa);
            proRegistraLogLegOrdRecoSusp(NOM_PROCESOPAR,
                                         SYSDATE,
                                         i.orden,
                                         NULL,
                                         nuError || '-' || sbmensa,
                                         USER);
		  
            Pkg_Error.SetErrorMessage(nuError, sbmensa);
          
          when others then
            rollback;
            Pkg_Error.geterror(nuError, sbmensa);
            proRegistraLogLegOrdRecoSusp(NOM_PROCESOPAR,
                                         SYSDATE,
                                         i.orden,
                                         NULL,
                                         nuError || '-' || sbmensa,
                                         USER);
		  
            Pkg_Error.SetErrorMessage(nuError, sbmensa);
        END;
      
      END LOOP;
    
    END IF;
  
    ----------------------------  PROCESO DE ASIGNACION CERTIFICACION DE REFORMAS ------------------------------------
  
    --- se valida que los parametros de certificacion no este vacio
    IF (cuValParVaciCert%ISOPEN) THEN
      CLOSE cuValParVaciCert;
    END IF;
  
    OPEN cuValParVaciCert;
  
    FETCH cuValParVaciCert
      INTO NUVALPARVACIO_CERT;
    CLOSE cuValParVaciCert;
  
    IF (NUVALPARVACIO_CERT > 0) THEN
    
      nuOpeUnit := null;
    
      IF (cuGetOrderTTACERTREF%ISOPEN) THEN
        CLOSE cuGetOrderTTACERTREF;
      END IF;
    
      FOR j IN cuGetOrderTTACERTREF LOOP
      
        begin
        
          -- se valida la unidad operativa con el cursor
          IF (cuGETUndOpeAsigCertVis%ISOPEN) THEN
            CLOSE cuGETUndOpeAsigCertVis;
          END IF;
        
          OPEN cuGETUndOpeAsigCertVis(j.producto);
          FETCH cuGETUndOpeAsigCertVis
            INTO nuOpeUnit;
		
          IF (cuGETUndOpeAsigCertVis%NOTFOUND) THEN
            nuOpeUnit := 0;
          END IF;
          CLOSE cuGETUndOpeAsigCertVis;
        
          IF (nuOpeUnit != 0) THEN
          
            --- se desbloquea la solicitud ---
		  
            delete LDC_BLOQ_LEGA_SOLICITUD
             where PACKAGE_ID_GENE = j.package_id;
          
            --- se asigna la orden ---
            api_assign_order(inuOrder         => j.orden,
                             inuOperatingUnit => nuOpeUnit,
                             onuErrorCode     => onuerrorcode,
                             osbErrorMessage  => osberrormessage);
          
            IF (onuerrorcode != 0) THEN
              sbmensa := 'API_ASSIGN_ORDER: Error asignando orden [' ||
                         j.orden || csbPrintError || nuerrorcode || '-' ||
                         sberrormessage;
			
              proRegistraLogLegOrdRecoSusp(NOM_PROCESOPAR,
                                           SYSDATE,
                                           j.orden,
                                           NULL,
                                           sbmensa,
                                           USER);
			
              rollback;
            ELSE
              commit;
            END IF;
          
          ELSE
            sbmensa := 'No se Encontro unidad operativa que haya legalizado una ultima orden para los tipos de trabajo configurado en el parametro [TITR_UNIDAD_ASIG_CERTVISIT]';
            proRegistraLogLegOrdRecoSusp(NOM_PROCESOPAR,
                                         SYSDATE,
                                         j.orden,
                                         NULL,
                                         sbmensa,
                                         USER);
            rollback;
          END IF;
        
        EXCEPTION
          when PKG_ERROR.CONTROLLED_ERROR then
            rollback;
            Pkg_Error.geterror(nuError, sbmensa);
            proRegistraLogLegOrdRecoSusp(NOM_PROCESOPAR,
                                         SYSDATE,
                                         j.orden,
                                         NULL,
                                         nuError || '-' || sbmensa,
                                         USER);
            Pkg_Error.SetErrorMessage(nuError, sbmensa);
          
          when others then
            rollback;
            Pkg_Error.geterror(nuError, sbmensa);
            proRegistraLogLegOrdRecoSusp(NOM_PROCESOPAR,
                                         SYSDATE,
                                         j.orden,
                                         NULL,
                                         nuError || '-' || sbmensa,
                                         USER);
            Pkg_Error.SetErrorMessage(nuError, sbmensa);
        END;
      
      END LOOP;
    
    END IF;
  
    ------------------------------  Fin Caso 588 --------------------------------------
    --INICIO CA 472
    FOR n IN cuProductosYaSuspendidosAcom LOOP
      nuerrorcode    := null;
      sberrormessage := null;
      nuPersonaLega  := n.RESPONSABLE_ID;
      --cadena datos adicionales
      SBDATOSADICIONALES := NULL;
    
      for rc in cugrupo(pkg_bcordenes.fnuobtienetipotrabajo(n.ORDER_ID),
                        nuCausalUserYaSuspAco) loop
        pkg_traza.trace('Grupo de dato adicional [' || rc.attribute_set_id ||
                        '] asociado al tipo de trabajo [' ||
                        rc.task_type_id || ']',
                        pkg_traza.cnuNivelTrzDef);
      
        for rcdato in cudatoadicional(rc.attribute_set_id) loop
          IF SBDATOSADICIONALES IS NULL THEN
            SBDATOSADICIONALES := RCDATO.NAME_ATTRIBUTE || '=';
          ELSE
            SBDATOSADICIONALES := SBDATOSADICIONALES || ';' ||
                                  RCDATO.NAME_ATTRIBUTE || '=';
          END IF;
          pkg_traza.trace('Dato adicional[' || rcdato.name_attribute || ']',
                          pkg_traza.cnuNivelTrzDef);
        end loop;
      end loop;
      --fin cadena datos adicionales
    
      --cadena legalizacion de orden prinipal
      SBCADENALEGALIZACION := NULL;
      OPEN CUCADENALEGALIZACION(n.ORDER_ID,
                                nuCausalUserYaSuspAco,
                                'Orden Legalizada por proceso ' ||
                                csbPRograma,
                                SBDATOSADICIONALES,
                                nuPersonaLega,
                                null);
      FETCH CUCADENALEGALIZACION
        INTO SBCADENALEGALIZACION;
      CLOSE CUCADENALEGALIZACION;
      --fin cadena legalizacion de orden prinipal
    
      pkg_traza.trace('Cadena legalizacion orden [' ||
                      SBCADENALEGALIZACION || '] ',
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('LLama api_legalizeorders SBCADENALEGALIZACION: ' ||
                      SBCADENALEGALIZACION || chr(10) ||
                      'dtFechaEjecIni: ' || sysdate || chr(10) ||
                      'dtFechaEjecFinLega: ' || sysdate || chr(10) ||
                      'idtChangeDate: ' || sysdate,
                      pkg_traza.cnuNivelTrzDef);
    
      ---INICIO LEGALIZAR TRABAJO ADICIONAL
      api_legalizeorders(SBCADENALEGALIZACION,
                         sysdate,
                         sysdate,
                         sysdate,
                         nuerrorcode,
                         sberrormessage);
    
      pkg_traza.trace('Sale api_legalizeorders nuerrorcode: ' ||
                      nuerrorcode || chr(10) || 'sberrormessage: ' ||
                      sberrormessage,
                      pkg_traza.cnuNivelTrzDef);
    
      IF nuerrorcode <> 0 THEN
        sbmensa := 'api_legalizeorders: Error legalizando orden: [' ||
                   n.ORDER_ID || ']' || ', error: ' || nuerrorcode || '-' ||
                   sberrormessage;
        --CASO 200-2390
        nuOTPadre := null;
        open CUOOR_RELATED_ORDER(n.ORDER_ID);
        fetch CUOOR_RELATED_ORDER
          into rfCUOOR_RELATED_ORDER;
        if CUOOR_RELATED_ORDER%found then
          if rfCUOOR_RELATED_ORDER.Order_Id is not null then
            nuOTPadre := rfCUOOR_RELATED_ORDER.Order_Id;
          end if;
        end if;
        close CUOOR_RELATED_ORDER;
        -----------------------
        proRegistraLogLegOrdRecoSusp(csbPRograma,
                                     SYSDATE,
                                     n.ORDER_ID,
                                     nuOTPadre,
                                     sbmensa,
                                     USER);
        ROLLBACK;
      ELSE
        DELETE FROM LDC_PRODUCTOPARASUSP
         WHERE ORDER_ID = n.ORDER_ID
           AND PROCESO = 'USER_YA_SUSPE_ACO';
        commit;
	  
      END IF;
    
    END LOOP;
  
    FOR reg IN cuOrdenesSuspDummy LOOP
      IF reg.orden IS NOT NULL THEN
	  
        nuerrorcode    := null;
	  
        sberrormessage := null;
        nuOrdenGene    := reg.orden;
        nuorden        := reg.orden_padre;
        sbLectura      := null;
        TBSTRING.DELETE; --Ticket  LJLB -- se limpia tabla pl
        ut_string.EXTSTRING(sbComentario, '|', TBSTRING);
        nuproductid := reg.producto;
      
        --TICKET 200-1968 LJLB-- se consulta lectura de los datos adicionales
        OPEN cuLecturaOrdePadre(nuParaLectSusp);
        FETCH cuLecturaOrdePadre
          INTO nuLectura;
        IF cuLecturaOrdePadre%NOTFOUND THEN
          sbLectura := TBSTRING(3);
          nuPosiIni := INSTR(sbLectura, '[', 1) + 1;
          sbLectura := substr(sbLectura, nuPosiIni, length(sbLectura));
          nuLectura := tO_nUmber(substr(sbLectura, 1, length(sbLectura) - 1));
        END IF;
        CLOSE cuLecturaOrdePadre;
      
        delete LDC_BLOQ_LEGA_SOLICITUD
         where PACKAGE_ID_GENE = reg.package_id;
        --Ticket  LJLB -- se procede asignar la orden generada
        api_assign_order(inuOrder         => reg.orden,
                         inuOperatingUnit => reg.unidad,
                         onuErrorCode     => nuerrorcode,
                         osbErrorMessage  => sberrormessage);
      
        IF nuerrorcode = 0 THEN
        
          dbms_lock.sleep(1);
          nuerrorcode    := null;
          sberrormessage := null;
          sbmensa        := null;
          nuEstado       := null;
          numarca        := null;
          numarcaOtPadre := null;
        
          -- se consulta estado del producto
          OPEN cuEstadoProducto(nuproductid);
          FETCH cuEstadoProducto
            INTO nuEstado;
          IF cuEstadoProducto%NOTFOUND THEN
            nuCausallega := -1;
          END IF;
          CLOSE cuEstadoProducto;
        
          IF nvl(nuCausallega, 0) <> -1 THEN
            IF nuEstado = 2 THEN
              nuCausallega := nuCausalLegUsuSup;
            ELSE
              nuCausallega := nuCausalLegUsuNSup;
            END IF;
          
            IF nuCausallega IS NOT NULL THEN
              OPEN cuTipoCausal(nuCausallega);
              FETCH cuTipoCausal
                INTO nuClaseCausal;
              CLOSE cuTipoCausal;
            
              IF nuClaseCausal > 0 THEN
			  
                ---200-2153
                OPEN cuMedidor(dtFechaEjecfIN);
                FETCH cuMedidor
                  INTO MedidorLega;
			  
                CLOSE cuMedidor;
              
                open cuMedidorAct;
                fetch cuMedidorAct
                  into MedidorAct;
			  
                close cuMedidorAct;
              
                Medidor := MedidorAct;
              
                if MedidorLega != MedidorAct then
                  dtFechaEjecFinLega := sysdate;
                
                  open cuUltimaLectura(reg.producto);
                  fetch cuUltimaLectura
                    into nuLectura;
				
                  close cuUltimaLectura;
                else
                  dtFechaEjecFinLega := dtFechaEjecfIN;
                end if;
                --200-2062------------------------------------
              
                sbCadenalega := nuOrdenGene || '|' || nuCausallega || '|' ||
                                nuPersona1886 || '||' || REG.actividad || '>' ||
                                nuClaseCausal || ';READING>' ||
                                NVL(nuLectura, '') ||
                                '>9>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|' ||
                                NVL(sbItemLegaSusp, '') || '|' || Medidor ||
                                ';1=' || NVL(nuLectura, '') || '=T===|' ||
                                '1277;Orden Legalizada por proceso ' ||
                                csbPRograma;
			  
              ELSE
                sbCadenalega := nuOrdenGene || '|' || nuCausallega || '|' ||
                                nuPersona1886 || '||' || REG.actividad || '>' ||
                                nuClaseCausal ||
                                ';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|' ||
                                NVL(sbItemLegaSusp, '') ||
                                '||1277;Orden Legalizada por proceso ' ||
                                csbPRograma;
			  
              END IF;
              pkg_traza.trace('LLama api_legalizeorders sbCadenalega: ' ||
                              sbCadenalega || chr(10) ||
							  
                              'dtFechaEjecIni: ' || SYSDATE || chr(10) ||
                              'dtFechaEjecFinLega: ' || SYSDATE,
                              pkg_traza.cnuNivelTrzDef);
            
              api_legalizeorders(sbCadenalega,
                                 SYSDATE,
                                 SYSDATE,
                                 null,
                                 nuerrorcode,
                                 sberrormessage);
            
              pkg_traza.trace('Sale api_legalizeorders nuerrorcode: ' ||
                              nuerrorcode || chr(10) || 'sberrormessage: ' ||
							  
                              sberrormessage,
                              pkg_traza.cnuNivelTrzDef);
            
              dbms_lock.sleep(2);
              --Ticket  LJLB -- se valida que todo alla terminado bien
			
              IF nuerrorcode = 0 THEN
                --agregar comentarios
                FOR rfcucomentarios IN cucomentarios LOOP
                  api_addordercomment(nuOrdenGene,
                                      3,
                                      substr(rfcucomentarios.comentarioot,
                                             1,
                                             1900),
									  
                                      nuerrorcode,
                                      sberrormessage);
                  IF nuerrorcode <> 0 THEN
                    sbmensa := 'api_addordercomment: Error asignando comentarios a la orden de VSI [' ||
                               nuOrdenGene || csbPrintError || nuerrorcode || '-' ||
                               sberrormessage;
                    proRegistraLogLegOrdRecoSusp(csbPRograma,
                                                 SYSDATE,
                                                 nuOrdenGene,
                                                 nuOrden,
                                                 sbmensa,
                                                 USER);
                    rollback;
                  END IF;
                END LOOP; --
                --se genera proceso de rp
                numarca := ldc_fncretornamarcaprod(reg.producto);
              
                if nvl(numarca, -1) != -1 then
                
                  LDCPROCREATRAMITESRP(nuorden, numarca, reg.package_id);
                end if;
                commit;
              
              ELSE
                sbmensa := 'api_legalizeorders: Error legalizando orden de VSI ' ||
                           nuerrorcode || '-' || sberrormessage;
                proRegistraLogLegOrdRecoSusp(csbPRograma,
                                             SYSDATE,
                                             nuOrdenGene,
                                             nuOrden,
                                             sbmensa,
                                             USER);
                dbms_lock.sleep(2);
                rollback;
              END IF;
            ELSE
			
              rollback;
              sbmensa := 'Error no hay causal configurada, por favor valide el parametro LDC_CAUSLEGRECSCERT';
              proRegistraLogLegOrdRecoSusp(csbPRograma,
                                           SYSDATE,
                                           nuOrdenGene,
                                           nuOrden,
                                           sbmensa,
                                           USER);
            END IF;
		  
          END IF;
        ELSE
          sbmensa := 'API_ASSIGN_ORDER: Error asignando orden de suspension [' ||
                     nuOrdenGene || csbPrintError || nuerrorcode || '-' ||
                     sberrormessage;
          proRegistraLogLegOrdRecoSusp(csbPRograma,
                                       SYSDATE,
                                       nuOrdenGene,
                                       nuOrden,
                                       sbmensa,
                                       USER);
          rollback;
          dbms_lock.sleep(2);
        END IF;
	  
      END IF;
    END LOOP;
    --FIN CA 472
  
    pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                     isbEstado      => 'Ok',
                                     isbObservacion => sbmensa);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
  
    WHEN pkg_Error.controlled_error THEN
      rollback;
      pkg_error.setError;
      pkg_error.getError(nuerrorcode, sberrormessage);
      pkg_traza.trace(csbPrinErrExc || nuerrorcode || '-' ||
                      sberrormessage,
                      pkg_traza.cnuNivelTrzDef);
	
      sbmensa := 'Proceso termino con Errores. ' || sbmensa || ' error ' ||
                 sberrormessage;
	
      pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                       isbEstado      => 'Error',
                                       isbObservacion => sbmensa);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
	
      RAISE pkg_Error.controlled_error;
    WHEN OTHERS THEN
      pkg_Error.seterror;
      pkg_Error.geterror(nuerrorcode, sberrormessage);
      sbmensa := 'Proceso termino con Errores. ' || sbmensa || ' error ' ||
                 sberrormessage;
	
      pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                       isbEstado      => 'Error',
                                       isbObservacion => sbmensa);
    
      pkg_traza.trace(csbPrinErrExc || nuerrorcode || '-' ||
                      sberrormessage,
                      pkg_traza.cnuNivelTrzDef);
	
      rollback;
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
	
      RAISE pkg_Error.controlled_error;
  END JOB_LEGAORDENRECOYSUSPADMI;

  PROCEDURE LDC_PRCREASOLIRECOSINCERT IS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P
    
    Funcion     : LDC_PROCREASOLIRECOSINCERT
    Descripcion : Procedimiento que crea el tramite reconexión sin certificación por medio de XML
    Autor       : Luis Javier Lopez barrios
    Fecha       : 10-04-2018
    
    Historia de Modificaciones
    Fecha               Autor                Modificacion
    =========           =========          ====================
    19/03/2021          ljlb                ca 472 se valida si producto esta vencido para generar suspension
    18/07/2023          jerazoer            Caso OSF-1260: 
                                            1. Se elimina la funcion fblAplicaEntregaxCaso, para las entregas la cual retorna true.
                                            2. Se ajusta el manejo de errores por el pkg_Error.
    **************************************************************************/
    csbMetodo                     CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                                            'LDC_PRCREASOLIRECOSINCERT'; --Nombre del método en la traza
    csbVAL_TRAMITES_NUEVOS_FLUJOS CONSTANT ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('VAL_TRAMITES_NUEVOS_FLUJOS');
																												   
  
    nupackageid mo_packages.package_id%TYPE;
  
    nuerrorcode    NUMBER;
    sberrormessage VARCHAR2(10000);
  
    sbmensa             VARCHAR2(10000);
    nupakageid          mo_packages.package_id%TYPE;
    nucliente           ge_subscriber.subscriber_id%TYPE;
    numediorecepcion    mo_packages.reception_type_id%TYPE;
    sbdireccionparseada ab_address.address_parsed%TYPE;
    nudireccion         ab_address.address_id%TYPE;
    nulocalidad         ab_address.geograp_location_id%TYPE;
    nucategoria         mo_motive.category_id%TYPE;
    nusubcategori       mo_motive.subcategory_id%TYPE;
    sbComment           VARCHAR2(2000);
    nuProductId         NUMBER;
    nuContratoId        NUMBER;
    nuTaskTypeId        NUMBER;
    sw                  NUMBER(2) DEFAULT 0;
    nuunidadoperativa   or_order.operating_unit_id%TYPE;
    nuestadosolicitud   mo_packages.motive_status_id%TYPE;
    sbsolicitudes       VARCHAR2(1000);
    nuorden             number;
    numarca             ge_suspension_type.suspension_type_id%type;
    numarcaantes        ge_suspension_type.suspension_type_id%type;
  
    nuCodigoAtrib  ld_parameter.numeric_value%type := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_CODIATRLECTRECOSCERT');
																							   
    sbNombreoAtrib ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_NOMBATRLECTRECOSCERT');
																						   
    sbTipoSuspe    ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('ID_RP_SUSPENSION_TYPE');
																						   
    nuLectura      NUMBER;
    sbTipoSuspeTra ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_TIPOSUSP_RECO');
																						   
    sbdato         VARCHAR2(1);
    nuPersonaLega  ge_person.person_id%TYPE := pkg_bopersonal.fnugetpersonaid;
    nuTipoSoli     mo_pAckages.package_type_id%TYPE; --TICKET 200-1968 LJLB-- se almacena tipo de solicitud
    sbTipoSoliVali ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_TRAMVALMARPRO'); --TICKET 200-1968 LJLB-- Se almacena listado de tipo de solicitudes a validar
																																										 
    nuMarcaSoli    ld_parameter.numeric_value%type := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_MAPR_TRAMRECO'); --TICKET 200-1968 LJLB-- Se almacena marca a validar
																																					
    --INICIO CA 472
    dtFechaEjec   DATE;
    nuUnidadDummy NUMBER := pkg_bcldc_pararepe.fnuobtienevalornumerico('UNIT_DUMMY_RP');
																
    nuEstaProd    NUMBER;
    osbSuspRp     VARCHAR2(1) := 'N';
    nucausal_id   ge_causal.causal_id%type;
    --FIN CA 472
    sbNoRepaSusp  varchar2(1) := 'N';
    sbcertificado ldc_certificados_oia.certificado%TYPE;
    nucodatributo ge_attributes.attribute_id%TYPE := pkg_bcld_parameter.fnuobtienevalornumerico('COD_DATO_ADICIONAL_VAL_CERTI');
																							  
    sbnombreatrib ge_attributes.name_attribute%TYPE := pkg_bcld_parameter.fsbobtienevalorcadena('NOMBRE_ATRI_VAL_CERTI');
																							  
  
    CURSOR cusolicitudesabiertas(nucuproducto pr_product.product_id%TYPE) IS
      SELECT pv.package_id colsolicitud
        FROM mo_packages pv, mo_motive mv
	  
       WHERE pv.package_type_id IN
             (SELECT (regexp_substr(csbVAL_TRAMITES_NUEVOS_FLUJOS,
                                    csbPatronRegex,
                                    1,
                                    LEVEL)) AS vlrColumna
									
                FROM dual
              CONNECT BY regexp_substr(csbVAL_TRAMITES_NUEVOS_FLUJOS,
                                       csbPatronRegex,
                                       1,
                                       LEVEL) IS NOT NULL)
									
									 
			
         AND pv.motive_status_id =
             pkg_bcld_parameter.fnuobtienevalornumerico('ESTADO_SOL_REGISTRADA')
         AND mv.product_id = nucuproducto
         AND pv.package_id = mv.package_id;
  
    --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
    CURSOR cuProducto(nucuorden NUMBER) IS
      SELECT product_id,
             subscription_id,
             oa.task_type_id,
             oa.package_id,
             oa.subscriber_id,
             ot.operating_unit_id,
             m.motive_status_id      estado_sol,
             M.PACKAGE_TYPE_ID       tipo_soli,
			 
             ot.EXECUTION_FINAL_DATE,
             ot.causal_id
	  
        FROM or_order_activity oa, or_order ot, mo_packages m
       WHERE oa.order_id = nucuorden
         AND oa.package_id IS NOT NULL
         AND oa.order_id = ot.order_id
         AND oa.package_id = m.package_id
         AND rownum = 1;
  
    -- Cursor para obtener los componentes asociados a un motivo
    CURSOR cuComponente(nucumotivos mo_motive.motive_id%TYPE) IS
      SELECT COUNT(1) FROM mo_component C WHERE c.package_id = nucumotivos;
  
    -- Se consulta si el producto esta suspendido
    CURSOR cuEstadoProducto(nuProducto pr_product.product_id%type) IS
      SELECT 'X'
        FROM PR_PRODUCT P, pr_prod_suspension PS
       WHERE P.PRODUCT_ID = PS.PRODUCT_ID
         AND P.PRODUCT_ID = nuProducto
         AND P.PRODUCT_STATUS_ID = 2
         AND PS.ACTIVE = 'Y'
			
			
         AND PS.SUSPENSION_TYPE_ID IN
             (SELECT (regexp_substr(sbTipoSuspe, csbPatronRegex, 1, LEVEL)) AS vlrColumna
                FROM dual
              CONNECT BY regexp_substr(sbTipoSuspe, csbPatronRegex, 1, LEVEL) IS NOT NULL);
  
    cursor cuPersonaLega(inuorden in or_order_person.order_id%type) is
      select person_id from or_order_person where order_id = inuorden;
  
    sbProceso VARCHAR2(100) := csbMetodo ||
                               TO_CHAR(SYSDATE, 'DDMMYYYYHH24MISS');
  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    nuorden := pkg_bcordenes.fnuobtenerotinstancialegal;
    -- Inicializamos el proceso 
    pkg_estaproc.prinsertaestaproc(isbProceso   => sbProceso,
                                   inuTotalRegi => null);
    pkg_traza.trace('Numero de la Orden:' || nuorden,
                    pkg_traza.cnuNivelTrzDef);
  
    -- obtenemos el producto y el paquete
    OPEN cuproducto(nuorden);
    FETCH cuProducto
      INTO nuproductid,
           nucontratoid,
           nutasktypeid,
           nupakageid,
           nucliente,
           nuunidadoperativa,
           nuestadosolicitud,
           nuTipoSoli,
           dtFechaEjec,
           nucausal_id;
  
    IF cuProducto%NOTFOUND THEN
	
      sbmensa := csbCadError ||
                 'El cursor cuProducto no arrojo datos con el # de orden' ||
                 to_char(nuorden);
	
      Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
    END IF;
    CLOSE cuproducto;
  
    pkg_traza.trace('Salio cursor cuProducto, nuProductId: ' ||
                    nuProductId || 'nuContratoId:' || 'nuTaskTypeId:' ||
                    nuTaskTypeId,
                    pkg_traza.cnuNivelTrzDef);
  
    -- Actualizamos las solicitud que se esta legalizando para que no salga como pendiente
    IF nuestadosolicitud = 13 THEN
      UPDATE mo_packages m
         SET m.motive_status_id = 14
       WHERE m.package_id = nupakageid;
    END IF;
  
    sbcertificado := ldc_boordenes.fsbDatoAdicTmpOrden(nuorden,
                                                       nucodatributo,
                                                       TRIM(sbnombreatrib));
  
    OPEN cuEstadoProducto(nuproductid);
    FETCH cuEstadoProducto
      INTO sbdato;
  
    IF cuEstadoProducto%NOTFOUND THEN
      numarcaantes := ldc_fncretornamarcaprod(nuproductid);
      numarca      := ldc_fnugetnuevamarca(nuorden);
      if nvl(numarca, -1) != -1 then
        ldcprocinsactumarcaprodu(nuproductid, numarca, nuorden);
        ldc_prmarcaproductolog(nuproductid,
                               numarcaantes,
                               numarca,
                               'Legalizacion OT :' || nuorden);
	  
      end if;
      sbmensa := csbCadError || 'El producto: ' || to_char(nuproductid) ||
                 ' no se encuentra suspendido o esta suspendido con un tipo diferente a[' ||
                 sbTipoSuspe || ']';
      return;
    END IF;
    CLOSE cuEstadoProducto;
  
    open cuPersonaLega(nuorden);
    fetch cuPersonaLega
      into nuPersonaLega;
    if cuPersonaLega%NOTFOUND then
      nuPersonaLega := NULL;
	
    end if;
    close cuPersonaLega;
  
    if nuPersonaLega is null then
      sbmensa := 'Proceso termino con errores : No se encontro persona que legaliza';
      Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
    end if;
  
    -- Buscamos solicitudes de revisión periodica generadas
    sbsolicitudes := NULL;
    FOR i IN cusolicitudesabiertas(nuproductid) LOOP
      if i.colsolicitud != nupakageid then
        IF sbsolicitudes IS NULL THEN
          sbsolicitudes := i.colsolicitud;
        ELSE
          sbsolicitudes := sbsolicitudes || ',' || to_char(i.colsolicitud);
        END IF;
      end if;
    END LOOP;
  
    IF TRIM(sbsolicitudes) IS NULL THEN
      -- Obtenemos los datos de la solicitud de visita de verificacion para generar el tramite de defecto critico
      sbdireccionparseada := NULL;
      nudireccion         := NULL;
      nulocalidad         := NULL;
      nucategoria         := NULL;
      nusubcategori       := NULL;
      sw                  := 1;
    
      nuLectura := ldc_boordenes.fsbDatoAdicTmpOrden(nuorden,
                                                     nuCodigoAtrib,
                                                     TRIM(sbNombreoAtrib));
	
      if nuLectura is null then
        sbmensa := csbCadError || 'No se ha digitado Lectura';
        Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
      end if;
    
      numarcaantes := ldc_fncretornamarcaprod(nuproductid); --TICKET 200-1968 LJLB -- se consulta marca del producto
    
      IF NVL(numarcaantes, 0) <> nuMarcaSoli AND
         (INSTR(sbTipoSoliVali, nuTipoSoli) > 0) THEN
	  
        sbTipoSuspeTra := '103';
      END IF;
      -- Construimos el XML para generar la orden de reconexión sin certificación
      sbcomment        := '[GENERACION PLUGIN]| LEGALIZACION ORDEN[' ||
                          nuorden || ']|LECTURA[' || nuLectura ||
                          ']|PERSONA[' || nuPersonaLega || ']| ' ||
                          substr(ldc_retornacomentotlega(nuorden), 1, 2000);
	
      numediorecepcion := pkg_bcld_parameter.fnuobtienevalornumerico('MEDIO_RECEPCION_RECO_SIN_CERT');
    
      if nucausal_id = 8903 and
         LDC_BODefectNoRepara.fsbValidateDefectsNoRepair(nuproductid,
                                                         nuorden,
                                                         sbcertificado) = 'S' then
	  
        sbNoRepaSusp := 'S';
      else
        sbNoRepaSusp := 'N';
      end if;
    
      --INICIO CA 472
      nupackageid := LDC_PKGESTIONLEGAORRP.FNUGETSOLIRECO(nuproductid,
                                                          sbTipoSuspeTra,
                                                          numediorecepcion,
                                                          sbcomment,
                                                          nuerrorcode,
                                                          sberrormessage);
      IF nupackageid IS NULL THEN
        sbmensa := csbCadError ||
                   'Error al generar la solicitud. Codigo error : ' ||
                   to_char(nuerrorcode) || ' Mensaje de error : ' ||
                   sberrormessage;
	  
        Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
      ELSE
        insert into LDC_BLOQ_LEGA_SOLICITUD
          (PACKAGE_ID_ORIG, PACKAGE_ID_GENE)
        values
          (nupakageid, nupackageid);
      
        -- Dejamos la solicitud como estaba
        IF nuestadosolicitud = 13 THEN
          UPDATE mo_packages m
             SET m.motive_status_id = 13
           WHERE m.package_id = nupakageid;
        END IF;
      
        IF LDC_PKGESTIONLEGAORRP.FBLGETPRODUCTOVENC(nuproductid,
                                                    dtFechaEjec) THEN
          nuEstaProd := LDC_PKGESTIONLEGAORRP.FNUGETESTAPROD(nuproductid,
                                                             osbSuspRp);
        
          if osbSuspRp = 'S' THEN
            IF nucausal_id = 3602 THEN
              nuUnidadDummy := nuunidadoperativa;
            END IF;
          
            if nucausal_id not in (9265, 3602) and sbNoRepaSusp = 'N' then
              INSERT INTO LDC_ORDEASIGPROC
                (ORAPORPA, ORAPSOGE, ORAOUNID, ORAOPROC)
              VALUES
                (nuorden, nupackageid, nuUnidadDummy, 'RECOSUSPRP');
            end if;
          END IF;
        
        END IF;
        sbmensa := 'Proceso termino Ok. Se genero la solicitud Nro : ' ||
                   to_char(nupackageid);
      
        pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                         isbEstado      => 'Ok',
                                         isbObservacion => sbmensa);
	  
      END IF;
	
      --FIN CA 472
    
      if nupackageid is not null and sbNoRepaSusp = 'S' then
	  
        INSERT INTO LDC_ORDEASIGPROC
          (ORAPORPA, ORAPSOGE, ORAOUNID, ORAOPROC)
        VALUES
          (nuorden, nupackageid, nuUnidadDummy, 'DEFNREPA');
      end if;
    ELSE
	
      sbmensa := 'Proceso termino. : El producto : ' ||
                 to_char(nuproductid) ||
                 ' ya tiene una solicitud de reconexión sin certificación en estado registrada.';
      Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
    END IF;
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN PKG_ERROR.controlled_error THEN
    
      Pkg_Error.seterror;
      pkg_error.getError(nuerrorcode, sbMensErro);
      pkg_traza.trace(csbPrinErrExc || nuerrorcode || sbMensErro,
                      pkg_traza.cnuNivelTrzDef);
      pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                       isbEstado      => 'Error',
                                       isbObservacion => sbMensErro);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RAISE PKG_ERROR.CONTROLLED_ERROR;
    
    WHEN OTHERS THEN
      sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
      pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                       isbEstado      => 'Error',
                                       isbObservacion => sbmensa);
      Pkg_Error.seterror;
      pkg_error.getError(nuerrorcode, sbMensErro);
      pkg_traza.trace(csbPrinErrExc || nuerrorcode || sbMensErro,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE PKG_ERROR.controlled_error;
  END LDC_PRCREASOLIRECOSINCERT;

  PROCEDURE LDC_PROCREASOLISUSPADMI IS
    /**************************************************************************
        Propiedad Intelectual de Gases del caribe S.A E.S.P
    
        Funcion     : LDC_PROCREASOLISUSPADMI
        Descripcion : Procedimiento que crea el tramite de suspension administrativa por revision periodica por medio de XML
        Autor       : Luis Javier Lopez Barrios
        Fecha       : 10-04-2018
    
        Historia de Modificaciones
          Fecha               Autor                Modificacion
        =========           =========          ====================
        19/09/2021          Horbath            CASO 667: Se ajusta el llamado a los parametros LDC_CAUSAL_DEF_NO_REPARA y LDC_TIPO_CAUSAL_DEF_NO_REPARA
        09/06/2021          Horbath            CASO 753: Se modifica la logica para establecer la forma de obtenci¿n de las variables ¿nutipoCausal¿ y ¿nuCausal¿,
                                                         Si el desarrollo aplica para la gasera y si el tipo de trabajo y causal de legalizaci¿n de la orden actual es igual a
                                                         la configurada en el par¿metro COD_VST_CERT_RP.
        17/01/2019          Jorge Valiente    CASO 200-2390: Se modifico la logica para establecer
                                                            en al entidad OR_RELATED_ORDER la relacion
                                                            entre la OT Padre y a OT Hija.
         18/09/2018       JOSH BRITO         CASO 200-2073 4. Modificar el proceso [LDC_PKGREPEGELERECOYSUSP.LDC_PROCREASOLISUSPADMI] para
                                                              3.1. Cuando se legalice 10444 y el producto se encuentre suspendido por suspensión diferente a
                                                              101,102,103 y 104, o cuando se legalice 10833 con causal 9809 definido en el parámetro TITRCAUSL_REPADEFCRIT_SERVSUSP
                                                              y el producto se encuentre suspendido, en lugar de generar el trámite de suspensión se creara una orden de trabajo con
                                                              la actividad en el parámetro [ACTIVITY_USUA_YA_SUSP_CM_RP] y se asociara al producto y la misma solicitud de la orden
                                                              que se está legalizando, una vez creada la nueva orden se asignara a la misma unidad de trabajo de la ordene que ese
                                                              está legalizando y se registrara la orden en la tabla LDC_PRODUCTOPARASUSP indicando que hace parte del proceso
                                                              [USER_YA_SUSPE]
                                                              Cuando se legalice 10795 con causal 3602 definido en el parámetro [TITRCAUSL_VISCERTREPA_DFCSUSP] si el producto se
                                                              encuentra suspendido con la misma suspensión que se le va a generar,  se insertara el registro en la tabla
                                                              [LDC_PRODUCTOPARASUSP], indicando que hace parte del proceso  [CERT_REPA_DEF_CON_SUSPE]
      18/07/2023      jerazoer                Caso OSF-1260: 
                                                              1. Se elimina la funcion fblAplicaEntregaxCaso, para las entregas la cual retorna true.
                                                              2. Se ajusta el manejo de errores por el pkg_Error.
      10/01/2024      epenao                  Caso OSF-1866:  En el llamado al método:  api_createorder   se adicionan los parámetros: 
                                                                 inuPackageid, inuSubscriptionid, inuProductid
                                                              Para que sean utilizados en la creación del registro en OR_ORDER_ACTIVITY.   
      02/07/2024      Jorge Valiente          Caso OSF-2863:  Cambiar logica donde se valida que el estado del producto sea 2 - Suspendido y que el tipo de trabajo sea 10444 y 
                                                              marca del producto no se encuentre en (101,102,103 y 104), adicionando el tipo de trabajo 10966.                                                              
                                                              * llamar a los nuevos parametros TIPTRA_PERMITE_CREAR_OT_10966 y MARPRO_EXCLUIDA_CREA_OT_10966
                                                              * Crear 2 nuevos cusores para validar existencia del tipo de trabajo y marca de producto en los nuevo paramertos
    
    **************************************************************************/
  
    csbMetodo                     CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                                            'LDC_PROCREASOLISUSPADMI'; --Nombre del método en la traza
    csbCOD_VST_CERT_RP            CONSTANT ldc_pararepe.paravast%type := pkg_bcldc_pararepe.fsbobtienevalorcadena('COD_VST_CERT_RP');
    csbVAL_TRAMITES_NUEVOS_FLUJOS CONSTANT ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('VAL_TRAMITES_NUEVOS_FLUJOS');
																												   
    nuErrorCode    NUMBER;
    sbErrorMessage VARCHAR2(4000);
    nuPackageId    mo_packages.package_id%type;
    nuMotiveId     mo_motive.motive_id%type;
    sbrequestxml1  constants_per.TIPO_XML_SOL%type;
    nuorden        or_order.order_id%type;
    sbComment      VARCHAR2(2000);
    nuProductId    NUMBER;
    nuContratoId   NUMBER;
    nuTaskTypeId   NUMBER;
    nuCausalOrder  NUMBER;
  
    nupakageid       mo_packages.package_id%TYPE;
    nucliente        ge_subscriber.subscriber_id%TYPE;
    numediorecepcion mo_packages.reception_type_id%TYPE;
    nudireccion      ab_address.address_id%TYPE;
    sw               NUMBER(2) DEFAULT 0;
    sbmensa          VARCHAR2(10000);
    dtfechasusp      DATE := SYSDATE;
    nutiposusp       ge_suspension_type.suspension_type_id%TYPE;
    nutipoCausal     NUMBER;
    nuCausal         NUMBER;
    sbsolicitudes    VARCHAR2(1000);
    numarcaantes     ldc_marca_producto.suspension_type_id%TYPE;
    nuPersonaLega    ge_person.person_id%TYPE := pkg_bopersonal.fnugetpersonaid;
    nuLectura        NUMBER;
    nuCodigoAtrib    NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_CODIATRLECTSUSPAD');
																		
    sbNombreoAtrib   VARCHAR2(100) := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_NOMBATRLECTSUSPAD');
																			 
  
    --se consulta solicitudes abiertas
    CURSOR cusolicitudesabiertas(nucuproducto pr_product.product_id%TYPE) IS
      SELECT pv.package_id colsolicitud
        FROM mo_packages pv, mo_motive mv
	  
       WHERE pv.package_type_id IN
             (SELECT (regexp_substr(csbVAL_TRAMITES_NUEVOS_FLUJOS,
                                    csbPatronRegex,
                                    1,
                                    LEVEL)) AS vlrColumna
									
                FROM dual
              CONNECT BY regexp_substr(csbVAL_TRAMITES_NUEVOS_FLUJOS,
                                       csbPatronRegex,
                                       1,
                                       LEVEL) IS NOT NULL)
									
									 
			
         AND pv.package_type_id <>
             pkg_bcld_parameter.fnuobtienevalornumerico('LDC_TRAM_RECO_SIN_CERT')
													 
			
         AND pv.motive_status_id =
             pkg_bcld_parameter.fnuobtienevalornumerico('ESTADO_SOL_REGISTRADA')
         AND mv.product_id = nucuproducto
         AND pv.package_id = mv.package_id;
  
    --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
    CURSOR cuProducto(nuorden NUMBER) IS
      SELECT product_id,
             subscription_id,
             at.subscriber_id,
             ot.operating_unit_id,
             m.motive_status_id,
             at.package_id
        FROM or_order_activity at, or_order ot, mo_packages m
       WHERE ot.order_id = nuorden
         AND AT.package_id IS NOT NULL
         AND at.order_id = ot.order_id
         AND m.package_id = at.package_id
         AND rownum = 1;
  
    --Se consulta estado del producto
    CURSOR cuEstadoProducto IS
      SELECT product_status_id
        FROM PR_PRODUCT
       WHERE PRODUCT_ID = nuProductId;
  
    nuunidadoperativa NUMBER;
    nuEstadoSolitud   NUMBER;
    nuEstadoPro       NUMBER;
  
    nuPackageidPadre NUMBER;
  
    numarcaant ldc_marca_producto.suspension_type_id%TYPE;
    numarca    ldc_marca_producto.suspension_type_id%TYPE;
  
    osbErrorMessage VARCHAR2(4000);
    onuErrorCode    NUMBER;
    nuContrato      number := NULL;
    nuAddress_Id    number := NULL;
    sbcomentario    varchar2(4000);
    nuevaOrderId    number := null;
    nuValtaskCau    number;
  
    ---667
    sbcertificado      ldc_certificados_oia.certificado%TYPE;
    nucodatributo      ge_attributes.attribute_id%TYPE := pkg_bcld_parameter.fnuobtienevalornumerico('COD_DATO_ADICIONAL_VAL_CERTI');
																								   
    sbnombreatrib      ge_attributes.name_attribute%TYPE := pkg_bcld_parameter.fsbobtienevalorcadena('NOMBRE_ATRI_VAL_CERTI');
																								   
    sbSuspensionNoRepa varchar2(1);
    sbProceso          VARCHAR2(100) := csbMetodo ||
                                        TO_CHAR(SYSDATE, 'DDMMYYYYHH24MISS');
  
    nuOrderactivityid  number;
  
    --Se consulta marca de suspension
    CURSOR cuMarcaProd IS
      SELECT suspension_type_id
        FROM pr_prod_suspension
       WHERE active = 'Y'
         AND product_id = nuProductId;
    -- caso: 753
    cursor cuValtaskCau(tipo number, cau number) is
      SELECT 1
        FROM (SELECT (regexp_substr(csbCOD_VST_CERT_RP, '[^;]+', 1, LEVEL)) AS column_value
                FROM dual
              CONNECT BY regexp_substr(csbCOD_VST_CERT_RP, '[^;]+', 1, LEVEL) IS NOT NULL)
       where column_value = tipo || ',' || cau;
  
    CURSOR cuOrderActData(inuOrderId IN or_order.order_id%TYPE) IS
      SELECT order_activity_id, product_id
        FROM or_order_activity
       WHERE order_id = inuOrderId;
  
    CURSOR cuDefectosCriticos(inuProdId IN or_order_activity.product_id%TYPE) IS
      SELECT count(1)
        FROM ldc_certificados_oia c, ldc_defectos_oia d
       WHERE c.certificados_oia_id = d.certificados_oia_id
         AND id_producto = inuProdId
         AND status_certificado = 'A'
         and order_id = nuorden
         AND INSTR(',' ||
                   pkg_bcldc_pararepe.fsbobtienevalorcadena('LDC_DEFECTOS_NO_REPARABLES') || ',',
                   ',' || d.defect_id || ',') > 0;
  
    cursor cuPersonaLega(inuorden in or_order_person.order_id%type) is
      select person_id from or_order_person where order_id = inuorden;
  
    ---OSF-2863
  
    ---Variable para manejar lso tipos de trabajo para el PLUGIN 
    sbTIPTRAPERMITECREAROT10966 ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('TIPTRA_PERMITE_CREAR_OT_10966');
    ---Variable para manejar las marcas del porducto de trabajo para el PLUGIN 
    sbMARPROEXCLUIDACREAOT10966 ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('MARPRO_EXCLUIDA_CREA_OT_10966');
  
    ---Cursor para establecer la existencia del dato en un paremtro
    cursor cuExiste(nuValor number, sbParametro varchar2) is
      select count(1)
        from dual
       where nuValor in
             (SELECT to_number(regexp_substr(sbParametro, '[^,]+', 1, LEVEL)) AS column_value
                FROM dual
              CONNECT BY regexp_substr(sbParametro, '[^,]+', 1, LEVEL) IS NOT NULL);
  
    nuTipoTrabajoExiste   NUMBER;
    nuMarcaProductoExiste NUMBER;
    ----------------------
  
  BEGIN
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_estaproc.prinsertaestaproc(isbProceso   => sbProceso,
                                   inuTotalRegi => null);
    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuorden := pkg_bcordenes.fnuobtenerotinstancialegal;
  
    nucausalorder := pkg_bcordenes.fnuobtienecausal(nuorden);
  
    pkg_traza.trace('Numero de la Orden:' || nuorden,
                    pkg_traza.cnuNivelTrzDef);
  
    nuTaskTypeId := pkg_bcordenes.fnuobtienetipotrabajo(nuorden);
  
    -- obtenemos el producto y el paquete
    OPEN cuproducto(nuorden);
    FETCH cuProducto
      INTO nuproductid,
           nucontratoid,
           nucliente,
           nuunidadoperativa,
           nuEstadoSolitud,
           nuPackageidPadre;
    IF cuProducto%NOTFOUND THEN
      sbmensa := csbCadError ||
                 'El cursor cuProducto no arrojo datos con el # de orden' ||
                 to_char(nuorden);
      Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
    END IF;
    CLOSE cuproducto;
  
    pkg_traza.trace('Salio cursor cuProducto, nuProductId: ' ||
                    nuProductId || 'nuContratoId:' || 'nuTaskTypeId:' ||
                    nuTaskTypeId,
                    pkg_traza.cnuNivelTrzDef);
  
    open cuPersonaLega(nuorden);
    fetch cuPersonaLega
      into nuPersonaLega;
    if cuPersonaLega%NOTFOUND then
      nuPersonaLega := NULL;
    end if;
    close cuPersonaLega;
    if nuPersonaLega is null then
      sbmensa := 'Proceso termino con errores : No se encontro persona que legaliza';
      Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
    end if;
    -- se consulta estado del producto
    OPEN cuEstadoProducto;
    FETCH cuEstadoProducto
      INTO nuEstadoPro;
    CLOSE cuEstadoProducto;
    /******************
    **INICIO 200-2073**
    ******************/
  
    --Se consulta marca del producto
    OPEN cuMarcaProd;
    FETCH cuMarcaProd
      INTO numarcaant;
    CLOSE cuMarcaProd;
  
    numarca := ldc_fnugetnuevamarca(nuorden);
    SW      := 0;
    IF nuEstadoPro = 2 THEN
    
      --OSF-2863
      ---Cursor para establecer existencia del tipo de trabajo en el parametro 
      open cuExiste(nuTaskTypeId, sbTIPTRAPERMITECREAROT10966);
      fetch cuExiste
        into nuTipoTrabajoExiste;
      close cuExiste;
      ---Cursor para establecer existencia de la marca del producto en el parametro 
      open cuExiste(numarcaant, sbMARPROEXCLUIDACREAOT10966);
      fetch cuExiste
        into nuMarcaProductoExiste;
      close cuExiste;
      -------------------  
    
      IF nuTipoTrabajoExiste = 1 AND nuMarcaProductoExiste = 0 and
         numarcaant is not null THEN
        SW := 1;
      END IF;
      IF INSTR(pkg_bcld_parameter.fsbobtienevalorcadena('TITRCAUSL_REPADEFCRIT_SERVSUSP'),
               nuTaskTypeId || '|' || nucausalorder) > 0 THEN
        SW := 1;
      END IF;
      IF INSTR(pkg_bcld_parameter.fsbobtienevalorcadena('TITRCAUSL_VISCERTREPA_DFCSUSP'),
               nuTaskTypeId || '|' || nucausalorder) > 0 AND
         numarcaant = numarca THEN
        SW := 2;
        INSERT INTO LDC_PRODUCTOPARASUSP
          (PRODUCT_ID, ORDER_ID, PROCESO)
        VALUES
          (nuProductId, nuorden, 'CERT_REPA_DEF_CON_SUSPE');
      END IF;
    
      IF SW = 1 THEN
        nuevaOrderId    := null;
        sbcomentario    := 'Orden generada con exito ';
        nuAddress_Id    := pkg_bcproducto.fnuiddireccinstalacion(nuProductId);
        nuContrato      := nucontratoid;
        onuErrorCode    := NULL;
        osbErrorMessage := NULL;
        --CREAR ORDEN CON LA ACTIVIDAD DEL TRABAJO ADICIONAL
      
        api_createorder(inuItemsid          => pkg_bcld_parameter.fnuobtienevalornumerico('ACTIVITY_USUA_YA_SUSP_CM_RP'),
                        inuPackageid        => nuPackageidPadre, --Requerido para la actualización en or_order_activity
                        inuMotiveid         => null,
                        inuComponentid      => null,
                        inuInstanceid       => null,
                        inuAddressid        => nuAddress_Id,
                        inuElementid        => null,
                        inuSubscriberid     => null,
                        inuSubscriptionid   => nuContrato, --requerido para el registro en or_order_activity                       
                        inuProductid        => nuProductId, --requerido para el registro en or_order_activity
                        inuOperunitid       => null,
                        idtExecestimdate    => sysdate,
                        inuProcessid        => null,
                        isbComment          => sbcomentario,
                        iblProcessorder     => null,
                        inuRefvalue         => 0,
                        ionuOrderid         => nuevaOrderId,
                        ionuOrderactivityid => nuOrderactivityid,
                        onuErrorCode        => onuErrorCode,
                        osbErrorMessage     => osbErrorMessage);
      
        pkg_traza.trace('Orden:' || nuevaOrderId ||
                        '- ionuOrderactivityid:' || nuOrderactivityid,
                        pkg_traza.cnuNivelTrzDef);
	  
        IF onuErrorCode = 0 THEN
          ---- ASIGNAR LA ORDEN A LA UNIDAD OPERATIVA
          api_assign_order(inuOrder         => nuevaOrderId,
                           inuOperatingUnit => nuunidadoperativa,
                           onuErrorCode     => onuerrorcode,
                           osbErrorMessage  => osberrormessage);
        
          IF onuErrorCode = 0 THEN
            --CASO 200-2390
            --Relacionar OT Padre con OT Hija
            INSERT INTO or_related_order
              (ORDER_ID, RELATED_ORDER_ID, RELA_ORDER_TYPE_ID)
            VALUES
              (nuorden, nuevaOrderId, 13);
            -------------------------------
		  
            INSERT INTO LDC_PRODUCTOPARASUSP
              (PRODUCT_ID, ORDER_ID, PROCESO, RESPONSABLE_ID)
            VALUES
			
              (nuProductId,
               nuevaOrderId,
               'USER_YA_SUSPE',
               pkg_bcordenes.fnuobtenerpersona(nuorden));
          ELSE
            sbmensa := csbCadError || osberrormessage || ' ';
            Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE,
                                      sbmensa);
		  
          END IF;
        
        ELSE
          sbmensa := csbCadError || osberrormessage || ' ';
          Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
        END IF;
	  
      END IF;
    END IF;
    /*****************
    **FINAL 200-2073**
    *****************/
    IF SW = 0 THEN
      IF nuEstadoPro <> 1 THEN
	  
        UPDATE pr_product
           SET product_status_id = 1
         WHERE product_id = nuproductid;
      END IF;
    
      IF nuEstadoSolitud = 13 THEN
        -- Actualizamos las solicitud que se esta legalizando para que no salga como pendiente
        UPDATE mo_packages m
           SET m.motive_status_id = 14
         WHERE m.package_id = nuPackageidPadre;
      
      END IF;
      -- Buscamos solicitudes de revisión periodica generadas
      sbsolicitudes := NULL;
      FOR i IN cusolicitudesabiertas(nuproductid) LOOP
        IF sbsolicitudes IS NULL THEN
          sbsolicitudes := i.colsolicitud;
        ELSE
          sbsolicitudes := sbsolicitudes || ',' || to_char(i.colsolicitud);
        END IF;
      END LOOP;
    
      IF sbsolicitudes IS NULL THEN
      
        -- Construimos XML para generar el tramite
        nupackageid    := NULL;
        numotiveid     := NULL;
        nuerrorcode    := NULL;
        sberrormessage := NULL;
        nuLectura      := ldc_boordenes.fsbDatoAdicTmpOrden(nuorden,
                                                            nuCodigoAtrib,
                                                            TRIM(sbNombreoAtrib));
	  
        if nuLectura is null then
          sbmensa := csbCadError || 'No se ha digitado Lectura';
          Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
        end if;
        sbcomment := '[GENERACION PLUGIN]| LEGALIZACION ORDEN[' || nuorden ||
                     ']|LECTURA[' || nuLectura || ']|PERSONA[' ||
                     nuPersonaLega || ']| ' ||
                     pkg_bcld_parameter.fsbobtienevalorcadena('COMENTARIO_SUSP_ADM_PRP') ||
                     ' CON CAUSAL : ' || to_char(nucausalorder);
      
        numediorecepcion := pkg_bcld_parameter.fnuobtienevalornumerico('MEDIO_RECEPCION_SUSPADM_PRP');
        nutiposusp       := LDC_FNUGETNUEVAMARCA(nuorden);
        if nutiposusp = -1 then
          nutiposusp := ldci_pkrevisionperiodicaweb.fnutiposuspension(nuproductid);
        end if;
        IF numediorecepcion IS NULL THEN
          sbmensa := 'No existe datos para el parametro MEDIO_RECEPCION_SUSPADM_PRP, definalos por el comando LDPAR';
          Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
        END IF;
        -- Inicio Caso:753
        OPEN cuValtaskCau(nuTaskTypeId, nucausalorder);
        FETCH cuValtaskCau
          INTO nuValtaskCau;
	  
        CLOSE cuValtaskCau;
        --Fin caso:753
      
        sbcertificado := ldc_boordenes.fsbDatoAdicTmpOrden(nuorden,
                                                           nucodatributo,
                                                           TRIM(sbnombreatrib));
      
        IF LDC_BODefectNoRepara.fsbValidateDefectsNoRepair(nuproductid,
                                                           nuorden,
                                                           sbcertificado) = 'S' THEN
		
          sbSuspensionNoRepa := 'S';
        else
          sbSuspensionNoRepa := 'N';
        End if;
      
        IF nuValtaskCau = 1 and sbSuspensionNoRepa = 'S' THEN
        
          nutipoCausal := pkg_bcldc_pararepe.fnuobtienevalornumerico('LDC_TIPO_CAUSAL_DEF_NO_REPARA');
															  
          nuCausal     := pkg_bcldc_pararepe.fnuobtienevalornumerico('LDC_CAUSAL_DEF_NO_REPARA');
															  
        
        ELSIF nuValtaskCau = 1 and sbSuspensionNoRepa = 'N' THEN
          -- CA753
        
          nutipoCausal := pkg_bcldc_pararepe.fnuobtienevalornumerico('TIPO_CAUSAL_SUSP_DEFEC_AUTO');
															  
          nuCausal     := pkg_bcldc_pararepe.fnuobtienevalornumerico('COD_CAUSA_SUSP_DEFEC_AUTO');
															  
        
        ELSE
        
          nutipoCausal := pkg_bcld_parameter.fnuobtienevalornumerico('TIPO_DE_CAUSAL_SUSP_ADMI');
																   
          nuCausal     := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CAUSA_SUSP_ADM_XML');
																   
        
        END IF;
        -- Fin CA667
      
        IF nutipoCausal IS NULL THEN
          sbmensa := 'No existe datos para el parametro TIPO_DE_CAUSAL_SUSP_ADMI, definalos por el comando LDPAR';
          Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
        END IF;
      
        IF nuCausal IS NULL THEN
          sbmensa := 'No existe datos para el parametro COD_CAUSA_SUSP_ADM_XML, definalos por el comando LDPAR';
          Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
        END IF;
      
        dtfechasusp := SYSDATE + 1 / 24 / 60;
        --P_LBC_SUSPENSION_ADMINISTRATIVA_POR_XML_100156 
        sbrequestxml1 := pkg_xml_soli_rev_periodica.getSuspensionAdministrativa(inuMedioRecepcionId => numediorecepcion,
                                                                                inuContactoId       => nucliente,
                                                                                inuDireccionId      => nudireccion,
                                                                                isbComentario       => sbComment,
                                                                                inuProducto         => nuproductid,
                                                                                idtFechaSuspension  => dtfechasusp,
                                                                                inuTipoSuspension   => nutiposusp,
                                                                                inuTipoCausal       => nutipoCausal,
                                                                                inuCausal           => nuCausal);
      
        -- Se crea la solicitud y la orden de trabajo
        pkg_traza.trace('XML:' || sbrequestxml1, pkg_traza.cnuNivelTrzDef);
        api_registerrequestbyxml(sbrequestxml1,
                                 nupackageid,
                                 numotiveid,
                                 nuerrorcode,
                                 sberrormessage);
        pkg_traza.trace('nupackageid:' || nupackageid,
                        pkg_traza.cnuNivelTrzDef);
	  
        pkg_traza.trace('numotiveid:' || numotiveid,
                        pkg_traza.cnuNivelTrzDef);
	  
        pkg_traza.trace('nuerrorcode:' || nuerrorcode || '-' ||
                        sberrormessage,
                        pkg_traza.cnuNivelTrzDef);
        IF nupackageid IS NULL THEN
		
          sbmensa := csbCadError ||
                     'Error al generar la solicitud de suspension administrativa prp. Codigo error : ' ||
                     to_char(nuerrorcode) || ' Mensaje de error : ' ||
                     sberrormessage;
		
          Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
        ELSE
          numarcaantes := ldc_fncretornamarcaprod(nuproductid);
          insert into LDC_BLOQ_LEGA_SOLICITUD
            (PACKAGE_ID_ORIG, PACKAGE_ID_GENE)
          values
            (nuPackageidPadre, nupackageid);
		
          ldcproccrearegistrotramtab(ldc_seq_tramites_revper.nextval,
                                     nuproductid,
                                     nupackageid,
                                     numarcaantes,
                                     numarcaantes,
                                     SYSDATE,
                                     'Se atiende la solicitud nro : ' ||
                                     to_char(nupakageid));
		
          sbmensa := 'Proceso termino Ok. Se genero la solicitud Nro : ' ||
                     to_char(nupackageid);
		
          IF nuEstadoSolitud = 13 THEN
            -- Actualizamos las solicitud que se esta legalizando para que no salga como pendiente
            UPDATE mo_packages m
               SET m.motive_status_id = 13
             WHERE m.package_id = nuPackageidPadre;
          
          END IF;
        
          IF nuEstadoPro <> 1 THEN
		  
            UPDATE pr_product
               SET product_status_id = nuEstadoPro
             WHERE product_id = nuproductid;
          END IF;
        
          pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                           isbEstado      => 'Ok',
                                           isbObservacion => sbmensa);
        
        END IF;
      ELSE
	  
        sbmensa := 'Error al generar la solicitud para el producto : ' ||
                   to_char(nuproductid) ||
                   ' Tiene las siguientes solicitudes de revisión periodica en estado registradas : ' ||
                   TRIM(sbsolicitudes);
	  
        Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
      END IF;
    
    END IF;
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN PKG_ERROR.controlled_error THEN
    
      Pkg_Error.seterror;
      pkg_error.getError(nuCodError, sbMensErro);
      pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                       isbEstado      => 'Error',
                                       isbObservacion => sbMensErro);
      pkg_traza.trace(csbPrinErrExc || nuCodError || '-' || sbMensErro,
                      pkg_traza.cnuNivelTrzDef);
	
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
	
      RAISE PKG_ERROR.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
      pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                       isbEstado      => 'Error',
                                       isbObservacion => sbmensa);
      Pkg_Error.seterror;
      pkg_error.getError(nuCodError, sbMensErro);
      pkg_traza.trace(csbPrinErrExc || nuCodError || '-' || sbMensErro,
                      pkg_traza.cnuNivelTrzDef);
	
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
	
      RAISE PKG_ERROR.controlled_error;
  END LDC_PROCREASOLISUSPADMI;

  FUNCTION FUNGENTRAMITESUSPE(nuProdcut_ID PR_PRODUCT.PRODUCT_ID%type,
                              nuMarca      LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID%TYPE,
                              nuorden      IN or_order.order_id%type,
                              nuSolicitud  IN mo_packages.package_id%type,
                              sbmensa      OUT VARCHAR2) RETURN NUMBER IS
  
    /**************************************************************************
      Propiedad Intelectual de HORBATH
    
      Funcion     : FUNGENTRAMITESUSPE
      Descripcion : Procedimiento que crea el tramite de suspension x acometida por medio de XML.
    
      Historia de Modificaciones
        Fecha               Autor                Modificacion
      =========           =========          ====================
      18/09/2018          JOSH BRITO          CASO 200-2073
    18/07/2023      jerazoer      Caso OSF-1260: Se ajusta el manejo de errores por el pkg_Error.
    **************************************************************************/
  
    csbMetodo                     CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                                            'FUNGENTRAMITESUSPE'; --Nombre del método en la traza
    csbVAL_TRAMITES_NUEVOS_FLUJOS CONSTANT ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('VAL_TRAMITES_NUEVOS_FLUJOS');
																												   
    numediorecepcion mo_packages.reception_type_id%TYPE;
    nudireccion      ab_address.address_id%TYPE;
    sbComment        VARCHAR2(2000);
    nuPackageId      mo_packages.package_id%type;
    nuMotiveId       mo_motive.motive_id%type;
    nutipoCausal     NUMBER;
    nuCausal         NUMBER;
    sbrequestxml1    constants_per.TIPO_XML_SOL%type;
    dtfechasusp      DATE := SYSDATE;
    nuErrorCode      NUMBER;
    sbErrorMessage   VARCHAR2(4000);
    nucontratoid     or_order_activity.subscription_id%type;
    nucliente        or_order_activity.subscriber_id%type;
    nuEstadoSolitud  mo_packages.motive_status_id%type;
    nuPackageidPadre mo_packages.package_id%type;
    nuCodigoAtrib    NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_CODIATRLECTSUSPAD');
																		
    sbsolicitudes    VARCHAR2(1000);
    nuPersonaLega    ge_person.person_id%TYPE := pkg_bopersonal.fnugetpersonaid;
    nucausalorder    ge_causal.causal_id%type;
    nuLectura        NUMBER;
  
    --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
    CURSOR cuProducto(nuPRODUCTO NUMBER) IS
      SELECT at.subscription_id,
             at.subscriber_id,
             m.motive_status_id,
             at.package_id
        FROM or_order_activity at, mo_packages m
       WHERE at.product_id = nuPRODUCTO
         AND AT.package_id IS NOT NULL
         AND at.package_id = nuSolicitud
         AND m.package_id = at.package_id
         AND rownum = 1;
  
    --se consulta solicitudes abiertas
    CURSOR cusolicitudesabiertas(nucuproducto pr_product.product_id%TYPE) IS
      SELECT pv.package_id colsolicitud
        FROM mo_packages pv, mo_motive mv
       WHERE pv.package_type_id IN
             (SELECT (regexp_substr(csbVAL_TRAMITES_NUEVOS_FLUJOS,
                                    csbPatronRegex,
                                    1,
                                    LEVEL)) AS vlrColumna
									
                FROM dual
              CONNECT BY regexp_substr(csbVAL_TRAMITES_NUEVOS_FLUJOS,
                                       csbPatronRegex,
                                       1,
                                       LEVEL) IS NOT NULL)
									
									 
			
         AND pv.package_type_id <>
             pkg_bcld_parameter.fnuobtienevalornumerico('LDC_TRAM_RECO_SIN_CERT')
													 
			
         AND pv.motive_status_id =
             pkg_bcld_parameter.fnuobtienevalornumerico('ESTADO_SOL_REGISTRADA')
         AND mv.product_id = nucuproducto
         AND pv.package_id = mv.package_id;
  
    CURSOR cuLecturaOrdePadre(nuParametro NUMBER) IS
      SELECT decode(s.capture_order,
                    1,
                    value_1,
                    2,
                    value_2,
                    3,
                    value_3,
                    4,
                    value_4,
                    5,
                    value_5,
                    6,
                    value_6,
                    7,
                    value_7,
                    8,
                    value_8,
                    9,
                    value_9,
                    10,
                    value_10,
                    11,
                    value_11,
                    12,
                    value_12,
                    13,
                    value_13,
                    14,
                    value_14,
                    15,
                    value_15,
                    16,
                    value_16,
                    17,
                    value_17,
                    18,
                    value_18,
                    19,
                    value_19,
                    20,
                    value_20,
                    'NA') lectura
	  
        FROM or_tasktype_add_data d,
             ge_attrib_set_attrib s,
             ge_attributes        A,
             or_requ_data_value   r,
             or_order             o
       WHERE d.task_type_id = o.task_type_id
         AND d.attribute_set_id = s.attribute_set_id
         AND s.attribute_id = a.attribute_id
         AND r.attribute_set_id = d.attribute_set_id
         AND r.order_id = o.order_id
         AND o.order_id = nuOrden
         AND d.active = 'Y'
         AND A.attribute_id = nuParametro;
  
    CURSOR cuPersonaLega IS
      select PERSON_ID from or_order_person where order_id = nuOrden;
  BEGIN
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    -- obtenemos el producto y el paquete
    OPEN cuproducto(nuProdcut_ID);
  
    FETCH cuProducto
      INTO nucontratoid, nucliente, nuEstadoSolitud, nuPackageidPadre;
    IF cuProducto%NOTFOUND THEN
      sbmensa := 'Proceso termino con errores Producto[' || nuProdcut_ID ||
                 ']. ';
	
      Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
    END IF;
    CLOSE cuproducto;
  
    IF nuEstadoSolitud = 13 THEN
      -- Actualizamos las solicitud que se esta legalizando para que no salga como pendiente
      UPDATE mo_packages m
         SET m.motive_status_id = 14
       WHERE m.package_id = nuPackageidPadre;
    
    END IF;
  
    -- Buscamos solicitudes de revisión periodica generadas
    sbsolicitudes := NULL;
    FOR i IN cusolicitudesabiertas(nuProdcut_ID) LOOP
      IF sbsolicitudes IS NULL THEN
        sbsolicitudes := i.colsolicitud;
      ELSE
        sbsolicitudes := sbsolicitudes || ',' || to_char(i.colsolicitud);
      END IF;
    END LOOP;
  
    IF sbsolicitudes IS NULL THEN
    
      -- Construimos XML para generar el tramite
      nupackageid    := NULL;
      numotiveid     := NULL;
      nuerrorcode    := NULL;
      sberrormessage := NULL;
    
      OPEN cuLecturaOrdePadre(nuCodigoAtrib);
      FETCH cuLecturaOrdePadre
        INTO nuLectura;
	
      IF cuLecturaOrdePadre%NOTFOUND THEN
        nuLectura := null;
      END IF;
      CLOSE cuLecturaOrdePadre;
    
      if nuLectura is null then
        sbmensa := csbCadError || 'No se ha digitado Lectura';
        Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
      end if;
    
      nucausalorder := pkg_bcordenes.fnuobtienecausal(nuorden);
    
      open cuPersonaLega;
      fetch cuPersonaLega
        into nuPersonaLega;
	
      close cuPersonaLega;
    
      sbcomment := '[GENERACION PLUGIN]| LEGALIZACION ORDEN[' || nuorden ||
                   ']|LECTURA[' || nuLectura || ']|PERSONA[' ||
                   nuPersonaLega || ']| ' ||
                   pkg_bcld_parameter.fsbobtienevalorcadena('COMENTARIO_SUSP_ADM_PRP') ||
                   ' CON CAUSAL : ' || to_char(nucausalorder);
    
      numediorecepcion := pkg_bcld_parameter.fnuobtienevalornumerico('MEDIO_RECEPCION_SUSPADM_PRP');
    
      IF numediorecepcion IS NULL THEN
        sbmensa := 'No existe datos para el parametro MEDIO_RECEPCION_SUSPADM_PRP, definalos por el comando LDPAR';
        Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
      END IF;
      nutipoCausal := pkg_bcld_parameter.fnuobtienevalornumerico('TIPO_DE_CAUSAL_SUSP_ADMI');
															   
      IF nutipoCausal IS NULL THEN
        sbmensa := 'No existe datos para el parametro TIPO_DE_CAUSAL_SUSP_ADMI, definalos por el comando LDPAR';
        Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
      END IF;
      nuCausal := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CAUSA_SUSP_ADM_XML');
														   
      IF nuCausal IS NULL THEN
        sbmensa := 'No existe datos para el parametro COD_CAUSA_SUSP_ADM_XML, definalos por el comando LDPAR';
        Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
      END IF;
      dtfechasusp := SYSDATE + 1 / 24 / 60;
      --P_LBC_SUSPENSION_ADMINISTRATIVA_POR_XML_100156                 
      sbrequestxml1 := pkg_xml_soli_rev_periodica.getSuspensionAdministrativa(inuMedioRecepcionId => numediorecepcion,
                                                                              inuContactoId       => nucliente,
                                                                              inuDireccionId      => nudireccion,
                                                                              isbComentario       => sbComment,
                                                                              inuProducto         => nuProdcut_ID,
                                                                              idtFechaSuspension  => dtfechasusp,
                                                                              inuTipoSuspension   => nuMarca,
                                                                              inuTipoCausal       => nutipoCausal,
                                                                              inuCausal           => nuCausal);
      pkg_traza.trace('XML:' || sbrequestxml1, pkg_traza.cnuNivelTrzDef);
      -- Se crea la solicitud y la orden de trabajo
      api_registerrequestbyxml(sbrequestxml1,
							   
                               nupackageid,
                               numotiveid,
                               nuerrorcode,
                               sberrormessage);
    
      pkg_traza.trace('nupackageid:' || nupackageid,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('numotiveid:' || numotiveid,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('nuerrorcode:' || nuerrorcode,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('sberrormessage:' || sberrormessage,
                      pkg_traza.cnuNivelTrzDef);
    
      IF nupackageid IS NULL THEN
        sbmensa := csbCadError ||
                   'Error al generar la solicitud de suspension administrativa prp. Codigo error : ' ||
                   to_char(nuerrorcode) || ' Mensaje de error : ' ||
                   sberrormessage;
        Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
      ELSE
        ldcproccrearegistrotramtab(ldc_seq_tramites_revper.nextval,
                                   nuProdcut_ID,
                                   nupackageid,
                                   nuMarca,
                                   nuMarca,
                                   SYSDATE,
                                   'Se atiende la solicitud nro : ' ||
                                   to_char(nupackageid));
	  
        sbmensa := 'Proceso termino Ok. Se genero la solicitud Nro : ' ||
                   to_char(nupackageid);
	  
        IF nuEstadoSolitud = 13 THEN
          -- Actualizamos las solicitud que se esta legalizando para que no salga como pendiente
          UPDATE mo_packages m
             SET m.motive_status_id = 13
           WHERE m.package_id = nuPackageidPadre;
        
        END IF;
        RETURN 0;
      
      END IF;
    ELSE
      sbmensa := 'Error al generar la solicitud para el producto : ' ||
                 to_char(nuProdcut_ID) ||
                 ' Tiene las siguientes solicitudes de revisión periodica en estado registradas : ' ||
                 TRIM(sbsolicitudes);
      Pkg_Error.SetErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, sbmensa);
    END IF;
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN PKG_ERROR.controlled_error THEN
      Pkg_Error.geterror(nuErrorCode, sbmensa);
      pkg_traza.trace(csbPrinErrExc || nuErrorCode || '-' || sbmensa,
                      pkg_traza.cnuNivelTrzDef);
	
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
	
      RETURN 1;
    WHEN OTHERS THEN
      sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
      Pkg_Error.seterror;
      Pkg_Error.geterror(nuErrorCode, sbmensa);
      pkg_traza.trace(csbPrinErrExc || nuErrorCode || '-' || sbmensa,
                      pkg_traza.cnuNivelTrzDef);
	
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
	
      RETURN 1;
  END FUNGENTRAMITESUSPE;

END LDC_PKGREPEGELERECOYSUSP;
/

PROMPT Asignación de permisos para el paquete LDC_PKGREPEGELERECOYSUSP
begin
  pkg_utilidades.prAplicarPermisos('LDC_PKGREPEGELERECOYSUSP', 'OPEN');
end;
/
