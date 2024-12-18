create or replace PACKAGE adm_person.PKG_LDCGRIDLDCAPLAC
IS
    /*****************************************************************
    Unidad         : PKG_LDCGRIDLDCAPLAC
    Descripcion    :
    Autor          : OLSOFTWARE SAS
    Fecha          : 17/09/2019

    Historia de Modificaciones
    Fecha       Autor                       Modificacion
    =========   =========                   ====================
    23/07/2024  PAcosta                     OSF-2952: Cambio de esquema ADM_PERSON
    25/04/2024  jpinedc                     OSF-2581: * Se ajusta SendMailNotif
                                            * Se reemplaza dald_parameter.fsbGetValue_Chain
                                            por pkg_BCLD_Parameter.fsbObtieneValorCadena

    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
   /*******************************************************************************

    Unidad     :   prGetDatosMedidor
    Descripcion:   Obtiene datos del medidor a partir del codigo multifamiliar
    *******************************************************************************/
   FUNCTION prGetDatosMedidor(codMulti number)
     RETURN PKCONSTANTE.TYREFCURSOR;


    /*******************************************************************************

    Unidad     :   FrfOrdenTrabajo
    Descripcion:   Obtiene datos de la Orden de trabajo
    *******************************************************************************/
   FUNCTION FrfOrdenTrabajo(nuOrder OR_ORDER.ORDER_ID%TYPE)
     RETURN PKCONSTANTE.TYREFCURSOR;

    /*******************************************************************************

    Unidad     :   FsbGetInfoOrden
    Descripcion:   Obtiene informacion general de la orden de trabajo
    *******************************************************************************/
   FUNCTION FsbGetInfoOrden(nuOrder OR_ORDER.ORDER_ID%TYPE)
     RETURN PKCONSTANTE.TYREFCURSOR;

    /*******************************************************************************

    Unidad     :   prGetDatosItems
    Descripcion:   Obtiene datos de los Items
    *******************************************************************************/
    FUNCTION prGetDatosItems
    (
      nuOrder     IN  OR_ORDER.ORDER_ID%TYPE,
      isbFlag     IN  VARCHAR2 DEFAULT 'N'
    )

    RETURN PKCONSTANTE.TYREFCURSOR;


   /*******************************************************************************

    Unidad     :   prGetDatosItemsCoti
    Descripcion:   Obtiene datos de los items cotizados
    *******************************************************************************/
   FUNCTION prGetDatosItemsCoti
   (
        nuOrder     IN  OR_ORDER.ORDER_ID%TYPE,
        isbFlag     IN  VARCHAR2 DEFAULT 'N'
   )
     RETURN PKCONSTANTE.TYREFCURSOR;


  /*******************************************************************************

    Unidad     :   prGetPriceItems
    Descripcion:   obtiene el precio de los items
    *******************************************************************************/
    FUNCTION prGetPriceItems(nuOrder        OR_ORDER.ORDER_ID%TYPE,
                             nuItems        GE_ITEMS.ITEMS_ID%TYPE,
                             FechaExeOrd    DATE)
    return number;


   /*******************************************************************************

    Unidad     :   FsbGetUserConect
    Descripcion:   obtiene informacion del usuario conectado, si es GDC o CONT
    *******************************************************************************/
    FUNCTION FsbGetUserConect return VARCHAR2;


    /*******************************************************************************

    Unidad     :   FsbGetEstadoOraco
    Descripcion:   Se obtienen todos los datos si la orden es rechazada
    *******************************************************************************/
    FUNCTION FsbGetEstadoOraco(nuOrder    or_order.order_id%type)
    RETURN PKCONSTANTE.TYREFCURSOR;


   /*******************************************************************************

    Unidad     :   frGerOrdenTotal
    Descripcion:   Obtiene informacion de la Orden de la tabla LDC_LEGAORACO
    *******************************************************************************/
   -- funciones que obtienen la informacion de las nuevas tablas creadas para la visualizacion del funcional --
   FUNCTION frGerOrdenTotal(nuOrder OR_ORDER.ORDER_ID%TYPE)
   RETURN PKCONSTANTE.TYREFCURSOR;


   /*******************************************************************************

    Unidad     :   prGetDatosMediNew
    Descripcion:   Obtiene informacion de los medidores guardados en la nueva tabla LDC_DETAMED
    *******************************************************************************/
   FUNCTION prGetDatosMediNew(nuOrder OR_ORDER.ORDER_ID%TYPE)
   RETURN PKCONSTANTE.TYREFCURSOR;


   /*******************************************************************************

    Unidad     :   prGetDatosItemsNew
    Descripcion:   Obtiene Informacion de los Items guardados en la nueva tabla LDC_ORITEM
    *******************************************************************************/
   FUNCTION prGetDatosItemsNew
   (
        nuOrder     IN  OR_ORDER.ORDER_ID%TYPE,
        isbFlag     IN  VARCHAR2 DEFAULT 'N'
   )
   RETURN PKCONSTANTE.TYREFCURSOR;


   /*******************************************************************************

    Unidad     :   prGetDatosItemsNewCoti
    Descripcion:   Obtiene Informacion de los Items Cotizados guardados en la nueva tabla LDC_ORITEM
    *******************************************************************************/
   FUNCTION prGetDatosItemsNewCoti
   (
        nuOrder     IN  OR_ORDER.ORDER_ID%TYPE,
        isbFlag     IN  VARCHAR2 DEFAULT 'N'
   )
   RETURN PKCONSTANTE.TYREFCURSOR;


    /*******************************************************************************

    Unidad     :   LDC_PRGESTORDERCOM
    Descripcion:   Hace un insert o update a la nueva tabla de la orden
    *******************************************************************************/
    PROCEDURE LDC_PRGESTORDERCOM(nuOrder 		OR_ORDER.ORDER_ID%TYPE,
                                 nuCONTRATO 	GE_CONTRATO.ID_CONTRATO%TYPE,
                                 nuPRODUCTO 	PR_PRODUCT.PRODUCT_ID%TYPE,
                                 NURESPONSABLE	NUMBER,
                                 sbCONTRATISTA	VARCHAR2,
                                 nuCAUSAL		NUMBER,
                                 sbStatus		VARCHAR2,
                                 sbFUNCIONARIO	VARCHAR2,
                                 FechaIni       DATE,
                                 FechaFin       DATE,
                                 nuMultifam     NUMBER,
                                 coderror       out number,
                                 messerror      out varchar2);

    /*******************************************************************************

    Unidad     :   LDC_PRINSERTMEDIDOR
    Descripcion:   Hace un insert o update a la nueva tabla del medidor
    *******************************************************************************/
    PROCEDURE LDC_PRINSERTMEDIDOR(nuOrder 	  or_order.order_id%type,
                                 sbMedidor	  elmesesu.emsscoem%type,
                                 nuContrato   ge_contrato.id_contrato%type,
                                 nuDireccion  ab_address.address%type,
                                 coderror     out number,
                                 messerror    out varchar2);

    /*******************************************************************************

    Unidad     :   LDC_PRINSERITEMS
    Descripcion:   Hace un insert o update a la nueva tabla de Items
    *******************************************************************************/
    PROCEDURE LDC_PRINSERITEMS(nuOrder 	        number,
                               nuItem	        number,
                               sbDescripcion    varchar2,
                               sbType           varchar2,
                               nuCantidad       number,
                               nuValor          number,
                               nuValorTotal     number,
                               coderror         out number,
                               messerror        out varchar2);

	/*******************************************************************************

    Unidad     :   FsbGetClassCausal
    Descripcion:   Funcion que retorna la clase de causal de acuerdo al causal_id
    *******************************************************************************/
	FUNCTION FsbGetClassCausal(inuCausalId ge_causal.causal_id%type)
    return NUMBER;
    /*****************************************************************
    Unidad         : SendMailNotif
    Descripcion: Envia correos electronicos
    ******************************************************************/
    PROCEDURE SendMailNotif
    (
        inuOrderId      IN  OR_order.order_id%TYPE,
        inuFlagMess     IN  NUMBER,
        isbUseParam     IN  VARCHAR2
    );
    
    /*******************************************************************************
	Metodo: fsbEsFacturable
	Descripcion:  Retorna Y si el estado de corte es facturable, de lo contrario retorna N
    ******************************************************************/
    FUNCTION fsbEsFacturable
    (
        inuEstacorte    IN  estacort.escocodi%TYPE
    )
    RETURN VARCHAR2;
    
    /*****************************************************************
    Unidad         : GetContratosMulti
    Descripcion:   Obtiene la cantidad de multifamiliares
    ******************************************************************/
    PROCEDURE GetContratosMulti
    (
        inuOrderId          IN  OR_order.order_id%TYPE,
        inuMultivivi        IN  ldc_info_predio.multivivienda%TYPE,
        onuCantContMult     OUT NUMBER,
        onuTotaContMult     OUT NUMBER
    );
    
    /*****************************************************************
    Unidad         : getWarrantyByProduct
    Descripcion:   Obtiene la informacion de las garantias dada la orden
    ******************************************************************/
    PROCEDURE getWarrantyByProduct
    (
        inuOrderId          IN  OR_order.order_id%TYPE,
        orcDatos            OUT PKCONSTANTE.TYREFCURSOR
    );
    
    /*******************************************************************************
	Metodo: ValidateItemsByAct
	Descripcion:  Valida que los items correspondan a la actividad
    ******************************************************************/
    PROCEDURE ValidateItemsByAct
    (
        inuActivity     IN      ge_items.items_id%TYPE,
        inuItemsId      IN      ge_items.items_id%TYPE
    );
    
    /*******************************************************************************
	Metodo: CreateOrderWarranty
	Descripcion:  Crea la orden de garantias
    ******************************************************************/
    PROCEDURE CreateOrderWarranty
    (
        inuOrderId          IN  OR_order.order_id%TYPE,
        isbFlag             IN  VARCHAR2
    );
    
    /*******************************************************************************
	Metodo: GetFlagByOrder
	Descripcion:  Obtiene el flag asociado a la orden
    ******************************************************************/
    PROCEDURE GetFlagByOrder
    (
        inuOrderId     IN      OR_order.order_id%TYPE,
        osbFlag        OUT     VARCHAR2
    );
    
    /*******************************************************************************
	Metodo: InsOrUpdByOrder
	Descripcion:  Inserta o actualiza el flag de garantias
    ******************************************************************/
    PROCEDURE InsOrUpdByOrder
    (
        inuOrderId     IN      OR_order.order_id%TYPE,
        isbFlag        IN      VARCHAR2
    );


END PKG_LDCGRIDLDCAPLAC;

/

create or replace PACKAGE BODY adm_person.PKG_LDCGRIDLDCAPLAC
IS

     /*****************************************************************
    Unidad         : PKG_LDCGRIDLDCAPLAC
    Descripcion:
    Autor          : OLSOFTWARE SAS
    Fecha          : 17/09/2019

    Historia de Modificaciones
    Fecha       Autor                       Modificacion
    =========   =========                   ====================
    16-08-2021  Horbath                     CA676. Se crea  SendMailNotif
                                                            fsbEsFacturable
                                                            GetContratosMulti
                                                            ValidateItemsByAct
                                                            CreateOrderWarranty
                                                   Se modifica prGetDatosMedidor
                                                               prGetDatosMediNew
                                                               prGetDatosItems
                                                               prGetDatosItemsCoti
                                                               prGetDatosItemsNew
                                                               prGetDatosItemsNewCoti
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

      /*******************************************************************************
    Metodo: prGetDatosMedidor
    Descripcion:  Funcion que obtiene todos los medidores de acuerdo al codigo multifamiliar
                  ingresado en la forma .net LDCAPLAC

    Autor: Miguel Angel Ballesteros Gomez
    Fecha: 17/09/2019

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
	24/07/2023		jerazomvm			CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    *******************************************************************************/
   FUNCTION prGetDatosMedidor(codMulti number)
   RETURN PKCONSTANTE.TYREFCURSOR IS

    sbProceso VARCHAR2(500) := 'fcuListaVigentes';
    sbError   VARCHAR2(4000);
    cuLista   PKCONSTANTE.TYREFCURSOR;


  BEGIN

     OPEN cuLista FOR
      select  el.EMSSCOEM medidor,
                sr.sesususc contrato,
                aa.address direccion,
                sr.sesuesco codigo_estado_corte,
                sr.sesuesco||' - '|| pktblestacort.fsbgetdescription(sr.sesuesco) estado_corte
            from  ldc_info_predio li,
                  ab_premise ap,
                  ab_address aa,
                  pr_product pr,
                  elmesesu el,
                  servsusc sr
            where li.premise_id = ap.premise_id
            and   aa.estate_number = ap.premise_id
            and   pr.address_id = aa.address_id
            and   el.emsssesu = pr.product_id
            and   el.emssfere > sysdate
            and   pr.product_id = sr.sesunuse
            and   li.multivivienda = codMulti;



    RETURN cuLista;


  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
        raise PKG_ERROR.CONTROLLED_ERROR;
    when others then
        Pkg_error.setError;
        raise PKG_ERROR.CONTROLLED_ERROR;

END prGetDatosMedidor;


      /*******************************************************************************
    Metodo: FrfOrdenTrabajo
    Descripcion: trae la informacion de la cabecera del .NET al ingresar el orden

    Autor: Miguel Angel Ballesteros Gomez
    Fecha: 20/09/2019

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
	24/07/2023		jerazomvm			CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
										2. Se reemplaza la separación de cadena LDC_BOUTILITIES.SPLITSTRINGS por 
											SELECT to_number(regexp_substr(variable,
															 '[^,]+',
															 1,
															 LEVEL)) AS alias
											FROM dual
											CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL
    *******************************************************************************/
   FUNCTION FrfOrdenTrabajo(nuOrder OR_ORDER.ORDER_ID%TYPE)
   RETURN PKCONSTANTE.TYREFCURSOR IS

    sbError     	VARCHAR2(4000);
	nuLDCTTLEGA		ld_parameter.value_chain%type	:=	dald_parameter.fnugetnumeric_value('LDCTTLEGA', NULL);
    cuLista     	PKCONSTANTE.TYREFCURSOR;


  BEGIN

     OPEN cuLista FOR
        SELECT oa.product_id producto,
                   oo.task_type_id tipotrabajo,
                   oa.activity_id actividad,
                   mp.comment_ descripcion,
                   oo.order_status_id estado,
                   pr.subscription_id contrato,
                   li.multivivienda multiv
            FROM OR_ORDER OO,
                 OR_ORDER_ACTIVITY OA,
                 mo_packages mp,
                 pr_product pr,
                 or_oper_unit_persons oup,
                 elmesesu el,
                 servsusc sr,
                 ldc_info_predio li,
                 ab_premise ap,
                 ab_address aa
            WHERE oo.order_id = nuOrder
            and   oup.operating_unit_id = oo.operating_unit_id
            and   oup.person_id = ge_bopersonal.fnuGetPersonId
            and   oo.order_id = oa.order_id
            and   mp.package_id = oa.package_id
            and   pr.product_id = oa.product_id
            and   oo.order_status_id = 5
            and   li.premise_id = ap.premise_id
            and   aa.estate_number = ap.premise_id
            and   pr.address_id = aa.address_id
            and   el.emsssesu = pr.product_id
            and   el.emssfere > sysdate
            and   pr.product_id = sr.sesunuse
            and   oo.task_type_id = (SELECT to_number(regexp_substr(nuLDCTTLEGA,
													   '[^,]+',
													   1,
													   LEVEL)) AS LDCTTLEGA
									 FROM dual
									 CONNECT BY regexp_substr(nuLDCTTLEGA, '[^,]+', 1, LEVEL) IS NOT NULL);

    RETURN cuLista;

  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
        raise PKG_ERROR.CONTROLLED_ERROR;
    when others then
        Pkg_error.setError;
        raise PKG_ERROR.CONTROLLED_ERROR;

END FrfOrdenTrabajo;



          /*******************************************************************************
    Metodo: FsbGetInfoOrden
    Descripcion: Se consulta la orden de trabajo para validar si existe en la base de datos

    Autor: Miguel Angel Ballesteros Gomez
    Fecha: 20/09/2019

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
	24/07/2023		jerazomvm			CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    *******************************************************************************/
   FUNCTION FsbGetInfoOrden(nuOrder OR_ORDER.ORDER_ID%TYPE)
   RETURN PKCONSTANTE.TYREFCURSOR IS

    cuLista     PKCONSTANTE.TYREFCURSOR;


  BEGIN

     OPEN cuLista FOR
        Select
            oo.order_id orden,
            oo.order_status_id EstadoOrden,
			(select 1
				from dual
				where (dald_parameter.fnugetnumeric_value('LDCTTLEGA')) in (oo.task_type_id)) nuExisteTipoTrabajo,
            (Select 1
                from  or_oper_unit_persons oup
                where oo.order_id = nuOrder
                and   oup.operating_unit_id = oo.operating_unit_id
                and   oup.person_id = /*16535*/ge_bopersonal.fnuGetPersonId) nuExisteOP
        from or_order oo
        where oo.order_id =  nuOrder;

     RETURN cuLista;

  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
        raise PKG_ERROR.CONTROLLED_ERROR;
    when others then
        Pkg_error.setError;
        raise PKG_ERROR.CONTROLLED_ERROR;

END FsbGetInfoOrden;



      /*******************************************************************************
    Metodo: prGetDatosItems
    Descripcion:  trae los items normales

    Autor: Miguel Angel Ballesteros Gomez
    Fecha: 20/09/2019

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    16-08-2021      Horbath             CA676. Se adiciona el parametro isbFlag
	24/07/2023		jerazomvm			CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
										2. Se reemplaza la separación de cadena LDC_BOUTILITIES.SPLITSTRINGS por 
											SELECT to_number(regexp_substr(variable,
															 '[^,]+',
															 1,
															 LEVEL)) AS alias
											FROM dual
											CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL
    *******************************************************************************/      
   FUNCTION prGetDatosItems
   (
        nuOrder     IN  OR_ORDER.ORDER_ID%TYPE,
        isbFlag     IN  VARCHAR2 DEFAULT 'N'
   )
   RETURN PKCONSTANTE.TYREFCURSOR IS

    sbError          			VARCHAR2(4000);
    cuLista          			PKCONSTANTE.TYREFCURSOR;
    nuOperUnit       			or_operating_unit.operating_unit_id%type;
    nuValiOfertados  			NUMBER;
    nuActivity       			ge_items.items_id%TYPE;
	sbCod_Itemcoti_LDCRIAIC		ld_parameter.value_chain%type	:=	pkg_BCLD_Parameter.fsbObtieneValorCadena('COD_ITEMCOTI_LDCRIAIC');

    nuPrueba varchar2(100);

        Cursor ValidaOfertados(nuUnidOperati   or_operating_unit.operating_unit_id%type) is
            select 1
            from ldc_const_unoprl
            where UNIDAD_OPERATIVA = nuUnidOperati; 

  BEGIN 

     -- se obtiene la unidad operativa asignada a la orden
       SELECT operating_unit_id into nuOperUnit FROM or_order WHERE ORDER_ID  = nuOrder;

       open ValidaOfertados(nuOperUnit);
        fetch ValidaOfertados into nuValiOfertados;
       close ValidaOfertados;
       
       -- Inicia CA676
       IF isbFlag = 'Y' THEN
            nuActivity := dald_parameter.fnugetnumeric_value('LDC_ACTI_NEW_WARRANTY', NULL);
       ELSE
            nuActivity := dald_parameter.fnugetnumeric_value('LDC_ACVSI', NULL);
       END IF;
       -- Termina CA676

       -- si la unidad operativa es ofertada
       if(nuValiOfertados = 1)then

                OPEN cuLista FOR                                                                
                -- consulta para la unidad ofertada --
                select i.items_id codigo, 
                       i.description Descripcion
                from or_order o
                inner join or_task_types_items ti on o.task_type_id=ti.task_type_id
                inner join ge_items i on i.items_id=ti.items_id
                inner join ge_item_classif ic on ic.item_classif_id=i.item_classif_id 
                and ic.item_classif_id not in (2,3,8,21)
				-- si la unidad operativa es ofertada se muestran los items que esten en la tabla LDC_ITEM_UO_LR
                inner join LDC_ITEM_UO_LR l on l.unidad_operativa=o.operating_unit_id
                and l.actividad = nuActivity
                and l.item=i.items_id

                where o.order_id = nuOrder
                AND i.items_id not in (SELECT to_number(regexp_substr(sbCod_Itemcoti_LDCRIAIC,
														'[^,]+',
														1,
														LEVEL)) AS COD_ITEMCOTI_LDCRIAIC
									   FROM dual
									   CONNECT BY regexp_substr(sbCod_Itemcoti_LDCRIAIC, '[^,]+', 1, LEVEL) IS NOT NULL);


       -- si la unidad operativa no es ofertada
       else

                OPEN cuLista FOR                                                                
                -- consulta para la unidad no ofertada --
                select i.items_id codigo, 
                i.description Descripcion 
                from or_task_types_items ti            
			    inner join ge_items i on i.items_id=ti.items_id
                inner join ge_item_classif ic on ic.item_classif_id=i.item_classif_id 
				and ic.item_classif_id not in (2,3,8,21)
                where ti.task_type_id in (select g.task_type_id
                                            from or_task_types_items g
                                            where g.items_id = nuActivity)
											
				AND i.items_id not in (SELECT to_number(regexp_substr(sbCod_Itemcoti_LDCRIAIC,
														'[^,]+',
														1,
														LEVEL)) AS COD_ITEMCOTI_LDCRIAIC
									   FROM dual
									   CONNECT BY regexp_substr(sbCod_Itemcoti_LDCRIAIC, '[^,]+', 1, LEVEL) IS NOT NULL)						 
				
				-- si la unidad operativa es NO ofertada no se muestran los items que esten en la tabla LDC_ITEM_UO_LR
				and not exists(select 1 
								from LDC_ITEM_UO_LR l
								where l.item = ti.items_id );


      end if;


    RETURN cuLista;

  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
        raise PKG_ERROR.CONTROLLED_ERROR;
    when others then
        Pkg_error.setError;
        raise PKG_ERROR.CONTROLLED_ERROR;

END prGetDatosItems;


  /*******************************************************************************
    Metodo: prGetDatosItemsCoti
    Descripcion:  trae los datos de los items cotizados

    Autor: Miguel Angel Ballesteros Gomez
    Fecha: 20/09/2019

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    16-08-2021      Horbath             CA676. Se adiciona el parametro isbFlag
	24/07/2023		jerazomvm			CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
										2. Se reemplaza la separación de cadena LDC_BOUTILITIES.SPLITSTRINGS por 
											SELECT to_number(regexp_substr(variable,
															 '[^,]+',
															 1,
															 LEVEL)) AS alias
											FROM dual
											CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL
    *******************************************************************************/      
   FUNCTION prGetDatosItemsCoti
   (
        nuOrder     IN  OR_ORDER.ORDER_ID%TYPE,
        isbFlag     IN  VARCHAR2 DEFAULT 'N'
   )
   RETURN PKCONSTANTE.TYREFCURSOR IS

   sbError          			VARCHAR2(4000);
    cuLista          			PKCONSTANTE.TYREFCURSOR;
    nuOperUnit       			or_operating_unit.operating_unit_id%type;
    nuValiOfertados  			NUMBER;
    nuActivity       			ge_items.items_id%TYPE;
	sbCod_Itemcoti_LDCRIAIC		ld_parameter.value_chain%type	:=	pkg_BCLD_Parameter.fsbObtieneValorCadena('COD_ITEMCOTI_LDCRIAIC');

        Cursor ValidaOfertados(nuUnidOperati   or_operating_unit.operating_unit_id%type) is
            select 1
            from ldc_const_unoprl
            where UNIDAD_OPERATIVA = nuUnidOperati; 

  BEGIN 

     -- se obtiene la unidad operativa asignada a la orden
       SELECT operating_unit_id into nuOperUnit FROM or_order WHERE ORDER_ID  = nuOrder;

       open ValidaOfertados(nuOperUnit);
        fetch ValidaOfertados into nuValiOfertados;
       close ValidaOfertados;
       
       -- Inicia CA676
       IF isbFlag = 'Y' THEN
            nuActivity := dald_parameter.fnugetnumeric_value('LDC_ACTI_NEW_WARRANTY', NULL);
       ELSE
            nuActivity := dald_parameter.fnugetnumeric_value('LDC_ACVSI', NULL);
       END IF;
       -- Termina CA676

             -- si la unidad operativa es ofertada
       if(nuValiOfertados = 1)then

                OPEN cuLista FOR                                                                
                -- consulta para la unidad ofertada --
                select i.items_id codigo, 
                       i.description Descripcion
                from or_order o
                inner join or_task_types_items ti on o.task_type_id=ti.task_type_id
                inner join ge_items i on i.items_id=ti.items_id
                inner join ge_item_classif ic on ic.item_classif_id=i.item_classif_id 
				and ic.item_classif_id not in (2,3,8,21)
                -- si la unidad operativa es ofertada se muestran los items que esten en la tabla LDC_ITEM_UO_LR
                inner join LDC_ITEM_UO_LR l on l.unidad_operativa=o.operating_unit_id
                and l.actividad = nuActivity
                and l.item=i.items_id

                where o.order_id = nuOrder
                AND i.items_id  in (SELECT to_number(regexp_substr(sbCod_Itemcoti_LDCRIAIC,
													'[^,]+',
													1,
													LEVEL)) AS COD_ITEMCOTI_LDCRIAIC
									FROM dual
									CONNECT BY regexp_substr(sbCod_Itemcoti_LDCRIAIC, '[^,]+', 1, LEVEL) IS NOT NULL);


       -- si la unidad operativa no es ofertada
       else
				
				OPEN cuLista FOR                                                                
                -- consulta para la unidad no ofertada --
                select i.items_id codigo, 
                i.description Descripcion 
                from or_task_types_items ti            
			    inner join ge_items i on i.items_id=ti.items_id
                inner join ge_item_classif ic on ic.item_classif_id=i.item_classif_id 
				and ic.item_classif_id not in (2,3,8,21)
                where ti.task_type_id in (select g.task_type_id
                                            from or_task_types_items g
                                            where g.items_id = nuActivity)
											
				AND i.items_id  in (SELECT to_number(regexp_substr(sbCod_Itemcoti_LDCRIAIC,
													'[^,]+',
													1,
													LEVEL)) AS COD_ITEMCOTI_LDCRIAIC
									FROM dual
									CONNECT BY regexp_substr(sbCod_Itemcoti_LDCRIAIC, '[^,]+', 1, LEVEL) IS NOT NULL)							 
				
				-- si la unidad operativa es NO ofertada no se muestran los items que esten en la tabla LDC_ITEM_UO_LR
				and not exists(select 1 
								from LDC_ITEM_UO_LR l
								where l.item = ti.items_id);


      end if;


    RETURN cuLista;

    --ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso, 10);

  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
        raise PKG_ERROR.CONTROLLED_ERROR;
    when others then
        Pkg_error.setError;
        raise PKG_ERROR.CONTROLLED_ERROR;

END prGetDatosItemsCoti;



    /*******************************************************************************
    Metodo: prGetDatosItems
    Descripcion:  trae los items normales

    Autor: Miguel Angel Ballesteros Gomez
    Fecha: 20/09/2019

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
	24/07/2023		jerazomvm			CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    *******************************************************************************/
   FUNCTION prGetPriceItems(nuOrder             OR_ORDER.ORDER_ID%TYPE,
                            nuItems             GE_ITEMS.ITEMS_ID%TYPE,
                            FechaExeOrd         DATE)
   return number is

    onuCostoItem          ge_unit_cost_ite_lis.price%TYPE := 0;
    nuvalordiferencia     ge_detalle_acta.valor_total%TYPE := 0;
    onuIdListaCosto       ge_unit_cost_ite_lis.list_unitary_cost_id%TYPE := NULL;
    onuPrecioVentaItem    ge_unit_cost_ite_lis.sales_value%TYPE;
    nuPrecio              number;

    CURSOR CUGETDATOS IS
        select
               daab_address.fnugetgeograp_location_id(OA.address_id) localidad,
               op.contractor_id contratista,
               O.OPERATING_UNIT_ID und_Operativa,
               o.defined_contract_id contrato
        from   OR_ORDER O,
               OR_ORDER_ACTIVITY OA,
               OR_OPERATING_UNIT OP
        where  O.ORDER_ID = nuOrder
        and    o.order_id = oa.order_id
        and    o.operating_unit_id = op.operating_unit_id;

    rcGetDatos      CUGETDATOS%ROWTYPE;


  BEGIN

   OPEN CUGETDATOS;
   FETCH CUGETDATOS INTO rcGetDatos;
   CLOSE CUGETDATOS;

   ge_bccertcontratista.obtenercostoitemlista(
                                              nuItems,
                                              FechaExeOrd,
                                              rcGetDatos.localidad,
                                              rcGetDatos.contratista,
                                              rcGetDatos.und_Operativa,
                                              rcGetDatos.contrato,
                                              onuIdListaCosto,
                                              onuCostoItem,
                                              onuPrecioVentaItem
                                              );


     return  onuCostoItem;


     EXCEPTION
        when PKG_ERROR.CONTROLLED_ERROR then
            raise PKG_ERROR.CONTROLLED_ERROR;
        when others then
            Pkg_error.setError;
            raise PKG_ERROR.CONTROLLED_ERROR;

END prGetPriceItems;



    /*******************************************************************************
        Metodo: FsbGetUserConect
        Descripcion:  Se obtiene el usuario que esta conectado en la base de datos

        Autor: Miguel Angel Ballesteros Gomez
        Fecha: 20/09/2019

        Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================
		24/07/2023		jerazomvm			CASO OSF-1261:
											1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
        *******************************************************************************/
   FUNCTION FsbGetUserConect
   return VARCHAR2 is

    sbUsuario       varchar2(100);

    CURSOR cugetTypePerfil is
       select tp.type_user tipoUsuario
        from  ldc_perfiles p,
              LDC_TYPEPERFILES tp
        where p.type_user = tp.cod_typeperfil
        and   p.ident_user = ge_bopersonal.fnuGetPersonId
        and   p.status_user = 'Y';

    BEGIN

        if(cugetTypePerfil%isopen)then
            close cugetTypePerfil;
        end if;

        open cugetTypePerfil;
        fetch cugetTypePerfil into sbUsuario;
            if(cugetTypePerfil%notfound)then
                sbUsuario := 'NotFind';
            end if;
        close cugetTypePerfil;


        return  sbUsuario;

      EXCEPTION
        when PKG_ERROR.CONTROLLED_ERROR then
            raise PKG_ERROR.CONTROLLED_ERROR;
        when others then
            Pkg_error.setError;
            raise PKG_ERROR.CONTROLLED_ERROR;

    END FsbGetUserConect;



		/*******************************************************************************
	Metodo: FsbGetEstadoOraco
	Descripcion:  Se obtienen todos los datos si la orden es rechazada

	Autor: Miguel Angel Ballesteros Gomez
	Fecha: 06/07/2020

	Historia de Modificaciones
	Fecha             Autor             Modificacion
	=========       =========           ====================
	24/07/2023		jerazomvm			CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
	*******************************************************************************/
    FUNCTION FsbGetEstadoOraco(nuOrder OR_ORDER.ORDER_ID%TYPE)
       RETURN PKCONSTANTE.TYREFCURSOR IS

        sbError   VARCHAR2(4000);
        cuLista   PKCONSTANTE.TYREFCURSOR;

      BEGIN

         OPEN cuLista FOR
             SELECT lo.COD_CAUSAL      codCausal,
                    lo.FECHAFINEXEC     Fecha_Fin,
                    lo.FECHAINICEXEC    Fecha_Ini,
                    lo.OSB_CONTRATISTA  osbContratista,
                    lo.RESPONSABLE codResponsable,
                    lo.obs_funcionario  osbFuncionario
                FROM ldc_legaoraco lo
                WHERE lo.order_id = nuOrder
                and   lo.estado_ord = 'R';


        RETURN cuLista;


      EXCEPTION
        when PKG_ERROR.CONTROLLED_ERROR then
            raise PKG_ERROR.CONTROLLED_ERROR;
        when others then
            Pkg_error.setError;
            raise PKG_ERROR.CONTROLLED_ERROR;

    END FsbGetEstadoOraco;



      /*******************************************************************************
    Metodo: LDC_PRGESTORDERCOM
    Descripcion:  GUARDA LA INFROMACION DE LA ORDEN EN LA TABLA LDC_LEGAORACO

    Autor: Miguel Angel Ballesteros Gomez
    Fecha: 20/09/2019

    Historia de Modificaciones
    Fecha             Autor             	Modificacion
    =========       =========           	====================
	14/02/2020		Miguel Ballesteros		Se valida el causal ingresado en la forma, si es de fallo se
											legaliza la orden de forma inmediata con ese causal sin medidores
											ni items, pero si es de exito se realiza el proceso de guardado de
											la orden en la tabla y se cambia el estado a 7
	24/07/2023		jerazomvm				CASO OSF-1261:
											1. Se reemplaza el llamado del API os_legalizeorders
											   por el API api_legalizeorders.
											2. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    *******************************************************************************/

    PROCEDURE LDC_PRGESTORDERCOM(nuOrder 				    OR_ORDER.ORDER_ID%TYPE,
                                 nuCONTRATO 			    GE_CONTRATO.ID_CONTRATO%TYPE,
                                 nuPRODUCTO 			    PR_PRODUCT.PRODUCT_ID%TYPE,
                                 nuRESPONSABLE			    NUMBER,
                                 sbCONTRATISTA		        VARCHAR2,
                                 nuCAUSAL			        NUMBER,
                                 sbStatus			        VARCHAR2,
                                 sbFUNCIONARIO		        VARCHAR2,
                                 FechaIni                   DATE,
                                 FechaFin                   DATE,
                                 nuMultifam                 NUMBER,
                                 coderror                   out number,
                                 messerror                  out varchar2)IS


        nuUnidOper         		or_order.operating_unit_id%type;
        nuExist            		number := 0;
        sberror            		varchar2(3000);
        onuErrorCode       		number;
        osbErrorMessage    		varchar2(2000);
		nuClassCausalid    		ge_causal.class_causal_id%type;
		nuActividad           	or_order_activity.order_Activity_id%TYPE;
		sbNEWItems            	CLOB;
		sbDatos               	varchar2(8000);

		ERROR_LEGA_ORDEN_PADRE_FALLO      EXCEPTION;


        CURSOR CUGETCONTRATISTA IS
            select oo.operating_unit_id
            from or_order oo
            where oo.order_id = nuOrder;

        CURSOR CUVERIFIORDER IS
            select count(1)
            from LDC_LEGAORACO
            where ORDER_ID = nuOrder;

		-- cursor para validar el tipo de causal
		CURSOR cuTipoCausal (nuCausal ge_causal.CAUSAL_ID%TYPE ) IS
			SELECT DECODE(CLASS_CAUSAL_ID, 1, 1, 2, 0) tipo
			FROM ge_causal
			WHERE CAUSAL_ID = nuCausal;

		--se obtiene actividad de la orden
		CURSOR cuGetActividad(inuOrdenId or_order.order_id%type) IS
			SELECT ORDER_ACTIVITY_ID --ACTIVITY_ID
			FROM or_order_activity
			WHERE order_id = inuOrdenId;


    BEGIN
	
	ut_trace.trace('Inicia PKG_LDCGRIDLDCAPLAC.LDC_PRGESTORDERCOM nuOrder: ' 		|| nuOrder 		 || chr(10) ||
																 'nuCONTRATO: ' 	|| nuCONTRATO 	 || chr(10) ||
																 'nuPRODUCTO: ' 	|| nuPRODUCTO 	 || chr(10) ||
																 'nuRESPONSABLE: ' 	|| nuRESPONSABLE || chr(10) ||
																 'sbCONTRATISTA: ' 	|| sbCONTRATISTA || chr(10) ||
																 'nuCAUSAL: ' 		|| nuCAUSAL 	 || chr(10) ||
																 'sbStatus: ' 		|| sbStatus 	 || chr(10) ||
																 'sbFUNCIONARIO: '	|| sbFUNCIONARIO || chr(10) ||
																 'FechaIni: ' 		|| FechaIni 	 || chr(10) ||
																 'FechaFin: ' 		|| FechaFin 	 || chr(10) ||
																 'nuMultifam: ' 	|| nuMultifam, 5);

        coderror :=0;
        messerror:='Sin error';

        OPEN CUGETCONTRATISTA;
        FETCH CUGETCONTRATISTA INTO nuUnidOper;
        CLOSE CUGETCONTRATISTA;

        OPEN CUVERIFIORDER;
        FETCH CUVERIFIORDER INTO nuExist;
        CLOSE CUVERIFIORDER;

		--se obtiene actividad de la orden
		OPEN cuGetActividad(nuOrder);
		FETCH cuGetActividad INTO nuActividad;
		CLOSE cuGetActividad;

		-- se valida el tipo de causal
		OPEN cuTipoCausal(nuCausal);
		FETCH cuTipoCausal INTO nuClassCausalid;
	    CLOSE cuTipoCausal;

		IF nuClassCausalid = 0 then  -- si la causal es de fallo

			ut_trace.trace('Se inicia el proceso de legalizacion la orden padre con causal de fallo sin generar ordenes hijas VSI',10);

			sbNEWItems := NULL;

			-- se crea la cadena de legalizacion
			sbDatos := nuOrder||'|'||
						nuCausal||'|'||
						nuRESPONSABLE||'||'||
						nuActividad||'>'||nuClassCausalid||';READING>>>;SUSPENSION_TYPE>>>;;|'||
						NVL(sbNEWItems,'')||'||1277;'||
						sbCONTRATISTA;

			ut_trace.trace('Se legaliza la orden padre',10);
			
			ut_trace.trace('Ingresa api_legalizeorders isbDataOrder: '	|| sbDatos 	|| chr(10) ||
													  'idtInitDate: '	|| FechaIni || chr(10) ||
													  'idtFinalDate: '	|| FechaFin	|| chr(10) ||
													  'idtChangeDate: '	|| sysdate, 11);
			
			api_legalizeorders(sbDatos, 
							   FechaIni, 
							   FechaFin, 
							   sysdate, 
							   onuErrorCode, 
							   osbErrorMessage
							   );
			
			ut_trace.trace('Sale api_legalizeorders onuErrorCode: '			|| onuErrorCode 	|| chr(10) ||
													  'osbErrorMessage: '	|| osbErrorMessage, 11);

			IF (onuErrorCode <> 0) then
			  pkg_Traza.Trace('PresentÂ¿ un error al legalizar la orden padre',10);
			   RAISE ERROR_LEGA_ORDEN_PADRE_FALLO;

			else

				-- si no se encontro ningun error en la legalizacion de la orden con causal de fallo se procede a guardarla en la tabla
				-- LDC_LEGAORACO con estado null es para dejar registro que la orden se realizo por el proceso de la forma LDCAPLAC

				-- se actualizan las fechas de la orden que se esta procesando
				update or_order oo
				set oo.exec_initial_date = FechaIni, oo.execution_final_date = FechaFin
				where oo.order_id = nuOrder;

				-- se hace insert en la tabla LDC_LEGAORACO que guarda la informacion de la cabecera del .NET
				insert into LDC_LEGAORACO (
										 COD_LEGAORACO,
										 ORDER_ID,
										 COD_UNIDOPERATIVA,
										 COD_CONTRATO,
										 COD_PRODUCTO,
										 RESPONSABLE,
										 OSB_CONTRATISTA,
										 COD_CAUSAL,
										 ESTADO_ORD,
										 FECHAFINEXEC,
										 FECHAINICEXEC,
										 OBS_FUNCIONARIO,
										 MULTIFAM
										 )
								 values (
										 SEQ_LDC_LEGAORACO.NEXTVAL,
										 nuOrder,
										 nuUnidOper,
										 nuCONTRATO,
										 nuPRODUCTO,
										 nuRESPONSABLE,
										 sbCONTRATISTA,
										 nuCAUSAL,
										 null,
										 fechafin,
										 FechaIni,
										 sbFUNCIONARIO,
										 nuMultifam
										 );

			END IF;



		ELSE -- 1 - exito

			IF nuExist = 0 THEN
				-- se actualiza la orden en or_order a estado 7
				OS_Executiontoexecuted (nuOrder, nuCAUSAL, sysdate, onuErrorCode, osbErrorMessage);

				if(onuErrorCode <> 0)then

					coderror := onuErrorCode;
					messerror := osbErrorMessage;
					Raise PKG_ERROR.controlled_error;

				end if;

				-- se actualizan las fechas de la orden que se esta procesando
				update or_order oo
				set oo.exec_initial_date = FechaIni, oo.execution_final_date = FechaFin
				where oo.order_id = nuOrder;

				-- se hace insert en la tabla LDC_LEGAORACO que guarda la informacion de la cabecera del .NET
				insert into LDC_LEGAORACO (
										 COD_LEGAORACO,
										 ORDER_ID,
										 COD_UNIDOPERATIVA,
										 COD_CONTRATO,
										 COD_PRODUCTO,
										 RESPONSABLE,
										 OSB_CONTRATISTA,
										 COD_CAUSAL,
										 ESTADO_ORD,
										 FECHAFINEXEC,
										 FECHAINICEXEC,
										 OBS_FUNCIONARIO,
										 MULTIFAM
										 )
								 values (
										 SEQ_LDC_LEGAORACO.NEXTVAL,
										 nuOrder,
										 nuUnidOper,
										 nuCONTRATO,
										 nuPRODUCTO,
										 nuRESPONSABLE,
										 sbCONTRATISTA,
										 nuCAUSAL,
										 sbStatus,
										 fechafin,
										 FechaIni,
										 sbFUNCIONARIO,
										 nuMultifam
										 );



			ELSE

				-- se actualiza la orden en or_order a estado 7
				OS_Executiontoexecuted (nuOrder, nuCAUSAL, sysdate, onuErrorCode, osbErrorMessage);

				if(onuErrorCode <> 0)then
					coderror := onuErrorCode;
					messerror := osbErrorMessage;
					Raise PKG_ERROR.controlled_error;
				end if;

				-- se actualizan las fechas de la orden que se esta procesando
				update or_order oo
				set oo.exec_initial_date = FechaIni, oo.execution_final_date = FechaFin
				where oo.order_id = nuOrder;

				-- se elimina la orden de la tabla
				DELETE FROM LDC_LEGAORACO WHERE ORDER_ID = nuOrder;

				-- luego se vuelve a agregar la orden
				insert into LDC_LEGAORACO (
											 COD_LEGAORACO,
											 ORDER_ID,
											 COD_UNIDOPERATIVA,
											 COD_CONTRATO,
											 COD_PRODUCTO,
											 RESPONSABLE,
											 OSB_CONTRATISTA,
											 COD_CAUSAL,
											 ESTADO_ORD,
											 FECHAFINEXEC,
											 FECHAINICEXEC,
											 OBS_FUNCIONARIO,
											 MULTIFAM
											 )
									 values (
											 SEQ_LDC_LEGAORACO.NEXTVAL,
											 nuOrder,
											 nuUnidOper,
											 nuCONTRATO,
											 nuPRODUCTO,
											 nuRESPONSABLE,
											 sbCONTRATISTA,
											 nuCAUSAL,
											 sbStatus,
											 fechafin,
											 FechaIni,
											 sbFUNCIONARIO,
											 nuMultifam
											 );


			END IF;


		END IF; --- FIN IF nuClassCausalid = 0

	ut_trace.trace('Finaliza PKG_LDCGRIDLDCAPLAC.LDC_PRGESTORDERCOM coderror: ' 	|| coderror	|| chr(10) ||
																   'messerror: '	|| messerror, 5);
																   
        commit;

	 EXCEPTION
            when PKG_ERROR.CONTROLLED_ERROR then
				ut_trace.trace('PKG_LDCGRIDLDCAPLAC.LDC_PRGESTORDERCOM PKG_ERROR.CONTROLLED_ERROR', 5);
				rollback;
				sberror:=sqlerrm;
				coderror:=-1;
				messerror:='Error guardando informacion de la orden # '||to_char(nuOrder)||'. '||substr(sberror,1,100);
            WHEN ERROR_LEGA_ORDEN_PADRE_FALLO THEN
				ut_trace.trace('PKG_LDCGRIDLDCAPLAC.LDC_PRGESTORDERCOM ERROR_LEGA_ORDEN_PADRE_FALLO', 5);
				ROLLBACK;
				coderror    := onuErrorCode;
				messerror   := 'Error legalizando orden con causal de fallo '||to_char(coderror)||'. '||substr(osbErrorMessage,1,100);
			when others then
				ut_trace.trace('PKG_LDCGRIDLDCAPLAC.LDC_PRGESTORDERCOM others', 5);
                rollback;
				sberror:=sqlerrm;
				coderror:=-1;
                messerror:='Error guardando informacion de la orden # '||to_char(nuOrder)||'. '||substr(sberror,1,100);


    END LDC_PRGESTORDERCOM;


          /*******************************************************************************
        Metodo: LDC_PRINSERTMEDIDOR
        Descripcion:  valida el tipo de periodo

        Autor: Miguel Angel Ballesteros Gomez
        Fecha: 20/09/2019

        Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================

        *******************************************************************************/

    PROCEDURE LDC_PRINSERTMEDIDOR(nuOrder 				    or_order.order_id%type,
                                 sbMedidor	                elmesesu.emsscoem%type,
                                 nuContrato 			    ge_contrato.id_contrato%type,
                                 nuDireccion                ab_address.address%type,
                                 coderror                   out number,
                                 messerror                  out varchar2)IS

    sberror            varchar2(3000);
    nuExist             number := 0;

    CURSOR CUVERIFIMED IS
            select COUNT(1)
            from LDC_DETAMED
            where ORDER_ID = nuOrder
            and  COD_CONTRATO = nuContrato;

    BEGIN

        coderror :=0;
        messerror:='Sin error';

        OPEN CUVERIFIMED;
        FETCH CUVERIFIMED INTO nuExist;
        CLOSE CUVERIFIMED;

        IF nuExist = 0 THEN
            -- se hace insert en la tabla LDC_DETAMED que guarda la informacion de los medidores seleccionados
            insert into LDC_DETAMED (
                                     COD_DETAMED,
                                     ORDER_ID,
                                     COD_MEDIDOR,
                                     COD_CONTRATO,
                                     DIRECCION
                                     )
                             values (
                                     SEQ_LDC_DETAMED.NEXTVAL,
                                     nuOrder,
                                     sbMedidor,
                                     nuContrato,
                                     nuDireccion
                                     );
         ELSE
            -- se elimina toda la informacion de los medidores relacionadas con esa orden
            delete from LDC_DETAMED where ORDER_ID = nuOrder;

            -- luego se hace el insert en la tabla con los nuevos medidores
            insert into LDC_DETAMED (
                                     COD_DETAMED,
                                     ORDER_ID,
                                     COD_MEDIDOR,
                                     COD_CONTRATO,
                                     DIRECCION
                                     )
                             values (
                                     SEQ_LDC_DETAMED.NEXTVAL,
                                     nuOrder,
                                     sbMedidor,
                                     nuContrato,
                                     nuDireccion
                                     );

        END IF;

        commit;

       EXCEPTION
     when others then
          rollback;
          sberror:=sqlerrm;
          coderror:=-1;
          messerror:='Error guardando informacion de los medidores # '||sbMedidor||'. '||substr(sberror,1,100);


    END LDC_PRINSERTMEDIDOR;


          /*******************************************************************************
        Metodo: LDC_PRINSERITEMS
        Descripcion:  valida el tipo de periodo

        Autor: Miguel Angel Ballesteros Gomez
        Fecha: 20/09/2019

        Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================

        *******************************************************************************/

    PROCEDURE LDC_PRINSERITEMS(nuOrder 	        number,
                               nuItem	        number,
                               sbDescripcion    varchar2,
                               sbType           varchar2,
                               nuCantidad 		number,
                               nuValor          number,
                               nuValorTotal     number,
                               coderror         out number,
                               messerror        out varchar2)IS


    sberror            varchar2(3000);
    nuExist             number := 0;

    CURSOR CUVERIFITEM IS
            select COUNT(1)
            from LDC_ORITEM
            where ORDER_ID = nuOrder
            and COD_ITEM = nuItem;

    BEGIN

        coderror :=0;
        messerror:='Sin error';

        OPEN CUVERIFITEM;
        FETCH CUVERIFITEM INTO nuExist;
        CLOSE CUVERIFITEM;

        IF nuExist = 0 THEN
        -- se hace insert en la tabla LDC_ORITEM que guarda la informacion de los items seleccionados
        insert into LDC_ORITEM  (
                                 COD_ORITEM,
                                 ORDER_ID,
                                 COD_ITEM,
                                 DESCRIPCION,
                                 TYPE_ITEMS,
                                 CANTIDAD,
                                 VALOR,
                                 VALORTOTAL
                                 )
                         values (
                                 SEQ_LDC_ORITEM.NEXTVAL,
                                 nuOrder,
                                 nuItem,
                                 sbDescripcion,
                                 sbType,
                                 nuCantidad,
                                 nuValor,
                                 nuValorTotal
                                 );
        ELSE

            -- se elimina la informacion del item en la tabla de acuerdo a la orden
            DELETE FROM LDC_ORITEM WHERE ORDER_ID = nuOrder;

            -- se hace el insert en la tabla
            insert into LDC_ORITEM  (
                                 COD_ORITEM,
                                 ORDER_ID,
                                 COD_ITEM,
                                 DESCRIPCION,
                                 TYPE_ITEMS,
                                 CANTIDAD,
                                 VALOR,
                                 VALORTOTAL
                                 )
                         values (
                                 SEQ_LDC_ORITEM.NEXTVAL,
                                 nuOrder,
                                 nuItem,
                                 sbDescripcion,
                                 sbType,
                                 nuCantidad,
                                 nuValor,
                                 nuValorTotal
                                 );

        END IF;

    commit;

    EXCEPTION
     when others then
          rollback;
          sberror:=sqlerrm;
          coderror:=-1;
          messerror:='Error guardando informacion de los Items # '||to_char(nuExist)||'. '||substr(sberror,1,100);


    END LDC_PRINSERITEMS;




    /*******************************************************************************
    Metodo: frGerOrdenTotal
    Descripcion: trae la informacion de la orden que se gestiono en el .NET LDCAPLAC para cargarla en la forma

    Autor: Miguel Angel Ballesteros Gomez
    Fecha: 20/09/2019

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
	24/07/2023		jerazomvm			CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    *******************************************************************************/
   FUNCTION frGerOrdenTotal(nuOrder OR_ORDER.ORDER_ID%TYPE)
   RETURN PKCONSTANTE.TYREFCURSOR IS

    sbError   VARCHAR2(4000);
    cuLista   PKCONSTANTE.TYREFCURSOR;

  BEGIN

     OPEN cuLista FOR
         SELECT  lo.COD_CAUSAL  codCausal,
                lo.COD_CONTRATO codContrato,
                lo.COD_PRODUCTO  codProduct,
                lo.FECHAFINEXEC   Fecha_Fin,
                lo.FECHAINICEXEC  Fecha_Ini,
                lo.OSB_CONTRATISTA  osbContratista,
                --lo.RESPONSABLE    codResponsable,
                dage_person.fsbgetname_(lo.RESPONSABLE, null) codResponsable,
                lo.MULTIFAM       nuMultifam,
                oo.task_type_id  tipotrabajo,
                oa.activity_id   actividad,
                mp.comment_ descripcion,
                oo.order_status_id estado
            FROM ldc_legaoraco lo,
                 or_order oo,
                 or_order_activity oa,
                 mo_packages mp
            WHERE lo.order_id = nuOrder
            and   oo.order_id = lo.order_id
            and   oa.order_id = oo.order_id
            and   mp.package_id = oa.package_id
            and   lo.estado_ord = 'P';


    RETURN cuLista;


  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
        raise PKG_ERROR.CONTROLLED_ERROR;
    when others then
        Pkg_error.setError;
        raise PKG_ERROR.CONTROLLED_ERROR;

END frGerOrdenTotal;




      /*******************************************************************************
    Metodo: prGetDatosMediNew
    Descripcion:  Funcion que obtiene todos los medidores en la nueva tabla creada ldc_detamed

    Autor: Miguel Angel Ballesteros Gomez
    Fecha: 17/09/2019

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    16-08-2021      Horbath             CA676. Se modifica para obtener el estado de corte
	24/07/2023		jerazomvm			CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    *******************************************************************************/      
   FUNCTION prGetDatosMediNew(nuOrder OR_ORDER.ORDER_ID%TYPE) 
   RETURN PKCONSTANTE.TYREFCURSOR IS

    cuLista   PKCONSTANTE.TYREFCURSOR;

  BEGIN 

     OPEN cuLista FOR        
        SELECT  distinct med.COD_CONTRATO  contrato,
                med.COD_MEDIDOR   medidor,
                med.DIRECCION     direccion,
                a.sesunuse,
                pktblservsusc.fnugetsesuesco(a.sesunuse) codigo_estado_corte,
                pktblservsusc.fnugetsesuesco(a.sesunuse) ||' - '||pktblestacort.fsbgetdescription(pktblservsusc.fnugetsesuesco(a.sesunuse)) estado_corte
            FROM    ldc_detamed med,
                    servsusc a
            WHERE   med.order_id = nuOrder
            AND     med.cod_contrato = a.sesususc
            AND    a.sesuserv = 7014;

    RETURN cuLista;


  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
        raise PKG_ERROR.CONTROLLED_ERROR;
    when others then
        Pkg_error.setError;
        raise PKG_ERROR.CONTROLLED_ERROR;

END prGetDatosMediNew;



      /*******************************************************************************
    Metodo: prGetDatosItemsNew
    Descripcion:  Funcion que obtiene todos los Items Normales de la nueva tabla

    Autor: Miguel Angel Ballesteros Gomez
    Fecha: 17/09/2019

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    16-08-2021      Horbath             CA676. Se adiciona el parametro isbFlag y
                                               el llamado al servicio ValidateItemsByAct
	24/07/2023		jerazomvm			CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    *******************************************************************************/      
   FUNCTION prGetDatosItemsNew
   (
        nuOrder     IN  OR_ORDER.ORDER_ID%TYPE,
        isbFlag     IN  VARCHAR2 DEFAULT 'N'
   )
   RETURN PKCONSTANTE.TYREFCURSOR
   IS

    cuLista     PKCONSTANTE.TYREFCURSOR;
    nuActivity  ge_items.items_id%TYPE;
    
    CURSOR cuItems
    IS
        SELECT  ori.COD_ITEM     nuItem,
            ori.Descripcion  sbDescripcion,
            ori.CANTIDAD     nuCantidad,
            ori.VALOR        nuValor,
            ori.VALORTOTAL   nuValorTotal
        FROM ldc_oritem ori
        WHERE ori.order_id = nuOrder
        and  ori.type_items = 'N';


  BEGIN 

    -- Inicia CA676
    IF isbFlag = 'Y' THEN
        nuActivity := dald_parameter.fnugetnumeric_value('LDC_ACTI_NEW_WARRANTY', NULL);
    ELSE
        nuActivity := dald_parameter.fnugetnumeric_value('LDC_ACVSI', NULL);
    END IF;

    FOR rcItem IN cuItems LOOP
        ValidateItemsByAct(nuActivity, rcItem.nuItem);
    END LOOP;
    -- Termina CA676

    OPEN cuLista FOR
        SELECT  ori.COD_ITEM     nuItem,
            ori.Descripcion  sbDescripcion,
            ori.CANTIDAD     nuCantidad,
            ori.VALOR        nuValor,
            ori.VALORTOTAL   nuValorTotal
        FROM ldc_oritem ori
        WHERE ori.order_id = nuOrder
        and  ori.type_items = 'N';

    RETURN cuLista;


  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
        raise PKG_ERROR.CONTROLLED_ERROR;
    when others then
        Pkg_error.setError;
        raise PKG_ERROR.CONTROLLED_ERROR;

END prGetDatosItemsNew;


     /*******************************************************************************
    Metodo: prGetDatosItemsNewCoti
    Descripcion:  Funcion que obtiene todos los Items cotizados de la nueva tabla

    Autor: Miguel Angel Ballesteros Gomez
    Fecha: 17/09/2019

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    16-08-2021      Horbath             CA676. Se adiciona el parametro isbFlag y
                                               el llamado al servicio ValidateItemsByAct
	24/07/2023		jerazomvm			CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    *******************************************************************************/      
   FUNCTION prGetDatosItemsNewCoti
   (
        nuOrder     IN  OR_ORDER.ORDER_ID%TYPE,
        isbFlag     IN  VARCHAR2 DEFAULT 'N'
   )
   RETURN PKCONSTANTE.TYREFCURSOR IS

        cuLista   PKCONSTANTE.TYREFCURSOR;
        nuActivity  ge_items.items_id%TYPE;

        CURSOR cuItems
        IS
            SELECT  ori.COD_ITEM     nuItem,
            ori.Descripcion  sbDescripcion,
            ori.CANTIDAD     nuCantidad,
            ori.VALOR        nuValor,
            ori.VALORTOTAL   nuValorTotal
        FROM ldc_oritem ori
        WHERE ori.order_id = nuOrder
        and  ori.type_items = 'C';

    BEGIN

     -- Inicia CA676
    IF isbFlag = 'Y' THEN
        nuActivity := dald_parameter.fnugetnumeric_value('LDC_ACTI_NEW_WARRANTY', NULL);
    ELSE
        nuActivity := dald_parameter.fnugetnumeric_value('LDC_ACVSI', NULL);
    END IF;

    FOR rcItem IN cuItems LOOP
        ValidateItemsByAct(nuActivity, rcItem.nuItem);
    END LOOP;
    -- Termina CA676


     OPEN cuLista FOR        
        SELECT  ori.COD_ITEM     nuItem,
            ori.Descripcion  sbDescripcion,
            ori.CANTIDAD     nuCantidad,
            ori.VALOR        nuValor,
            ori.VALORTOTAL   nuValorTotal         
        FROM ldc_oritem ori
        WHERE ori.order_id = nuOrder
        and  ori.type_items = 'C';

    RETURN cuLista;


  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
        raise PKG_ERROR.CONTROLLED_ERROR;
    when others then
        Pkg_error.setError;
        raise PKG_ERROR.CONTROLLED_ERROR;

	END prGetDatosItemsNewCoti;


	/*******************************************************************************
	Metodo: FsbGetClassCausal
	Descripcion:  Se obtiene la clase de causal de acuerdo al causal_id

	Autor: Miguel Angel Ballesteros Gomez
	Fecha: 08/06/2020

	Historia de Modificaciones
	Fecha             Autor             Modificacion
	=========       =========           ====================
	24/07/2023		jerazomvm			CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
	*******************************************************************************/
   FUNCTION FsbGetClassCausal(inuCausalId ge_causal.causal_id%type)
   return NUMBER is

    nuClassCausal       number;

    BEGIN

	select gc.class_causal_id into nuClassCausal
	from ge_causal g,
		 ge_class_causal gc
	where g.class_causal_id = gc.class_causal_id
	and   g.causal_id = inuCausalId;


    return  nuClassCausal;

    EXCEPTION
	  when PKG_ERROR.CONTROLLED_ERROR then
		  raise PKG_ERROR.CONTROLLED_ERROR;
	  when others then
		  Pkg_error.setError;
		  raise PKG_ERROR.CONTROLLED_ERROR;

    END FsbGetClassCausal;

    /*****************************************************************
    Unidad         : SendMailNotif
    Descripcion:   Envia correos electronicos
    Autor          : Horbath
    Fecha          : 16-08-2021
    
    Parametros:   isbFlagMess = 1 cuando se ejecuto la orden correctamente
                  isbFlagMess = 2 cuando se aprobo la orden correctamente
                  isbFlagMess = 3 cuando se rechazo la orden correctamente
                  
    Historia de Modificaciones
    Fecha       Autor               Modificacion
    =========   =========           ====================
    16-08-2021  Horbath             CA676. Creacion
	24/07/2023	jerazomvm			CASO OSF-1261:
									1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    25/04/2024  jpinedc             OSF-2581: Se usa pkg_Correo en lugar de ldc_sendemail
                                    2. Se quita la evalución de flbAplicaEntregaxCaso
    ******************************************************************/
    PROCEDURE SendMailNotif
    (
        inuOrderId      IN  OR_order.order_id%TYPE,
        inuFlagMess     IN  NUMBER,
        isbUseParam     IN  VARCHAR2
    )
    IS

        sbToMess        ld_parameter.value_chain%TYPE;
        sbMessage       ld_parameter.value_chain%TYPE;
        sbSubject       ld_parameter.value_chain%TYPE := 'Respuesta legalización LDCAPLAC';
        tbEmails        ut_string.tytb_string;
        nuIndex         NUMBER;
        nuOperUnitId    or_operating_unit.operating_unit_id%TYPE;
        
        sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');

    BEGIN
        pkg_Traza.Trace('Inicia PKG_LDCGRIDLDCAPLAC.SendMailNotif',15);
        
        pkg_Traza.Trace('inuOrderId|'|| inuOrderId,15);
        pkg_Traza.Trace('inuFlagMess|'|| inuFlagMess,15);        
        pkg_Traza.Trace('isbUseParam|'|| isbUseParam,15);
                
        nuOperUnitId := daor_order.fnugetoperating_unit_id(inuOrderId,0);

        pkg_Traza.Trace('nuOperUnitId|'|| nuOperUnitId,15);
       
        -- Si el flag isbUseParam, se utilizan los destinatarios del parametro LDC_EMAIL_REG_NOTIF
        IF isbUseParam = 'Y' THEN
            sbToMess := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_EMAIL_REG_NOTIF');
        ELSE
            sbToMess := daor_operating_unit.fsbgete_mail(nuOperUnitId, 0);
        END IF;

        pkg_Traza.Trace('sbToMess|'|| sbToMess,15);
        
        IF inuFlagMess = 1 THEN
            sbMessage := 'Han ingresado la orden '||inuOrderId||' de la unidad '||nuOperUnitId||' a LDCPLAC para su aprobación o rechazo';
        ELSIF inuFlagMess = 2 THEN
            sbMessage := 'La orden '||inuOrderId||' ha sido Aprobada en la forma LDCPLAC';
        ELSIF inuFlagMess = 3 THEN
            sbMessage := 'La orden '||inuOrderId||' ha sido Rechazada en la forma LDCPLAC';
        END IF;

        pkg_Traza.Trace('sbMessage|'|| sbMessage,15);
        
        ut_string.extstring(sbToMess, ',' , tbEmails);

        nuIndex := tbEmails.first;
        
        LOOP
            EXIT WHEN nuIndex IS NULL;
            
            IF tbEmails(nuIndex) IS NOT NULL THEN
                
                pkg_Correo.prcEnviaCorreo
                (
                    isbRemitente        => sbRemitente,
                    isbDestinatarios    => tbEmails(nuIndex),
                    isbAsunto           => sbSubject,
                    isbMensaje          => sbMessage
                );        
                                        
            END IF;
            nuIndex := tbEmails.NEXT(nuIndex);
        
        END LOOP;

       pkg_Traza.Trace('Fin PKG_LDCGRIDLDCAPLAC.SendMailNotif',15);

    EXCEPTION
	  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		  RAISE PKG_ERROR.CONTROLLED_ERROR;
	  WHEN others THEN
		  Pkg_error.setError;
		  RAISE PKG_ERROR.CONTROLLED_ERROR;
    END SendMailNotif;
    
    /*******************************************************************************
	Metodo: fsbEsFacturable
	Descripcion:  Retorna Y si el estado de corte es facturable, de lo contrario retorna N

    Autor          : Horbath
    Fecha          : 16-08-2021

    Historia de Modificaciones
    Fecha       Autor               Modificacion
    =========   =========           ====================
    16-08-2021  Horbath             CA676. Creacion
	24/07/2023	jerazomvm			CASO OSF-1261:
									1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    ******************************************************************/
    FUNCTION fsbEsFacturable
    (
        inuEstacorte    IN  estacort.escocodi%TYPE
    )
    RETURN VARCHAR2
    IS
        CURSOR cuEstado
        IS
            SELECT coecfact
            FROM estacort, confesco
            WHERE coeccodi = escocodi
            AND escocodi = inuEstacorte
            AND coecserv = 7014;


        sbEsFacturable  VARCHAR2(1);

    BEGIN
       pkg_Traza.Trace('Inicia PKG_LDCGRIDLDCAPLAC.fsbEsFacturable',15);

        OPEN cuEstado;
        FETCH cuEstado INTO sbEsFacturable;
        CLOSE cuEstado;
        
        IF sbEsFacturable = 'S' THEN
           pkg_Traza.Trace('Fin PKG_LDCGRIDLDCAPLAC.fsbEsFacturable - RETURN: Y',15);
            RETURN  'Y';
        ELSE
           pkg_Traza.Trace('Fin PKG_LDCGRIDLDCAPLAC.fsbEsFacturable - RETURN: N',15);
            RETURN  'N';
        END IF;

    EXCEPTION
      WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		  RAISE PKG_ERROR.CONTROLLED_ERROR;
	  WHEN others THEN
		  Pkg_error.setError;
		  RAISE PKG_ERROR.CONTROLLED_ERROR;

    END fsbEsFacturable;
    
    /*****************************************************************
    Unidad         : GetContratosMulti
    Descripcion:   Obtiene la cantidad de multifamiliares
    Autor          : Horbath
    Fecha          : 16-08-2021

    Historia de Modificaciones
    Fecha       Autor                       Modificacion
    =========   =========                   ====================
    16-08-2021  Horbath                     CA676. Creacion
	24/07/2023	jerazomvm					CASO OSF-1261:
											1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    ******************************************************************/
    PROCEDURE GetContratosMulti
    (
        inuOrderId          IN  OR_order.order_id%TYPE,
        inuMultivivi        IN  ldc_info_predio.multivivienda%TYPE,
        onuCantContMult     OUT NUMBER,
        onuTotaContMult     OUT NUMBER
    )
    IS

        CURSOR cuCantidad
        IS
            SELECT count(1)
            FROM LDC_DETAMED
            WHERE order_id = inuOrderId;
            
        CURSOR cuCantTotal
        IS
            select  count(1)
            from  ldc_info_predio li,
                  ab_premise ap,
                  ab_address aa,
                  pr_product pr,
                  elmesesu el,
                  servsusc sr
            where li.premise_id = ap.premise_id
            and   aa.estate_number = ap.premise_id
            and   pr.address_id = aa.address_id
            and   el.emsssesu = pr.product_id
            and   el.emssfere > sysdate
            and   pr.product_id = sr.sesunuse
            and   li.multivivienda = inuMultivivi;


    BEGIN
       pkg_Traza.Trace('Inicia PKG_LDCGRIDLDCAPLAC.GetContratosMulti',15);

        OPEN cuCantidad;
        FETCH cuCantidad INTO onuCantContMult;
        CLOSE cuCantidad;
        
        OPEN cuCantTotal;
        FETCH cuCantTotal INTO onuTotaContMult;
        CLOSE cuCantTotal;
        
       pkg_Traza.Trace('Fin PKG_LDCGRIDLDCAPLAC.GetContratosMulti - onuCantContMult: '||onuCantContMult||' onuTotaContMult: '||onuTotaContMult,15);

    EXCEPTION
	  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		  RAISE PKG_ERROR.CONTROLLED_ERROR;
	  WHEN others THEN
		  Pkg_error.setError;
		  RAISE PKG_ERROR.CONTROLLED_ERROR;
    END GetContratosMulti;
    
    /*****************************************************************
    Unidad         : getWarrantyByProduct
    Descripcion:   Obtiene la informacion de las garantias dada la orden
    Autor          : Horbath
    Fecha          : 16-08-2021

    Historia de Modificaciones
    Fecha       Autor                       Modificacion
    =========   =========                   ====================
    16-08-2021  Horbath                     CA676. Creacion
	24/07/2023	jerazomvm					CASO OSF-1261:
											1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
											2. Se reemplaza la separación de cadena LDC_BOUTILITIES.SPLITSTRINGS por 
												SELECT to_number(regexp_substr(variable,
																'[^,]+',
																1,
																LEVEL)) AS alias
												FROM dual
												CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL
    ******************************************************************/
    PROCEDURE getWarrantyByProduct
    (
        inuOrderId          IN  OR_order.order_id%TYPE,
        orcDatos            OUT PKCONSTANTE.TYREFCURSOR
    )
    IS
        nuMulti         			ldc_info_predio.multivivienda%TYPE;
        dtFechaProceso  			ge_item_warranty.final_warranty_date%TYPE;
        nuProuductId    			or_order_activity.product_id%TYPE;
		nuLDCTTLEGA					ld_parameter.value_chain%type	:=	dald_parameter.fnugetnumeric_value('LDCTTLEGA', NULL);
		sbLdc_Task_Type_Warranty	ld_parameter.value_chain%type	:=	pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_TASK_TYPE_WARRANTY');

        CURSOR cuMultifamiliar
        IS
            SELECT
                   li.multivivienda multiv,
                   oa.product_id
            FROM OR_ORDER OO,
                 OR_ORDER_ACTIVITY OA,
                 mo_packages mp,
                 pr_product pr,
                 ldc_info_predio li,
                 ab_premise ap,
                 ab_address aa
            WHERE oo.order_id = inuOrderId
            and   oo.order_id = oa.order_id
            and   mp.package_id = oa.package_id
            and   pr.product_id = oa.product_id
            and   li.premise_id = ap.premise_id
            and   aa.estate_number = ap.premise_id
            and   pr.address_id = aa.address_id
            and   oo.task_type_id = (SELECT to_number(regexp_substr(nuLDCTTLEGA,
									     			   '[^,]+',
													   1,
													   LEVEL)) AS LDCTTLEGA
									 FROM dual
									 CONNECT BY regexp_substr(nuLDCTTLEGA, '[^,]+', 1, LEVEL) IS NOT NULL)
            AND rownum = 1;

    BEGIN
       pkg_Traza.Trace('Inicia PKG_LDCGRIDLDCAPLAC.getWarrantyByProduct',15);


        OPEN cuMultifamiliar;
        FETCH cuMultifamiliar INTO nuMulti, nuProuductId;
        CLOSE cuMultifamiliar;

        dtFechaProceso := daor_order.fdtgetexecution_final_date(inuOrderId,0);
        
        IF dtFechaProceso IS NULL THEN
            dtFechaProceso := ut_date.fdtsysdate;
        END IF;

        OPEN orcDatos FOR
            SELECT  gw.item_id||' - '|| dage_items.fsbgetdescription(gw.item_id,0) item,
                    gw.product_id producto,
                    gw.final_warranty_date valido_hasta,
                    gw.is_active activo
            FROM ge_item_warranty gw
            WHERE gw.product_id IN (SELECT
                                            distinct p.product_id
                                            FROM OR_order ot, ab_address ab, ldc_info_predio ld, pr_product p
                                            WHERE ot.external_address_id = ab.address_id
                                            AND ab.estate_number = ld.premise_id
                                            AND ab.address_id = p.address_id
                                            AND p.product_type_id = 7014
                                            AND ld.multivivienda = nuMulti
                                            AND ot.task_type_id = (SELECT to_number(regexp_substr(sbLdc_Task_Type_Warranty,
																					'[^,]+',
																					1,
																					LEVEL)) AS LDC_TASK_TYPE_WARRANTY
																   FROM dual
																   CONNECT BY regexp_substr(sbLdc_Task_Type_Warranty, '[^,]+', 1, LEVEL) IS NOT NULL)
                                            AND p.product_id = nuProuductId)
            AND gw.final_warranty_date > dtFechaProceso;

       pkg_Traza.Trace('Fin PKG_LDCGRIDLDCAPLAC.getWarrantyByProduct',15);

    EXCEPTION
	  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		  RAISE PKG_ERROR.CONTROLLED_ERROR;
	  WHEN others THEN
		  Pkg_error.setError;
		  RAISE PKG_ERROR.CONTROLLED_ERROR;
    END getWarrantyByProduct;
    
    /*******************************************************************************
	Metodo: ValidateItemsByAct
	Descripcion:  Valida que los items correspondan a la actividad

    Autor          : Horbath
    Fecha          : 16-08-2021

    Historia de Modificaciones
    Fecha       Autor                       Modificacion
    =========   =========                   ====================
    16-08-2021  Horbath                     CA676. Creacion
	24/07/2023	jerazomvm					CASO OSF-1261:
											1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    ******************************************************************/
    PROCEDURE ValidateItemsByAct
    (
        inuActivity     IN      ge_items.items_id%TYPE,
        inuItemsId      IN      ge_items.items_id%TYPE
    )
    IS
        sbValor     VARCHAR2(1);

        CURSOR cuDatosOrden
        IS
            SELECT 'Y'
            FROM   LDC_ITEM_UO_LR
            WHERE  actividad = inuActivity
            AND    item = inuItemsId;

    BEGIN
       pkg_Traza.Trace('Inicia PKG_LDCGRIDLDCAPLAC.ValidateItemsByAct',15);

        OPEN cuDatosOrden;
        FETCH cuDatosOrden INTO sbValor;
        CLOSE cuDatosOrden;
        
        IF sbValor IS NULL THEN
            Pkg_error.SetErrorMessage(2741,'No existe configuración del ítem ['||inuItemsId||'] con la actividad ['||inuActivity||']');
            raise PKG_ERROR.CONTROLLED_ERROR;
        END IF;


       pkg_Traza.Trace('Fin PKG_LDCGRIDLDCAPLAC.ValidateItemsByAct',15);

    EXCEPTION
	  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		  RAISE PKG_ERROR.CONTROLLED_ERROR;
	  WHEN others THEN
		  Pkg_error.setError;
		  RAISE PKG_ERROR.CONTROLLED_ERROR;
    END ValidateItemsByAct;
    
    /*******************************************************************************
	Metodo: CreateOrderWarranty
	Descripcion:  Crea la orden de garantias

    Autor          : Horbath
    Fecha          : 16-08-2021

    Historia de Modificaciones
    Fecha       Autor                       Modificacion
    =========   =========                   ====================
    16-08-2021  Horbath                     CA676. Creacion
	24/07/2023	jerazomvm					CASO OSF-1261:
											1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    ******************************************************************/
    PROCEDURE CreateOrderWarranty
    (
        inuOrderId          IN  OR_order.order_id%TYPE,
        isbFlag             IN  VARCHAR2
    )
    IS
        nuActivity      ge_items.items_id%TYPE;
        nuAddressId     OR_order.external_address_id%TYPE;
        nuOrderId       OR_order.order_id%TYPE;
        nuErrorCode     ge_message.message_id%TYPE;
        sbErrorMessa    ge_message.description%TYPE;
        rcOrderActi     or_order_activity%ROWTYPE;
        
        CURSOR cuDatosOrden
        IS
            SELECT *
            FROM or_order_activity
            WHERE ORDER_id = inuOrderId;


    BEGIN
        null;

    EXCEPTION
	  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		  RAISE PKG_ERROR.CONTROLLED_ERROR;
	  WHEN others THEN
		  Pkg_error.setError;
		  RAISE PKG_ERROR.CONTROLLED_ERROR;
    END CreateOrderWarranty;
    
    /*******************************************************************************
	Metodo: GetFlagByOrder
	Descripcion:  Obtiene el flag asociado a la orden

    Autor          : Horbath
    Fecha          : 16-08-2021

    Historia de Modificaciones
    Fecha       Autor                       Modificacion
    =========   =========                   ====================
    16-08-2021  Horbath                     CA676. Creacion
	24/07/2023	jerazomvm					CASO OSF-1261:
											1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    ******************************************************************/
    PROCEDURE GetFlagByOrder
    (
        inuOrderId     IN      OR_order.order_id%TYPE,
        osbFlag        OUT     VARCHAR2
    )
    IS
        sbValor     VARCHAR2(1);

        CURSOR cuDatosOrden
        IS
            SELECT NVL(flag_garant, 'N')
            FROM   LDC_FLAG_GARANTIA
            WHERE  order_id = inuOrderId;

    BEGIN
       pkg_Traza.Trace('Inicia PKG_LDCGRIDLDCAPLAC.GetFlagByOrder',15);

        OPEN cuDatosOrden;
        FETCH cuDatosOrden INTO osbFlag;
        CLOSE cuDatosOrden;

       pkg_Traza.Trace('Fin PKG_LDCGRIDLDCAPLAC.GetFlagByOrder - osbFlag: '||osbFlag,15);

    EXCEPTION
	  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		  RAISE PKG_ERROR.CONTROLLED_ERROR;
	  WHEN others THEN
		  Pkg_error.setError;
		  RAISE PKG_ERROR.CONTROLLED_ERROR;
    END GetFlagByOrder;
    
    /*******************************************************************************
	Metodo: InsOrUpdByOrder
	Descripcion:  Inserta o actualiza el flag de garantias

    Autor          : Horbath
    Fecha          : 16-08-2021

    Historia de Modificaciones
    Fecha       Autor                       Modificacion
    =========   =========                   ====================
    16-08-2021  Horbath                     CA676. Creacion
	24/07/2023	jerazomvm					CASO OSF-1261:
											1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    ******************************************************************/
    PROCEDURE InsOrUpdByOrder
    (
        inuOrderId     IN      OR_order.order_id%TYPE,
        isbFlag        IN      VARCHAR2
    )
    IS
        nuExiste        NUMBER;

        CURSOR cuDatosOrden
        IS
            SELECT count(1)
            FROM   LDC_FLAG_GARANTIA
            WHERE  order_id = inuOrderId;

    BEGIN
       pkg_Traza.Trace('Inicia PKG_LDCGRIDLDCAPLAC.InsOrUpdByOrder',15);

        OPEN cuDatosOrden;
        FETCH cuDatosOrden INTO nuExiste;
        CLOSE cuDatosOrden;
        
        IF nuExiste = 0 THEN
            INSERT INTO LDC_FLAG_GARANTIA (ORDER_ID, FLAG_GARANT)
            VALUES (inuOrderId, isbFlag);
        ELSE
            UPDATE LDC_FLAG_GARANTIA
                SET FLAG_GARANT = isbFlag
            WHERE ORDER_ID = inuOrderId;
        END IF;
        
        COMMIT;

       pkg_Traza.Trace('Fin PKG_LDCGRIDLDCAPLAC.InsOrUpdByOrder',15);

    EXCEPTION
	  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		  RAISE PKG_ERROR.CONTROLLED_ERROR;
	  WHEN others THEN
		  Pkg_error.setError;
		  RAISE PKG_ERROR.CONTROLLED_ERROR;
    END InsOrUpdByOrder;
END pkg_ldcgridldcaplac;

/
PROMPT Otorgando permisos de ejecucion a PKG_LDCGRIDLDCAPLAC
BEGIN
    pkg_utilidades.praplicarpermisos('PKG_LDCGRIDLDCAPLAC', 'ADM_PERSON');
END;
/