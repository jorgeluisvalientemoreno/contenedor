select a.causal_id || ' - ' || a.description Causal_Solicitud,
       a.causal_type_id || ' - ' || cct.description Tipo_Causal,
       a.attributed_to,
       a.active
  from OPEN.cc_CAUSAL a
 inner join OPEN.CC_CAUSAL_TYPE cct
    on cct.causal_type_id = a.causal_type_id
 where a.causal_id = 438
