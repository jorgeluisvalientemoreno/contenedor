select a.*, rowid
  from perifact a
 where a.pefacicl = 4402
   and a.pefaano > 2023
 order by a.pefafimo desc;
select a.*, rowid
  from pericose a
 where a.pecscico = 4402
 order by a.pecsfeci desc;
--trginsfechapefa
--select a.*, rowid from open.bitainco a where A.BIINPEFA = 44823
/*10454 - 1983 - Error en la ejecuci�n de la acci�n 8222, 
expresi�n 121401248, se gener� el error 902029 
No se encontr� un per�odo de consumo actual o siguiente para el ciclo [4402] del producto 
[50292925]. [1753977602] [1753977603]. [Error al llamar el servicio GE_BSAction.ExecValidExprByAction]. [1753977604]*/
