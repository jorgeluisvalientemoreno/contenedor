column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    CURSOR cuConfiguracion
    IS
    Select  c.cocltiso, 
            c.cocltitr, 
            t.description desc_1, 
            c.coclacpa,  
            c.coclcaus, 
            ca.description desc_2, 
            c.coclcate, 
            c.coclmere,
            ti.task_type_id, 
            c.coclacti, 
            i2.description, 
            c.coclasau, 
            c.cocldias, 
            c.coclcame
    From open.LDC_COTTCLAC  c
    Inner join or_task_type t on c.cocltitr = t.task_type_id
    Inner join ge_items i on c.coclacpa = i.items_id
    Inner join ge_causal ca on c.coclcaus = ca.causal_id
    Inner join ge_items i2 on c.coclacti = i2.items_id
    Inner join open.or_task_types_items ti on ti.items_id = c.coclacti
    Where c.cocltitr in (11056,11178);

    CURSOR cuOrdenes
    (
        inuTipoTrabajo  IN or_order.task_type_id%TYPE,
        inuActividad    IN or_order_activity.activity_id%TYPE,
        inuCausal       IN or_order.causal_id%TYPE,
        inuActividadGen    IN or_order_activity.activity_id%TYPE
    )
    IS
    select  o.order_id
    from    or_order o, or_order_activity a
    where   a.order_id = o.order_id
    and o.task_type_id = inuTipoTrabajo--c.cocltitr--11178
    and o.order_status_id = 8
    and a.activity_id= inuActividad--c.coclacpa--100009157
    and o.causal_id = inuCausal--c.coclcaus--1
    and trunc(o.legalization_date) >= to_date('03/03/2024','dd/mm/yyyy')
    and not exists (
        select 'X' from or_order_Activity ooaa, or_order oo where oo.order_id = ooaa.order_id  and ooaa.activity_id = inuActividadGen  and ooaa.product_id = a.product_id and trunc(oo.created_date) >= to_date('03/03/2024','dd/mm/yyyy')
    )
    and not exists (
        select 'X' from or_order_Activity ooaa, or_order oo where oo.order_id = ooaa.order_id  and oo.task_type_id = 11056  and ooaa.product_id = a.product_id and order_status_id in (0,5,7)
    );

    PROCEDURE PRPROCGENVSI 
    (
        inuOrden  IN or_order.order_id%TYPE
    )
    IS
      nuorden       NUMBER; --se almacena numero de orden
      sbmensa       VARCHAR2(4000);
      nuPersonIdsol NUMBER := 1;
      nuPersonId NUMBER := 1;
      ONUCHANNEL    CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE;
      ONUCHANNELOT    CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE;
      sbObserva     VARCHAR2(4000);
      sbRequestXML  VARCHAR2(4000);
      nuPackageId   NUMBER;
      nuMotiveId    NUMBER;
      onuErrorCode  NUMBER;

      dtFechaPro    DATE;
      sbGenera      VARCHAR2(1);
      dtFechaCrea   DATE;

      nuExisteActividad NUMBER;
      nuEMaximo NUMBER;

      --se consultan datos de la orden
      CURSOR cuGetdatOrden IS
        SELECT O.TASK_TYPE_ID,
                O.OPERATING_UNIT_ID,
                O.CAUSAL_ID,
                OA.ACTIVITY_ID,
                s.package_id,
                P.CATEGORY_ID,
                P.SUBCATEGORY_ID,
                nvl(S.PACKAGE_TYPE_ID,-1) PACKAGE_TYPE_ID,
                OA.PRODUCT_ID,
          oa.SUBSCRIPTION_ID,
                OA.SUBSCRIBER_ID,
                NVL(OA.ADDRESS_ID,O.EXTERNAL_ADDRESS_ID) ADDRESS_ID,
                (select c.order_comment from or_ordeR_comment c where c.order_id= o.order_id and c.legalize_comment='Y' and rownum=1) comentario
          From or_order o,
                or_order_activity oa
                left join mo_packages s on s.package_id=oa.package_id
                left join pr_product p on p.product_id=oa.product_id
          WHERE o.order_id = oa.order_id
            AND o.order_id = nuorden;



      regDatOrden cuGetdatOrden%ROWTYPE;

      CURSOR cuConfVSI IS
        SELECT C.COCLACTI, C.COCLMERE, c.COCLASAU, c.COCLDIAS, c.COCLCAME
          FROM LDC_COTTCLAC c
          WHERE (c.COCLTISO = regDatOrden.PACKAGE_TYPE_ID or c.COCLTISO = -1)
            AND c.COCLTITR = regDatOrden.TASK_TYPE_ID
            AND (c.COCLACPA = regDatOrden.ACTIVITY_ID or c.COCLACPA is null)
            AND (c.COCLCAUS = regDatOrden.CAUSAL_ID or c.COCLCAUS = -1)
            AND (c.COCLCATE = regDatOrden.CATEGORY_ID or c.COCLCATE = -1)
            AND (c.COCLSUCA = regDatOrden.SUBCATEGORY_ID or c.COCLSUCA is null);


      --CAMBIO 944
      CURSOR CUEXISTE(NUVALOR NUMBER, IsbPARAM_TITRACT_ERROR VARCHAR2) IS
        SELECT count(1) cantidad
          FROM DUAL
          WHERE NUVALOR IN
                (select to_number(column_value)
                  from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain(IsbPARAM_TITRACT_ERROR,
                                                                                            NULL),
                                                          ',')));
      nuExiste number := 0;

    CURSOR cuGetCliente(inucontrato NUMBER) IS
    SELECT suscclie
    FROM suscripc
    WHERE susccodi = inucontrato;

    nucliente NUMBER;
      ---------------------
    nuLevel     NUMBER(2);
    nuTraceOut  NUMBER(1);

        CURSOR cuPersona 
        (
            inuOrden  IN or_order.order_id%TYPE
        )
        IS
        SELECT  person_id
        FROM    or_order_stat_change a,sa_user b, ge_person c
        WHERE   b.mask = a.user_id
        AND     c.user_id = b.user_id
        AND     order_id = inuOrden
        AND     final_status_id = 8;

        CURSOR cuExisteActividad
        (
          inuorganizat_area_id IN LDC_POINTAT_ACT.organizat_area_id%TYPE,
          inuitems_id          IN LDC_POINTAT_ACT.items_id%TYPE
        )
        IS
        SELECT count(1)
        FROM LDC_POINTAT_ACT
        WHERE organizat_area_id = inuorganizat_area_id
        AND   items_id = inuitems_id;

        CURSOR cuMaximoActividad
        IS
        SELECT  MAX(pointat_act_id)
        FROM    LDC_POINTAT_ACT;
    BEGIN
      nuorden := inuOrden; --se obtiene orden que se esta legalizando

      nuExisteActividad := 0;

      dbms_output.put_line('INICIO PRPROCGENVSI ORDEN ' || nuorden);

      IF (cuPersona%ISOPEN) THEN
          CLOSE cuPersona;
      END IF;

      OPEN cuPersona(nuorden);
      FETCH  cuPersona INTO nuPersonIdsol;
      CLOSE cuPersona;

      dtFechaCrea := daor_order.fdtgetcreated_date(nuorden, null);
      --se carga informacion de la orden
      OPEN cuGetdatOrden;
      FETCH cuGetdatOrden
        INTO regDatOrden;
      IF cuGetdatOrden%NOTFOUND THEN
        sbmensa := 'No existe informacion de la orden ' || to_char(nuorden);
        pkg_Error.setErrorMessage(isbMsgErrr => sbmensa);
      END IF;
      CLOSE cuGetdatOrden;

      nuPersonId := ge_bopersonal.fnugetpersonid;
      --se obtiene punto de atencion
      gE_BOPERSONAL.GETCURRENTCHANNEL(nuPersonIdsol, ONUCHANNEL);

      gE_BOPERSONAL.GETCURRENTCHANNEL(nuPersonId, ONUCHANNELOT);

      sbObserva := substr('OSF2554 - Solicitud Generada por legalizacion de la orden #' || nuorden ||': '||regDatOrden.comentario,1,2000);
      dbms_output.put_line('sbmensa' || sbmensa);
      FOR reg IN cuConfVSI LOOP
        if regDatOrden.PRODUCT_ID is not null and reg.COCLCAME='S' then
            if LDC_BoProcesaOrdVMP.fsbValidaCambMed(regDatOrden.PRODUCT_ID, dtFechaCrea)='S' then
              sbGenera :='N';
            else
              sbGenera :='S';
            end if;
        else
            sbGenera :='S';
        end if;

        dbms_output.put_line('sbGenera' || sbGenera);
        dbms_output.put_line('reg.cocldias' || reg.cocldias);
        --cambio 263
        if ((reg.cocldias=0) and sbGenera='S')then

          --CAMBIO 944
            open CUEXISTE(daor_order.fnugettask_type_id(nuorden),'PARAM_TITRACT_ERROR');
            fetch CUEXISTE into nuExiste;
            close CUEXISTE;

          -----------------------------

          IF regDatOrden.SUBSCRIBER_ID IS NULL THEN
            IF regDatOrden.SUBSCRIPTION_ID IS NOT NULL THEN
              OPEN cuGetCliente(regDatOrden.SUBSCRIPTION_ID );
              FETCH cuGetCliente INTO nuCliente;
              CLOSE cuGetCliente;
            ELSE
              OPEN cuGetCliente(DAPR_PRODUCT.FNUGETSUBSCRIPTION_ID(regDatOrden.PRODUCT_ID,null ));
              FETCH cuGetCliente INTO nuCliente;
              CLOSE cuGetCliente;
            END IF;
          ELSE
            nuCliente := regDatOrden.SUBSCRIBER_ID;
          END IF;


          IF (cuExisteActividad%ISOPEN) THEN
              CLOSE cuExisteActividad;
          END IF;

          OPEN cuExisteActividad(ONUCHANNELOT, reg.COCLACTI);
          FETCH  cuExisteActividad INTO nuExisteActividad;
          CLOSE cuExisteActividad;

          IF (nuExisteActividad = 0) THEN

              IF (cuMaximoActividad%ISOPEN) THEN
                CLOSE cuMaximoActividad;
              END IF;

              OPEN cuMaximoActividad;
              FETCH  cuMaximoActividad INTO nuEMaximo;
              CLOSE cuMaximoActividad;

              nuEMaximo := nuEMaximo +1;
              
              INSERT INTO LDC_POINTAT_ACT VALUES (nuEMaximo,ONUCHANNELOT,reg.COCLACTI);

              dbms_output.put_line('nuEMaximo' || nuEMaximo);
          END IF;


          nuPackageId  := null;
          nuMotiveId   := null;
          onuErrorCode := null;
          sbmensa      := null;
          sbRequestXML := '<?xml version="1.0" encoding="ISO-8859-1"?>
                  <P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101 ID_TIPOPAQUETE="100101">
                  <CUSTOMER/>
                  <CONTRACT/>
                  <PRODUCT>' ||regDatOrden.PRODUCT_ID ||'</PRODUCT>
                  <FECHA_DE_SOLICITUD>' ||SYSDATE || '</FECHA_DE_SOLICITUD>
                  <ID>' || nuPersonIdsol ||'</ID>
                  <POS_OPER_UNIT_ID>' ||ONUCHANNEL ||'</POS_OPER_UNIT_ID>
                  <RECEPTION_TYPE_ID>' ||reg.COCLMERE ||'</RECEPTION_TYPE_ID>
                  <CONTACT_ID>' ||nuCliente/*regDatOrden.SUBSCRIBER_ID*/ ||'</CONTACT_ID>
                  <ADDRESS_ID>' ||regDatOrden.ADDRESS_ID ||'</ADDRESS_ID>
                  <COMMENT_>' || sbObserva ||'</COMMENT_>
                  <CONTRATO></CONTRATO>
                  <M_SOLICITUD_DE_TRABAJOS_PARA_UN_CLIENTE_100113>
                  <ITEM_ID>' ||reg.COCLACTI ||'</ITEM_ID>
                  <DIRECCION_DE_EJECUCION_DE_TRABAJOS>' ||regDatOrden.ADDRESS_ID ||'</DIRECCION_DE_EJECUCION_DE_TRABAJOS>
                  <C_GENERICO_22>
                  <C_GENERICO_10319/>
                  </C_GENERICO_22>
                  </M_SOLICITUD_DE_TRABAJOS_PARA_UN_CLIENTE_100113>
                  </P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101>';

          /*Ejecuta el XML creado*/
          api_registerRequestByXml(sbRequestXML,
                                    nuPackageId,
                                    nuMotiveId,
                                    onuErrorCode,
                                    sbmensa);


          dbms_output.put_line('onuErrorCode['|| onuErrorCode ||']');
          dbms_output.put_line('onuErrorCode['|| sbmensa ||']');
          dbms_output.put_line('nuPackageId['|| nuPackageId ||']');

          IF (nuExisteActividad = 0) THEN

              dbms_output.put_line('nuEMaximo 2' || nuEMaximo);
              DELETE FROM LDC_POINTAT_ACT
              WHERE organizat_area_id = ONUCHANNELOT
              AND   items_id = reg.COCLACTI;
          END IF;

          IF nupackageid IS NULL THEN
              dbms_output.put_line('sbRequestXML' || sbRequestXML);
              RAISE pkg_Error.controlled_error;
          ELSE

            IF reg.COCLASAU = 'S' THEN
              insert into LDC_BLOQ_LEGA_SOLICITUD
                (PACKAGE_ID_ORIG, PACKAGE_ID_GENE)
              values
                (regDatOrden.package_id, nuPackageId);

              INSERT INTO LDC_ORDEASIGPROC
                (ORAPORPA,
                  ORAPSOGE,
                  ORAOPELE,
                  ORAOUNID,
                  ORAOCALE,
                  ORAOITEM,
                  ORAOPROC)
              VALUES
                (nuorden,
                  nuPackageId,
                  DAOR_ORDER_PERSON.FNUGETPERSON_ID(regDatOrden.OPERATING_UNIT_ID,
                                                    nuorden),
                  regDatOrden.OPERATING_UNIT_ID,
                  regDatOrden.causal_id,
                  null,
                  'SEVAASAU');
            ELSE
              INSERT INTO LDC_ORDEASIGPROC
                (ORAPORPA,
                  ORAPSOGE,
                  ORAOPELE,
                  ORAOUNID,
                  ORAOCALE,
                  ORAOITEM,
                  ORAOPROC)
              VALUES
                (nuorden,
                  nuPackageId,
                  DAOR_ORDER_PERSON.FNUGETPERSON_ID(regDatOrden.OPERATING_UNIT_ID,
                                                    nuorden),
                  NULL,
                  regDatOrden.causal_id,
                  null,
                  'SEVAASAU');

            END IF;
          END IF;
        Else
          if sbGenera='S' then
            dtFechaPro := trunc(sysdate) + reg.cocldias;
            IF reg.COCLASAU = 'S' THEN
              INSERT INTO LDC_GEN_VSIXJOB(COCLORDE, COCLACTI, COCLUNID, COCLMERE, COCLPROD,	COCLCOME, COCLDIRE, COCLFEPR, COCLPERS, COCLCAME)
              VALUES(nuorden, reg.COCLACTI, regDatOrden.OPERATING_UNIT_ID, reg.COCLMERE, regDatOrden.PRODUCT_ID, sbObserva,regDatOrden.ADDRESS_ID, dtFechaPro , nuPersonIdsol, reg.COCLCAME);
            ELSE
              INSERT INTO LDC_GEN_VSIXJOB(COCLORDE, COCLACTI, COCLUNID, COCLMERE, COCLPROD,	COCLCOME, COCLDIRE, COCLFEPR, COCLPERS, COCLCAME)
              VALUES(nuorden, reg.COCLACTI, null, reg.COCLMERE, regDatOrden.PRODUCT_ID, sbObserva,regDatOrden.ADDRESS_ID, dtFechaPro, nuPersonIdsol, reg.COCLCAME );
          End if;
          end if;
        End if;
      END LOOP;

      dbms_output.put_line('FIN PRPROCGENVSI ' || sbmensa);
    EXCEPTION
      WHEN pkg_Error.controlled_error THEN
        --CAMBIO 944
        IF nuExiste = 1 THEN
          raise;
        ELSE
          pkg_Error.getError(onuErrorCode, sbmensa);
        END IF;
        ----------------------------------
      WHEN OTHERS THEN
        pkg_Error.setError;
        RAISE pkg_Error.controlled_error;

    END PRPROCGENVSI;
BEGIN
  dbms_output.put_line('Inicia Datafix 2554');
	FOR reg IN cuConfiguracion LOOP
      dbms_output.put_line('reg.cocltitr '||reg.cocltitr);
      dbms_output.put_line('reg.coclacpa '||reg.coclacpa);
      dbms_output.put_line('reg.coclcaus '||reg.coclcaus);
		  FOR rcOrdenes IN cuOrdenes(reg.cocltitr, reg.coclacpa,reg.coclcaus, reg.coclacti ) LOOP
          dbms_output.put_line('Order procesada '||rcOrdenes.order_id);
          PRPROCGENVSI(rcOrdenes.order_id);
          commit;
      END LOOP;
	END LOOP;

  dbms_output.put_line('FIN Datafix 2554');
  commit;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/