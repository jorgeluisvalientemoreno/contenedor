declare
  cursor cuDatos is
  select *
  from open.OR_OPE_UNI_ITEM_BALA m
  --where m.operating_unit_id=3116
  where items_id not like '4%'
  AND OPERATING_UNIT_ID NOT IN (799,79)
  AND OPERATING_UNIT_ID IN (
1371,
1512,
1513,
1514,
1515,
1516,
1517,
1518,
1520,
1521
)
  ;
  cursor cuMovimientos(nuUnidad number, nuItem number) is
  select *
    from open.or_uni_item_bala_mov m
   where operating_unit_id=nuUnidad
     and items_id=nuItem
     and movement_type in ('I','N')
   order by items_id,1;
   cursor cuMovimientos2(nuItem number, documento number) is
  select *
    from open.or_uni_item_bala_mov m
   where items_id=nuItem
     and id_items_documento=documento
     and movement_type='D'
   order by items_id,1;
   
    cursor cuMovimientos3(nuItem number, documento number, cantidad number,VALIDA VARCHAR2) is
  select *
    from open.or_uni_item_bala_mov m
   where items_id=nuItem
     and support_document=to_char(documento)
     and movement_type='N'
     and amount=decode(valida,'S',cantidad,amount)
   order by items_id,1;
   
   rgMovimientos cuMovimientos2%rowtype;
   sbDatosN varchar2(32000);
   sbDatosI varchar2(32000);
   sbRegistro varchar2(32000);
begin
  dbms_output.enable(buffer_size => NULL);
  for reg in cuDatos loop
    sbRegistro:= reg.operating_unit_id||'|'||reg.items_id;
      for reg2 in cuMovimientos(reg.operating_unit_id, reg.items_id) loop
        if reg2.movement_type='N' then
          if open.dage_items_documento.fnugetdocument_type_id(reg2.id_items_documento,null) =105 then
              open cuMovimientos2( reg.items_id, reg2.id_items_documento);
              fetch cuMovimientos2 into  rgMovimientos;
              if cuMovimientos2%found then
                if rgMovimientos.amount=reg2.amount and rgMovimientos.total_value<>reg2.total_value then
                  if sbDatosN is null then
                     sbDatosN := 'N'||'-'||reg2.id_items_documento;
                  else 
                     sbDatosN:=sbDatosN||','||reg2.id_items_documento;
                  end if;
                end if;
              end if;
              close cuMovimientos2;
          end if;
        elsif reg2.movement_type = 'I' then
            open cuMovimientos3(reg.items_id, reg2.id_items_documento, reg2.amount,'S');
            fetch cuMovimientos3 into rgMovimientos;
            if cuMovimientos3%found then
               if rgMovimientos.total_value<>reg2.total_value then
                  if sbDatosI is null then
                   sbDatosI := 'I'||'-'|| reg2.id_items_documento;
                  else 
                     sbDatosI:=sbDatosI||','||reg2.id_items_documento;
                  end if;
              else
                  if round(rgMovimientos.total_value)<>round((reg2.total_value/reg2.amount)*rgMovimientos.amount) then
                     if sbDatosI is null then
                       sbDatosI := 'I'||'-'||reg2.id_items_documento;
                     else 
                         sbDatosI:=sbDatosI||','||reg2.id_items_documento;
                     end if;
                  end if;
               end if;
            else
                if cuMovimientos3%isopen then
                    close cuMovimientos3;
                end if;
                open cuMovimientos3(reg.items_id, reg2.id_items_documento, reg2.amount,'N');
                fetch cuMovimientos3 into rgMovimientos;
                if cuMovimientos3%found then
                   if reg2.amount=rgMovimientos.amount and rgMovimientos.total_value<>reg2.total_value then
                      if sbDatosI is null then
                       sbDatosI := 'I'||'-'|| reg2.id_items_documento;
                      else 
                         sbDatosI:=sbDatosI||','||reg2.id_items_documento;
                      end if;
                  else
                      if round(rgMovimientos.total_value)<>round((reg2.total_value/reg2.amount)*rgMovimientos.amount) then
                         if sbDatosI is null then
                           sbDatosI := 'I'||'-'||reg2.id_items_documento;
                         else 
                             sbDatosI:=sbDatosI||','||reg2.id_items_documento;
                         end if;
                      end if;
                   end if;
                else
                  if reg2.ITEM_MOVEME_CAUS_ID<>-1 then
                     dbms_output.put_line('No encontro'||reg.items_id);
                  end if;
                end if;
               if cuMovimientos3%isopen then
                    close cuMovimientos3;
               end if;
            end if;
            if cuMovimientos3%isopen then
                    close cuMovimientos3;
             end if;
        end if;
      end loop;
      if sbDatosN is not null or sbDatosI is not null then
        dbms_output.put_line(sbRegistro ||' Diferencias en :'||sbDatosN||'-'||sbDatosI);
        sbDatosN:=null;
        sbDatosI:=null;
      end if;
  end loop;
end;

  
