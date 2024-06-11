select nvl(sum(cucosacu), 0) Valor_Total
  from open.cuencobr
 where cuconuse = 52361289
   and nvl(cucosacu, 0) > 0
   and nvl(cucovare, 0) = 0
   and nvl(cucovrap, 0) = 0;
