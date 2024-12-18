CREATE OR REPLACE PROCEDURE LDC_PRGEAUDPRE
IS
    /*******************************************************************************
   Metodo:       LDC_PRGEAUDPRE
   Descripcion:  Procedimiento que tiene la misma logica que el procedimiento LDCFAAC
                 del PB con el mismo nombre, el cual se encarga del proceso de generacion
                 de auditorias previas, sin embargo los datos de MES, AÃ‘O, NUMERO DE CICLO
                 Y EMAIL, se obtienen de una forma distinta al PB, por medio de la tabla
                 "PROCEJEC"

   Autor:        Olsoftware/Miguel Ballesteros
   Fecha:        23/08/2019

   Entrada        Descripcion
   nuPeriodo:     Codigo periodo de Facturacion

   Salida             Descripcion

   Historia de Modificaciones
   FECHA        AUTOR                       DESCRIPCION
   18/11/2020   HORBATH                    CA 461 se adiciona logica para agrupar archivos de excel
   29/04/2024   jpinedc                    OSF-2581: Se cambia ldc_sendemail por
                                            pkg_Correo.prcEnviaCorreo
  *******************************************************************************/

    -- Cursor que obtiene los datos del mes, Ano y numero de ciclo de acuerdo al codigo del periodo de facturacion
    CURSOR CUGETMANUMCICLO (nuPeriodoFact PROCEJEC.PREJCOPE%TYPE)
    IS
        SELECT PEFAANO Ano, PEFAMES Mes, PEFACICL Num_Ciclo
          FROM PERIFACT PF, PROCEJEC PCJ
         WHERE     pcj.prejcope = pf.pefacodi
               AND pcj.prejprog = 'FCRI'
               AND pf.pefacodi = nuPeriodoFact;

    -- Cursor que obtiene el numero del periodo que se le haya hecho cierre critica
    CURSOR CUGETCODPERFACT IS
        SELECT PE.ROWID        ID_REG,
               COD_PERFACT     nuPeriodo,
               PEFAANO         Ano,
               PEFAMES         Mes,
               PEFACICL        Num_Ciclo
          FROM LDC_CODPERFACT PE, PERIFACT PF
         WHERE     ESTADPROCESS = 'P'
               AND TYPEPROCESS = 'FCRI'
               AND pf.pefacodi = COD_PERFACT;

    --INICIO CA 461
    TYPE tblPeriProc IS TABLE OF CUGETCODPERFACT%ROWTYPE
        INDEX BY VARCHAR2 (100);

    vtblPeriProc      tblPeriProc;
    sbIndexPeri       VARCHAR2 (100);
    sbEmailNoti       VARCHAR2 (4000)
        := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_EMAILNOLE');
        
    sbCiclProc        VARCHAR2 (4000);
    sbCiclProcAtla    VARCHAR2 (4000);
    sbCiclProcMagd    VARCHAR2 (4000);
    sbCiclProcCesar   VARCHAR2 (4000);
    nuDepart          NUMBER;

    sbAgrupDepa       VARCHAR2 (2)
        := pkg_BCLD_Parameter.fsbObtieneValorCadena ('AGRUPAAUDPREVDPTO');
    nuValida          NUMBER;

    CURSOR cugetdepartamento IS
        SELECT DISTINCT d.geograp_location_id depa, d.description
          FROM ge_geogra_location d, LDC_CICLDEPA C, LDC_TEMPPPAUD P
         WHERE     geog_loca_area_type = 2
               AND geograp_location_id = C.CICLDEPA
               AND C.CICLCODI = P.CICLO;

    CURSOR cuGetDepa (nuciclo NUMBER)
    IS
        SELECT CICLDEPA
          FROM LDC_CICLDEPA
         WHERE CICLCODI = nuCiclo;

    nuPeriodoAux      perifact.pefacodi%TYPE;
    sbEmail           VARCHAR2 (4000);
    sbruta            VARCHAR2 (200);
    sbNomArch         VARCHAR2 (200);
    sbNomHoja         VARCHAR2 (4000);
    SBSENTENCIA       CLOB;
    sb_subject        VARCHAR2 (200) := 'Proceso de Auditorias Previas Hecho';
    sb_text_msg       VARCHAR2 (200)
        := 'Se realiza el proceso de auditorias previas con el codigo del periodo de facturacion tramitado';
    nuparano          NUMBER;
    nuparmes          NUMBER;
    nutsess           NUMBER;
    sbparuser         VARCHAR2 (50);
    coderror          NUMBER;
    sbmessage         VARCHAR2 (2000);
    sbMensError       VARCHAR2 (2000);


    sbsentc1          CLOB;
    sbsentc2          CLOB;
    sbsentc3          CLOB;
    sbsentc4          CLOB;
    sbsentc5          CLOB;
    sbsentc6          CLOB;
    sbsentc7          CLOB;
    sbsentc8          CLOB;
    sbsentc9          CLOB;

    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');

    --este cursor separa lo emails
    CURSOR cuEmails (sbEmail VARCHAR2, sbseparador VARCHAR2)
    IS
        SELECT COLUMN_VALUE
          FROM TABLE (ldc_boutilities.splitstrings (sbEmail, sbseparador));


    ----------------------------------------------------------------------------------------
    -- Procedimiento Pragma para actualizar la tabla LDC_CODPERFACT
    ----------------------------------------------------------------------------------------
    PROCEDURE proUpdCodperfact (nuPeriodo   PROCEJEC.PREJCOPE%TYPE,
                                Estado      LDC_CODPERFACT.ESTADPROCESS%TYPE)
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        UPDATE LDC_CODPERFACT
           SET ESTADPROCESS = Estado
         WHERE cod_perfact = nuPeriodo AND TYPEPROCESS = 'FCRI';

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            NULL;
    END;

    ----------------------------------------------------------------------------------------
    -- Fin del procedimiento Pragma
    ----------------------------------------------------------------------------------------


    -----------------------------------------------------------------------------------------------
    -- Procedimiento Pragma para validar la inserccion o update de la tabla LDC_VALIDGENAUDPREVIAS
    -----------------------------------------------------------------------------------------------
    PROCEDURE proUpdValidGenaudprevias (nuPeriodo PROCEJEC.PREJCOPE%TYPE)
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        x   NUMBER;
    BEGIN
        SELECT COUNT (*)
          INTO x
          FROM LDC_VALIDGENAUDPREVIAS
         WHERE COD_PEFACODI = nuPeriodo AND PROCESO = 'AUDPREV';

        IF x = 0
        THEN
            INSERT INTO LDC_VALIDGENAUDPREVIAS (cod_pefacodi,
                                                fecha_audprevia,
                                                PROCESO)
                 VALUES (nuPeriodo, SYSDATE, 'AUDPREV');
        ELSE
            UPDATE LDC_VALIDGENAUDPREVIAS
               SET fecha_audprevia = SYSDATE
             WHERE cod_pefacodi = nuperiodo AND PROCESO = 'AUDPREV';
        END IF;

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            NULL;
    END;

    ----------------------------------------------------------------------------------------
    -- Fin del procedimiento Pragma
    ----------------------------------------------------------------------------------------
    --INICIO CA 461
    FUNCTION fnuValidaAudiPrev (inuPeriodo   IN NUMBER,
                                inuano       IN NUMBER,
                                inuMes       IN NUMBER,
                                inuCiclo     IN NUMBER)
        RETURN NUMBER
    IS
        /*******************************************************************************
          Metodo:       fnuValidaAudiPrev
          Descripcion:  Proceso que valida si hubo problema de auditorias previas
          Autor:        Horbath
          Fecha:        18/11/2020
          Ticket:        461

          Entrada        Descripcion
            nuPeriodo:     Codigo periodo de Facturacion
            inuano         a??o
            inuMes         mes
            inuCiclo       ciclo

          Salida             Descripcion

          Historia de Modificaciones
          FECHA        AUTOR                       DESCRIPCION
         *******************************************************************************/

        sbdatos    VARCHAR2 (1);

        --se valida periodo
        CURSOR cugetPeriodo IS
            SELECT 'x'
              FROM LDC_VERIPRES
             WHERE     VEPRANO = inuano
                   AND VEPRMES = inuMes
                   AND VEPRCICL = inuCiclo
            UNION ALL
            SELECT 'x'
              FROM LDC_AJUSCOPR
             WHERE     AJCPANO = inuano
                   AND AJCPMES = inuMes
                   AND AJCPCICL = inuCiclo
            UNION ALL
            SELECT 'x'
              FROM LDC_LECTMENO
             WHERE     LEMEANO = inuano
                   AND LEMEMES = inuMes
                   AND LEMECICL = inuCiclo
            UNION ALL
            SELECT 'x'
              FROM LDC_CONSALTO
             WHERE     COALANO = inuano
                   AND COALMES = inuMes
                   AND COALCICL = inuCiclo
            UNION ALL
            SELECT 'x'
              FROM LDC_VAPLANERR
             WHERE     PLERANO = inuano
                   AND PLERMES = inuMes
                   AND PLERCICL = inuCiclo
            UNION ALL
            SELECT 'x'
              FROM LDC_PRNOFGCA
             WHERE ANO = inuano AND MES = inuMes AND CICLO = inuCiclo
            UNION ALL
            SELECT 'x'
              FROM LDC_CONSNOFA
             WHERE ANO = inuano AND MES = inuMes AND CICLO = inuCiclo
            UNION ALL
            SELECT 'x'
              FROM LDC_ORPECAME
             WHERE ANO = inuano AND MES = inuMes AND CICLO = inuCiclo;

        CURSOR CUEXISTEPER IS
            SELECT 'X'
              FROM LDC_PERIAUPR
             WHERE PEAPPEFA = inuPeriodo AND PEAPESTA = 'P';
    BEGIN
        OPEN cugetPeriodo;

        FETCH cugetPeriodo INTO sbdatos;

        IF cugetPeriodo%FOUND
        THEN
            OPEN CUEXISTEPER;

            FETCH CUEXISTEPER INTO sbdatos;

            IF CUEXISTEPER%FOUND
            THEN
                UPDATE LDC_PERIAUPR
                   SET PEAPFERE = SYSDATE
                 WHERE PEAPPEFA = inuPeriodo;
            ELSE
                INSERT INTO LDC_PERIAUPR (PEAPPEFA,
                                          PEAPCICL,
                                          PEAPESTA,
                                          PEAPFERE)
                     VALUES (inuPeriodo,
                             inuCiclo,
                             'P',
                             SYSDATE);
            END IF;

            CLOSE CUEXISTEPER;

            COMMIT;
            RETURN 1;
        END IF;

        CLOSE cugetPeriodo;

        RETURN 0;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END fnuValidaAudiPrev;
--FIN CA 461



BEGIN
    sbruta := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDCPARMRUTAPREVIAS');
    sbEmail :=
        pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDCCONFMAILGAUDPRE');


    nuparano := TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY'));
    nuparmes := TO_NUMBER (TO_CHAR (SYSDATE, 'MM'));
    nutsess := USERENV ('SESSIONID');
    sbparuser := USER;

    -- se llama al procedimiento ldc_proinsertaestaprog que actualiza el progreso en estaprog
    ldc_proinsertaestaprog (nuparano,
                            nuparmes,
                            'LDC_PRGEAUDPRE',
                            'En ejecucion',
                            nutsess,
                            sbparuser);

    vtblPeriProc.DELETE;
    sbCiclProc := NULL;

    DELETE FROM LDC_TEMPPPAUD;

    COMMIT;

    FOR reg IN CUGETCODPERFACT
    LOOP
        --se coloca registro en procesando
        UPDATE LDC_CODPERFACT
           SET ESTADPROCESS = 'X'
         WHERE ROWID = reg.ID_REG;

        INSERT INTO LDC_TEMPPPAUD (PERIODO,
                                   CICLO,
                                   ANIO,
                                   MES)
             VALUES (reg.nuPeriodo,
                     reg.Num_Ciclo,
                     reg.Ano,
                     reg.Mes);

        COMMIT;

        IF sbAgrupDepa = 'N'
        THEN
            IF sbCiclProc IS NULL
            THEN
                sbCiclProc := reg.Num_Ciclo;
            ELSE
                sbCiclProc := sbCiclProc || ',' || reg.Num_Ciclo;
            END IF;
        ELSE
            IF cuGetDepa%ISOPEN
            THEN
                CLOSE cuGetDepa;
            END IF;

            OPEN cuGetDepa (reg.Num_Ciclo);

            FETCH cuGetDepa INTO nuDepart;

            CLOSE cuGetDepa;

            IF nuDepart = 3
            THEN
                IF sbCiclProcAtla IS NULL
                THEN
                    sbCiclProcAtla := reg.Num_Ciclo;
                ELSE
                    sbCiclProcAtla := sbCiclProcAtla || ',' || reg.Num_Ciclo;
                END IF;
            ELSIF nuDepart = 4
            THEN
                IF sbCiclProcMagd IS NULL
                THEN
                    sbCiclProcMagd := reg.Num_Ciclo;
                ELSE
                    sbCiclProcMagd := sbCiclProcMagd || ',' || reg.Num_Ciclo;
                END IF;
            ELSE
                IF sbCiclProcCesar IS NULL
                THEN
                    sbCiclProcCesar := reg.Num_Ciclo;
                ELSE
                    sbCiclProcCesar :=
                        sbCiclProcCesar || ',' || reg.Num_Ciclo;
                END IF;
            END IF;
        END IF;

        IF NOT vtblPeriProc.EXISTS (reg.nuPeriodo)
        THEN
            vtblPeriProc (reg.nuPeriodo).ID_REG := reg.ID_REG;
            vtblPeriProc (reg.nuPeriodo).nuPeriodo := reg.nuPeriodo;
            vtblPeriProc (reg.nuPeriodo).Ano := reg.Ano;
            vtblPeriProc (reg.nuPeriodo).Mes := reg.Mes;
            vtblPeriProc (reg.nuPeriodo).Num_Ciclo := reg.Num_Ciclo;
        END IF;
    END LOOP;

    IF vtblPeriProc.COUNT > 0
    THEN
        --se genera proceso de auditoria previas
        sbIndexPeri := vtblPeriProc.FIRST;

        LOOP
            EXIT WHEN sbIndexPeri IS NULL;
            -- se llama al procedimiento que actualiza el estado del codigo del periodo
            proUpdCodperfact (sbIndexPeri, 'E');
            nuValida := 0;

            -- se establece el codigo del periodo en una variable para ser usado en el exception
            nuPeriodoAux := vtblPeriProc (sbIndexPeri).nuPeriodo;

            BEGIN
                -- se llama al paquete en donde esta toda la logica de generacion de auditorias previas --
                LDC_PKFAAC.proGeneraAuditorias (
                    vtblPeriProc (sbIndexPeri).Ano,
                    vtblPeriProc (sbIndexPeri).Mes,
                    vtblPeriProc (sbIndexPeri).Num_Ciclo,
                    NULL);

                proUpdCodperfact (vtblPeriProc (sbIndexPeri).nuPeriodo, 'T');
                --se valida periodo si tuvo problemas de auditorias
                nuValida :=
                    fnuValidaAudiPrev (vtblPeriProc (sbIndexPeri).nuPeriodo,
                                       vtblPeriProc (sbIndexPeri).Ano,
                                       vtblPeriProc (sbIndexPeri).Mes,
                                       vtblPeriProc (sbIndexPeri).Num_Ciclo);
            EXCEPTION
                WHEN pkg_Error.CONTROLLED_ERROR
                THEN
                    proUpdCodperfact (vtblPeriProc (sbIndexPeri).nuPeriodo,
                                      'P');
                    nuValida := -1;
                WHEN OTHERS
                THEN
                    proUpdCodperfact (vtblPeriProc (sbIndexPeri).nuPeriodo,
                                      'P');
                    nuValida := -1;
            END;

            IF nuValida = 0
            THEN
                proUpdValidGenaudprevias (
                    vtblPeriProc (sbIndexPeri).nuPeriodo);
            END IF;

            sbIndexPeri := vtblPeriProc.NEXT (sbIndexPeri);
        END LOOP;

        ----------------------------------------------------------------------------------------
        -- Bloque se sentencias
        ----------------------------------------------------------------------------------------
        IF sbAgrupDepa = 'N'
        THEN
            sbNomArch :=
                   'Repo_Audi_Previas_Total_'
                || sbCiclProc
                || '_'
                || TO_CHAR (SYSDATE, 'DDMMYYYY_HH24MISS');
            --- bloque Verificacion presion producto: --
            sbsentc1 :=
                'SELECT VEPRSESU PRODUCTO,
                                      VEPRDEPA DEPARTAMENTO,
                                      VEPRLOCA LOCALIDAD,
                                      VEPRCATE CATEGORIA,
                                      VEPRCICL CICLO,
                                      VEPRPEFA PERIODO,
                                      utl_raw.cast_to_varchar2(nlssort(VEPRESCO, ''nls_sort=binary_ai''))  ESTADO_CORTE,
                                      VEPRMES  MES,
                                      VEPRANO ANO,
                                      VEPRPRAC  PRESION_actual,
                                      VEPRPRAN   presion_ant,
                                      VEPRFCAC  FACTOR_CORRECCION_actual,
                                      VEPRFCAN FACTOR_CORRECCION_anterior,
                                      VEPRSUBC SUBCATEGORIA,
                                      VEPROBSE OBSERVACION
                                  FROM LDC_VERIPRES, LDC_TEMPPPAUD
                                  WHERE VEPRANO =  ANIO
                                  AND VEPRMES = MES
                                  AND VEPRCICL = CICLO';


            --- bloque let_ menor --
            sbsentc2 := 'SELECT
                                           LEMECICL CICLO,
                                           LEMESESU  PRODUCTO,
                                           LEMEPEFA pefacodi,
                                           LEMEFELE  FECHA_LECTURA,
                                           LEMELEAC  LECTURA_ACTUAL,
                                           LEMELEAN LECTURA_ANTERIOR,
                                           LEMEMECO METODO_CONSUMO,
                                           LEMECOAC  CONSUMO_ACTUAL,
                                           LEMECOPR   CONSUMO_PROMEDIO,
                                          LEMEREGL REGLA
                                    FROM    LDC_LECTMENO, LDC_TEMPPPAUD
                                    WHERE LEMEANO =  ANIO
                                    AND     LEMEMES = MES
                                    AND     LEMECICL = CICLO';


            --- bloque Consumos altos: --
            sbsentc3 := 'SELECT
                                            COALCICL CICLO,
                                            COALSESU PRODUCTO,
                                          COALCATE CATEGORIA,
                                          COALSUCA SUBCATEGORIA,
                                          COALESFN ESTADO_FINANCIERO,
                                          COALLEAC LECTURA_ACTUAL,
                                          COALLEAN LECTURA_ANTERIOR,
                                          COALCOAC CONSUMO_ACTUAL,
                                          COALCOAN CONSUMO_ANTERIOR,
                                          COALCOAS CONSUMO_ANTERIOR_2,
                                          COALCOAT CONSUMO_ANTERIOR_3,
                                          COALCOPR CONSUMO_PROMEDIO,
                                          COALMECO METODO_CONSUMO,
                                          COALREGL REGLA_APLICADA
                                    FROM LDC_CONSALTO, LDC_TEMPPPAUD
                                    WHERE   COALANO =  ANIO
                                    AND     COALMES = MES
                                    AND     COALCICL = CICLO';


            --- bloque plan errado: --
            sbsentc4 :=
                'SELECT
                                           PLERSESU  PRODUCTO,
                                           PLERCICL CICLO,
                                           PLERPLFA PLAN,
                                           utl_raw.cast_to_varchar2(nlssort(pktblplansusc.fsbgetdescription(PLERPLFA), ''nls_sort=binary_ai''))  DESC_PLAN,
                                           PLERCATE CATEGORIA,
                                           utl_raw.cast_to_varchar2(nlssort(pktblcategori.fsbgetdescription(PLERCATE), ''nls_sort=binary_ai''))  DESC_CATEGORIA,
                                           PLERSUCA  SUBCATEGORIA,
                                           utl_raw.cast_to_varchar2(nlssort(pktblsubcateg.fsbgetdescription(PLERCATE, PLERSUCA), ''nls_sort=binary_ai''))  DESC_SUBCATEGORIA,
                                           PLERFEIN  FECHA_REGISTRO_PRODUCTO
                                      FROM    LDC_VAPLANERR, LDC_TEMPPPAUD
                                      WHERE PLERANO =  ANIO
                                       AND PLERMES  = MES
                                       AND PLERCICL = CICLO';


            --- bloque Ajustes consumos promedios: --
            sbsentc5 := '  SELECT
                                            AJCPCICL pefacicl,
                                            AJCPPECO cosspecs,
                                            AJCPSESU  PRODUCTO,
                                            AJCPLEAN  LECTURA_ANTERIOR,
                                            AJCPFELE  FECHA_LECTURA,
                                            AJCPESCO  ESTADO_CORTE,
                                            AJCPLEAC  LECTURA_ACTUAL,
                                            AJCPCOAC CONSUMO_ACTUAL,
                                            AJCPCOAN  CONS_ANTERIOR,
                                            AJCPCOPR  CONSUMO_PROMEDIO,
                                            AJCPCORE  CONSUMO_RECUPERADO,
                                            AJCPNUCO NRO_CONS_PROM,
                                            AJCPMECC METODO_CONSUMO,
                                            AJCPREAN  CONS_RECU_ANT
                                      FROM    LDC_AJUSCOPR, LDC_TEMPPPAUD
                                      WHERE   AJCPANO= ANIO
                                      AND     AJCPMES = MES
                                      AND     AJCPCICL= CICLO';

            sbsentc6 :=
                '  SELECT
                                            V.CICLO  CICLO,
                                            TIPO  TIPO,
                                            EST_CORTE   ESTADO_DE_CORTE,
											utl_raw.cast_to_varchar2(nlssort(c.ESCODESC, ''nls_sort=binary_ai''))   descripcion,
                                            CATEGORIA  CATEGORIA,
                                            SUBCATEG  SUBCATEG,
                                            CANTIDAD CANTIDAD_USU
                                      FROM   LDC_VERUSCATE V, LDC_TEMPPPAUD T, estacort c
                                      WHERE   V.ANO = T.ANIO
                                      AND     V.MES = T.MES
                                      AND     V.CICLO= T.CICLO
									  AND C.ESCOCODI = V.EST_CORTE';

            sbsentc7 :=
                '  SELECT
                                            O.CICLO  CICLO,
                                            CONTRATO  CONTRATO,
                                            TIPO_TRABAJO   TIPO_DE_TRABAJO,
											utl_raw.cast_to_varchar2(nlssort(TT.DESCRIPTION, ''nls_sort=binary_ai''))  desc_TIPO_DE_TRABAJO,
                                            ESTADO_ORDEN  ESTADO_ORDEN,
                                            UNIDAD_OPERATIVA  UNIDAD_OPERATIVA
                                      FROM   LDC_ORPECAME O, LDC_TEMPPPAUD T,  OR_TASK_TYPE TT
                                      WHERE   O.ANO = T.ANIO
                                      AND     O.MES = T.MES
                                      AND     O.CICLO= T.CICLO
									  AND TT.TASK_TYPE_ID = o.TIPO_TRABAJO';

            --- bloque Consumos pendientes de Facturar: --
            sbsentc8 :=
                '  SELECT
                                            C.CICLO  CICLO,
                                            CONTRATO  CONTRATO,
                                            NRO_MESES  NRO_DE_PERIODOS,
											 c.ESTACORT estado_corte,
										  utl_raw.cast_to_varchar2(nlssort(ESCODESC, ''nls_sort=binary_ai''))  desc_ESTA_DE_CORTE,
										  c.ESTAPROD estado_producto,
										 utl_raw.cast_to_varchar2(nlssort(EP.DESCRIPTION ,''nls_sort=binary_ai''))  desc_ESTADO_PRODUCTO,
										  C.PERSINFACT
                                      FROM   LDC_CONSNOFA C, LDC_TEMPPPAUD T, estacort EC, PS_PRODUCT_STATUS EP
                                      WHERE   C.ANO = T.ANIO
                                      AND     C.MES = T.MES
                                      AND     C.CICLO= T.CICLO
									  AND  EC.ESCOCODI = c.ESTACORT
									  AND  EP.PRODUCT_STATUS_ID = C.ESTAPROD';

            --- Productos que no entraran a FGCA: --
            sbsentc9 := '  SELECT
                                            P.CICLO  CICLO,
                                            PRODUCTO  PRODUCTO,
                                            OBSERVACION  OBSERVACION
                                      FROM   LDC_PRNOFGCA P, LDC_TEMPPPAUD T
                                      WHERE   P.ANO = T.ANIO
                                      AND     P.MES = T.MES
                                      AND     P.CICLO= T.CICLO';

            ----------------------------------------------------------------------------------------
            -- Finaliza Bloque se sentencias
            ----------------------------------------------------------------------------------------

            -- se concatenan los nombres de las hojas del documento de excel
            sbNomHoja :=
                'Verificacion presion producto|let_menor|Consumos altos|plan errado|Ajustes consumos promedios|Usuarios por categoria|Ordenes para validar|Consumos pendientes de Facturar|Productos no entraran a FGCA';

            -- se concantenan las sentencias para enviarlas al procedimiento de creacion del excel
            SBSENTENCIA :=
                   sbsentc1
                || '|'
                || sbsentc2
                || '|'
                || sbsentc3
                || '|'
                || sbsentc4
                || '|'
                || sbsentc5
                || '|'
                || sbsentc6
                || '|'
                || sbsentc7
                || '|'
                || sbsentc8
                || '|'
                || sbsentc9;

            --- aqui se debe llamar al procedimiento que genera el archivo en excel--
            LDC_EXPORT_REPORT_EXCEL (sbruta,
                                     sbNomArch,
                                     sbNomHoja,
                                     SBSENTENCIA);

            -- aqui se debe llamar al procedimiento que envia el mensaje al correo --
            IF sbEmailNoti IS NOT NULL
            THEN
                FOR item IN cuEmails (sbEmailNoti, ',')
                LOOP
                
                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => sbRemitente,
                        isbDestinatarios    => TRIM (item.COLUMN_VALUE),
                        isbAsunto           => sb_subject,
                        isbMensaje          => sb_text_msg
                        || ' de los ciclos ['
                        || sbCiclProc
                        || ']'
                        || '<br>'
                        || ' Nombre archivo:'
                        || sbNomArch
                        || '.xls, esta ubicado en la ruta: '
                        || sbruta
                        || ''
                    );
                
                END LOOP;
            END IF;
        ELSE
            FOR regDep IN cugetdepartamento
            LOOP
                IF regDep.depa = 3
                THEN
                    sbCiclProc := sbCiclProcAtla;
                ELSIF regDep.depa = 4
                THEN
                    sbCiclProc := sbCiclProcMagd;
                ELSE
                    sbCiclProc := sbCiclProcCesar;
                END IF;

                sbNomArch :=
                       'Rep_Audi_Previas_Depa_'
                    || regDep.description
                    || '_'
                    || sbCiclProc
                    || '_'
                    || TO_CHAR (SYSDATE, 'DDMMYYYY_HH24MISS');
                --- bloque Verificacion presion producto: --
                sbsentc1 :=
                       'SELECT VEPRSESU PRODUCTO,
                                          VEPRDEPA DEPARTAMENTO,
                                          VEPRLOCA LOCALIDAD,
                                          VEPRCATE CATEGORIA,
                                          VEPRCICL CICLO,
                                          VEPRPEFA PERIODO,
                                          utl_raw.cast_to_varchar2(nlssort(VEPRESCO, ''nls_sort=binary_ai''))  ESTADO_CORTE,
                                          VEPRMES  MES,
                                          VEPRANO ANO,
                                          VEPRPRAC  PRESION_actual,
                                          VEPRPRAN   presion_ant,
                                          VEPRFCAC  FACTOR_CORRECCION_actual,
                                          VEPRFCAN FACTOR_CORRECCION_anterior,
                                          VEPRSUBC SUBCATEGORIA,
                                          VEPROBSE OBSERVACION
                                      FROM LDC_VERIPRES, LDC_TEMPPPAUD
                                      WHERE VEPRANO =  ANIO
                                      AND VEPRMES = MES
                                      AND VEPRCICL = CICLO
                                      AND VEPRDEPA = '
                    || regDep.depa;


                --- bloque let_ menor --
                sbsentc2 := 'SELECT
                                               LEMECICL CICLO,
                                               LEMESESU  PRODUCTO,
                                               LEMEPEFA pefacodi,
                                               LEMEFELE  FECHA_LECTURA,
                                               LEMELEAC  LECTURA_ACTUAL,
                                               LEMELEAN LECTURA_ANTERIOR,
                                               LEMEMECO METODO_CONSUMO,
                                               LEMECOAC  CONSUMO_ACTUAL,
                                               LEMECOPR   CONSUMO_PROMEDIO,
                                              LEMEREGL REGLA
                                        FROM  LDC_LECTMENO, LDC_TEMPPPAUD,
											pr_product p,
											ab_address d,
											GE_GEOGRA_LOCATION l
                                        WHERE LEMEANO =  ANIO
                                          AND LEMEMES = MES
                                          AND LEMECICL = CICLO
                                          and LEMESESU = p.product_id
                                          and p.address_id = d.address_id
										and L.GEOGRAP_LOCATION_ID = D.GEOGRAP_LOCATION_ID
										and L.GEO_LOCA_FATHER_ID = ' || regDep.depa;


                --- bloque Consumos altos: --
                sbsentc3 := 'SELECT COALCICL CICLO,
                                            COALSESU PRODUCTO,
                                            COALCATE CATEGORIA,
                                            COALSUCA SUBCATEGORIA,
                                            COALESFN ESTADO_FINANCIERO,
                                            COALLEAC LECTURA_ACTUAL,
                                            COALLEAN LECTURA_ANTERIOR,
                                            COALCOAC CONSUMO_ACTUAL,
                                            COALCOAN CONSUMO_ANTERIOR,
                                            COALCOAS CONSUMO_ANTERIOR_2,
                                            COALCOAT CONSUMO_ANTERIOR_3,
                                            COALCOPR CONSUMO_PROMEDIO,
                                            COALMECO METODO_CONSUMO,
                                            COALREGL REGLA_APLICADA
                                        FROM LDC_CONSALTO, LDC_TEMPPPAUD,
											pr_product p,
											ab_address d,
											GE_GEOGRA_LOCATION l
                                        WHERE   COALANO =  ANIO
                                        AND     COALMES = MES
                                        AND     COALCICL = CICLO
                                        and COALSESU = p.product_id
                                        and p.address_id = d.address_id
										and L.GEOGRAP_LOCATION_ID = D.GEOGRAP_LOCATION_ID
										and L.GEO_LOCA_FATHER_ID = ' || regDep.depa;


                --- bloque plan errado: --
                sbsentc4 :=
                       'SELECT
                                               PLERSESU  PRODUCTO,
                                           PLERCICL CICLO,
                                           PLERPLFA PLAN,
                                           utl_raw.cast_to_varchar2(nlssort(pktblplansusc.fsbgetdescription(PLERPLFA), ''nls_sort=binary_ai''))  DESC_PLAN,
                                           PLERCATE CATEGORIA,
                                           utl_raw.cast_to_varchar2(nlssort(pktblcategori.fsbgetdescription(PLERCATE), ''nls_sort=binary_ai''))  DESC_CATEGORIA,
                                           PLERSUCA  SUBCATEGORIA,
                                           utl_raw.cast_to_varchar2(nlssort(pktblsubcateg.fsbgetdescription(PLERCATE, PLERSUCA), ''nls_sort=binary_ai''))  DESC_SUBCATEGORIA,
                                           PLERFEIN  FECHA_REGISTRO_PRODUCTO
                                          FROM    LDC_VAPLANERR, LDC_TEMPPPAUD,
												pr_product p,
												ab_address d,
												GE_GEOGRA_LOCATION l
                                          WHERE PLERANO =  ANIO
                                           AND PLERMES  = MES
                                           AND PLERCICL = CICLO
                                           and PLERSESU = p.product_id
										   and p.address_id = d.address_id
										   and L.GEOGRAP_LOCATION_ID = D.GEOGRAP_LOCATION_ID
										   and L.GEO_LOCA_FATHER_ID = '
                    || regDep.depa;


                --- bloque Ajustes consumos promedios: --
                sbsentc5 :=
                       '  SELECT
                                                AJCPCICL pefacicl,
                                                AJCPPECO cosspecs,
                                                AJCPSESU  PRODUCTO,
                                                AJCPLEAN  LECTURA_ANTERIOR,
                                                AJCPFELE  FECHA_LECTURA,
                                                AJCPESCO  ESTADO_CORTE,
                                                AJCPLEAC  LECTURA_ACTUAL,
                                                AJCPCOAC CONSUMO_ACTUAL,
                                                AJCPCOAN  CONS_ANTERIOR,
                                                AJCPCOPR  CONSUMO_PROMEDIO,
                                                AJCPCORE  CONSUMO_RECUPERADO,
                                                AJCPNUCO NRO_CONS_PROM,
                                                AJCPMECC METODO_CONSUMO,
                                                AJCPREAN  CONS_RECU_ANT
                                          FROM    LDC_AJUSCOPR, LDC_TEMPPPAUD,
										          pr_product p, ab_address d,
												 GE_GEOGRA_LOCATION l
                                          WHERE   AJCPANO= ANIO
                                          AND     AJCPMES = MES
                                          AND     AJCPCICL= CICLO
                                          and AJCPSESU = p.product_id
										   and p.address_id = d.address_id
										   and L.GEOGRAP_LOCATION_ID = D.GEOGRAP_LOCATION_ID
										   and L.GEO_LOCA_FATHER_ID = '
                    || regDep.depa;

                sbsentc6 :=
                       '  SELECT
                                            V.CICLO  CICLO,
                                            TIPO  TIPO,
                                           EST_CORTE   ESTADO_DE_CORTE,
										   utl_raw.cast_to_varchar2(nlssort(c.ESCODESC, ''nls_sort=binary_ai''))   descripcion,
                                            CATEGORIA  CATEGORIA,
                                            SUBCATEG  SUBCATEG,
                                            CANTIDAD CANTIDAD_USU
                                       FROM   LDC_VERUSCATE V, LDC_TEMPPPAUD T, estacort c, ldc_cicldepa cd
                                      WHERE   V.ANO = T.ANIO
                                      AND     V.MES = T.MES
                                      AND     V.CICLO= T.CICLO
									  AND C.ESCOCODI = V.EST_CORTE
									  and T.CICLO = cd.CICLCODI
									  and cd.CICLDEPA = '
                    || regDep.depa;

                sbsentc7 :=
                       '  SELECT
                                            O.CICLO  CICLO,
                                            CONTRATO  CONTRATO,
                                            TIPO_TRABAJO   TIPO_DE_TRABAJO,
											utl_raw.cast_to_varchar2(nlssort(TT.DESCRIPTION, ''nls_sort=binary_ai''))  desc_TIPO_DE_TRABAJO,
                                            ESTADO_ORDEN  ESTADO_ORDEN,
                                            UNIDAD_OPERATIVA  UNIDAD_OPERATIVA
                                      FROM   LDC_ORPECAME O, LDC_TEMPPPAUD T,  OR_TASK_TYPE TT,
									        suscripc, ab_address d, GE_GEOGRA_LOCATION l
                                      WHERE   O.ANO = T.ANIO
                                      AND     O.MES = T.MES
                                      AND     O.CICLO= T.CICLO
									  AND TT.TASK_TYPE_ID = o.TIPO_TRABAJO
									  AND   CONTRATO = SUSCCODI
                                      and SUSCIDDI = d.address_id
									 and L.GEOGRAP_LOCATION_ID = D.GEOGRAP_LOCATION_ID
									 and L.GEO_LOCA_FATHER_ID = '
                    || regDep.depa;

                --- bloque Consumos pendientes de Facturar: --
                sbsentc8 :=
                       '  select C.CICLO  CICLO,
                                            CONTRATO  CONTRATO,
                                            NRO_MESES  NRO_DE_PERIODOS,
											 c.ESTACORT estado_corte,
										  utl_raw.cast_to_varchar2(nlssort(ESCODESC, ''nls_sort=binary_ai''))  desc_ESTA_DE_CORTE,
										  c.ESTAPROD estado_producto,
										 utl_raw.cast_to_varchar2(nlssort(EP.DESCRIPTION ,''nls_sort=binary_ai''))  desc_ESTADO_PRODUCTO,
										  C.PERSINFACT
                                      FROM   LDC_CONSNOFA C, LDC_TEMPPPAUD T, estacort EC, PS_PRODUCT_STATUS EP
											,suscripc, ab_address d, GE_GEOGRA_LOCATION l
                                      WHERE   C.ANO = T.ANIO
                                      AND     C.MES = T.MES
                                      AND     C.CICLO= T.CICLO
									  AND  EC.ESCOCODI = c.ESTACORT
									  AND  EP.PRODUCT_STATUS_ID = C.ESTAPROD
									  AND   CONTRATO = SUSCCODI
                                      and SUSCIDDI = d.address_id
									  and L.GEOGRAP_LOCATION_ID = D.GEOGRAP_LOCATION_ID
									 and L.GEO_LOCA_FATHER_ID = '
                    || regDep.depa;

                --- bloque Consumos pendientes de Facturar: --
                sbsentc9 :=
                       '  SELECT     P.CICLO  CICLO,
                                            PRODUCTO  PRODUCTO,
                                            OBSERVACION  OBSERVACION
                                      FROM  LDC_PRNOFGCA P, LDC_TEMPPPAUD T, pr_product p,
											ab_address d, GE_GEOGRA_LOCATION l
									  WHERE   P.ANO = T.ANIO
										  AND     P.MES = T.MES
										  AND     P.CICLO= T.CICLO
										  and PRODUCTO = p.product_id
										  and p.address_id = d.address_id
										and L.GEOGRAP_LOCATION_ID = D.GEOGRAP_LOCATION_ID
										and L.GEO_LOCA_FATHER_ID = '
                    || regDep.depa;

                ----------------------------------------------------------------------------------------
                -- Finaliza Bloque se sentencias
                ----------------------------------------------------------------------------------------

                -- se concatenan los nombres de las hojas del documento de excel
                sbNomHoja :=
                    'Verificacion presion producto|let_menor|Consumos altos|plan errado|Ajustes consumos promedios|Usuarios por categoria|Ordenes para validar|Consumos pendientes de Facturar|Productos no entraran a FGCA';

                -- se concantenan las sentencias para enviarlas al procedimiento de creacion del excel
                SBSENTENCIA :=
                       sbsentc1
                    || '|'
                    || sbsentc2
                    || '|'
                    || sbsentc3
                    || '|'
                    || sbsentc4
                    || '|'
                    || sbsentc5
                    || '|'
                    || sbsentc6
                    || '|'
                    || sbsentc7
                    || '|'
                    || sbsentc8
                    || '|'
                    || sbsentc9;

                --- aqui se debe llamar al procedimiento que genera el archivo en excel--
                LDC_EXPORT_REPORT_EXCEL (sbruta,
                                         sbNomArch,
                                         sbNomHoja,
                                         SBSENTENCIA);

                -- aqui se debe llamar al procedimiento que envia el mensaje al correo --
                IF sbEmailNoti IS NOT NULL
                THEN
                    FOR item IN cuEmails (sbEmailNoti, ',')
                    LOOP
                    
                        pkg_Correo.prcEnviaCorreo
                        (
                            isbRemitente        => sbRemitente,
                            isbDestinatarios    => TRIM (item.COLUMN_VALUE),
                            isbAsunto           => sb_subject,
                            isbMensaje          => sb_text_msg
                            || ' de los ciclos ['
                            || sbCiclProc
                            || ']'
                            || '<br>'
                            || ' Nombre archivo:'
                            || sbNomArch
                            || '.xls, esta ubicado en la ruta: '
                            || sbruta
                            || ''
                        );
                
                    END LOOP;
                END IF;
            END LOOP;
        END IF;
    END IF;

    ldc_proactualizaestaprog (nutsess,
                              sbMensError,
                              'LDC_PRGEAUDPRE',
                              'Ok');
EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR
    THEN
        pkg_Error.getError (coderror, sbmessage);

        ldc_proactualizaestaprog (nutsess,
                                  sbmessage,
                                  'LDC_PRGEAUDPRE',
                                  'Termino con error');
        proUpdCodperfact (nuPeriodoAux, 'P'); -- se actualiza el periodo que presento el error
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

        ldc_proactualizaestaprog (nutsess,
                                  sbmessage,
                                  'LDC_PRGEAUDPRE',
                                  'Termino con error');
        proUpdCodperfact (nuPeriodoAux, 'P'); -- se actualiza el periodo que presento el error
        ROLLBACK;
        RAISE pkg_Error.CONTROLLED_ERROR;
END LDC_PRGEAUDPRE;
/
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PRGEAUDPRE', 'OPEN');
END;
/