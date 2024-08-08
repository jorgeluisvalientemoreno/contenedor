select gc_debt_negot_prod.debt_negotiation_id  "Negociacion", 
       gc_debt_negot_prod.sesunuse  "Producto", 
       gc_debt_negot_prod.late_charge_days  "Dias de mora", 
       gc_debt_negot_prod.billed_late_charge  "Valor mora",
       gc_debt_negot_prod.pending_balance  "Saldo pendiente",
       gc_debt_negot_prod.value_to_pay  "Valor a pagar",
       gc_debt_negot_prod.exoner_reconn_charge  "Flag exoneracion"  
from open.gc_debt_negot_prod
where gc_debt_negot_prod.sesunuse = 1157700
order by gc_debt_negot_prod.debt_negotiation_id desc;
