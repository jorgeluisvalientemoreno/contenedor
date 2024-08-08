update open.ta_vigetaco
set ta_vigetaco.vitcfein = trunc(sysdate, 'YEAR'),
    ta_vigetaco.vitcfefi = last_day(add_months(trunc(sysdate, 'YEAR'), 11))
where ta_vigetaco.vitccons in (select max(ta_vigetaco.vitccons)
                               from open.ta_vigetaco  X
                               where x.vitctaco in (2186)
                               and vitcfein >= '01/01/2021');
                      