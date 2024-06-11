with  Consumo_actual as (select   (1+20)  Consumo_desv
                        from dual
) , max_perifact as  ( select max(l2.leempefa) periodo_fact  from open.lectelme l2 where l2.leemsesu = 17161263)
, Consumo_anterior as  (select lectelme.leemleto Lectura_ant
                        from open.lectelme
                        where leemsesu = 17161263
                        and leempefa <=  (select periodo_fact from max_perifact)
                        and leemfele = (select max(l3.leemfele)
                                        from lectelme l3
                                        where lectelme.leemsesu = l3.leemsesu
                                        and  leempefa <= (select periodo_fact from max_perifact))
                        and leemleto is not null)

, Calificacion_est as (select calivaco.cavccodi ||' : '|| initcap(calivaco.cavcdesc)  Calificacion
from open.caravaco
inner join open.racavaco on racavaco.rcvccrvc = crvccodi
inner join open.calivaco on calivaco.cavccodi = racavaco.rcvccavc
where caravaco.crvccate = (select category_id
                           from open.pr_product
                           where product_id = 17161263)
and caravaco.crvcsuca = (select subcategory_id
                         from open.pr_product
                         where product_id = 17161263)
and  2  between caravaco.crvcraci and caravaco.crvcracf
and (select round(( Consumo_desv - 2) /  2 * 100)
                      from Consumo_actual) between racavaco.rcvcrain and racavaco.rcvcrafi
), Consumo_final as (   select (select Lectura_ant from Consumo_anterior)  "Lectura Anterior",
                    (select (Lectura_ant + (select Consumo_desv - 1
                                            from Consumo_actual))
                                            from Consumo_anterior) "Lectura Actual Calculada",
                     (select Consumo_desv from Consumo_actual) "Consumo",
                      Calificacion  "Calificacion",
                     (select round(( Consumo_desv - 2) / 2 * 100)
                      from Consumo_actual)  "% de Variacion Calculado"
                     from Calificacion_est
)
select *
from Consumo_final