declare
  nuRoleId      number         := SA_BOROLE.GETNEXTID;;
  sbNameRole     varchar2(4000) := 'ROL GENERICO GUAJIRA';
  sbDescRole     varchar2(4000) := 'ROL GENERICO GUAJIRA';
  nuRoleType     number         := 4;
  nuUserOwner   number         := null;
  
  
  cursor cuUnidadesGuajira is
  select operating_unit_id
  from or_operating_unit u
  where u.admin_base_id = 25
    and u.oper_unit_classif_id =11;

  
begin
    insert into sa_role(role_id, name, description, role_type_id, user_owner_id)
                 values(nuRoleId, sbNameRole, sbDescRole, nuRoleType, nuUserOwner);
    insert into or_actividades_rol(id_actividad_rol, id_rol, id_actividad) 
    select GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('OR_ACTIVIDADES_ROL', 'SEQ_OR_ACTIVIDADES_ROL'),nuRoleId ,i.items_id
      from ge_items i 
      where i.item_classif_id=2
        and not exists(select null from ct_item_novelty n where n.items_id=i.items_id)
        and (select count(1) from open.or_task_types_items ti where ti.items_id=i.items_id)=1;
        
     for reg in cuUnidadesGuajira loop
         begin
             OR_BCRolUnidadTrab.InsTasTypOpeUni(Inuroleid => nuRoleId,Inuoperunitid => reg.operating_unit_id);
         exception
           when others then
             dbms_output.put_line(sqlerrm);
         end;
     end loop;   
                      
exception
  when others then 
    rollback;
    dbms_output.put_line(sqlerrm);
end;
/

