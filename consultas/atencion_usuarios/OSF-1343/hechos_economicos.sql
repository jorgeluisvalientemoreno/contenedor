SELECT movitido "Codigo tipo documento",
       movitimo "Tipo mov",
       movifeco "Fecha",
       movisign "Signo",
       movivalo "Valor mov",
       movicicl "Ciclo",
       moviserv "Tipo producto",
       movicate "Categoria",
       movisuca "Subcategoria",
       moviconc "Concepto",
       movicaca "Causal"
  FROM ic_movimien
  WHERE movifeco >= '01/12/2023'
 and   movifeco <= '02/12/2023'
  and   movitido = 73
  and   movicaca in (4, 20, 50, 53)
  --and movisign != 'C'
 and movicicl in (1301/*,
568,
306,
3802,
5402,
1006,
1022,
1001,
5105,
801,
781,
1301*/)

