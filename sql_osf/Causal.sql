select g.causal_id || ' - ' || g.description Causal,
       g.causal_type_id || ' - ' || g2.description Tipo_causal,
       g.attributed_to || ' - ' || ga.description Atributo,
       g.module_id || ' - ' || gm.description Modulo,
       g.class_causal_id || ' - ' || g1.description Clasificacion_Causal,
       g.allow_update Permite_Actualizacion,
       g.observation Observacion
  from open.ge_causal g
 inner join open.ge_class_causal g1
    on g1.class_causal_id = g.class_causal_id
 inner join open.ge_causal_type g2
    on g2.causal_type_id = g.causal_type_id
 inner join open.ge_module gm
    on gm.module_id = g.module_id
 inner join OPEN.GE_ATTRIBUTED_TO ga
    on ga.attributed_to = g.attributed_to
 where g.causal_id in (3904, -- USUARIO SUSPENDIDO CDM REFORMA
                       3905, -- USUARIO SUSPENDIDO ACOMETIDA REFORMA
                       3906, -- RECONEXION CDM REFORMA
                       3907 -- REINSTALACION REFORMA
                       );
