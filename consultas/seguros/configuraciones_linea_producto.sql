select l.product_line_id,
       l.description,
       ty.policy_type_id,
       ty.description,
       ty.contratist_code code_poly_type, 
       ty.contratista_id  code_aseg,
       ty.is_exq,
       va.initial_date,
       va.final_date,
       va.policy_value,
       va.share_value value_prima
from open.ld_product_line l
left join open.ld_policy_type ty on ty.product_line_id  = l.product_line_id 
left join open.ld_validity_policy_type va on va.policy_type_id = ty.policy_type_id
where l.product_line_id in (&linea_prod)  and va.final_date> sysdate ;

--code_poly_type : cod de tipo de poliza en la aseguradora