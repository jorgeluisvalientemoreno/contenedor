select *
  from open.estaprog
 where esprpefa in (select pefacodi
                      from open.perifact
                     where pefaactu = 'S'
                       and trunc(pefaffmo) = trunc(sysdate))
   and esprprog like 'FIDF%';
