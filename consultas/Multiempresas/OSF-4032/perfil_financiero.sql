-- perdil_financiero 
 select f.position_type_id,
        p.name_,
        case 
         when f.action_amount_id = 1 then '1 - MONTO FINANCIACIONES'
          when f.action_amount_id = 2 then '2 - MONTO TRANSACCIÓN EN CAJA'
            when f.action_amount_id = 3 then '3 - MONTO NOVEDAD CONTRATISTA'
              when f.action_amount_id = 4 then '4 - MONTO NOTAS DE FACTURACIÓN'
                when f.action_amount_id = 5 then '5 - MONTO DEVOLUCIÓN SALDO A FAVOR'
                  when f.action_amount_id = 6 then '6 - MONTO NEGOCIACIÓN DE DEUDA'
                    end "accion",
        f.max_budget  presupuesto_maximo
      from ge_person  p,
           ge_financial_profile f
     where p.user_id = (select s.user_id from open.sa_user  s where mask='DIASAL')--DIASAL,  CESMEN
       and f.position_type_id = p.position_type_id
       
       --and p.position_type_id = 1200;
select *
from ldc_specials_plan s
where 1= 1
and   s.product_id in (1188537, 1000449, 1000895)
order by s.init_date desc
for update;

/*select *
from ge_financial_profile f2
where f2.position_type_id = 1200
for update;


update ge_financial_profile f2 set f2.max_budget = 99999999999 where f2.position_type_id = 1200 and f2.action_amount_id in (1,2,3,4,5,6)

99999999999
*/

/*select apmousar, count(1)
from fa_apromofa
where apmousar <> apmousre
group by apmousar
order by count(1) desc*/

