CREATE OR REPLACE PROCEDURE adm_person.ldc_prchangeplan  
IS
  /*****************************************************************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_PRCHANGEPLAN
  Descripcion    : Proceso para registrar trámite 100226  - Cambio de Plan Comercial ? Gas


  Autor          : socoro@horbath.com
  Fecha          : 12/04/2016

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  15/09/2017      Karem Baquero       CASO 200-1482 Se modifica el cursor <<cuConfig>> para cambiar el condicional que
                                      tiene para validar el plan comercial anterior plcomant, para que valide por el plan comercial
                                      actual plcomact
  21/11/2023      Adrianavg           OSF-1805: se reemplaza tipo de dato de la variable sbXml, varchar2(2000) constants_per.tipo_xml_sol%TYPE
                                      Se retiran las variables sbPlanRes, sbPlanCom, rcCCXCATEG1 declaradas sin uso
                                      Declarar las variables de control de la traza
                                      Se reemplaza or_bolegalizeorder.fnuGetCurrentOrder por pkg_bcordenes.fnuobtenerotinstancialegal
                                      , daor_order.fnugetcausal_id(nuOrderId,null) por pkg_bcordenes.fnuobtienecausal
                                      , dage_causal.fnugetclass_causal_id por Pkg_Bcordenes.Fnuobtieneclasecausal
                                      , Daor_Order_Activity.Fnugetpackage_Id Por Pkg_Bcordenes.Fnuobtienesolicitud, se cambia nuOrderActId por nuOrderId
                                      , Ge_Bopersonal.Fnugetcurrentchannel Por Pkg_Bopersonal.Fnugetpuntoatencionid
                                      , Daor_Order_Activity.Fnugetproduct_Id Por Pkg_Bcordenes.Fnuobtieneproducto, se cambia nuOrderActId por nuOrderId
                                      , Dapr_Product.Fnugetproduct_Type_Id(Nuproductid, Null) Por Pkg_Bcproducto.Fnutipoproducto
                                      , nuBillDataChange := mo_bobillingdatachange.fnuGetRecIdByPackId(nuPackageId) por cursor cuBillDataChangeId
                                      , nuCategAnt := damo_bill_data_change.fnugetold_category_id(nuBillDataChange, null) por cursor cuOldCategoryId
                                      , nuCategAct := damo_motive.fnugetcategory_id(nuMotiveId,null) por cursor cuCategoryId
                                      , pktblcategori.fsbgetdescription(nuCategAnt,null) por cursor cuDescripCateAnt
                                      , dacc_commercial_plan.fsbgetdescription (nuPlanAnt, null) por cursor cuDescripPlanAnt
                                      , dapr_product.fnugetaddress_id(nuProductId,null) por pkg_bcproducto.fnuiddireccinstalacion
                                      , SA_BOUser.Fnugetuserid; por PKG_SESSION.GETUSERID
                                      , dapr_product.fnugetsubscription_id(nuProductId,null) por pkg_bcproducto.fnuContrato
                                      , pktblsuscripc.fnugetsuscclie(nuSuscripc,null) por pkg_bccontrato.fnuidcliente
                                      , dage_subscriber.fsbgetidentification(nuSubscriber,null) por pkg_bccliente.fsbidentificacion
                                      , OS_RegisterRequestWithXML por API_RegisterRequestByXML
                                      , ge_boerrors.seterrorcodeargument(,) por Pkg_Error.Seterrormessage y Ld_Boconstans.cnuGeneric_Error por PKG_ERROR.CNUGENERIC_MESSAGE
                                      , ex.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                      , Errors.getError(nuErrorCode, sbErrorMessage) por PKG_ERROR.GETERROR
                                      , Errors.setError por ERRORS.SETERROR
                                      , dapr_product.fnugetcommercial_plan_id por pkg_bcproducto.fnuTraerCommercialPlanId
                                      , GE_BOPERSONAL.FNUGETPERSONID() por PKG_BOPERSONAL.FNUGETPERSONAID
                                      , Se retira nuOrderActId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId), se reemplaza por nuOrderId 
  07/12/2023      Adrianavg           OSF-1805: Del bloque de exception en CONTROLLED_ERROR y OTHERS se retira el PKG_ERROR.SETERRORMESSAGE y se añade un RAISE
                                      PKG_ERROR.CONTROLLED_ERROR.
                                      se ajusta el PKG_ERROR.SETERRORMESSAGE a PKG_ERROR.SETERRORMESSAGE(isbMsgErrr =>  SbMess)
  16/04/2024      PAcosta             OSF-2532: Se crea el objeto en el esquema adm_person  
  *******************************************************************************************************************/
  
  -- Constantes para el control de la traza
  csbnompkg      CONSTANT VARCHAR2(32) := $$plsql_unit||'.';  
  csbniveltraza  CONSTANT NUMBER(2)    := pkg_traza.cnuniveltrzdef;
  csbmetodo      CONSTANT VARCHAR2(60) := csbnompkg||'LDC_PRCHANGEPLAN';

  --Cursor para obtener los medios de recepci?n que puede ser usados en el trámite
  CURSOR cumediorecepcion (inuoperatingunitid mo_packages.pos_oper_unit_id%TYPE)
   IS
      SELECT R.reception_type_id ID, R.DESCRIPTION
        FROM ge_reception_type R, or_ope_uni_rece_type o, or_operating_unit u
       WHERE R.reception_type_id <> ge_boparameter.fnuget('EXTERN_RECEPTION')
         AND R.reception_type_id = o.reception_type_id
         AND o.operating_unit_id = u.operating_unit_id
         AND u.operating_unit_id = inuoperatingunitid-- unidad operativa
         AND ROWNUM = 1;

    rcmediorecepcion cumediorecepcion%rowtype;
    nuorderid       or_order.order_id%TYPE;
    nucausalid      or_order.causal_id%TYPE;
    nucausalclass   ge_causal.class_causal_id%TYPE;
    sbxml           constants_per.tipo_xml_sol%TYPE;
    nuorderactid    or_order_activity.order_activity_id%TYPE;
    nupackageid     mo_packages.package_id%TYPE;
    sbmess          VARCHAR2(2000);
    exerror         EXCEPTION;
    numotiveid      mo_motive.motive_id%TYPE;
    nuproductid     pr_product.product_id%TYPE;
    nucategant      pr_product.category_id%TYPE;
    nucategact      pr_product.category_id%TYPE;
    nucommcateg     categori.catecodi%TYPE;
    nuresicateg     categori.catecodi%TYPE;
    nuplanant       cc_commercial_plan.commercial_plan_id%TYPE;
    nuplanact       cc_commercial_plan.commercial_plan_id%TYPE; 
    onupackageid    mo_packages.package_id%TYPE;
    onumotiveid     mo_motive.motive_id%TYPE;
    nuerrorcode     NUMBER := 0;
    sberrormessage  VARCHAR2(2000);
    nuaddressid     ab_address.address_id%TYPE;
    nuuserid        sa_user.user_id%TYPE;
    nurolid         cc_role.role_id%TYPE;
    sbcomment       mo_packages.comment_%TYPE;
    nususcripc      suscripc.susccodi%TYPE;
    nusubscriber    ge_subscriber.subscriber_id%TYPE;
    nucontactid     ge_subscriber.identification%TYPE;
    nuproducttypeid pr_product.product_type_id%TYPE;

    CURSOR cuconfig(inucateant       NUMBER,
                    inucateact       NUMBER,
                    inucommplanact   NUMBER)
    IS 
    SELECT *
      FROM ldc_ccxcateg
     WHERE cateant = inucateant
       AND cateact = inucateact
       AND plcomant = inucommplanact --Se modifica en el caso 200-1482 Jm Gestion Informatica
       AND configact = 'A'
       AND ROWNUM = 1;

    --LJLB -- se consulta regitro en datos adicionales
    CURSOR cudatosadic 
    IS
    SELECT bill_data_change_id
      FROM mo_bill_data_change
     WHERE package_id = onupackageid
       AND motive_id = onumotiveid;

    nurespuesta ld_parameter.numeric_value%TYPE := dald_parameter.fnugetnumeric_value('LDC_RESP_TRACAPC');  --Ticket 200-214 LJLB -- Se consulta respuesta para el tramite

    --Ticket 200-214 LJLB -- Se Valdia que la respeus exista y sea de tipo 40
    CURSOR curespuesta IS
    SELECT 'X'
      FROM cc_answer
     WHERE answer_id = nurespuesta
       AND answer_type_id = 40;

    sbdato      VARCHAR2(1);  --Ticket 200-214 LJLB -- Se almacena el resultado del cursor cuRespuesta
    nucoddatos  mo_bill_data_change.bill_data_change_id%TYPE;
    rcccxcateg  ldc_ccxcateg%rowtype; 
    nuban       NUMBER := 0;

    nubilldatachange  mo_bill_data_change.bill_data_change_id%TYPE;
    nuoperatingunitid mo_packages.pos_oper_unit_id%TYPE;

    --id del tramite de cambio de ciclo de facturación
    CURSOR cubilldatachangeid (p_nupackageid mo_bill_data_change.package_id%TYPE)						
    IS						
    SELECT bill_data_change_id 						
      FROM mo_bill_data_change						
     WHERE package_id= p_nupackageid;						

    --categoria anterior
    CURSOR cuoldcategoryid (p_nubilldatachange mo_bill_data_change.bill_data_change_id%TYPE) 
    IS
    SELECT old_category_id
      FROM mo_bill_data_change
     WHERE bill_data_change_id = p_nubilldatachange;						

    --categoria actual    
    CURSOR cucategoryid( p_inumotive_id mo_motive.motive_id%TYPE)						
    IS						
    SELECT category_id						
      FROM mo_motive						
     WHERE motive_id = p_inumotive_id;						

    --Descripcion categoria
    CURSOR cudescripcateant ( p_nucatecodi categori.catecodi%TYPE ) 
    IS
    SELECT catedesc
      FROM categori
     WHERE catecodi = p_nucatecodi;
     sbdesccateg categori.catedesc%TYPE;

    --Descripcion Plan Comercial 
    CURSOR cudescripplanant(p_commercial_plan_id cc_commercial_plan.commercial_plan_id%TYPE )
    IS
    SELECT DESCRIPTION
     FROM cc_commercial_plan
    WHERE commercial_plan_id = p_commercial_plan_id;
    sbdescripplanant cc_commercial_plan.DESCRIPTION%TYPE;
    
    CURSOR cudatosrecepcion
    IS
    SELECT numeric_value ID,  DESCRIPTION  
      FROM ld_parameter
     WHERE parameter_id = 'MEDRECEP'; 
    
    --Obtener rol del usuario conectado 
     CURSOR curol
     IS
     SELECT role_id 
       FROM cc_role
      WHERE ROWNUM = 1;     

BEGIN   
  pkg_traza.TRACE(csbmetodo, csbniveltraza, pkg_traza.csbinicio);

  --Obtener el identificador de la orden  que se encuentra en la instancia
  nuorderid := pkg_bcordenes.fnuobtenerotinstancialegal;
  pkg_traza.TRACE(csbmetodo||' nuOrderId: '||nuorderid, csbniveltraza);

  IF nuorderid IS NOT NULL THEN
      nucausalid :=  pkg_bcordenes.fnuobtienecausal(nuorderid);
  ELSE
     sbmess := ' No se encontró identificador de la orden';
     RAISE exerror;
  END IF;

  pkg_traza.TRACE(csbmetodo||' nuCausalId: '||nucausalid, csbniveltraza);

  IF nucausalid IS NOT NULL THEN
      nucausalclass := pkg_bcordenes.fnuobtieneclasecausal(nucausalid);
  ELSE
     sbmess := ' No se encontró causal';
     RAISE exerror;
  END IF;

  IF nucausalclass IS NULL THEN
     sbmess := ' No se encontró clase de causal';
     RAISE exerror;
  END IF;

  pkg_traza.TRACE(csbmetodo||' nuCausalClass: '||nucausalclass, csbniveltraza);

  --Validar si la orden se legaliz? con clase de causal de exito
  IF nvl(nucausalclass,0) = 1 THEN
           --Obtener identificador del paquete
           nupackageid := pkg_bcordenes.fnuobtienesolicitud(nuorderid);
           pkg_traza.TRACE(csbmetodo||' nuPackageId: '||nupackageid, csbniveltraza);

           IF nupackageid IS NULL THEN
              sbmess := ' No se encontró identificador de solicitud';
              RAISE exerror;
           END IF;

           --Obtener unidad operativa de la solicitud
           nuoperatingunitid := pkg_bopersonal.fnugetpuntoatencionid(pkg_bopersonal.fnugetpersonaid);
           IF nuoperatingunitid IS NULL THEN
              sbmess := ' No se encontró identificador de la unidad operativa asociada a la solicitud';
              RAISE exerror;
           END IF;

           pkg_traza.TRACE(csbmetodo||' nuOperatingUnitId: '||nuoperatingunitid, csbniveltraza);

           --Obtener producto
           nuproductid := pkg_bcordenes.fnuobtieneproducto(nuorderid);
           pkg_traza.TRACE(csbmetodo||' nuProductId: '||nuproductid, csbniveltraza);

           IF nuproductid IS NULL  THEN
              sbmess := ' No se encontró identificador de producto';
              RAISE exerror;
           END IF;
           nuproducttypeid := pkg_bcproducto.fnutipoproducto(nuproductid);           
           pkg_traza.TRACE(csbmetodo||' nuProductTypeId: '||nuproducttypeid, csbniveltraza);
           
           IF (nupackageid IS NOT NULL) THEN
                -- Obtiene id de mo_bill_data_change
               OPEN cubilldatachangeid(nupackageid);
              FETCH cubilldatachangeid INTO nubilldatachange;
              CLOSE cubilldatachangeid;
              pkg_traza.TRACE(csbmetodo||' nuBillDataChange: '||nubilldatachange, csbniveltraza);

              IF (nubilldatachange IS NOT NULL) THEN
                  --Obtener categoría anterior
                  OPEN cuoldcategoryid(nubilldatachange);
                 FETCH cuoldcategoryid INTO nucategant;
                 CLOSE cuoldcategoryid;
              ELSE
                  sbmess := ' No se encontró identificador de registro en mo_bill_data_change para la solicitud '||to_char(nupackageid);
                  RAISE exerror;
              END IF;
           END IF;
            pkg_traza.TRACE(csbmetodo||' nuCategAnt: '||nucategant, csbniveltraza);

           --Obtener motivo
           numotiveid := to_number(ldc_boutilities.fsbgetvalorcampotabla('mo_motive','package_id ','motive_id ',nupackageid));
           pkg_traza.TRACE(csbmetodo||' nuMotiveId: '||numotiveid, csbniveltraza); 

           IF numotiveid  = -1  THEN
              sbmess := ' No se encontró motivo asociado a la solicitud '||to_char(nupackageid);
              RAISE exerror;
           END IF;

           --Obtener categoría actual
            OPEN cucategoryid(numotiveid);
            FETCH cucategoryid INTO nucategact;
            CLOSE cucategoryid;   

           pkg_traza.TRACE(csbmetodo||' nuCategAct: '||nucategact, csbniveltraza);

           IF nucategact IS NULL  THEN
              sbmess := ' No se encontró identificador de categoría para el motivo '||to_char(numotiveid);
              RAISE exerror;
           END IF;

           -- Validar que esta solicitud solo aplique para los cambios de uso de categoría Residencial(1)
           ---a Comercial(2) y viceversa
           nucommcateg := dald_parameter.fnugetnumeric_value('COMMERCIAL_CATEGORY',NULL);
           pkg_traza.TRACE(csbmetodo||' nuCommCateg: '||nucommcateg, csbniveltraza);

           IF nucommcateg IS NULL  THEN
              sbmess := ' No se configuró el parámetro COMMERCIAL_CATEGORY';
              RAISE exerror;
           END IF;

           nuresicateg := dald_parameter.fnugetnumeric_value('RESIDEN_CATEGORY',NULL);
           pkg_traza.TRACE(csbmetodo||' nuResiCateg: '||nuresicateg, csbniveltraza);

           IF nuresicateg IS NULL  THEN
              sbmess := ' No se configuró el parámetro RESIDEN_CATEGORY';
              RAISE exerror;
           END IF;

           IF ((nucategant = nuresicateg AND nucategact = nucommcateg)
                   OR (nucategant = nucommcateg AND  nucategact = nuresicateg )  ) THEN

               --Obtener plan comercial anterior
               nuplanant := pkg_bcproducto.fnutraercommercialplanid(nuproductid);
               pkg_traza.TRACE(csbmetodo||' nuPlanAnt: '||nuplanant, csbniveltraza);

               IF nuplanant IS NULL  THEN
                  sbmess := ' No se encontró identificador de plan comercial para el producto '||to_char(nuproductid);
                  RAISE exerror;
               END IF;

            --------------------------------------------------------------
             nuban := 0;
              OPEN cuconfig (nucategant,nucategact,nuplanant);
             FETCH cuconfig INTO rcccxcateg;
             IF cuconfig%notfound THEN
                nuban := 1;
             END IF;
             CLOSE cuconfig;

             IF nuban = 1 THEN

               --Obtener Descripción categoria anterior
                 OPEN cudescripcateant(nucategant);
                FETCH cudescripcateant INTO sbdesccateg;
                CLOSE cudescripcateant;              

               --Obtener Descripción plan comercial anterior
                 OPEN cudescripplanant(nuplanant);
                FETCH cudescripplanant INTO sbdescripplanant;
                CLOSE cudescripplanant; 

                sbmess := ' No se encontro configuracion para la categoria Anterior '||to_char(nucategant)
                ||' - '||sbdesccateg||'y el plan comercial Anterior'
                ||' - '|| nuplanant ||' - '|| sbdescripplanant ||' - '|| ' en la forma CPCXC';
                RAISE exerror;
             END IF;

             nuplanact := rcccxcateg.plcomact;

             pkg_traza.TRACE(csbmetodo||' nuPlanAct: '||nuplanact, csbniveltraza);
            --------------------------------------------------------------
               OPEN cudatosrecepcion;
               FETCH cudatosrecepcion INTO rcmediorecepcion.ID , rcmediorecepcion.DESCRIPTION;
               CLOSE cudatosrecepcion; 
               pkg_traza.TRACE(csbmetodo||' rcMedioRecepcion.id: '||rcmediorecepcion.ID, csbniveltraza);

               --Obtener dirección del producto
               nuaddressid := pkg_bcproducto.fnuiddireccinstalacion(nuproductid);
               IF nuaddressid IS NULL THEN
                  sbmess := ' No se encontró dirección para el producto '||to_char(nuproductid);
                  RAISE exerror;
               END IF;

               pkg_traza.TRACE(csbmetodo||' nuAddressId: '||nuaddressid, csbniveltraza);

               --Obtener usuario conectado
               nuuserid :=  pkg_session.getuserid;
               pkg_traza.TRACE(csbmetodo||' nuUserId: '||nuuserid, csbniveltraza);

               --Obtener rol del usuario conectado
                 OPEN curol;
                FETCH curol INTO nurolid;
                CLOSE curol; 

               OPEN curespuesta;
              FETCH curespuesta INTO sbdato;
                 IF curespuesta%notfound THEN
                    sbmess := ' La respuesta '||to_char(nurespuesta)||' No existe o no es de tipo 40, por favor valide';
                    RAISE exerror;
                 END IF;
              CLOSE curespuesta;

               IF nurolid = -1 THEN
                  sbmess := ' No se encontró dirección para el productol para el usuario '||to_char(nuuserid);
                  RAISE exerror;
               END IF;

               pkg_traza.TRACE(csbmetodo||' nuRolId: '||to_char(nurolid), csbniveltraza); 

               --Comentario de la solicitud
               sbcomment := 'Orden '||to_char(nuorderid);
               --Obtener suscriptor
               nususcripc := pkg_bcproducto.fnucontrato(nuproductid);
               IF nususcripc IS NULL THEN
                  sbmess := ' No se encontró contrato para el producto '||to_char(nuproductid);
                  RAISE exerror;
               END IF;

               pkg_traza.TRACE(csbmetodo||' nuSuscripc: '||to_char(nususcripc), csbniveltraza);

               nusubscriber := pkg_bccontrato.fnuidcliente(nususcripc);
               IF nusubscriber IS NULL THEN
                  sbmess := ' No se encontró suscriptor para el contrato '||to_char(nususcripc);
                  RAISE exerror;
               END IF;

               pkg_traza.TRACE(csbmetodo||' nuSubscriber: '||to_char(nusubscriber), csbniveltraza);

               nucontactid := pkg_bccliente.fsbidentificacion(nusubscriber);
               IF nucontactid IS NULL THEN
                  sbmess := ' No se encontró identificaci?n para el suscriptor '||to_char(nusubscriber);
                  RAISE exerror;
               END IF;

               pkg_traza.TRACE(csbmetodo||' nuContactId: '||to_char(nucontactid), csbniveltraza);
               --
               sbxml := pkg_xml_soli_facturacion.getsolicitudcancelacionplancom
                                        (sysdate,               --idtFechaRegi
                                         rcmediorecepcion.ID,    --inuMedioRecepcionId
                                         nusubscriber,          --inuContactoId
                                         nuaddressid,           --inuDireccion
                                         sbcomment,             --isbComentario
                                         nurolid,               --inuRelacionCliente
                                         nusubscriber,          --inuCliente
                                         nususcripc,            --inuContratoId 
                                         nuproductid,           --inuProductoId
                                         nuproducttypeid,       --inuTipoProd 
                                         nuplanant,             --inuPlanComerAnte
                                         nuplanact,             --inuPlanComerActual
                                         nurespuesta             --inuRespuesta
                             );
              pkg_traza.TRACE(csbmetodo||' sbXml: '|| sbxml, csbniveltraza);
              --Se debe enviar el XML generado para que se cree la solicitud de Cambio de Plan Comercial.

              pkg_traza.TRACE(csbmetodo||' Antes de registrar trámite por XML', csbniveltraza);

              api_registerrequestbyxml (isbrequestxml =>  sbxml,
                                        onupackageid  =>  onupackageid,
                                        onumotiveid  =>   onumotiveid,
                                        onuerrorcode =>   nuerrorcode,
                                        osberrormessage => sberrormessage);
              pkg_traza.TRACE(csbmetodo||' Después de registrar trámite por XML', csbniveltraza);
              --Esta solicitud debe quedar en estado atendida y se debe realizar el cambio de plan comercial.         

              IF nuerrorcode <> 0 THEN
                 pkg_traza.TRACE(csbmetodo||' nuErrorCode: '||nuerrorcode, csbniveltraza);
                 pkg_traza.TRACE(csbmetodo||' sbErrorMessage: '||sberrormessage, csbniveltraza);              
                 sbmess := sberrormessage; 
                 RAISE exerror;
              END IF;
               pkg_traza.TRACE(csbmetodo||' PAQUETE CREADO: '||to_char(onupackageid), csbniveltraza);
               pkg_traza.TRACE(csbmetodo||' MOTIVO ID: '||onumotiveid, csbniveltraza);

                OPEN cudatosadic;
               FETCH cudatosadic INTO nucoddatos;
               pkg_traza.TRACE(csbmetodo||' nuCodDatos: '||nucoddatos, csbniveltraza);
               
               IF cudatosadic%found THEN
                  UPDATE mo_bill_data_change
                     SET old_commercial_plan_id = nuplanant
                   WHERE bill_data_change_id = nucoddatos;
                   pkg_traza.TRACE(csbmetodo||' Actualizar old_commercial_plan_id por: '||nuplanant, csbniveltraza);
               END IF;
               CLOSE cudatosadic;

              UPDATE mo_motive
                 SET product_id = nuproductid
               WHERE motive_id = onumotiveid;
               pkg_traza.TRACE(csbmetodo||' Actualizar product_id por: '||nuproductid ||' del motivo '||onumotiveid, csbniveltraza);
              
              mo_boattention.changeplanbilling(onupackageid);
              mo_bomotiveactionutil.exectranstatusforrequ(onupackageid, 58);
              UPDATE mo_executor_log_mot 
                 SET status_exec_log_id = 3
               WHERE package_id = onupackageid 
                 AND status_exec_log_id <> 3; 
              pkg_traza.TRACE(csbmetodo||' Actualizar estado de ejecutores de Procesos Sobre Motivos: '||onupackageid , csbniveltraza);
          END IF;--Fin valida categoria
    END IF; --Fin clase de causal
    pkg_traza.TRACE(csbmetodo, csbniveltraza, pkg_traza.csbfin);
    EXCEPTION
      WHEN exerror THEN
          ROLLBACK;
          IF cumediorecepcion%isopen THEN
            CLOSE cumediorecepcion;
          END IF;
          pkg_traza.TRACE(csbmetodo||' exError: '||sbmess, csbniveltraza);
          pkg_error.seterrormessage(isbmsgerrr =>  sbmess);
      WHEN pkg_error.controlled_error THEN
          ROLLBACK;
          sbmess := sqlerrm;
          pkg_traza.TRACE(csbmetodo||' SbMess: '||sbmess, csbniveltraza); 
          pkg_error.geterror(nuerrorcode, sberrormessage);
          pkg_traza.TRACE(csbmetodo||' ERROR CONTROLLED', csbniveltraza);
          pkg_traza.TRACE(csbmetodo||' error onuErrorCode: '||nuerrorcode, csbniveltraza);
          pkg_traza.TRACE(csbmetodo||' error osbErrorMess: '||sberrormessage, csbniveltraza);
          pkg_traza.TRACE(csbmetodo,  csbniveltraza, pkg_traza.csbfin_erc);
          RAISE pkg_error.controlled_error;
      WHEN OTHERS THEN
          ROLLBACK;
          pkg_traza.TRACE(csbmetodo||' SbMess: '||sbmess||' - '||sqlerrm, csbniveltraza);
          pkg_error.seterror; 
          pkg_error.geterror(nuerrorcode, sberrormessage);
          pkg_traza.TRACE(csbmetodo||' ERROR OTHERS', csbniveltraza);
          pkg_traza.TRACE(csbmetodo||' error onuErrorCode: '||nuerrorcode, csbniveltraza);
          pkg_traza.TRACE(csbmetodo||' error osbErrorMess: '||sberrormessage, csbniveltraza);
          pkg_traza.TRACE(csbmetodo,  csbniveltraza, pkg_traza.csbfin_erc);
          RAISE pkg_error.controlled_error;


END ldc_prchangeplan ;
/
PROMPT Otorgando permisos de ejecucion a LDC_PRCHANGEPLAN
BEGIN
  pkg_utilidades.praplicarpermisos('LDC_PRCHANGEPLAN','ADM_PERSON');
END;
/