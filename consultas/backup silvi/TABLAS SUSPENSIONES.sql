select * from  PR_PRODUCT
where product_id in ( 1163279 ,2067091) ; 
select * from  SERVSUSC
where sesunuse  in ( 1163279 ,2067091) ;
select * from  PR_PROD_SUSPENSION
where product_id in ( 1163279 ,2067091) ; 
select * from COMPSESU
where cmsssesu in ( 1163279 ,2067091) ;
select * from  PR_COMP_SUSPENSION
where  component_id in (select cmssidco from COMPSESU
where cmsssesu in ( 1163279 ))  ;
select * from  PR_COMP_SUSPENSION
where  component_id in (select cmssidco from COMPSESU
where cmsssesu in ( 2067091 ))  ;
select * from  PR_COMPONENT  where product_id in ( 1163279 ,2067091) ;  
select * from suspcone s 
where suconuse in ( 1163279 )
order by sucofeor desc;
select * from suspcone s 
where suconuse in ( 2067091 )
order by sucofeor desc;

--definir que pasa con esa orden 

