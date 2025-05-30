select a.*, rowid
  from OPEN.ge_equivalence_set a
 where a.equivalence_set_id = 218;
select a1.*, rowid
  from OPEN.GE_EQUIVALENC_VALUES a1
 where a1.equivalence_set_id in
       (select a.equivalence_set_id
          from OPEN.ge_equivalence_set a
         where a.equivalence_set_id = 218);
select a1.equivalence_set_id Modulo_Ordenes,
       a1.equivalence_value_id Codigo_Equivalente,
       a1.origin_value || ' - ' || gc.description Causal,
       a1.target_value Valor_Destino,
       a1.hash_value,
       a1.hash_value_target
  from OPEN.GE_EQUIVALENC_VALUES a1
 inner join open.ge_causal gc
    on gc.causal_id = a1.origin_value
 where a1.equivalence_set_id in
       (select a.equivalence_set_id
          from OPEN.ge_equivalence_set a
         where a.equivalence_set_id = 218)
   and a1.origin_value = 9795;
