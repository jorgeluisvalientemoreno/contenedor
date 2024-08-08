    select  cotcconc, 
            cotcserv,
            cotcvige,
            tacocr01 plan_comercial ,
            tacocr02 subcategoria ,
            tacocr03 categoria,
            vitctaco,
            vitccons, 
            vitcfein,
            vitcfefi, 
            vitcvalo, 
            vitcporc
    from open.ta_conftaco t
    left join open.ta_tariconc ta on cotccons= tacocotc
    left join open.ta_vigetaco on tacocons = vitctaco
    left join open.concepto c on cotcconc = c.conccodi
    where cotcconc in (19,30,674)  
      and cotcserv =7014 
      and cotcvige = 'S' and vitcfefi >=to_date(&fechaVenta,'dd/mm/yyyy') and tacocr01=4 and tacocr02 in (1,-1);


 --consulta de tarifas activas para los conceptos de interna, cargo por conexion y certificacion por plan comercial 
-- TACOCR01 PLAN COMERCIAL 
-- TACOCR02 SUBCATEGORIA
-- TACOCR03 CATEGORIA  
--30 interna 19 cxc  674 cert
