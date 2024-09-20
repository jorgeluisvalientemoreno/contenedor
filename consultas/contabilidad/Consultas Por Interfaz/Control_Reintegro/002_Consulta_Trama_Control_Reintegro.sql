-- Consulta trama Control Reintegro
select clasecta, (select cuctdesc from open.ldci_cuentacontable where cuctcodi = clasecta) nom_cuenta,
       clavref3, asignacn, total
  from (
         select *
          from (
                  select (Case When Ctadiv Is Null Then Clasecta Else Ctadiv End) Clasecta,
                         clavref3, asignacn, sum(decode(clavcont, '40', 1, '01', 1, -1) * impomtrx) Total
                    from open.ldci_detaintesap l
                   where l.cod_interfazldc = 12037
                     and (clasecta LIKE '%1110%' OR clasecta LIKE '1202%')
                  group by (Case When Ctadiv Is Null Then Clasecta Else Ctadiv End), clavref3, asignacn
                  order by 2, 1
               )
         where total != 0
       )
