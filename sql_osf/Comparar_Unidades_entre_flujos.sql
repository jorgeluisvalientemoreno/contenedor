select AA.DESCRIPTION, AA.UNIT_ID, aa.package_id, AA.STATUS_ID, bb.package_id,BB.STATUS_ID from 
(select s.*, d.package_id
  from (select /*+ index (d IDX_WF_DATA_EXTERNAL_01) index (s IX_WF_INSTANCE23, IX_WF_INSTANCE24)*/
         d.plan_id, d.package_id, d.unit_type_id
          from open.wf_data_external d
         where D.package_id in (194845907)) d,
       open.wf_instance s
 where D.PLAN_ID = S.PLAN_ID)AA,
(select s.*, d.package_id
  from (select /*+ index (d IDX_WF_DATA_EXTERNAL_01) index (s IX_WF_INSTANCE23, IX_WF_INSTANCE24)*/
         d.plan_id, d.package_id, d.unit_type_id
          from open.wf_data_external d
         where D.package_id in (188919964)) d,
       open.wf_instance s
 where D.PLAN_ID = S.PLAN_ID) BB
 where  AA.DESCRIPTION=BB.DESCRIPTION and  AA.UNIT_ID=BB.UNIT_ID  
