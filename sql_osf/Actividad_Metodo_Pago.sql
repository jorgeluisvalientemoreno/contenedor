SELECT a.items_id ID,
       b.description || '     MODALIDAD[' ||
       DECODE(a.pay_modality,
              1,
              '1-Antes de Hacer los Trabajos',
              2,
              '2-Al Finalizar los Trabajos',
              3,
              '3-Seg¿n Avance de Obra',
              4,
              '4-Sin Cotizaci¿n') || ']    PRODUCTO[' ||
       DECODE(a.product_type_id,
              null,
              'N/A',
              pktblServicio.fsbGetDescription(a.product_type_id)) || ']' DESCRIPTION
  FROM ps_engineering_activ a, ge_items b
 WHERE a.items_id = b.items_id
