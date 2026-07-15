set SERVEROUTPUT ON;
DECLARE
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
    

    PROCEDURE pObtenerConsumos
    (
        inuProd     in  number,
        inuTCon     in  number,
        inuPeco     in  number,
        inuCons     in  number,
        onuCorreg   out number,
        onuCalc     out number,
        onuFact     out number,
        orcConBase  out conssesu%rowtype
    )
    is

        CURSOR cuConsumoCalculado
        (
            inuProducto number,
            inuTipoCons number,
            inuPeriodo  number
        )
        IS
        SELECT
        COSSSESU,COSSTCON,COSSPEFA,
        COSSCOCA,COSSNVEC,COSSELME,
        COSSMECC,COSSFLLI,COSSPFCR,
        COSSDICO,COSSIDRE,COSSCMSS,
        COSSFERE,COSSFUFA,COSSCAVC,
        COSSFUNC,COSSPECS,COSSCONS,
        COSSFCCO
        FROM open.VW_CMPRODCONSUMPTIONS
        WHERE COSSSESU = inuProducto
        AND COSSTCON = inuTipoCons
        AND COSSPECS = inuPeriodo
        ORDER BY COSSFERE DESC;

        CURSOR cuConsumoFacturado
        (
            inuProducto number,
            inuTipoCons number,
            inuPeriodo  number
        )
        IS
        SELECT
        SUM(COSSCOCA) consumo
        FROM CONSSESU
        WHERE COSSSESU = inuProducto
        AND COSSMECC = 4
        AND cosstcon = inuTipoCons
        AND cosspecs = inuPeriodo;

        -- CURSOR para obtener lecturas por producto y tipos de consumo
        CURSOR cuConsumosVista
        (
            inuSesu number,
            inuTcon number,
            inuPeco number
        )
        IS
        SELECT cossread, (cossread-cosscoca) diferencia_1, (cosscoca-cossread) diferencia_2
        FROM open.VW_CMPRODCONSUMPTIONS
        WHERE COSSSESU = inuSesu
        AND COSSPECS = inuPeco
        AND cosstcon = inuTcon;

        rcConssesu      conssesu%rowtype;
        nuConsumoFact   conssesu.cosscoca%type;
        nuConsumoAct    conssesu.cosscoca%type;

        nuConsumoCalc   number := 0;
        nuConsumoUnid   number := 0;
        nuDiferencia1   number := 0;
        nuDiferencia2   number := 0;

        nuFacturadoFin  conssesu.cosscoca%type;
        nuCorregidoFin  conssesu.cosscoca%type;
        nuCalculadoFin  conssesu.cosscoca%type;

    BEGIN
    
    dbms_output.put_line('Inicia pObtenerConsumos ');

        rcConssesu  := null;
        nuConsumoUnid   := null;
        nuDiferencia1   := null;
        nuDiferencia2   := null;
        
        nuFacturadoFin  := null;
        nuCorregidoFin  := null;
        nuCalculadoFin  := null;
        
        open cuConsumoCalculado(inuProd,inuTCon,inuPeco);
        fetch cuConsumoCalculado INTO rcConssesu;
        close cuConsumoCalculado;

        nuConsumoAct    := rcConssesu.cosscoca;
        orcConBase      := rcConssesu;

        open cuConsumosVista(inuProd,inuTCon,inuPeco);
        fetch cuConsumosVista INTO nuConsumoUnid,nuDiferencia1,nuDiferencia2;
        close cuConsumosVista;

        open cuConsumoFacturado(inuProd,inuTCon,inuPeco);
        fetch cuConsumoFacturado INTO nuConsumoFact;
        close cuConsumoFacturado;

        /*
        CORREGIDO: Para volverlo cero (Se multiplica por -1)
        CALCULADO: Valor limpio
        FACTURADO: Lo que le falta al facturado actual para llegar al calculado
            Si el facturado actual es menor, simplemente es la resta del Calculado menos el facturado actual
            Si el facturado actual es mayor, es la resta del Calculado menos el facturado actual
            Ejemplos
            797 - 1000  = -203  (Facturado Actual Mayor)
            797 - 50    = 720   (Facturado Actual menor)
            797 - -10   = 787   (Facturado Actual Menor que cero)
            797 - 0     = 797   (Facturado Actual Cero)
        */

        case
        when (nuConsumoUnid = 0) then
            nuCorregidoFin := 0;
        when (nuConsumoUnid > 0)then
            nuCorregidoFin := nuConsumoUnid*-1;
        else
            nuCorregidoFin := nuDiferencia2-nuConsumoCalc;
        END case;

        nuCalculadoFin  := inuCons;
        nuFacturadoFin  := nuCalculadoFin - nuConsumoFact;

        onuCorreg   := nuCorregidoFin;
        onuCalc     := nuCalculadoFin;
        onuFact     := nuFacturadoFin;

        dbms_output.put_line('Consumo Calculado '||rcConssesu.cosscoca);
        dbms_output.put_line('Consumo Facturado '||nuConsumoFact);
        dbms_output.put_line('Consumo Requerido '||inuCons);
        dbms_output.put_line('-------------------------------------------');
        dbms_output.put_line('Consumo Corregido Fin '||nuCorregidoFin);
        dbms_output.put_line('Consumo Calculado Fin '||nuCalculadoFin);
        dbms_output.put_line('Consumo Facturado Fin '||nuFacturadoFin);

    dbms_output.put_line('Fin pObtenerConsumos ');
        
    EXCEPTION
        when ex.CONTROLLED_ERROR  then
            Errors.getError(nuErrorCode, sbErrorMessage);
            dbms_output.put_line('ERROR CONTROLLED ');
            dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
            dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

        when OTHERS then
            Errors.setError;
            Errors.getError(nuErrorCode, sbErrorMessage);
            dbms_output.put_line('ERROR OTHERS ');
            dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
            dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
    END pObtenerConsumos;
    
    PROCEDURE pObtenerPeco
    (
        inuProd IN servsusc.sesunuse%type,
        inuMes  IN perifact.pefames%type,
        inuAnio IN perifact.pefaano%type,
        onuPeco OUT pericose.pecscons%type
    )
    IS

    CURSOR cuCiclo
    (
        inuSesu servsusc.sesucicl%type
    )
    IS
    SELECT sesucicl
    FROM servsusc
    WHERE sesunuse = inuSesu;
    
    CURSOR cuPeriodo
    (
        inuCiclo    perifact.pefacicl%type,
        inuMesP     perifact.pefames%type,
        inuAno      perifact.pefaano%type
    )
    IS
    SELECT pecscons
    FROM perifact, PERICOSE
    WHERE pefames = inuMesP
    AND pefaano = inuAno
    AND pefacicl = inuCiclo
	 and pecscico = pefacicl
	 and pecsfecf  between pefafimo and pefaffmo;
    
    nuCiclo     perifact.pefacicl%type;
    nuPeco      pericose.pecscons%type;
    
    BEGIN
    
    dbms_output.put_line('Inicia pObtenerPeco ');
    
    open cuCiclo(inuProd);
    fetch cuCiclo INTO nuCiclo;
    close cuCiclo;

    open cuPeriodo(nuCiclo,inuMes,inuAnio);
    fetch cuPeriodo INTO nuPeco;
    close cuPeriodo;
    
    dbms_output.put_line('Mes: '||inuMes||' - Año: '||inuAnio||' - Ciclo: '||nuCiclo||' - Periodo de Consumo:'||nuPeco);

    onuPeco := nuPeco;
    
    dbms_output.put_line('Fin pObtenerPeco ');
    
    EXCEPTION
        when ex.CONTROLLED_ERROR  then
            Errors.getError(nuErrorCode, sbErrorMessage);
            dbms_output.put_line('ERROR CONTROLLED ');
            dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
            dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

        when OTHERS then
            Errors.setError;
            Errors.getError(nuErrorCode, sbErrorMessage);
            dbms_output.put_line('ERROR OTHERS ');
            dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
            dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
    END pObtenerPeco;
    

    PROCEDURE pAjustarConsumos
    (
        inuProd     in  number,
        inuTCon     in  number,
        inuPeco     in  number,
        inuCons     in  number,
        isbFuncion  in  varchar2
    )
    IS

        nuConsCorregido conssesu.cosscoca%type;
        nuConsCalculado conssesu.cosscoca%type;
        nuConsFacturado conssesu.cosscoca%type;
        rcConsumoBase   conssesu%rowtype;

        sbTokenEtiqueta     conssesu.cossfufa%type  := '[GDC] - ';
        sbEtiqueta          conssesu.cossfufa%type;

    BEGIN
    
        dbms_output.put_line('Inicia pAjustarConsumos ');

        pObtenerConsumos(inuProd,inuTCon,inuPeco,inuCons,nuConsCorregido,nuConsCalculado,nuConsFacturado,rcConsumoBase);
        sbEtiqueta  := substr(sbTokenEtiqueta||rcConsumoBase.cossfufa,0,99);

        --Inserción de consumos ajustados
        IF(isbFuncion = 'EST')THEN

        -- Inserción de Consumos
            -- Inserción de consumo corregido
            INSERT INTO conssesu
            (
                COSSSESU,COSSTCON,COSSPEFA,
                COSSCOCA,COSSNVEC,COSSELME,
                COSSMECC,COSSFLLI,COSSPFCR,
                COSSDICO,COSSIDRE,COSSCMSS,
                COSSFERE,COSSFUFA,COSSCAVC,
                COSSFUNC,COSSPECS,COSSCONS,
                COSSFCCO
            )
            VALUES
            (
                rcConsumoBase.COSSSESU,rcConsumoBase.COSSTCON,rcConsumoBase.COSSPEFA,
                nuConsCorregido,null,rcConsumoBase.COSSELME,
                2,'N',NULL,
                NULL,NULL,NULL,
                sysdate,sbEtiqueta,null,
                rcConsumoBase.COSSFUNC,rcConsumoBase.COSSPECS,NULL,
                NULL
            );

            -- Inserción de consumo por estimación
            INSERT INTO conssesu
            (
                COSSSESU,COSSTCON,COSSPEFA,
                COSSCOCA,COSSNVEC,COSSELME,
                COSSMECC,COSSFLLI,COSSPFCR,
                COSSDICO,COSSIDRE,COSSCMSS,
                COSSFERE,COSSFUFA,COSSCAVC,
                COSSFUNC,COSSPECS,COSSCONS,
                COSSFCCO
            )
            VALUES
            (
                rcConsumoBase.COSSSESU,rcConsumoBase.COSSTCON,rcConsumoBase.COSSPEFA,
                nuConsCalculado,rcConsumoBase.COSSNVEC,rcConsumoBase.COSSELME,
                3,'N',rcConsumoBase.COSSPFCR,
                rcConsumoBase.COSSDICO,null,null,
                sysdate,sbEtiqueta,rcConsumoBase.COSSCAVC,
                rcConsumoBase.COSSFUNC,rcConsumoBase.COSSPECS,null,
                null
            );

            -- Inserción de consumo facturado
            INSERT INTO conssesu
            (
                COSSSESU,COSSTCON,COSSPEFA,
                COSSCOCA,COSSNVEC,COSSELME,
                COSSMECC,COSSFLLI,COSSPFCR,
                COSSDICO,COSSIDRE,COSSCMSS,
                COSSFERE,COSSFUFA,COSSCAVC,
                COSSFUNC,COSSPECS,COSSCONS,
                COSSFCCO
            )
            VALUES
            (
                rcConsumoBase.COSSSESU,rcConsumoBase.COSSTCON,rcConsumoBase.COSSPEFA,
                nuConsFacturado,rcConsumoBase.COSSNVEC,rcConsumoBase.COSSELME,
                4,'N',NULL,
                rcConsumoBase.COSSDICO,null,null,
                sysdate,sbEtiqueta,rcConsumoBase.COSSCAVC,
                rcConsumoBase.COSSFUNC,rcConsumoBase.COSSPECS,null,
                null
            );

        ELSE

        -- Inserción de Consumos
            -- Inserción de consumo corregido
            INSERT INTO conssesu
            (
                COSSSESU,COSSTCON,COSSPEFA,
                COSSCOCA,COSSNVEC,COSSELME,
                COSSMECC,COSSFLLI,COSSPFCR,
                COSSDICO,COSSIDRE,COSSCMSS,
                COSSFERE,COSSFUFA,COSSCAVC,
                COSSFUNC,COSSPECS,COSSCONS,
                COSSFCCO
            )
            VALUES
            (
                rcConsumoBase.COSSSESU,rcConsumoBase.COSSTCON,rcConsumoBase.COSSPEFA,
                nuConsCorregido,null,rcConsumoBase.COSSELME,
                2,'N',NULL,
                NULL,NULL,NULL,
                sysdate,sbEtiqueta,null,
                rcConsumoBase.COSSFUNC,rcConsumoBase.COSSPECS,NULL,
                NULL
            );

            -- Inserción de consumo por estimación
            INSERT INTO conssesu
            (
                COSSSESU,COSSTCON,COSSPEFA,
                COSSCOCA,COSSNVEC,COSSELME,
                COSSMECC,COSSFLLI,COSSPFCR,
                COSSDICO,COSSIDRE,COSSCMSS,
                COSSFERE,COSSFUFA,COSSCAVC,
                COSSFUNC,COSSPECS,COSSCONS,
                COSSFCCO
            )
            VALUES
            (
                rcConsumoBase.COSSSESU,rcConsumoBase.COSSTCON,rcConsumoBase.COSSPEFA,
                nuConsCalculado,0,rcConsumoBase.COSSELME,
                1,'N',rcConsumoBase.COSSPFCR,
                rcConsumoBase.COSSDICO,null,null,
                sysdate,sbEtiqueta,rcConsumoBase.COSSCAVC,
                rcConsumoBase.COSSFUNC,rcConsumoBase.COSSPECS,null,
                null
            );

            -- Inserción de consumo facturado
            INSERT INTO conssesu
            (
                COSSSESU,COSSTCON,COSSPEFA,
                COSSCOCA,COSSNVEC,COSSELME,
                COSSMECC,COSSFLLI,COSSPFCR,
                COSSDICO,COSSIDRE,COSSCMSS,
                COSSFERE,COSSFUFA,COSSCAVC,
                COSSFUNC,COSSPECS,COSSCONS,
                COSSFCCO
            )
            VALUES
            (
                rcConsumoBase.COSSSESU,rcConsumoBase.COSSTCON,rcConsumoBase.COSSPEFA,
                nuConsFacturado,0,rcConsumoBase.COSSELME,
                4,'N',NULL,
                rcConsumoBase.COSSDICO,null,null,
                sysdate,sbEtiqueta,rcConsumoBase.COSSCAVC,
                rcConsumoBase.COSSFUNC,rcConsumoBase.COSSPECS,null,
                null
            );

        END IF;
        
        dbms_output.put_line('Fin pAjustarConsumos ');
        
    EXCEPTION
        when ex.CONTROLLED_ERROR  then
            Errors.getError(nuErrorCode, sbErrorMessage);
            dbms_output.put_line('ERROR CONTROLLED pAjustarConsumos ');
            dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
            dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

        when OTHERS then
            Errors.setError;
            Errors.getError(nuErrorCode, sbErrorMessage);
            dbms_output.put_line('ERROR OTHERS pAjustarConsumos ');
            dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
            dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
    END pAjustarConsumos;
    
    PROCEDURE pAjustaConsumo
    (
        inuProd     in  number,
        inuTCon     in  number,
        inuMes      in  number,
        inuAnio     in  number,
        inuCons     in  number,
        isbFuncion  in  varchar2
    )
    IS
    
    nuPeco  pericose.pecscons%type;
    
    BEGIN
    
    dbms_output.put_line('Inicio pAjustarConsumo');
    
    -- Obtiene el periodo de consumo
    pObtenerPeco
    (
        inuProd,
        inuMes,
        inuAnio,
        nuPeco
    );
    
    -- Realizar el ajuste de consumos
    pAjustarConsumos
    (
        inuProd,
        inuTCon,
        nuPeco,
        inuCons,
        isbFuncion
    );
    
    
    dbms_output.put_line('Fin pAjustarConsumo ');
    
    EXCEPTION
        when ex.CONTROLLED_ERROR  then
            Errors.getError(nuErrorCode, sbErrorMessage);
            dbms_output.put_line('ERROR CONTROLLED pAjustarConsumo ');
            dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
            dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

        when OTHERS then
            Errors.setError;
            Errors.getError(nuErrorCode, sbErrorMessage);
            dbms_output.put_line('ERROR OTHERS pAjustarConsumo ');
            dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
            dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
    END pAjustaConsumo;
    
BEGIN
    errors.Initialize;
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(0);
    ut_trace.Trace('INICIO');
   
    -- pAjustaConsumo(8602963,103,7,2022,3976.62,'EST');
    -- pAjustaConsumo(203442,103,8,2022,2662.12,'EST');
   -- pAjustaConsumo(8602963,103,9,2022,21631.18,'EST');
    pAjustaConsumo(8602963,103,10,2022,21631.18,'EST');
    
   -- commit;

    dbms_output.put_line('SALIDA onuErrorCode: '||nuErrorCode);
    dbms_output.put_line('SALIDA osbErrorMess: '||sbErrorMessage);


EXCEPTION
    when ex.CONTROLLED_ERROR  then
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED principal ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

    when OTHERS then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR OTHERS principal ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
END;
/