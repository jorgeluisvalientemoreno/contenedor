--validar_facturacion_electronica
select * 
from lote_fact_electronica  l 
where periodo_facturacion = 114061;

select * 
from factura_elect_general g 
where codigo_lote=9327
/*and   g.documento = 2141624176*/; 

select *
from factura  f
where f.factpefa = 114061
and f.factprog = 6;

select *
from ldc_pecofact l 
where l.pcfapefa= 114061
