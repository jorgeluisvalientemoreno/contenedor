CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGGETRAMSACRP
FOR  INSERT OR UPDATE OF ORDER_ID ON OR_ORDER_ACTIVITY
 COMPOUND TRIGGER

	/*****************************************************************
	Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        20-02-2021   Olsoftware             Caso 652: se Modifican los cursores cuvalact para validar que la actividad nueva se diferente a la registrada
											                      en la tabla LDC_ACTIVI_BY_PACK_TYPE y cuvalcomt para agregar una validacion con respecto a la solicitud

	******************************************************************/



    nuOrden         open.or_order.order_id%TYPE;
    nuCliente       open.ge_subscriber.subscriber_id%TYPE;
    nuAddress       open.ab_address.address_id%TYPE;
    nuSolicit       open.mo_packages.package_id%TYPE;
    nuActivid       open.ge_items.items_id%TYPE;
    nuProduct       open.pr_product.product_id%TYPE;
    nuContrato      open.suscripc.susccodi%TYPE;
    sbObserva       open.mo_packages.comment_%TYPE;
    nuValMed        NUMBER := 0;
    nuRegistra      NUMBER := 0;
    nuValComSac     NUMBER := 0;
    nuOrdenPadre    NUMBER;
    sbAplica44      VARCHAR2(1):='N';
    sbAplica652     VARCHAR2(1):='N';
    sbEntra         VARCHAR2(1);
    nuTitrOtPad     open.or_task_type.task_type_id%type;
    sbParTitr       open.ldc_pararepe.paravast%type := ','||open.daldc_pararepe.fsbGetPARAVAST('LDC_PARTITRNOTIF', null)||',';


    --Se valida si la actividad registrada tiene configuracion sac
    cursor cuValidaActividadSac is
    SELECT /*+ INDEX (IDX_OR_ORDER_ACTIVITY18 OA )*/
           nuCliente subscriber_id,
           p.reception_type_id ,
           nuAddress address_id,
           p.package_id,
           s.activity_id,
           p.comment_||', orden generada '||nuOrden comentario,
           trim(substr(upper(p.comment_),instr(upper(p.comment_),'LEGALIZADA :')+12, instr(upper(p.comment_),'CON CAUSAL')-(instr(upper(p.comment_),'LEGALIZADA :')+12) )) orden
      FROM open.mo_packages p,
           open.ldc_activi_by_pack_type s
      WHERE nuSolicit= p.package_id
        and s.package_type_id = open.dald_parameter.fnugetnumeric_value('SOL_REVPER_SAC', NULL) --- 100306
        and s.actividades_rev_per is not null
        and nuActivid != s.activity_id
        and nuActivid IN ( SELECT to_number(column_value)
                               FROM TABLE(open.ldc_boutilities.splitstrings(s.ACTIVIDADES_REV_PER,',') ));

    regOrdenes cuValidaActividadSac%ROWTYPE;
    --Se valida si el medio de recepcion de la solicitud esta en el parametro
    cursor cuvalmerec(MEDIO NUMBER) is
    SELECT 1
    FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('LDC_MEDIRECSAC',NULL),','))
    where to_number(column_value)= MEDIO;


	--Se valida si la orden esta marcada con solicitud sac
	cursor cuvalcomt(nuOT open.or_order.order_id%type) is
  select 1
    from open.or_order_comment oc
   where oc.comment_type_id= open.dald_parameter.fnuGetNumeric_Value('PARAM_TIPCON_OT_SACSUSP')
     and  oc.order_id = nuOt;



   cursor cuComenSolSac(nuOt NUMBER) IS
    select S.COMMENT_
    from LDC_ASIGNA_UNIDAD_REV_PER sr, mo_packages s
    where orden_trabajo=nuOt
      and PACKAGE_ID = SOLICITUD_GENERADA;


   -- Se lanzar? despu?s de cada fila actualizada
  AFTER EACH ROW IS
  BEGIN
        if (:OLD.order_id is null AND :NEW.order_id is not null) then
          sbEntra := 'S';
        else
          sbEntra := 'N';
        end if;
        if sbEntra = 'S' then
          --Se valida si la entrega del cambio 44 aplica
          IF fblAplicaEntregaxCaso('0000044') THEN
            sbAplica44 :='S';
          else
            sbAplica44 :='N';
          END IF;
          IF fblAplicaEntregaxCaso('0000652') THEN
            sbAplica652 :='S';
          else
            sbAplica652 :='N';
          END IF;
          ut_trace.trace('LDC_TRGGETRAMSACRP-> sbAplica44:'||sbAplica44,10);
          ut_trace.trace('LDC_TRGGETRAMSACRP-> sbAplica652:'||sbAplica652,10);
          --Se guardan los datos de la orden
          if sbAplica44 = 'S' then
            nuOrden   := :new.order_id;
            nuCliente := :NEW.subscriber_id;
            nuAddress := :NEW.address_id;
            nuSolicit := :NEW.package_id;
            nuActivid := :NEW.activity_id;
            nuProduct := :NEW.product_id;
            nuContrato:= :NEW.Subscription_Id;
            ut_trace.trace('LDC_TRGGETRAMSACRP-> nuOrden:'||nuOrden,10);
          end if;
        end if;
  Exception
  when ex.CONTROLLED_ERROR then
    raise;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
  END AFTER EACH ROW;
  AFTER STATEMENT IS
  BEGIN
     if sbAplica44 = 'S' and sbEntra = 'S' then

        open cuValidaActividadSac;
  	    fetch cuValidaActividadSac into regOrdenes ;
        IF cuValidaActividadSac%FOUND THEN
          ut_trace.trace('LDC_TRGGETRAMSACRP-->regOrdenes.PACKAGE_ID:'||regOrdenes.PACKAGE_ID,10);


          Open cuvalmerec(regOrdenes.reception_type_id);
          fetch cuvalmerec INTO nuValMed;
          close cuvalmerec;
          ut_trace.trace('LDC_TRGGETRAMSACRP-->nuValMed:'||nuValMed,10);


          BEGIN
            nuOrdenPadre:=regOrdenes.orden;
            ut_trace.trace('LDC_TRGGETRAMSACRP-->nuOrdenPadre:'||nuOrdenPadre,10);
          EXCEPTION
            when others then
              nuOrdenPadre:=NULL;
              ut_trace.trace('LDC_TRGGETRAMSACRP-->nuOrdenPadre:Eror al obtener orden padre',10);
          END;

          If nuValMed = 1 Then
            nuRegistra:=1;
            sbObserva := substr(regOrdenes.comentario,1,1999);
          Else
            OPEN cuComenSolSac(nuOrdenPadre);
            FETCH cuComenSolSac INTO sbObserva;
            IF  cuComenSolSac%NOTFOUND THEN
              sbObserva := substr(regOrdenes.comentario,1,1999);
            END IF;
            CLOSE cuComenSolSac;


            open cuvalcomt(nuOrdenPadre);
            fetch cuvalcomt INTO nuValComSac;
            if cuvalcomt%found then
               --Se valida si el tipo de trabajo de la orden padre se encuentra en el parametro LDC_PARTITRNOTIF
               if sbAplica652 ='S' then
                 begin
                   nuTitrOtPad :=open.daor_order.fnugettask_type_id(nuOrdenPadre, null);
                 exception
                   when others then
                     nuTitrOtPad:=null;
                 end;
                 ut_trace.trace('LDC_TRGGETRAMSACRP-->nuTitrOtPad:'||nuTitrOtPad,10);
                 ut_trace.trace('LDC_TRGGETRAMSACRP-->sbParTitr:'||sbParTitr,10);
                 if nuTitrOtPad is not null then
                   if instr(sbParTitr,nuTitrOtPad) > 0 then
                     nuRegistra := 1;
                   else
                     nuRegistra := 0;
                   end if;
                 else
                   nuRegistra := 0;
                 end if;--if nuTipoSolPad is not null then
              else
              --sino aplica la entrega para la gasera
                nuRegistra := 1;
              end if; --if sbAplica652 ='S' then
            end if;--if cuvalcomt%found then
            close cuvalcomt;
          End if;--If nuValMed = 1 Then
        End if; --IF cuValidaActividadSac%FOUND THEN
        close cuValidaActividadSac;
        If nuRegistra =1 Then
               INSERT INTO LDC_GENSAC(PACKAGE_ID,
                                       ACTIVITY_ID,
                                       ORDER_ID,
                                       PRODUCT_ID,
                                       SUBSCRIPTION_ID,
                                       ADDRESS_ID,
                                       FLAG,
                                       OBSERVACION,
                                       FECHA_REGISTRO)  --- cambio 652
                    VALUES(nuSolicit,
                           regOrdenes.ACTIVITY_ID,
                           nuOrden,
                           nuProduct,
                           nuContrato,
                           nuAddress,
                           'N',
                           sbObserva,
                           SYSDATE);  --- cambio 652
        End If;--If nuRegistra =1 Then
     end if;--if sbAplica44 = 'S' then
  Exception
  when ex.CONTROLLED_ERROR then
    raise;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
  End AFTER STATEMENT;


END;
/
