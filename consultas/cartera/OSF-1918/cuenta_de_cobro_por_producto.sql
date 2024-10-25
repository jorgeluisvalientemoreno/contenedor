--cuenta_de_cobro_por_producto
select cc.cucocodi,
       cc.cucofact,
       s1.sesususc,
       cc.cuconuse,
       s1.sesuserv,
       cc.cucosuca,
       cc.cucosacu,
       cc.cucovaab,
       cc.cucovato,
       cc.cucovare,
       cc.cucovrap,
       NVL(cc.cucovato,0)- NVL(cc.cucovaab,0)- NVL(cc.cucovare,0)- NVL(cc.cucovrap,0) Pendiente_Pago,
       cc.cucofeve,
       round (sysdate - cc.cucofeve)  edad
from cuencobr  cc
inner join servsusc s1  on s1.sesunuse = cc.cuconuse
where cc.cuconuse in (1147674)
and   cc.cucosacu > 0
order by cc.cuconuse, cc.cucofeve desc;


--and   (sysdate - cc.cucofeve) >= 90
/*update cuencobr  cc1  set cc1.cucofeve  = '29/06/2024' where  cc1.cucocodi = 3059702889*/
