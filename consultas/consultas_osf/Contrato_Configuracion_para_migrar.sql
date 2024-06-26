--Contratos
select 'PL - Productivo', t.*
  from open.ge_contrato@osfpl t
 where t.id_contratista in (25, 2791)
union all
select 'QH - Calidad', t.*
  from open.ge_contrato t
 where t.id_contratista in (25, 2791);

--Contratos x contratista existentes en PL no exitentes en QH
select 'PL - Productivo', t.*
  from open.ge_contrato@osfpl t
 where t.id_contratista in (25, 2791)
   and (select count(1)
          from open.ge_contrato t1
         where t1.id_contratista in (25, 2791)) = 0;

--Difetencia Contratos
select t.id_contrato, t.id_contratista
  from open.ge_contrato@osfpl t
 where t.id_contratista in (25, 2791)
minus
select t.id_contrato, t.id_contratista
  from open.ge_contrato t
 where t.id_contratista in (25, 2791);

--si se desea tener el mismo coigo del contrato , antes de registrar el contrato desde ctcco se urtiliza 
--select seq_ge_contrato.nextval from dual;-- para llegar hasta el codigo necesario
--1ro se regitra el contrato desde CTCCO. Solo se digita la siguiente informacion:
--*descripcion del contrato 
--*Tipo de moneda 
--*tipo de contrato 

--antes de utilizar la LDCMCCO (LDC - Modificación de Contrato por Contratista)
--para registrar el restro de informacion del contrato, consulltamos lo sigueinte
select *
  from open.LDC_CONTFEMA@osfpl a
 where a.id_contrato in
       (select t.id_contrato
          from open.ge_contrato@osfpl t
         where t.id_contratista in (25, 2791))
   and (select count(1)
          from open.LDC_CONTFEMA a1
         where a1.id_contrato = a.id_contrato) = 0;
select *
  from open.LDC_CONT_PLAN_COND@osfpl a
 where a.contract_id in
       (select t.id_contrato
          from open.ge_contrato@osfpl t
         where t.id_contratista in (25, 2791))
   and (select count(1)
          from open.LDC_CONT_PLAN_COND a1
         where a1.contract_id = a.contract_id) = 0;
select *
  from open.LDC_CONTRATO_AREA@osfpl a
 where a.id_contrato in
       (select t.id_contrato
          from open.ge_contrato@osfpl t
         where t.id_contratista in (25, 2791))
   and (select count(1)
          from open.LDC_CONTRATO_AREA a1
         where a1.id_contrato = a.id_contrato) = 0;

select *
  from open.ldc_tipoinc_bycon@osfpl a
 where a.id_contrato in
       (select t.id_contrato
          from open.ge_contrato@osfpl t
         where t.id_contratista in (25, 2791))
   and (select count(1)
          from open.ldc_tipoinc_bycon a1
         where a1.id_contrato = a.id_contrato) = 0;

--Tirgger LDC_TRG_LDC_ITEM_UO_LR
--Para autorizar apertura de ACTA para la forma LDCCA cuando se genera
select t4.*, rowid
  from open.LDC_MONTO_ACTA@osfpl t4
 where t4.id_contrato in
       (select t.id_contrato
          from open.ge_contrato@osfpl t
         where t.id_contratista in (25, 2791))
   and (select count(t.id_contrato)
          from open.LDC_MONTO_ACTA t
         where t.id_contrato = t4.id_contrato) = 0;

--luego de creado el contrato utilizamos LDCMCCO (LDC - Modificación de Contrato por Contratista)para registrar el restro de informacion del contrato
select *
  from open.ge_acta@osfpl a
 where a.id_contrato in
       (select t.id_contrato
          from open.ge_contrato@osfpl t
         where t.id_contratista in (25, 2791));
select *
  from open.ge_acta a
 where a.id_contrato in
       (select t.id_contrato
          from open.ge_contrato t
         where t.id_contratista in (25, 2791));

--ejecutamos CTAACN - Acta de apertura de contrato

--tipo de trabajo por tipo de contrato
select *
  from open.ct_tasktype_contype@osfpl t
 where t.contract_type_id in
       (select tc.id_tipo_contrato
          from open.ge_contrato@osfpl tc
         where tc.id_contrato in
               (select t.id_contrato
                  from open.ge_contrato@osfpl t
                 where t.id_contratista in (25, 2791)))
      --and t.task_type_id in (11320, 11321, 11324, 11317)
   and (select count(1)
          from open.ct_tasktype_contype t1
         where t1.contract_type_id in
               (select tc1.id_tipo_contrato
                  from open.ge_contrato tc1
                 where tc1.id_contrato in
                       (select t.id_contrato
                          from open.ge_contrato t
                         where t.id_contratista in (25, 2791)))
           and t1.task_type_id = t.task_type_id) = 0;

--Tipo de trabajo
select ott.*, rowid
  from open.or_task_type@osfpl ott
 where ott.task_type_id in
       (select t.task_type_id
          from open.ct_tasktype_contype@osfpl t
         where t.contract_type_id in
               (select tc.id_tipo_contrato
                  from open.ge_contrato@osfpl tc
                 where tc.id_contrato in
                       (select t.id_contrato
                          from open.ge_contrato@osfpl t
                         where t.id_contratista in (25, 2791))))
      --and ott.task_type_id = 11318
   and (select count(1)
          from open.or_task_type ott1
         where ott1.task_type_id = ott.task_type_id)
      --and ott.task_type_id = 11318
       = 0;

--Tipo de traabjo x causal 
select ottc1.task_type_id, ottc1.causal_id
  from open.or_task_type_causal@osfpl ottc1
 where ottc1.task_type_id in
       (select t1.task_type_id
          from open.ct_tasktype_contype@osfpl t1
         where t1.contract_type_id in
               (select tc1.id_tipo_contrato
                  from open.ge_contrato@osfpl tc1
                 where tc1.id_contrato in
                       (select t.id_contrato
                          from open.ge_contrato@osfpl t
                         where t.id_contratista in (25, 2791))))
minus
select ottc.task_type_id, ottc.causal_id
  from open.or_task_type_causal ottc
 where ottc.task_type_id in
       (select t.task_type_id
          from open.ct_tasktype_contype t
         where t.contract_type_id in
               (select tc.id_tipo_contrato
                  from open.ge_contrato tc
                 where tc.id_contrato in
                       (select t.id_contrato
                          from open.ge_contrato t
                         where t.id_contratista in (25, 2791))));

--Actividades e Items 
select plgi.*, rowid
  from open.ge_items@osfpl plgi
 where plgi.items_id in
       (select pltt0.items_id
          from open.or_task_types_items@osfpl pltt0
         where pltt0.task_type_id in
               (select plt.task_type_id
                  from open.ct_tasktype_contype@osfpl plt
                 where plt.contract_type_id in
                       (select tc.id_tipo_contrato
                          from open.ge_contrato@osfpl tc
                         where tc.id_contrato in
                               (select t.id_contrato
                                  from open.ge_contrato@osfpl t
                                 where t.id_contratista in (25, 2791)))))
   and (select count(1)
          from open.ge_items plgi1
         where plgi1.items_id in
               (select pltt01.items_id
                  from open.or_task_types_items pltt01
                 where pltt01.task_type_id in
                       (select plt1.task_type_id
                          from open.ct_tasktype_contype plt1
                         where plt1.contract_type_id in
                               (select tc1.id_tipo_contrato
                                  from open.ge_contrato tc1
                                 where tc1.id_contrato in
                                       (select t.id_contrato
                                          from open.ge_contrato t
                                         where t.id_contratista in (25, 2791)))))
              /*and plgi1.items_id || '-' || plgi1.description =
              plgi.items_id || '-' || plgi.description*/
           and plgi1.items_id = plgi.items_id) = 0;

select pltt0.* -- pltt0.task_type_id , pltt0.items_id
  from open.or_task_types_items@osfpl pltt0
 where pltt0.task_type_id in
       (select plt.task_type_id
          from open.ct_tasktype_contype@osfpl plt
         where plt.contract_type_id in
               (select tc.id_tipo_contrato
                  from open.ge_contrato@osfpl tc
                 where tc.id_contrato in
                       (select t.id_contrato
                          from open.ge_contrato@osfpl t
                         where t.id_contratista in (25, 2791))))
minus
select pltt0.* -- pltt0.task_type_id , pltt0.items_id 
  from open.or_task_types_items pltt0
 where pltt0.task_type_id in
       (select plt.task_type_id
          from open.ct_tasktype_contype plt
         where plt.contract_type_id in
               (select tc.id_tipo_contrato
                  from open.ge_contrato tc
                 where tc.id_contrato in
                       (select t.id_contrato
                          from open.ge_contrato t
                         where t.id_contratista in (25, 2791))));

--Relacion entre TT e Items
--forma 1
select TT0.*, ROWID
  from open.or_task_types_items@osfpl tt0
 where tt0.task_type_id in
       (select pltt0.task_type_id
          from open.or_task_types_items@osfpl pltt0
         where pltt0.task_type_id in
               (select plt.task_type_id
                  from open.ct_tasktype_contype@osfpl plt
                 where plt.contract_type_id in
                       (select tc.id_tipo_contrato
                          from open.ge_contrato@osfpl tc
                         where tc.id_contrato in
                               (select t.id_contrato
                                  from open.ge_contrato@osfpl t
                                 where t.id_contratista in (25, 2791)))
                --and plt.task_type_id in (11320, 11321, 11324, 11317)
                ))
   and (select count(1)
          from open.or_task_types_items tt01
         where tt01.task_type_id in
               (select pltt01.task_type_id
                  from open.or_task_types_items pltt01
                 where pltt01.task_type_id in
                       (select plt1.task_type_id
                          from open.ct_tasktype_contype plt1
                         where plt1.contract_type_id in
                               (select tc1.id_tipo_contrato
                                  from open.ge_contrato tc1
                                 where tc1.id_contrato in
                                       (select t.id_contrato
                                          from open.ge_contrato t
                                         where t.id_contratista in (25, 2791)))
                        --and plt.task_type_id in (11320, 11321, 11324, 11317)
                        ))
           and tt01.task_type_id || '-' || tt01.items_id =
               tt0.task_type_id || '-' || tt0.items_id) = 0;

---forma 2
select tt0.task_type_id, tt0.items_id
  from open.or_task_types_items@osfpl tt0
 where tt0.task_type_id in
       (select pltt0.task_type_id
          from open.or_task_types_items@osfpl pltt0
         where pltt0.task_type_id in
               (select plt.task_type_id
                  from open.ct_tasktype_contype@osfpl plt
                 where plt.contract_type_id in
                       (select tc.id_tipo_contrato
                          from open.ge_contrato@osfpl tc
                         where tc.id_contrato in
                               (select t.id_contrato
                                  from open.ge_contrato@osfpl t
                                 where t.id_contratista in (25, 2791)))))
minus
select tt01.task_type_id, tt01.items_id
  from open.or_task_types_items tt01
 where tt01.task_type_id in
       (select pltt01.task_type_id
          from open.or_task_types_items pltt01
         where pltt01.task_type_id in
               (select plt1.task_type_id
                  from open.ct_tasktype_contype plt1
                 where plt1.contract_type_id in
                       (select tc1.id_tipo_contrato
                          from open.ge_contrato tc1
                         where tc1.id_contrato in
                               (select t.id_contrato
                                  from open.ge_contrato t
                                 where t.id_contratista in (25, 2791)))));

--todos los tipos de trabajo por items
select pltt0.* -- pltt0.task_type_id , pltt0.items_id
  from open.or_task_types_items@osfpl pltt0
minus
select pltt01.* -- pltt0.task_type_id , pltt0.items_id 
  from open.or_task_types_items pltt01;

--todos las unidades operativas
select pltt0.*
  from open.or_operating_unit@osfpl pltt0
 where (select count(1)
          from open.or_operating_unit pltt1
         where pltt1.operating_unit_id = pltt0.operating_unit_id) = 0
   and pltt0.contractor_id in (25, 2791);

--ldc_item_uo_lr_fk  (ldc_const_unoprl) unidad operativas para LDCCUAI
--SELECT l.* FROM open.ldc_const_unoprl@osfpl l;
SELECT l.unidad_operativa
  FROM open.ldc_const_unoprl@osfpl l
 where l.unidad_operativa in
       (select pltt0.operating_unit_id
          from open.or_operating_unit@osfpl pltt0
         where pltt0.contractor_id in (25, 2791))
minus
SELECT l.unidad_operativa
  FROM open.ldc_const_unoprl l
 where l.unidad_operativa in
       (select pltt0.operating_unit_id
          from open.or_operating_unit pltt0
         where pltt0.contractor_id in (25, 2791));

--Todos ldc_item_uo_lr_fk  (ldc_const_unoprl) unidad operativas para LDCCUAI
--SELECT l.* FROM open.ldc_const_unoprl@osfpl l;
SELECT l.unidad_operativa
  FROM open.ldc_const_unoprl@osfpl l
minus
SELECT l.unidad_operativa
  FROM open.ldc_const_unoprl l;

--ldc_item_uo_lr_fk  (ldc_const_unoprl) unidad operativas para LDCCUAI
select oou.operating_unit_id
  from open.or_operating_unit@osfpl oou
 where oou.operating_unit_id in
       (SELECT l.unidad_operativa FROM open.ldc_const_unoprl@osfpl l)
minus
select oou.operating_unit_id
  from open.or_operating_unit oou
 where oou.operating_unit_id in
       (SELECT l.unidad_operativa FROM open.ldc_const_unoprl l);

SELECT l.unidad_operativa
  FROM open.ldc_const_unoprl@osfpl l
-- where l.unidad_operativa in
--       (4559, 4560, 4561, 4564, 4563, 4262, 4565, 4566, 4567)
minus
SELECT l1.unidad_operativa
  FROM open.ldc_const_unoprl l1
-- where l1.unidad_operativa in
--       (4559, 4560, 4561, 4564, 4563, 4262, 4565, 4566, 4567)
;

--LDCCUAI
--validar actividad
--Validamos la configuracion (Unidad - Actividad - Item) en la la forma LDCCUAI (Desactivar el TRIGGER)
--validar unidad operativa
SELECT l.* --distinct l.item ||',' --
  FROM open.ldc_item_uo_lr@osfpl l
 WHERE l.item in
       (select pltt0.items_id
          from open.or_task_types_items@osfpl pltt0
         where pltt0.task_type_id in
               (select plt.task_type_id
                  from open.ct_tasktype_contype@osfpl plt
                 where plt.contract_type_id in
                       (select tc.id_tipo_contrato
                          from open.ge_contrato@osfpl tc
                         where tc.id_contrato in
                               (select t.id_contrato
                                  from open.ge_contrato@osfpl t
                                 where t.id_contratista in (25, 2791)))))
   and (SELECT count(1)
          FROM open.or_operating_unit l1
         WHERE l1.operating_unit_id = l.unidad_operativa) = 0;

/*insert into open.ldc_item_uo_lr
  (unidad_operativa, actividad, item, liquidacion)*/
select *
  from (SELECT l.unidad_operativa, l.actividad, l.item, l.liquidacion
          FROM open.ldc_item_uo_lr@osfpl l
        minus
        SELECT l1.unidad_operativa, l1.actividad, l1.item, l1.liquidacion
          FROM open.ldc_item_uo_lr l1);

SELECT l.* --distinct l.item ||',' --
  FROM open.ldc_item_uo_lr@osfpl l
minus
SELECT l.* --distinct l.item ||',' --
  FROM open.ldc_item_uo_lr l;

select t.unidad_operativa
  from open.ldc_const_unoprl@osfpl t
minus
select t1.unidad_operativa
  from ldc_const_unoprl t1;

--Tipo de trabajo
select ott.task_type_id
  from open.or_task_type@osfpl ott
minus
select ott.task_type_id
  from open.or_task_type ott;

--Tipo de trabajo x items
select *
  from open.or_task_types_items@osfpl pltt0
minus
select *
  from open.or_task_types_items pltt0;

--Maximos y minimos tt e items
select max(l.itemsxtt_id)
  from open.LDC_CMMITEMSXTT l
 order by l.itemsxtt_id desc;

--Configuraci?n de cantidad m?ximas y m?nimas de ?tems por tipos de trabajo
select l.task_type_id, l.items_id
  from open.LDC_CMMITEMSXTT@osfpl l
minus
select l.task_type_id, l.items_id
  from LDC_CMMITEMSXTT l;

select l.*, rowid
  from open.LDC_CMMITEMSXTT@osfpl l
 where l.task_type_id in
       (select tt0.task_type_id
          from open.OR_TASK_TYPE@osfpl tt0
         where tt0.task_type_id in
               (select t.task_type_id
                  from open.ct_tasktype_contype@osfpl t
                 where t.contract_type_id =
                       (select tc.id_tipo_contrato
                          from open.ge_contrato@osfpl tc
                         where tc.id_contrato = 8341)))
   and (select count(1)
          from open.LDC_CMMITEMSXTT l1
         where l1.task_type_id = l.task_type_id) = 0;

select l.task_type_id,
       l.items_id,
       l.activity_id,
       l.item_amount_min,
       l.item_amount_max
  from open.LDC_CMMITEMSXTT@osfpl l
 where l.task_type_id in
       (select tt0.task_type_id
          from open.OR_TASK_TYPE@osfpl tt0
         where tt0.task_type_id in
               (select t.task_type_id
                  from open.ct_tasktype_contype@osfpl t
                 where t.contract_type_id =
                       (select tc.id_tipo_contrato
                          from open.ge_contrato@osfpl tc
                         where tc.id_contrato = 8341)))
minus
select l.task_type_id,
       l.items_id,
       l.activity_id,
       l.item_amount_min,
       l.item_amount_max
  from open.LDC_CMMITEMSXTT l
 where l.task_type_id in
       (select tt0.task_type_id
          from open.OR_TASK_TYPE tt0
         where tt0.task_type_id in
               (select t.task_type_id
                  from open.ct_tasktype_contype t
                 where t.contract_type_id =
                       (select tc.id_tipo_contrato
                          from open.ge_contrato tc
                         where tc.id_contrato = 8341)));

--select SEQLDC_CMMITEMSXTT.nextval from dual
select *
  from open.GE_ITEMS@osfpl pl2
 where (select count(1)
          from open.GE_ITEMS qh2
         where qh2.items_id = pl2.items_id) = 0
   and pl2.items_id = 100010241
   ;

---Lista de costo
select *
  from open.GE_LIST_UNITARY_COST@osfpl pl3
 where (select count(1)
          from open.GE_LIST_UNITARY_COST qh3
         where qh3.list_unitary_cost_id = pl3.list_unitary_cost_id) = 0;

/*insert into GE_UNIT_COST_ITE_LIS(ITEMS_ID,
                                 LIST_UNITARY_COST_ID,
                                 PRICE,
                                 LAST_UPDATE_DATE,
                                 USER_ID,
                                 TERMINAL,
                                 SALES_VALUE)*/
select *
  from open.GE_UNIT_COST_ITE_LIS@osfpl pl1
 where (select count(1)
          from open.GE_UNIT_COST_ITE_LIS qh1
         where qh1.list_unitary_cost_id || '-' || qh1.items_id =
               pl1.list_unitary_cost_id || '-' || pl1.items_id) = 0
 order by pl1.last_update_date;

select *
  from open.GE_UNIT_COST_ITE_LIS@osfpl pl1
 where (select count(1)
          from open.GE_UNIT_COST_ITE_LIS qh1
         where qh1.list_unitary_cost_id || '-' || qh1.items_id =
               pl1.list_unitary_cost_id || '-' || pl1.items_id) = 0;

--Lista de costos
select pltt.*, rowid
  from open.or_task_type@osfpl pltt
 where pltt.task_type_id in
       (select pltt0.task_type_id
          from open.or_task_types_items@osfpl pltt0
         where pltt0.task_type_id in
               (select plt.task_type_id
                  from open.ct_tasktype_contype@osfpl plt
                 where plt.contract_type_id =
                       (select tc.id_tipo_contrato
                          from open.ge_contrato@osfpl tc
                         where tc.id_contrato = 8341))
           and (select count(1)
                  from open.or_task_type tt
                 where tt.task_type_id = pltt0.task_type_id) = 0);

--lista de costos 
--mostrar resultado de cada entidad PL1, PL2 y PL3
select distinct pl1.*
  from open.GE_UNIT_COST_ITE_LIS@osfpl pl1,
       open.GE_ITEMS@osfpl             pl2,
       open.GE_LIST_UNITARY_COST@osfpl pl3
 where pl2.ITEMS_ID = pl1.ITEMS_ID
   and pl3.LIST_UNITARY_COST_ID = pl1.LIST_UNITARY_COST_ID
   and pl1.ITEMS_ID in
       (select TT0.ITEMS_ID
          from open.or_task_types_items@osfpl tt0
         where tt0.task_type_id in
               (select t.task_type_id
                  from open.ct_tasktype_contype@osfpl t
                 where t.contract_type_id =
                       (select tc.id_tipo_contrato
                          from open.ge_contrato@osfpl tc
                         where tc.id_contrato = 8341)))
   and pl1.Last_Update_Date >= '01/01/2023'
      --and pl1.list_unitary_cost_id = 4026
      --and (select count(1) from open.GE_LIST_UNITARY_COST a where a.list_unitary_cost_id = pl3.list_unitary_cost_id) = 0
   and (select count(1)
          from open.GE_UNIT_COST_ITE_LIS qh1
         where qh1.Last_Update_Date >= '01/01/2023'
           and (qh1.items_id || '-' || qh1.list_unitary_cost_id) =
               (pl1.items_id || '-' || pl1.list_unitary_cost_id)) = 0;

--lista entre pl y qh
select *
  from open.GE_LIST_UNITARY_COST@osfpl pl1
 where
--pl1.list_unitary_cost_id in (4049, 4047, 4045, 1, 4050, 4051, 4048, 4046, 4042) and 
 (select count(1)
    from open.GE_LIST_UNITARY_COST qh1
   where qh1.list_unitary_cost_id = pl1.list_unitary_cost_id) = 0;

select pl1.LIST_UNITARY_COST_ID, pl1.CONTRATOR_ID
  from open.GE_LIST_UNITARY_COST@osfpl pl1
-- where pl1.list_unitary_cost_id in
--       (4049, 4047, 4045, 1, 4050, 4051, 4048, 4046, 4042)
;
select pl1.LIST_UNITARY_COST_ID, pl1.CONTRATOR_ID
  from open.GE_LIST_UNITARY_COST pl1
-- where pl1.list_unitary_cost_id in
--       (4049, 4047, 4045, 1, 4050, 4051, 4048, 4046, 4042)
;

--Lista de costos x items
select distinct pl1.* --, (pl1.items_id || '-' || pl1.list_unitary_cost_id)
  from open.GE_UNIT_COST_ITE_LIS@osfpl pl1,
       open.GE_ITEMS@osfpl             pl2,
       open.GE_LIST_UNITARY_COST@osfpl pl3
 where pl2.ITEMS_ID = pl1.ITEMS_ID
   and pl3.LIST_UNITARY_COST_ID = pl1.LIST_UNITARY_COST_ID
   and pl1.ITEMS_ID in
       (select TT0.ITEMS_ID
          from open.or_task_types_items@osfpl tt0
         where tt0.task_type_id in
               (select t.task_type_id
                  from open.ct_tasktype_contype@osfpl t
                 where t.contract_type_id in
                       (select tc.id_tipo_contrato
                          from open.ge_contrato@osfpl tc
                         where tc.id_contrato in
                               (select t.id_contrato
                                  from open.ge_contrato@osfpl t
                                 where t.id_contratista in (25, 2791)))))
      --and pl1.Last_Update_Date >= '01/01/2023'
      --and (select count(1) from open.GE_LIST_UNITARY_COST a where a.list_unitary_cost_id = pl3.list_unitary_cost_id) = 0
   and (select count(1)
          from open.GE_UNIT_COST_ITE_LIS qh1
         where qh1.Last_Update_Date >= '01/01/2023'
           and (qh1.items_id || '-' || qh1.list_unitary_cost_id) =
               (pl1.items_id || '-' || pl1.list_unitary_cost_id)) = 0
/*and (select count(1)
 from open.GE_UNIT_COST_ITE_LIS qh1,
      open.GE_ITEMS             qh2,
      open.GE_LIST_UNITARY_COST qh3
where qh2.ITEMS_ID = qh1.ITEMS_ID
  and qh3.LIST_UNITARY_COST_ID = qh1.LIST_UNITARY_COST_ID
  and qh1.ITEMS_ID in
      (select TT0.ITEMS_ID
         from open.or_task_types_items@osfpl tt0
        where tt0.task_type_id in
              (select t.task_type_id
                 from open.ct_tasktype_contype@osfpl t
                where t.contract_type_id =
                      (select tc.id_tipo_contrato
                         from open.ge_contrato@osfpl tc
                        where tc.id_contrato = 9961)))
  and qh1.Last_Update_Date >= '01/01/2023'
  and (qh1.items_id || '-' || qh1.list_unitary_cost_id) =
      (pl1.items_id || '-' || pl1.list_unitary_cost_id)) = 0*/
;
--and qh1.list_unitary_cost_id = pl1.list_unitary_cost_id) = 0;
select plt.*
  from open.GE_UNIT_COST_ITE_LIS@osfpl plt
 where plt.last_update_date >= '31/12/2023'
   and plt.items_id in
       (select pltt0.items_id
          from open.or_task_types_items@osfpl pltt0
         where pltt0.task_type_id in
               (select plt.task_type_id
                  from open.ct_tasktype_contype@osfpl plt
                 where plt.contract_type_id = 18))
   and (select count(1)
          from open.GE_UNIT_COST_ITE_LIS t
         where t.last_update_date >= '31/12/2023'
           and t.items_id in
               (select pltt0.items_id
                  from open.or_task_types_items pltt0
                 where pltt0.task_type_id in
                       (select plt.task_type_id
                          from open.ct_tasktype_contype plt
                         where plt.contract_type_id = 18))
           and (t.items_id || '-' || t.list_unitary_cost_id) =
               (plt.items_id || '-' || plt.list_unitary_cost_id)) = 0;

--ROLES POR UNIDAD DE TRABAJO
select *
  from open.OR_ROL_UNIDAD_TRAB@osfpl a
 where
--a.id_unidad_operativa in (4559, 4560, 4561, 4564, 4563, 4562, 4565, 4566, 4567) and 
 (select count(1)
    from open.OR_ROL_UNIDAD_TRAB b
   where b.id_unidad_operativa || '-' || b.id_rol =
         a.id_unidad_operativa || '-' || a.id_rol) = 0;

select *
  from open.OR_ROL_UNIDAD_TRAB@osfpl a
-- where a.id_unidad_operativa in
--       (4559, 4560, 4561, 4564, 4563, 4262, 4565, 4566, 4567)
minus
select *
  from open.OR_ROL_UNIDAD_TRAB a
-- where a.id_unidad_operativa in
--       (4559, 4560, 4561, 4564, 4563, 4262, 4565, 4566, 4567)
;

select gi.*, rowid
  from open.ge_items@osfpl gi
       -- where gi.items_id in (100010087);
       
         select gi1.items_id --gi1.*
           from open.ge_items@osfpl gi1
         minus
         select gi.items_id --*
           from open.ge_items gi
          where (select count(1)
                   from open.ge_items@osfpl gi2
                  where gi.items_id = gi2.items_id) = 0;


---LDCUAI
select se.*, rowid from open.sa_executable se where se.name like '%LDCCU%';
