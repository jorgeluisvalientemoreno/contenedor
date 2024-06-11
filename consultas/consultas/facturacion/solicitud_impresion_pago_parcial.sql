select ldc_solcaufnb.package_id, ldc_solcaufnb.contrato  , ldc_solcaufnb.tipo_causal , case
        when tipo_causal = 0 then '0 - gestion por proceso interno'
        when tipo_causal = 1 then '1 - separación de factura'
        when tipo_causal = 2 then '2 - abono a factura de productos'
        else '-'   end as descripcion_tipo_causal,
        ldc_solcaufnb.causal , ldc_causalabonofnb.descripcion 
from open.ldc_solcaufnb 
left join open.ldc_causalabonofnb  on  ldc_solcaufnb.causal = ldc_causalabonofnb.codigo
