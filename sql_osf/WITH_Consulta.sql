WITH solicitud AS
 (select package_id
    from open.mo_packages mp
   where mp.package_type_id = 100232
     and mp.motive_status_id = 32)
select S.DESCRIPTION, S.UNIT_ID, D.package_id, S.STATUS_ID
--select s.*, d.package_id
  from (select /*+ index (d IDX_WF_DATA_EXTERNAL_01) index (s IX_WF_INSTANCE23, IX_WF_INSTANCE24)*/
         d.plan_id, d.package_id, d.unit_type_id
          from open.wf_data_external d, solicitud
         where D.package_id in (solicitud.package_id)) d,
       open.wf_instance s
 where D.PLAN_ID = S.PLAN_ID
      --and s.description ='Anular Solicitud'
   and s.unit_id = 828
--and s.status_id = (14)
--and damo_packages.fnugetpackage_type_id(d.package_id,null) = 100232
--   and rownum = 1
