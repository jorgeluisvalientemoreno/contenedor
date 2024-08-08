select * from open.GE_EQUIVALENCE_SET@Osfpl;
select *
  from open.GE_EQUIVALENC_VALUES@Osfpl
 where equivalence_set_id = 218
minus
select *
  from GE_EQUIVALENC_VALUES
 where equivalence_set_id = 218;
select *
  from open.GE_EQUIVA_SET_FIELDS@Osfpl
 where equivalence_set_id = 218;
select *
  from ge_causal gc
 where gc.causal_id in
       (3843, 3844, 3845, 3386, 3846, 3847, 3848, 3849, 3850)
