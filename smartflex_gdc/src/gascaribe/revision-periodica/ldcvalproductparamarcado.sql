CREATE OR REPLACE PROCEDURE LDCVALPRODUCTPARAMARCADO(pProductID PR_PRODUCT.PRODUCT_ID%type,
                                                     nuTipoSol  PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%type) AS
    /**************************************************************************
    Propiedad Intelectual de HORBATH TECHNOLOGIES

    Funcion     :  LDCVALPRODUCTPARAMARCADO
    Descripcion :  Validaciones:
                  *Solo se debe generar para las categorias configuradas en el parametro COD_CATEG_VALIDOS_OTREV.(1,2,3,6)
                  *Solo se debe generar si no hay solicitudes en proceso con alguno de los parametros que se estan manejando.
                  *Solo se pueda generar si no tiene marca o si tiene marca 101-No permitio revisar

    Autor       : Josh Brito
    Fecha       : 13-03-2018

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    13-03-2018          Josh Brito         Creacion Caso 200-1743
    03/04/2018          JOSH BRITO         CASO 200-1871 Se agregaro las validacione de estado de corte y si
                                           tiene ordenes en procesos de tipos de trabajo certificables en una VS
  25/06/2018      dsaltarin      Ca 200-2007, se modifica porque estaba permitiendo generar tramits a usuarios
                       suspendidos desde acometida
    18/09/2018          josh brito          Caso 200-2157 para la solicitud 100237 se validara si el el producto
                                            tiene diferido con fecha mayor o igual al plazo minimo de revision
    28/09/2018          JJJM               Se cambia parametro LDC_PAR_STATUSORDEN_SUSP por LDC_PAR_STATUSORDEN_SUSP_NEW
                                           en el cursor cuOrdenSusp

    30/01/2019          ELAL               caso 200-2231 se adiciona parametro LDC_LISTTITRSUSPAURE  para proceso de autoreconectado
  09/05/2019      dsaltarin       caso 200-2625. Se adiciona que busque el comentario para buscar el numero de la orden que lo genera.
                              Se corrige para que si la instancia no esta en el parametro LDC_PAR_INSTANCIA arroje
                              error si hay ordenes
  27/02/2020          HT          Caso 34. se incluira un nuevo proceso que valide en caso que el tr?!mite sea el 100295 que no existan
                                           ordenes de certificaci??n SV (par?!metro LDC_CODACTVICESVPV y LDC_CODACTVICESVSV) en estado 0 o 5.
    09/12/2020          ljlb                CA 337 se coloca validacion de producto excluido
    05/02/2021          dsaltarin           547: se modifica para que valide si la orden de autoreconectado es la que se encxuentra en legalizacin
    25/02/2021          LJLB                CA 472 se modifica para que no tenga en cuenta los productos castigados.
    25/05/2021          dsaltarin           CA 769: Se modifica para que que no valide entrega del 472 sino que se crea un parametro para validar el tipo de suspension
                                            se corrige para que valide que si el producto esa suspendido por acometida por RP
    25-09-2021          Horbath             CA667: SE adiciona validacion para saber si el producto tiene marca de no reparable
    25/06/2022          Jorge Valiente      OSF-369: Realizar el llamado del servicio LDC_FNUCUENTASSALDOSPRODUCTO para que valide el producto del usuario y si
                                                     tiene 2 o mas cuentas de cobro con saldo debe levantar error indicando que ?No se puede generar tramite
                                                     porque el usuario tiene saldo pendiente?.
    05/07/2022          Jorge Valiente      OSF-384: Actualizar el nuevo mensaje solicitado por el funcional.
                                                     Su instalaci?n presenta defectos no reparables por la empresa
                                                     tiene 2 o mas cuentas de cobro con saldo debe levantar error indicando que ?No se puede generar tramite
                                                     porque el usuario tiene saldo pendiente?.
    09/08/2022          Jorge Valiente      OSF-479: Aplicar nueva logica donde se validen las cuentas de cobro con saldo obtenidas del servicio LDC_FNUCUENTASSALDOSPRODUCTO con el valor 
                                                     del parametro CANT_CTA_SALDO_RESTR_RECON del OSF-369.
                                                     
    **************************************************************************/
  nuProductId         PR_PRODUCT.PRODUCT_ID%type;  -- := 471702;
  nuCategoryId        CATEGORI.CATECODI%type;
  nuProductStatus     pr_product.product_status_id%type;
  listCategorias      Varchar2(4000);
  nEstadoCorte        number DEFAULT 0;
  nContSolicitud      number DEFAULT 0;
  nContOrdenTTCertVSI number DEFAULT 0;
  nMarca              number default NULL;
  sbmensamen          VARCHAR2(4000);
  nuMarca101          open.ge_suspension_type.suspension_type_id%type;
  nuMarca102          open.ge_suspension_type.suspension_type_id%type;
  nuMarca103          open.ge_suspension_type.suspension_type_id%type;
  nuMarca104          open.ge_suspension_type.suspension_type_id%type;
  TIPO_SUSPENSION     open.ge_suspension_type.suspension_type_id%type;
  sbTipoSoliSuspe     open.ld_parameter.value_chain%type:=DALD_PARAMETER.fsbGetValue_Chain('TIPO_SOL_CERRAR_SUSPENSION',NULL);
  nuCantOt          number;
  --200-2007----
  sbTipoTrabSuspNoVali  open.ld_parameter.value_chain%type:=DALD_PARAMETER.fsbGetValue_Chain('TITR_SUS_NO_VALIDO_TRAMITE_RP',NULL);
  nususpen_ord_act_id    open.pr_product.suspen_ord_act_id%type;
  nuOrden          open.or_order.order_id%type;
  nuTitr          open.or_task_type.task_type_id%type;
  --200-2007----
  ---769
  sbValida472     open.ldc_pararepe.paravast%type := open.daldc_pararepe.fsbGetPARAVAST('LDC_VALIDA_472', null);
  ---769


  CURSOR cuSolicitudes is
    SELECT  p.package_type_id,
        (SELECT t.description from open.ps_package_type t where t.package_type_id=p.package_type_id) descripcion,
        p.comment_
    FROM open.mo_packages p, open.mo_motive m
        WHERE p.package_id = m.package_id
    AND package_type_id in (SELECT to_number(column_value) as tasks_type
                                  FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('VAL_TIPO_PAQUETE_OTREV'),',')))
        AND m.product_id = nuproductid
        AND p.motive_status_id not in (14,32,51);

  CURSOR cuOrdenSusp( nuProductId   PR_PRODUCT.PRODUCT_ID%type) IS
            select count(1)
            from open.or_order_activity a, open.or_order b, open.mo_packages p
            where a.order_id  = b.order_id
            and ( b.task_type_id in (SELECT TO_NUMBER(COLUMN_VALUE)
                                   FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('LDC_TT_SUSP_CM',NULL),',')))
                 or b.task_type_id in (SELECT TO_NUMBER(COLUMN_VALUE)
                                   FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('LDC_TT_SUSP_ACOMETIDA',NULL),',')))
                 )
          and b.order_status_id in (SELECT TO_NUMBER(COLUMN_VALUE)
                                   FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('LDC_PAR_STATUSORDEN_SUSP_NEW',NULL),',')))
            and a.PRODUCT_ID  = nuProductId
      and a.package_id = p.package_id
      and instr(sbTipoSoliSuspe, package_type_id) > 0;
          --and rownum = 1;

        CURSOR cuOrdenReparacion( nuProductId   PR_PRODUCT.PRODUCT_ID%type)
        IS
            select count(1)
            from or_order_activity a, or_order b, mo_packages p
            where a.order_id  = b.order_id
      and a.package_id=p.package_id
            and p.package_type_id =DALD_PARAMETER.fnuGetNumeric_Value('TRAMITE_REPARACION_PRP',NULL)
          and b.order_status_id in (SELECT TO_NUMBER(COLUMN_VALUE)
                                   FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('LDC_PAR_STATUSORDEN_SUSP',NULL),',')))
            and a.PRODUCT_ID  = nuProductId;

    nusaldodife number;

    sbTitrAuto  VARCHAR2(400) := DALD_PARAMETER.fsbGetValue_Chain('LDC_LISTTITRSUSPAURE',null);  --se consultas tipo d etrabajo de autoreconetado
    --TICKET 200-2231 ELAL -- se consulta ordenes pendientes
    CURSOR cuOrdenAuto IS
    SELECT 'X'
    FROM or_order o, or_order_activity oa
    WHERE o.order_id = oa.order_id
     AND oa.product_id = nuProductId
     and not exists(select null from open.ldc_ordenes_rp rp where rp.order_id=oa.order_id)
     AND o.task_type_id in (SELECT TO_NUMBER(COLUMN_VALUE)
                                   FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(sbTitrAuto,',')))
     AND o.order_status_id NOT IN ( SELECT eo.ORDER_STATUS_ID
                                    FROM OR_ORDER_STATUS eo
                                    WHERE eo.IS_FINAL_STATUS = 'Y')
   ;

    sbdatos  VARCHAR2(1);
  --200-2625----------------
    sbComment_ mo_packages.comment_%type;
    v_out      number:= 1;
    sbIntancia    VARCHAR2(200);
    sbOrden      VARCHAR2(2000);
    nuOT      open.or_order.order_id%type;
  csbEnt2625    open.ldc_versionentrega.nombre_entrega%type:='OSS_SUSYRECO_DSS_2002625_1';
  sbAplica2625  varchar2(1):='N';
  nuInstCierraOt  number:=0;

    CURSOR cuOrdenAutov2(numOrden  open.or_order.order_id%type) IS
    SELECT 'X'
    FROM or_order o, or_order_activity oa
    WHERE o.order_id = oa.order_id
     AND oa.product_id = nuProductId
     AND o.task_type_id in (SELECT TO_NUMBER(COLUMN_VALUE)
                                   FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(sbTitrAuto,',')))
     AND o.order_status_id NOT IN ( SELECT eo.ORDER_STATUS_ID
                                    FROM OR_ORDER_STATUS eo
                                    WHERE eo.IS_FINAL_STATUS = 'Y')
  AND  ((o.order_id!=numOrden AND sbAplica2625='S') Or sbAplica2625='N')
   ;
  --200-2625----------------

  --INICIO CA 34
   sbActivPriVisi VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CODACTVICESVPV', NULL);--se almacena codigo primera visita SV
   sbActivSegVisi VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CODACTVICESVSV', NULL);--se almacena codigo segunda visita SV
   sbEstadoVali VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CODESTORDVA', NULL);--se almacena estado de orden a validar

   --se consulta ordenes de certificacion sv pendiente
   CURSOR cuValidaVisiCert IS
   SELECT 'X'
   FROM or_order o, or_order_activity oa
   WHERE o.order_id = oa.order_id
    AND oa.product_id = nuProductId
    AND oa.activity_id IN ( SELECT to_number(regexp_substr(sbActivPriVisi||','||sbActivSegVisi,'[^,]+', 1, LEVEL)) As acti
                              FROM   dual
                             CONNECT BY regexp_substr(sbActivPriVisi||','||sbActivSegVisi, '[^,]+', 1, LEVEL) IS NOT NULL)
    AND o.order_status_id in ( SELECT to_number(regexp_substr(sbEstadoVali,'[^,]+', 1, LEVEL)) AS esta
                               FROM   dual
                               CONNECT BY regexp_substr(sbEstadoVali, '[^,]+', 1, LEVEL) IS NOT NULL);

  --FIN CA 34
  --INICIO CA 472
  sbExistePrCast VARCHAR2(1);

  sbEstaFina VARCHAR2(400) := DALDC_PARAREPE.fsbGetPARAVAST('LDC_ESFICAPR', NULL);
  CURSOR  cuGetisprodcasti IS
  SELECT 'X'
  FROM servsusc
  WHERE sesunuse =pProductID
   AND sesuesfn  in ( SELECT (regexp_substr(sbEstaFina,'[^,]+', 1, LEVEL)) AS esta
                       FROM   dual
                       CONNECT BY regexp_substr(sbEstaFina, '[^,]+', 1, LEVEL) IS NOT NULL);

  sbAPlica472 VARCHAR2(1) := 'N';
  nuValida NUMBER := 0;
  --FIN CA 472
  
  --Inicio OSF-479
  nuCANT_CTA_SALDO_RESTR_RECON LDC_PARAREPE.PAREVANU%type := daldc_pararepe.fnuGetPAREVANU('CANT_CTA_SALDO_RESTR_RECON',null);
  --Fin OSF-479
begin

    --DBMS_LOCK.Sleep(10);

  --INICIO CA 337
  IF FBLAPLICAENTREGAXCASO('0000337') THEN
    IF LDC_PKGESTPREXCLURP.FUNVALEXCLURP(pProductID) > 0 THEN
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'Producto ['||pProductID||'] se encuentra excluido para el proceso de RP');
    END IF;
  END IF;
  --FIN CA 337

  --INICIO CA 472
  IF FBLAPLICAENTREGAXCASO('0000472') THEN
       sbAPlica472 := 'S';
    IF nuTipoSol IN (100237,100294, 100295) THEN
       OPEN cuGetisprodcasti;
       FETCH cuGetisprodcasti INTO sbExistePrCast;
       IF cuGetisprodcasti%FOUND THEN
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'Producto ['||pProductID||'] se encuentra en estado financiero no valido, por favor valide parametro LDC_ESFICAPR');
       END IF;
       CLOSE cuGetisprodcasti;
     END IF;
  END IF;
  --FIN CASO 472
  --200-2625----------------
  IF OPEN.fblAplicaEntrega(csbEnt2625) THEN
    sbAplica2625:='S';
  ELSE
    sbAplica2625:='N';
  end if;
  IF sbAplica2625='S' THEN
    IF nuTipoSol = 100237 THEN
       sbIntancia := 'P_LDC_SOLICITUD_VISITA_IDENTIFICACION_CERTIFICADO_100237-1';
    END IF;
    IF nuTipoSol = 100294 THEN
       sbIntancia := 'P_SOLICITUD_REPARACION_PRP_100294-1';
    END IF;
    IF nuTipoSol = 100295 THEN
       sbIntancia := 'P_GENERACION_SOLICITUD_DE_CERTIFICACION_PRP_100295-1';
    END IF;
    IF GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK('WORK_INSTANCE', NULL, 'MO_PROCESS', 'COMMENT_', v_out) = GE_BOCONSTANTS.GETTRUE THEN
      GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',NULL,'MO_PROCESS','COMMENT_',sbComment_);
    ELSE
      IF GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbIntancia, NULL, 'MO_PACKAGES', 'COMMENT_', v_out) = GE_BOCONSTANTS.GETTRUE THEN
      GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbIntancia,NULL,'MO_PACKAGES','COMMENT_',sbComment_);
      END IF;
    END IF;
    begin
      sbOrden := substr(sbComment_, instr(upper(sbComment_), upper('orden legalizada') )+19, instr(upper(sbComment_), upper('con causal') )-instr(upper(sbComment_), upper('orden legalizada'))-20);
      nuOT := to_number(sbOrden);
    exception
      when others then
       nuOT :=null;
    end;
    if instr(DALD_PARAMETER.fsbGetValue_Chain('LDC_PAR_INSTANCIA',NULL),ut_session.getmodule)=0 then
      nuInstCierraOt:=0;
    else
      nuInstCierraOt:=1;
    end if;
  END IF;
  --200-2625----------------
  nuProductId := pProductID;
  ut_trace.trace('LDCVALPRODUCTPARAMARCADO-nuProductId -->'||nuProductId, 10);

  nuCategoryId  := pktblservsusc.fnugetcategory(nuProductId);
  ut_trace.trace('LDCVALPRODUCTPARAMARCADO-nuCategoryId -->'||nuCategoryId, 10);

  listCategorias := open.DALD_PARAMETER.FSBGETVALUE_CHAIN('COD_CATEG_VALIDOS_OTREV');
  ut_trace.trace('LDCVALPRODUCTPARAMARCADO-listCategorias -->'||listCategorias, 10);

  nuProductStatus := dapr_product.fnugetproduct_status_id(nuProductId, null);
  ut_trace.trace('LDCVALPRODUCTPARAMARCADO-nuProductStatus -->'||nuProductStatus, 10);

  IF nuTipoSol = 100237 THEN
    nusaldodife := LDC_FNCRETORNASALDDIFVISITA(nuProductId);
    IF nusaldodife <> 0 THEN
      GI_BOERRORS.SETERRORCODEARGUMENT(2741,'El producto '|| nuProductId ||' tiene un diferido con fecha mayor o igual al plazo minimo de revision');
    END IF;
  END IF;

  IF OPEN.fblAplicaEntrega('OSS_RPS_JGBA_2001743_2') THEN
    nuMarca101 := open.DALD_PARAMETER.FNUGETNUMERIC_VALUE('MARCA_PRODUCTO_101');
    nuMarca102 := open.DALD_PARAMETER.FNUGETNUMERIC_VALUE('MARCA_PRODUCTO_102');
    nuMarca103 := open.DALD_PARAMETER.FNUGETNUMERIC_VALUE('SUSPENSION_TYPE_CERTI');
    nuMarca104 := open.DALD_PARAMETER.FNUGETNUMERIC_VALUE('MARCA_PRODUCTO_104');
        --Solo se debe generar para las categorias configuradas en el parametro COD_CATEG_VALIDOS_OTREV
        IF instr(listCategorias, nuCategoryId) = 0 THEN
            sbmensamen := 'El Producto no pertenece a una categoria valida.';
            ut_trace.trace('LDCVALPRODUCTPARAMARCADO-->'||sbmensamen, 10);
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
            RAISE ex.controlled_error;
        END IF;

        --Valida si el producto esta en estado de corte validos
        BEGIN
            SELECT COUNT(1) INTO nEstadoCorte
            FROM servsusc e
            WHERE e.sesunuse = nuProductId
            AND e.sesuesco in (SELECT TO_NUMBER(COLUMN_VALUE)
                                FROM TABLE (LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('ESTADO_CORTE_OTREV', NULL), ',')));
        EXCEPTION
          WHEN no_data_found THEN
           nEstadoCorte := 0;
        END;

        IF nEstadoCorte = 0 THEN
            sbmensamen := 'El producto no tiene un estado de corte valido. ';
            ut_trace.trace('LDCVALPRODUCTPARAMARCADO-->'||sbmensamen, 10);
            DBMS_OUTPUT.PUT_LINE(sbmensamen);
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
            RAISE ex.controlled_error;
        END IF;

        --Solo se debe generar si no hay solicitudes en proceso con alguno de los parametros que se estan manejando
       /* BEGIN
            SELECT COUNT(1) INTO nContSolicitud
            FROM OPEN.MO_PACKAGES P, OPEN.MO_MOTIVE M
            WHERE P.PACKAGE_ID = M.PACKAGE_ID
            AND PACKAGE_TYPE_ID IN(SELECT to_number(column_value) AS tasks_type
                                      FROM TABLE(open.ldc_boutilities.splitstrings(OPEN.DALD_PARAMETER.FSBGETVALUE_CHAIN('VAL_TIPO_PAQUETE_OTREV'),',')))
            AND M.PRODUCT_ID = nuProductId
            and P.MOTIVE_STATUS_ID NOT IN (14,32,51);
        EXCEPTION
          WHEN no_data_found THEN
           nContSolicitud := 0;
        END;

        IF nContSolicitud > 0 THEN
            sbmensamen := 'El Usuario(Producto) tiene solicitudes en Proceso del tipo cofiguradas en el parametro VAL_TIPO_PAQUETE_OTREV';
            ut_trace.trace('LDCVALPRODUCTPARAMARCADO-->'||sbmensamen, 10);
            DBMS_OUTPUT.PUT_LINE(sbmensamen);
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
            RAISE ex.controlled_error;
        END IF;*/
    FOR reg in cuSolicitudes LOOP
      --if reg.package_type_id != 100156  or (reg.package_type_id = 100294 and nuTipoSol != 100295) then
      if instr(sbTipoSoliSuspe,reg.package_type_id) = 0 or reg.comment_ like '%[GENERACION PLUGIN]%' then
        if reg.package_type_id = 100294 and nuTipoSol = 100295 then
          if nuInstCierraOt = 0 then
            nuCantOt:=0;
          else
            open cuOrdenReparacion(nuProductId);
            fetch cuOrdenReparacion into nuCantOt;
            if cuOrdenReparacion%notfound then
              nuCantOt := 0;
            end if;
            close cuOrdenReparacion;
          end if;

          if nuCantOt = 0  then
            sbmensamen := 'El Producto tiene solicitudes de Revision Periodica: '||reg.package_type_id||'-'||reg.descripcion||' en proceso.';
            ut_trace.trace('LDCVALPRODUCTPARAMARCADO-->'||reg.package_type_id, 10);
            DBMS_OUTPUT.PUT_LINE(sbmensamen);
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
            RAISE ex.controlled_error;
          end if;
        else
          sbmensamen := 'El Producto tiene solicitudes de Revision Periodica: '||reg.package_type_id||'-'||reg.descripcion||' en proceso.';
          ut_trace.trace('LDCVALPRODUCTPARAMARCADO-->'||reg.package_type_id, 10);
          DBMS_OUTPUT.PUT_LINE(sbmensamen);
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
          RAISE ex.controlled_error;
        end if;
      else
        if nuInstCierraOt = 0 then
            nuCantOt:=0;
        else
          open cuOrdenSusp(nuProductId);
          fetch cuOrdenSusp into nuCantOt;
            if cuOrdenSusp%notfound then
              nuCantOt := 0;
            end if;
          close cuOrdenSusp;
        end if;
        if nuCantOt = 0 then
          sbmensamen := 'El Producto tiene solicitudes de Revision Periodica: '||reg.package_type_id||'-'||reg.descripcion||' en proceso.';
          ut_trace.trace('LDCVALPRODUCTPARAMARCADO-->'||reg.package_type_id, 10);
          DBMS_OUTPUT.PUT_LINE(sbmensamen);
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
          RAISE ex.controlled_error;
        end if;
      end if;
    END LOOP;


    --TICKET 200-2231 ELAL -- se validan ordenes de autoreconetado
    IF sbAplica2625='S' and nuOT is not null and nuInstCierraOt = 0 THEN
      OPEN cuOrdenAutoV2(nuOT);
      FETCH cuOrdenAutoV2 INTO sbdatos;
        IF cuOrdenAutoV2%FOUND THEN
          sbmensamen := 'El Producto '||nuProductId||' tiene ordenes de autoreconectado pendiente';
          ut_trace.trace('LDCVALPRODUCTPARAMARCADO-->'||sbmensamen, 10);
          DBMS_OUTPUT.PUT_LINE(sbmensamen);
          close cuOrdenAutoV2;
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
          RAISE ex.controlled_error;
        END IF;
      CLOSE cuOrdenAutoV2;
    ELSE
      OPEN cuOrdenAuto;
      FETCH cuOrdenAuto INTO sbdatos;
        IF cuOrdenAuto%FOUND THEN
          sbmensamen := 'El Producto '||nuProductId||' tiene ordenes de autoreconectado pendiente';
          ut_trace.trace('LDCVALPRODUCTPARAMARCADO-->'||sbmensamen, 10);
          DBMS_OUTPUT.PUT_LINE(sbmensamen);
          close cuOrdenAuto;
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
          RAISE ex.controlled_error;
        END IF;
      CLOSE cuOrdenAuto;
    END IF;
    --TICKET 200-2231 ELAL -- se validan ordenes de autoreconetado

    --Valida si tiene ordenes en procesos de tipos de trabajo certificables en una VS
    BEGIN
      SELECT COUNT(1) INTO nContOrdenTTCertVSI
      FROM ldc_trab_cert,
         or_order_activity,
         or_order,
         mo_packages
      WHERE nuProductId = or_order_activity.PRODUCT_ID
      AND or_order.task_type_id = ldc_trab_cert.id_trabcert
      AND or_order_activity.order_id = or_order.order_id
      AND order_status_id in (0, 5, 7)
      AND or_order_activity.package_id = mo_packages.package_id
      AND 100101 = mo_packages.package_type_id;
    EXCEPTION
      WHEN no_data_found THEN
       nContOrdenTTCertVSI := 0;
    END;

        IF nContOrdenTTCertVSI > 0 THEN
            sbmensamen := 'El producto tiene ordenes en procesos de tipos de trabajo certificables en una VSI';
            ut_trace.trace('LDCVALPRODUCTPARAMARCADO-->'||sbmensamen, 10);
            DBMS_OUTPUT.PUT_LINE(sbmensamen);
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
            RAISE ex.controlled_error;
        END IF;

        --Solo se pueda generar si no tiene marca o si tiene marca 101-No permitio revisar
        BEGIN
            SELECT SUSPENSION_TYPE_ID INTO nMarca
            FROM OPEN.ldc_marca_producto
            WHERE ID_PRODUCTO = nuProductId;

         EXCEPTION
          WHEN no_data_found THEN
           nMarca := NULL;
        END;
        ut_trace.trace('LDCVALPRODUCTPARAMARCADO-nMarca -->'||nMarca, 10);

        IF nvl(nMarca,101) <> nuMarca101 and nuTipoSol = 100237 THEN
            sbmensamen := 'El Producto no debe tener marca diferente de 101';
            ut_trace.trace('LDCVALPRODUCTPARAMARCADO-->'||sbmensamen, 10);
            DBMS_OUTPUT.PUT_LINE(sbmensamen);
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
            RAISE ex.controlled_error;
        END IF;

        IF nvl(nMarca,101) not in (nuMarca102,nuMarca104) and nuTipoSol = 100294 THEN
            sbmensamen := 'El Producto no debe tener marca diferente de 102, 103, 104';
            ut_trace.trace('LDCVALPRODUCTPARAMARCADO-->'||sbmensamen, 10);
            DBMS_OUTPUT.PUT_LINE(sbmensamen);
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
            RAISE ex.controlled_error;
        END IF;

        IF nvl(nMarca,101) not in (nuMarca102,nuMarca104, nuMarca103) and nuTipoSol = 100295 THEN
            sbmensamen := 'El Producto no debe tener marca diferente de 102, 103 o 104';
            ut_trace.trace('LDCVALPRODUCTPARAMARCADO-->'||sbmensamen, 10);
            DBMS_OUTPUT.PUT_LINE(sbmensamen);
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
            RAISE ex.controlled_error;
        END IF;
        BEGIN
          SELECT SUSPENSION_TYPE_ID
            INTO TIPO_SUSPENSION
           FROM OPEN.PR_PROD_SUSPENSION
          WHERE PRODUCT_ID = pProductID
            --AND SUSPENSION_TYPE_ID IN (nuMarca101, nuMarca102, nuMarca103, nuMarca104)
            AND ACTIVE = 'Y'
            AND ROWNUM=1;
        EXCEPTION
          WHEN OTHERS THEN
               TIPO_SUSPENSION := 1;
        END;
        ut_trace.trace('LDCVALPRODUCTPARAMARCADO-TIPO_SUSPENSION -->'||TIPO_SUSPENSION, 10);
    --200-2007----
    nususpen_ord_act_id := dapr_product.fnugetsuspen_ord_act_id(nuProductId, null);
    if nususpen_ord_act_id is not null then
      nuOrden   := daor_order_activity.fnugetorder_id(nususpen_ord_act_id, null);
      nuTitr    := daor_order.fnugettask_type_id(nuOrden, null);
    end if;
    --200-2007----

    IF nuProductStatus != 1 THEN
      IF nuProductStatus = 2 THEN

        --INICIO CA 472
        IF sbValida472 = 'S' AND nuTipoSol IN (100294,100295 ) and TIPO_SUSPENSION not in (101,102,103,104)  THEN
           if LDC_PKGESTIONLEGAORRP.FNUGETSUSPCMOTPR(pProductID) = 1 THEN
              nuValida := 1;
           else
             nuValida :=0;
           END IF;
        else
          nuValida :=0;
        END IF;
        --FIN CA 472
        IF nuValida = 0 THEN
          IF nuTipoSol = 100237 and nvl(TIPO_SUSPENSION,101) <> nuMarca101 then
            sbmensamen := 'El producto no se encuentra suspendido por Revision ('||nuMarca101||').';
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
            RAISE ex.controlled_error;
          ELSIF nuTipoSol = 100294 AND nvl(TIPO_SUSPENSION,101) NOT IN (nuMarca102, nuMarca104, nuMarca103) then
            sbmensamen := 'El producto no se encuentra suspendido por Reparaciones ('||nuMarca102||','||nuMarca104||' o Certificaciones ('||nuMarca103||').';
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
            RAISE ex.controlled_error;
          ELSIF nuTipoSol = 100295 AND nvl(TIPO_SUSPENSION,101) NOT IN (nuMarca102, nuMarca104, nuMarca103) then
            sbmensamen := 'El producto no se encuentra suspendido por reparaciones ('||nuMarca102||','||nuMarca104||' o Certificaciones ('||nuMarca103||').';
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
            RAISE ex.controlled_error;
          END IF;
        END IF;

        if instr(sbTipoTrabSuspNoVali,nuTitr) > 0 THEN
          sbmensamen := 'El producto no se encuentra suspendido por un tipo de trabajo de acometida, debe ejecutar tramite de reconexion por revision segura';
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
        end if;

      ELSE


        sbmensamen := 'El estado del producto es diferente de  1-Activo o 2-Suspendido';
        ut_trace.trace('LDCVALPRODUCTPARAMARCADO-->'||sbmensamen, 10);
        DBMS_OUTPUT.PUT_LINE(sbmensamen);
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
        RAISE ex.controlled_error;
      END IF;
    END IF;
  END IF;
  --INICIO CA 34
  IF FBLAPLICAENTREGAXCASO('0000034') THEN
     IF nuTipoSol = 100295 THEN
       OPEN cuValidaVisiCert;
       FETCH cuValidaVisiCert INTO sbDatos;
       IF cuValidaVisiCert%FOUND THEN
          CLOSE cuValidaVisiCert;
          sbmensamen :='El producto ['||nuProductId||'] tiene ordenes de visita de certificacion SV pendientes';
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
       END IF;
       CLOSE cuValidaVisiCert;
     END IF;
  END IF;
  --FIN CA 34

    --Validacion CA667
    IF FBLAPLICAENTREGAXCASO('0000667') THEN

        IF nuTipoSol = 100294 THEN
            IF LDC_BODefectNoRepara.fboMarkActiveProduct(pProductID) THEN
                --Cambio de mensaje por el Jira-384
                --ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'El producto ['||pProductID||'] cuenta con una marca activa de bloqueo RP. Favor validar');
                ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'Su instalaci?n presenta defectos no reparables por la empresa');
                RAISE ex.controlled_error;
            END IF;
        END IF;

    END IF;
    -- fin CA667

    --Inicio OSF-369
    --OSF-479 Se agrega parametro nuCANT_CTA_SALDO_RESTR_RECON
    IF FBLAPLICAENTREGAXCASO('OSF-369') THEN
      if LDC_FNUCUENTASSALDOSPRODUCTO(pProductID) >= nuCANT_CTA_SALDO_RESTR_RECON and nuInstCierraOt = 1 then
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'No se puede generar tramite porque el usuario tiene saldo pendiente');
        RAISE ex.controlled_error;
      end if;
    end if;
    --Fin OSF-369

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
END ldcvalproductparamarcado;
/
