CREATE OR REPLACE FUNCTION adm_person.fnucuotainicialcom (
    inufinanplan IN plandife.pldicodi%TYPE,
    inususcripc  IN suscripc.susccodi%TYPE,
    inuproductid IN servsusc.sesunuse%TYPE
) RETURN NUMBER IS

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuCuotaInicialCom
  Descripcion    : Trae el valor de la cuota inicial del consumo

  Autor          : GDC
  Fecha          : 20/11/2013

  Parametros                      Descripcion
  ============                 ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  21-02-2024      Paola Acosta        OSF-2180: Migraci�n del esquema OPEN al esquema ADM_PERSON  
  
  25-03-2019      F.Castro            Se modifica para obtener la cuota inicial de todos los
                                      conceptos de consumo segun parametro COD_CONCEPTO_CONSUMO
                                      CA-200-2430
  ******************************************************************/

    nuvalconsumo      NUMBER;
    nuporccuoini      NUMBER;
    nuporcuousuario   NUMBER;
    nureturn          NUMBER;
    csbentrega2002430 CONSTANT VARCHAR2(100) := 'BSS_CAR_FCF_2002430_2';
    nucategoria       NUMBER;
BEGIN

    --dbms_output.put_line('Inicia fnuCuotaInicialCom');
    ut_trace.TRACE('Inicia fnuCuotaInicialCom', 11);
    nureturn := NULL;
    -- valor consumo facturado
    BEGIN
      SELECT SUM(consumo) INTO nuvalconsumo
        FROM (
               SELECT round(to_number(regexp_substr( COLUMN_VALUE, '[^;]+', 1, 1 ))) consumo
                 FROM
                 (SELECT * FROM (
                 SELECT * FROM TABLE(ldc_boutilities.splitstrings(fnu_ldc_getsaldconc(inuproductid,-1,-2), '|'))
                 ) -- -2 obtiene el saldo de todos los conceptos de consumo
                 WHERE COLUMN_VALUE IS NOT NULL)

                 UNION
                SELECT SUM(difesape)
                  FROM diferido
                 WHERE difenuse IN ( SELECT sesunuse FROM servsusc WHERE sesususc = inususcripc AND sesuserv= 7014
                                        AND sesunuse = nvl(inuproductid,sesunuse) )
                   AND difeconc IN (SELECT to_number(COLUMN_VALUE)
                                      FROM TABLE(ldc_boutilities.splitstrings((SELECT P.value_chain
                                                                                      FROM ld_parameter P
                                                                                      WHERE P.parameter_id = 'COD_CONCEPTO_CONSUMO'),','))));
      EXCEPTION WHEN OTHERS THEN
         nureturn := 0;
      END;
      ut_trace.TRACE('nuValConsumo ['||nuvalconsumo||']', 11);

      IF ( nuvalconsumo > 0 ) THEN
        BEGIN
           SELECT  nvl(porc_cuota,0) INTO nuporccuoini
           FROM    ldc_plandife
           WHERE   ldc_plandife.pldicodi = inufinanplan;
        EXCEPTION WHEN OTHERS THEN
           nuporccuoini := 0;
        END;
        ut_trace.TRACE('nuPorcCuoIni ['||nuporccuoini||']', 11);

        -- si es a nivel de producto
        IF ( inuproductid IS NOT NULL ) THEN
          BEGIN
            SELECT porc_cuotaini
              INTO nuporcuousuario
              FROM ldc_usucuoinind
             WHERE contrato = inususcripc
               AND producto = inuproductid ;
          EXCEPTION WHEN OTHERS THEN
            -- si no esta configurado el producto, se valida si esta el contrato
            BEGIN
              SELECT porc_cuotaini
                INTO nuporcuousuario
                FROM ldc_usucuoinind
               WHERE contrato = inususcripc ;
            EXCEPTION WHEN OTHERS THEN
               nuporcuousuario := 0;
            END;
          END;
        ELSE
          -- si es a nivel de contrato
          BEGIN
            SELECT porc_cuotaini
              INTO nuporcuousuario
              FROM ldc_usucuoinind
             WHERE contrato = inususcripc ;
          EXCEPTION WHEN OTHERS THEN
             nuporcuousuario := 0;
          END;
        END IF;
        ut_trace.TRACE('nuPorCuoUsuario ['||nuporcuousuario||']', 11);

        -- si tiene configuraci?n de porcentaje particular, se calcula con ese
        IF ( nuporcuousuario > 0 ) THEN
           nureturn := nuvalconsumo * nuporcuousuario/100;
           ut_trace.TRACE('nuCuoUsuario ['||nureturn||']', 11);
        ELSE
          -- de lo contrario, se calcula con el general
          IF ( nuporccuoini > 0 ) THEN
             nureturn := nuvalconsumo * nuporccuoini/100;
             ut_trace.TRACE('nuCuoIni ['||nureturn||']', 11);
          ELSE
            BEGIN
              SELECT sesucate
                INTO nucategoria
               FROM servsusc
              WHERE sesunuse=inuproductid;
            EXCEPTION WHEN OTHERS THEN
              nucategoria := 0;
            END;
            IF fblaplicaentrega(csbentrega2002430) AND nucategoria >= 3  THEN
              nureturn := nuvalconsumo;
            END IF;
          END IF;
        END IF;
      END IF;

      ut_trace.TRACE('Fin fnuCuotaInicialCom', 11);

      RETURN(nureturn);

END fnucuotainicialcom;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUCUOTAINICIALCOM', 'ADM_PERSON');
END;
/