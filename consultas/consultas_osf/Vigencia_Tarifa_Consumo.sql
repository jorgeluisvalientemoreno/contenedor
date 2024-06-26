select t1.*, rowid
  from ta_vigetaco t1
 where (t1.vitctaco || '-' || t1.vitcfefi) in
       (select t.vitctaco || '-' || max(t.vitcfefi)
          from ta_vigetaco t
         group by t.vitctaco)
   and t1.vitctaco = 1744
