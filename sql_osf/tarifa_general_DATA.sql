SELECT d.vitccons, d.vitcfein,
       d.vitcfefi,
       ravtliin || ' - ' || ravtlisu rango,
       CASE
         WHEN NVL(ravtvalo, 0) != 0 THEN
          ravtvalo
         ELSE
          CASE
            WHEN NVL(vitcvalo, 0) != 0 THEN
             vitcvalo
            ELSE
             CASE
               WHEN NVL(ravtporc, 0) != 0 THEN
                ravtporc
               ELSE
                vitcporc
             END
          END
       END VALOR,
       A.TACOCONS TARIFA,
       COTCSERV,
       tacocr02,
       tacocr03,
       d.rowid
  FROM open.ta_tariconc a
  LEFT OUTER JOIN open.ta_conftaco b
    ON (a.tacocotc = b.cotccons)
  LEFT OUTER JOIN open.ta_vigetaco d
    ON (d.vitctaco = a.tacocons)
  LEFT OUTER JOIN open.ta_rangvitc e
    ON (e.ravtvitc = d.vitccons)
 WHERE 1 = 1
   --and cotcconc = 19
   AND COTCSERV = 7014
   AND tacocr01 = 48
 ORDER BY d.vitcfein DESC;
