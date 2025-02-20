declare
  cursor cuItem is 
  select *
  from open.ge_items@OSFPL i
  where items_id in (100010522)
    and not exists(select null from open.ge_items i2 where i2.items_id=i.items_id);
    
  cursor cuActividad(nuItem number) is
  select *
  from open.or_actividad@OSFPL a
  where a.id_actividad=nuItem
     and not exists(select null from open.or_actividad a2 where a2.id_actividad=a.id_actividad);
  sbPaso varchar2(100);
  
  
  cursor CuAtributos(nuItem number) is
  select *
  from open.ge_items_attributes@OSFPL a 
  where a.items_id=nuItem;
  
  cursor cuNoveadad(nuItem number) is
  select *
  from open.ct_item_novelty n
  where n.items_id=nuItem;
begin
  for reg in cuItem loop
      begin
      sbPaso := 'Insertar item '||reg.items_id;
      insert into ge_items values(reg.ITEMS_ID, reg.DESCRIPTION,reg.ITEM_CLASSIF_ID,reg.MEASURE_UNIT_ID,reg.TECH_CARD_ITEM_ID,reg.CONCEPT,reg.OBJECT_ID,reg.USE_,reg.ELEMENT_TYPE_ID,
                                  reg.ELEMENT_CLASS_ID, reg.STANDARD_TIME, reg.WARRANTY_DAYS, reg.DISCOUNT_CONCEPT, reg.ID_ITEMS_TIPO, reg.OBSOLETO, reg.PROVISIONING_TYPE, reg.PLATFORM,
                                  reg.RECOVERY, reg.RECOVERY_ITEM_ID, reg.INIT_INV_STATUS_ID, reg.SHARED, reg.CODE);
                                  

      for reg2 in cuActividad(reg.items_id) loop 
        sbPaso :='Error insertar activivdad '||reg.items_id;
        insert into or_actividad values(reg2.ID_ACTIVIDAD,reg2.ACTIVID_COMPENSACION, reg2.OBJETO_COMPENSACION, reg2.CANTIDAD_DEFECTO, reg2.LEGALIZA_MULTIPLE, reg2.ANULABLE, reg2.TIEMPO_VIDA,
                                        reg2.PRIORIDAD_DESPACHO, reg2.ACTIVA,reg2.PRIORIDAD);
       
       for reg3 in CuAtributos(reg.ITEMS_ID) loop
                  insert into ge_items_attributes
           (ITEMS_ID,
            ATTRIBUTE_1_ID,
            INIT_EXPRESSION_1_ID,
            VALID_EXPRESSION_1_ID,
            STATEMENT_1_ID,
            COMPONENT_1_ID,
            ATTRIBUTE_2_ID,
            INIT_EXPRESSION_2_ID,
            VALID_EXPRESSION_2_ID,
            STATEMENT_2_ID,
            COMPONENT_2_ID,
            ATTRIBUTE_3_ID,
            INIT_EXPRESSION_3_ID,
            VALID_EXPRESSION_3_ID,
            STATEMENT_3_ID,
            COMPONENT_3_ID,
            ATTRIBUTE_4_ID,
            INIT_EXPRESSION_4_ID,
            VALID_EXPRESSION_4_ID,
            STATEMENT_4_ID,
            COMPONENT_4_ID,
            REQUIRED1,
            REQUIRED2,
            REQUIRED3,
            REQUIRED4)
         values
           (reg3.ITEMS_ID,
            reg3.ATTRIBUTE_1_ID,
            reg3.INIT_EXPRESSION_1_ID,
            reg3.VALID_EXPRESSION_1_ID,
            reg3.STATEMENT_1_ID,
            reg3.COMPONENT_1_ID,
            reg3.ATTRIBUTE_2_ID,
            reg3.INIT_EXPRESSION_2_ID,
            reg3.VALID_EXPRESSION_2_ID,
            reg3.STATEMENT_2_ID,
            reg3.COMPONENT_2_ID,
            reg3.ATTRIBUTE_3_ID,
            reg3.INIT_EXPRESSION_3_ID,
            reg3.VALID_EXPRESSION_3_ID,
            reg3.STATEMENT_3_ID,
            reg3.COMPONENT_3_ID,
            reg3.ATTRIBUTE_4_ID,
            reg3.INIT_EXPRESSION_4_ID,
            reg3.VALID_EXPRESSION_4_ID,
            reg3.STATEMENT_4_ID,
            reg3.COMPONENT_4_ID,
            reg3.required1,
            reg3.required2,
            reg3.required3,
            reg3.required4);

       
       end loop;
       for reg3 in cuNoveadad(reg.items_id) loop
         insert into ct_item_novelty(ITEMS_ID,LIQUIDATION_SIGN,COMMENT_) values(reg3.ITEMS_ID,reg3.LIQUIDATION_SIGN,reg3.COMMENT_);
         
       end loop;
      end loop; 
      commit;
     exception
        when others then
          rollback;
          dbms_output.put_line('Error al '||sbPaso ||' '|| sqlerrm);
     end;
     end loop;
     commit;
end;
