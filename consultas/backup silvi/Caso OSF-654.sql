select *
from (
 SELECT   SUM(CPSCCOTO) ,   SUM(CPSCPROD)
FROM LDC_COPRSUCA
WHERE cpsccate = 1--ircproduct.sesucate
 AND cpscsuca = 1--ircproduct.sesusuca
 AND cpscubge = 120--nugeoglocation
 AND TO_DATE ('01/'||CPSCMECO||'/'||CPSCANCO , 'DD/MM/YYYY') <
     TO_DATE ('01/'||2||'/'||2023 , 'DD/MM/YYYY')
 GROUP BY CPSCMECO, CPSCANCO
 ORDER BY TO_DATE ('01/'||CPSCMECO||'/'||CPSCANCO , 'DD/MM/YYYY') DESC)
 where rownum = 1;
 
 select o.order_id, oa.product_id, oa.activity_id, o.task_type_id, o.created_date
 from or_order o, or_order_activity oa
 where o.order_id = oa.order_id
  and oa.product_id = 52071561
 -- and trunc(o.created_date) = trunc(sysdate)
  and o.task_type_id  in (12620, 10043, 12619)
  and O.ORDER_STATUS_ID not in (8,12);
 
 select *
 from or_order
 where order_id = 277188779;
 
 select o.order_id, oa.product_id, oa.activity_id, o.task_type_id, o.created_date
 from or_order o, or_order_activity oa
 where o.order_id = oa.order_id
  and oa.product_id = 52071561
  and trunc(o.created_date) = trunc(sysdate)
  and o.task_type_id  in (12620, 10043, 12619)
  and O.ORDER_STATUS_ID not in (8,12);

 
 
select *
  from lectelme, or_order_Activity
  where leemdocu = OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID
   and order_id = 276642424;

select p.product_id, d.address_id, D.GEOGRAP_LOCATION_ID
 from pr_product p, ab_address d
 where p.address_id = d.address_id
  and p.product_id = 3058398;
  
  
  select *
  from lectelme
  where leemsesu = 3055276
  order by leemfele desc;
  --update hicoprpm set HCPPCOPR = 0 where HCPPCONS =116871698;
update servsusc set sesusuca = 1 where sesunuse = 51607908;
update pr_product set SUBCATEGORY_ID = 1 where product_id = 51607908;

select *
from suscripc
where susccodi = 66737105;
select *
from pr_product
where product_id = 51607908;

SELECT NVL(hc.hcppcopr, 0) promedio_propio
--*INTO nuconsumopromedio
FROM open.hicoprpm hc
WHERE hc.hcppsesu = 3055276
AND hc.hcpppeco = (select pc.pecscons
                   from open.pericose pc
                   where pc.pecsfecf = (select max(t.pecsfecf)
                                         from OPEN.PERICOSE t
                                         where t.pecscico in
                                                     (select ss.sesucicl
                                                        from open.servsusc ss
                                                       where ss.sesunuse = 3055276)
                                                 and t.pecsproc = 'S'
                                                 and t.pecsflav = 'S')
                           and pc.pecscico in
                               (select ss.sesucicl
                                  from open.servsusc ss
                                 where ss.sesunuse = 3055276)
                AND rownum = 1);

select COSSSESU producto,
      COSSPEFA periodo,
      COSSCOCA consumo,
      COSSMECC metodo_calculo,
      COSSFLLI flag_liquidacion,
      COSSDICO dias_consumo,
      COSSFERE fecha_registro,
       COSSCAVC calificacion,
      COSSPECS periodo_consumo,
      COSSFUFA funcion     
from conssesu
where cosssesu = 52071561
order by cossfere desc;
select *
from LDC_RECROBLE;

update LDC_RECROBLE set REOBREOB = 1 where REOBCODI = 14;

select *
from pr_product
where product_id = 52162541;

select sesuesco, sesunuse, sesuesfn, SESUCATE, D.GEOGRAP_LOCATION_ID
  from servsusc, pr_product p, ab_address d
  where sesunuse = p.product_id
    and p.address_id = d.address_id
    and sesunuse in (1102534 ,
2071576 ,
2080562 ,
2065298 ,
2065313 ,
2065314 ,
1059996 ,
6100473 ,
2063874 ,
2065328 ,
50111083,
1059268 ,
1061147 ,
1061619 ,
2064421 ,
2064424 ,
2076780 ,
2066901 ,
1110510 ,
17129301,
1129545 ,
1158304 ,
50527121,
27000882,
17031404,
17033028,
2059319 ,
2069980 ,
2070215 ,
17242043,
2091336 ,
17003707,
2080684 ,
2089788 ,
17022508,
17015477,
6104990 ,
50607696,
50652672,
1036478 ,
1121116 ,
1122312 ,
50010116,
50073399,
50026086,
50028483,
6079048 ,
2087215 ,
2089021 ,
1087394 ,
1047630 ,
6087139 ,
1070065 ,
17173187,
1101310 ,
50019788,
50084116,
50018646,
50055601,
50728774,
1141067 ,
1133997 ,
1134277 ,
17236267,
17245422,
50445902,
1052517 ,
1052536 ,
50554083,
1184690 ,
50427139,
1093583 ,
1094180 ,
50081675,
50050915,
50054401,
50059900,
2074908 ,
2078744 ,
6084808 ,
6085109 ,
17008963,
17015930,
50043707,
50333153,
50520591,
50012690,
2057630 ,
2058560 ,
2062281 ,
2062446 ,
1123360 ,
1124275 ,
1124620 ,
1125214 ,
1125540 ,
1143897 ,
17103622,
2071980 ,
2072200 ,
2072317 ,
50285617,
2072261 ,
2072634 ,
2033393 ,
2066208 ,
17099446,
17099789,
2067643 ,
2067708 ,
2068705 ,
17173927,
2067235 ,
2067644 ,
2067702 ,
2067822 ,
2068027 ,
1106853 ,
50598952,
17232185,
17172798,
2079711 ,
2089355 ,
17014535,
17015197,
17015262,
2091465 ,
1106503 ,
1106803 ,
1107557 ,
1107804 ,
17005299,
2072706 ,
2073079 ,
50572617,
50575710,
17201315,
50002615,
2075982 ,
2078533 ,
17150210,
2068241 ,
2068764 ,
2068828 ,
17099370,
2064166 ,
17027820,
17040049,
2065728 ,
2065737 ,
2066450 ,
2066516 ,
2065054 ,
2079027 ,
17008673,
17027339,
17027409,
50061754,
50063163,
1082216 ,
17099670,
1116031 ,
1190197 ,
1170880 ,
1173773 ,
6104020 ,
2071397 ,
17086523,
17019191,
17021749,
50500411,
50598232,
1079774 ,
1079783 ,
50033645,
50037386,
1131880 ,
1061125 ,
1049210 ,
1090820 ,
1055124 ,
1055180 ,
1118587 ,
50502971,
17036570,
17037888,
6098636 ,
6102026 ,
6081731 ,
6138835 ,
50434416,
50434422,
50287596,
6077643 ,
6077686 ,
1096610 ,
1096611 ,
1096864 ,
1085070 ,
50581957,
50077414,
1090860 ,
1090869 ,
1091139 ,
10004791,
50106197,
50066929,
50105108,
1080955 ,
1057581 ,
1090051 ,
1091826 ,
1096812 ,
1096860 ,
1097195 ,
1051709 ,
1048701 ,
50510003,
50327721,
50617669,
1084325 ,
1086198 ,
50641341,
1103448 ,
1104865 ,
50763424,
1043198 ,
6092724 ,
6092725 ,
6097427 ,
1063272 ,
1060058 ,
1147836 ,
1064039 ,
1072692 ,
1055644 ,
1055774 ,
1149475 ,
1152149 ,
1106081 ,
1088506 ,
1090346 ,
1116703 ,
1126596 ,
50530638,
1127248 ,
1094372 ,
50525461,
1028568 ,
50315889,
1072173 ,
50700684,
1121218 ,
50015828,
50016372,
50637656,
1043388 ,
1043506 ,
1043545 ,
1092910 ,
1107985 ,
50774753,
1160307 ,
1114473 ,
1186034 ,
1187460 ,
1069241 ,
1154468 ,
1140507 ,
1037087 ,
50088444,
6077971 ,
6078653 ,
50582298,
6077107 ,
1058214 ,
1058808 ,
1098882 ,
1137671 ,
6092240 ,
6092266 ,
6092391 ,
6092510 ,
6092563 ,
7059197 ,
3056512 ,
3058398 ,
7055747 ,
6095626 ,
3007212 ,
1170729 ,
1171821 ,
1177953 ,
1092192 ,
1092244 ,
13001338,
6097295 ,
6097850 ,
6098067 ,
13002417,
6101441 ,
6088528 ,
6103001 ,
6101330 ,
6135309 ,
6122942 ,
17008295,
17038383,
7057839 ,
50653685,
50020803,
50986950,
17022713,
17031657,
17031904,
50986725,
51077276,
51065748,
51108645,
51178078,
51151405,
51250253,
50527027,
51245930,
51316978,
51353193,
51352029,
51313177,
51479880,
51479887,
51505678,
51490916,
51549153,
51726470,
1059254 ,
51398337,
51748293,
51909777,
51862341,
51861140,
52107944,
52105870,
52193033,
52208581,
52387226,
52223048,
13000044,
52275886,
50078834,
17031270,
34000024,
2024714 ,
50684357,
52050341);


LDC_BSSREGLASPROCLECTURAS
