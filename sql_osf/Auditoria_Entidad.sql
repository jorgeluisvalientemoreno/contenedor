SELECT *
  FROM open.au_aud_pol_attr      b,
       open.ge_entity_attributes c,
       open.ge_entity            d,
       open.AU_LOG_POLICY        au,
       open.AU_AUDIT_POLICY      ap
 WHERE b.entity_attribute_id = c.entity_attribute_id
   AND c.entity_id = d.entity_id
   AND b.is_monitored = 1
   AND b.is_object_attribute = 1
   AND b.entity_attribute_id IS NOT NULL
   AND b.entity_attribute_id = c.entity_attribute_id
   AND D.NAME_ = upper('GE_ACTA')
   and b.audit_log_id = au.audit_log_id
   and au.audit_policy_id = ap.audit_policy_id
   and (select t.STATUS
          from dba_triggers t
         where t.TRIGGER_NAME = au.trigger_name) != 'DISABLED';
SELECT B.AUDIT_LOG_ID,
       C.TECHNICAL_NAME,
       C.DISPLAY_NAME,
       COMMENT_,
       NAME_,
       AU.AUDIT_POLICY_ID,
       BASE_TABLE_NAME,
       TRIGGER_NAME,
       AU.EVENT_ID,
       ev.description,
       AU.AUD_POL_STATUS_ID,
       AP.NAME,
       AP.DESCRIPTION,
       AP.AUD_POL_STATUS_ID,
       DECODE(AP.AUD_POL_STATUS_ID,
              0,
              'JUST_CREATED_STATUS',
              3,
              'ENABLED_INVALID_POLICY_STATUS',
              4,
              'ENABLED_POLICY_STATUS',
              5,
              'DISABLED_POLICY_STATUS ',
              7,
              'NO_CONSISTENT_POLICY_STATUS',
              8,
              'DISABLED_INVALID_POLICY_STATUS',
              18,
              'DELETED_POLICY_STATUS') DESC_AUD_POL_STATUS,
       (select t.STATUS
          from dba_triggers t
         where t.TRIGGER_NAME = au.trigger_name) estado_trigger,
       DECODE(AP.IS_FOR_ALL_USERS, 0, 'NO', 1, 'SI') IS_FOR_ALL_USERS,
       AP.AUD_POL_TYPE,
       DECODE(AP.AUD_POL_TYPE, 'P', 'PROCESO', 'U', 'USUARIO') DESC_POL_TYPE
  FROM open.au_aud_pol_attr      b,
       open.ge_entity_attributes c,
       open.ge_entity            d,
       open.AU_LOG_POLICY        au
  left join open.GE_EVENT ev
    on ev.event_id = au.event_id, open.AU_AUDIT_POLICY ap

 WHERE b.entity_attribute_id = c.entity_attribute_id
   AND c.entity_id = d.entity_id
   AND b.is_monitored = 1
   AND b.is_object_attribute = 1
   AND b.entity_attribute_id IS NOT NULL
   AND b.entity_attribute_id = c.entity_attribute_id
   AND D.NAME_ = upper('ab_address')
   and b.audit_log_id = au.audit_log_id
   and au.audit_policy_id = ap.audit_policy_id;
