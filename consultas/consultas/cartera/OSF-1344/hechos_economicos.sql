select movitido "Codigo tipo documento",
       movitimo "Tipo mov",
       movifeco "Fecha",
       movisign "Signo",
       decode (movisign, 'C', - movivalo, 'D', movivalo) "Valor mov",
       movicicl "Ciclo",
       moviserv "Tipo producto",
       movicate "Categoria",
       movisuca "Subcategoria",
       moviconc "Concepto",
       movicaca "Causal"
  from ic_movimien
  where movifeco >= '30/08/2023'
  and movicicl in (1601)
