--Configuracion promocion
select *
  from open.cc_promotion
 where 1 = 1
   and promotion_id = 417
 order by init_offer_date asc; -- for update;

--detalle promocion
select *
  from cc_prom_detail
 where 1 = 1
   and promotion_id = 417
 order by concept_id desc;

--Promocion Asignada a Motivo
select * from open.MO_MOT_PROMOTION order by register_date desc;

--Promocion asignada a producto
select *
  from open.PR_PROMOTION
 where product_id = 50029154
 order by initial_date asc;

--select * from CC_PROM_COMP; no se usa 
--select * from  CC_COM_SEG_PROM; --no se usa
--select * from PP_COPPSSCO --no se usa

select UT_DATE.FSBSTR_SYSDATE from dual;
--Excepciones registradas para el cobro de factura
SELECT *
  FROM open.LDC_EXCEP_COBRO_FACT
 WHERE 1 = 1
   and fecha >= '20/03/2024'
 order by fecha desc;
