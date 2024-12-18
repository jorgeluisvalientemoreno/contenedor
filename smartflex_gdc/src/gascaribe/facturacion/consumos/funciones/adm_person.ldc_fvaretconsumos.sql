CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FVARETCONSUMOS" (inuSesunuse NUMBER, inuCiclCodi NUMBER) RETURN VARCHAR2  IS
/*****************************************************************
Propiedad intelectual de GDO.

Unidad         : LDC_fvaRetConsumos
Descripción    : Retorna los ultimos consumos de un servicio suscrito.
Autor          : Arquitecsoft/Millerlandy Moreno T.
Fecha          : 28-03-2014

Parametros             Descripcion
============        ===================
inuSesunuse         Codigo del servicio suscrito


Historia de Modificaciones

DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
-----------  -------------------    -------------------------------------
******************************************************************/
  --<<
  -- Variables del proceso
  -->>
  vaCosumos  VARCHAR2(2000); -- Variable para almacenar los ultimos 6 consumos
  nuCont     NUMBER :=1;     -- Contador de consumos a retornar
  --<<
  -- Cursores del proceso
  -->>
  --<<
  -- Cursor que obtiene el perido de consumo
  -->>

  CURSOR cuPerido IS
  SELECT COSSPECS,cosscoca
  FROM open.servsusc,open.elmesesu es,open.lectelme lec,open.conssesu
 WHERE emsssesu(+) = sesunuse
   AND (ES.emsscmss = (SELECT MAX(emsscmss) FROM OPEN.elmesesu WHERE emsssesu = sesunuse) OR emsscmss IS NULL)
   AND cossmecc = 4
   AND leempefa = cosspefa
   AND leemsesu(+) = sesunuse
   AND cosssesu(+) = sesunuse
   AND sesunuse = inuSesunuse
   AND (lec.leemfele = (SELECT /*+index(IX_LECTELME05 lectelme)*/ MAX(leemfele)
                          FROM open.lectelme
                         WHERE leemsesu = sesunuse) OR lec.leemfele IS NULL);

  --<<
  -- Cursor que obtiene el ciclo y fecha del periodo de consumo
  -->>
    CURSOR cuCiclFech(inupecscons OPEN.pericose.pecscons%TYPE) IS
    SELECT pecscico,pecsfeci
      FROM OPEN.pericose
      WHERE pecscons = inupecscons;
  --<<
  -- Cursor que obtiene los periodos de consumos anteriores
  -->>
  CURSOR cuPeriodos(inupecscico OPEN.pericose.pecscico%TYPE,
                    idapecsfeci OPEN.pericose.pecsfeci%TYPE) IS
  SELECT pecscons
    FROM OPEN.pericose
   WHERE pecscico = inupecscico
     AND pecsfeci < idapecsfeci
   ORDER BY  PECSCONS  DESC;
  --<<
  -- Cursor que obtiene el consumo por periodo de consumo
  -->>
  CURSOR cuConsumo(inucosspecs NUMBER ) IS
  SELECT Nvl(SUM(cons.cosscoca),0) total
    FROM  open.conssesu cons
   WHERE cons.cosssesu = inuSesunuse
     AND cosspecs = inucosspecs
     AND cons.cossmecc = 4;

  --<<
  -- Curor que obtiene los periodos de consumo para el ciclo
  -->>
  CURSOR cuPeriCicl IS
  SELECT pecscons
    FROM OPEN.pericose
   WHERE pecscico = inuCiclCodi
     AND PECSPROC = 'S'
   ORDER BY pecscons DESC ;

BEGIN
    --<<
    -- Inicializa en ceros para el caso que el servsusc no tenga consumos
    -->>
    vaCosumos := '0,0,0,0,0,0,0';
    FOR rgcuPeriodos IN cuPeriCicl LOOP

          --<<
          -- Valida el consumo que se va a retornar, solo se toman en cuenta los ultimos 6 consumos
          -->>
          IF nuCont = 1 THEN
            --<<
            -- Calcula el consumo para el periodo y lo adiciona a la variable de salida
            -->>
            FOR rgcuConsumo IN cuConsumo(rgcuPeriodos.pecscons) LOOP
              vaCosumos := To_Char(rgcuConsumo.total);
            END LOOP;

          ELSIF nuCont = 2 THEN
            --<<
            -- Calcula el consumo para el periodo y lo adiciona a la variable de salida
            -->>
            FOR rgcuConsumo IN cuConsumo(rgcuPeriodos.pecscons) LOOP
              vaCosumos := vaCosumos||','||To_Char(rgcuConsumo.total);
            END LOOP;
          ELSIF nuCont = 3 THEN
            --<<
            -- Calcula el consumo para el periodo y lo adiciona a la variable de salida
            -->>
            FOR rgcuConsumo IN cuConsumo(rgcuPeriodos.pecscons) LOOP
              vaCosumos := vaCosumos||','||To_Char(rgcuConsumo.total);
            END LOOP;
          ELSIF nuCont = 4 THEN
            --<<
            -- Calcula el consumo para el periodo y lo adiciona a la variable de salida
            -->>
            FOR rgcuConsumo IN cuConsumo(rgcuPeriodos.pecscons) LOOP
              vaCosumos := vaCosumos||','||To_Char(rgcuConsumo.total);
            END LOOP;
          ELSIF nuCont = 5 THEN
            --<<
            -- Calcula el consumo para el periodo y lo adiciona a la variable de salida
            -->>
            FOR rgcuConsumo IN cuConsumo(rgcuPeriodos.pecscons) LOOP
              vaCosumos := vaCosumos||','||To_Char(rgcuConsumo.total);
            END LOOP;
          ELSIF nuCont = 6 THEN
            --<<
            -- Calcula el consumo para el periodo y lo adiciona a la variable de salida
            -->>
            FOR rgcuConsumo IN cuConsumo(rgcuPeriodos.pecscons) LOOP
              vaCosumos := vaCosumos||','||To_Char(rgcuConsumo.total);
            END LOOP;
          ELSIF nuCont = 7 THEN
            --<<
            -- Calcula el consumo para el periodo y lo adiciona a la variable de salida
            -->>
            FOR rgcuConsumo IN cuConsumo(rgcuPeriodos.pecscons) LOOP
              vaCosumos := vaCosumos||','||To_Char(rgcuConsumo.total);
            END LOOP;
          ELSE
            EXIT;
          END IF;
          --<<
          -- Incrementa la variable para garantizar q solo se tome el consumo actual
          -- y los ultimos 6 consumos.
          -->>
          nuCont := nuCont+1;

    END LOOP;

  RETURN vaCosumos;
END LDC_fvaRetConsumos;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FVARETCONSUMOS', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON LDC_FVARETCONSUMOS TO REPORTES;
/
