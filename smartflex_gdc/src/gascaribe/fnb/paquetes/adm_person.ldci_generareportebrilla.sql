CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_GENERAREPORTEBRILLA
AS
    PROCEDURE LDRIRBRI;

END LDCI_GENERAREPORTEBRILLA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_GENERAREPORTEBRILLA
AS



    PROCEDURE LDRIRBRI
    IS

    cnuNULL_ATTRIBUTE constant number := 2126;
    sbPath            ge_boInstanceControl.stysbValue;
    ufArchivo         utl_file.file_type;
    sbFileName        varchar2(200);
    sbLinea           varchar2(32000);
    sw                number;

    sbano             ge_boInstanceControl.stysbValue;
    sbmes             ge_boInstanceControl.stysbValue;
    sbciclo           ge_boInstanceControl.stysbValue;
    sbreporte         ge_boInstanceControl.stysbValue;
    sbruta            ge_boInstanceControl.stysbValue;

    CURSOR cuFinancia
    (
           nuano      IN  NUMBER,
           numes      IN  NUMBER,
           nucontrato IN  NUMBER
    )
    IS
    SELECT /*+ RULE */
           SF.SUBSCRIPTION_ID, SF.QUOTAS_NUMBER, SF.VALUE_TO_FINANCE, SF.QUOTA_VALUE, SF.RECORD_DATE
           FROM OPEN.CC_FINANCING_REQUEST SF, OPEN.LDC_CIERCOME LC
           WHERE SF.SUBSCRIPTION_ID = nucontrato
           AND SF.RECORD_DATE BETWEEN LC.CICOFEIN AND LC.CICOFECH
           AND LC.CICOANO = nuano
           AND LC.CICOMES = numes
           AND EXISTS (SELECT 'X' FROM OPEN.DIFERIDO DF
                                  WHERE DF.DIFESUSC = SF.SUBSCRIPTION_ID
                                  AND DF.DIFEFEIN BETWEEN LC.CICOFEIN AND LC.CICOFECH
                                  AND DF.DIFECONC IN (30,19))
           AND SF.FINANCING_REQUEST_ID = (SELECT MAX(SF1.FINANCING_REQUEST_ID)
                                                 FROM OPEN.CC_FINANCING_REQUEST SF1, OPEN.LDC_CIERCOME LC1
                                                 WHERE SF1.SUBSCRIPTION_ID = SF.SUBSCRIPTION_ID
                                                 AND SF1.RECORD_DATE BETWEEN LC1.CICOFEIN AND LC1.CICOFECH
                                                 AND LC1.CICOANO = nuano
                                                 AND LC1.CICOMES = numes
                                                 AND EXISTS (SELECT 'X' FROM OPEN.DIFERIDO DF1
                                                                        WHERE DF1.DIFESUSC = SF1.SUBSCRIPTION_ID
                                                                        AND DF1.DIFEFEIN BETWEEN LC1.CICOFEIN AND LC1.CICOFECH
                                                                        AND DF1.DIFECONC IN (30,19)));

    CURSOR cuMoraMax
    (
           nuServicio IN  NUMBER,
           nuProducto IN  NUMBER,
           nuano      IN  NUMBER,
           numes      IN  NUMBER
    )
    IS
    SELECT SC.EDAD FROM OPEN.LDC_OSF_SESUCIER SC
                   WHERE SC.TIPO_PRODUCTO = nuServicio
                   AND SC.NUANO = nuano
                   AND SC.NUMES = numes
                   AND SC.PRODUCTO = nuProducto
                   AND ROWNUM = 1;

    CURSOR cuConsumo
    (
           nuProducto IN  NUMBER,
           nuano      IN  NUMBER,
           numes      IN  NUMBER,
           nuCiclo    IN  NUMBER
    )
    IS
    SELECT SUM(CN.COSSCOCA) CONSUMO_GAS
           FROM OPEN.CONSSESU CN
           WHERE CN.COSSSESU = nuProducto
           AND CN.COSSFLLI = 'S'
           AND CN.COSSPEFA = (SELECT PF.PEFACODI
                                     FROM OPEN.PERIFACT PF
                                     WHERE PF.PEFAANO = nuano
                                     AND PF.PEFAMES = numes
                                     AND PF.PEFACICL = nuCiclo);

    CURSOR cuRefi
    (
           nuProducto IN  NUMBER,
           nuServicio IN  NUMBER
    )
    IS
    SELECT DECODE(COUNT(1),0,'NO','SI') RFGAS
           FROM OPEN.DIFERIDO DF2
           WHERE DF2.DIFEPROG = 'GCNED'
           AND DF2.DIFENUSE = nuProducto
           AND nuServicio = 7014;

    CURSOR cuEstado
    (
           nuProducto IN  NUMBER
    )
    IS
    SELECT EP.PRODUCT_STATUS_ID||' - '||EP.DESCRIPTION ESTADO_SERVICIO
            FROM OPEN.PS_PRODUCT_STATUS EP WHERE EP.PRODUCT_STATUS_ID = OPEN.dapr_product.fnugetproduct_status_id(nuProducto);

    CURSOR cuFechaCupo
    (
           nucontrato IN  NUMBER
    )
    IS
    SELECT HQ.REGISTER_DATE FECHACUPO
                   FROM OPEN.LD_QUOTA_HISTORIC HQ
                   WHERE HQ.SUBSCRIPTION_ID = nucontrato
                   AND HQ.RESULT = 'Y'
                   AND HQ.QUOTA_HISTORIC_ID = (SELECT MIN(HQ1.QUOTA_HISTORIC_ID)
                                                      FROM OPEN.LD_QUOTA_HISTORIC HQ1
                                                      WHERE HQ1.SUBSCRIPTION_ID = HQ.SUBSCRIPTION_ID
                                                      AND HQ1.RESULT = 'Y');

    CURSOR cuCupoAsignado
    (
           nucontrato IN  NUMBER
    )
    IS
    SELECT CB.QUOTA_VALUE CUPO FROM OPEN.LD_QUOTA_BY_SUBSC CB WHERE CB.SUBSCRIPTION_ID = nucontrato;

    CURSOR cuSinCupo
    (
           nuCiclo      IN  NUMBER
    )
    IS
    SELECT /*+ RULE */
           SU.SUSCCODI CONTRATO,
           SS.SESUNUSE PRODUCTO,
           L.GEOGRAP_LOCATION_ID||' - '||L.DESCRIPTION LOCALIDAD,
           (SELECT K.SUCADESC FROM OPEN.SUBCATEG K WHERE K.SUCACATE = SS.SESUCATE AND K.SUCACODI = SS.SESUSUCA) ESTRATO,
           TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE),TRUNC(SS.SESUFEIN))) ANTIGUEDAD_SERVICIO,
           DECODE(SS.SESUESFN,'C','SI','NO') CASTIGO_GAS,
           SS.SESUSERV,
           SS.SESUCICL
    FROM OPEN.SUSCRIPC SU,
         OPEN.SERVSUSC SS,
         OPEN.AB_ADDRESS B,
         OPEN.GE_GEOGRA_LOCATION L
    WHERE SS.SESUSUSC = SU.SUSCCODI
    AND B.ADDRESS_ID = SU.SUSCIDDI
    AND L.GEOGRAP_LOCATION_ID = B.GEOGRAP_LOCATION_ID
    AND NOT EXISTS (SELECT 'X' FROM OPEN.LD_QUOTA_BY_SUBSC CP
                               WHERE CP.SUBSCRIPTION_ID = SU.SUSCCODI
                               AND CP.QUOTA_VALUE > 0)
    AND SS.SESUCICL = DECODE(nuCiclo,-1,SS.SESUCICL,nuCiclo);

    CURSOR cuConCupo
    (
           nuCiclo      IN  NUMBER
    )
    IS
    SELECT /*+ RULE */
           SU.SUSCCODI CONTRATO,
           SS.SESUNUSE PRODUCTO,
           L.GEOGRAP_LOCATION_ID||' - '||L.DESCRIPTION LOCALIDAD,
           (SELECT K.SUCADESC FROM OPEN.SUBCATEG K WHERE K.SUCACATE = SS.SESUCATE AND K.SUCACODI = SS.SESUSUCA) ESTRATO,
           TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE),TRUNC(SS.SESUFEIN))) ANTIGUEDAD_SERVICIO,
           DECODE(SS.SESUESFN,'C','SI','NO') CASTIGO_GAS,
           SS.SESUSERV,
           SS.SESUCICL
    FROM OPEN.SUSCRIPC SU,
         OPEN.SERVSUSC SS,
         OPEN.AB_ADDRESS B,
         OPEN.GE_GEOGRA_LOCATION L
    WHERE SS.SESUSUSC = SU.SUSCCODI
    AND B.ADDRESS_ID = SU.SUSCIDDI
    AND L.GEOGRAP_LOCATION_ID = B.GEOGRAP_LOCATION_ID
    AND EXISTS (SELECT 'X' FROM OPEN.LD_QUOTA_BY_SUBSC CP
                           WHERE CP.SUBSCRIPTION_ID = SU.SUSCCODI
                           AND CP.QUOTA_VALUE > 0)
    AND SS.SESUCICL = DECODE(nuCiclo,-1,SS.SESUCICL,nuCiclo);

    type tytbDada1 IS table of cuSinCupo%rowtype index BY binary_integer;
    type tytbDada2 IS table of cuConCupo%rowtype index BY binary_integer;

    tbData1      tytbDada1;
    tbData2      tytbDada2;

    rcFinancia     cuFinancia%rowtype;
    rcMoraMax      cuMoraMax%rowtype;
    rcConsumo      cuConsumo%rowtype;
    rcRefi         cuRefi%rowtype;
    rcEstado       cuEstado%rowtype;
    rcFechaCupo    cuFechaCupo%rowtype;
    rcCupoAsignado cuCupoAsignado%rowtype;



    BEGIN
--        ut_trace.init;
--        ut_trace.setlevel(99);
        ut_trace.trace('INICIA LDCI_GeneraReporteBrilla.LDRIRBRI', 15);

        sbano := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAANO');
        sbmes := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAMES');
        sbciclo := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFACICL');
        sbreporte := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFACODI');
        sbruta := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAOBSE');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        if (sbano is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'A?o');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbmes is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Mes');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbciclo is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Ciclo');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbreporte is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Reporte');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbruta is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Ruta');
            raise ex.CONTROLLED_ERROR;
        end if;

        sbPath      := OPEN.DALD_PARAMETER.fsbGetValue_Chain('RutaRepoBrilla');--DAGE_DIRECTORY.fsbgetpath(sbruta);

        --Reporte contratos sin cupo brilla:
        IF sbreporte = 1 THEN

           sbFileName  := 'Repo_ContratoSinBrilla_'||to_char(sysdate,'YYYY')||'_'||to_char(sysdate,'MM')||'.csv';
           ufArchivo   := utl_file.Fopen(sbPath, sbFileName,'A', 5000);

           sbLinea := 'CONTRATO|PRODUCTO|LOCALIDAD|ESTRATO|ANTIGUEDAD_SERVICIO|PERIODO_FINANCIADO|MONTO_FINANCIADO|VALOR_CUOTA|'||
                      'FECHA_INICIAL_FINANCIACION|MORA_MAX_FINANCIACION_CONEX|HABITO_PAGO|CONSUMO_GAS|REFINANCIACION_GAS|CASTIGO_GAS|ESTADO_SERVICIO';

           utl_file.put_line( ufArchivo, sbLinea );
           sbLinea := null;

           OPEN  cuSinCupo(sbciclo);
           LOOP

             tbData1.delete;
             FETCH cuSinCupo BULK COLLECT INTO tbData1 LIMIT 700;
             FOR nuIndex IN tbData1.first..tbData1.last LOOP
                 sbLinea := tbData1(nuIndex).CONTRATO||'|'||
                            tbData1(nuIndex).PRODUCTO||'|'||
                            tbData1(nuIndex).LOCALIDAD||'|'||
                            tbData1(nuIndex).ESTRATO||'|'||
                            tbData1(nuIndex).ANTIGUEDAD_SERVICIO||'|';

                 sw      := 0;
                 IF(cuFinancia%ISOPEN)THEN
                     CLOSE cuFinancia;
                 END IF;

                 OPEN  cuFinancia(sbano,sbmes,tbData1(nuIndex).CONTRATO);

                 FETCH cuFinancia INTO rcFinancia;
                 LOOP
                       sbLinea := sbLinea||rcFinancia.Quotas_Number||'|'||
                                           rcFinancia.Value_To_Finance||'|'||
                                           rcFinancia.Quota_Value||'|'||
                                           rcFinancia.Record_Date||'|';
                       sw      := 1;
                 FETCH cuFinancia INTO rcFinancia;
                 EXIT WHEN (cuFinancia%notfound);
                 END LOOP;

                 CLOSE cuFinancia;
                 IF sw = 0 THEN
                       sbLinea := sbLinea||NULL||'|'||
                                           NULL||'|'||
                                           NULL||'|'||
                                           NULL||'|';
                 END IF;

                 ------------------------------
                 sw      := 0;
                 IF(cuMoraMax%ISOPEN)THEN
                     CLOSE cuMoraMax;
                 END IF;

                 OPEN  cuMoraMax(tbData1(nuIndex).SESUSERV,tbData1(nuIndex).PRODUCTO,sbano,sbmes);

                 FETCH cuMoraMax INTO rcMoraMax;
                 LOOP
                       sbLinea := sbLinea||rcMoraMax.Edad||'|';
                       sw      := 1;
                 FETCH cuMoraMax INTO rcMoraMax;
                 EXIT WHEN (cuMoraMax%notfound);
                 END LOOP;

                 CLOSE cuMoraMax;
                 IF sw = 0 THEN
                       sbLinea := sbLinea||NULL||'|';
                 END IF;

                 -------------------------------
                 sbLinea := sbLinea||OPEN.LDC_REPORTESCONSULTA.fnuHabitoPago(tbData1(nuIndex).PRODUCTO,tbData1(nuIndex).CONTRATO,tbData1(nuIndex).SESUSERV,sbano,sbmes)||'|';

                 -------------------------------
                 sw      := 0;
                 IF(cuConsumo%ISOPEN)THEN
                     CLOSE cuConsumo;
                 END IF;

                 OPEN  cuConsumo(tbData1(nuIndex).PRODUCTO,sbano,sbmes,tbData1(nuIndex).SESUCICL);

                 FETCH cuConsumo INTO rcConsumo;
                 LOOP
                       sbLinea := sbLinea||rcConsumo.Consumo_Gas||'|';
                       sw      := 1;
                 FETCH cuConsumo INTO rcConsumo;
                 EXIT WHEN (cuConsumo%notfound);
                 END LOOP;

                 CLOSE cuConsumo;
                 IF sw = 0 THEN
                       sbLinea := sbLinea||NULL||'|';
                 END IF;

                 -------------------------------
                 sw      := 0;
                 IF(cuRefi%ISOPEN)THEN
                     CLOSE cuRefi;
                 END IF;

                 OPEN  cuRefi(tbData1(nuIndex).PRODUCTO,tbData1(nuIndex).SESUSERV);

                 FETCH cuRefi INTO rcRefi;
                 LOOP
                       sbLinea := sbLinea||rcRefi.Rfgas||'|';
                       sw      := 1;
                 FETCH cuRefi INTO rcRefi;
                 EXIT WHEN (cuRefi%notfound);
                 END LOOP;

                 CLOSE cuRefi;
                 IF sw = 0 THEN
                       sbLinea := sbLinea||NULL||'|';
                 END IF;

                 -------------------------------
                 sbLinea := sbLinea||tbData1(nuIndex).CASTIGO_GAS||'|';

                 -------------------------------
                 sw      := 0;
                 IF(cuEstado%ISOPEN)THEN
                     CLOSE cuEstado;
                 END IF;

                 OPEN  cuEstado(tbData1(nuIndex).PRODUCTO);

                 FETCH cuEstado INTO rcEstado;
                 LOOP
                       sbLinea := sbLinea||rcEstado.Estado_Servicio;
                       sw      := 1;
                 FETCH cuEstado INTO rcEstado;
                 EXIT WHEN (cuEstado%notfound);
                 END LOOP;

                 CLOSE cuEstado;
                 IF sw = 0 THEN
                       sbLinea := sbLinea||NULL;
                 END IF;

                 -------------------------------

                 utl_file.put_line( ufArchivo, sbLinea );
                 utl_file.fflush( ufArchivo);
                 sbLinea := NULL;

             END LOOP;

             EXIT WHEN (cuSinCupo%NOTFOUND);
           END LOOP;

           CLOSE cuSinCupo;
        END IF;

        --Reporte contratos con cupo brilla:
        IF sbreporte <> 1 THEN

           IF sbreporte = 2 THEN
              sbFileName  := 'Repo_ContratoBrillaSinUso_'||to_char(sysdate,'YYYY')||'_'||to_char(sysdate,'MM')||'.csv';
           END IF;

           IF sbreporte = 3 THEN
              sbFileName  := 'Repo_ContratoBrillaConUso_'||to_char(sysdate,'YYYY')||'_'||to_char(sysdate,'MM')||'.csv';
           END IF;

           ufArchivo   := utl_file.Fopen(sbPath, sbFileName,'A', 5000);

           IF sbreporte = 2 THEN
             sbLinea := 'CONTRATO|PRODUCTO|FECHA_ASIG_CUPO_BRILLA|CUPO_ASIGNADO|LOCALIDAD|ESTRATO|ANTIGUEDAD_SERVICIO|PERIODO_FINANCIADO|MONTO_FINANCIADO|VALOR_CUOTA|'||
                        'FECHA_INICIAL_FINANCIACION|MORA_MAX_FINANCIACION_CONEX|HABITO_PAGO|CONSUMO_GAS|REFINANCIACION_GAS|CASTIGO_GAS|ESTADO_SERVICIO';
           END IF;

           IF sbreporte = 3 THEN
             sbLinea := 'CONTRATO|PRODUCTO|FECHA_ASIG_CUPO_BRILLA|CUPO_ASIGNADO|CANTIDAD_COMPRAS_REALIZADAS|VALOR_COMPRAS_REALIZADAS|PRODUCTOS_ADQUIRIDOS|LOCALIDAD|ESTRATO|ANTIGUEDAD_SERVICIO|PERIODO_FINANCIADO|MONTO_FINANCIADO|VALOR_CUOTA|'||
                        'FECHA_INICIAL_FINANCIACION|MORA_MAX_FINANCIACION_CONEX|HABITO_PAGO|CONSUMO_GAS|REFINANCIACION_GAS|CASTIGO_GAS|ESTADO_SERVICIO';
           END IF;

           utl_file.put_line( ufArchivo, sbLinea );
           sbLinea := null;

           OPEN  cuConCupo(sbciclo);
           LOOP

             tbData2.delete;
             FETCH cuConCupo BULK COLLECT INTO tbData2 LIMIT 700;
             FOR nuIndex IN tbData2.first..tbData2.last LOOP

                 --Sin Usar
                 IF (sbreporte = 2) AND (OPEN.LDC_ReportesConsulta.fnuCupousado(tbData2(nuIndex).CONTRATO) = 0) THEN

                   sbLinea := tbData2(nuIndex).CONTRATO||'|'||
                              tbData2(nuIndex).PRODUCTO||'|';

                   ------------------------------
                   sw      := 0;
                   IF(cuFechaCupo%ISOPEN)THEN
                       CLOSE cuFechaCupo;
                   END IF;

                   OPEN  cuFechaCupo(tbData2(nuIndex).CONTRATO);

                   FETCH cuFechaCupo INTO rcFechaCupo;
                   LOOP
                         sbLinea := sbLinea||rcFechaCupo.Fechacupo||'|';
                         sw      := 1;
                   FETCH cuFechaCupo INTO rcFechaCupo;
                   EXIT WHEN (cuFechaCupo%notfound);
                   END LOOP;

                   CLOSE cuFechaCupo;
                   IF sw = 0 THEN
                         sbLinea := sbLinea||NULL||'|';
                   END IF;

                   ------------------------------
                   sw      := 0;
                   IF(cuCupoAsignado%ISOPEN)THEN
                       CLOSE cuCupoAsignado;
                   END IF;

                   OPEN  cuCupoAsignado(tbData2(nuIndex).CONTRATO);

                   FETCH cuCupoAsignado INTO rcCupoAsignado;
                   LOOP
                         sbLinea := sbLinea||rcCupoAsignado.Cupo||'|';
                         sw      := 1;
                   FETCH cuCupoAsignado INTO rcCupoAsignado;
                   EXIT WHEN (cuCupoAsignado%notfound);
                   END LOOP;

                   CLOSE cuCupoAsignado;
                   IF sw = 0 THEN
                         sbLinea := sbLinea||NULL||'|';
                   END IF;

                   ------------------------------
                   sbLinea := sbLinea||tbData2(nuIndex).LOCALIDAD||'|'||
                              tbData2(nuIndex).ESTRATO||'|'||
                              tbData2(nuIndex).ANTIGUEDAD_SERVICIO||'|';

                   ------------------------------
                   sw      := 0;
                   IF(cuFinancia%ISOPEN)THEN
                       CLOSE cuFinancia;
                   END IF;

                   OPEN  cuFinancia(sbano,sbmes,tbData2(nuIndex).CONTRATO);

                   FETCH cuFinancia INTO rcFinancia;
                   LOOP
                         sbLinea := sbLinea||rcFinancia.Quotas_Number||'|'||
                                             rcFinancia.Value_To_Finance||'|'||
                                             rcFinancia.Quota_Value||'|'||
                                             rcFinancia.Record_Date||'|';
                         sw      := 1;
                   FETCH cuFinancia INTO rcFinancia;
                   EXIT WHEN (cuFinancia%notfound);
                   END LOOP;

                   CLOSE cuFinancia;
                   IF sw = 0 THEN
                         sbLinea := sbLinea||NULL||'|'||
                                             NULL||'|'||
                                             NULL||'|'||
                                             NULL||'|';
                   END IF;

                   ------------------------------
                   sw      := 0;
                   IF(cuMoraMax%ISOPEN)THEN
                       CLOSE cuMoraMax;
                   END IF;

                   OPEN  cuMoraMax(tbData2(nuIndex).SESUSERV,tbData2(nuIndex).PRODUCTO,sbano,sbmes);

                   FETCH cuMoraMax INTO rcMoraMax;
                   LOOP
                         sbLinea := sbLinea||rcMoraMax.Edad||'|';
                         sw      := 1;
                   FETCH cuMoraMax INTO rcMoraMax;
                   EXIT WHEN (cuMoraMax%notfound);
                   END LOOP;

                   CLOSE cuMoraMax;
                   IF sw = 0 THEN
                         sbLinea := sbLinea||NULL||'|';
                   END IF;

                   -------------------------------
                   sbLinea := sbLinea||OPEN.LDC_REPORTESCONSULTA.fnuHabitoPago(tbData2(nuIndex).PRODUCTO,tbData2(nuIndex).CONTRATO,tbData2(nuIndex).SESUSERV,sbano,sbmes)||'|';

                   -------------------------------
                   sw      := 0;
                   IF(cuConsumo%ISOPEN)THEN
                       CLOSE cuConsumo;
                   END IF;

                   OPEN  cuConsumo(tbData2(nuIndex).PRODUCTO,sbano,sbmes,tbData2(nuIndex).SESUCICL);

                   FETCH cuConsumo INTO rcConsumo;
                   LOOP
                         sbLinea := sbLinea||rcConsumo.Consumo_Gas||'|';
                         sw      := 1;
                   FETCH cuConsumo INTO rcConsumo;
                   EXIT WHEN (cuConsumo%notfound);
                   END LOOP;

                   CLOSE cuConsumo;
                   IF sw = 0 THEN
                         sbLinea := sbLinea||NULL||'|';
                   END IF;

                   -------------------------------
                   sw      := 0;
                   IF(cuRefi%ISOPEN)THEN
                       CLOSE cuRefi;
                   END IF;

                   OPEN  cuRefi(tbData2(nuIndex).PRODUCTO,tbData2(nuIndex).SESUSERV);

                   FETCH cuRefi INTO rcRefi;
                   LOOP
                         sbLinea := sbLinea||rcRefi.Rfgas||'|';
                         sw      := 1;
                   FETCH cuRefi INTO rcRefi;
                   EXIT WHEN (cuRefi%notfound);
                   END LOOP;

                   CLOSE cuRefi;
                   IF sw = 0 THEN
                         sbLinea := sbLinea||NULL||'|';
                   END IF;

                   -------------------------------
                   sbLinea := sbLinea||tbData2(nuIndex).CASTIGO_GAS||'|';

                   -------------------------------
                   sw      := 0;
                   IF(cuEstado%ISOPEN)THEN
                       CLOSE cuEstado;
                   END IF;

                   OPEN  cuEstado(tbData2(nuIndex).PRODUCTO);

                   FETCH cuEstado INTO rcEstado;
                   LOOP
                         sbLinea := sbLinea||rcEstado.Estado_Servicio;
                         sw      := 1;
                   FETCH cuEstado INTO rcEstado;
                   EXIT WHEN (cuEstado%notfound);
                   END LOOP;

                   CLOSE cuEstado;
                   IF sw = 0 THEN
                         sbLinea := sbLinea||NULL;
                   END IF;

                   -------------------------------

                   utl_file.put_line( ufArchivo, sbLinea );
                   utl_file.fflush( ufArchivo);
                   sbLinea := NULL;

                 END IF;

                 --Con Uso
                 IF (sbreporte = 3) AND (OPEN.LDC_ReportesConsulta.fnuCupousado(tbData2(nuIndex).CONTRATO) > 0) THEN

                   sbLinea := tbData2(nuIndex).CONTRATO||'|'||
                              tbData2(nuIndex).PRODUCTO||'|';

                   ------------------------------
                   sw      := 0;
                   IF(cuFechaCupo%ISOPEN)THEN
                       CLOSE cuFechaCupo;
                   END IF;

                   OPEN  cuFechaCupo(tbData2(nuIndex).CONTRATO);

                   FETCH cuFechaCupo INTO rcFechaCupo;
                   LOOP
                         sbLinea := sbLinea||rcFechaCupo.Fechacupo||'|';
                         sw      := 1;
                   FETCH cuFechaCupo INTO rcFechaCupo;
                   EXIT WHEN (cuFechaCupo%notfound);
                   END LOOP;

                   CLOSE cuFechaCupo;
                   IF sw = 0 THEN
                         sbLinea := sbLinea||NULL||'|';
                   END IF;

                   ------------------------------
                   sw      := 0;
                   IF(cuCupoAsignado%ISOPEN)THEN
                       CLOSE cuCupoAsignado;
                   END IF;

                   OPEN  cuCupoAsignado(tbData2(nuIndex).CONTRATO);

                   FETCH cuCupoAsignado INTO rcCupoAsignado;
                   LOOP
                         sbLinea := sbLinea||rcCupoAsignado.Cupo||'|';
                         sw      := 1;
                   FETCH cuCupoAsignado INTO rcCupoAsignado;
                   EXIT WHEN (cuCupoAsignado%notfound);
                   END LOOP;

                   CLOSE cuCupoAsignado;
                   IF sw = 0 THEN
                         sbLinea := sbLinea||NULL||'|';
                   END IF;

                   ------------------------------
                   sbLinea := sbLinea||OPEN.LDC_REPORTESCONSULTA.fnuVentasBrillaCantidad(tbData2(nuIndex).CONTRATO)||'|'||
                              OPEN.LDC_REPORTESCONSULTA.fnuVentasBrillaTotales(tbData2(nuIndex).CONTRATO)||'|'||
                              OPEN.LDC_REPORTESCONSULTA.fnuVentasBrillaProductos(tbData2(nuIndex).CONTRATO)||'|'||
                              tbData2(nuIndex).LOCALIDAD||'|'||
                              tbData2(nuIndex).ESTRATO||'|'||
                              tbData2(nuIndex).ANTIGUEDAD_SERVICIO||'|';

                   ------------------------------
                   sw      := 0;
                   IF(cuFinancia%ISOPEN)THEN
                       CLOSE cuFinancia;
                   END IF;

                   OPEN  cuFinancia(sbano,sbmes,tbData2(nuIndex).CONTRATO);

                   FETCH cuFinancia INTO rcFinancia;
                   LOOP
                         sbLinea := sbLinea||rcFinancia.Quotas_Number||'|'||
                                             rcFinancia.Value_To_Finance||'|'||
                                             rcFinancia.Quota_Value||'|'||
                                             rcFinancia.Record_Date||'|';
                         sw      := 1;
                   FETCH cuFinancia INTO rcFinancia;
                   EXIT WHEN (cuFinancia%notfound);
                   END LOOP;

                   CLOSE cuFinancia;
                   IF sw = 0 THEN
                         sbLinea := sbLinea||NULL||'|'||
                                             NULL||'|'||
                                             NULL||'|'||
                                             NULL||'|';
                   END IF;

                   ------------------------------
                   sw      := 0;
                   IF(cuMoraMax%ISOPEN)THEN
                       CLOSE cuMoraMax;
                   END IF;

                   OPEN  cuMoraMax(tbData2(nuIndex).SESUSERV,tbData2(nuIndex).PRODUCTO,sbano,sbmes);

                   FETCH cuMoraMax INTO rcMoraMax;
                   LOOP
                         sbLinea := sbLinea||rcMoraMax.Edad||'|';
                         sw      := 1;
                   FETCH cuMoraMax INTO rcMoraMax;
                   EXIT WHEN (cuMoraMax%notfound);
                   END LOOP;

                   CLOSE cuMoraMax;
                   IF sw = 0 THEN
                         sbLinea := sbLinea||NULL||'|';
                   END IF;

                   -------------------------------
                   sbLinea := sbLinea||OPEN.LDC_REPORTESCONSULTA.fnuHabitoPago(tbData2(nuIndex).PRODUCTO,tbData2(nuIndex).CONTRATO,tbData2(nuIndex).SESUSERV,sbano,sbmes)||'|';

                   -------------------------------
                   sw      := 0;
                   IF(cuConsumo%ISOPEN)THEN
                       CLOSE cuConsumo;
                   END IF;

                   OPEN  cuConsumo(tbData2(nuIndex).PRODUCTO,sbano,sbmes,tbData2(nuIndex).SESUCICL);

                   FETCH cuConsumo INTO rcConsumo;
                   LOOP
                         sbLinea := sbLinea||rcConsumo.Consumo_Gas||'|';
                         sw      := 1;
                   FETCH cuConsumo INTO rcConsumo;
                   EXIT WHEN (cuConsumo%notfound);
                   END LOOP;

                   CLOSE cuConsumo;
                   IF sw = 0 THEN
                         sbLinea := sbLinea||NULL||'|';
                   END IF;

                   -------------------------------
                   sw      := 0;
                   IF(cuRefi%ISOPEN)THEN
                       CLOSE cuRefi;
                   END IF;

                   OPEN  cuRefi(tbData2(nuIndex).PRODUCTO,tbData2(nuIndex).SESUSERV);

                   FETCH cuRefi INTO rcRefi;
                   LOOP
                         sbLinea := sbLinea||rcRefi.Rfgas||'|';
                         sw      := 1;
                   FETCH cuRefi INTO rcRefi;
                   EXIT WHEN (cuRefi%notfound);
                   END LOOP;

                   CLOSE cuRefi;
                   IF sw = 0 THEN
                         sbLinea := sbLinea||NULL||'|';
                   END IF;

                   -------------------------------
                   sbLinea := sbLinea||tbData2(nuIndex).CASTIGO_GAS||'|';

                   -------------------------------
                   sw      := 0;
                   IF(cuEstado%ISOPEN)THEN
                       CLOSE cuEstado;
                   END IF;

                   OPEN  cuEstado(tbData2(nuIndex).PRODUCTO);

                   FETCH cuEstado INTO rcEstado;
                   LOOP
                         sbLinea := sbLinea||rcEstado.Estado_Servicio;
                         sw      := 1;
                   FETCH cuEstado INTO rcEstado;
                   EXIT WHEN (cuEstado%notfound);
                   END LOOP;

                   CLOSE cuEstado;
                   IF sw = 0 THEN
                         sbLinea := sbLinea||NULL;
                   END IF;

                   -------------------------------

                   utl_file.put_line( ufArchivo, sbLinea );
                   utl_file.fflush( ufArchivo);
                   sbLinea := NULL;

                 END IF;

             END LOOP;

             EXIT WHEN (cuConCupo%NOTFOUND);
           END LOOP;

           CLOSE cuConCupo;
        END IF;


        utl_file.fclose(ufArchivo);
        COMMIT;

        ut_trace.trace('FIN LDCI_GeneraReporteBrilla.LDRIRBRI', 15);

        EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END LDRIRBRI;

END LDCI_GENERAREPORTEBRILLA;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_GENERAREPORTEBRILLA', 'ADM_PERSON'); 
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_GENERAREPORTEBRILLA to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_GENERAREPORTEBRILLA to INTEGRADESA;
GRANT EXECUTE on ADM_PERSON.LDCI_GENERAREPORTEBRILLA to REXEREPORTES;
/
