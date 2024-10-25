--cuenta_de_cobro_por_contrato
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
where s1.sesususc in (1147674)
and   cc.cucosacu > 0
order by cc.cuconuse, cc.cucofeve desc;

/*update cuencobr  cc1  set cc1.cucofeve  = '30/06/2024' where  cc1.cucocodi = 3060241039*/
