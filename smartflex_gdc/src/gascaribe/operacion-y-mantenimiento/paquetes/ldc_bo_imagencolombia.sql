CREATE OR REPLACE PACKAGE "LDC_BO_IMAGENCOLOMBIA" AS

    /**************************************************************************
    Propiedad intelectual de Gases de Occidente.

    Nombre del Paquete: LCD_IMAGEN_COLOMBIA
    Descripcion : PACKAGE para manejo de Imagen Colombia.

    Autor       : Maria J. Mesa.
    Fecha       : 21 febrero de 2013

    Historia de Modificaciones
      Fecha             Autor                Modificacion
    =========         =========          ====================
	20-11-2015         Sandra Mu?oz     SAO357722 - Se modifica procedimiento
	                                    SetImagenColombia, se crea la funcion
										fsbAplicaEntrega
    21-02-2013         MMesa            Creacion.
    07-01-2015         ggamarra         SetImagenColombia
    13-02-2015         ivandc           SetImagenColombia
    25-02-2015         slemus           SetImagenColombia
    16-03-2015         Mmejia           Modificacion <<valFechaLlegada>>
                                        <<valFechaControl>> <<valFechaNormaliza>>
                                        <<valFechaFinLabores>> ARA.134698
    07-04-2015         sagomez          UpdImagenColombia  ARA 6665
    19-04-2015         haltamiranda     ARA-7973 Modificacion del procedure SetImagenColombia, se reemplaza el llamado al metodo PR_BOTIMESCHEDULER.REGISTER
                                        de 8 parametros por el 3 parametros.
    30-06-2015         Sandra Mu?oz     ARA8039. Se desactiva la traza en IniNumeroServicio
   **************************************************************************/

    -- Obtiene la Version actual del Paquete
    FUNCTION FSBVERSION RETURN VARCHAR2;


    --------------------------------------------------------------------------
    --Tabla PL para el manejo
    --------------------------------------------------------------------------



    -------------------------------------------------------------------------
    -- Metodos publicos del PACKAGE
    --------------------------------------------------------------------------

    /*Inicializa los campos en El PB dado el identificador de la Orden*/
    PROCEDURE IniNumeroServicio
    (
     inuOrderId  OR_order.order_id%type
    );

    /*Retorna el Listado de Elementos*/
    PROCEDURE ObtListElemento
    (
      inuElemento         IN      ldc_imcoelem.icelcodi%type,
      isbDescription      IN      ldc_imcoelem.iceldesc%type,
      rfQuery             OUT     Constants.tyRefCursor
    ) ;

    /*Retorna el Listado de SubElementos*/
    PROCEDURE ObtListSubElmento
    (
      inuSubElemento      IN      ldc_imcosuel.icsecodi%type,
      isbDescription      IN      ldc_imcosuel.icsedesc%type,
      rfQuery             OUT     Constants.tyRefCursor
    );

    /*Retorna el Listado de Marcas */
    PROCEDURE ObtListMarca
    (
      inuMarca            IN      ldc_imcomael.icmecodi%type,
      isbDescription      IN      ldc_imcomael.icmedesc%type,
      rfQuery             OUT     Constants.tyRefCursor
    );

   /*Almacena en Base de Datos la informacion proporcianada en el Formulario PB*/
   PROCEDURE SetImagenColombia ;

   /*Valida que la fecha de Llegada sea mayor a la fecha de Reporte*/
   PROCEDURE  valFechaLlegada
   (
    idtFechaInsta      in       date
   );

   /*Valida que la fecha de Llegada sea mayor a la fecha de Control*/
   PROCEDURE  valFechaControl
   (
    idtFechaInsta        in        date
   );

   /*Valida que la fecha de Llegada sea mayor a la fecha de Normaliza*/
   PROCEDURE  valFechaNormaliza
   (
    idtFechaInsta        in        date
   );

   /*Valida que la fecha de Llegada sea mayor a la fecha de Fin de Labores*/
   PROCEDURE  valFechaFinLabores
   (
    idtFechaInsta        in        date
   );

   /*Inicializa la forma OCRT */
   PROCEDURE IniDatosOCRT
   (
     inuOrderId  OR_order.order_id%type
   );

   /*Valida la forma de consulta OCRT */
   PROCEDURE SetValOCRT;

   /*Obtiene las causales de legalizacion dado el tipo de trabajo*/
   PROCEDURE ObtListCausales
    (
      inuCausal           IN       OR_task_type_causal.causal_id%type,
      isbDescription      IN       ge_causal.description%type,
      rfQuery             OUT      Constants.tyRefCursor
    ) ;
    /*Obtien la Lista de Personas responsables de la orden */
    PROCEDURE ObtListPersonId
    (
      inuPersonId           IN       or_oper_unit_persons.person_id%type,
      isbDescription      IN       ge_person.person_id%type,
      rfQuery             OUT      Constants.tyRefCursor
    );

    /*Actualiza Ordenes registradas en LDC_IMCORETE  */
    PROCEDURE UpdImagenColombia;

    /*Valida desde ORCAO cuando se ejecuta el objeto legalizador que ya este grabado el formato de imagen colombia en LDC_IMCORETE */
    PROCEDURE LDC_VALIDA_OT_IMAGEN_COLOMBIA;

    PROCEDURE obtContratistaBase( isbContratista      in VARCHAR2, ocuDataCursor out constants.tyRefCursor);

    PROCEDURE LDC_LlenarAtributosContratista(iosbContratistas  in out     Ge_BoUtilities.styStatement);

	PROCEDURE obtContratistas( inuContratista      in      ge_contratista.id_contratista%type,
                               isbNombre           in      ge_contratista.nombre_contratista%type,
							   ocuDataCursor       out constants.tyRefCursor);

    PROCEDURE obtOperatingUnit( isbOperatingUnit      in VARCHAR2, ocuDataCursor out constants.tyRefCursor);

    PROCEDURE LDC_FiOperatingUnitAttributes(sbAttributes  in out     Ge_BoUtilities.styStatement);
    PROCEDURE FillOrderAttributes(iosbAttributes in out Ge_BoUtilities.styStatement);

	PROCEDURE obtOperatingUnitS( inuOperatingUnit      in      or_operating_unit.OPERATING_UNIT_ID%type,
                                 isbNombre             in      or_operating_unit.name%type,
							     ocuDataCursor        out constants.tyRefCursor);

	PROCEDURE getFatherOperUnit( inuContractorId   in  number, ocuCursor  out constants.tyRefCursor);

    /*PROCEDURE GetOrderById(inuOperUnitId     in OR_order.operating_unit_id%type,
                           ocuDataCursor  out constants.tyRefCursor);*/

    PROCEDURE GetOrderById
    (
        inuOrderId     in OR_order.order_id%type,
        ocuDataCursor  out constants.tyRefCursor
    );

    PROCEDURE GetOrdersByOperatingUnitId
    (
        inuOperatingUnitId     in OR_order.operating_unit_id%type,
        ocuDataCursor  out constants.tyRefCursor
    );

    PROCEDURE GetOperatingUnitByOrderId
    (
        inuOrderId     in OR_order.order_id%type,
        onuOperatingUnitId  out OR_order.operating_unit_id%type
    );

    PROCEDURE GetContractorByOperaUnitId
    (
        inuOperatingUnitId     in or_operating_unit.operating_unit_id%type,
        onuContractorId  out or_operating_unit.contractor_id%type
    );


	    FUNCTION fsbAplicaEntrega(isbEntrega VARCHAR2) RETURN VARCHAR2 ;

 END LDC_BO_IMAGENCOLOMBIA;
/

CREATE OR REPLACE PACKAGE BODY "LDC_BO_IMAGENCOLOMBIA" AS
  /**************************************************************************
    Propiedad intelectual de Gases de Occidente.

    Nombre del Paquete: LCD_IMAGEN_COLOMBIA
    Descripcion : PACKAGE para manejo de Imagen Colombia.

    Autor       : Maria J. Mesa.
    Fecha       : 21 febrero de 2013

    Historia de Modificaciones
      Fecha             Autor                Modificacion
    =========         =========          ====================
    20-11-2015         Sandra Mu?oz     SAO357722 - Se modifica procedimiento
	                                    SetImagenColombia, se crea la funcion
										fsbAplicaEntrega
    07-04-2015         sagomez          UpdImagenColombia
    16-03-2015         Mmejia           Modificacion <<valFechaLlegada>>
                                        <<valFechaControl>> <<valFechaNormaliza>>
                                        <<valFechaFinLabores>> ARA.134698
    13-02-2015         ivandc           SetImagenColombia
    30-01-2015         ggamarra         SetImagenColombia
    07-01-2015         ggamarra         SetImagenColombia
    21-02-2013         MMesa            Creacion.

   **************************************************************************/


    --------------------------------------------
    -- Variables PRIVADAS DEL PAQUETE
    --------------------------------------------

    tbAttributes                cc_tytbAttribute;
    sbNitEmpresa           sistema.sistnitc%type;

    ---------------------------------------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    ---------------------------------------------------------------------------
    CSBVERSION                   CONSTANT        VARCHAR2(40)  := 'NC_3867_2';
    csbWORK_INSTANCE             CONSTANT        VARCHAR2(20)  := 'WORK_INSTANCE';
    csbSeqLDC_IMCORETE           CONSTANT        VARCHAR2(100) := 'SEQ_LDC_IMCORETE';
    cnuVarDefecto                CONSTANT        NUMBER        :=  -1; --
    cnuTaskTypeEmergen           CONSTANT        NUMBER        :=  203;  -- 203 - EMERGENCIAS
    cnuEstadoAsignado            CONSTANT        NUMBER        :=  5;
    cnuEstadoEjecutado           CONSTANT        NUMBER        :=  7;
    cnuEstadoLegaliza            CONSTANT        NUMBER        :=  8;

    --Constantes NIT de la Empresa
    csbNIT_GDO            CONSTANT        ld_parameter.value_chain%type := dald_parameter.fsbgetvalue_chain('NIT_GDO');
    csbNIT_GDC            CONSTANT        ld_parameter.value_chain%type := dald_parameter.fsbgetvalue_chain('NIT_GDC');
    csbNIT_EFG            CONSTANT        ld_parameter.value_chain%type := dald_parameter.fsbgetvalue_chain('NIT_EFIGAS');
    csbNIT_STG            CONSTANT        ld_parameter.value_chain%type := dald_parameter.fsbgetvalue_chain('NIT_SURTIGAS');

    -- Cursor para consultar el NIT de la Empresa
    CURSOR cuNitEmpresa
    IS
    SELECT sistnitc
    FROM sistema;


    /*
       Versionammiento del Pkg */
    FUNCTION FSBVERSION RETURN VARCHAR2 IS
    BEGIN
      return CSBVERSION;
    END FSBVERSION;

    /*
       Obtiene el Seguiente Valor de la Secuencia SEQ_LDC_IMCORETE*/
    FUNCTION fnunextLDC_IMCORETE
    RETURN NUMBER
    IS
      NUNEXT NUMBER;
      NUFOUND NUMBER;
    BEGIN
      LOOP
         NUNEXT := SEQ.GETNEXT( csbSeqLDC_IMCORETE );
         SELECT COUNT(1)
         INTO NUFOUND
         FROM LDC_IMCORETE
         WHERE ICRTCODI = NUNEXT;
         EXIT WHEN NUFOUND = 0;
      END LOOP;
      RETURN NUNEXT;
    END fnunextLDC_IMCORETE;


   /*
      Obtiene el Id de OR_order_Activity dada el Identificador de la Orden */
   FUNCTION getIdOrderActivity
   (
     inuOrderId       in      OR_order.order_id%type
   )
   return number
   is
     nuExistOrder         number := 0;
     nuIdOrderActivity    OR_order_activity.order_activity_id%type :=0;

     -- CURSOR
      CURSOR cuOrderActivity(inuOrderId in OR_order.order_id%type ) IS
        select ORDER_activity_id  FROM OR_order_activity
        where ORDER_id  = inuOrderId
        AND ORDER_activity_id IS not null;

   BEGIN
     for exac in cuOrderActivity(inuOrderId) loop
       nuExistOrder :=1;
       nuIdOrderActivity := exac.ORDER_activity_id;
     END loop;

     return  nuIdOrderActivity;

   END getIdOrderActivity;


  /*
     Obtiene el Id de ORDER_comment dada la orden */
  FUNCTION getIdOrderComment
   (
     inuOrderId       in      OR_order.order_id%type
   )
   return number
   is
     nuExistOrder         number := 0;
     nuIdOrderComment    OR_order_comment.order_comment_id%type := 0;

     -- CURSOR
      CURSOR cuOrderActivity(inuOrderId in OR_order.order_id%type ) IS
        select ORDER_comment_id FROM OR_order_comment
        where ORDER_id  = inuOrderId
        AND ORDER_comment_id IS not null;

   BEGIN
     for exac in cuOrderActivity(inuOrderId) loop
       nuExistOrder :=1;
       nuIdOrderComment := exac.order_comment_id;
     END loop;

     return  nuIdOrderComment;

   END getIdOrderComment;


   /*
      VALIDA que la orden sea de Emergencia */
   PROCEDURE valOrdenEmergencias
   (
     inuOrderId  OR_order.order_id%type
   )
    IS
       nuTaskType or_task_type.task_type_id%type;
       nuTaskClas or_task_type.task_type_classif%type;
       nuEstadOrd OR_order.order_status_id%type;
             --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);
    BEGIN
      ut_trace.trace('Inicia ldc_bo_imagencolombia.valOrdenEmergencias',9);

      nuTaskType := daor_order.fnugettask_type_id(inuOrderId);
      nuTaskClas := daor_task_type.fnugettask_type_classif(nuTaskType) ;
      nuEstadOrd := daor_order.fnugetorder_status_id(inuOrderId);


      IF cnuTaskTypeEmergen <> nuTaskClas THEN
        ge_boerrors.seterrorcodeargument(2741,'La Orden Ingresada ['||inuOrderId||'] no corresponde'
                                     ||' a una Orden de Emergencia, Por favor verifique.');

      END IF;

      IF nuEstadOrd not in (cnuEstadoAsignado, cnuEstadoEjecutado) THEN

        ge_boerrors.seterrorcodeargument(2741,'La orden ['||inuOrderId||'] no se puede legalizar.'
                       ||' No se encuentra un estado valido para ejecutar este proceso');
      END IF;


      ut_trace.trace('Finaliza ldc_bo_imagencolombia.valOrdenEmergencias',9);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
	    pkErrors.pop;
	    raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END valOrdenEmergencias ;

    FUNCTION getDirecciPackage
    (
      inupackageId   mo_packages.package_id%type
    ) return number
    IS

      nuIdAddress                        ab_address.address_id%type;
         --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);

       CURSOR cuMo_Address (inupackageId in number) IS
        SELECT address_id FROM mo_Address
        WHERE PACKAGE_id = inuPackageId
        AND rownum = 1;

    BEGIN
      ut_trace.trace ('Inicia LDC_BO_imagencolombia.getDirecciPackage',8);

      for i in cuMo_Address(inupackageId) loop
        nuIdAddress := i.address_id;
        ut_trace.trace ('Id de la direccion  ['||i.address_id||']',8) ;
      end loop;

      return nuIdAddress;

      ut_trace.trace ('Finaliza LDC_BO_imagencolombia.fnugetItemSeriadOrden',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when NO_DATA_FOUND then
	    pkErrors.pop;
       return '-';
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
	    raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END getDirecciPackage;

    /*Obtiene el Medidor asociado al producto*/
    FUNCTION fnugetSerie
    (
     inuProductId       in     pr_product.product_id%type
    )return varchar2
    IS
     -- CURSOR  que obtiene el medidor asociado a el producto
      CURSOR cuObtMedidor (inuProductId  in  pr_product.product_id%type) is
        SELECT emsscoem FROM elmesesu
        WHERE emsssesu = inuProductId
        --WHERE emsssspr = inuProductId
        AND trunc(sysdate) between emssfein AND emssfere
        AND rownum = 1 ;

      sbMedidor                           elmesesu.emsscoem%type:= '-1';
      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      sbErrorMessage                      varchar2(2000);
      nuErrorCode                         number;

    begin
      ut_trace.trace('Inicia fnugetSerie',9);

      for m in cuObtMedidor(inuProductId) loop
        sbMedidor := m.emsscoem;
        ut_trace.trace ('Elemento de Medicion ['||m.emsscoem||']',8) ;
      end loop;

      return  sbMedidor;

      ut_trace.trace('Finaliza fnugetSerie',9);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when NO_DATA_FOUND then
	    pkErrors.pop;
       return '-1';
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
	    raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetSerie;

    /*
      Iniciliza numero de servicio dado la orden.  */

    PROCEDURE IniNumeroServicio
    (
     inuOrderId  OR_order.order_id%type
    )
    IS
      sbInstance                    Ge_BOInstanceControl.stysbName;
      sbSerialNumb                  Ge_BOInstanceControl.stysbValue := NULL;
      nuNumServic                   pr_product.product_id%type;
      nuPackageId                   mo_packages.package_id%type;
      nuDireccion                   ab_address.address_id%type;
      dtFechOrden                   OR_order.created_date%type;
      nuSectorGeo                   OR_order.operating_sector_id%type;
      nuCasoRepor                   OR_order.task_type_id%type;
      nuTrabReali                   OR_order.real_task_type_id%type;
      sbObservaci                   OR_order_comment.order_comment%type;
      nuCuadrilla                   OR_order.operating_unit_id%type;
      dtFechRepor                   OR_order.created_date%type;
      dtFechLlega                   OR_order.exec_initial_date%type;
      dtFechFinal                   OR_order.execution_final_date%type;
      sbMedidor                     elemmedi.elmecodi%type;
      nuElemedi                     elmesesu.emsselme%type;
      nuOrderActivityId             or_order_activity.order_activity_id%type;
      nuOrderCommentId              OR_order_comment.order_comment_id%type;
      --  Variables para manejo de Errores
      exCallService                 EXCEPTION;
      sbCallService                 varchar2(2000);
      nuErrorCode                   number;
      sbErrorMessage                varchar2(2000);

    BEGIN
	  -- ARA8039. SMUNOZ. Se desactiva traza
      -- ut_trace.Init;
      --  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);

      UT_Trace.Trace('Inicia LCD_IMAGENCOLOMBIA.InitNumeroServicio',8);
      pkErrors.push ('LDC_BO_IMAGENCOLOMBIA.InitNumeroServicio');

      -- Obtiene la instancia actual
      Ge_BOInstanceControl.GetCurrentInstance(sbInstance);

      -- Obtiene ordder_activity asociada a la orden
      nuOrderActivityId := getIdOrderActivity (inuOrderId);
      -- Si tiene un valor
      IF (inuOrderID IS NOT NULL) THEN
        -- Valida que la orden sea de Emergencias
        valOrdenEmergencias(inuOrderID);

        -- Obtiene el numero de servicio -*- product_id

        nuNumServic := DAOR_order_activity.FNUGETPRODUCT_ID(nuOrderActivityId);
        -- Obtiene el numero de solicitud de la orden
        begin

          nuPackageId := DAOR_order_activity.FNUGETPACKAGE_ID(nuOrderActivityId);
          UT_Trace.Trace('nuPackageId' ||'['||nuPackageId||']',8);
          EXCEPTION
           when OTHERS then
               nuPackageId := null;
        END;

        -- Obtiene la direccion del producto
        begin

          if nuNumServic IS null then
            nuDireccion := getDirecciPackage(nuPackageId);
            UT_Trace.Trace('getDirecciPackage(nuPackageId)' ||'['||nuDireccion||']',8);
          else
            nuDireccion := DAPR_product.FNUGETADDRESS_ID(nuNumServic) ;
            UT_Trace.Trace('DAPR_product.FNUGETADDRESS_ID(nuNumServic)' ||'['||nuDireccion||']',8);
          END if;

          EXCEPTION
            when OTHERS then
               nuDireccion := null;
        END;

        -- Obtiene la decha de creacion de la orden
        dtFechOrden := DAOR_order.FDTGETCREATED_DATE(inuOrderId);
        -- Obtiene el sector
        nuSectorGeo := DAOR_order.FNUGETOPERATING_SECTOR_ID(inuOrderId);
        -- Obtiene el trabajo reportado
        nuCasoRepor := DAOR_order.FNUGETTASK_TYPE_ID(inuOrderId);
        UT_Trace.Trace('nuCasoRepor' ||'['||nuCasoRepor||']',8);
        -- Obtiene el trabajo real realizado
        nuTrabReali := DAOR_order.FNUGETREAL_TASK_TYPE_ID(inuOrderId);
        -- Obtiene la cuadrilla
        nuCuadrilla := DAOR_order.FNUGETOPERATING_UNIT_ID(inuOrderId);
        UT_Trace.Trace('nuCuadrilla' ||'['||nuCuadrilla||']',8);
        -- Obtiene la fecha de reporte


        begin
        -- Obtiene la observacion del orden
        nuOrderCommentId := getIdOrderComment(inuOrderId) ;
        sbObservaci := DAMO_packages.fsbgetcomment_(nuPackageId);
        EXCEPTION
           when OTHERS then
             sbObservaci := ' ' ;
        END;

        -- Obtiene el medidor dado el producto.
        begin
          sbMedidor := fnugetSerie(nuNumServic);
          EXCEPTION
           when OTHERS then
               sbMedidor := null;
        END;
        UT_Trace.Trace('sbMedidor' ||'['||sbMedidor||']',8);

        -- Inicializa PACKAGE_id
        if nuPackageId IS not null then
          ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTACTI',nuPackageId,ge_boconstants.gettrue);
        else
          ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTACTI',cnuVarDefecto,ge_boconstants.gettrue);
        END if;
        -- Inicializa numero de servicio.
        if  nuNumServic IS not null then
          ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTNUSE',nuNumServic,ge_boconstants.gettrue);
        ELSE
          ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTNUSE',cnuVarDefecto,ge_boconstants.gettrue);
        END if;
        -- Inicializa direccion
        if nuDireccion IS not null then
          ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTDIRE',nuDireccion,ge_boconstants.gettrue);
        else
          ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTDIRE',cnuVarDefecto,ge_boconstants.gettrue);
        END if;
        -- Inicializa la fecha de creacion de la orden
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTFECH',dtFechOrden,ge_boconstants.gettrue);
        -- Inicializa Sector
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTSECT',nuSectorGeo,ge_boconstants.gettrue);
        -- Inicializa caso reportado
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTCARE',nuCasoRepor,ge_boconstants.gettrue);
        -- Inicializa trabajo realizado
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTTITR',nuTrabReali,ge_boconstants.gettrue);
        -- Inicializa Cuadrilla
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTCUDR',nuCuadrilla,ge_boconstants.gettrue);
        -- Inicializa Observacion de la orden
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTOBSF',sbObservaci,ge_boconstants.gettrue);
        -- Inicializa la fecha de reporte
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTFERE',dtFechOrden,ge_boconstants.gettrue);


        -- Inicializa la fecha de llegada
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTLLEG',dtFechOrden,ge_boconstants.gettrue);
         -- Inicializa la fecha CONTROL
       ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTCTRL',dtFechOrden,ge_boconstants.gettrue);
       -- Inicializa la fecha NORMALIZA
       ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTNORM',dtFechOrden,ge_boconstants.gettrue);
				  -- Inicializa la fecha finalizacion
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTFILA',dtFechOrden,ge_boconstants.gettrue);

        -- Inicializa el Medidor
        if sbMedidor IS not null then
          ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTMEDI', sbMedidor,ge_boconstants.gettrue);
        ELSE
          ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTMEDI', cnuVarDefecto,ge_boconstants.gettrue);
        END if;


      END IF;

      UT_Trace.Trace('Finaliza LCD_IMAGENCOLOMBIA.InitNumeroServicio',8);


    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when NO_DATA_FOUND then
        GE_BOERRORS.SETERRORCODEARGUMENT(2691,
                           'La orden no tiene asociado un numero de servicio.');
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
	    pkErrors.pop;
	    raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END IniNumeroServicio;


   /*OBTIENE lista de Elementos dados la localizacion */

    PROCEDURE ObtListElemento
    (
      inuElemento         IN         ldc_imcoelem.icelcodi%type,
      isbDescription      IN         ldc_imcoelem.iceldesc%type,
      rfQuery             OUT        Constants.tyRefCursor
    )
    IS
      sbInstance                     Ge_BOInstanceControl.stysbName;
      sbLocaRed                      Ge_BOInstanceControl.stysbValue := NULL;
      sbSql                          VARCHAR2(2000);
      --  Variables para manejo de Errores
      exCallService                  EXCEPTION;
      sbCallService                  varchar2(2000);
      nuErrorCode                    number;
      sbErrorMessage                 varchar2(2000);

    BEGIN
      ut_trace.Init;

      UT_Trace.Trace('Inicia LCD_IMAGENCOLOMBIA.ObtListElemento',8);
      pkErrors.push ('LDC_BO_IMAGENCOLOMBIA.ObtListElemento');
      sbSql:=null;

      -- Obtiene la instancia actual
      Ge_BOInstanceControl.GetCurrentInstance(sbInstance);
      -- Captura el id del subscriptor al que le esta realizando la venta
      ge_boinstancecontrol.GetAttributeNewValue(sbInstance,null,'LDC_IMCORETE',
                                                         'ICRTLORE',sbLocaRed);

      UT_Trace.Trace('inuLocaRed' ||'['||sbLocaRed||']',8);

      if sbLocaRed IS null then
        ge_boerrors.seterrorcodeargument(2741,'Antes de Seleccionar un Elemento es'||
                          ' necesario que Seleccione una " Localizacion en la Red".');
      else

        UT_Trace.Trace('Inicia creacion lista ' ,7);
        -- Obtiene la observacion del orden
        sbSql:='SELECT e.ICELCODI ID,'||chr(10)||
                  'e.ICELDESC DESCRIPTION'||chr(10)||
                  'FROM LDC_IMCOELEM e , LDC_IMCOELLO l'||chr(10)||
                  'WHERE l.ICELELEM = e.ICELCODI'||chr(10)||
                  'AND l.ICELLOCA ='|| sbLocaRed ||chr(10)||
                  'ORDER BY ID asc';


        UT_Trace.Trace('sbsql ['||sbSql||']',7);
        UT_Trace.Trace('Finaliza creacion lista ' ,7);
      END if;
      OPEN rfQuery FOR sbSql;

      UT_Trace.Trace('Finaliza LCD_IMAGENCOLOMBIA.ObtListElemento',8);


   EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
	    pkErrors.pop;
	    raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END ObtListElemento;



    /*Obtiene Lista de subElementos dado el elemento */
     PROCEDURE ObtListSubElmento
    (
      inuSubElemento      IN       ldc_imcosuel.icsecodi%type,
      isbDescription      IN       ldc_imcosuel.icsedesc%type,
      rfQuery             OUT      Constants.tyRefCursor
    )
    IS
      sbInstance                   Ge_BOInstanceControl.stysbName;
      sbElemento                   Ge_BOInstanceControl.stysbValue := NULL;
      sbSql                        VARCHAR2(2000);
      --  Variables para manejo de Errores
      exCallService                EXCEPTION;
      sbCallService                varchar2(2000);
      nuErrorCode                  number;
      sbErrorMessage               varchar2(2000);

    BEGIN
      ut_trace.Init;

      UT_Trace.Trace('Inicia LCD_IMAGENCOLOMBIA.ObtListSubElmento',8);
      pkErrors.push ('LDC_BO_IMAGENCOLOMBIA.ObtListSubElmento');
      sbSql:=null;

      -- Obtiene la instancia actual
      Ge_BOInstanceControl.GetCurrentInstance(sbInstance);
      -- Captura el id del subscriptor al que le esta realizando la venta
      ge_boinstancecontrol.GetAttributeNewValue(sbInstance,null,'LDC_IMCORETE',
                                                         'ICRTELEM',sbElemento);
      UT_Trace.Trace('inuElemento' ||'['||sbElemento||']',8);

      if sbElemento IS null then
        ge_boerrors.seterrorcodeargument(2741,'Antes de Seleccionar un SubElemento es necesario que Seleccione un "Elemento".');
      else

        UT_Trace.Trace('Inicia creacion lista ' ,7);
        -- Obtiene la observacion del orden
        sbSql:='SELECT se.ICSECODI ID,'||chr(10)||
                  'se.ICSEDESC DESCRIPTION'||chr(10)||
                  'FROM LDC_IMCOSUEL se, LDC_IMCOSEEL  el'||chr(10)||
                  'WHERE se.ICSECODI = el.ICSESUEL'||chr(10)||
                  'AND el.ICSEELEM = '||''''||to_char(sbElemento)||''''||chr(10)||
                  'ORDER BY ID asc';

        UT_Trace.Trace('sbsql ['||sbSql||']',7);
        UT_Trace.Trace('Finaliza creacion lista ' ,7);
      END if;
      OPEN rfQuery FOR sbSql;

      UT_Trace.Trace('Finaliza LCD_IMAGENCOLOMBIA.ObtListSubElmento',8);


   EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
	    pkErrors.pop;
	    raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END ObtListSubElmento;

    /*OBTIENE lista de marcas dado el elmento*/

    PROCEDURE ObtListMarca
    (
      inuMarca            IN       ldc_imcomael.icmecodi%type,
      isbDescription      IN       ldc_imcomael.icmedesc%type,
      rfQuery             OUT      Constants.tyRefCursor
    )
    IS
      sbInstance                   Ge_BOInstanceControl.stysbName;
      sbElemento                   Ge_BOInstanceControl.stysbValue := NULL;
      sbSql                        VARCHAR2(2000);
      --  Variables para manejo de Errores
      exCallService                EXCEPTION;
      sbCallService                varchar2(2000);
      nuErrorCode                  number;
      sbErrorMessage               varchar2(2000);

    BEGIN
      ut_trace.Init;

      UT_Trace.Trace('Inicia LCD_IMAGENCOLOMBIA.ObtListMarca',8);
      -- Obtiene la instancia actual
      pkErrors.push ('LDC_BO_IMAGENCOLOMBIA.ObtListMarca');
      sbSql:=null;

      Ge_BOInstanceControl.GetCurrentInstance(sbInstance);
      -- Captura el id del subscriptor al que le esta realizando la venta
      ge_boinstancecontrol.GetAttributeNewValue(sbInstance,null,'LDC_IMCORETE',
                                                         'ICRTELEM',sbElemento);

      UT_Trace.Trace('sbMarca' ||'['||sbElemento||']',8);
      if sbElemento IS null then
        ge_boerrors.seterrorcodeargument(2741,'Antes de Seleccionar una Marca es'
                                        ||' necesario que Seleccione un "Elemento".');
      else
        UT_Trace.Trace('Inicia creacion lista ' ,7);
        -- Obtiene la observacion del orden
        sbSql:='SELECT ma.ICMECODI ID,'||chr(10)||
                  'ma.ICMEDESC DESCRIPTION'||chr(10)||
                  'FROM LDC_IMCOMAEL ma , LDC_IMCOELMA em'||chr(10)||
                  'WHERE ma.ICMECODI = em.ICEMMAEL'||chr(10)||
                  'AND em.ICEMELEM = '||''''||to_char(sbElemento)||''''||chr(10)||
                  'ORDER BY ID asc';

        UT_Trace.Trace('sbsql ['||sbSql||']',7);
        UT_Trace.Trace('Finaliza creacion lista ' ,7);

       END if;
      OPEN rfQuery FOR sbSql;

      UT_Trace.Trace('Finaliza LCD_IMAGENCOLOMBIA.ObtListMarca',8);


   EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
	    pkErrors.pop;
	    raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END ObtListMarca;



	/*****************************************************************
    Propiedad intelectual de Gases de occidente.

    Nombre del Paquete: sbAplicaEntrega
    Descripcion:        Indica si la entrega aplica para la gasera

    Autor : Sandra Mu?oz
    Fecha : 20-10-2015 Aranda 8687

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    02-09-2015    Sandra Mu?oz          Creacion
    ******************************************************************/
    FUNCTION fsbAplicaEntrega(isbEntrega VARCHAR2) RETURN VARCHAR2 IS
        blGDO      BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaGDO(isbEntrega);
        blEFIGAS   BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaEfigas(isbEntrega);
        blSURTIGAS BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaSurtigas(isbEntrega);
        blGDC      BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaGDC(isbEntrega);
    BEGIN
        IF blGDO = TRUE OR blEFIGAS = TRUE OR blSURTIGAS = TRUE OR blGDC = TRUE THEN
            RETURN  'S';
        END IF;
        RETURN 'N';

    END;


    /********************************************************************************
    Adiciona atributos en Instancia
       Historia de Modificaciones
      Fecha             Autor                Modificacion
    =========         =========          ====================
    25-02-2015         slemus           Se modifica el llamado al servicio PR_BOTIMESCHEDULER para la actualizacion
                                        de datos de la tabla pr_timeout_component, ya que se insertan datos que generan
                                        conflicto con datos que procesan los servicios de 
    13-02-2015         ivandc           Se modifica la validacion del api de legalizacion dado que se estaba haciendo
                                        sobre la variable incorrecta. Ademas se ajusta el orden del llamado del metodo
                                        PR_BOTIMESCHEDULER.REGISTER y PR_BOTIMESCHEDULER.UPDRECORD para que dependan
                                        del resultado de la legalizacion
    30-01-2015         ggamarra         Se adiciona validacion de si la causa aplica para registro de
                                        tiempo fuera de servicio.  NC 3867
    07-01-2015         ggamarra         Se modifica registro de tiempo fuera de servicio por metodo que registre con el
                                        componente y calcule el tiempo para que aparezca corrrectamente en la forma
                                        de aprobacion.  NC 3867
    02-10-2014          Alexandra G      Se modifica la forma de validar en el momento de legalizar la orden, si la orden
                                        existe registrada en LDC_IMCORETE por alguna ejecucion anterior, se actualiza la
                                        informacion, si la orden no existe se realiza el insert en dicha tabla.
                                        Se crea el procedimiento updDatosIMC privado para actualizar informacion de las
                                        tablas LDC_IMCORETE y IMCODIAM
                                        Se crea el procedimiento insDatosIMC privado para insertar informacion en las
                                        tablas LDC_IMCORETE y IMCODIAM
    15-08-2013         EMIROL           Se coloca validacion del atributo legaliza materiales
                                        si esta activo solo se guarda la informacion de imagen colombia
                                        y se levanta mensaje de advertencia informado que la orden se debe cerrar
                                        por el comando ORCAO ya que esta se legaliza con matiales.
                                        si el flag no esta activo guarda la informacion de imagen colombia y legaliza
                                        la orden.
    13-03-2013         MMesa            Creacion.
   ************************************************************************************/
    PROCEDURE SetImagenColombia
    IS
      sbInstance             Ge_BOInstanceControl.stysbName;
      sbFatherInstance       Ge_BOInstanceControl.stysbName;
      sbProcessInst          Ge_BOInstanceControl.stysbName;
      sbOrderId              Ge_BOInstanceControl.stysbValue;
      sbSectoId              Ge_BOInstanceControl.stysbValue;
      sbTipTrId              Ge_BOInstanceControl.stysbValue;
      sbCudriId              Ge_BOInstanceControl.stysbValue;
      sbNumserv              Ge_BOInstanceControl.stysbValue;
      sbSubElem              Ge_BOInstanceControl.stysbValue;
      sbImputab              Ge_BOInstanceControl.stysbValue;
      sbDirecci              Ge_BOInstanceControl.stysbValue;
      sbActivid              Ge_BOInstanceControl.stysbValue;
      sbFecha                Ge_BOInstanceControl.stysbValue;
      sbCasoRepo             Ge_BOInstanceControl.stysbValue;
      sbObservac             Ge_BOInstanceControl.stysbValue;
      sbFechaRep             Ge_BOInstanceControl.stysbValue;
      sbLlegada              Ge_BOInstanceControl.stysbValue;
      sbControl              Ge_BOInstanceControl.stysbValue;
      sbNormali              Ge_BOInstanceControl.stysbValue;
      sbFinLabo              Ge_BOInstanceControl.stysbValue;
      sbTipoEve              Ge_BOInstanceControl.stysbValue;
      sbTiEvCon              Ge_BOInstanceControl.stysbValue;
      sbSuspSer              Ge_BOInstanceControl.stysbValue;
      sbUserSus              Ge_BOInstanceControl.stysbValue;
      sbMedidor              Ge_BOInstanceControl.stysbValue;
      sbLocaRed              Ge_BOInstanceControl.stysbValue;
      sbLectura              Ge_BOInstanceControl.stysbValue;
      sbElement              Ge_BOInstanceControl.stysbValue;
      sbCausa                Ge_BOInstanceControl.stysbValue;
      sbObseCau              Ge_BOInstanceControl.stysbValue;
      sbRepoPor              Ge_BOInstanceControl.stysbValue;
      sbMarca                Ge_BOInstanceControl.stysbValue;
      sbDiametro             Ge_BOInstanceControl.stysbValue;
      sbDimeRotu             Ge_BOInstanceControl.stysbValue;
      sbNivePres             Ge_BOInstanceControl.stysbValue;
      sbCausalId             Ge_BOInstanceControl.stysbValue;
      sbPersonId             Ge_BOInstanceControl.stysbValue;
      sbLegaMate             Ge_BOInstanceControl.stysbValue;
      nuIcrtCodi             ldc_imcorete.icrtcodi%type;
      nuOrderId              OR_order.order_id%type;
      sbMaskUSer             ldc_imcorete.icrtuser%type;
      osbMessageLeg          varchar2(2000);
      onuCodErrorLeg         number;
      nuSeqReTe              number;
      nuValorReSeq           number;
      nuIcRete               number;
      nuCodiRete             number;
      sbdataorder            varchar2(2000);
      sbActividadesOrden     varchar2(1000);
      nuCantIngresadaOrden   number;
      nuOrderActivityId      or_order_activity.order_activity_id%type;
      nuEstado               number;
      RCTIMEOUTCOMP          DAPR_TIMEOUT_COMPONENT.STYPR_TIMEOUT_COMPONENT;
      nuComp                 pr_component.component_id%type;
      nuCompTime             number;
      sbTimeOut              cc_answer.time_out%type;

      --  Variables para manejo de Errores
      exCallService          EXCEPTION;
      sbCallService          varchar2(2000);
      nuErrorCode            number;
      sbErrorMessage         varchar2(2000);

	BEGIN

	NULL;

	END  SetImagenColombia;


  /*Valida que la fecha de Llegada sea mayor o igual a la fecha de Reporte*/
  PROCEDURE  valFechaLlegada
   (
    idtFechaInsta      in       date
   )
   IS
     sbInstance                    Ge_BOInstanceControl.stysbName;
     sbFechaRepo                   Ge_BOInstanceControl.stysbValue := NULL;
     dtFechaRepo                   ldc_imcorete.icrtfere%type;
   BEGIN
     ut_trace.trace('Inicia LDC_BO_IMAGENCOLOMBIA.valFechaLlegada',9);
     -- Obtiene
     Ge_BOInstanceControl.GetCurrentInstance(sbInstance);

     -- Obtiene numero de fecha instanciada
     Ge_BOInstanceControl.GetAttributeNewValue(sbInstance,NULL,'LDC_IMCORETE','ICRTFERE',sbFechaRepo);
     UT_Trace.Trace('ICRTFERE ['||sbFechaRepo||']',9);
     dtFechaRepo := to_date(sbFechaRepo);

     --Obtiene el nit de la empresa
     OPEN cuNitEmpresa;
     FETCH cuNitEmpresa INTO sbNitEmpresa;
     CLOSE cuNitEmpresa;

     --ARA.134698
     --Mmejia
     --Se agrega la validacion por gasera para la fecha de llegada
     -- se valida entre para todas las gases menos efigas
     if idtFechaInsta  <  dtFechaRepo AND (sbNitEmpresa NOT IN (csbNIT_EFG) ) THEN
       ge_boerrors.seterrorcodeargument(2741,'La Fecha de Llegada debe ser mayor o igual a la Fecha de Reporte');
     else
       if idtFechaInsta > sysdate then
         ge_boerrors.seterrorcodeargument(2741,'La Fecha de Llegada No puede ser Mayor a la Fecha Actual');
       END if;
     END if;

     ut_trace.trace('Finaliza LDC_BO_IMAGENCOLOMBIA.valFechaLlegada',9);
   END valFechaLlegada;

  /*Valida que la fecha de Control sea mayor o igual a la fecha de llegada*/
  PROCEDURE  valFechaControl
   (
    idtFechaInsta        in        date
   )
   IS
     sbInstance                    Ge_BOInstanceControl.stysbName;
     sbFechaCtl                    Ge_BOInstanceControl.stysbValue := NULL;
     dtFechaCtl                    ldc_imcorete.icrtlleg%type;
   BEGIN
     ut_trace.trace('Inicia LDC_BO_IMAGENCOLOMBIA.valFechaControl',9);
     -- Obtiene
     Ge_BOInstanceControl.GetCurrentInstance(sbInstance);

     -- Obtiene numero de fecha instanciada
     Ge_BOInstanceControl.GetAttributeNewValue(sbInstance,NULL,'LDC_IMCORETE','ICRTLLEG',sbFechaCtl);
     UT_Trace.Trace('ICRTFERE ['||sbFechaCtl||']',9);
     dtFechaCtl := to_date(sbFechaCtl);

     --Obtiene el nit de la empresa
     OPEN cuNitEmpresa;
     FETCH cuNitEmpresa INTO sbNitEmpresa;
     CLOSE cuNitEmpresa;

     --ARA.134698
     --Mmejia
     --Se agrega la validacion por gasera para la fecha de llegada
     -- se valida entre para todas las gases menos efigas
     IF idtFechaInsta  <  dtFechaCtl AND (sbNitEmpresa NOT IN (csbNIT_EFG) ) THEN
       ge_boerrors.seterrorcodeargument(2741,'La Fecha de Control debe ser mayor o igual a la Fecha de Llegada');
     else
       if idtFechaInsta > sysdate then
         ge_boerrors.seterrorcodeargument(2741,'La Fecha de Control No puede ser Mayor a la Fecha Actual');
       END if;
     END if;

     ut_trace.trace('Finaliza LDC_BO_IMAGENCOLOMBIA.valFechaControl',9);
   END valFechaControl;

  /*Valida que la fecha de normaliza sea mayor o igual a la fecha de control*/
  PROCEDURE  valFechaNormaliza
   (
    idtFechaInsta        in        date
   )
   IS
     sbInstance                    Ge_BOInstanceControl.stysbName;
     sbFechaNorma                  Ge_BOInstanceControl.stysbValue := NULL;
     dtFechaNorma                  ldc_imcorete.icrtctrl%type;
   BEGIN
     ut_trace.trace('Inicia LDC_BO_IMAGENCOLOMBIA.valFechaNormaliza',9);
     -- Obtiene
     Ge_BOInstanceControl.GetCurrentInstance(sbInstance);

     -- Obtiene numero de fecha instanciada
     Ge_BOInstanceControl.GetAttributeNewValue(sbInstance,NULL,'LDC_IMCORETE','ICRTCTRL',sbFechaNorma );
     UT_Trace.Trace('ICRTFERE ['||sbFechaNorma ||']',9);
     dtFechaNorma := to_date(sbFechaNorma);

     --Obtiene el nit de la empresa
     OPEN cuNitEmpresa;
     FETCH cuNitEmpresa INTO sbNitEmpresa;
     CLOSE cuNitEmpresa;

     --ARA.134698
     --Mmejia
     --Se agrega la validacion por gasera para la fecha de llegada
     -- se valida entre para todas las gases menos efigas
     IF idtFechaInsta  <   dtFechaNorma AND (sbNitEmpresa NOT IN (csbNIT_EFG) ) THEN
       ge_boerrors.seterrorcodeargument(2741,'La Fecha de Normaliza debe ser mayor o igual a la Fecha de Control');
     else
       if idtFechaInsta > sysdate then
         ge_boerrors.seterrorcodeargument(2741,'La Fecha de Normaliza No puede ser Mayor a la Fecha Actual');
       END if;
     END if;

     ut_trace.trace('Finaliza LDC_BO_IMAGENCOLOMBIA.valFechaNormaliza',9);
   END valFechaNormaliza;


   /*Valida que la fecha de Fin de Labores sea mayor o igual a la fecha de normaliza*/
  PROCEDURE  valFechaFinLabores
   (
    idtFechaInsta        in        date
   )
   IS
     sbInstance                    Ge_BOInstanceControl.stysbName;
     sbFechaFiLa                   Ge_BOInstanceControl.stysbValue := NULL;
     dtFechaFiLa                   ldc_imcorete.icrtnorm%type;
   BEGIN
     ut_trace.trace('Inicia LDC_BO_IMAGENCOLOMBIA.valFechaFinLabores',9);
     -- Obtiene
     Ge_BOInstanceControl.GetCurrentInstance(sbInstance);

     -- Obtiene numero de Fecha instanciada
     Ge_BOInstanceControl.GetAttributeNewValue(sbInstance,NULL,'LDC_IMCORETE','ICRTNORM',sbFechaFiLa );
     UT_Trace.Trace('ICRTFERE ['||sbFechaFiLa ||']',9);
     dtFechaFiLa := to_date(sbFechaFiLa);

     --Obtiene el nit de la empresa
     OPEN cuNitEmpresa;
     FETCH cuNitEmpresa INTO sbNitEmpresa;
     CLOSE cuNitEmpresa;

     --ARA.134698
     --Mmejia
     --Se agrega la validacion por gasera para la fecha de llegada
     -- se valida entre para todas las gases menos efigas
     IF idtFechaInsta  <   dtFechaFiLa AND (sbNitEmpresa NOT IN (csbNIT_EFG) ) THEN
       ge_boerrors.seterrorcodeargument(2741,'La Fecha de fin de labores no puede ser menor a la Fecha de Normaliza');
     ELSE
       if idtFechaInsta > sysdate then
         ge_boerrors.seterrorcodeargument(2741,'La Fecha de Fin de Labores No puede ser Mayor a la Fecha Actual');
       END if;
     END if;


     ut_trace.trace('Finaliza LDC_BO_IMAGENCOLOMBIA.valFechaFinLabores',9);

     END valFechaFinLabores;


/*     valida que la haya sido registra en OFRT*/

    /*
     Obtiene el Id de ORDER_comment dada la orden */
  FUNCTION valOrdenRevicionTecnica
   (
     inuOrderId       in      OR_order.order_id%type
   )
   return number
   is
     nuExistOrder         number := 0;
     nuIdOrderComment    OR_order_comment.order_comment_id%type := 0;

     -- CURSOR
      CURSOR cuOrderActivity(inuOrderId in OR_order.order_id%type ) IS
        select ORDER_comment_id FROM OR_order_comment
        where ORDER_id  = inuOrderId
        AND ORDER_comment_id IS not null;

   BEGIN
     for exac in cuOrderActivity(inuOrderId) loop
       nuExistOrder :=1;
       nuIdOrderComment := exac.order_comment_id;
     END loop;

     return  nuIdOrderComment;

   END valOrdenRevicionTecnica;


   /***************************************************************
       Inicializa la forma OCRT
       Historia de Modificaciones
      Fecha             Autor                Modificacion
    =========         =========          ====================
    13-03-2013         MMesa            Creacion.
    15-08-2013         EMIROL           Se seteo el atributo que indica si la orden se legaliza con materiales

   ***************************************************************/
   PROCEDURE IniDatosOCRT
   (
     inuOrderId  OR_order.order_id%type
   )
    IS
      sbInstance                    Ge_BOInstanceControl.stysbName;
      sbSerialNumb                  Ge_BOInstanceControl.stysbValue := NULL;
      nuOrderActivityId             or_order_activity.order_activity_id%type;
      nuOrderCommentId              OR_order_comment.order_comment_id%type;
      sbObservaci                   OR_order_comment.order_comment%type;
      dtFechFinal                   OR_order.execution_final_date%type;
      nuSectorGeo                   OR_order.operating_sector_id%type;
      nuTrabReali                   OR_order.real_task_type_id%type;
      dtFechLlega                   OR_order.exec_initial_date%type;
      nuCuadrilla                   OR_order.operating_unit_id%type;
      nuPackageId                   mo_packages.package_id%type;
      sbImputable                   ldc_imcorete.icrtimpu%type;
      dtFechRepor                   OR_order.created_date%type;
      nuCasoRepor                   OR_order.task_type_id%type;
      nuNumServic                   pr_product.product_id%type;
      nuDireccion                   ab_address.address_id%type;
      dtFechOrden                   OR_order.created_date%type;
      dtFechCtrl                    ldc_imcorete.icrtctrl%type;
      dtFechNorma                   ldc_imcorete.icrtnorm%type;
      nuImcorete                    ldc_imcorete.icrtcodi%type;
      sbSubElem                     ldc_imcorete.icrtelem%type;
      sbTipoEve                     ldc_imcorete.icrttiev%type;
      sbTiEvCon                     ldc_imcorete.icrtevco%type;
      sbSuspSer                     ldc_imcorete.icrtsuse%type;
      sbUserSus                     ldc_imcorete.icrtusse%type;
      sbLocaRed                     ldc_imcorete.icrtlore%type;
      sbLectura                     ldc_imcorete.icrtlect%type;
      sbElement                     ldc_imcorete.icrtelem%type;
      sbCausa                       ldc_imcorete.icrtcaus%type;
      sbObseCau                     ldc_imcorete.ictrobsc%type;
      sbRepoPor                     ldc_imcorete.ictrrepo%type;
      sbMarca                       ldc_imcorete.ictrmarc%type;
      sbDiametro                    ldc_imcodiam.icdidiam%type;
      sbDimeRotu                    ldc_imcodiam.icdidiro%type;
      sbNivePres                    ldc_imcodiam.icdinipr%type;
      sbPersonId                    ldc_imcorete.icrtpers%type;
      dtFechActu                    ldc_imcorete.icrtfemo%type;
      sbObscActu                    ldc_imcorete.icrtobup%type;
      nuCausalId                    OR_order.causal_id%type;
      sbMedidor                     elemmedi.elmecodi%type;
      nuElemedi                     elmesesu.emsselme%type;
      sbLegaMate                    ldc_imcorete.icrtlmat%type;
      nuExistOrder                  number := 0;
      nuExistDiame                  number := 0;
      --  Variables para manejo de Errores
      exCallService                 EXCEPTION;
      sbCallService                 varchar2(2000);
      nuErrorCode                   number;
      sbErrorMessage                varchar2(2000);
      -- CURSOR
      CURSOR cuLdc_Imcorete(inuOrderId in OR_order.order_id%type ) IS
        select * FROM ldc_imcorete
        where icrtorde  = inuOrderId
        AND rownum = 1;
     -- CURSOR
      CURSOR cuLdc_imcodiam(inuImcorete in ldc_imcorete.icrtcodi %type ) IS
        select * FROM ldc_imcodiam
        where icdirete = inuImcorete
        AND rownum = 1;

    BEGIN
      ut_trace.Init;
      UT_Trace.Trace('Inicia LCD_IMAGENCOLOMBIA.IniDatosOCRT',8);
      pkErrors.push ('LDC_BO_IMAGENCOLOMBIA.IniDatosOCRT');

      for e in cuLdc_Imcorete(inuOrderId) loop
        nuExistOrder :=1;
        nuImcorete  := e.icrtcodi;
        nuNumServic := e.icrtnuse;
        nuPackageId := e.icrtacti;
        nuDireccion := e.icrtdire;
        sbImputable := e.icrtimpu;
        dtFechOrden := e.icrtfech;
        nuSectorGeo := e.icrtsect;
        nuCasoRepor := e.icrtcare;
        nuTrabReali := e.icrttitr;
        nuCuadrilla := e.icrtcudr;
        sbObservaci := e.icrtobsf;
        sbMedidor   := e.icrtmedi;
        dtFechLlega := e.icrtlleg;
        dtFechFinal := e.icrtfila;
        dtFechOrden := e.icrtfere;
        dtFechCtrl  := e.icrtctrl;
        dtFechNorma := e.icrtnorm;
        sbSubElem   := e.icrtelem;
        sbTipoEve   := e.icrttiev;
        sbTiEvCon   := e.icrtevco;
        sbSuspSer   := e.icrtsuse;
        sbUserSus   := e.icrtusse;
        sbLocaRed   := e.icrtlore;
        sbLectura   := e.icrtlect;
        sbElement   := e.icrtelem;
        sbCausa     := e.icrtcaus;
        sbObseCau   := e.ictrobsc;
        sbRepoPor   := e.ictrrepo;
        sbMarca     := e.ictrmarc;
        sbSubElem   := e.icrtsuel;
        sbPersonId  := e.icrtpers;
        sbObscActu  := e.icrtobup;
        dtFechActu  := e.icrtfemo;
        sbLegaMate  := e.icrtlmat;
      END loop;

      for e in cuLdc_imcodiam(nuImcorete) loop
        nuExistDiame :=1;
        sbDiametro  := e.icdidiam;
        sbDimeRotu  := e.icdidiro;
        sbNivePres  := e.icdinipr;
      END loop;
      -- Obtiene la causal con la que se legalizo la orden.
      nuCausalId  := daor_order.fnugetcausal_id(inuOrderId);

      -- Obtiene la instancia actual
      Ge_BOInstanceControl.GetCurrentInstance(sbInstance);
      -- Si tiene un valor
      IF (inuOrderId IS NOT NULL) THEN
        -- Valida que la orden exista en OFRT
        if nuExistOrder = 0 then
          GE_BOERRORS.SETERRORCODEARGUMENT(2741,
                           'La orden no esta Registrada en la OFRT, por favor verificar.');
        END if;

        if nuExistDiame = 0 then
          sbDiametro  := null;
          sbDimeRotu  := null;
          sbNivePres  := null;
        END if;
        -- Inicializa PACKAGE_id
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTACTI',nuPackageId,ge_boconstants.gettrue);
        -- Inicializa numero de servicio.
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTNUSE',nuNumServic,ge_boconstants.gettrue);
        -- Inicializa direccion
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTDIRE',nuDireccion,ge_boconstants.gettrue);
        -- Inicializa campo Imputable
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTIMPU',sbImputable,ge_boconstants.gettrue);
        -- Inicializa la fecha de creacion de la orden
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTFECH',dtFechOrden,ge_boconstants.gettrue);
        -- Inicializa Sector
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTSECT',nuSectorGeo,ge_boconstants.gettrue);
        -- Inicializa caso reportado
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTCARE',nuCasoRepor,ge_boconstants.gettrue);
        -- Inicializa trabajo realizado
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTTITR',nuTrabReali,ge_boconstants.gettrue);
        -- Inicializa Cuadrilla
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTCUDR',nuCuadrilla,ge_boconstants.gettrue);
        -- Inicializa Observacion de la orden
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTOBSF',sbObservaci,ge_boconstants.gettrue);
        -- Inicializa la fecha de reporte
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTFERE',dtFechOrden,ge_boconstants.gettrue);
        -- Inicializa la fecha de llegada
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTLLEG',dtFechLlega,ge_boconstants.gettrue);
        -- Inicializa la fecha finalizacion
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTFILA',dtFechFinal,ge_boconstants.gettrue);
        -- Inicializa fecha de Control
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTCTRL',dtFechCtrl,ge_boconstants.gettrue);
        -- Inicializa Fecha de normalizacion
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTNORM',dtFechNorma,ge_boconstants.gettrue);
        -- Inicializa el Medidor
        ge_boinstancecontrol.addattribute(sbInstance,null,
                  'LDC_IMCORETE','ICRTMEDI', sbMedidor,ge_boconstants.gettrue);
        -- Inicializa el tipo de evento
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                  'LDC_IMCORETE','ICRTTIEV',sbTipoEve,ge_boconstants.gettrue);
        -- Inicializa el campo evento controlado
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                  'LDC_IMCORETE','ICRTEVCO',sbTiEvCon,ge_boconstants.gettrue);
        -- Inicializa el campo servicio suspendido
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                  'LDC_IMCORETE','ICRTSUSE',sbSuspSer,ge_boconstants.gettrue);
        -- Inicializa el campo usuarios sin servicio
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                  'LDC_IMCORETE','ICRTUSSE',sbUserSus,ge_boconstants.gettrue);
        -- Inicializa el campo localizacion de red
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                  'LDC_IMCORETE','ICRTLORE',sbLocaRed,ge_boconstants.gettrue);
        -- Inicializa el campo Lectura
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                  'LDC_IMCORETE','ICRTLECT',sbLectura,ge_boconstants.gettrue);
        -- Inicializa el campo Elemento
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                  'LDC_IMCORETE','ICRTELEM',sbElement,ge_boconstants.gettrue);
        -- Inicializa el campo SubElemento
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                  'LDC_IMCORETE','ICRTSUEL',sbSubElem,ge_boconstants.gettrue);
        -- Inicializa el campo Causa de la emergencia
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                  'LDC_IMCORETE','ICRTCAUS',sbCausa,ge_boconstants.gettrue);
        -- Inicializando el campo Observacion del Registro de OFRT
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                  'LDC_IMCORETE','ICTROBSC',sbObseCau,ge_boconstants.gettrue);
        -- Inicializa el campo reportado por
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                  'LDC_IMCORETE','ICTRREPO',sbRepoPor,ge_boconstants.gettrue);
        -- Inicializa el campo Marca del Elemento
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                  'LDC_IMCORETE','ICTRMARC',sbMarca,ge_boconstants.gettrue);
        -- Inicializa el campo Diametro de la rotura
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                  'LDC_IMCODIAM','ICDIDIAM',sbDiametro,ge_boconstants.gettrue);
        -- Inicializa el campo Dimension de la rotura
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                  'LDC_IMCODIAM','ICDIDIRO',sbDimeRotu,ge_boconstants.gettrue);
        -- Inicializa el campo Nivel de Presion.
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                  'LDC_IMCODIAM','ICDINIPR',sbNivePres,ge_boconstants.gettrue);
        -- Obtiene la causal con la que se legalizo la orden.
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                  'OR_ORDER','CAUSAL_ID',nuCausalId,ge_boconstants.gettrue);
         -- Inicializa el campo Nivel de Presion.
        ge_boInstanceControl.addattribute(sbInstance,NULL,
         'OR_OPER_UNIT_PERSONS','PERSON_ID',sbPersonId,ge_boconstants.gettrue);

        ge_boInstanceControl.addattribute(sbInstance,NULL,
                   'LDC_IMCORETE','ICRTOBUP',sbObscActu,ge_boconstants.gettrue);
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                   'LDC_IMCORETE','ICRTFERG',dtFechActu,ge_boconstants.gettrue);
        ge_boInstanceControl.addattribute(sbInstance,NULL,
                   'LDC_IMCORETE','ICRTLMAT',sbLegaMate,ge_boconstants.gettrue);

      END IF;

      UT_Trace.Trace('Finaliza LCD_IMAGENCOLOMBIA.IniDatosOCRT',8);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
	    pkErrors.pop;
	    raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END IniDatosOCRT;

    /*Valida la forma de consulta OCRT */
    PROCEDURE SetValOCRT
    IS
    BEGIN
      ut_trace.Init;
      UT_Trace.Trace('Inicia LCD_IMAGENCOLOMBIA.SetValOCRT',8);
       -- null procedimiento dummy
      UT_Trace.Trace('Finaliza LCD_IMAGENCOLOMBIA.SetValOCRT',8);
    END SetValOCRT;

    /*Obtiene Lista de Causales permitidas para Legalizacion*/
     PROCEDURE ObtListCausales
    (
      inuCausal           IN       OR_task_type_causal.causal_id%type,
      isbDescription      IN       ge_causal.description%type,
      rfQuery             OUT      Constants.tyRefCursor
    )
    IS
      sbInstance                   Ge_BOInstanceControl.stysbName;
      sbTipTrId                    Ge_BOInstanceControl.stysbValue := NULL;
      nuTipoTrab                   or_task_type.task_type_id%type;
      sbSql                        VARCHAR2(2000);
      --  Variables para manejo de Errores
      exCallService                EXCEPTION;
      sbCallService                varchar2(2000);
      nuErrorCode                  number;
      sbErrorMessage               varchar2(2000);

    BEGIN
      ut_trace.Init;

      UT_Trace.Trace('Inicia LCD_IMAGENCOLOMBIA.ObtListCausales',8);
      pkErrors.push ('LDC_BO_IMAGENCOLOMBIA.ObtListCausales');
      sbSql:=null;

      -- Obtiene la instancia actual
      Ge_BOInstanceControl.GetCurrentInstance(sbInstance);
      -- Obtiene el id del tipo de trabajo que esta instaciando
      Ge_BOInstanceControl.GetAttributeNewValue(sbInstance,NULL,'LDC_IMCORETE',
                                                          'ICRTTITR',sbTipTrId);
      UT_Trace.Trace('Task_type_id' ||'['||sbTipTrId||']',8);
      nuTipoTrab := to_number(sbTipTrId);
      UT_Trace.Trace('Inicia creacion lista ' ,7);
        -- Obtiene la observacion del orden
        sbSql:='SELECT o.causal_id ID, ' ||chr(10)||
               'c.description DESCRIPTION '||chr(10)||
               'FROM OR_task_type_causal o , ge_causal c' ||chr(10)||
               'WHERE o.causal_id = c.causal_id ' ||chr(10)||
               'AND o. task_type_id = '|| nuTipoTrab ||chr(10)||
               'ORDER BY ID asc';

        UT_Trace.Trace('sbsql ['||sbSql||']',7);
        UT_Trace.Trace('Finaliza creacion lista ' ,7);

       OPEN rfQuery FOR sbSql;

      UT_Trace.Trace('Finaliza LCD_IMAGENCOLOMBIA.ObtListCausales',8);

   EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
	    pkErrors.pop;
	    raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END ObtListCausales;


    /*Obtiene Lista de Causales permitidas para Legalizacion*/
    PROCEDURE ObtListPersonId
    (
      inuPersonId           IN       or_oper_unit_persons.person_id%type,
      isbDescription      IN       ge_person.person_id%type,
      rfQuery             OUT      Constants.tyRefCursor
    )
    IS
      sbInstance                   Ge_BOInstanceControl.stysbName;
      sbOrderId                    Ge_BOInstanceControl.stysbValue := NULL;
      nuOrderId                    or_task_type.task_type_id%type;
      nuOperUnitid                 OR_order.operating_unit_id%type;
      sbSql                        VARCHAR2(2000);
      --  Variables para manejo de Errores
      exCallService                EXCEPTION;
      sbCallService                varchar2(2000);
      nuErrorCode                  number;
      sbErrorMessage               varchar2(2000);

    BEGIN
      ut_trace.Init;

      UT_Trace.Trace('Inicia LCD_IMAGENCOLOMBIA.ObtListPersonId',8);
      pkErrors.push ('LDC_BO_IMAGENCOLOMBIA.ObtListPersonId');
      sbSql:=null;

      -- Obtiene la instancia actual
      Ge_BOInstanceControl.GetCurrentInstance(sbInstance);
      -- Obtiene el id del tipo de trabajo que esta instaciando
      Ge_BOInstanceControl.GetAttributeNewValue(sbInstance,NULL,'LDC_IMCORETE',
                                                          'ICRTORDE',sbOrderId);
      UT_Trace.Trace('Task_type_id' ||'['||sbOrderId||']',8);
      nuOrderId := to_number(sbOrderId);
      nuOperUnitid := daor_order.fnugetoperating_unit_id(nuOrderId);

      UT_Trace.Trace('Inicia creacion lista ' ,7);
        -- Obtiene la observacion del orden
        sbSql:='SELECT o.person_id ID ,' ||chr(10)||
               'p.NAME_ DESCRIPTION  '||chr(10)||
               'FROM or_oper_unit_persons o , ge_person p' ||chr(10)||
               'WHERE p.person_id = o.person_id ' ||chr(10)||
               'AND o.operating_unit_id = '|| nuOperUnitid ||chr(10)||
               'ORDER BY ID asc';

        UT_Trace.Trace('sbsql ['||sbSql||']',7);
        UT_Trace.Trace('Finaliza creacion lista ' ,7);


       OPEN rfQuery FOR sbSql;

      UT_Trace.Trace('Finaliza LCD_IMAGENCOLOMBIA.ObtListPersonId',8);


   EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
	    pkErrors.pop;
	    raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END ObtListPersonId;



    /*Actualiza Ordenes registradas en LDC_IMCORETE  */
    PROCEDURE UpdImagenColombia
    IS
      sbInstance             Ge_BOInstanceControl.stysbName;
      sbFatherInstance       Ge_BOInstanceControl.stysbName;
      sbProcessInst          Ge_BOInstanceControl.stysbName;
      sbOrderId              Ge_BOInstanceControl.stysbValue;
      sbSectoId              Ge_BOInstanceControl.stysbValue;
      sbTipTrId              Ge_BOInstanceControl.stysbValue;
      sbCudriId              Ge_BOInstanceControl.stysbValue;
      sbNumserv              Ge_BOInstanceControl.stysbValue;
      sbSubElem              Ge_BOInstanceControl.stysbValue;
      sbImputab              Ge_BOInstanceControl.stysbValue;
      sbDirecci              Ge_BOInstanceControl.stysbValue;
      sbActivid              Ge_BOInstanceControl.stysbValue;
      sbFecha                Ge_BOInstanceControl.stysbValue;
      sbCasoRepo             Ge_BOInstanceControl.stysbValue;
      sbObservac             Ge_BOInstanceControl.stysbValue;
      sbFechaRep             Ge_BOInstanceControl.stysbValue;
      sbLlegada              Ge_BOInstanceControl.stysbValue;
      sbControl              Ge_BOInstanceControl.stysbValue;
      sbNormali              Ge_BOInstanceControl.stysbValue;
      sbFinLabo              Ge_BOInstanceControl.stysbValue;
      sbTipoEve              Ge_BOInstanceControl.stysbValue;
      sbTiEvCon              Ge_BOInstanceControl.stysbValue;
      sbSuspSer              Ge_BOInstanceControl.stysbValue;
      sbUserSus              Ge_BOInstanceControl.stysbValue;
      sbMedidor              Ge_BOInstanceControl.stysbValue;
      sbLocaRed              Ge_BOInstanceControl.stysbValue;
      sbLectura              Ge_BOInstanceControl.stysbValue;
      sbElement              Ge_BOInstanceControl.stysbValue;
      sbCausa                Ge_BOInstanceControl.stysbValue;
      sbObseCau              Ge_BOInstanceControl.stysbValue;
      sbRepoPor              Ge_BOInstanceControl.stysbValue;
      sbMarca                Ge_BOInstanceControl.stysbValue;
      sbDiametro             Ge_BOInstanceControl.stysbValue;
      sbDimeRotu             Ge_BOInstanceControl.stysbValue;
      sbNivePres             Ge_BOInstanceControl.stysbValue;
      sbCausalId             Ge_BOInstanceControl.stysbValue;
      sbPersonId             Ge_BOInstanceControl.stysbValue;
      sbObserAct             Ge_BOInstanceControl.stysbValue;
      nuIcrtCodi             ldc_imcorete.icrtcodi%type;
      nuOrderId              OR_order.order_id%type;
      sbMaskUSer             ldc_imcorete.icrtuser%type;
      osbMessageLeg          varchar2(2000);
      onuCodErrorLeg         number;
      nuSeqReTe              number;
      nuValorReSeq           number;
      nuIcRete               number;
      nuCodiRete             number;

      --  Variables para manejo de Errores
      exCallService          EXCEPTION;
      sbCallService          varchar2(2000);
      nuErrorCode            number;
      sbErrorMessage         varchar2(2000);

    BEGIN

	NULL;

    END  UpdImagenColombia;

  PROCEDURE LDC_VALIDA_OT_IMAGEN_COLOMBIA
   IS
   /*****************************************************************
   Propiedad intelectual de PETI.

   Unidad         : LDC_VALIDA_OT_IMAGEN_COLOMBIA
   Descripcion    : Valida que ya este grabado el formulario de imagen colombial atravez del comando OFRT
   Autor          : Emiro Leyva H.
   Fecha          : 15/08/2013

   Parametros              Descripcion
   ============         ===================

   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================
   02/03/2015                          Cambio 6005. Se modifica para que permita legalizar
                                       con las causales definidas en el parametro CAUSAL_EXCLU_IMAGEN_COL
                                       sin necesidad de registrar previamente la revision tecnica en imagen
                                       Colombia
   ******************************************************************/
   nuorderid              or_order.order_id%TYPE;
   nucurractivityid       or_order_activity.order_activity_id%TYPE;
   nuOk                   number;
   nuErrorCode                         number;
   sbErrorMessage                      varchar2(2000);

   nuCausalId               ge_causal.causal_id%type;
   sbCausalExcImagenCol     ld_parameter.value_chain%type;

   CURSOR cuLDC_IMCORETE
   IS
      SELECT COUNT(1)
       FROM ldc_imcorete
       WHERE ICRTORDE = nuorderid;

   error_proceso          EXCEPTION;
  BEGIN
      ut_trace.trace('Inicia ldc_bo_imagencolombia.LDC_VALIDA_OT_IMAGEN_COLOMBIA',9);

     -- se obtienen las causales excluidas de revision tecnica en imagen colombia
     sbCausalExcImagenCol:= dald_parameter.fsbGetValue_Chain('CAUSAL_EXCLU_IMAGEN_COL');

     ---  numero de orden que se legaliza
     nuorderid := or_bolegalizeorder.fnugetcurrentorder;
     -- Actividad de Orden
     nucurractivityid := or_bolegalizeactivities.fnugetcurractivity;
     IF nuorderid IS NULL THEN
        nuorderid := daor_order_activity.fnugetorder_id (nucurractivityid);
     END IF;

      -- obtiene la causal de legalizacion
     nuCausalId := daor_order.fnugetcausal_id(nuorderid);

     -- valida si la causal se encuentra excluida
     if ut_string.fnuinstr('|'||sbCausalExcImagenCol||'|','|'||nuCausalId||'|')>0 then
        ut_trace.trace('La causal ['||nuCausalId||'] se encuentra excluida de revision imagen colombia',15);
        return;
     END if;

     OPEN cuLDC_IMCORETE;
     FETCH cuLDC_IMCORETE INTO nuOk;
     CLOSE cuLDC_IMCORETE;
     IF nuok = 0 THEN
       ge_boerrors.seterrorcodeargument(2741,'La Orden Ingresada ['||nuorderid||'] se le debe grabar primero el formato'
                                     ||' de Imagen Colombia por el comando OFRT, Por favor verifique.');
     end if;
     ut_trace.trace('Finaliza ldc_bo_imagencolombia.LDC_VALIDA_OT_IMAGEN_COLOMBIA',9);
  EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
	    pkErrors.pop;
	    raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);
  END LDC_VALIDA_OT_IMAGEN_COLOMBIA;

  /**************************************************************************
    Propiedad Intelectual de PETI
    Procedimiento     :  LDC_LlenarAtributosContratista
    Descripcion :
    Autor       : Emiro Leyva
    Fecha       : 24-10-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    24-10-2013          emirol               Creacion.
  **************************************************************************/
  PROCEDURE LDC_LlenarAtributosContratista
    (
        iosbContratistas  in out     Ge_BoUtilities.styStatement
    )
    IS
        sbEmpresa                   ge_boutilities.styStatementAttribute;
        sbTipoAutoriz               ge_boutilities.styStatementAttribute;
        sbTipoContriby              ge_boutilities.styStatementAttribute;
        sbStatus                    ge_boutilities.styStatementAttribute;
        sbCargo                     ge_boutilities.styStatementAttribute;
        sbIdentification            ge_boutilities.styStatementAttribute;
    BEGIN

        if iosbContratistas IS not null then
            return;
        END if;

        -- Se obtiene codigo-descripcion de los atributos a desplegar
        sbEmpresa := 'GE_CONTRATISTA.ID_EMPRESA ' || Ge_BoUtilities.csbSEPARATOR ||'Ge_BoCertifContratista.fsbObtNombreEmpresa(GE_CONTRATISTA.ID_EMPRESA)';

        sbTipoAutoriz := '( SELECT fa_tipoauto.tiaucodi ' || Ge_BoUtilities.csbSEPARATOR ||'fa_tipoauto.tiaudesc FROM fa_tipoauto WHERE tiaucodi = GE_CONTRATISTA.ID_TIPOAUTORIZACION )';
        sbTipoContriby := '( SELECT fa_tipocont.ticocodi ' || Ge_BoUtilities.csbSEPARATOR ||'fa_tipocont.ticodesc FROM fa_tipocont WHERE ticocodi = GE_CONTRATISTA.ID_TIPOCONTRIBUYENTE)';
        sbStatus := 'ge_contratista.status ' || Ge_BoUtilities.csbSEPARATOR || 'ct_boconstants.fsbGetDescStatus(ge_contratista.status)';
        sbCargo := 'GE_CONTRATISTA.POSITION_TYPE_ID ' || Ge_BoUtilities.csbSEPARATOR || 'dage_position_type.fsbgetdescription(GE_CONTRATISTA.POSITION_TYPE_ID, 0)';
        sbIdentification := 'decode(GE_CONTRATISTA.SUBSCRIBER_ID, null, null,
               DAGE_IDENTIFICA_TYPE.FSBGETDESCRIPTION(DAGE_SUBSCRIBER.FNUGETIDENT_TYPE_ID(GE_CONTRATISTA.SUBSCRIBER_ID))'|| Ge_BoUtilities.csbSEPARATOR ||'DAGE_SUBSCRIBER.FSBGETIDENTIFICATION(GE_CONTRATISTA.SUBSCRIBER_ID))';

        -- Se Adicional los atributos a desplegar
        GE_BOUtilities.AddAttribute ('GE_CONTRATISTA.ID_CONTRATISTA','ID_CONTRATISTA',iosbContratistas);
        GE_BOUtilities.AddAttribute ('GE_CONTRATISTA.NOMBRE_CONTRATISTA','NOMBRE_CONTRATISTA',iosbContratistas);
        GE_BOUtilities.AddAttribute ('GE_CONTRATISTA.DESCRIPCION','DESCRIPCION',iosbContratistas);
        GE_BOUtilities.AddAttribute ('GE_CONTRATISTA.CORREO_ELECTRONICO','CORREO_ELECTRONICO',iosbContratistas);
        GE_BOUtilities.AddAttribute ('GE_CONTRATISTA.TELEFONO','TELEFONO',iosbContratistas);
        GE_BOUtilities.AddAttribute ('GE_CONTRATISTA.NOMBRE_CONTACTO','NOMBRE_CONTACTO',iosbContratistas);
        GE_BOUtilities.AddAttribute (sbEmpresa,'ID_EMPRESA',iosbContratistas);
        GE_BOUtilities.AddAttribute ('GE_CONTRATISTA.ID_SUSCRIPTOR','ID_SUSCRIPTOR',iosbContratistas);
        --Se adiciona Tipo de Contribuyente y Tipo de Autorizacion
        --Identificador - Descripcion.
        GE_BOUtilities.AddAttribute (sbTipoAutoriz,'ID_TIPOAUTORIZACION',iosbContratistas);
        GE_BOUtilities.AddAttribute (sbTipoContriby,'ID_TIPOCONTRIBUYENTE',iosbContratistas);
        GE_BOUtilities.AddAttribute (sbStatus,'STATUS',iosbContratistas);

        --Atributos de entidades de recaudo
        GE_BOUtilities.AddAttribute (sbIdentification,'SUBSCRIBER_ID', iosbContratistas);


        GE_BOUtilities.AddAttribute ('GE_CONTRATISTA.COMMON_REG','COMMON_REG',iosbContratistas);
        GE_BOUtilities.AddAttribute ('GE_CONTRATISTA.IVA_TAX','IVA_TAX',iosbContratistas);
        GE_BOUtilities.AddAttribute ('GE_CONTRATISTA.WITHHOLDING_TAX','WITHHOLDING_TAX',iosbContratistas);
        GE_BOUtilities.AddAttribute (sbCargo,'POSITION_TYPE_ID',iosbContratistas);


        GE_BOUtilities.AddAttribute (':parent_id','parent_id',iosbContratistas);

        ut_trace.trace(iosbContratistas,40);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END LDC_LlenarAtributosContratista;



  /**************************************************************************
    Propiedad Intelectual de PETI
    Procedimiento     :  LDC_FiOperatingUnitAttributes
    Descripcion :
    Autor       : Emiro Leyva
    Fecha       : 24-10-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    24-10-2013          emirol               Creacion.
  **************************************************************************/

   PROCEDURE LDC_FiOperatingUnitAttributes
    (
        sbAttributes  in out     Ge_BoUtilities.styStatement
    )
    IS

    BEGIN
       if sbAttributes IS not null then
            return;
        END if;
   --     sbAttributes := '';

      	cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.OPERATING_UNIT_ID',    'OPERATING_UNIT_ID',     cc_boBossUtil.cnuNUMBER,   sbAttributes, tbAttributes, true);
    	cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.OPER_UNIT_CODE',       'OPER_UNIT_CODE',        cc_boBossUtil.cnuVARCHAR2, sbAttributes, tbAttributes);
        cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.NAME',                 'NAME',                  cc_boBossUtil.cnuVARCHAR2, sbAttributes, tbAttributes);

        cc_boBossUtil.AddAttribute (
            'decode(OR_OPERATING_UNIT.OPER_UNIT_CLASSIF_ID, null, null,
             OR_OPERATING_UNIT.OPER_UNIT_CLASSIF_ID ||'||chr(39)||' - '||chr(39)||
            '||DAOR_OPER_UNIT_CLASSIF.fsbGetDescription(OR_OPERATING_UNIT.OPER_UNIT_CLASSIF_ID))',
            'OPER_UNIT_CLASSIF_ID',     cc_boBossUtil.cnuVARCHAR2,   sbAttributes, tbAttributes);

        -- Unidad de trabajo asociada.
        cc_boBossUtil.AddAttribute (
            'decode(OR_OPERATING_UNIT.ASSO_OPER_UNIT, null, null,
             OR_OPERATING_UNIT.ASSO_OPER_UNIT ||'||chr(39)||' - '||chr(39)||
            '||DAOR_OPERATING_UNIT.fsbGetName(OR_OPERATING_UNIT.ASSO_OPER_UNIT))',
            'ASSO_OPER_UNIT',     cc_boBossUtil.cnuVARCHAR2,   sbAttributes, tbAttributes);

         cc_boBossUtil.AddAttribute (
            'decode(OR_OPERATING_UNIT.FATHER_OPER_UNIT_ID, null, null,
             OR_OPERATING_UNIT.FATHER_OPER_UNIT_ID ||'||chr(39)||' - '||chr(39)||
            '||DAOR_OPERATING_UNIT.fsbGetName(OR_OPERATING_UNIT.FATHER_OPER_UNIT_ID))',
            'FATHER_OPER_UNIT_ID',     cc_boBossUtil.cnuVARCHAR2,   sbAttributes, tbAttributes);

        cc_boBossUtil.AddAttribute (
            'decode(OR_OPERATING_UNIT.PERSON_IN_CHARGE, null, null,
             OR_OPERATING_UNIT.PERSON_IN_CHARGE ||'||chr(39)||' - '||chr(39)||
            '||DAGE_PERSON.fsbGetName_(OR_OPERATING_UNIT.PERSON_IN_CHARGE))',
            'PERSON_IN_CHARGE',     cc_boBossUtil.cnuVARCHAR2,   sbAttributes, tbAttributes);

        cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.EVAL_LAST_DATE',       'EVAL_LAST_DATE',        cc_boBossUtil.cnuDATE,     sbAttributes, tbAttributes);

        cc_boBossUtil.AddAttribute (
            'decode(OR_OPERATING_UNIT.SUBSCRIBER_ID, null, null,
               DAGE_IDENTIFICA_TYPE.FSBGETDESCRIPTION(DAGE_SUBSCRIBER.FNUGETIDENT_TYPE_ID(OR_OPERATING_UNIT.SUBSCRIBER_ID))||'||chr(39)||' - '||chr(39)||
                '||DAGE_SUBSCRIBER.FSBGETIDENTIFICATION(OR_OPERATING_UNIT.SUBSCRIBER_ID))',
            'SUBSCRIBER_ID', cc_boBossUtil.cnuVARCHAR2, sbAttributes, tbAttributes);

        cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.VEHICLE_NUMBER_PLATE', 'VEHICLE_NUMBER_PLATE',  cc_boBossUtil.cnuVARCHAR2, sbAttributes, tbAttributes);

        cc_boBossUtil.AddAttribute (
            'decode(OR_OPERATING_UNIT.OPER_UNIT_STATUS_ID, null, null,
             OR_OPERATING_UNIT.OPER_UNIT_STATUS_ID ||'||chr(39)||' - '||chr(39)||
            '||DAOR_OPER_UNIT_STATUS.fsbGetDescription(OR_OPERATING_UNIT.OPER_UNIT_STATUS_ID))',
            'OPER_UNIT_STATUS_ID',     cc_boBossUtil.cnuVARCHAR2,   sbAttributes, tbAttributes);

        cc_boBossUtil.AddAttribute ('decode(OR_OPERATING_UNIT.VALID_FOR_ASSIGN,''Y'',''Si'',''No'')','VALID_FOR_ASSIGN', cc_boBossUtil.cnuVARCHAR2, sbAttributes, tbAttributes);

        cc_boBossUtil.AddAttribute ('decode(OR_OPERATING_UNIT.GEN_ADMIN_ORDER,''Y'',''Si'',''No'')','GEN_ADMIN_ORDER', cc_boBossUtil.cnuVARCHAR2, sbAttributes, tbAttributes);
        cc_boBossUtil.AddAttribute ('decode(OR_OPERATING_UNIT.NOTIFICABLE,''Y'',''Si'',''No'')',    'NOTIFICABLE',     cc_boBossUtil.cnuVARCHAR2, sbAttributes, tbAttributes);
        cc_boBossUtil.AddAttribute (            'decode(OR_OPERATING_UNIT.OPERATING_CENTER_ID, null, null,
             OR_OPERATING_UNIT.OPERATING_CENTER_ID ||'||chr(39)||' - '||chr(39)||
            '||DAGE_CENTRO_OPERATIVO.fsbGetDescripcion(OR_OPERATING_UNIT.OPERATING_CENTER_ID))',
         'CENTRO_OPER_ID',  cc_boBossUtil.cnuVARCHAR2,   sbAttributes, tbAttributes);

        cc_boBossUtil.AddAttribute (
            'decode(OR_OPERATING_UNIT.ADMIN_BASE_ID, null, null,
             OR_OPERATING_UNIT.ADMIN_BASE_ID ||'||chr(39)||' - '||chr(39)||
            '||DAGE_BASE_ADMINISTRA.fsbGetDescripcion(OR_OPERATING_UNIT.ADMIN_BASE_ID))',
         'ADMIN_BASE_ID',  cc_boBossUtil.cnuVARCHAR2,   sbAttributes, tbAttributes);

        cc_boBossUtil.AddAttribute (
            'decode(OR_OPERATING_UNIT.OPERATING_ZONE_ID, null, null,
             OR_OPERATING_UNIT.OPERATING_ZONE_ID ||'||chr(39)||' - '||chr(39)||
            '||DAOR_OPERATING_ZONE.fsbgetdescription(OR_OPERATING_UNIT.OPERATING_ZONE_ID))',
         'OPERATING_ZONE_ID',  cc_boBossUtil.cnuVARCHAR2,   sbAttributes, tbAttributes);

        cc_boBossUtil.AddAttribute (
            'decode(OR_OPERATING_UNIT.ASSIGN_TYPE, '
            ||chr(39)||'S'||chr(39)||', '||chr(39)||ge_boi18n.fsbGetTraslation('ASSIGNED_WITH_S')||chr(39)||', '
            ||chr(39)||'C'||chr(39)||', '||chr(39)||ge_boi18n.fsbGetTraslation('ASSIGNED_WITH_C')||chr(39)||', '
            ||chr(39)||'N'||chr(39)||', '||chr(39)||ge_boi18n.fsbGetTraslation('ASSIGNED_WITH_N')||chr(39)||','
            ||chr(39)||'R'||chr(39)||', '||chr(39)||ge_boi18n.fsbGetTraslation('ASSIGNED_WITH_R')||chr(39)||')',
            'ASSIGN_TYPE',     cc_boBossUtil.cnuVARCHAR2,   sbAttributes, tbAttributes);

        cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.ASSIGN_CAPACITY',    'ASSIGN_CAPACITY',                  cc_boBossUtil.cnuVARCHAR2, sbAttributes, tbAttributes);
        cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.USED_ASSIGN_CAP',    'USED_ASSIGN_CAP',                  cc_boBossUtil.cnuVARCHAR2, sbAttributes, tbAttributes);

        cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.AIU_VALUE_UTIL',       'AIU_VALUE_UTIL',        cc_boBossUtil.cnuNUMBER,   sbAttributes, tbAttributes);
        cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.AIU_VALUE_ADMIN',      'AIU_VALUE_ADMIN',       cc_boBossUtil.cnuNUMBER,   sbAttributes, tbAttributes);
        cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.AIU_VALUE_UNEXPECTED', 'AIU_VALUE_UNEXPECTED',  cc_boBossUtil.cnuNUMBER,   sbAttributes, tbAttributes);
        cc_boBossUtil.AddAttribute ('decode(OR_OPERATING_UNIT.PASSWORD_REQUIRED,''Y'',''Si'',''No'')',    'PASSWORD_REQUIRED',     cc_boBossUtil.cnuVARCHAR2, sbAttributes, tbAttributes);

        cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.ADDRESS',              'ADDRESS',               cc_boBossUtil.cnuVARCHAR2, sbAttributes, tbAttributes);
        cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.PHONE_NUMBER',         'PHONE_NUMBER',          cc_boBossUtil.cnuVARCHAR2, sbAttributes, tbAttributes);
        cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.FAX_NUMBER',           'FAX_NUMBER',            cc_boBossUtil.cnuVARCHAR2, sbAttributes, tbAttributes);
        cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.BEEPER',               'BEEPER',                cc_boBossUtil.cnuVARCHAR2, sbAttributes, tbAttributes);

        cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.E_MAIL',               'E_MAIL',                cc_boBossUtil.cnuVARCHAR2, sbAttributes, tbAttributes);

        cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.CONTRACTOR_ID',        'CONTRACTOR_ID',         cc_boBossUtil.cnuNUMBER,   sbAttributes, tbAttributes);
        cc_boBossUtil.AddAttribute ('OR_OPERATING_UNIT.contractor_id',        'parent_id',             cc_boBossUtil.cnuNUMBER,   sbAttributes, tbAttributes);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;

        when others then
            errors.seterror;
            raise ex.CONTROLLED_ERROR;
    END LDC_FiOperatingUnitAttributes;

/**************************************************************************
    Propiedad Intelectual de PETI
    Procedimiento     :  obtContratistaBase
    Descripcion :
    Autor       : Emiro Leyva
    Fecha       : 24-10-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    24-10-2013          emirol               Creacion.
  **************************************************************************/
   PROCEDURE obtContratistaBase
    (
        isbContratista      in VARCHAR2,
        ocuDataCursor       out constants.tyRefCursor
    )
    IS
        sbSql                   varchar2(32767);
        nuContratista           ge_contratista.id_contratista%type;
        sbContratistas          Ge_BoUtilities.styStatement;
        --======================================================================

    BEGIN

        LDC_LlenarAtributosContratista(sbContratistas);

        nuContratista := to_number(isbContratista);

        sbSql :=  ' SELECT ' || sbContratistas   ||chr(10)||
                  ' FROM    GE_CONTRATISTA '                   ||chr(10)||
                  ' WHERE   GE_CONTRATISTA.id_contratista = :nuContratista';

        ut_trace.trace(sbSql,40);

         open ocuDataCursor for sbSql using cc_boBossUtil.cnuNULL, nuContratista;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END obtContratistaBase;

/**************************************************************************
    Propiedad Intelectual de PETI
    Procedimiento     :  obtContratistas
    Descripcion :
    Autor       : Emiro Leyva
    Fecha       : 24-10-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    24-10-2013          emirol               Creacion.
  **************************************************************************/
    PROCEDURE obtContratistas
    (
        inuContratista      in      ge_contratista.id_contratista%type,
        isbNombre           in      ge_contratista.nombre_contratista%type,
        ocuDataCursor       out     constants.tyRefCursor
    )
    IS
        sbSql                   varchar2(32767);
        sbContratistas          Ge_BoUtilities.styStatement;

        nuContratista           ge_contratista.id_contratista%type;
        sbNombre                ge_contratista.nombre_contratista%type;

        sbUserId                varchar2(16);
        --======================================================================

    BEGIN

        nuContratista   := nvl(inuContratista, CC_BOConstants.cnuAPPLICATIONNULL );
        sbNombre        := trim (upper(nvl(isbNombre, CC_BOConstants.csbNULLSTRING )));
  --      nuEmpresa      := nvl(inuEmpresa, CC_BOConstants.cnuAPPLICATIONNULL );

        LDC_LlenarAtributosContratista(sbContratistas);

        sbSql := ' SELECT '|| sbContratistas ||chr(10)||
                 ' FROM GE_CONTRATISTA '||chr(10)||
                 ' WHERE ';

        --CRITERIOS PARA EL IDENTIFICADOR DEL CONTRATISTA
        IF nuContratista != CC_BOConstants.cnuAPPLICATIONNULL then
            sbSql := sbSql ||' id_contratista = :nuContratista'||chr(10)||' and ';
        ELSE
            sbSql := sbSql ||chr(39)|| nuContratista ||chr(39)||' = :nuContratista'||chr(10)||' and ';
        END IF;

        --CRITEROS (SEGURIDAD ADMINISTRADOR DE CONTRATISTAS DOMINIO: CONTRATISTAS
   --     CT_BOContrSecurity.LoadSecuritySettings(CT_BOConstants.csbSEC_INFO_TYPE_GENERAL);


            --Usuario de la sesion
            sbUserId := to_char(sa_bouser.fnuGetUserId(ut_session.getUSER));


        --CRITERIOS PARA EL NOMBRE DEL CONTRATISTA
        IF sbNombre != CC_BOConstants.csbNULLSTRING then
            sbSql := sbSql ||'upper(nombre_contratista) LIKE upper(:sbNombre)||'||chr(39)||'%'||chr(39)||chr(10);
        ELSE
            sbSql := sbSql ||chr(39)|| sbNombre ||chr(39)||' = :sbNombre'||chr(10);
        END IF;

         ut_trace.trace(sbSql,40);

        open ocuDataCursor for sbSql using      cc_boBossUtil.cnuNULL,
                                                nuContratista,
                                                sbNombre;


    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END obtContratistas;
  ------------------------------------------------------------------------------------------------------------------------
/**************************************************************************
    Propiedad Intelectual de PETI
    Procedimiento     :  obtOperatingUnit
    Descripcion :
    Autor       : Emiro Leyva
    Fecha       : 24-10-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    24-10-2013          emirol               Creacion.
  **************************************************************************/
   PROCEDURE obtOperatingUnit
    (
        isbOperatingUnit    in VARCHAR2,
        ocuDataCursor       out constants.tyRefCursor
    )
    IS
        sbSql                   varchar2(32767);
        nuoperating_unit          or_operating_unit.OPERATING_UNIT_ID%type;
        sboperating_unit          Ge_BoUtilities.styStatement;
        --======================================================================

    BEGIN

        LDC_FiOperatingUnitAttributes(sboperating_unit);

        nuoperating_unit := to_number(isbOperatingUnit);

        sbSql :=  ' SELECT ' || sboperating_unit   ||chr(10)||
                  ' FROM    OR_OPERATING_UNIT '                   ||chr(10)||
                  ' WHERE   OR_OPERATING_UNIT.OPERATING_UNIT_ID = :nuoperating_unit';

        ut_trace.trace(sbSql,40);

         open ocuDataCursor for sbSql using nuoperating_unit;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END obtOperatingUnit;

/**************************************************************************
    Propiedad Intelectual de PETI
    Procedimiento     :  obtOperatingUnitS
    Descripcion :
    Autor       : Emiro Leyva
    Fecha       : 24-10-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    24-10-2013          emirol               Creacion.
  **************************************************************************/
    PROCEDURE obtOperatingUnitS
    (
        inuOperatingUnit      in      or_operating_unit.OPERATING_UNIT_ID%type,
        isbNombre             in      or_operating_unit.name%type,
        ocuDataCursor         out     constants.tyRefCursor
    )
    IS
        sbSql                   varchar2(32767);
        sbOperatingUnit          Ge_BoUtilities.styStatement;

        nuOperatingUnit           or_operating_unit.OPERATING_UNIT_ID%type;
        sbNombre                  or_operating_unit.name%type;

        sbUserId                varchar2(16);
        --======================================================================

    BEGIN

        nuOperatingUnit   := nvl(inuOperatingUnit, CC_BOConstants.cnuAPPLICATIONNULL );
        sbNombre          := trim (upper(nvl(isbNombre, CC_BOConstants.csbNULLSTRING )));

        LDC_FiOperatingUnitAttributes(sbOperatingUnit);

        sbSql := ' SELECT '|| sbOperatingUnit ||chr(10)||
                 ' FROM OR_OPERATING_UNIT '||chr(10)||
                 ' WHERE ';

        --CRITERIOS PARA EL IDENTIFICADOR DEL CONTRATISTA
        IF nuOperatingUnit != CC_BOConstants.cnuAPPLICATIONNULL then
            sbSql := sbSql ||' operating_unit_id = :nuOperatingUnit'||chr(10)||' and ';
        ELSE
            sbSql := sbSql ||chr(39)|| nuOperatingUnit ||chr(39)||' = :nuOperatingUnit'||chr(10)||' and ';
        END IF;

        --CRITEROS (SEGURIDAD ADMINISTRADOR DE CONTRATISTAS DOMINIO: CONTRATISTAS
   --     CT_BOContrSecurity.LoadSecuritySettings(CT_BOConstants.csbSEC_INFO_TYPE_GENERAL);


            --Usuario de la sesion
            sbUserId := to_char(sa_bouser.fnuGetUserId(ut_session.getUSER));


        --CRITERIOS PARA EL NOMBRE DEL CONTRATISTA
        IF sbNombre != CC_BOConstants.csbNULLSTRING then
            sbSql := sbSql ||'upper(name) LIKE upper(:sbNombre)||'||chr(39)||'%'||chr(39)||chr(10);
        ELSE
            sbSql := sbSql ||chr(39)|| sbNombre ||chr(39)||' = :sbNombre'||chr(10);
        END IF;

         ut_trace.trace(sbSql,40);

        open ocuDataCursor for sbSql using      --cc_boBossUtil.cnuNULL,
                                                nuOperatingUnit,
                                                sbNombre;


    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END obtOperatingUnitS;


  --------------------------------------**************************Referencia HIjo de padre--------------------------------
 /**************************************************************************
    Propiedad Intelectual de PETI
    Procedimiento     :  getFatherOperUnit
    Descripcion :
    Autor       : Emiro Leyva
    Fecha       : 24-10-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    24-10-2013          emirol               Creacion.
  **************************************************************************/

      PROCEDURE getFatherOperUnit
    (
        inuContractorId in  number,
        ocuCursor       out constants.tyRefCursor
    )
    IS
        sbSql ge_boutilities.styStatementAttribute;
        sbHint   ge_boutilities.styStatementAttribute;
	    sbAttributes                ge_boutilities.styStatementAttribute;
    BEGIN

        -- Construir los atributos de la unidad de trabajo
        LDC_FiOperatingUnitAttributes(sbAttributes);

        -- Construir el hint
        sbHint :=  '/*+ index(or_operating_unit idx_or_operating_unit10) */';

        -- Armar la sentencia
        sbSql := 'select '|| sbHint ||sbAttributes ||chr(10)||'from OR_OPERATING_UNIT /*+ Ge_BofwCertifContratista.getFatherOperUnit */'||chr(10);
        sbSql := sbSql||'where OR_OPERATING_UNIT.CONTRACTOR_ID = :inuContractorId';

        -- Mostrar la sentencia a ejecutar
        dbms_output.put_Line(sbSql);

        -- Retornar los datos
        open ocuCursor for sbSql using  nvl(inuContractorId,GE_BOUtilities.csbNULLSTRING);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;

        when others then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END getFatherOperUnit;

    PROCEDURE FillOrderAttributes(iosbAttributes in out Ge_BoUtilities.styStatement)
    IS
        sbNumerator                 ge_boutilities.styStatementAttribute;
        sbTaskType                  ge_boutilities.styStatementAttribute;
        sbOrderStatus               ge_boutilities.styStatementAttribute;
        sbOperatingSector           ge_boutilities.styStatementAttribute;
        sbOperatingUnit             ge_boutilities.styStatementAttribute;
        sbOperaUnitStatus           ge_boutilities.styStatementAttribute;
        sbAssignedWith              ge_boutilities.styStatementAttribute;
        sbOrderClassif              ge_boutilities.styStatementAttribute;
        sbCausal                    ge_boutilities.styStatementAttribute;
        sbRealTaskType              ge_boutilities.styStatementAttribute;
        sbPerson                    ge_boutilities.styStatementAttribute;
        sbCorscopr                  ge_boutilities.styStatementAttribute;
        sbRuseruta                  ge_boutilities.styStatementAttribute;
        sbRouteName                 ge_boutilities.styStatementAttribute;
        sbAddress_parsed            ge_boutilities.styStatementAttribute;
        sbNeighborthood             ge_boutilities.styStatementAttribute;
        sbGeogrLocation             ge_boutilities.styStatementAttribute;
        sbSubscName                 ge_boutilities.styStatementAttribute;
        sbSubscLast_name            ge_boutilities.styStatementAttribute;
        sbProgClasDesc              ge_boutilities.styStatementAttribute;
        sbProduct                   ge_boutilities.styStatementAttribute;
        sbSubscriber                ge_boutilities.styStatementAttribute;
        sbIsCountermand             ge_boutilities.styStatementAttribute;
        sbClientType                ge_boutilities.styStatement;
        sbClientPhone               ge_boutilities.styStatement;
        sbScoring                   ge_boutilities.styStatement;
        sbDuration                  ge_boutilities.styStatement;
        sbComment                   ge_boutilities.styStatement;
        sbCommentType               ge_boutilities.styStatement;
        sbAssoUnit                  ge_boutilities.styStatement;
        sbOffered                   ge_boutilities.styStatement;
        sbProjectName               ge_boutilities.styStatement;
        sbStageName                 ge_boutilities.styStatement;

                                                                                                --
    BEGIN
        -- Atributos con codigo y descripcion
        sbNumerator         := 'OR_ORDER.numerator_id || chr(32) || chr(45) || chr(32) || OR_ORDER.sequence';
        sbTaskType          := '(select or_task_type.task_type_id || chr(32) || chr(45) || chr(32) || or_task_type.description FROM or_task_type WHERE or_task_type.task_type_id = OR_order.task_type_id )';
        sbOrderStatus       := '(select OR_order_status.order_status_id || chr(32) || chr(45) || chr(32) || OR_order_status.description FROM OR_order_status WHERE OR_order_status.order_status_id = OR_order.order_status_id )';
        sbOperatingSector   := '(select or_operating_sector.operating_sector_id || chr(32) || chr(45) || chr(32) || or_operating_sector.description FROM or_operating_sector WHERE OR_order.operating_sector_id = or_operating_sector.operating_sector_id )';
        sbOperatingUnit     := '(select or_operating_unit.operating_unit_id || chr(32) || chr(45) || chr(32) || or_operating_unit.name FROM or_operating_unit WHERE or_operating_unit.operating_unit_id = OR_order.operating_unit_id)';
        sbOperaUnitStatus   := '(select or_oper_unit_status.oper_unit_status_id || chr(32) || chr(45) || chr(32) || or_oper_unit_status.description FROM or_operating_unit, or_oper_unit_status WHERE or_operating_unit.oper_unit_status_id =  or_oper_unit_status.oper_unit_status_id AND or_operating_unit.operating_unit_id = OR_order.operating_unit_id)';
        /*sbAssignedWith      := 'OR_ORDER.ASSIGNED_WITH || chr(32) || chr(45) || chr(32) || decode(OR_ORDER.ASSIGNED_WITH'||
                                                                                   ',''''S'''','''''||ge_boi18n.fsbGetTraslation('ASSIGNED_WITH_S')||
                                                                                   ''''',''''C'''','''''||ge_boi18n.fsbGetTraslation('ASSIGNED_WITH_C')||
                                                                                   ''''',''''N'''','''''||ge_boi18n.fsbGetTraslation('ASSIGNED_WITH_N')||
                                                                                   ''''',''''R'''','''''||ge_boi18n.fsbGetTraslation('ASSIGNED_WITH_R')||
                                                                                   ''''',null)'; */
        sbOrderClassif      := 'OR_ORDER.ORDER_CLASSIF_ID || chr(32) || chr(45) || chr(32) || OR_boBasicDataServices.fsbGetDescOrderClassif(OR_ORDER.ORDER_CLASSIF_ID)';
        sbCausal            := '(select ge_causal.causal_id || chr(32) || chr(45) || chr(32) || ge_causal.description FROM ge_causal WHERE ge_causal.causal_id = OR_order.causal_id)';
        sbRealTaskType      := '(select or_task_type.task_type_id || chr(32) || chr(45) || chr(32) || or_task_type.description FROM or_task_type WHERE or_task_type.task_type_id = or_order.real_task_type_id )';
        sbProgClasDesc      := 'OR_BOBasicDataServices.fsbGetProgClassDesc(or_order.order_id)';
        sbPerson            := '(select OR_ORDER_PERSON.person_id || chr(32) || chr(45) || chr(32) || ge_person.name_ FROM ge_person, OR_ORDER_PERSON '
                              || ' WHERE ge_person.person_id = OR_ORDER_PERSON.person_id '
                              || ' AND OR_ORDER_PERSON.operating_unit_id = OR_order.operating_unit_id '
                              || ' AND OR_ORDER_PERSON.order_id = OR_order.order_id )';
        sbCorscopr          := 'or_order.consecutive';
        sbRuseruta          := 'or_order.route_id';
        sbRouteName         := '(select  OR_route.route_id || chr(32) || chr(45) || chr(32) || OR_route.Name FROM OR_route WHERE OR_route.route_id = or_order.route_id)';
        sbAddress_parsed    := 'AB_ADDRESS.address_parsed';
        sbNeighborthood     := 'decode(or_order.external_address_id,null,null,ab_bobasicdataservices.fsbGetDescNeighborthoodByAddr(or_order.external_address_id))';
        sbGeogrLocation     := 'decode(or_order.external_address_id,null,null,ab_bobasicdataservices.fsbGetDescGeograLocatiByAddr(or_order.external_address_id))';
        sbSubscName         := 'ge_subscriber.subscriber_name';
        sbSubscLast_name    := 'ge_subscriber.subs_last_name';
        sbProduct           := 'or_bobasicdataservices.fnuGetProductId(or_order.order_id)';
        sbSubscriber        := 'ge_subscriber.identification';
        sbClientType        := 'decode(ge_subscriber.subscriber_type_id, null, null,ge_subscriber.subscriber_type_id|| chr(32) || chr(45) || chr(32) ||dage_subscriber_type.fsbgetdescription(ge_subscriber.subscriber_type_id))';
        sbClientPhone       := 'or_bobasicdataservices.fsbObtTelefonoClient(or_order.order_id)';
        sbScoring           := 'or_bobasicdataservices.fnuObtUltimoScoring(or_order.order_id)';
        sbDuration          := 'or_bobasicdataservices.fnuEsfuerzoOrden(or_order.order_id)';
        sbComment           := 'or_bcordercomment.fsbLastCommentByOrder(or_order.order_id)';
        sbCommentType       := 'or_bcordercomment.fsbLastCommentTypeByOrder(or_order.order_id)';
        sbAssoUnit          := 'or_order.asso_unit_id || chr(32) || chr(45) || chr(32) || daor_operating_unit.fsbGetName(or_order.asso_unit_id,0)';
        sbOffered           := 'or_order.offered';
        sbProjectName       := 'PM_BOServices.fsbGetProjectNameByStage(or_order.stage_id)';
        sbStageName         := 'or_order.stage_id || chr(32) || chr(45) || chr(32) || dapm_stage.fsbGetStage_name(or_order.stage_id,0)';
        --sbIsCountermand     := 'decode(OR_ORDER.IS_COUNTERMAND,'''''|| or_boconstants.csbSI || ''''','''''|| ge_boi18n.fsbGetTraslation('YES') || ''''', '''''||ge_boi18n.fsbGetTraslation('NO')|| ''''')';

        GE_BOUtilities.AddAttribute ('OR_ORDER.ORDER_ID','ORDER_ID',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbNumerator,'numerator', iosbAttributes);
        GE_BOUtilities.AddAttribute (sbTaskType,'TASK_TYPE',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbOrderStatus,'ORDER_STATUS',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbOperatingSector,'OPERATING_SECTOR',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbProduct,'PRODUCT_ID',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbOperatingUnit,'OPERATING_UNIT',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbOperaUnitStatus,'OPERATING_UNIT_STATUS',iosbAttributes);
        GE_BOUtilities.AddAttribute ('OR_ORDER.CREATED_DATE','CREATED_DATE',iosbAttributes);
        GE_BOUtilities.AddAttribute ('OR_ORDER.ASSIGNED_DATE','ASSIGNED_DATE',iosbAttributes);
        --GE_BOUtilities.AddAttribute (sbAssignedWith,'ASSIGNED_WITH',iosbAttributes);
        GE_BOUtilities.AddAttribute ('OR_ORDER.EXEC_ESTIMATE_DATE','EXEC_ESTIMATE_DATE',iosbAttributes);
        GE_BOUtilities.AddAttribute ('OR_ORDER.MAX_DATE_TO_LEGALIZE','MAX_DATE_TO_LEGALIZE',iosbAttributes);
        GE_BOUtilities.AddAttribute ('OR_ORDER.REPROGRAM_LAST_DATE','REPROGRAM_LAST_DATE',iosbAttributes);
        GE_BOUtilities.AddAttribute ('OR_ORDER.LEGALIZATION_DATE','LEGALIZATION_DATE',iosbAttributes);
        GE_BOUtilities.AddAttribute ('OR_ORDER.EXEC_INITIAL_DATE','EXEC_INITIAL_DATE',iosbAttributes);
        GE_BOUtilities.AddAttribute ('OR_ORDER.EXECUTION_FINAL_DATE','EXECUTION_FINAL_DATE',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbCausal,'CAUSAL',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbPerson,'PERSON',iosbAttributes);
        GE_BOUtilities.AddAttribute ('OR_ORDER.ORDER_VALUE','ORDER_VALUE',iosbAttributes);
        GE_BOUtilities.AddAttribute ('nvl(OR_ORDER.PRINTING_TIME_NUMBER,0)','PRINTING_TIME_NUMBER',iosbAttributes);
        GE_BOUtilities.AddAttribute ('nvl(OR_ORDER.LEGALIZE_TRY_TIMES,0)','LEGALIZE_TRY_TIMES',iosbAttributes);
        --GE_BOUtilities.AddAttribute (sbIsCountermand,'IS_COUNTERMAND',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbRealTaskType,'REAL_TASK_TYPE',iosbAttributes);
        GE_BOUtilities.AddAttribute ('OR_ORDER.PRIORITY','PRIORITY',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbProgClasDesc,'PROGCLASDESC',iosbAttributes);
        GE_BOUtilities.AddAttribute ('OR_ORDER.ARRANGED_HOUR','ARRANGED_HOUR',iosbAttributes);
        GE_BOUtilities.AddAttribute ('OR_ORDER.APPOINTMENT_CONFIRM','APPOINTMENT_CONFIRM',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbCorscopr,'CORSCOPR',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbRuseruta,'RUSERUTA',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbRouteName,'ROUTE_NAME',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbAddress_parsed,'ADDRESS_PARSED',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbNeighborthood,'NEIGHBORTHOOD',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbGeogrLocation,'GEOGRAP_LOCATION',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbSubscriber,'SUBSCRIBER_ID',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbSubscName,'SUBSC_NAME',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbSubscLast_name,'SUBSC_LAST_NAME',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbClientType,'CLIENT_TYPE',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbClientPhone,'CLIENT_PHONE',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbScoring,'SCORING',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbDuration,'DURATION',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbComment,'ORDER_COMMENT',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbCommentType,'COMMENT_TYPE',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbAssoUnit ,'ASSO_UNIT',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbOffered ,'OFFERED',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbProjectName,'PROJECT_NAME',iosbAttributes);
        GE_BOUtilities.AddAttribute (sbStageName,'STAGE_NAME',iosbAttributes);
        GE_BOUtilities.AddAttribute ('OR_ORDER.ORDER_STATUS_ID','ORDER_STATUS_ID',iosbAttributes);
        GE_BOUtilities.AddAttribute ('OR_ORDER.OPERATING_UNIT_ID','parent_id',iosbAttributes);


    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;

        when others then
            errors.seterror;
            raise ex.CONTROLLED_ERROR;
    END FillOrderAttributes;

    PROCEDURE GetOrderById
    (
        inuOrderId     in OR_order.order_id%type,
        ocuDataCursor  out constants.tyRefCursor
    )
    IS
      sbSql                           Ge_BoUtilities.styStatement;
      sbOrderFrom                     Ge_BoUtilities.styStatement;
      sbOrderWhere                    Ge_BoUtilities.styStatement;
      sbOrderAttributes               Ge_BoUtilities.styStatement;
      sbRecordBind                    Ge_BoUtilities.styStatement;
      cuCursor                        constants.tyRefCursor;
      sbUsing                         Ge_BoUtilities.styStatement;
	  gsbORDERFrom                    Ge_BoUtilities.styStatement;
	  gsbORDERWhere                   Ge_BoUtilities.styStatement;
    BEGIN


        FillOrderAttributes(sbOrderAttributes);
        gsbORDERFrom := ' FROM OR_ORDER, GE_SUBSCRIBER, AB_ADDRESS, OR_TASK_TYPE';
        gsbORDERWhere := ' WHERE AB_ADDRESS.address_id(+) = OR_ORDER.external_address_id';
        sbOrderFrom := gsbORDERFrom;
        sbOrderWhere := gsbORDERWhere || chr(10) ||'AND GE_SUBSCRIBER.subscriber_id(+) = OR_ORDER.subscriber_id'
		                ||chr(10)||' AND OR_order.TASK_TYPE_ID=OR_TASK_TYPE.TASK_TYPE_ID'
		                ||chr(10)||' AND OR_TASK_TYPE.TASK_TYPE_CLASSIF='||cnuTaskTypeEmergen
                        ||chr(10)||' AND OR_order.ORDER_ID = :inuOrderId ';


        sbSql := 'select '|| sbOrderAttributes ||chr(10)||
                  sbOrderFrom ||chr(10)||
                   sbOrderWhere;
        open ocuDataCursor for sbSql using nvl(inuOrderId,GE_BOUtilities.csbNULLSTRING);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;

        when others then
            errors.seterror;
            raise ex.CONTROLLED_ERROR;
    END GetOrderById;


    PROCEDURE GetOrdersByOperatingUnitId
    (
        inuOperatingUnitId     in OR_order.operating_unit_id%type,
        ocuDataCursor  out constants.tyRefCursor
    )
    IS
      sbSql                           varchar2(20000);
      sbOrderFrom                     Ge_BoUtilities.styStatement;
      sbOrderWhere                    Ge_BoUtilities.styStatement;
      sbOrderAttributes               Ge_BoUtilities.styStatement;
      sbRecordBind                    Ge_BoUtilities.styStatement;
      cuCursor                        constants.tyRefCursor;
      sbUsing                         Ge_BoUtilities.styStatement;
	  gsbORDERFrom                    Ge_BoUtilities.styStatement;
	  gsbORDERWhere                   Ge_BoUtilities.styStatement;
    BEGIN

        FillOrderAttributes(sbOrderAttributes);
        --sbOrderAttributes := 'order_id, :parent_id';
        gsbORDERFrom := ' FROM OR_ORDER, GE_SUBSCRIBER, AB_ADDRESS, OR_TASK_TYPE';
        gsbORDERWhere := ' WHERE AB_ADDRESS.address_id(+) = OR_ORDER.external_address_id';
        sbOrderFrom := gsbORDERFrom;
        sbOrderWhere := gsbORDERWhere || chr(10) ||'AND GE_SUBSCRIBER.subscriber_id(+) = OR_ORDER.subscriber_id'
		                ||chr(10)||' AND OR_order.TASK_TYPE_ID=OR_TASK_TYPE.TASK_TYPE_ID'
		                ||chr(10)||' AND OR_TASK_TYPE.TASK_TYPE_CLASSIF='||cnuTaskTypeEmergen
                        ||chr(10)||' AND OR_order.OPERATING_UNIT_id = :inuOperatingUnitId ';


        sbSql := 'SELECT '|| sbOrderAttributes ||chr(10)||
                  sbOrderFrom ||chr(10)||
                   sbOrderWhere;
        open ocuDataCursor for sbSql using nvl(inuOperatingUnitId,GE_BOUtilities.csbNULLSTRING);

        --sbRecordBind := 'BEGIN Open :cuCursor for ''' || sbSql || ''' using ' || sbUsing || ';  END;';
        ut_trace.Trace(sbSql);
        --execute immediate sbRecordBind using cuCursor;
        --ocuDataCursor := cuCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;

        when others then
            errors.seterror;
            raise ex.CONTROLLED_ERROR;
    END GetOrdersByOperatingUnitId;

    PROCEDURE GetOperatingUnitByOrderId
    (
        inuOrderId     in OR_order.order_id%type,
        onuOperatingUnitId  out OR_order.operating_unit_id%type
    )
    IS
    BEGIN

        -- Valida que la orden exista
        daor_order.acckey (inuOrderId);

        -- Obtiene el dato de la unidad operativa a la que se le asigno la orden
        onuOperatingUnitId := daor_order.fnugetoperating_unit_id(inuOrderId);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;

        when others then
            errors.seterror;
            raise ex.CONTROLLED_ERROR;
    END GetOperatingUnitByOrderId;


    PROCEDURE GetContractorByOperaUnitId
    (
        inuOperatingUnitId     in or_operating_unit.operating_unit_id%type,
        onuContractorId  out or_operating_unit.contractor_id%type
    )
    IS
    BEGIN

        -- Valida que la unidad operativa exista
        daor_operating_unit.acckey (inuOperatingUnitId);

        -- Obtiene el dato del contratista de la unidad operativa
        onuContractorId := daor_operating_unit.fnugetcontractor_id(inuOperatingUnitId);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;

        when others then
            errors.seterror;
            raise ex.CONTROLLED_ERROR;
    END GetContractorByOperaUnitId;


 END  LDC_BO_IMAGENCOLOMBIA;
/

