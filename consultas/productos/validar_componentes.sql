 SELECT ROWID id_reg,r.product_id nuproducto,r.is_main principal

    FROM open.pr_component r

   WHERE r.is_main           = 'N'

     AND r.component_type_id = 7038

   ;



  SELECT ROWID id_reg,x.cmsssesu nuproducto,x.cmssmain principal

    FROM open.compsesu x

   WHERE x.cmssmain = 'N'

     AND x.cmsstcom = 7038

   ;
