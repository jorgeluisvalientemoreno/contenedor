SELECT lm.package_id,
       lm.action_id,
       p.document_type_id,
       p.document_key,
       el.*
  FROM OPEN.MO_WF_PACK_INTERFAC LM,
       OPEN.GE_EXECUTOR_LOG     EL,
       OPEN.MO_PACKAGES         P
 WHERE LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
   AND P.PACKAGE_ID = LM.PACKAGE_ID
   and lm.action_id = 76
   AND LM.STATUS_ACTIVITY_ID = 4
   AND P.PACKAGE_TYPE_ID IN (271)
   and p.document_type_id = 1;
select *
  from open.fa_histcodi h
 where h.hicdnume = 7017779
   and h.hicdtico = 1;
SELECT lm.package_id,
       lm.action_id,
       p.document_type_id,
       p.document_key,
       p.request_date,
       el.message,
       h.*
  FROM OPEN.MO_WF_PACK_INTERFAC LM,
       OPEN.GE_EXECUTOR_LOG     EL,
       OPEN.MO_PACKAGES         P,
       open.fa_histcodi         h
 WHERE LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
   AND P.PACKAGE_ID = LM.PACKAGE_ID
   and lm.action_id = 76
   AND LM.STATUS_ACTIVITY_ID = 4
   AND P.PACKAGE_TYPE_ID IN (271)
   and p.document_type_id = 1
   and h.hicdnume = p.document_key
   and h.hicdtico = p.document_type_id
   and p.document_key = 196630925;
