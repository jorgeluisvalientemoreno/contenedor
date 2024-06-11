with compras as
(select mmitfecr, dmitcoin, dmitcoun
from (
select mmitfecr, DMITCOIN, dmitcoun, row_number() over ( partition by DMITCOIN order by DMITCOIN) filas
from open.ldci_intemmit, open.ldci_dmitmmit, open.ge_items_documento d
where mmitcodi=Dmitmmit
  and mmitnudo is not null
  and mmitdsap is not null
  and to_char(id_items_documento)=mmitnudo
  and document_type_id!='105'
  and dmitcant>0
  order by DMITCOIN, mmitfecr desc)
where filas=1),
Migrado as(
SELECT B.CUADHOMO,I.ITEMS_ID, SUM(EIXBVLOR) VALOR
       FROM MIGRA.LDC_TEMP_EXITEBOD_SGE A, MIGRA.LDC_MIG_CUADCONT B, OPEN.GE_ITEMS I
      WHERE A.EIXBBCUA = B.CUADCODI
        AND A.BASEDATO = B.BASEDATO
        and nvl(migra.FNUGETITEMOSF_ROLLOUT(eixbitem, a.BASEDATO),0)=I.items_id
       GROUP BY  B.CUADHOMO,I.ITEMS_ID
       )
select (select u.person_in_charge||'-'||p.name_ from open.ge_person p where p.person_id=u.person_in_charge) responsable,
       u.operating_unit_id,
       u.name,
       b.items_id,
       (select description from open.ge_items i where i.items_id=b.items_id) desc_item,
       balance,
       total_costs,
      dmitcoun costo_unitario_compras,
      valor valor_migrado
from open.or_ope_uni_item_bala b
     left join compras on dmitcoin=items_id
     left join Migrado m on m.items_id=b.items_id and m.cuadhomo=b.operating_unit_id, open.or_operating_unit u
where b.operating_unit_id=u.operating_unit_id
 and balance>0;



 
