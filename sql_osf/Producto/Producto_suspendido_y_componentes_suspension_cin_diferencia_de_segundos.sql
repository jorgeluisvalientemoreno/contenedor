select /*+ index (ps IDX_PR_PROD_SUSPENSION_01)*/
 ps.*, cmsssesu, cmssidco, pc.*
  from open.pr_prod_suspension ps
 inner join open.compsesu
    on ps.product_id = cmsssesu
 inner join open.pr_comp_suspension pc
    on cmssidco = pc.component_id
   and pc.suspension_type_id <> ps.suspension_type_id
   and pc.aplication_date between ps.aplication_date and
       (ps.aplication_date + 1 / (60 * 60 * 24))
 where ps.suspension_type_id = 2
   and ps.aplication_date >= '01/01/2021';
