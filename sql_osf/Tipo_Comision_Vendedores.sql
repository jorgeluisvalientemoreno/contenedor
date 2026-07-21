--Tipo comision
select a.*, rowid
  from OPEN.LDC_TIPO_COMISION_NEL a
 where a.tipo_comision_id = 6;
--Plan comercial para Tipo Comision
select a.*, rowid
  from OPEN.LDC_COMISION_PLAN_NEL a
 where a.tipo_comision_id = 6;
--Tarifa para vendedores por plan de comison
select a.*, rowid
  from OPEN.LDC_COMI_TARIFA_NEL a
 where a.comision_plan_id in
       (select a1.comision_plan_id
          from OPEN.LDC_COMISION_PLAN_NEL a1
         where a1.tipo_comision_id = 6);
--Tipo Comision x unidad operativa
select a.*, rowid
  from OPEN.LDC_INFO_OPER_UNIT_NEL a
 where a.tipo_comision_id = 6;
