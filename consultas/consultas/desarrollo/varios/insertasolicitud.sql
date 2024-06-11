declare

 CURSOR cuProductos is
    SELECT distinct pr_prod_suspension.product_id
      FROM open.pr_prod_suspension
      WHERE pr_prod_suspension.active = 'Y'
          AND pr_prod_suspension.suspension_type_id =  102
      minus
      SELECT distinct pr_prod_suspension.product_id
      FROM open.pr_prod_suspension, open.mo_motive, open.mo_packages, open.or_order_activity,open.or_activ_defect
      WHERE pr_prod_suspension.active = 'Y'
          AND pr_prod_suspension.suspension_type_id =  102
          AND pr_prod_suspension.product_id = mo_motive.product_id
          AND mo_motive.package_id = mo_packages.package_id
          AND mo_packages.package_type_id = 265
          AND mo_packages.package_id = or_order_activity.package_id
          AND or_order_activity.task_type_id = 12161
          AND or_order_activity.order_activity_id = or_activ_defect.order_activity_id;
          
        inuProduct_id   pr_product.product_id%type;
        dtRequestDate   mo_packages.request_date%type:=sysdate;
        isbOrderComme   varchar2(4000):='Orden insertada con aranda 144180 para generar defectos a suspendidos';
        onuPackage_id   number;

        nuPackage_id    number; --:= ge_bosequence.fnugetnextvalsequence('MO_PACKAGES','SEQ_MO_PACKAGES');
        nuMotive_id     number; --:= ge_bosequence.fnugetnextvalsequence('MO_MOTIVE','SEQ_MO_MOTIVE');
        nuOrder_id      number; --:= ge_bosequence.fnugetnextvalsequence('OR_ORDER','SEQ_OR_ORDER');
        nuOrderActivity_id number; --:= ge_bosequence.fnugetnextvalsequence('OR_ORDER_ACTIVITY','SEQ_OR_ORDER_ACTIVITY');
        nuSubscriber_id number;
        nuSubscription  number;
        nuCommentType   number:=1277;
        nuactiv_defect_id number;
        nuErrorCode       number;
        sbErrorMesse      varchar2(4000);
    BEGIN
       for reg in cuProductos loop
          inuProduct_id   := reg.product_id;
          nuPackage_id    := ge_bosequence.fnugetnextvalsequence('MO_PACKAGES','SEQ_MO_PACKAGES');
          nuMotive_id     := ge_bosequence.fnugetnextvalsequence('MO_MOTIVE','SEQ_MO_MOTIVE');
          nuOrder_id      := ge_bosequence.fnugetnextvalsequence('OR_ORDER','SEQ_OR_ORDER');
          nuOrderActivity_id := ge_bosequence.fnugetnextvalsequence('OR_ORDER_ACTIVITY','SEQ_OR_ORDER_ACTIVITY');
          onuPackage_id :=  nuPackage_id;

          nuSubscriber_id := pr_boproduct.fnugetsubscbyservnum(inuProduct_id);
          nuSubscription  := pktblservsusc.fnugetsesususc(inuProduct_id);
          nuactiv_defect_id := Ge_Bosequence.fnugetnextvalsequence('OR_ACTIV_DEFECT','SEQ_OR_ACTIV_DEFECT_156818');
          -- Inserta solicitud

          INSERT INTO mo_packages
                  (package_id,request_date,messag_delivery_date, user_id,contact_id,subscriber_id,
                  terminal_id, client_privacy_flag,package_type_id, motive_status_id,
                  comm_exception, cust_care_reques_num,tag_name,company_id,comment_)
          VALUES (nuPackage_id,decode(dtRequestDate,null,sysdate,dtRequestDate),
                  decode(dtRequestDate,null,sysdate,dtRequestDate),'MIGRA',nuSubscriber_id,nuSubscriber_id,'MIGRACION','N',
                  265,14,'N',nuPackage_id,'P_REVISION_PERIODICA_MASIVA_265 Preguntar',99,
                  'Solicitud Creada Manualmente con aranda 144180');

          -- Inserta Motivo
          INSERT INTO mo_motive
                  (motive_id,privacy_flag,client_privacy_flag,provisional_flag, IS_mult_product_flag,
                  authoriz_letter_flag, partial_flag,priority,motiv_recording_date,custom_decision_flag,
                  product_motive_id,motive_type_id,motive_status_id,package_id,cust_care_reques_num,
                  tag_name,is_immediate_attent, product_id)
          VALUES (nuMotive_id,'N','N','N','N','N','N',100,sysdate,'N',24,13,11,nuPackage_id,nuPackage_id,
                 'M_REVISION_PERIODICA_24','Y',inuProduct_id);

          -- Inserta Orden
          INSERT INTO or_order
                  (order_id,created_date,order_status_id,task_type_id,is_countermand,
                  order_cost_average,order_cost_by_list,operative_aiu_value,admin_aiu_value,
                  charge_status,causal_id)
          VALUES  (nuOrder_id,sysdate,8,12161,'N',0,0,0,0,1,3299);

          -- Inserta Actividad
          INSERT INTO or_order_activity
                  (order_activity_id,status,task_type_id,order_id,package_id,product_id,subscription_id,comment_,register_date)
          VALUES  (nuOrderActivity_id,'F',12161,nuOrder_id,nuPackage_id,inuProduct_id,nuSubscription,
                  'Orden creada manualmente con aranda 144180',dtRequestDate);

          -- Inserta defectos
          INSERT INTO or_Activ_defect
                  (activ_defect_id, order_activity_id, defect_id)
          VALUES  (nuactiv_defect_id, nuOrderActivity_id, 85);
          
          -- crea el comentario
          OS_ADDORDERCOMMENT (nuOrder_id, nuCommentType, isbOrderComme, nuErrorCode,sbErrorMesse);
       end loop;
        commit;
    EXCEPTION
        when others then
            Errors.getError( nuErrorCode,sbErrorMesse);
            --setRowError('CreateRequest: '|| sbErrorMesse||' '||sqlerrm);
            dbms_output.put_line(sqlerrm);
    END CreateReque;
