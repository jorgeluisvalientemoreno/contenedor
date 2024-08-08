SELECT to_char(or_ope_uni_item_bala.operating_unit_id) operating_unit_id,
       to_char(or_ope_uni_item_bala.items_id) items_id,
       ge_items.code || ' - ' || ge_items.description item_description,
       to_char(or_ope_uni_item_bala.quota) quota,
       to_char(or_ope_uni_item_bala.balance) balance,
       to_char(or_ope_uni_item_bala.total_costs) total_costs,
       to_char(ge_item_classif.cost_method) cost_method,
       TO_char(ge_item_classif.quantity_control) quantity_control,
       to_char(nvl(or_ope_uni_item_bala.occacional_quota, 0)) OCCASIONAL_QUOTA
  FROM or_ope_uni_item_bala, ge_items, ge_item_classif /*+ OR_BCOperUnit_Admin.frfGetOperUnitItems SAO197153 */
 WHERE or_ope_uni_item_bala.operating_unit_id = &inuOperatingUnitId
   AND or_ope_uni_item_bala.items_id = ge_items.items_id
   AND ge_items.item_classif_id = ge_item_classif.item_classif_id;

select s.id_items_seriado,
       s.items_id,
       s.serie,
       s.id_items_estado_inv,
       e.descripcion,
       s.costo,
       s.fecha_ingreso
  from open.ge_items_seriado s
  inner join ge_items_estado_inv e on e.id_items_estado_inv = s.id_items_estado_inv
 where s.operating_unit_id = &inuOperatingUnitId
   and s.id_items_estado_inv = 1
