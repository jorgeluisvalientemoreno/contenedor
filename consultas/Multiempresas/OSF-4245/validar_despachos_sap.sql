--validar_despachos_sap
SELECT m.mmitcodi,
       m.mmitnudo,
       m.mmitnupe,
       m.mmitdsap,
       m.mmittimo,
       m.mmitdesc,
       m.mmitnatu,
       m.mmitfesa,
       m.mmitesta,
       m.mmitinte,
       m.mmitfecr,
       m.mmitmens,
       d.dmitcodi,
       d.dmititem  item,
       i.description,
       d.dmitcant  cantidad,
       d.dmitcape  cantidad_pendiente,
       d.dmitcoun  costo_unitario,
       d.dmitcoun * d.dmitcant AS valor_total,
       d.dmitvaun  valor_unitario,
       d.dmitpiva  porcet_iva,
       d.dmitalde  almacen_destino,
       d.dmitmarc  marca,
       d.dmitsafi  marca_salida_final,
       d.dmitmabo  marca_borrado,
       d.dmitvalo  nuevo_usado,
       s.serimmit,
       s.seridmit,
       s.sericodi,
       s.serinume,
       s.seriestr,
       s.serimarc,
       s.seriano,
       s.sericaja,
       s.serirema,
       s.seritien
FROM ldci_intemmit m
INNER JOIN ldci_dmitmmit d ON d.dmitmmit = m.mmitcodi
INNER JOIN ge_items i ON i.items_id = d.dmititem
LEFT OUTER JOIN ldci_seridmit s ON s.seridmit = d.dmitcodi AND s.serimmit = m.mmitcodi
WHERE 1=1
and   m.mmitfecr >= '23/05/2025'
and  m.mmitnudo = '1500751'
order by m.mmitfecr desc;


--validar_despachos_sap
/*SELECT*
FROM ldci_intemmit m
WHERE m.mmitnudo = '1500751'
for update;*/
