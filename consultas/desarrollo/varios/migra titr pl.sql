declare
  sbMIgraqh varchar2(1) := 'S';
  nuevoCodigoTitr varchar2(1):='N';
  nuTitr          open.or_task_type.task_type_id%type;
  nuExiste          number;
  sbContinua        varchar2(1):='N';
  cursor cuTipoTrab is
    select  TASK_TYPE_ID,DESCRIPTION,SHORT_NAME,IS_ANULL,TRY_AUTOM_ASSIGMENT,USES_OPER_SECTOR,TASK_TYPE_CLASSIF,ADD_ITEMS_ALLOWED,ADD_NET_ALLOWED,COMMENT_REQUIRED,WARRANTY_PERIOD,CONCEPT,SOLD_ENGINEERING_SER,PRIORITY,NODAL_CHANGE,ARRANGED_HOUR_ALLOWED,OBJECT_ID,TASK_TYPE_GROUP_ID,WORK_DAYS,COMPROMISE_CRM,USE_,NOTIFICABLE,GEN_ADMIN_ORDER,UPD_ITEMS_ALLOWED,PRINT_FORMAT_ID
      from open.or_task_type@OSFPL  i
     where task_type_id in (&TipoTrabajo   )
    --and not exists(select null from open.or_task_type@sfbz0707 i2 where i2.task_type_id=i.task_type_id and sbMIgraqh='N')
    ;
  cursor cuTitrQh(nuTitr number) is
  select count(1)
   from open.or_task_type
   where task_type_id=nuTitr;
   
  cursor cuItesmTitr(nuTitr number) is
    select *
      from open.or_task_types_items@OSFPL ti
     where ti.task_type_id = nuTitr;
     
  cursor cuGeItemsQh(nuItems number) is 
  select count(1)
  from open.ge_items
  where items_id=nuItems;

  cursor cuCausalTitr(nuTitr number) is
    select *
      from open.or_task_type_causal@OSFPL tc
     where tc.task_type_id = nuTitr;
     
  cursor cuGetCausalQh(nuCausal number) is
  select count(1)
  from open.ge_causal c
  where c.causal_id=nuCausal;
  

begin
  nuExiste := 0;
  
  select count(1)
  into nuExiste
  from open.or_task_type
  where task_type_id=&TipoTrabajo;
  
  if nuExiste > 0 then
    
    select count(1)
      into nuExiste
      from open.or_task_type t
      inner join open.or_task_type@osfpl t2 on t2.task_type_id=t.task_type_id and t2.description != t.description
      where t.task_type_id=&TipoTrabajo;
      
      if nuExiste > 0 then
          dbms_output.put_line('Tipo de trabajo ya existe');
          sbContinua :='N';
      else
        ---nuTitr := SEQ_OR_TASK_TYPE_4498.NEXTVAL;
        dbms_output.put_line('Codigo usado, nuevo titr: '||nuTitr);
        sbContinua :='N';
      end if;
  else
    select task_type_id
      into nuTitr
      from open.or_task_type@osfpl
      where task_type_id=&TipoTrabajo;
      dbms_output.put_line('Codigo disponible, nuevo titr: '||nuTitr);
      sbContinua :='S';
  end if;

  if sbContinua = 'S' then
  
  for reg in cuTipoTrab loop
    
    
    DBMS_OUTPUT.PUT_LINE('TITR :'||nuTitr);
    nuExiste:=0;
      begin
        insert into or_task_type
          (TASK_TYPE_ID,
           DESCRIPTION,
           SHORT_NAME,
           IS_ANULL,
           TRY_AUTOM_ASSIGMENT,
           USES_OPER_SECTOR,
           TASK_TYPE_CLASSIF,
           ADD_ITEMS_ALLOWED,
           ADD_NET_ALLOWED,
           COMMENT_REQUIRED,
           WARRANTY_PERIOD,
           CONCEPT,
           SOLD_ENGINEERING_SER,
           PRIORITY,
           NODAL_CHANGE,
           ARRANGED_HOUR_ALLOWED,
           OBJECT_ID,
           TASK_TYPE_GROUP_ID,
           WORK_DAYS,
           COMPROMISE_CRM,
           USE_,
           NOTIFICABLE,
           GEN_ADMIN_ORDER,
           UPD_ITEMS_ALLOWED,
           PRINT_FORMAT_ID)
        values
          (nuTitr,
           reg.DESCRIPTION,
           reg.SHORT_NAME,
           reg.IS_ANULL,
           reg.TRY_AUTOM_ASSIGMENT,
           reg.USES_OPER_SECTOR,
           reg.TASK_TYPE_CLASSIF,
           reg.ADD_ITEMS_ALLOWED,
           reg.ADD_NET_ALLOWED,
           reg.COMMENT_REQUIRED,
           reg.WARRANTY_PERIOD,
           reg.CONCEPT,
           reg.SOLD_ENGINEERING_SER,
           reg.PRIORITY,
           reg.NODAL_CHANGE,
           reg.ARRANGED_HOUR_ALLOWED,
           reg.OBJECT_ID,
           reg.TASK_TYPE_GROUP_ID,
           reg.WORK_DAYS,
           reg.COMPROMISE_CRM,
           reg.USE_,
           reg.NOTIFICABLE,
           reg.GEN_ADMIN_ORDER,
           reg.UPD_ITEMS_ALLOWED,
           reg.PRINT_FORMAT_ID);
           insert into ct_tasktype_contype select SQ_LDC_TASKTYPE_CONTYPE_HIST.Nextval,CONTRACT_TYPE_ID, nuTitr,CONTRACT_ID,FLAG_TYPE from open.ct_tasktype_contype@osfpl where task_type_id=Reg.task_type_id;
        
      
        /* insert into or_task_type@sfbz0707(TASK_TYPE_ID,DESCRIPTION,SHORT_NAME,IS_ANULL,TRY_AUTOM_ASSIGMENT,USES_OPER_SECTOR,TASK_TYPE_CLASSIF,ADD_ITEMS_ALLOWED,ADD_NET_ALLOWED,COMMENT_REQUIRED,WARRANTY_PERIOD,CONCEPT,
                     SOLD_ENGINEERING_SER,PRIORITY,NODAL_CHANGE,ARRANGED_HOUR_ALLOWED,OBJECT_ID,TASK_TYPE_GROUP_ID,WORK_DAYS,COMPROMISE_CRM,USE_,NOTIFICABLE,GEN_ADMIN_ORDER,UPD_ITEMS_ALLOWED,PRINT_FORMAT_ID)
        values(reg.TASK_TYPE_ID,reg.DESCRIPTION,reg.SHORT_NAME,reg.IS_ANULL,reg.TRY_AUTOM_ASSIGMENT,reg.USES_OPER_SECTOR,reg.TASK_TYPE_CLASSIF,reg.ADD_ITEMS_ALLOWED,reg.ADD_NET_ALLOWED,reg.COMMENT_REQUIRED,reg.WARRANTY_PERIOD,reg.CONCEPT,
                     reg.SOLD_ENGINEERING_SER,reg.PRIORITY,reg.NODAL_CHANGE,reg.ARRANGED_HOUR_ALLOWED,reg.OBJECT_ID,reg.TASK_TYPE_GROUP_ID,reg.WORK_DAYS,reg.COMPROMISE_CRM,reg.USE_,reg.NOTIFICABLE,reg.GEN_ADMIN_ORDER,reg.UPD_ITEMS_ALLOWED,reg.PRINT_FORMAT_ID);*/
        for reg2 in cuItesmTitr(reg.task_type_id) loop
          nuExiste:=0;
          open cuGeItemsQh(reg2.items_id);
          fetch cuGeItemsQh into nuExiste;
          close cuGeItemsQh;
          
          if nuExiste = 0 then
            insert into ge_items select * from open.ge_items@osfpl where items_id=reg2.items_id;
            insert into or_actividad select * from open.or_actividad@osfpl where id_actividad=reg2.items_id;
            insert into ct_item_novelty  select * from open.ct_item_novelty@osfpl where items_id=reg2.items_id;
            insert into ge_items_attributes select * from open.ge_items_attributes@osfpl where items_id=reg2.items_id;
            savepoint a;
            begin
               insert into or_actividades_rol select SEQ_OR_ACTIVIDADES_ROL.NEXTVAL,ID_ROL, ID_ACTIVIDAD from open.or_actividades_rol@osfpl where ID_ACTIVIDAD=reg2.items_id;
               --arreglar este insert
               insert into or_actividades_rol select SEQ_OR_ACTIVIDADES_ROL.NEXTVAL,ID_ROL, ID_ACTIVIDAD from open.or_actividades_rol@osfpl where ID_ACTIVIDAD in (100010520, 100010521, 100010522);
               insert into open.or_ope_uni_task_type select * from open.or_ope_uni_task_type@osfpl where task_type_id in (select distinct task_type_id from open.or_task_types_items where items_id in (100010520, 100010521, 100010522));
            exception
              when others then
                rollback to a;
                dbms_output.put_line('Error al asociar a roles');
            end; 
            insert into or_task_types_items
              (TASK_TYPE_ID,
               ITEMS_ID,
               ITEM_AMOUNT,
               IS_LEGALIZE_VISIBLE,
               DISPLAY_ORDER,
               COMPANY_KEY)
            values
              (reg2.TASK_TYPE_ID,
               reg2.ITEMS_ID,
               reg2.ITEM_AMOUNT,
               reg2.IS_LEGALIZE_VISIBLE,
               reg2.DISPLAY_ORDER,
               reg2.COMPANY_KEY);
          
          /*insert into or_task_types_items@sfbz0707(TASK_TYPE_ID,ITEMS_ID,ITEM_AMOUNT,IS_LEGALIZE_VISIBLE,DISPLAY_ORDER,COMPANY_KEY) values
                                                       (reg2.TASK_TYPE_ID,reg2.ITEMS_ID,reg2.ITEM_AMOUNT,reg2.IS_LEGALIZE_VISIBLE,reg2.DISPLAY_ORDER,reg2.COMPANY_KEY);*/
          
          
          else
            dbms_output.put_line('El item '||reg2.items_id||' ya existe');
          end if;
        end loop;
        for reg2 in cuCausalTitr(reg.task_type_id) loop
          nuExiste := 0;
          open cuGetCausalQh(reg2.causal_id);
          fetch cuGetCausalQh into nuExiste;
          close cuGetCausalQh;
          if nuExiste = 0 then
            insert into ge_causal select * from open.ge_causal@osfpl where causal_id=reg2.causal_id;
          end if;
          insert into or_task_type_causal
            (TASK_TYPE_ID, CAUSAL_ID, COMPANY_KEY)
          values
            (nuTitr, reg2.CAUSAL_ID, reg2.COMPANY_KEY);
        
        -- insert into or_task_type_causal@sfbz0707(TASK_TYPE_ID,CAUSAL_ID,COMPANY_KEY) values(reg2.TASK_TYPE_ID,reg2.CAUSAL_ID,reg2.COMPANY_KEY);
        end loop;
    
      commit;
      exception
        when others then
          rollback;
        
      end;
  end loop;
  --commit;
  end if;
end;
