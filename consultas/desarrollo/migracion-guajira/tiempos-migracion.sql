SELECT 
    PROGRAMA, 
    TIEMPO_TRANSCURRIDO, 
    TOTAL_PROCESAR, 
    TOTAL_PROCESADO, 
    TOTAL_CORRECTO,
    TOTAL_ERROR
FROM (
    -- Parte por programa
    SELECT 
        LPMPROG AS PROGRAMA,
        FLOOR((NVL(MAX(LPMFEFI), SYSDATE) - MAX(LPMFEIN)) * 24) || ' horas, ' ||
        FLOOR(MOD((NVL(MAX(LPMFEFI), SYSDATE) - MAX(LPMFEIN)) * 24 * 60, 60)) || ' minutos, ' ||
        FLOOR(MOD((NVL(MAX(LPMFEFI), SYSDATE) - MAX(LPMFEIN)) * 86400, 60)) || ' segundos' AS TIEMPO_TRANSCURRIDO,
        TO_CHAR(SUM(LPMREAP), 'FM999G999G999G990') AS TOTAL_PROCESAR,
        TO_CHAR(SUM(LPMREPR), 'FM999G999G999G990') AS TOTAL_PROCESADO,
        TO_CHAR(SUM(LPMREPR) - SUM(LPMREER), 'FM999G999G999G990') AS TOTAL_CORRECTO,
        TO_CHAR(SUM(LPMREER), 'FM999G999G999G990') AS TOTAL_ERROR,
        MIN(LPMFEIN) AS FECHA_INICIO
    FROM MIGRAGG.LOG_PROC_MIGRA d
    ---where d.lpmprog!='PRDMIGR_FACTURAS_EMITIDAS'
    GROUP BY LPMPROG
 
    UNION ALL
 
    -- Parte de total general
    SELECT 
        'TOTAL GENERAL ---------->' AS PROGRAMA,
        FLOOR(SUM(total_segundos) / 3600) || ' horas, ' ||
        FLOOR(MOD(SUM(total_segundos), 3600) / 60) || ' minutos, ' ||
        MOD(SUM(total_segundos), 60) || ' segundos' AS TIEMPO_TRANSCURRIDO,
        TO_CHAR(SUM(LPMREAP), 'FM999G999G999G990') AS TOTAL_PROCESAR,
        TO_CHAR(SUM(LPMREPR), 'FM999G999G999G990') AS TOTAL_PROCESADO,
        TO_CHAR(SUM(LPMREPR) - SUM(LPMREER), 'FM999G999G999G990') AS TOTAL_CORRECTO,
        TO_CHAR(SUM(LPMREER), 'FM999G999G999G990') AS TOTAL_ERROR,
        TO_DATE('9999-12-31', 'YYYY-MM-DD') AS FECHA_INICIO
    FROM (
        SELECT 
            NVL(MAX(LPMFEFI), SYSDATE) - MIN(LPMFEIN) AS duracion_dias,
            SUM(LPMREAP) AS LPMREAP,
            SUM(LPMREPR) AS LPMREPR,
            SUM(LPMREER) AS LPMREER,
            ROUND((NVL(MAX(LPMFEFI), SYSDATE) - MIN(LPMFEIN)) * 86400) AS total_segundos
        FROM MIGRAGG.LOG_PROC_MIGRA d
       -- where d.lpmprog!='PRDMIGR_FACTURAS_EMITIDAS'
        GROUP BY LPMPROG
    )
)
ORDER BY FECHA_INICIO;
/





select l.lpmprog, (max(l.lpmfefi)-min(l.lpmfein) )*24*60 tiempo, sum(l.lpmreap) total, sum(l.lpmrepr) procesados, sum(l.lpmreer) errores, max(l.lpmcodi) codigo
from migragg.log_proc_migra l
where l.lpmfein>='16/10/2025 17:00:00'
group by l.lpmprog
order by codigo;
