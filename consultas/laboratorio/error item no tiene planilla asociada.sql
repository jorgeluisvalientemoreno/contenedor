  SELECT gl.variable_template_id, activity_id, open.dage_items.fsbgetdescription(activity_id), gl.items_id, open.dage_items.fsbgetdescription(gl.items_id)
          FROM open.ge_items_gama_item gi, open.ge_lab_template  gl
          WHERE gl.activity_id = 4000727
            and gl.items_id = 100003011
          and gi.items_id = gl.items_id;
          
          
select *
from open.or_order_Activity
where order_id=53673542;

select *
from open.ge_items_seriado
where id_items_seriado=1797;

select *
from open.ge_items
where items_id in (100003011 ,4000727 )
