CREATE OR REPLACE PROCEDURE adm_person.LDC_PRRECAMORA (PEFACODI   NUMBER, --Codigo Peridodo de Facturacion que genero cargos a la - 1
                                                       CICLO      NUMBER, --   Ciclo del periodo que genero cargos a la - 1
                                                       ANNO       NUMBER, --   Año del periodo que genero cargos a la - 1
                                                       MES        NUMBER --   Mes del periodo que genero cargos a la - 1
                                                                        )
IS
    /*******************************************************************************
    Metodo:       LDC_PRRECAMORA
    Descripcion:  Procedimiento obtener los conceptor de RECARGOS POR MORA de loa cargos a la -1.

    Autor:        HORBATH
    Fecha:        05/04/2021
    Cambio        230

    Entrada           Descripcion
    nuPeriodo:        Codigo periodo de Facturacion

    Salida             Descripcion

    Historia de Modificaciones
    FECHA           AUTOR                       DESCRIPCION
    12/07/2021      HORBATH                     CASO 230_2: * Modificar la sentencia del cursor CUCARGOBASE
                                                          para establecer una nueva SUBCONSULTA.
                                                               - Esta subconsulta permita establecer una nueva
                                                                 l???gica y establecer el cargo base, el cual
                                                                 esta asociado el concepto de recargo por mora
                                                                 identificado en el cargo a la -1.
                                                        * Modificar la variable de entrada del cursor CUCARGOBASE
                                                          con relaci???n al recargo por mora proveniente del
                                                          cursor CUCARGOBASE en el parametro CONCEPTO.
    26/04/2024       PACOSTA                    OSF-2598: Se retira el llamado al esquema OPEN (open.)
                                                Se crea el objeto en el esquema adm_person
    09/05/2024       jpinedc                    OSF-2581: Se reemplaza ldc_sendemail por
                                                pkg_Correo.prcEnviaCorreo
                                                * Se implementan últimos estandares
                                                * Se da formato al código
    *******************************************************************************/

    csbMetodo        CONSTANT VARCHAR2(70) :=  'LDC_PRRECAMORA';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;    
    
    --DESVIACION_ESTANDAR
    DE1                     ld_parameter.numeric_value%TYPE;
    --CONSTANTE_NIVEL_CONFIANZA
    CNC1                    ld_parameter.numeric_value%TYPE;
    --LIMITE_ERROR_MUESTRUAL
    LEM1                    ld_parameter.numeric_value%TYPE;
    --Cantidad de suscriptores en un ciclo
    CP1                     ld_parameter.numeric_value%TYPE;
    --Tamaño muestra poblacion de suscriptores
    TM1                     ld_parameter.numeric_value%TYPE;

    sbParametros            VARCHAR2 (100);

    --Periodo de facturacion
    CURSOR cuperifact IS
        SELECT pf.*
          FROM perifact pf
         WHERE     pf.pefacodi = PEFACODI
               AND PF.PEFAANO = ANNO
               AND PF.PEFAMES = MES;

    rfcuperifact            cuperifact%ROWTYPE;

    --Este cursor permitir obtener el total de contratos de un ciclo específico.
    CURSOR CUTOTALCONTRATOSCICLO IS
        SELECT COUNT (SUSCCODI)
          FROM SUSCRIPC
         WHERE SUSCCICL = CICLO;

    --establecer la población de contrato limitada por la variable TM1
    CURSOR CUCONTRATORECMOR (TM1 NUMBER)
    IS
          SELECT s.SUSCCODI
            FROM SUSCRIPC s
           WHERE     (SELECT COUNT (ss.sesususc)
                        FROM SERVSUSC ss,
                             CARGOS  c,
                             CONCEPTO cp,
                             PERIFACT p
                       WHERE     c.CARGNUSE = ss.SESUNUSE
                             AND c.CARGCONC = cp.CONCCODI
                             AND c.CARGPEFA = p.PEFACODI
                             AND ss.SESUSUSC = s.SUSCCODI
                             AND p.PEFACICL = CICLO
                             AND p.PEFAANO = ANNO
                             AND p.PEFAMES = MES
                             AND c.CARGCUCO = -1
                             AND c.CARGCACA = 15
                             AND (  SELECT NVL (cbl.coblconc, 0)
                                      FROM concbali cbl
                                     WHERE     cbl.coblconc IN
                                                   (SELECT conccodi
                                                      FROM concepto
                                                     WHERE concdesc LIKE
                                                               '%RECARGO%')
                                           AND (SELECT COUNT (1)
                                                  FROM concepto co
                                                 WHERE co.conccodi = coblcoba) >
                                               0
                                           AND cbl.coblconc = c.cargconc
                                  GROUP BY coblconc) >
                                 0) >
                     0
                 AND ROWNUM <= TM1
        GROUP BY s.SUSCCODI
        ORDER BY DBMS_RANDOM.VALUE;

    RFCUCONTRATORECMOR      CUCONTRATORECMOR%ROWTYPE;

    CURSOR CUSERVICIOS (CONTRATO NUMBER)
    IS
        SELECT SESUNUSE
          FROM SERVSUSC
         WHERE SESUSUSC = CONTRATO;

    RFCUSERVICIOS           CUSERVICIOS%ROWTYPE;

    CURSOR CUCARGOSSINFACT (INUSESUNUSE NUMBER)
    IS
        SELECT c.*
          FROM cargos c, perifact p
         WHERE     p.PEFACICL = CICLO
               AND p.PEFAANO = ANNO
               AND p.PEFAMES = MES
               AND c.CARGCUCO = -1
               AND c.cargnuse = INUSESUNUSE
               AND c.CARGPEFA = p.PEFACODI
               AND (  SELECT NVL (cbl.coblconc, 0)
                        FROM concbali cbl
                       WHERE     cbl.coblconc IN
                                     (SELECT conccodi
                                        FROM concepto
                                       WHERE concdesc LIKE '%RECARGO%')
                             AND (SELECT COUNT (1)
                                    FROM concepto co
                                   WHERE co.conccodi = coblcoba) > 0
                             AND cbl.coblconc = c.cargconc
                    GROUP BY coblconc) >
                   0;

    RFCUCARGOSSINFACT       CUCARGOSSINFACT%ROWTYPE;

    CURSOR CUCUENTACOBRO (INUCONTRATO NUMBER, IDTFACTFEGE DATE)
    IS
          SELECT CC1.CUCOCODI, f.factfege, cc1.cucofact
            FROM FACTURA f, CUENCOBR cc1, cargos c
           WHERE     F.FACTSUSC = INUCONTRATO
                 AND f.FACTCODI = CC1.CUCOFACT
                 AND F.FACTPROG = 6
                 AND F.FACTFEGE <= IDTFACTFEGE
                 AND NVL (CC1.CUCOSACU, 0) > 0
                 AND CC1.CUCOFEPA IS NULL
                 AND cc1.cucocodi = c.cargcuco
                 AND (  SELECT COUNT (coblcoba)
                          FROM concbali cc
                         WHERE     cc.coblconc IN
                                       (SELECT conccodi
                                          FROM concepto
                                         WHERE concdesc LIKE '%RECARGO%')
                               AND CC.coblcoba = C.CARGCONC
                      GROUP BY cc.coblcoba) >
                     0
        GROUP BY CC1.CUCOCODI, f.factfege, cc1.cucofact
        ORDER BY f.factfege DESC;

    RFCUCUENTACOBRO         CUCUENTACOBRO%ROWTYPE;

    CURSOR CURECARGOSMORA (INUCARGCUCO NUMBER)
    IS
          SELECT c.*
            FROM CARGOS  c,
                 SERVSUSC ss,
                 CONCEPTO cp,
                 PERIFACT p
           WHERE     c.cargcuco = INUCARGCUCO
                 AND c.CARGNUSE = ss.SESUNUSE
                 AND CARGCONC = CP.CONCCODI
                 AND CARGPEFA = P.PEFACODI
                 AND (  SELECT NVL (cbl.coblconc, 0)
                          FROM concbali cbl
                         WHERE     cbl.coblconc IN
                                       (SELECT conccodi
                                          FROM concepto
                                         WHERE concdesc LIKE '%RECARGO%')
                               AND (SELECT COUNT (1)
                                      FROM concepto co
                                     WHERE co.conccodi = coblcoba) > 0
                               AND cbl.coblconc = c.cargconc
                      GROUP BY coblconc) >
                     0
                 AND C.CARGCACA = 15
        ORDER BY c.cargfecr ASC;

    RFCURECARGOSMORA        CURECARGOSMORA%ROWTYPE;

    CURSOR CUCONCBALI (INUREVSRGOMORA NUMBER)
    IS
          SELECT NVL (cbl.coblcoba, 0)
            FROM concbali cbl
           WHERE     cbl.coblconc IN (SELECT conccodi
                                        FROM concepto
                                       WHERE concdesc LIKE '%RECARGO%')
                 AND cbl.coblconc = INUREVSRGOMORA
        GROUP BY cbl.coblcoba;

    --establecer las facturas pagadas dentro del periodo de facturación que genera los cargos a la -1 con el servicio obtenido del
    CURSOR CUCUENTACOBROORIGEN (CONTRATO      NUMBER,
                                IDTFACTFEGE   DATE,
                                IDTPEFAFIMO   DATE,
                                IDTPEFAFFMO   DATE)
    IS
          SELECT CC.*
            FROM FACTURA F, CUENCOBR CC
           WHERE     F.FACTSUSC = CONTRATO
                 AND F.FACTCODI = CC.CUCOFACT
                 AND F.FACTPROG = 6
                 AND F.FACTFEGE < IDTFACTFEGE
                 AND NVL (CC.CUCOSACU, 0) = 0
                 AND CC.CUCOFEPA BETWEEN IDTPEFAFIMO AND IDTPEFAFFMO
        ORDER BY F.FACTFEGE DESC;

    RFCUCUENTACOBROORIGEN   CUCUENTACOBROORIGEN%ROWTYPE;

    --establecer DATA del cargo base generado de factura anterior generada a la que genero el CAARGO POR MORA
    CURSOR CUCARGOBASE (CONTRATO NUMBER, nuFACTURA NUMBER, CONCEPTO NUMBER)
    IS
        SELECT f.factcodi,
               c.cargvalo,
               c.cargfecr,
               c.cargconc,
               c.cargcuco
          FROM factura   f,
               CUENCOBR  CC,
               cargos    c,
               (SELECT TRUNC (F1.FACTFEGE),
                       TRUNC (ADD_MONTHS (F1.FACTFEGE, -1), 'MM')
                           PRIMER_DIA_MES,
                       TRUNC (LAST_DAY (ADD_MONTHS (F1.FACTFEGE, -1)))
                           ULTIMO_DIA_MES
                  FROM FACTURA F1
                 WHERE F1.FACTCODI = nuFACTURA AND F1.FACTPROG = 6) F2
         WHERE     F.FACTSUSC = CONTRATO
               AND f.FACTCODI = CC.CUCOFACT
               AND F.FACTPROG = 6
               AND F.FACTFEGE <= SYSDATE
               AND f.factfege BETWEEN f2.PRIMER_DIA_MES AND f2.ULTIMO_DIA_MES
               AND c.cargcuco = cc.cucocodi
               --Inicio CONCEPTO CASO 230_2
               AND c.cargconc IN
                       (  SELECT NVL (cbl.coblcoba, 0)
                            FROM concbali cbl
                           WHERE     cbl.coblconc IN
                                         (SELECT conccodi
                                            FROM concepto
                                           WHERE concdesc LIKE '%RECARGO%')
                                 AND cbl.coblconc = CONCEPTO
                        GROUP BY cbl.coblcoba)
               --= CONCEPTO
               --Fin CONCEPTO CASO 230_2
               AND c.cargcaca = 51;

    RFCUCARGOBASE           CUCARGOBASE%ROWTYPE;

    ---DATA DE GENERACION EXCEL
    CURSOR CUDCCARGOBASRM IS
          SELECT *
            FROM LDC_CARGOBASRM C
        ORDER BY c.cgbrfcrm, C.CGBRSUSC DESC;

    RFCUDCCARGOBASRM        CUDCCARGOBASRM%ROWTYPE;

    CURSOR CUconftain (FECHACARGO DATE)
    IS
        SELECT (  ROUND (
                      (  (  (  (  POWER (((cf.cotiporc / 100) + 1), (1 / 12))
                                - 1)
                             * 12)
                          / 12)
                       * 100),
                      3)
                / 30)    Interes_Mora
          FROM conftain cf
         WHERE     cf.cotitain = 2
               AND TRUNC (FECHACARGO) BETWEEN cf.cotifein AND cotifefi;

    nuInteresMora           NUMBER;

    nuDiasMora              NUMBER;

    ---FIN GENEACION EXCEL
    nuCiclo                 perifact.pefacicl%TYPE;
    nuPeriodoAux            perifact.pefacodi%TYPE;
    sbEmail                 ld_parameter.value_chain%TYPE
        := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDCCONFMAILGAUDPOST');
    sbruta                  ld_parameter.value_chain%TYPE
        := pkg_BCLD_Parameter.fsbObtieneValorCadena (
               'LDCPARMRUTAPOSTERIORES');
    nutsess                 NUMBER;
    coderror                NUMBER;
    sbmessage               VARCHAR2 (2000);
    sbMensError             VARCHAR2 (2000);

    -- variables para el proceso de generacion de cargos --
    sentence                CLOB;
    NomArchCarg             VARCHAR2 (200);
    NomHoja                 VARCHAR2 (2000);

    -- cursor que obtiene informacion de la tabla cargos y valida que no exista registros en la tabla BITAINCO
    CURSOR CUVALCARGOS (nuPeriodo PROCEJEC.PREJCOPE%TYPE)
    IS
        SELECT 1
          FROM cargos g
         WHERE     g.cargpefa = nuPeriodo
               AND cargprog = 5
               AND NOT EXISTS
                       (SELECT 'X'
                          FROM bitainco b
                         WHERE b.biinpefa = nuPeriodo);

    -- Cursor que obtiene los datos del mes, ano y numero de ciclo de acuerdo al codigo del periodo de facturacion
    CURSOR CUGETMANUMCICLO (nuPeriodoFact PROCEJEC.PREJCOPE%TYPE)
    IS
        SELECT PEFAANO Ano, PEFAMES Mes, PEFACICL Num_Ciclo
          FROM PERIFACT PF, PROCEJEC PCJ
         WHERE     pcj.prejcope = pf.pefacodi
               AND pcj.prejprog = 'FGCA'
               AND pf.pefacodi = nuPeriodoFact;

    -- Cursor que obtiene el numero del periodo que se le haya hecho cierre critica
    CURSOR CUGETCODPERFACT IS
        SELECT COD_PERFACT     nuPeriodo
          FROM LDC_CODPERFACT
         WHERE ESTADPROCESS = 'P' AND TYPEPROCESS = 'FGCA';

    --este cursor separa lo emails
    CURSOR cuEmails IS
        SELECT COLUMN_VALUE
          FROM TABLE (ldc_boutilities.splitstrings (sbEmail, '|'));

    sbRemitente             ld_parameter.value_chain%TYPE
        := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_SMTP_SENDER');

    ----------------------------------------------------------------------------------------
    -- Procedimiento Pragma para actualizar la tabla LDC_CODPERFACT
    ----------------------------------------------------------------------------------------
    PROCEDURE proUpdCodperfact (nuPeriodo   PROCEJEC.PREJCOPE%TYPE,
                                Estado      LDC_CODPERFACT.ESTADPROCESS%TYPE)
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        
        csbMetodo1        CONSTANT VARCHAR2(105) :=  csbMetodo || '.' || 'proUpdCodperfact';
            
    BEGIN
    
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
        
        UPDATE LDC_CODPERFACT
           SET ESTADPROCESS = Estado
         WHERE cod_perfact = nuPeriodo AND TYPEPROCESS = 'FGCA';

        COMMIT;

        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);  
                
    EXCEPTION
        WHEN OTHERS
        THEN
            NULL;
    END;

    ----------------------------------------------------------------------------------------
    -- Fin del procedimiento Pragma
    ----------------------------------------------------------------------------------------

    -- Procedimiento Pragma para validar la inserccion o update de la tabla LDC_VALIDGENAUDPREVIAS
    -----------------------------------------------------------------------------------------------
    PROCEDURE proUpdValidGenaudposterior (nuPeriodo PROCEJEC.PREJCOPE%TYPE)
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        x   NUMBER;
        
        csbMetodo2        CONSTANT VARCHAR2(105) :=  csbMetodo || '.' || 'proUpdValidGenaudposterior';
            
    BEGIN
    
        pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbINICIO);  
        
        SELECT COUNT (*)
          INTO x
          FROM LDC_VALIDGENAUDPREVIAS
         WHERE COD_PEFACODI = nuPeriodo AND PROCESO = 'AUDPOST';

        IF x = 0
        THEN
            INSERT INTO LDC_VALIDGENAUDPREVIAS (cod_pefacodi,
                                                fecha_audprevia,
                                                PROCESO)
                 VALUES (nuPeriodo, SYSDATE, 'AUDPOST');
        ELSE
            UPDATE LDC_VALIDGENAUDPREVIAS
               SET fecha_audprevia = SYSDATE
             WHERE cod_pefacodi = nuperiodo AND PROCESO = 'AUDPOST';
        END IF;

        COMMIT;
        
        pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbFIN);
                  
    EXCEPTION
        WHEN OTHERS
        THEN
            NULL;
    END;

    FUNCTION FnuDiasMora (nuCuencobr NUMBER, nuContrato NUMBER)
        RETURN NUMBER
    IS
        CURSOR cufacturaanterior IS
            SELECT f.factcodi, f.factfege, f.factpefa
              FROM factura  f,
                   (SELECT TRUNC (F1.FACTFEGE),
                           TRUNC (ADD_MONTHS (F1.FACTFEGE, -1))
                               MES_ANTERIOR,
                           TRUNC (ADD_MONTHS (F1.FACTFEGE, -1), 'MM')
                               PRIMER_DIA_MES_ANTERIOR,
                           TRUNC (LAST_DAY (ADD_MONTHS (F1.FACTFEGE, -1)))
                               ULTIMO_DIA_MES_ANTERIOR
                      FROM FACTURA F1
                     WHERE     F1.FACTCODI =
                               (  SELECT cc.cucofact
                                    FROM cuencobr cc, factura f3
                                   WHERE     cc.cucocodi = nuCuencobr
                                         AND cc.cucofact = f3.factcodi
                                         AND NVL (cc.cucosacu, 0) > 0
                                GROUP BY cc.cucofact)
                           AND F1.FACTPROG = 6) F2
             WHERE     F.FACTSUSC = nuContrato
                   AND F.FACTPROG = 6
                   AND F.FACTFEGE <= SYSDATE
                   AND f.factfege BETWEEN f2.PRIMER_DIA_MES_ANTERIOR
                                      AND f2.ULTIMO_DIA_MES_ANTERIOR
                   AND ROWNUM = 1;

        rfcufacturaanterior    cufacturaanterior%ROWTYPE;

        CURSOR cufacturaposterior IS
            SELECT f.factcodi,
                   f.factfege,
                   (SELECT pf.pefafimo
                      FROM perifact pf
                     WHERE pf.pefacodi = f.factpefa)    Periodo_Inicial
              FROM factura  f,
                   (SELECT TRUNC (F1.FACTFEGE),
                           TRUNC (ADD_MONTHS (F1.FACTFEGE, 1))
                               MES_POSTERIOR,
                           TRUNC (ADD_MONTHS (F1.FACTFEGE, 1), 'MM')
                               PRIMER_DIA_MES_POSTERIOR,
                           TRUNC (LAST_DAY (ADD_MONTHS (F1.FACTFEGE, 1)))
                               ULTIMO_DIA_MES_POSTERIOR
                      FROM FACTURA F1
                     WHERE     F1.FACTCODI =
                               (  SELECT cc.cucofact
                                    FROM cuencobr cc, factura f3
                                   WHERE     cc.cucocodi = nuCuencobr
                                         AND cc.cucofact = f3.factcodi
                                         AND NVL (cc.cucosacu, 0) > 0
                                GROUP BY cc.cucofact)
                           AND F1.FACTPROG = 6) F2
             WHERE     F.FACTSUSC = NUCONTRATO
                   AND F.FACTPROG = 6
                   AND F.FACTFEGE <= SYSDATE
                   AND f.factfege BETWEEN f2.PRIMER_DIA_MES_POSTERIOR
                                      AND f2.ULTIMO_DIA_MES_POSTERIOR
                   AND ROWNUM = 1;

        rfcufacturaposterior   cufacturaposterior%ROWTYPE;

        CURSOR cufacturaanteriorpaga IS
            SELECT (cc.cucofepa - cc.cucofeve)     DiasMora
              FROM cuencobr cc
             WHERE cc.cucocodi = nuCuencobr;

        dtFechaIncialPeriodo   DATE;

        csbMetodo3        CONSTANT VARCHAR2(105) :=  csbMetodo || '.' || 'FnuDiasMora';
            
    BEGIN
    
        pkg_traza.trace(csbMetodo3, csbNivelTraza, pkg_traza.csbINICIO);
                 
        --Fecha generacion de factura anterior con deuda
        OPEN cufacturaanterior;

        FETCH cufacturaanterior INTO rfcufacturaanterior;

        IF cufacturaanterior%FOUND
        THEN
            IF rfcufacturaanterior.factfege IS NOT NULL
            THEN
                --Fecha periodo inicial de proxima factura
                OPEN cufacturaposterior;

                FETCH cufacturaposterior INTO rfcufacturaposterior;

                IF cufacturaposterior%FOUND
                THEN
                    pkg_Traza.Trace (
                           'rfcufacturaposterior.factfege['
                        || rfcufacturaposterior.factfege
                        || ']');

                    IF rfcufacturaposterior.factfege IS NOT NULL
                    THEN
                        nuDiasMora :=
                            ROUND (
                                  TRUNC (rfcufacturaposterior.factfege)
                                - TRUNC (rfcufacturaanterior.factfege));
                    ELSE
                        BEGIN
                            SELECT pf.pefafimo
                              INTO dtFechaIncialPeriodo
                              FROM perifact pf
                             WHERE     pf.pefacodi = PEFACODI
                                   AND pf.pefaano = ANNO
                                   AND pf.pefames = mes
                                   AND pf.pefacicl = CICLO;

                            nuDiasMora :=
                                ROUND (
                                      TRUNC (dtFechaIncialPeriodo)
                                    - TRUNC (rfcufacturaanterior.factfege));
                        EXCEPTION
                            WHEN OTHERS
                            THEN
                                nuDiasMora := 0;
                        END;
                    END IF;
                ELSE
                    BEGIN
                        SELECT pf.pefafimo
                          INTO dtFechaIncialPeriodo
                          FROM perifact pf
                         WHERE     pf.pefacodi = PEFACODI
                               AND pf.pefaano = ANNO
                               AND pf.pefames = mes
                               AND pf.pefacicl = CICLO;

                        nuDiasMora :=
                            ROUND (
                                  TRUNC (dtFechaIncialPeriodo)
                                - TRUNC (rfcufacturaanterior.factfege));
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            nuDiasMora := 0;
                    END;
                END IF;

                CLOSE cufacturaposterior;
            ---------------------------------------------
            END IF;
        ELSE
            --Factura anterior paga despues de la fecha de vencimiento
            pkg_Traza.Trace (
                   'Cuenta de cobro['
                || nuCuencobr
                || '] - Contrato['
                || nuContrato
                || ']');

            OPEN cufacturaanteriorpaga;

            FETCH cufacturaanteriorpaga INTO nuDiasMora;

            CLOSE cufacturaanteriorpaga;
        --nuDiasMora := -1;
        END IF;

        CLOSE cufacturaanterior;

        ----------------------------------------

        pkg_traza.trace(csbMetodo3, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN nuDiasMora;
    END;
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    --DESVIACION_ESTANDAR
    DE1 := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DESVIACION_ESTANDAR');
    pkg_Traza.Trace ('DESVIACION_ESTANDAR[' || DE1 || ']');

    --CONSTANTE_NIVEL_CONFIANZA
    CNC1 := pkg_BCLD_Parameter.fnuObtieneValorNumerico ( 'CONSTANTE_NIVEL_CONFIANZA');
    pkg_Traza.Trace ('CONSTANTE_NIVEL_CONFIANZA[' || CNC1 || ']');

    --LIMITE_ERROR_MUESTRUAL
    LEM1 := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('LIMITE_ERROR_MUESTRAL');
    pkg_Traza.Trace ('LIMITE_ERROR_MUESTRUAL[' || LEM1 || ']');

    IF DE1 IS NULL OR CNC1 IS NULL OR LEM1 IS NULL
    THEN
        IF DE1 IS NULL
        THEN
            sbParametros := sbParametros || ' DESVIACION_ESTANDAR ';
        END IF;

        IF CNC1 IS NULL
        THEN
            sbParametros := sbParametros || ' CONSTANTE_NIVEL_CONFIANZA ';
        END IF;

        IF LEM1 IS NULL
        THEN
            sbParametros := sbParametros || ' LIMITE_ERROR_MUESTRAL ';
        END IF;

        -- aqui se debe llamar al procedimiento que envia el mensaje al correo --
        IF sbEmail IS NOT NULL
        THEN
            FOR item IN cuEmails
            LOOP
                pkg_Correo.prcEnviaCorreo (
                    isbRemitente       => sbRemitente,
                    isbDestinatarios   => TRIM (item.COLUMN_VALUE),
                    isbAsunto          =>
                        'Proceso de Cargos Mora a la -1 Sin Parametros Configurados',
                    isbMensaje         =>
                           'No existe valor en los siguientes parametros ['
                        || sbParametros
                        || ']');
            END LOOP;
        END IF;
    ELSE
        DELETE FROM ldc_cargobasrm;

        COMMIT;

        OPEN cuperifact;

        FETCH cuperifact INTO rfcuperifact;

        CLOSE cuperifact;

        OPEN CUTOTALCONTRATOSCICLO;

        FETCH CUTOTALCONTRATOSCICLO INTO CP1;

        CLOSE CUTOTALCONTRATOSCICLO;

        pkg_Traza.Trace ('Cantidad Poblacion[' || CP1 || ']');

        TM1 :=
            ROUND (
                  (CP1 * POWER (DE1, 2) * POWER (CNC1, 2))
                / (  ((CP1 - 1) * POWER (LEM1, 2))
                   + (POWER (DE1, 2) * POWER (CNC1, 2))),
                0);
        pkg_Traza.Trace ('Tamaño Muestra[' || TM1 || ']');

        FOR RFCUCONTRATORECMOR IN CUCONTRATORECMOR (TM1)
        LOOP
            pkg_Traza.Trace (
                'Contrato[' || RFCUCONTRATORECMOR.SUSCCODI || ']');

            FOR RFCUSERVICIOS IN CUSERVICIOS (RFCUCONTRATORECMOR.SUSCCODI)
            LOOP
                --BUSCAR CARGOS A LA -1
                pkg_Traza.Trace (
                    '*****Servicio[' || RFCUSERVICIOS.SESUNUSE || ']');

                FOR RFCUCARGOSSINFACT
                    IN CUCARGOSSINFACT (RFCUSERVICIOS.SESUNUSE)
                LOOP
                    INSERT INTO ldc_cargobasrm (cgbrsusc,        --o  Contrato
                                                cgbrcaba, --o  Código del cargo BASE
                                                cgbrvacb, --o  Valor del cargo BASE
                                                cgbrfccb, --o  Fecha Creación cargo BASE
                                                cgbrcarm, --o  Código del RECARGO POR MORA
                                                cgbrvarm, --o  Valor del RECARGO POR MORA
                                                cgbrfcrm, --o  Fecha Creación RECARGO POR MORA
                                                cgbrcuco)
                         VALUES (RFCUCONTRATORECMOR.SUSCCODI,
                                 NULL,
                                 NULL,
                                 NULL,
                                 RFCUCARGOSSINFACT.CARGCONC,
                                 RFCUCARGOSSINFACT.CARGVALO,
                                 RFCUCARGOSSINFACT.CARGFECR,
                                 NULL);

                    COMMIT;
                END LOOP;
            END LOOP;

            pkg_Traza.Trace (
                'Contrato[' || RFCUCONTRATORECMOR.SUSCCODI || ']');
            pkg_Traza.Trace ('---------------CARGO BASE 1');

            FOR RFCUCUENTACOBRO
                IN CUCUENTACOBRO (RFCUCONTRATORECMOR.SUSCCODI, SYSDATE)
            LOOP
                pkg_Traza.Trace (
                       '**********Cuenta Cobro['
                    || RFCUCUENTACOBRO.CUCOCODI
                    || '] - FACTURA['
                    || RFCUCUENTACOBRO.CUCOFACT
                    || '] - FECHA GENREACION['
                    || RFCUCUENTACOBRO.FACTFEGE
                    || ']');

                FOR RFCURECARGOSMORA
                    IN CURECARGOSMORA (RFCUCUENTACOBRO.CUCOCODI)
                LOOP
                    OPEN CUCARGOBASE (RFCUCONTRATORECMOR.SUSCCODI,
                                      RFCUCUENTACOBRO.CUCOFACT,
                                      RFCURECARGOSMORA.CARGCONC);

                    FETCH CUCARGOBASE INTO RFCUCARGOBASE;

                    IF CUCARGOBASE%FOUND
                    THEN
                        IF RFCUCARGOBASE.CARGVALO IS NOT NULL
                        THEN
                            pkg_Traza.Trace (
                                   '***************Concepto RECARGO MORA['
                                || RFCURECARGOSMORA.CARGCONC
                                || ']');

                            INSERT INTO ldc_cargobasrm (cgbrsusc, --o  Ccontrato
                                                        cgbrcaba, --o  Código del cargo BASE
                                                        cgbrvacb, --o  Valor del cargo BASE
                                                        cgbrfccb, --o  Fecha Creación cargo BASE
                                                        cgbrcarm, --o  Código del RECARGO POR MORA
                                                        cgbrvarm, --o  Valor del RECARGO POR MORA
                                                        cgbrfcrm, --o  Fecha Creación RECARGO POR MORA
                                                        cgbrcuco) --o  Fecha Creación RECARGO POR MORA)
                                 VALUES (RFCUCONTRATORECMOR.SUSCCODI,
                                         RFCUCARGOBASE.CARGCONC,
                                         RFCUCARGOBASE.CARGVALO,
                                         RFCUCARGOBASE.CARGFECR,
                                         RFCURECARGOSMORA.CARGCONC,
                                         RFCURECARGOSMORA.CARGVALO,
                                         RFCURECARGOSMORA.CARGFECR,
                                         RFCUCARGOBASE.CARGCUCO);

                            COMMIT;
                        END IF;
                    END IF;

                    CLOSE CUCARGOBASE;
                END LOOP;
            END LOOP;

            pkg_Traza.Trace (
                '----------------------------------------------------------------');

            pkg_Traza.Trace ('---------------CARGO BASE 2');
            pkg_Traza.Trace (
                   '---------------RFCUCONTRATORECMOR.SUSCCODI['
                || RFCUCONTRATORECMOR.SUSCCODI
                || '],SYSDATE['
                || SYSDATE
                || '],rfcuperifact.pefafimo['
                || rfcuperifact.pefafimo
                || '],rfcuperifact.pefaffmo['
                || rfcuperifact.pefaffmo
                || ']');

            FOR RFCUCUENTACOBROORIGEN
                IN CUCUENTACOBROORIGEN (RFCUCONTRATORECMOR.SUSCCODI,
                                        SYSDATE,
                                        rfcuperifact.pefafimo,
                                        rfcuperifact.pefaffmo)
            LOOP
                FOR RFCURECARGOSMORA
                    IN CURECARGOSMORA (RFCUCUENTACOBROORIGEN.CUCOCODI)
                LOOP
                    pkg_Traza.Trace (
                           '********************PAGO Concepto RECARGO MORA['
                        || RFCURECARGOSMORA.CARGCONC
                        || ']');

                    OPEN CUCARGOBASE (RFCUCONTRATORECMOR.SUSCCODI,
                                      RFCUCUENTACOBROORIGEN.CUCOFACT,
                                      RFCURECARGOSMORA.CARGCONC); --CASO 230_2

                    --NUCARGOBASE);
                    FETCH CUCARGOBASE INTO RFCUCARGOBASE;

                    IF CUCARGOBASE%FOUND
                    THEN
                        IF RFCUCARGOBASE.CARGVALO IS NOT NULL
                        THEN
                            pkg_Traza.Trace (
                                   '***************Concepto RECARGO MORA['
                                || RFCURECARGOSMORA.CARGCONC
                                || ']');

                            INSERT INTO ldc_cargobasrm (cgbrsusc, --o  Ccontrato
                                                        cgbrcaba, --o  Código del cargo BASE
                                                        cgbrvacb, --o  Valor del cargo BASE
                                                        cgbrfccb, --o  Fecha Creación cargo BASE
                                                        cgbrcarm, --o  Código del RECARGO POR MORA
                                                        cgbrvarm, --o  Valor del RECARGO POR MORA
                                                        cgbrfcrm, --o  Fecha Creación RECARGO POR MORA)
                                                        cgbrcuco)
                                 VALUES (RFCUCONTRATORECMOR.SUSCCODI,
                                         RFCUCARGOBASE.CARGCONC,
                                         RFCUCARGOBASE.CARGVALO,
                                         RFCUCARGOBASE.CARGFECR,
                                         RFCURECARGOSMORA.CARGCONC,
                                         RFCURECARGOSMORA.CARGVALO,
                                         RFCURECARGOSMORA.CARGFECR,
                                         RFCUCUENTACOBROORIGEN.CUCOCODI);

                            COMMIT;
                        END IF;
                    END IF;

                    CLOSE CUCARGOBASE;

                    COMMIT;
                END LOOP;

                pkg_Traza.Trace (
                    '----------------------------------------------------------------');
            END LOOP;
        END LOOP;

        ---DATA DE GENERACION EXCEL

        DELETE FROM LDC_DATACARGOS;

        COMMIT;

        FOR RFCUDCCARGOBASRM IN CUDCCARGOBASRM
        LOOP
            OPEN CUconftain (RFCUDCCARGOBASRM.CGBRFCRM);

            FETCH CUconftain INTO nuInteresMora;

            CLOSE CUconftain;

            nuDiasMora :=
                ABS (
                    FnuDiasMora (RFCUDCCARGOBASRM.CGBRCUCO,
                                 RFCUDCCARGOBASRM.CGBRSUSC));

            INSERT INTO LDC_DATACARGOS (DACACONT,
                                        DACACICL,
                                        DACACABA,
                                        DACAVABA,
                                        DACATASA,
                                        DACADIMO,
                                        DACAPERI,
                                        DACAVARM)
                 VALUES (RFCUDCCARGOBASRM.CGBRSUSC,
                         CICLO,
                         RFCUDCCARGOBASRM.CGBRCABA,
                         RFCUDCCARGOBASRM.CGBRVACB,
                         nuInteresMora,
                         nuDiasMora,
                         PEFACODI,
                         RFCUDCCARGOBASRM.CGBRVARM);

            COMMIT;
        --null;
        END LOOP;

        ----------------------------------------------------------------------------------------
        -- Inicia proceso de CARGOS A LA -1
        ----------------------------------------------------------------------------------------

        --------------   Bloque de sentencias CARGOS A LA -1    -------------

        --- Cargos a la -1: --
        sentence := 'select dacacont Contrato,
                      dacacicl Ciclo,
                      dacacaba Cargo,
                      dacavaba ValorBase,
                      dacatasa TasaAplicada,
                      dacadimo DiasDeMora,
                      dacaperi Periodo,
                      dacavarm ValorDeLaMoraCalculada
                 from ldc_datacargos
             order by Contrato,dacacaba desc';

        ------------   Finaliza Bloque de sentencias CARGOS A LA -1    ---------

        NomArchCarg := 'CARGO_BASE_VALOR_MORA_' || PEFACODI;

        -- se establece el nombre de la hoja de excel
        NomHoja := 'Cargos a la -1 con Cargo Mora';

        --- aqui se debe llamar al procedimiento que genera el archivo en excel--
        LDC_EXPORT_REPORT_EXCEL (sbruta,
                                 NomArchCarg,
                                 NomHoja,
                                 sentence);

        -- aqui se debe llamar al procedimiento que envia el mensaje al correo --
        IF sbEmail IS NOT NULL
        THEN
            FOR item IN cuEmails
            LOOP
                pkg_Correo.prcEnviaCorreo (
                    isbRemitente       => sbRemitente,
                    isbDestinatarios   => TRIM (item.COLUMN_VALUE),
                    isbAsunto          =>
                        'Proceso de Cargos Mora a la -1 Hecho',
                    isbMensaje         =>
                           'Se realizó el reporte de Cargos Mora a la -1 de forma correcta con el nombre: '
                        || NomArchCarg
                        || '.xls, esta ubicado en la ruta: '
                        || sbruta
                        || '');
            END LOOP;
        END IF;
    END IF;                                  --Parametros sin DATA pra muestra
----------------------- Finaliza proceso de cargos a la -1 con Cargos de Mora ---------------------------

---FIN GENEACION EXCEL

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
    
EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR
    THEN
        pkg_Error.getError (coderror, sbmessage);
        ldc_proactualizaestaprog (nutsess,
                                  sbmessage,
                                  'LDC_PRRECAMORA-' || nuCiclo,
                                  'Termino con error');
        proUpdCodperfact (nuPeriodoAux, 'P'); -- se actualiza el periodo que presento el error
        pkg_Traza.Trace (
            'coderror[' || coderror || '] - sbmessage[' || sbmessage || ']');
        RAISE pkg_Error.CONTROLLED_ERROR;
    WHEN OTHERS
    THEN
        pkg_Error.setError;
        pkg_Error.getError (coderror, sbmessage);
        sbMensError :=
               sbmessage
            || 'Error No Controlado, '
            || DBMS_UTILITY.format_error_backtrace;
        Errors.SETMESSAGE (sbMensError);
        ldc_proactualizaestaprog (
            nutsess,
            sbMensError,
            'LDC_PRRECAMORA-' || nuCiclo,
            'Termino con error: ' || DBMS_UTILITY.format_error_backtrace);
        proUpdCodperfact (nuPeriodoAux, 'P'); -- se actualiza el periodo que presento el error
        pkg_Traza.Trace (
            'coderror[' || coderror || '] - sbmessage[' || sbmessage || ']');
        ROLLBACK;
        RAISE pkg_Error.CONTROLLED_ERROR;
END LDC_PRRECAMORA;
/

PROMPT Otorgando permisos de ejecucion a LDC_PRRECAMORA
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PRRECAMORA', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_PRRECAMORA para reportes
GRANT EXECUTE ON adm_person.LDC_PRRECAMORA TO rexereportes;
/

