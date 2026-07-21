select cuconuse Producto, sum(cucovare) Valor_Reclamo
  from open.cuencobr
 where 1 = 1
      --and cuconuse = 50732225
   and nvl(cucovare, 0) > 0
   and rownum <= 30
 group by cuconuse
having sum(cucovare) > 0
