
select * from open.cc_promotion  where promotion_id = 417 for update ;
select * from open.MO_MOT_PROMOTION order by register_date desc ; 
--select * from CC_PROM_COMP; no se usa 
--select * from  CC_COM_SEG_PROM; --no se usa
select * from open.PR_PROMOTION@osfpl  where product_id = 50029154  order by initial_date asc ;
select * from open.PR_PROMOTION where product_id = 50029154  order by initial_date asc ;

--select * from PP_COPPSSCO --no se usa

select UT_DATE.FSBSTR_SYSDATE from dual ;
SELECT * --TIPO_EXCEP
        FROM open.LDC_EXCEP_COBRO_FACT@Osfpl
       WHERE fecha>= '20/03/2024';
       --PACKAGE_ID = 207052231;
       
       select * from open.mo_packages@Osfpl m , open.mo_motive@Osfpl mo where mo.package_id= m.package_id and  mo.package_id= 211793686;
       select * from open.or_order@osfpl where order_id = 319201178
;

select sesucicl from servsusc where sesususc = 66753443

;

select * from cc_prom_detail 
select * from concepto where conccodi = 201
select * from open.cc_prom_detail  p  
left join open.gr_config_expression g on  g.config_expression_id =  p.config_expression_id 
where promotion_id in  (  469,  470, 466, 467, 468);
