update open.ta_vigetaco set ta_vigetaco.vitcfefi= '28-02-2021 23:59:59'
where ta_vigetaco.vitccons in (select d.vitccons
                               from open.ta_tariconc
                               inner join open.ta_taricopr on ta_taricopr.tacptacc = ta_tariconc.tacocons
                               inner join open.ta_vigetaco  d on d.vitctaco = ta_tariconc.tacocons
                               where ta_taricopr.tacpprta = 6866
                               and ta_vigetaco.vitcfefi '28-12-2021 23:59:59');             
​
update open.ta_vigetacp set ta_vigetacp.vitpfefi = '28-02-2021 23:59:59'
where ta_vigetacp.vitpcons in (select d.vitpcons
                               from open.ta_taricopr
                               inner join open.ta_vigetacp d on d.vitptacp = ta_taricopr.tacpcons
                               where ta_taricopr.tacpprta = 6866
                               and d.vitpfefi = '31-12-2021 23:59:59');