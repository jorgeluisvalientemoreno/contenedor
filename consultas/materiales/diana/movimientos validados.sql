select *
from open.ldci_intemmit
where mmitesta=1
and mmitnudo is not null
and mmitnudo not in ('87112','87114','87109','83205','87098','122211','SM32519','87120','SM39351','SM58113','VD67351','VD52334','VD64282',
                      'VD50848','VD52136','VD50847','BQ23007','VD57468','VD52135', 'VD57469','BQ21815','SM68989','VD51228', 'VD63468','VD67368',
                      'VD67549','VD69090','VD69569','VD52281','117978','87105','146159','148641','153167','178548','190007','190006','190003',
                      '190004','190005', '190022','190030','189996', '189997','189998','189999','190000','190029',
                      '190028', '190025','190026','190017','190018','190020','190014','190009','190019','190016','190011',
                      '190015','190012','190010','190023','190027','190034','190033','190032','190031','190035','190038','190037',
                      '190038' , '190037','190036', '190039','190040','207714','201489','190008','190002','213252','210749','190001','190013','217575',
                      '190021','242416','243154','243266','248445','190024','250398','255750','255750','277575','287234','287297','287297',
                      '289886','293635','294021','294963','298030','298030','297964','253365','306149','308009','306149','308009','308010',
                      '312549','347885',   '362957',    '299563','360512','371328','368082','368079','371293','368053','371291','369334',
                      '368081','367998','376839','378459','376625','376775','293386','468668','437543','474577','475174','518625','518647','518638',
                      '518651','518646','518637','518652','518649','518660','518643','518633','518661','518626','518627','518636','518640','518650',
                      '518642','518630','518645','518644','518662','521374','521410','521377','521376','521381','521398','523381','526268',

                      
                      
'47471','121505')
order by mmitcodi;

select u.operating_unit_id||'-'||u.name unidad, mmitcodi cod, mmitnudo docum, mmitdsap doc_sap, mmittimo timo, mmitnatu natu, mmitfecr fecha,mmitmens error_, mmitesta esta,mmitinte inten, dmititem item, dmitcant cant, dmitcoun costo_uni,dmitcape,dmitsafi
from open.ldci_intemmit,open.ldci_dmitmmit, open.ge_items_documento d, open.or_operating_unit u
where mmitcodi=dmitmmit
and mmitnudo='87112'
and to_char(id_items_documento)=mmitnudo
and u.operating_unit_id=d.operating_unit_id
--and dmititem=10007708
--and mmitdsap is not null
order by mmitcodi;

select mmitcodi cod, mmitdsap doc_sap, mmittimo timo, mmitnatu, mmitesta, serinume
from open.ldci_intemmit, open.ldci_seridmit
where mmitcodi=Serimmit
and mmitnudo='475174'
---and mmitdsap is not null
order by mmitcodi, serinume


