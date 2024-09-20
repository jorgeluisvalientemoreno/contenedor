select sesuserv, cargnuse, sesususc, cargconc, o.concdesc, 
       cargcaca, (select ca.cacadesc from open.causcarg ca where ca.cacacodi = cargcaca) desc_caca, 
       cargsign, decode(cargsign, 'DB', cargvalo, -cargvalo) cargvalo, cargfecr, cargdoso,
       (select no.notaobse from open.notas no where no.notanume = to_number(substr(cargdoso,4,8))) Observacion
  from open.cargos c, open.servsusc s, open.concepto o
 where cargnuse = sesunuse
   and sesunuse in (50675158,50679772,50731209,50752885,50765147,50714451,50722896,50752512,50756847,50758251,50780186,
                    17237196,17253268)
   and cargfecr >= '01-05-2016' and cargfecr <= '01-06-2016'
   and cargtipr = 'P'
   and cargdoso like 'N%'
   and cargconc in (19,30,674,291)
   and cargcaca != 20
   and cargconc = conccodi
