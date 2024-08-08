select i.items_id, i.description, g.id_items_gama, g.descripcion, i.id_items_tipo, t.descripcion, code
from open.ge_items i, open.ge_items_gama_item ig, open.ge_items_gama g, open.ge_items_tipo t
where i.item_classif_id=21
  and i.items_id=ig.items_id
  and ig.id_items_gama=g.id_items_gama
  and t.id_items_tipo=i.id_items_tipo
  and t.id_items_tipo=20
;


select *
from open.ge_items_tipo_atr atr, open.ge_entity_attributes t
where id_items_tipo=20
  and t.entity_attribute_id=atr.entity_attribute_id;
  and id
;

select *
from 
select *
from open.ge_entity
where entity_id=9875;

select *
from open.ge_items_tipo_at_val a, open.ge_items_Seriado s, open.ge_items i
where a.id_items_seriado=s.id_items_seriado
  and i.items_id=S.items_id
  and i.id_items_tipo=20
  and s.id_items_seriado=1133489;

select *
from open.ge_items_seriado
where serie like '%229555%'
