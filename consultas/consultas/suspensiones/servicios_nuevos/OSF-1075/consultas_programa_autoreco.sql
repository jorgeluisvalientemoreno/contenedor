WITH causas AS
      (
        SELECT /*+ MATERIALIZED */ REGEXP_SUBSTR( '1,4,15,60', '[^,]+', 1, level ) codigo
        FROM DUAL
        CONNECT BY REGEXP_SUBSTR( '1,4,15,60', '[^,]+', 1, level) is not null  
      )
      SELECT /*+ INDEX ( CARGOS IX_CARG_NUSE_CUCO_CONC ) */
           SUM( CASE ca.cargsign WHEN 'DB' THEN cargunid WHEN 'CR' then -cargunid END ) volumen
      FROM cargos ca
      WHERE ca.cargnuse = 51529438
      AND ca.cargcuco > 0
      AND ca.cargconc = 31
      AND ca.cargcaca IN (  SELECT codigo FROM causas )
      AND ca.cargsign IN ( 'DB','CR' )
      AND ca.cargfecr > to_date('17/03/2023 6:14:02','dd/mm/yyyy hh24:mi:ss')
      AND ca.cargpeco IN
      (
                SELECT pecscons
                FROM pericose pc
                WHERE pc.pecscico = 1406
                AND   pc.pecsfeci > to_date('17/03/2023 6:14:02','dd/mm/yyyy hh24:mi:ss')
      );           
      
      
      
        WITH causas AS
      (
        SELECT /*+ MATERIALIZED */ REGEXP_SUBSTR( '1,4,15,60', '[^,]+', 1, level ) codigo
        FROM DUAL
        CONNECT BY REGEXP_SUBSTR( '1,4,15,60', '[^,]+', 1, level) is not null  
      )
      SELECT /*+ INDEX ( CARGOS IX_CARG_NUSE_CUCO_CONC ) */
           SUM( CASE ca.cargsign WHEN 'DB' THEN cargunid WHEN 'CR' then -cargunid END ) volumen
      FROM cargos ca
      WHERE ca.cargnuse = 51529438
      AND ca.cargcuco > 0
      AND ca.cargconc = 31
      AND ca.cargcaca IN (  SELECT codigo FROM causas )
      AND ca.cargsign IN ( 'DB','CR' )
      AND ca.cargfecr > TRUNC(ADD_MONTHS ( SYSDATE , - 6))
      AND ca.cargpeco IN
      (
                SELECT pecscons
                FROM pericose pc
                WHERE pc.pecscico = 1406
                AND   pc.pecsfeci > TRUNC(ADD_MONTHS ( SYSDATE , - 6)
                )
      ); 
      
