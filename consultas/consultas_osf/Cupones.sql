SELECT c.*, rp.PAANFECH 
FROM "OPEN"."CUPON" c 
LEFT JOIN "OPEN"."PAGOS" p ON "PAGOCUPO" = "CUPONUME" 
LEFT JOIN "OPEN"."RC_PAGOANUL" rp ON rp."PAANCUPO" = c."CUPONUME"
WHERE "CUPOSUSC" = 67257793
ORDER BY "CUPOFECH" DESC
