--eliminar tildes
utl_raw.cast_to_varchar2(nlssort('Aéíóu', 'nls_sort=binary_ai'))

SELECT TRANSLATE('ácento con ó ídd',
   'áéíóúàèìòùãõâêîôôäëïöüçÁÉÍÓÚÀÈÌÒÙÃÕÂÊÎÔÛÄËÏÖÜÇ',
   'aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC')
FROM dual;


select LISTAGG( a.name_attribute||'='||decode(mandatory,'Y','REQUERIDO','NO_REQUERIDO'),';')  within group(order by tda.order_, gd.capture_order asc) as CAMPO
from open.or_tasktype_add_data tda
inner join open.ge_attrib_set_attrib gd on gd.attribute_set_id = tda.attribute_set_id
inner join open.ge_attributes a on a.attribute_id = gd.attribute_id
inner join open.ge_causal c on (tda.use_ = 'B' or (tda.use_ ='C' and c.class_causal_id = 1) or (tda.use_ ='I' and c.class_causal_id = 2)) and c.causal_id=1
where tda.task_type_id=12155
  and tda.active='Y'
;

--XMLAGG