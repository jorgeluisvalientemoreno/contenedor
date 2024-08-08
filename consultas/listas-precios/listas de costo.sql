select *
from open.LDC_TIPO_LIST_DEPART ;


select *
from open.ge_geogra_location
where geog_loca_area_type=3
  and not exists(select null from open.LDC_LOC_TIPO_LIST_DEP where geograp_location_id=localidad);
  
SELECT TILI.TIPO_LISTA, TIPO.DESCRIPCION, LO.GEOGRAP_LOCATION_ID, LO.DESCRIPTION
FROM OPEN.LDC_LOC_TIPO_LIST_DEP TILI, OPEN.GE_GEOGRA_LOCATION  LO,  OPEN.LDC_TIPO_LIST_DEPART TIPO
WHERE TILI.LOCALIDAD=LO.GEOGRAP_LOCATION_ID
  AND TIPO.CONSECUTIVO=TILI.TIPO_LISTA
  
select *
from open.LDC_ITEMS_AUDIT
WHERE MODIF_dATE>='03/04/2017';

select l.list_unitary_cost_id,l.validity_start_date,l.validity_final_date, l.description,COUNT(*)
from open.ge_list_unitary_cost l, open.ge_unit_cost_ite_lis li
where validity_start_date>='01/03/2017'
  and l.list_unitary_cost_id=li.list_unitary_cost_id
  and l.geograp_location_id is not null
 -- AND LI.ITEMS_ID=100004901
  group by l.list_unitary_cost_id,l.validity_start_date,l.validity_final_date, l.description;
  
