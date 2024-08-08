declare
  cursor cuItems is
  select m.id_items_seriado, s.operating_unit_id, s.id_items_estado_inv, count(1)
from open.or_uni_item_bala_mov m, open.ge_items_seriado s
where m.items_id=100003008
  and m.operating_unit_id=799
  and movement_type!='N'
  and s.id_items_seriado=m.id_items_seriado
 -- and s.operating_unit_id is  null
  --and s.id_items_seriado=983
  group by m.id_items_seriado, s.operating_unit_id, s.id_items_estado_inv
 ;
 cursor cuMovimientos(idSeriado number) is
 select *
 from open.or_uni_item_bala_mov m
 where m.id_items_seriado=idSeriado
   order by m.move_date, m.uni_item_bala_mov_id;
   
   sbTipoMovimiento varchar2(1);
   nuOk number:=0;
begin
    for reg in cuItems loop
      sbTipoMovimiento := null;
      for reg2 in cuMovimientos(reg.id_items_seriado) loop
        
        if sbTipoMovimiento is null then
          sbTipoMovimiento:=reg2.movement_type;
        else
          if sbTipoMovimiento = 'I' and reg2.movement_type in ('D','N') then
            nuOk:=0;
           --dbms_output.put_line('Entro 1');
          elsif sbTipoMovimiento='D' and reg2.movement_type  in ('N') then
            nuOk:=0;
            --dbms_output.put_line('Entro 2');
          elsif sbTipoMovimiento ='N' and reg2.movement_type in ('I') then
            -- dbms_output.put_line('Entro 3');
              nuOk:=0;
          elsif sbTipoMovimiento ='D' and reg2.movement_type in ('I') and reg2.item_moveme_caus_id =19  then
              --dbms_output.put_line('Entro 4');
              nuOk:=0;
          else 
            nuOk:=1;
             --dbms_output.put_line('Entro 5');
             --dbms_output.put_line('sbTipoMovimiento'||sbTipoMovimiento);
             --dbms_output.put_line('reg2.movement_type'||reg2.movement_type);
          end if;
          if nuOk=1 then
             dbms_output.put_line('Revisar: '||reg.id_items_seriado);
             exit;
          end if;
          if reg2.item_moveme_caus_id=19 and reg2.movement_type='N'then
             null;
          else
            sbTipoMovimiento := reg2.movement_type;
          end if;
        end if;
      end loop;
    end loop;
end;
