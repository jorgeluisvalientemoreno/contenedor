select sesunuse, sesueste
from gasgg.servsusc
where sesunuse in (1011338,1013870,1002074,1001142,1002626,1004361);

select *
from gasgg.caestese
where cetsnuse IN (1011338,1013870,1002074,1001142,1002626,1004361)
 and cetsetac =24;
 



  SELECT *
    FROM GASGG.MOCAESTE MO, GASGG.PROCSUSP PRO
    WHERE MO.MCETCAET IN (11, 14) -- 11 SUSP. POR AREA DE CERTIF y 14 SUSP. ACOM. POR CERTIFIC
        AND MO.MCETPROC = PRO.PRSUCODI
        AND MO.MCETCAET = PRO.PRSUESTE
        AND MO.MCETMOTI = PRO.PRSUMOTI
        and mcetnuse=1001494;
        
        
select *
from open.ldc_marca_producto
where id_producto=4301494;

select count(1)
from migragg.ldc_marca_producto;

migragg.PRDMIGR_PR_PROD_SUSPENSION
