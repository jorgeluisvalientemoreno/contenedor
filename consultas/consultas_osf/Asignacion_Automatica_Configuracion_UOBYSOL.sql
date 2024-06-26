--UOBYSOL - Solicitud
select a.*,
       (select b.description
          from open.ps_package_type b
         where b.package_type_id = a.package_type_id)
  from open.LDC_PACKAGE_TYPE_ASSIGN a
 where a.package_type_id = 100101;

--UOBYSOL - Solicitud - Actividad
select a.package_type_id,
       c.operating_unit_id,
       c.task_type_id,
       c.procesopre,
       c.procesopost,
       c.catecodi,
       c.items_id
  from open.LDC_PACKAGE_TYPE_OPER_UNIT c
 inner join open.LDC_PACKAGE_TYPE_ASSIGN a
    on a.package_type_assign_id = c.package_type_assign_id
 where c.package_type_assign_id =
       (select a1.package_type_assign_id
          from open.LDC_PACKAGE_TYPE_ASSIGN a1
         where a1.package_type_id = 100101)
   and c.items_id = 100007375;

select distinct PTOU.PACKAGE_TYPE_ASSIGN_ID Codigo_UOBYSOL,
                ppt.package_type_id || ' - ' || ppt.description Solicitud,
                PTOU.ITEMS_ID || ' - ' || gi.description Actividad,
                PTOU.Operating_Unit_Id || ' - ' || oou.name Unidad_Opertiva,
                DECODE(PTOU.CATECODI,
                       -1,
                       'TODAS LAS LOCALIDADES',
                       PTOU.CATECODI) Localidad,
                PTOU.PROCESOPRE Servicio_PRE,
                PTOU.PROCESOPOST Servicio_POST
  from open.LDC_PACKAGE_TYPE_OPER_UNIT PTOU
 inner join open.LDC_PACKAGE_TYPE_ASSIGN PTA
    on PTA.PACKAGE_TYPE_ASSIGN_ID = PTOU.package_type_assign_id
 inner join open.ps_package_type ppt
    on ppt.package_type_id = pta.package_type_id
 inner join open.ge_items gi
    on gi.items_id = PTOU.items_id
 inner join open.or_operating_unit oou
    on oou.operating_unit_id = PTOU.Operating_Unit_Id
 where /*PTOU.package_type_assign_id =
       (select a1.package_type_assign_id
          from open.LDC_PACKAGE_TYPE_ASSIGN a1
         where a1.package_type_id = 100101)
   and*/
 PTOU.items_id in (100009788)
--   group by PTOU.PACKAGE_TYPE_OPER_UNIT_ID, ppt.package_type_id || ' - ' || ppt.description ,PTOU.ITEMS_ID || ' - ' || gi.description, PTOU.Operating_Unit_Id || ' - ' || oou.name, PTOU.PACKAGE_TYPE_ASSIGN_ID 
 order by PTOU.PACKAGE_TYPE_ASSIGN_ID;

select c.package_type_oper_unit_id
  from open.LDC_PACKAGE_TYPE_OPER_UNIT c
 where c.procesopre like '%FSBASIGNAUTOMATICAREVPER%';

---Items y Solicitudes
select distinct PTOU.PACKAGE_TYPE_ASSIGN_ID Codigo_UOBYSOL,
                ppt.package_type_id || ' - ' || ppt.description Solicitud,
                PTOU.ITEMS_ID || ' - ' || gi.description Actividad,
                oou.operating_unit_id || ' - ' || oou.name Unidad_Operativa
  from open.LDC_PACKAGE_TYPE_OPER_UNIT PTOU
 inner join open.LDC_PACKAGE_TYPE_ASSIGN PTA
    on PTA.PACKAGE_TYPE_ASSIGN_ID = PTOU.package_type_assign_id
 inner join open.ps_package_type ppt
    on ppt.package_type_id = pta.package_type_id
 inner join open.ge_items gi
    on gi.items_id = PTOU.items_id
  left join open.or_operating_unit oou
    on oou.operating_unit_id = PTOU.Operating_Unit_Id
   and 'S' = &ValidaUnidadOperativa
 where PTOU.PROCESOPRE is null
   and PTOU.PROCESOPOST is null
   and ptou.items_id = 4295105
 order by ppt.package_type_id || ' - ' || ppt.description,
          PTOU.ITEMS_ID || ' - ' || gi.description
