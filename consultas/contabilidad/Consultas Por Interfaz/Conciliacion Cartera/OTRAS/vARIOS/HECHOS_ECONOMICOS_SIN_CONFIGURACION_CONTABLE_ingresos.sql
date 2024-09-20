-- INGRESOS HECHOS SIN REGISTROS
SELECT movitido, movitimo, (select m.timodesc from open.ic_tipomovi m where m.timocodi = movitimo) des_timo,
       movicaca, cacadesc, moviconc, c.concdesc,
       sum(decode(movisign, 'D', movivalo, -movivalo)) total
       --A.* --distinct a.movicaca, i.cacadesc, a.moviconc, c.concdesc, c.concclco
  FROM open.ic_movimien a,  open.concepto c,  open.causcarg i
 WHERE a.movifeco BETWEEN '01-05-2015' AND '31-05-2015 23:59:59'
   And movitido in (71, 73)
   And a.moviconc = c.conccodi and a.movicaca = i.cacacodi
   and c.concclco in (SELECT distinct c.concclco
                        FROM open.ic_movimien a,  open.concepto c,  open.ic_clascont i
                       WHERE a.movifeco BETWEEN '01-05-2015' AND '31-05-2015 23:59:59'
                         And movitido in (71, 73)
                         And a.moviconc = c.conccodi
                         and c.concclco = i.clcocodi
                      group by c.concclco, i.clcodesc
                      minus
                      SELECT distinct Cod_Clasificador
                        FROM (SELECT ecrccoco, c.ecrcfech Fecha_Contable, h.clcocodi Cod_Clasificador, h.clcodesc Desc_Clasificador, 
                                     DECODE(dcrcsign, 'D', dcrcvalo, -dcrcvalo) valor
                                FROM open.ic_decoreco, (SELECT * FROM open.ic_encoreco co
                                                         WHERE ecrccoge IN (SELECT cogecons FROM open.ic_compgene
                                                                             WHERE cogecoco IN (SELECT cococodi 
                                                                                                  FROM open.ic_compcont
                                                                                                 WHERE cocotcco = 1)
                                                                               AND cogefein >= ('01-05-2015')
                                                                               AND cogefefi <= ('31-05-2015'))) c,
                                     open.ic_clascore p, open.ic_clascont h
                               WHERE dcrcecrc = c.ecrccons
                                 AND dcrcclcr = p.clcrcons
                                 AND p.clcrclco = h.clcocodi))
Group by movitido, movitimo, movicaca, cacadesc, moviconc, c.concdesc
