select e.* 
from open.factura_elect_general e  , open.factura f  
where documento= factcodi
 and exists ( select null 
            from open.cuencobr , open.servsusc 
            where sesunuse = cuconuse 
            and cucofact = factcodi 
            and sesuserv= 7053) 
order by fecha_registro desc
;

select * 
from open.facturas_emitidas E --, factura f
WHERE codigo_lote=1031 
;

--delete from facturas_emitidas where codigo_lote=1030



select * from open.lote_fact_electronica l
where periodo_facturacion= 113091
order by periodo_facturacion desc ;


update open.lote_fact_electronica l  set periodo_facturacion=-1 where periodo_facturacion= 113091

select e.* 
from open.factura_elect_general e  
where codigo_lote in (1035)
order by fecha_registro desc
;

delete from factura_elect_general where codigo_lote in (1035) 

select * from open.cargos where cargdoso like '%PP_RECARGA%'
and cargfecr >= '15/07/2024' and rownum <= 5

UPDATE PERSONALIZACIONES.LOTE_FACT_ELECTRONICA SET FECHA_INICIO_PROC = NULL WHERE CICLO = 601 AND CODIGO_LOTE = 5964 
select * from open.notas n where notasusc in (67484636)  and n.notafecr >='22/07/2024' ; 

/*insert into lote_fact_electronica
select personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.nextval CODIGO_LOTE ,
PERIODO_FACTURACION ,
ANIO ,
MES ,
CICLO ,
1 CANTIDAD_REGISTRO ,
CANTIDAD_HILOS ,
HILOS_PROCESADO ,
HILOS_FALLIDO ,
INTENTOS ,
'S' FLAG_TERMINADO ,
FECHA_INICIO ,
FECHA_FIN ,
null FECHA_INICIO_PROC ,
null FECHA_FIN_PROC, 
tipo_documento 
from lote_fact_electronica
where codigo_lote = 4647;

delete from  factura_elect_general where codigo_lote = 4647 and documento = 2136290980; 

update factura_elect_general set codigo_lote = 34
where codigo_lote = 4647 and documento = 2136290980;
 


SELECT * FROM OPEN.FACTURA WHERE FACTCODI = 2136345068 */
/*
SELECT * FROM OPEN.TIDOFAEL 
;

select * from open.recofael


update  recofael set prefijo = 'SETT' where tipo_documento=1 
SELECT *
FROM dba_scheduler_jobs
WHERE  JOB_NAME  IN ('JOB_FACTURACION_ELECGEN','JOB_NOTAS_FACTELECGEN','JOB_VENTAS_ELECGEN');


*/   


