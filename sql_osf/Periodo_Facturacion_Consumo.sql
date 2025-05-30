--select distinct ss.sesucicl from open.servsusc ss where ss.sesususc = 1015760 ss.sesunuse = 1804543;
--update open.perifact pf set pf.pefaactu = 'N' where pf.pefaactu = 'S' and pf.pefaffmo and pf.pefacicl = 6309;
--update open.perifact pf set pf.pefaactu = 'S' where trunc(sysdate) between pf.pefafimo and pf.pefaffmo and pf.pefacicl = 6309;
select a.*, rowid
  from open.perifact a
 where a.pefacicl = 501
   and a.pefaano > 2024
 order by a.pefafimo desc;
--update  open.perifact a set a.pefaactu = 'S' where a.pefacodi = 117198;
--update  open.perifact a set a.pefaactu = '-' where a.pefacodi = 116338;
select a.*, rowid
  from open.pericose a
 where a.pecscico = 501
 order by a.pecsfeci desc;
--update  open.pericose a set a.pecsfecf = to_date('06/11/25', 'DD/MM/YY') where a.pecscons = 49524;
--select * from open.ciclo;
--select * from personalizaciones.lote_fact_electronica;
--trginsfechapefa
--select a.*, rowid from open.bitainco a where A.BIINPEFA = 44823
/*10454 - 1983 - Error en la ejecución de la acción 8222, 
expresión 121401248, se generó el error 902029 
No se encontró un período de consumo actual o siguiente para el ciclo [8414] del producto 
[50292925]. [1753977602] [1753977603]. [Error al llamar el servicio GE_BSAction.ExecValidExprByAction]. [1753977604]*/
