SELECT 'Consulta', extractvalue(APP_XML, 'PB/APPLICATION/QUERY_NAME') cONSULTA FROM OPEN.GE_DISTRIBUTION_FILE  WHERE distribution_file_id = 'LDCI_PREPLICACECOLOCA'
union
SELECT 'proceso', extractvalue(APP_XML, 'PB/APPLICATION/OBJECT_NAME') proceso FROM OPEN.GE_DISTRIBUTION_FILE  WHERE distribution_file_id = 'LDCI_PREPLICACECOLOCA'
select *
from open.ld_parameter
where parameter_id='COD_USER_LDCGTA'
FOR UPDATE;
select *
from sa_user
where mask='CONSCOL'
LDC_PKVENTAFNB.LDC_PRLODPD;

select *
from ge_contrato
where id_contratista=337;

select *
from or_order
where operating_unit_id=1512
  and order_status_id=5;


CA_UIREPTPROCESOARCHIVOSDA.FRPDAPROCESS
--REPFRPDA PB QUE EJECUTA OTRRA FORMA 
