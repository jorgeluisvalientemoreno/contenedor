-- OSCAR RESTREPO
-- MOVIMIENTO DESDE HECHOS
SELECT       
      TIPO,      
      PRODUCTO,      
      TIPOMOVI,      
      DESC_MOVITIMO,      
      TIPO_HECHO,      
      MOVISIGN SIGNO,      
      CONCCLCO COD_CLASIFICADOR,      
      CLCODESC DESC_CLASIFICADOR,      
      FECHA,CAUSAL,       
      SUM(DECODE(TIPOMOVI,1,VALOR,16,VALOR,25,VALOR,56,VALOR,-VALOR)) VALOR       
FROM (       
                  /*Facturación por Concepto*/       
                  select DECODE(movitido,71,'FACTURACION',73,'NOTAS') TIPO,MOVISERV PRODUCTO,movitimo TIPOMOVI,       
                  (SELECT TIMODESC FROM open.ic_tipomovi WHERE TIMOCODI = MOVITIMO and rownum=1) DESC_MOVITIMO,       
                  MOVITIHE TIPO_HECHO,movifeco FECHA,MOVICACA CAUSAL,movisign, moviconc,      
                  sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor        
                    from open.ic_movimien        
                    where movitido = 71       
                    and movifeco >= '01-04-2015'
                    and movifeco <= '30-04-2015'       
                    AND MOVITIHE = 'F'       
                    AND MOVITIMO = 1       
                    group by movifeco,  movitido, MOVITIHE,  movitimo,  MOVISERV, MOVITIMO, MOVICACA,moviconc,movisign       
              UNION       
                  /*Aplicación de Saldo a Favor en Facturación*/       
                  select DECODE(movitido,71,'FACTURACION',73,'NOTAS') TIPO,MOVISERV PRODUCTO,movitimo TIPOMOVI,       
                  (SELECT TIMODESC FROM open.ic_tipomovi WHERE TIMOCODI = MOVITIMO and rownum=1) DESC_MOVITIMO,       
                  MOVITIHE TIPO_HECHO,movifeco FECHA,MOVICACA CAUSAL,movisign, moviconc,      
                  sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor        
                    from open.ic_movimien        
                    where movitido = 71       
                    and movifeco >= '01-04-2015'
                    and movifeco <= '30-04-2015'     
                    AND MOVITIHE is null       
                    AND MOVITIMO = 11       
                    group by movitido,movifeco,moviserv,movitimo,MOVICACA,MOVITIHE,moviconc,movisign       
              UNION       
                  /*Aplicación Saldo a Favor por Notas*/       
                  select DECODE(movitido,71,'FACTURACION',73,'NOTAS') TIPO,MOVISERV PRODUCTO,movitimo TIPOMOVI,       
                  (SELECT TIMODESC FROM open.ic_tipomovi WHERE TIMOCODI = MOVITIMO and rownum=1) DESC_MOVITIMO,       
                  MOVITIHE TIPO_HECHO,movifeco FECHA,MOVICACA CAUSAL,movisign, moviconc,      
                  sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor        
                    from open.ic_movimien        
                    where movitido = 73       
                    and movifeco >= '01-04-2015'
                    and movifeco <= '30-04-2015'       
                    AND MOVITIHE is null       
                    AND MOVITIMO = 40       
                    group by movitido,movifeco,moviserv,movitimo,MOVICACA,MOVITIHE,moviconc,movisign       
              UNION       
                  /*Saldo a Favor por Facturación*/       
                  select DECODE(movitido,71,'FACTURACION',73,'NOTAS') TIPO,MOVISERV PRODUCTO,movitimo TIPOMOVI,       
                  (SELECT TIMODESC FROM open.ic_tipomovi WHERE TIMOCODI = MOVITIMO and rownum=1) DESC_MOVITIMO,       
                  MOVITIHE TIPO_HECHO,movifeco FECHA,MOVICACA CAUSAL,movisign, moviconc,      
                  sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor        
                    from open.ic_movimien        
                    where movitido = 71       
                    and movifeco >= '01-04-2015'
                    and movifeco <= '30-04-2015'         
                    AND MOVITIHE is null       
                    AND MOVITIMO = 44       
                    group by movitido,movifeco,moviserv,movitimo,MOVICACA,MOVITIHE,moviconc,movisign       
              UNION       
                  /*Saldo a Favor por Notas*/       
                  select DECODE(movitido,71,'FACTURACION',73,'NOTAS') TIPO,MOVISERV PRODUCTO,movitimo TIPOMOVI,       
                  (SELECT TIMODESC FROM open.ic_tipomovi WHERE TIMOCODI = MOVITIMO and rownum=1) DESC_MOVITIMO,       
                  MOVITIHE TIPO_HECHO,movifeco FECHA,MOVICACA CAUSAL,movisign, moviconc,      
                  sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor        
                    from open.ic_movimien        
                    where movitido = 73       
                    and movifeco >= '01-04-2015'
                    and movifeco <= '30-04-2015'         
                    AND MOVITIHE is null       
                    AND MOVITIMO = 46       
                    group by movitido,movifeco,moviserv,movitimo,MOVICACA,MOVITIHE,moviconc,movisign       
              UNION       
                  /*Notas por Concepto*/       
                  select DECODE(movitido,71,'FACTURACION',73,'NOTAS') TIPO,MOVISERV PRODUCTO,movitimo TIPOMOVI,       
                  (SELECT TIMODESC FROM open.ic_tipomovi WHERE TIMOCODI = MOVITIMO and rownum=1) DESC_MOVITIMO,       
                  MOVITIHE TIPO_HECHO,movifeco FECHA,MOVICACA CAUSAL,movisign, moviconc,      
                  sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor        
                    from open.ic_movimien        
                    where movitido = 73       
                    and movifeco >= '01-04-2015'
                    and movifeco <= '30-04-2015'      
                    AND MOVITIHE is null       
                    AND MOVITIMO in (16,56)       
                    group by movitido,movifeco,moviserv,movitimo,MOVICACA,MOVITIHE,moviconc,movisign       
              UNION       
                  select DECODE(movitido,71,'FACTURACION',73,'NOTAS') TIPO,MOVISERV PRODUCTO,movitimo TIPOMOVI,       
                  (SELECT TIMODESC FROM open.ic_tipomovi WHERE TIMOCODI = MOVITIMO and rownum=1) DESC_MOVITIMO,       
                  MOVITIHE TIPO_HECHO,movifeco FECHA,MOVICACA CAUSAL,movisign, moviconc,      
                  sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor        
                    from open.ic_movimien        
                    where movitido = 73       
                    and movifeco >= '01-04-2015'
                    and movifeco <= '30-04-2015'  
                    AND MOVITIHE is null       
                    AND MOVITIMO = 48       
                    group by movitido,movifeco,moviserv,movitimo,MOVICACA,MOVITIHE,moviconc,movisign       
              UNION       
                  select DECODE(movitido,71,'FACTURACION',73,'NOTAS') TIPO,MOVISERV PRODUCTO,movitimo TIPOMOVI,       
                  (SELECT TIMODESC FROM open.ic_tipomovi WHERE TIMOCODI = MOVITIMO and rownum=1) DESC_MOVITIMO,       
                  MOVITIHE TIPO_HECHO,movifeco FECHA,MOVICACA CAUSAL,movisign, moviconc,      
                  sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor        
                    from open.ic_movimien        
                    where movitido = 73       
                    and movifeco >= '01-04-2015'
                    and movifeco <= '30-04-2015'         
                    AND MOVITIHE is null       
                    AND MOVITIMO = 57       
                    group by movitido,movifeco,moviserv,movitimo,MOVICACA,MOVITIHE,moviconc,movisign       
              UNION       
                  SELECT TIPO,PRODUCTO,TIPOMOVI,       
                  (SELECT TIMODESC FROM open.ic_tipomovi WHERE TIMOCODI = TIPOMOVI and rownum=1) DESC_MOVITIMO,       
                  TIPO_HECHO, FECHA,CAUSAL,movisign, moviconc,SUM(valor) VALOR      
                    FROM (      
                          /*Recaudo por Concepto*/      
                          select 'RECAUDOS' TIPO,MOVISERV PRODUCTO,movitimo TIPOMOVI,      
                          (SELECT TIMODESC FROM open.ic_tipomovi WHERE TIMOCODI = MOVITIMO and rownum=1) DESC_MOVITIMO,      
                          MOVITIHE TIPO_HECHO,movifeco FECHA,MOVICACA CAUSAL,movisign,moviconc,sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor       
                             from open.ic_movimien       
                             where movitido = 72      
                             and movifeco >= '01-04-2015'
                             and movifeco <= '30-04-2015'       
                             AND MOVITIMO = 23      
                          group by movifeco,  movitido, MOVITIHE,  movitimo,  MOVISERV,  MOVICACA,moviconc,movisign      
                         )      
                    GROUP BY TIPO,PRODUCTO,TIPOMOVI,DESC_MOVITIMO,TIPO_HECHO,FECHA,CAUSAL,moviconc,movisign                  
     ) , OPEN.CONCEPTO, OPEN.IC_CLASCONT      
    WHERE moviconc =  CONCCODI      
    AND CONCCLCO = CLCOCODI (+)      
    GROUP BY TIPO,PRODUCTO,TIPOMOVI,DESC_MOVITIMO,TIPO_HECHO,FECHA,CAUSAL,CONCCLCO,CLCODESC,movisign
