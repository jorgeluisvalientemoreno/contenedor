-- Validar_diferidos
select             d.difecodi,
                   d.difesusc,
                   d.difenuse,
                   d.difeconc,
                   c.concdesc,
                   d.difevatd,
                   d.difevacu,
                   d.difecupa,
                   d.difenucu,
                   d.difesape,
                   d.difenudo,
                   md.modicaca,
                   cc.cacadesc,
                   d.difesign  signo_cargo,
                   md.modisign signo_movi,
                   md.modifech,
                   md.modifeca,
                   md.modicuap,
                   md.modivacu,
                   md.modiprog
from diferido d
inner join concepto c  on c.conccodi = difeconc
left join movidife  md  on md.modinuse = d.difenuse  and md.modidife = d.difecodi and  md.modifech  >= '20/08/2025'
left join causcarg  cc  on cc.cacacodi = md.modicaca
where difenuse in (1000650)
and  md.modicaca = 23
and d.difeconc  in (739, 1086, 203, 603, 1026)
--and difesape >0
and d.difecodi not in (116704761, 116704760,116704791,116704792)
 order by md.modinuse;

--and d.difecodi  not in (116696960, 116696961)
--and d.difeconc in (739, 1086, 203, 603, 1026)
--and difenudo in ('OR-327554774')
--and difesape >0
--and difenudo in ('OR-268504197','OR-322928854','OR-291677461')
--7000888,7053704,7053723,7054007,7055238
/*difenudo in ('OR-333815152','OR-249127948','OR-242163820','OR-338237819','OR-338237817','OR-324050829','OR-282873513','OR-282873512','OR-281013409','OR-364126328',
'OR-356152887','OR-364126322','OR-364126332')*/

--and difesape >0

-- hijos: 7054333,7054346,7054855,7054909,7057634,50077600
/*ordenes hijas: and difenudo in ('OR-313986006','OR-272179530','OR-272179536','OR-270596501','OR-302988632','OR-302988633','OR-294038834','OR-335568602','OR-335568603','OR-330487939',
'OR-366288466','OR-356152379','OR-366288465','OR-366288467','OR-353036138') */










