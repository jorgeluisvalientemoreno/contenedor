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
  WHERE movifeco >'12/07/2023'
  and movicicl in (201)