select package_id, contrato  , tipo_causal , case
        when tipo_causal = 0 then '0 - gestion por proceso interno'
        when tipo_causal = 1 then '1 - separación de factura'
        when tipo_causal = 2 then '2 - abono a factura de productos'
        else '-'   end as descripcion_tipo_causal,
        causal , descripcion 
from open.ldc_solcaufnb l
left join open.ldc_causalabonofnb dca on  l.causal = dca.codigo
where l.package_id = 186562845