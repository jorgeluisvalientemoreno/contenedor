CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRGAPYCAR
IS
    /*******************************************************************************
        Metodo:       LDC_PRGAPYCAR
        Descripcion:  Procedimiento que tiene la misma logica que el procedimiento LDCFAPC
                      del PB con el mismo nombre, el cual se encarga Del proceso de de generacion
                      de AUDITORIAS POSTERIORES Y LOS CARGOS A LA -1, sin embargo los datos de MES,
                      ANO, NUMERO DE CICLO Y EMAIL, se obtienen de una forma distinta al PB, por
                      medio de la tabla "PROCEJEC" y el codigo del periodo de facturacion se obtiene
                      por medio de la tabla temporal creada LDC_CODPERFACT que guarda este codigo cuando
                      se dispara el trigger LDC_TRGPRGEAUPRE cuando hay un cierre de critica.

        Autor:        Olsoftware/Miguel Ballesteros
        Fecha:        30/08/2019

        Entrada           Descripcion
        nuPeriodo:        Codigo periodo de Facturacion

        Salida             Descripcion

        Historia de Modificaciones
        FECHA          AUTOR                       DESCRIPCION
     22/09/2020     HORBATH     CASO 316:
                                   * Se modifico el cursor CUGETCODPERFACT para contar registros en la
                                   LDC_prometcub con el fin de establecer si el proceso el periodo esta en P[PENDIENTE]
                                   este periodo ya ingreso inconsistencias de consumo en la entidad LDC_prometcub
                                   * Se creara variable para establecer el envio de correo con los periodos que no cumplieron
                                   con el control de MT3 en el concepto de consumo
        14/11/2020     HORBATH     CA 461
                                   se coloca logica para agrupar archivos de excel por departamento
                                   - validar si hubo problemas en el periodo en las auditorias posteriores
                                   - realizar nuevo proceso que elimine los cargos despues de la cnatidad de periodos configurados en
                                   el parametro LDC_CAPERSIFACT
                                   - cambiar notificacion por los email configurados en el parametro LDC_EMAILNOLE
                                   --agregar nueva funcionalidad que genere cargos a la -1 de losc argos con causal 15
        25/04/2021     HORBATH     CASO 230:
                                   Agregar servicio llamado LDC_PRRECAMORA en las ubicaciones indicadas por el N1 Francisco Catro.
                                   Debido a que el procedimiento cambio de logica y de funcionalidad cuando se cotixo el CASO 230.
        31/07/2021     ljlb        CA 696
                                   se coloca validacion del parametro LDC_ACTIPROAUDPOST para activar o incativar el proceso de auditoria en la
                                   forma LDCEMC
        12/01/2022     hahenao     CA_834:
                                   Se invoca el metodo LDC_PCOMPRESSFILE para comprimir en .zip el archivo Reporte_Cargos_-1_Depa_ y
                                   eliminar original.
       18/04/2022  cgonzalez OSF-159 Se ajusta para reemplazar el borrado de cargos por la creacion de un cargo
           contrapartida.
           Se ajusta la consulta donde se obtiene el n periodo atras de facturacion,
           para que lo haga por a¿¿¿¿o y mes de la entidad PERIFACT y no por meses del calendario.
       16/06/2022      ljlb        CA OSF-364  se ajusta proceso para controlar el envio de correo
    30/06/2022      LJLB       CA OSF-404 se ajusta proceso de reporte de cargos a -1
    16/05/2024      jpinedc     OSF-2581: * Se reemplaza ldc_sendemail por pkg_Correo.prcEnviaCorreo
    *******************************************************************************/

    csbMetodo       CONSTANT VARCHAR2 (70) := 'LDC_PRGAPYCAR';
    csbNivelTraza   CONSTANT NUMBER (2) := pkg_traza.fnuNivelTrzDef;

    NuControl                NUMBER := 0;

    nuCiclo                  perifact.pefacicl%TYPE;
    nuPeriodoAux             perifact.pefacodi%TYPE;
    --sbEmail                  VARCHAR2 (4000);

    sbruta                   VARCHAR2 (200);
    sbNomArch                VARCHAR2 (200);
    sbNomHoja                VARCHAR2 (2000);
    SBSENTENCIA              CLOB;
    sb_subject               VARCHAR2 (200)
                                 := 'Proceso de Auditorias Posteriores Hecho';
    sb_text_msg              VARCHAR2 (200)
        := 'Se realiza el proceso de auditorias posteriores con el codigo del periodo de facturacion tramitado';
    nuparano                 NUMBER;
    nuparmes                 NUMBER;
    nutsess                  NUMBER;
    sbparuser                VARCHAR2 (50);
    coderror                 NUMBER;
    sbmessage                VARCHAR2 (2000);
    sbMensError              VARCHAR2 (2000);

    sbsentc1                 CLOB;
    sbsentc2                 CLOB;
    sbsentc3                 CLOB;
    sbsentc4                 CLOB;
    sbsentc5                 CLOB;
    sbsentc6                 CLOB;
    sbsentc7                 CLOB;
    sbsentc8                 CLOB;
    sbsentc9                 CLOB;

    -- variables para el proceso de generacion de cargos
    NomArchCarg              VARCHAR2 (200);

    dtFechaFin               DATE;
    dtFechaFinf              DATE;

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
                         WHERE     b.biinpefa = nuPeriodo
                               AND TRUNC (BIINFECH) BETWEEN dtFechaFin
                                                        AND dtFechaFinf);


    -- Cursor que obtiene los datos del mes, ano y numero de ciclo de acuerdo al codigo del periodo de facturacion
    CURSOR CUGETMANUMCICLO (nuPeriodoFact PROCEJEC.PREJCOPE%TYPE)
    IS
        SELECT PEFAANO Ano, PEFAMES Mes, PEFACICL Num_Ciclo
          FROM PERIFACT PF
         WHERE pf.pefacodi = nuPeriodoFact;

    -- Cursor que obtiene el numero del periodo que se le haya hecho cierre critica
    CURSOR CUGETCODPERFACT IS
        SELECT PE.ROWID        ID_REG,
               COD_PERFACT     nuPeriodo,
               PEFAANO         Ano,
               PEFAMES         Mes,
               PEFACICL        Num_Ciclo
          FROM LDC_CODPERFACT PE, PERIFACT PF
         WHERE     ESTADPROCESS = 'P'
               AND TYPEPROCESS = 'FGCA'
               AND pf.pefacodi = COD_PERFACT;

    item                     CUGETCODPERFACT%ROWTYPE;

    --este cursor separa lo emails
    CURSOR cuEmails (sbEmail VARCHAR2, sbseparador VARCHAR2)
    IS
    SELECT regexp_substr(sbEmail,'[^' || sbseparador || ']+', 1,LEVEL) COLUMN_VALUE
    FROM dual
    CONNECT BY regexp_substr(sbEmail, '[^' ||sbseparador || ']+', 1, LEVEL) IS NOT NULL;

    TYPE tblPeriProc IS TABLE OF CUGETCODPERFACT%ROWTYPE
        INDEX BY VARCHAR2 (100);

    vtblPeriProc             tblPeriProc;
    sbIndexPeri              VARCHAR2 (100);

    sbEmailNoti              VARCHAR2 (4000)
        := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_EMAILNOLE');
    sbCiclProc               VARCHAR2 (4000);
    sbCiclProcAtla           VARCHAR2 (4000);
    sbCiclProcMagd           VARCHAR2 (4000);
    sbCiclProcCesar          VARCHAR2 (4000);
    nuDepart                 NUMBER;

    sbAgrupDepa              VARCHAR2 (2)
        := pkg_BCLD_Parameter.fsbObtieneValorCadena ('AGRUPAAUDPOSTDPTO');
    nuValida                 NUMBER;
    nucantPeri               NUMBER
        := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('LDC_CAPERSIFACT');

    CURSOR cuGetFechVali IS
        SELECT TRUNC (MIN (PEFAFFMO)), MAX (PEFAFFMO)
          FROM LDC_CODPERFACT PE, PERIFACT PF
         WHERE     ESTADPROCESS = 'P'
               AND TYPEPROCESS = 'FGCA'
               AND pf.pefacodi = COD_PERFACT;

    sbExistecarg             VARCHAR2 (1);

    CURSOR cuValidaCargos IS
        SELECT 'X'
          FROM procejec
         WHERE     PREJPROG = 'FGCA'
               AND TRUNC (PREJFECH) BETWEEN dtFechaFin AND dtFechaFinf
               AND PREJESPR <> 'T';

    sbCiclosExc              VARCHAR2 (4000)
        := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_CICLEXPCA');

    nuValidaCicl             NUMBER;

    CURSOR cuExisteCiclo (inuPeriodo NUMBER)
    IS
        SELECT COUNT (1)
          FROM perifact
         WHERE     pefacodi = inuPeriodo
               AND pefacicl IN (    SELECT TO_NUMBER (REGEXP_SUBSTR (sbCiclosExc,
                                                                     '[^,]+',
                                                                     1,
                                                                     LEVEL))    AS activi
                                      FROM DUAL
                                CONNECT BY REGEXP_SUBSTR (sbCiclosExc,
                                                          '[^,]+',
                                                          1,
                                                          LEVEL)
                                               IS NOT NULL);

    Inuano                   NUMBER;
    Inumes                   NUMBER;
    sbConceptos              VARCHAR2 (400)
        := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_CONCELIMCARG');

    sbSignoContra            VARCHAR2 (2);

    --se valida los productos con mas periodo de consumo liquidado
    CURSOR cuValidaPerio (inuperiodo NUMBER, iniciclo NUMBER)
    IS
        SELECT c.*
          FROM cargos c, perifact pe, pericose pc
         WHERE     cargpefa = inuperiodo
               --AND cargprog in ( 5
               AND cargcuco = -1
               AND pe.pefaano = Inuano                                 --nuano
               AND pe.pefames = Inumes                                 --numes
               AND cargpeco = pc.pecscons
               AND pc.pecscico = pe.pefacicl
               AND pefacicl = iniciclo
               AND c.cargconc IN (    SELECT TO_NUMBER (
                                                 REGEXP_SUBSTR (sbConceptos,
                                                                '[^,]+',
                                                                1,
                                                                LEVEL))    AS activi
                                        FROM DUAL
                                  CONNECT BY REGEXP_SUBSTR (sbConceptos,
                                                            '[^,]+',
                                                            1,
                                                            LEVEL)
                                                 IS NOT NULL)
               AND c.cargcaca IN (15, 59)
               AND pc.pecsfecf <= pe.pefaffmo;

    CURSOR cuproduElimCarg (inuNuse NUMBER, inuperiodo NUMBER)
    IS
        SELECT cargnuse,
               cargpeco,
               cargpefa,
               fila
          FROM (SELECT cargnuse,
                       cargpeco,
                       cargpefa,
                       ROWNUM     fila
                  FROM (  SELECT DISTINCT c.cargnuse, c.cargpeco, c.cargpefa
                            FROM cargos c
                           WHERE     c.cargnuse = inuNuse
                                 AND c.cargpefa = inuperiodo
                                 AND c.cargprog = 5
                        ORDER BY cargpeco DESC))
         WHERE fila > nucantPeri;

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

    nuIndJob                 NUMBER;

    CURSOR cugetCargos IS
        SELECT pf.pefaano              ano,
               pf.pefames              mes,
               pf.pefacicl             Ciclo,
               c.CARGCUCO              CuentadeCobro,
               ss.sesunuse             Producto,
               ss.sesususc             Contrato,
               ss.sesuserv             TipodeProducto,
               C.cargconc              Concepto,
               c.CARGFECR              FechadeCargo,
               c.CARGVALO              Valor,
               c.CARGDOSO              DocumentodeSoporte,
               c.CARGSIGN              Signo,
               ss.sesucate             Categoria,
               ss.sesusuca             Subcategoria,
               c.CARGCACA              Causadelcargo,
               pr.product_status_id    ESTADOTECNICO,
               ss.sesuesco             ESTADOdeCORTE,
               c.cargunid              unddelcargo,
               c.cargprog              programa,
               L.GEO_LOCA_FATHER_ID    DEPARTAMENTO,
               CASE
                   WHEN c.cargconc = 31 AND C.CARGCACA = 15
                   THEN
                       (SELECT RALIVALO
                          FROM RANGLIQU
                         WHERE     RALISESU = c.cargnuse
                               AND RALIPECO = c.cargpeco
                               AND RALICONC = 31
                               AND RALIUNLI > 0
                               AND RALILIIR = 0
                               AND ROWNUM < 2)
                   ELSE
                       0
               END                     tarifa_fija,
               CASE
                   WHEN c.cargconc = 31 AND C.CARGCACA = 15
                   THEN
                       (SELECT RALIVALO
                          FROM RANGLIQU
                         WHERE     RALISESU = c.cargnuse
                               AND RALIPECO = c.cargpeco
                               AND RALICONC = 31
                               AND RALIUNLI > 0
                               AND RALILIIR = 21
                               AND ROWNUM < 2)
                   ELSE
                       0
               END                     tarifa_variable,
               nuIndJob
          FROM cargos              c,
               SERVSUSC            ss,
               SUSCRIPC            su,
               pr_product          pr,
               PERIFACT            pf,
               LDC_TEMPPPAUD       pt,
               ab_address          d,
               GE_GEOGRA_LOCATION  l
         WHERE     ss.sesunuse = pr.product_id
               AND c.cargnuse = ss.sesunuse
               AND ss.SESUSUSC = su.susccodi
               AND c.CARGPEFA = pf.pefacodi
               AND pf.pefacicl = pt.ciclo
               AND pf.pefaano = pt.ANIO
               AND pf.pefames = pt.mes
               AND c.CARGCUCO = -1
               AND C.CARGCACA = 15
               AND D.ADDRESS_ID = PR.ADDRESS_ID
               AND D.GEOGRAP_LOCATION_ID = L.GEOGRAP_LOCATION_ID;

    TYPE tbCargos IS TABLE OF cugetCargos%ROWTYPE;

    v_tbCargos               tbCargos;

    sbActivo                 VARCHAR2 (1)
        := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_ACTIPROAUDPOST');

    sbRemitente              ld_parameter.value_chain%TYPE
        := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_SMTP_SENDER');

    ----------------------------------------------------------------------------------------
    -- Procedimiento Pragma para actualizar la tabla LDC_CODPERFACT
    ----------------------------------------------------------------------------------------
    PROCEDURE proUpdCodperfact (nuPeriodo   PROCEJEC.PREJCOPE%TYPE,
                                Estado      LDC_CODPERFACT.ESTADPROCESS%TYPE)
    IS
        csbMetodo2   CONSTANT VARCHAR2 (70)
                                  := csbMetodo || '.proUpdCodperfact' ;

        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        pkg_traza.trace (csbMetodo2, csbNivelTraza, pkg_traza.csbINICIO);

        UPDATE LDC_CODPERFACT
           SET ESTADPROCESS = Estado
         WHERE cod_perfact = nuPeriodo AND TYPEPROCESS = 'FGCA';

        COMMIT;

        pkg_traza.trace (csbMetodo2, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN OTHERS
        THEN
            NULL;
    END proUpdCodperfact;

    -- Procedimiento Pragma para validar la inserccion o update de la tabla LDC_VALIDGENAUDPREVIAS
    -----------------------------------------------------------------------------------------------
    PROCEDURE proUpdValidGenaudposterior (nuPeriodo PROCEJEC.PREJCOPE%TYPE)
    IS
        csbMetodo3   CONSTANT VARCHAR2 (70)
            := csbMetodo || '.proUpdValidGenaudposterior' ;
        PRAGMA AUTONOMOUS_TRANSACTION;
        x                     NUMBER;
    BEGIN
        pkg_traza.trace (csbMetodo3, csbNivelTraza, pkg_traza.csbINICIO);

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

        pkg_traza.trace (csbMetodo3, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN OTHERS
        THEN
            NULL;
    END proUpdValidGenaudposterior;

    FUNCTION fnuValidaauditoPost (inuPeriodo   IN NUMBER,
                                  inuano       IN NUMBER,
                                  inumes       IN NUMBER,
                                  inuciclo     IN NUMBER)
        RETURN NUMBER
    IS
        /*******************************************************************************
       Metodo:       fnuValidaauditoPost
       Descripcion:  Proceso que valida si hubo problema de auditorias posteriores
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

        csbMetodo4   CONSTANT VARCHAR2 (70)
                                  := csbMetodo || '.fnuValidaauditoPost' ;

        PRAGMA AUTONOMOUS_TRANSACTION;

        CURSOR cuGetproductAudi IS
            SELECT DISTINCT inuPeriodo     inuPeriodo,
                            inuano         inuano,
                            inumes         inumes,
                            inuciclo       inuciclo,
                            contrato,
                            producto,
                            concepto,
                            CONSUMO        volliq,
                            valor          valliq,
                            categoria,
                            SUCA,
                            estado_producto,
                            1              PROCESO
              FROM (SELECT COALSESU              producto,
                           SUBSCRIPTION_ID       CONTRATO,
                           CATEGORY_ID           categoria,
                           SUBCATEGORY_ID        suca,
                           PRODUCT_STATUS_ID     estado_producto,
                           31                    concepto,
                           COALCOAC              CONSUMO,
                           0                     valor
                      FROM LDC_CONSUALTO, PR_PRODUCT
                     WHERE     COALANO = inuano
                           AND COALMES = inumes
                           AND COALCICL = inuciclo
                           AND PRODUCT_ID = COALSESU
                    UNION ALL
                    SELECT VAALSESU,
                           SUBSCRIPTION_ID       CONTRATO,
                           CATEGORY_ID           categoria,
                           SUBCATEGORY_ID        suca,
                           PRODUCT_STATUS_ID     estado_producto,
                           VAALCONC              concepto,
                           NVL (VAALCOAC, 0)     CONSUMO,
                           VAALVALO              VALOR
                      FROM LDC_VALALTCA, PR_PRODUCT
                     WHERE     VAALANO = inuano
                           AND VAALMES = inumes
                           AND VAALCICL = inuciclo
                           AND PRODUCT_ID = VAALSESU
                           AND VAALCONC = 31);

        TYPE tbproductAudi IS TABLE OF cuGetproductAudi%ROWTYPE;

        v_tbproductAudi       tbproductAudi;

        CURSOR cugetValidRegistro (inuProdu NUMBER)
        IS
            SELECT 'X'
              FROM ldc_prometcub
             WHERE     PERIODO = inuPeriodo
                   AND ANNO = inuano
                   AND MES = inumes
                   AND PRODUCTO = inuProdu;

        sbExiste              VARCHAR2 (1);
        nuvalida              NUMBER := 0;
    BEGIN
        pkg_traza.trace (csbMetodo4, csbNivelTraza, pkg_traza.csbINICIO);

        OPEN cuGetproductAudi;

        LOOP
            FETCH cuGetproductAudi
                BULK COLLECT INTO v_tbproductAudi
                LIMIT 100;

            FOR i IN 1 .. v_tbproductAudi.COUNT
            LOOP
                IF cugetValidRegistro%ISOPEN
                THEN
                    CLOSE cugetValidRegistro;
                END IF;

                nuvalida := 1;

                --se valida si existe proceso
                OPEN cugetValidRegistro (v_tbproductAudi (i).producto);

                FETCH cugetValidRegistro INTO sbExiste;

                IF cugetValidRegistro%NOTFOUND
                THEN
                    INSERT INTO ldc_prometcub (periodo,
                                               anno,
                                               mes,
                                               ciclo,
                                               contrato,
                                               producto,
                                               concepto,
                                               volliq,
                                               valliq,
                                               categoria,
                                               subcategoria,
                                               estado_producto,
                                               PROCESO)
                         VALUES (v_tbproductAudi (i).inuPeriodo,
                                 v_tbproductAudi (i).inuano,
                                 v_tbproductAudi (i).inumes,
                                 v_tbproductAudi (i).inuciclo,
                                 v_tbproductAudi (i).contrato,
                                 v_tbproductAudi (i).producto,
                                 v_tbproductAudi (i).concepto,
                                 v_tbproductAudi (i).volliq,
                                 v_tbproductAudi (i).valliq,
                                 v_tbproductAudi (i).categoria,
                                 v_tbproductAudi (i).suca,
                                 v_tbproductAudi (i).estado_producto,
                                 v_tbproductAudi (i).PROCESO);
                ELSE
                    UPDATE ldc_prometcub
                       SET PROCESO = 2
                     WHERE     PERIODO = inuPeriodo
                           AND ANNO = inuano
                           AND MES = inumes
                           AND PRODUCTO = v_tbproductAudi (i).producto;
                END IF;

                CLOSE cugetValidRegistro;
            END LOOP;

            COMMIT;
            EXIT WHEN cuGetproductAudi%NOTFOUND;
        END LOOP;

        CLOSE cuGetproductAudi;

        COMMIT;
        pkg_traza.trace (csbMetodo4, csbNivelTraza, pkg_traza.csbFIN);

        RETURN nuvalida;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pkg_Error.setError;
            RETURN nuvalida;
    END fnuValidaauditoPost;
BEGIN
    pkg_traza.trace (csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

    sbruta :=
        pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDCPARMRUTAPOSTERIORES');

    -- se hace este select para obtener la informacion a enviar al procedimiento ldc_proinsertaestaprog
    nuparano := TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY'));
    nuparmes := TO_NUMBER (TO_CHAR (SYSDATE, 'MM'));
    nutsess := USERENV ('SESSIONID');
    sbparuser := USER;


    -- se llama al procedimiento ldc_proinsertaestaprog que actualiza el progreso en estaprog
    ldc_proinsertaestaprog (nuparano,
                            nuparmes,
                            'LDC_PRGAPYCAR',
                            'En ejecucion',
                            nutsess,
                            sbparuser);
    vtblPeriProc.DELETE;
    sbCiclProc := NULL;

    DELETE FROM LDC_TEMPPPAUD;

    COMMIT;

    OPEN cuGetFechVali;

    FETCH cuGetFechVali INTO dtFechaFin, dtFechaFinf;

    CLOSE cuGetFechVali;

    IF dtFechaFin IS NOT NULL
    THEN
        OPEN cuValidaCargos;

        FETCH cuValidaCargos INTO sbExistecarg;

        CLOSE cuValidaCargos;
    END IF;

    IF sbExistecarg IS NULL
    THEN
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

            DELETE FROM LDC_prometcub
                  WHERE periodo = reg.nuPeriodo;

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
                        sbCiclProcAtla :=
                            sbCiclProcAtla || ',' || reg.Num_Ciclo;
                    END IF;
                ELSIF nuDepart = 4
                THEN
                    IF sbCiclProcMagd IS NULL
                    THEN
                        sbCiclProcMagd := reg.Num_Ciclo;
                    ELSE
                        sbCiclProcMagd :=
                            sbCiclProcMagd || ',' || reg.Num_Ciclo;
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
            --se genera proceso de auditoria posteriores
            sbIndexPeri := vtblPeriProc.FIRST;

            LOOP
                EXIT WHEN sbIndexPeri IS NULL;

                OPEN cuExisteCiclo (vtblPeriProc (sbIndexPeri).nuPeriodo);

                FETCH cuExisteCiclo INTO nuValidaCicl;

                CLOSE cuExisteCiclo;

                IF nuValidaCicl = 0
                THEN
                    --INICIO CA 696
                    --cgonzalez - Se cambia la manera en que se obtiene el n periodo atras de facturacion
                    SELECT TO_NUMBER (TO_CHAR (fecha, 'YYYY'))     anio,
                           TO_NUMBER (TO_CHAR (fecha, 'MM'))       mes
                      INTO Inuano, Inumes
                      FROM (   --SELECT add_months(SYSDATE, -nucantPeri) fecha
                            SELECT ADD_MONTHS (
                                       TO_DATE (
                                           TO_CHAR (
                                                  '01/'
                                               || vtblPeriProc (sbIndexPeri).mes
                                               || '/'
                                               || vtblPeriProc (sbIndexPeri).ano)),
                                       -nucantPeri)    fecha
                              FROM DUAL);

                    pkg_Traza.Trace ('Inuano: ' || Inuano, 5);
                    pkg_Traza.Trace ('Inumes: ' || Inumes, 5);
                    pkg_Traza.Trace ('nucantPeri: ' || nucantPeri, 5);

                    --FIN CA 696
                    FOR regPer
                        IN cuValidaPerio (
                               vtblPeriProc (sbIndexPeri).nuperiodo,
                               vtblPeriProc (sbIndexPeri).Num_Ciclo)
                    LOOP
                        --cgonzalez - OSF-159 Se cambia la logica de borrado de cargos por la creacion de la contrapartida del cargo.
                        CASE regPer.cargsign
                            WHEN 'DB'
                            THEN
                                sbSignoContra := 'CR';
                            WHEN 'CR'
                            THEN
                                sbSignoContra := 'DB';
                        END CASE;

                        regPer.cargsign := sbSignoContra;

                        INSERT INTO CARGOS (CARGCUCO,
                                            CARGNUSE,
                                            CARGCONC,
                                            CARGCACA,
                                            CARGSIGN,
                                            CARGPEFA,
                                            CARGVALO,
                                            CARGDOSO,
                                            CARGCODO,
                                            CARGUSUA,
                                            CARGTIPR,
                                            CARGUNID,
                                            CARGFECR,
                                            CARGPROG,
                                            CARGCOLL,
                                            CARGPECO,
                                            CARGTICO,
                                            CARGVABL,
                                            CARGTACO)
                             VALUES (regPer.CARGCUCO,
                                     regPer.CARGNUSE,
                                     regPer.CARGCONC,
                                     regPer.CARGCACA,
                                     regPer.CARGSIGN,
                                     regPer.CARGPEFA,
                                     regPer.CARGVALO,
                                     regPer.CARGDOSO,
                                     regPer.CARGCODO,
                                     regPer.CARGUSUA,
                                     regPer.CARGTIPR,
                                     regPer.CARGUNID,
                                     regPer.CARGFECR,
                                     regPer.CARGPROG,
                                     regPer.CARGCOLL,
                                     regPer.CARGPECO,
                                     regPer.CARGTICO,
                                     regPer.CARGVABL,
                                     regPer.CARGTACO);

                        COMMIT;

                        pkg_Traza.Trace (
                               'INSERT INTO CARGOS: '
                            || regPer.CARGCUCO
                            || ' - '
                            || regPer.CARGCONC
                            || ' - '
                            || regPer.CARGSIGN
                            || ' - '
                            || regPer.CARGVALO,
                            5);
                    END LOOP;
                END IF;

                sbIndexPeri := vtblPeriProc.NEXT (sbIndexPeri);
            END LOOP;

            --se genera proceso de auditoria posteriores
            sbIndexPeri := vtblPeriProc.FIRST;

            LOOP
                EXIT WHEN sbIndexPeri IS NULL;
                nuValida := 0;
                NuControl := 0;

                -- se establece el codigo del periodo en una variable para ser usado en el exception
                nuPeriodoAux := vtblPeriProc (sbIndexPeri).nuPeriodo;
                -- se llama al procedimiento que actualiza el estado del codigo del periodo a ejecutado
                proUpdCodperfact (nuPeriodoAux, 'E');

                -- se elimina los datos de la tabla temporal LDC_SAVECONEXION
                DELETE FROM LDC_SAVECONEXION;

                -- se llama al paquete en donde esta toda la logica DEL PROCESO DE GENERACION DE AUDITOR??A???A???A???A?AS POSTERIORES Y LOS CARGOS A LA -1
                BEGIN
                    LDC_PKFAPC.proGeneraAuditorias (
                        vtblPeriProc (sbIndexPeri).Ano,
                        vtblPeriProc (sbIndexPeri).Mes,
                        vtblPeriProc (sbIndexPeri).Num_Ciclo,
                        NULL);



                    OPEN cuExisteCiclo (vtblPeriProc (sbIndexPeri).nuPeriodo);

                    FETCH cuExisteCiclo INTO nuValidaCicl;

                    CLOSE cuExisteCiclo;

                    IF nuValidaCicl = 0
                    THEN
                        --Inicio CASO 316
                        NuControl :=
                            LDC_FNUESTADOPERIODO (
                                vtblPeriProc (sbIndexPeri).nuPeriodo,
                                vtblPeriProc (sbIndexPeri).Num_Ciclo,
                                vtblPeriProc (sbIndexPeri).Ano,
                                vtblPeriProc (sbIndexPeri).Mes);

                        --INICIO CA 696
                        IF (sbActivo = 'S')
                        THEN
                            nuvalida :=
                                fnuValidaauditoPost (
                                    vtblPeriProc (sbIndexPeri).nuPeriodo,
                                    vtblPeriProc (sbIndexPeri).Ano,
                                    vtblPeriProc (sbIndexPeri).Mes,
                                    vtblPeriProc (sbIndexPeri).Num_Ciclo);
                        END IF;
                    --FIN CA 696
                    END IF;
                EXCEPTION
                    WHEN pkg_Error.CONTROLLED_ERROR
                    THEN
                        proUpdCodperfact (nuPeriodoAux, 'P');
                        nuvalida := -1;
                    WHEN OTHERS
                    THEN
                        proUpdCodperfact (nuPeriodoAux, 'P');
                        nuvalida := -1;
                END;

                IF NuControl = 0 AND nuvalida = 0
                THEN
                    --Actualiza el estado del periodo en el campo PROCESO a 'AUDPOST'
                    proUpdValidGenaudposterior (nuPeriodoAux);
                END IF;

                -- se llama al procedimiento que actualiza el estado del periodo a terminado, para indicar que el proceso termino correctamente
                proUpdCodperfact (nuPeriodoAux, 'T');

                sbIndexPeri := vtblPeriProc.NEXT (sbIndexPeri);
            END LOOP;

            IF sbAgrupDepa = 'N'
            THEN
                ----------------------------------------------------------------------------------------
                -- Bloque se sentencias
                ----------------------------------------------------------------------------------------
                sbNomArch :=
                       'Repo_Audi_Post_Total_'
                    || sbCiclProc
                    || '_'
                    || TO_CHAR (SYSDATE, 'DDMMYYYY_HH24MISS');
                --- Cargos Dobles: --
                sbsentc1 := 'SELECT
											  CADOCICL CICLO,
											  CADOSESU  PRODUCTO,
											  CADOCONC CONCEPTO,
											  CADOCACA CAUSAL,
											  CADOSIGN SIGNO,
											  CADOCANT  CANTIDAD,
											  CADOVALO VALOR
									 FROM	LDC_CARGDOBL, LDC_TEMPPPAUD
									 WHERE CADOANO = ANIO
										  AND CADOMES = MES
										  AND CADOCICL= CICLO';


                --- Consumos Altos --
                sbsentc2 := 'SELECT
												  COALCICL CICLO,
												  COALSESU PRODUCTO,
												  COALCATE CATEGORIA,
												  COALSUCA SUBCATEGORIA,
												  COALPEFA  PEFACODI   ,
												  COALCATE   sesucate,
												  nvl(COALCOPR,0) PROMEDIO,
												  nvl(COALCOAC,0) CONSUMO_ACTUAL,
												  nvl(COALCOAN,0)  CONSUMO_ANTERIOR_1,
												  nvl(COALCOAS,0) CONSUMO_ANTERIOR_2,
												  nvl(COALCOAT,0) CONSUMO_ANTERIOR_3,
												  coalregl regla
										  FROM    LDC_CONSUALTO, LDC_TEMPPPAUD
										  WHERE   COALANO= ANIO
										  AND     COALMES = MES
										  AND     COALCICL= CICLO';


                --- Valores Altos Cargos: --
                sbsentc3 :=
                    'SELECT
												  VAALCICL CICLO,
												  VAALSESU PRODUCTO,
												  VAALSERV SERVICIO,
												  VAALCONC CONCEPTO,
												  VAALSIGN SIGNO,
												  VAALCATE CATEGORIA,
												  VAALSUCA SUBCATEGORIA,
												  VAALDOSO DOCUMENTO,
												  VAALVALO VALOR,
												  VAALCACA CAUSA_CARGO,
												   utl_raw.cast_to_varchar2(nlssort(pktblcauscarg.fsbgetdescription(VAALCACA), ''nls_sort=binary_ai''))  DESCRIPCION_CAUSA,
												  nvl(VAALCOPR,0)  PROMEDIO,
												  nvl(VAALCOAC,0)  CONSUMO_ACTUAL,
												  nvl( VAALCOAN,0)  CONSUMO_ANTERIOR_1,
												  nvl(VAALCOAS,0) CONSUMO_ANTERIOR_2,
												  nvl(VAALCOAT,0) CONSUMO_ANTERIOR_3
										  FROM    LDC_VALALTCA, LDC_TEMPPPAUD
										  WHERE   VAALANO= ANIO
										  AND     VAALMES = MES
										  AND     VAALCICL= CICLO';


                --- Verificacion Subsidio: --
                sbsentc4 :=
                       'SELECT
											  VEUCCICL  sesucicl,
											  VEUCANO  pefaano,
											  VEUCMES pefames,
											  VEUCSESU PRODUCTO,
											  VEUCVALO VALOR,
											  VEUCSUCA SUBCATEGORIA,
											  utl_raw.cast_to_varchar2(nlssort(VEUCOBSE, ''nls_sort=binary_ai''))  OBSERVACION
										  FROM    LDC_VECSUCFC, LDC_TEMPPPAUD
										  WHERE   VEUCANO= ANIO
										  AND     VEUCMES = MES
										  AND     VEUCCICL= CICLO
										  AND     VECSCONC=  '
                    || 196
                    || ' -- Subsidio';


                --- Verificacion Cargos Fijo: --
                sbsentc5 :=
                       'SELECT
												VEUCCICL  sesucicl,
												VEUCANO  pefaano,
												VEUCMES pefames,
												VEUCSESU PRODUCTO,
												VEUCVALO VALOR,
												VEUCSUCA SUBCATEGORIA,
												utl_raw.cast_to_varchar2(nlssort(VEUCOBSE, ''nls_sort=binary_ai''))  OBSERVACION
										  FROM    LDC_VECSUCFC, LDC_TEMPPPAUD
										  WHERE   VEUCANO= ANIO
										  AND     VEUCMES = MES
										  AND     VEUCCICL= CICLO
										  AND     VECSCONC= '
                    || 17
                    || ' -- Cargo Fijo';


                --- Verificacion contribuccion: --
                sbsentc6 :=
                       '  SELECT
												  VEUCCICL  sesucicl,
												  VEUCANO  pefaano,
												  VEUCMES pefames,
												  VEUCSESU PRODUCTO,
												  VEUCVALO VALOR,
												  VEUCSUCA SUBCATEGORIA,
												  utl_raw.cast_to_varchar2(nlssort(VEUCOBSE, ''nls_sort=binary_ai'')) OBSERVACION
											FROM    LDC_VECSUCFC, LDC_TEMPPPAUD
											WHERE   VEUCANO= ANIO
											AND     VEUCMES = MES
											AND     VEUCCICL= CICLO
											AND     VECSCONC= '
                    || 37
                    || ' -- Contribucion';


                --- Verificacion contribuccion: --
                sbsentc7 := '  SELECT
												   VECOCANT Cantidad,
												   VECOCICL sesucicl,
												   VECOMES pefames,
												   VECOANO pefaano
											FROM    LDC_VERICOMP, LDC_TEMPPPAUD
											WHERE   VECOANO= ANIO
											AND     VECOMES = MES
											AND     VECOCICL= CICLO';



                --- Verificacion de tarifas aplicadas incorrectamente[Consumo - Cargo Fijo]: --
                sbsentc8 :=
                    ' SELECT
												  VAAASESU PRODUCTO,
												  VAAATAAP Tarifa_Aplicada,
												  VAAATACO tarifa_concepto,
												  VAAAVALO VALOR_CARGO,
												  VAAAUNID  MT3,
												  utl_raw.cast_to_varchar2(nlssort(VAAAMERE, ''nls_sort=binary_ai''))  MERCADORELEVANTE,
												  utl_raw.cast_to_varchar2(nlssort(VAAACATE, ''nls_sort=binary_ai''))  CATEGORIA,
												  utl_raw.cast_to_varchar2(nlssort(VAAASUCA, ''nls_sort=binary_ai'')) SUBCATEGORIA,
												  utl_raw.cast_to_varchar2(nlssort(VAAACONC, ''nls_sort=binary_ai''))  CONCEPTO,
												  VAAAFEIN  FECHA_INICIAL,
												  VAAAFEFI   FECHA_FINAL,
												  VAAARANG  RANGO,
												  VAAAVATA  VALOR_TARIFA,
												  VAAAVALI  VALOR_LIQUI,
												  VAAADIFE  diferencia
										   FROM   LDC_VATAAPI, LDC_TEMPPPAUD
										   WHERE   VAAAANO = ANIO
										   AND     VAAAMES = MES
										   AND     VAAACICL= CICLO';


                --- Verificacion Facturacion serv. 7053:  --
                sbsentc9 := 'select
											  VEFASESU Producto,
											  VEFACANT cant
									  FROM LDC_VERIFASE, LDC_TEMPPPAUD
									  WHERE   VEFAANO  = ANIO
									  AND     VEFAMES  = MES
									  AND     VEFACICL = CICLO';

                ----------------------------------------------------------------------------------------
                -- Finaliza Bloque se sentencias
                ----------------------------------------------------------------------------------------

                -- se concatenan los nombres de las hojas del documento de excel
                sbNomHoja :=
                       'Cargos Dobles'
                    || '|'
                    || 'Consumos Altos'
                    || '|'
                    || 'Valores Altos Cargos'
                    || '|'
                    || 'Verificacion Subsidio'
                    || '|'
                    || 'Verificacion Cargos Fijo'
                    || '|'
                    || 'Verificacion contribuccion'
                    || '|'
                    || 'Verificacion compensacion'
                    || '|'
                    || 'Verificacion de tarifas aplicadas incorrectamente[Consumo - Cargo Fijo]'
                    || '|'
                    || 'Verificacion Facturacion serv_7053';

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

                IF sbEmailNoti IS NOT NULL
                THEN
                    FOR item IN cuEmails (sbEmailNoti, ',')
                    LOOP
                        BEGIN
                            pkg_Correo.prcEnviaCorreo (
                                isbRemitente       => sbRemitente,
                                isbDestinatarios   => TRIM (item.COLUMN_VALUE),
                                isbAsunto          => sb_subject,
                                isbMensaje         =>
                                       sb_text_msg
                                    || ' de los ciclos ['
                                    || sbCiclProc
                                    || ']'
                                    || '<br>'
                                    || ' Nombre archivo:'
                                    || sbNomArch
                                    || '.xls, esta ubicado en la ruta: '
                                    || sbruta
                                    || '');
                        EXCEPTION
                            WHEN OTHERS
                            THEN
                                NULL;
                        END;
                    END LOOP;
                END IF;
            ELSE
                FOR regDep IN cugetdepartamento
                LOOP
                    ----------------------------------------------------------------------------------------
                    -- Bloque se sentencias
                    ----------------------------------------------------------------------------------------
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
                           'Repo_Audi_Post_Depa_'
                        || regDep.description
                        || '_'
                        || sbCiclProc
                        || '_'
                        || TO_CHAR (SYSDATE, 'DDMMYYYY_HH24MISS');
                    --- Cargos Dobles: --
                    sbsentc1 := 'SELECT
											  CADOCICL CICLO,
											  CADOSESU  PRODUCTO,
											  CADOCONC CONCEPTO,
											  CADOCACA CAUSAL,
											  CADOSIGN SIGNO,
											  CADOCANT  CANTIDAD,
											  CADOVALO VALOR
									 FROM	LDC_CARGDOBL, LDC_TEMPPPAUD,
												  pr_product p,
												  ab_address d,
												  GE_GEOGRA_LOCATION l
									 WHERE CADOANO = ANIO
										  AND CADOMES = MES
										  AND CADOCICL= CICLO
										  and CADOSESU = p.product_id
										  and p.address_id = d.address_id
										  and L.GEOGRAP_LOCATION_ID = D.GEOGRAP_LOCATION_ID
										  and L.GEO_LOCA_FATHER_ID =  ' || regDep.depa;


                    --- Consumos Altos --
                    sbsentc2 := 'SELECT
												  COALCICL CICLO,
												  COALSESU PRODUCTO,
												  COALCATE CATEGORIA,
												  COALSUCA SUBCATEGORIA,
												  COALPEFA  PEFACODI   ,
												  COALCATE   sesucate,
												  nvl(COALCOPR,0) PROMEDIO,
												  nvl(COALCOAC,0) CONSUMO_ACTUAL,
												  nvl(COALCOAN,0)  CONSUMO_ANTERIOR_1,
												  nvl(COALCOAS,0) CONSUMO_ANTERIOR_2,
												  nvl(COALCOAT,0) CONSUMO_ANTERIOR_3,
												  coalregl regla
										  FROM    LDC_CONSUALTO, LDC_TEMPPPAUD,
												  pr_product p,
												  ab_address d,
												  GE_GEOGRA_LOCATION l
										  WHERE   COALANO= ANIO
										  AND     COALMES = MES
										  AND     COALCICL= CICLO
										  and COALSESU = p.product_id
											and p.address_id = d.address_id
											and L.GEOGRAP_LOCATION_ID = D.GEOGRAP_LOCATION_ID
											and L.GEO_LOCA_FATHER_ID =  ' || regDep.depa;


                    --- Valores Altos Cargos: --
                    sbsentc3 :=
                           'SELECT
												  VAALCICL CICLO,
												  VAALSESU PRODUCTO,
												  VAALSERV SERVICIO,
												  VAALCONC CONCEPTO,
												  VAALSIGN SIGNO,
												  VAALCATE CATEGORIA,
												  VAALSUCA SUBCATEGORIA,
												  VAALDOSO DOCUMENTO,
												  VAALVALO VALOR,
												  VAALCACA CAUSA_CARGO,
												  utl_raw.cast_to_varchar2(nlssort(pktblcauscarg.fsbgetdescription(VAALCACA), ''nls_sort=binary_ai''))  DESCRIPCION_CAUSA,
												  nvl(VAALCOPR,0)  PROMEDIO,
												  nvl(VAALCOAC,0)  CONSUMO_ACTUAL,
												  nvl( VAALCOAN,0)  CONSUMO_ANTERIOR_1,
												  nvl(VAALCOAS,0) CONSUMO_ANTERIOR_2,
												  nvl(VAALCOAT,0) CONSUMO_ANTERIOR_3
										  FROM    LDC_VALALTCA, LDC_TEMPPPAUD,
												  pr_product p,
												  ab_address d,
												  GE_GEOGRA_LOCATION l
										  WHERE   VAALANO= ANIO
										  AND     VAALMES = MES
										  AND     VAALCICL= CICLO
										  and VAALSESU = p.product_id
											and p.address_id = d.address_id
											and L.GEOGRAP_LOCATION_ID = D.GEOGRAP_LOCATION_ID
											and L.GEO_LOCA_FATHER_ID = '
                        || regDep.depa;


                    --- Verificacion Subsidio: --
                    sbsentc4 :=
                           'SELECT
											  VEUCCICL  sesucicl,
											  VEUCANO  pefaano,
											  VEUCMES pefames,
											  VEUCSESU PRODUCTO,
											  VEUCVALO VALOR,
											  VEUCSUCA SUBCATEGORIA,
											  utl_raw.cast_to_varchar2(nlssort(VEUCOBSE, ''nls_sort=binary_ai'')) OBSERVACION
										  FROM    LDC_VECSUCFC, LDC_TEMPPPAUD,
												  pr_product p,
												  ab_address d,
												  GE_GEOGRA_LOCATION l
										  WHERE   VEUCANO= ANIO
										  AND     VEUCMES = MES
										  AND     VEUCCICL= CICLO
										  AND     VECSCONC=  '
                        || 196
                        || ' -- Subsidio
										  and VEUCSESU = p.product_id
											and p.address_id = d.address_id
											and L.GEOGRAP_LOCATION_ID = D.GEOGRAP_LOCATION_ID
											and L.GEO_LOCA_FATHER_ID = '
                        || regDep.depa;


                    --- Verificacion Cargos Fijo: --
                    sbsentc5 :=
                           'SELECT
												VEUCCICL  sesucicl,
												VEUCANO  pefaano,
												VEUCMES pefames,
												VEUCSESU PRODUCTO,
												VEUCVALO VALOR,
												VEUCSUCA SUBCATEGORIA,
												utl_raw.cast_to_varchar2(nlssort(VEUCOBSE, ''nls_sort=binary_ai'')) OBSERVACION
										  FROM    LDC_VECSUCFC, LDC_TEMPPPAUD,
												  pr_product p,
												  ab_address d,
												  GE_GEOGRA_LOCATION l
										  WHERE   VEUCANO= ANIO
										  AND     VEUCMES = MES
										  AND     VEUCCICL= CICLO
										  AND     VECSCONC= '
                        || 17
                        || ' -- Cargo Fijo
										  and VEUCSESU = p.product_id
											and p.address_id = d.address_id
											and L.GEOGRAP_LOCATION_ID = D.GEOGRAP_LOCATION_ID
											and L.GEO_LOCA_FATHER_ID =  '
                        || regDep.depa;


                    --- Verificacion contribuccion: --
                    sbsentc6 :=
                           '  SELECT
												  VEUCCICL  sesucicl,
												  VEUCANO  pefaano,
												  VEUCMES pefames,
												  VEUCSESU PRODUCTO,
												  VEUCVALO VALOR,
												  VEUCSUCA SUBCATEGORIA,
												  utl_raw.cast_to_varchar2(nlssort(VEUCOBSE, ''nls_sort=binary_ai''))  OBSERVACION
											FROM    LDC_VECSUCFC, LDC_TEMPPPAUD,
												  pr_product p,
												  ab_address d,
												  GE_GEOGRA_LOCATION l
											WHERE   VEUCANO= ANIO
											AND     VEUCMES = MES
											AND     VEUCCICL= CICLO
											AND     VECSCONC= '
                        || 37
                        || ' -- Contribucion
											and VEUCSESU = p.product_id
											and p.address_id = d.address_id
											and L.GEOGRAP_LOCATION_ID = D.GEOGRAP_LOCATION_ID
											and L.GEO_LOCA_FATHER_ID = '
                        || regDep.depa;


                    --- Verificacion contribuccion: --
                    sbsentc7 := '  SELECT
												   VECOCANT Cantidad,
												   VECOCICL sesucicl,
												   VECOMES pefames,
												   VECOANO pefaano
											FROM    LDC_VERICOMP, LDC_TEMPPPAUD, ldc_cicldepa cd
											WHERE   VECOANO= ANIO
											AND     VECOMES = MES
											AND     VECOCICL= CICLO
											and    CICLO = cd.CICLCODI
									        and cd.CICLDEPA = ' || regDep.depa;



                    --- Verificacion de tarifas aplicadas incorrectamente[Consumo - Cargo Fijo]: --
                    sbsentc8 :=
                           ' SELECT
												  VAAASESU PRODUCTO,
												  VAAATAAP Tarifa_Aplicada,
												  VAAATACO tarifa_concepto,
												  VAAAVALO VALOR_CARGO,
												  VAAAUNID  MT3,
												  utl_raw.cast_to_varchar2(nlssort(VAAAMERE, ''nls_sort=binary_ai''))   MERCADORELEVANTE,
												  utl_raw.cast_to_varchar2(nlssort(VAAACATE, ''nls_sort=binary_ai''))  CATEGORIA,
												  utl_raw.cast_to_varchar2(nlssort(VAAASUCA, ''nls_sort=binary_ai''))  SUBCATEGORIA,
												  utl_raw.cast_to_varchar2(nlssort(VAAACONC, ''nls_sort=binary_ai''))   CONCEPTO,
												  VAAAFEIN  FECHA_INICIAL,
												  VAAAFEFI   FECHA_FINAL,
												  VAAARANG  RANGO,
												  VAAAVATA  VALOR_TARIFA,
												  VAAAVALI  VALOR_LIQUI,
												  VAAADIFE  diferencia
										   FROM   LDC_VATAAPI, LDC_TEMPPPAUD,
												  pr_product p,
												  ab_address d,
												  GE_GEOGRA_LOCATION l
										   WHERE   VAAAANO = ANIO
										   AND     VAAAMES = MES
										   AND     VAAACICL= CICLO
										   and VAAASESU = p.product_id
										  and p.address_id = d.address_id
										  and L.GEOGRAP_LOCATION_ID = D.GEOGRAP_LOCATION_ID
										  and L.GEO_LOCA_FATHER_ID = '
                        || regDep.depa;


                    --- Verificacion Facturacion serv. 7053:  --
                    sbsentc9 := 'select
											  VEFASESU Producto,
											  VEFACANT cant
									  FROM LDC_VERIFASE, LDC_TEMPPPAUD,
												  pr_product p,
												  ab_address d,
												  GE_GEOGRA_LOCATION l
									  WHERE   VEFAANO  = ANIO
									  AND     VEFAMES  = MES
									  AND     VEFACICL = CICLO
									  and VEFASESU = p.product_id
									  and p.address_id = d.address_id
									  and L.GEOGRAP_LOCATION_ID = D.GEOGRAP_LOCATION_ID
									  and L.GEO_LOCA_FATHER_ID = ' || regDep.depa;

                    ----------------------------------------------------------------------------------------
                    -- Finaliza Bloque se sentencias
                    ----------------------------------------------------------------------------------------

                    -- se concatenan los nombres de las hojas del documento de excel
                    sbNomHoja :=
                           'Cargos Dobles'
                        || '|'
                        || 'Consumos Altos'
                        || '|'
                        || 'Valores Altos Cargos'
                        || '|'
                        || 'Verificacion Subsidio'
                        || '|'
                        || 'Verificacion Cargos Fijo'
                        || '|'
                        || 'Verificacion contribuccion'
                        || '|'
                        || 'Verificacion compensacion'
                        || '|'
                        || 'Verificacion de tarifas aplicadas incorrectamente[Consumo - Cargo Fijo]'
                        || '|'
                        || 'Verificacion Facturacion serv_7053';

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
                            BEGIN
                                pkg_Correo.prcEnviaCorreo (
                                    isbRemitente   => sbRemitente,
                                    isbDestinatarios   => TRIM (item.COLUMN_VALUE),
                                    isbAsunto      => sb_subject,
                                    isbMensaje     =>
                                           sb_text_msg
                                        || ' de los ciclos ['
                                        || sbCiclProc
                                        || ']'
                                        || '<br>'
                                        || ' Nombre archivo:'
                                        || sbNomArch
                                        || '.xls, esta ubicado en la ruta: '
                                        || sbruta
                                        || '');
                            EXCEPTION
                                WHEN OTHERS
                                THEN
                                    NULL;
                            END;
                        END LOOP;
                    END IF;
                END LOOP;
            END IF;

            DELETE FROM
                LDC_CARGAUPO
                  WHERE (anio, mes, ciclo) IN
                            (SELECT anio, mes, ciclo FROM ldc_tempppaud);

            COMMIT;

            nuIndJob := SEQ_CARGAUPO.NEXTVAL;

            --se realizan cargos a la -1
            OPEN cugetCargos;

            LOOP
                FETCH cugetCargos BULK COLLECT INTO v_tbCargos LIMIT 100;

                FORALL i IN 1 .. v_tbCargos.COUNT SAVE EXCEPTIONS
                    INSERT INTO LDC_CARGAUPO
                         VALUES v_tbCargos (i);

                COMMIT;
                EXIT WHEN cugetCargos%NOTFOUND;
            END LOOP;

            CLOSE cugetCargos;

            COMMIT;

            IF sbEmailNoti IS NOT NULL
            THEN
                FOR item IN cuEmails (sbEmailNoti, ',')
                LOOP
                    BEGIN
                        pkg_Correo.prcEnviaCorreo (
                            isbRemitente       => sbRemitente,
                            isbDestinatarios   => TRIM (item.COLUMN_VALUE),
                            isbAsunto          =>
                                'Proceso de Cargos a la -1 Hecho',
                            isbMensaje         =>
                                   'Se realizo el reporte de Cargos a la -1 de forma correcta con el nombre: '
                                || NomArchCarg
                                || '.xls, esta ubicado en la ruta: '
                                || sbruta
                                || '<br>'
                                || ' para los ciclos ['
                                || sbCiclProcAtla
                                || ','
                                || sbCiclProcMagd
                                || ','
                                || sbCiclProcCesar
                                || ']');
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            NULL;
                    END;
                END LOOP;
            END IF;

            BEGIN
                pkg_Correo.prcEnviaCorreo (
                    isbRemitente       => sbRemitente,
                    isbDestinatarios   => 'innovacionbi@gascaribe.com',
                    isbAsunto          =>
                        'Proceso de Cargos a la -1 Terminado con Exito',
                    isbMensaje         => nuIndJob);
            EXCEPTION
                WHEN OTHERS
                THEN
                    NULL;
            END;
        END IF;
    END IF;

    ldc_proactualizaestaprog (nutsess,
                              sbMensError,
                              'LDC_PRGAPYCAR',
                              'Ok');

    pkg_traza.trace (csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR
    THEN
        pkg_Error.getError (coderror, sbmessage);

        ldc_proactualizaestaprog (nutsess,
                                  sbmessage,
                                  'LDC_PRGAPYCAR-' || nuCiclo,
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
                                  'LDC_PRGAPYCAR-' || nuCiclo,
                                  'Termino con error');

        proUpdCodperfact (nuPeriodoAux, 'P'); -- se actualiza el periodo que presento el error
        ROLLBACK;
        RAISE pkg_Error.CONTROLLED_ERROR;
END LDC_PRGAPYCAR;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRGAPYCAR', 'ADM_PERSON');
END;
/

