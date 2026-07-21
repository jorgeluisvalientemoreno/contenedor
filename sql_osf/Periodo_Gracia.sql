--Periodo_Gracia
SELECT /*+ INDEX(PK_CC_SALES_FINANC_COND e)*/
 e.Financing_Plan_Id Plan_Financiacion,
 e.finan_id Financiacion,
 max(g.end_date) Final_Gracia --, d.difecodi
  FROM cc_sales_financ_cond e
 inner join OPEN.DIFERIDO D
    on e.finan_id = d.difecofi
  left join OPEN.CC_GRACE_PERI_DEFE G
    on G.DEFERRED_ID = D.DIFECODI
 WHERE e.package_id = 42262600
   and (',' || '5,99,6,7,8' || ',' LIKE '%,' || e.financing_plan_id || ',%')
--AND e.quotas_number = 1
 group by e.Financing_Plan_Id, e.finan_id, g.end_date;

SELECT d.difesusc Contrato,
       d.difenuse Producto,
       G.DEFERRED_ID Diferido,
       cgp.grace_period_id || ' - ' || cgp.description Perido_Gracia,
       cgp.min_grace_days Dias_Gracia_Minimos,
       cgp.max_grace_days Dias_Gracia_Maximos,
       g.initial_date Fecha_Incial,
       g.end_date Fecha_Final
  FROM OPEN.CC_GRACE_PERI_DEFE G, OPEN.DIFERIDO D, OPEN.CC_GRACE_PERIOD cgp
 WHERE G.DEFERRED_ID = D.DIFECODI
   and g.grace_period_id = cgp.grace_period_id
   and d.difesusc = 67734032; -- 67791784
-- AND d.difecodi in (8447853)

select a.*, rowid from OPEN.DIFERIDO a where a.difesusc = 67734032;

select *
  from OPEN.CC_GRACE_PERIOD a
 inner join PLANDIFE pd
    on pd.pldipegr = a.grace_period_id
 where a.grace_period_id in (47, 49);
