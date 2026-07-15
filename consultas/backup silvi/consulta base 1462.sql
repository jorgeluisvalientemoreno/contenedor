select  s1.sesususc "Contrato", s1.sesunuse "Producto", s1.sesuserv "Tipo producto",cucofact "Factura",cucocodi"cuentas de cobro",cucosacu "Saldo_cuenta_cobro" ,cucovare "Valor_reclamo",cucovrap , (sum(cucosacu) - sum(cucovare) - sum(cucovrap)) "saldo_pend "
from servsusc s1, cuencobr
where cuconuse = s1.sesunuse /*and cucocodi = cargcuco and cargnuse= sesunuse */
and cucosacu > 0  and sesususc  =1144858 --and cucofact not in (2117935940)
group by  s1.sesunuse, s1.sesususc,  s1.sesuserv,cucofact,cucovare,cucosacu,cucocodi ,cucovrap
order by  s1.sesususc;


--2117935940 actual 
SELECT CARGCUCO,CUCOFACT, CARGNUSE ,sesuserv , CARGCONC, CARGCACA, concdesc , cargvalo,CARGPEFA,sesucicl 
FROM CARGOS
LEFT JOIN CUENCOBR ON CUCOCODI = CARGCUCO 
LEFT JOIN SERVSUSC ON CARGNUSE = SESUNUSE 
LEFT JOIN CONCEPTO ON CARGCONC = CONCCODI
WHERE  cargpefa = 105240 and sesususc   = 1023068 and cargcaca in (15,51)  and sesuserv =7053
;


select * from pr_product  where product_id  = 52673650 
