--LOG_LDCTA
SELECT *
FROM OPEN.LDC_LOGTIPTRAADI
WHERE ORDEN_ORGINAL=70229515;

--MAESTRO LDCTA

SELECT *
FROM OPEN.LDC_ORDTIPTRAADI
where order_id=70229515;

--DETALLE LDCTA
SELECT *
FROM OPEN.LDC_ORDTIPTRAADI
where order_id=70229515;

--MATERIALES TIPO DE TRABAJO ADICINAL
SELECT *
FROM OPEN.LDC_ITEMTIPTRAADI