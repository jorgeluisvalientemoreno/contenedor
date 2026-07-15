update ldci_actacont
set actcontabiliza ='N'
where idacta= 242949;


update ic_encoreco
set ecrccoco = 4
where ecrccons in ( 270113 , 270172);

update contratista
set empresa='GDGU'
where contratista=909;

select *
from ic_encoreco
inner join ic_decoreco on dcrcecrc = ecrccons
inner join ldci_tipointerfaz on  ecrccoco = cod_comprobante
where ldci_pkinterfazsap.fvaGetData(42, DCRCINAD, '|') = '242949'
AND ecrcfech BETWEEN '11/03/2025' AND '14/05/2025'
AND dcrccuco NOT IN ('A', 'G')
AND tipointerfaz = 'L7';


select *
from ldci_actacont
where  idacta = 250592
order by fechcontabiliza desc  ;

select contratista.contratista, contratista.empresa
from ge_acta, ge_contrato, contratista
where id_acta = 242949
and ge_contrato.id_contrato = ge_acta.id_contrato
and ge_contrato.id_contratista = contratista.contratista;

select *
from ge_acta
where id_acta = 242949;
 
 
 SELECT *
FROM ldci_logsproc
WHERE LOPRPROC = 'L7' AND LOPRFECH > SYSDATE -10
order by LOPRFECH desc ;


select * from ldci_encaintesap
where  cod_interfazldc in (57296);

select * from ldci_detaintesap
where  cod_interfazldc in (57298);


select a.id_acta, A.REFERENCE_ITEM_ID,it.description des_items, at.task_type_id titr, ot.clctclco  Clasi  , value_1 Activo , name_1
from open.ge_detalle_acta a 
inner join open.ge_items it on  it.items_id = A.REFERENCE_ITEM_ID 
inner join open.or_order_activity at on at.order_id = id_orden
inner join open.or_requ_data_value ov on ov.order_id = id_orden
inner join  open.ic_clascott  ot on  at.task_type_id = ot.clcttitr
where ot.clctclco in (245,413,414,314)
and name_1 = 'NUM_COD_ACTIVO'
order by at.register_date desc


select g.id_acta, g.id_orden, g.id_items, (select i.description from open.ge_items i where i.items_id = g.id_items) des_item,
       (select value_1 from open.or_requ_data_value where order_id = g.id_orden and name_1 = 'NUM_COD_ACTIVO') Activo,
       sum(g.valor_total) total
  from open.ge_detalle_acta g  
 where g.id_acta = 249591
group by g.id_acta, g.id_orden, g.id_items
