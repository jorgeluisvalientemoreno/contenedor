CREATE OR REPLACE procedure adm_person.ProcGeneraCupon_BColombia is
/************************************************************************
    Copyright (c) 2014 GASES DEL CARIBE

    NOMBRE       : ProcGeneraCupon_BColombia
    AUTOR        : Horbath Tecnologies
    FECHA        : 17/10/2019
    DESCRIPCION  : Procedimiento mediante el cual se obtiene la informacion
                   de los cupones pendiente de pago y los envia a servidor ftp
                   para su envio a entidades de recaudo.
                   Este procedimiento es copia del procedimiento ProcGeneraCuponAso2001
                   y la modificacion realizada solo aplica para Bancolombia CA-000206
                   El cambio es en su estructura;
                   Como referencia uno (1) se envia el numero de contrato
                   y como referencia dos (2) el numero de cupon.


    Historia de Modificaciones
    Autor       Fecha        Descripcion
    PACOSTA     25/04/2024   OSF-2596: Se crea el objeto en el esquema adm_person  
    jpinedc     11/02/2024   OSF-2328: Ajustes ultimas directrices desarrollo 
************************************************************************/

    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    csbMetodo        CONSTANT VARCHAR2(70) := 'ProcGeneraCupon_BColombia';
    
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
        
    -- CURSOR para obrener la informacion de los cupones a enviar
    CURSOR  cuCupones(nuperi number) IS
    SELECT  cuponume,
            cupotipo,
            cupodocu,
            cupovalo,
            (
                SELECT MAX(CUCOFEVE)
                FROM CUENCOBR
                WHERE cucofaag IN 
                (
                    SELECT FACTCODI
                    FROM factura
                    WHERE FACTCODI = cupodocu
                    AND FACTSUSC = CUPOSUSC
                )
            ) cupofech,
            cupoprog,
            cupocupa,
            cuposusc,
            cupoflpa
    FROM cupon
    WHERE (cuponume, cuposusc) IN
    (
        SELECT max(cuponume), cuposusc
        FROM cupon
        WHERE cupoprog IN ('FIDF')
        AND cupodocu IN
        (
            SELECT factcodi FROM factura WHERE factpefa = nuperi
        )
        AND CUPOFLPA = 'N'
        group by cuposusc
    )
    ORDER BY CUPONUME;

    CURSOR cuCuperiodo IS
    SELECT distinct esprpefa PREJCOPE,
                    (SELECT PEFACICL
                       FROM PERIFACT
                      WHERE PEFACODI = esprpefa) CICLO
    FROM estaprog
    WHERE esprprog like 'FIDF%'
    AND TRUNC(esprfefi) = TRUNC(SYSDATE - 1)
    AND ESPRPORC = 100
     /* Comentarear para hacer pruebas */
    AND esprpefa NOT IN
    (SELECT NVL(locupefa, -1) FROM LOGCUPON WHERE locuacci = 'FIN')
     /* Fin */
     --   AND rownum < 4
     ORDER by esprpefa desc;

    --DECLARACION DE VARIABLES
    sbEncabezado01  varchar2(500) := '';
    sbEncabezado05  varchar2(500) := '';
    sbEncabezado06  varchar2(500) := '';
    sbEncabezado08  varchar2(500) := '';
    sbEncabezado09  varchar2(500) := '';

    nuConsecutivo         NUMBER;
    nuCuponIni     CUPON.CUPONUME%TYPE;
    nuCuponFin     CUPON.CUPONUME%TYPE;
    sbSendEmail    ld_parameter.value_chain%TYPE; --Direccion de email quine firma el email
    sbRecEmail     ld_parameter.value_chain%TYPE; --Direccion de email que recibe
    nuValor         varchar2(20) := 0;
    nuCantidad      number(15) := 0;
    nuCicl          number(4);
    sbNombArchivo   VARCHAR2(4000); --Nombre de Archivo a Generar
    sbDirectorio    VARCHAR2(4000) := pkg_parametros.fsbGetValorCadena('DIREC_ARCH_CUPON_PEND_PAGO_1');
    flArchivo            pkg_gestionArchivos.styArchivo;
    sbModoEscritura VARCHAR2(1) := pkg_gestionArchivos.csbMODO_ESCRITURA;
    
    --IDENTIFICA EL MAXIMO CONSECUTIVO GENERADO POR DIA
    CURSOR cuConsecutivo
    IS
    SELECT NVL(MAX(LOCUCONS), 0) + 1
    FROM LOGCUPON
    WHERE TRUNC(LOCUFERE) = TRUNC(SYSDATE);
    
    PROCEDURE prcCierraCursores
    IS
        csbMetodo1        CONSTANT VARCHAR2(70) := csbMetodo || '.prcCierraCursores';
        nuError1         NUMBER;
        sbError1         VARCHAR2(4000);    
    BEGIN

        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);
        
        IF cuConsecutivo%ISOPEN THEN
            CLOSE cuConsecutivo;
        END IF;
          
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError1,sbError1);        
            pkg_traza.trace('sbError1 => ' || sbError1, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError1,sbError1);
            pkg_traza.trace('sbError1 => ' || sbError1, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prcCierraCursores;

    --PROCEDIMIENTO QUE ESCRIBE EN ARCHIVO PLANO
    PROCEDURE proEscFile
    (
        isbLine         VARCHAR2,
        isbDirectorio   VARCHAR2,
        isbArchivo      VARCHAR2,
        ouFile      IN OUT NOCOPY pkg_gestionArchivos.styArchivo
    ) 
    IS
        csbMetodo2        CONSTANT VARCHAR2(70) := csbMetodo || '.proEscFile';
        nuError2         NUMBER;
        sbError2         VARCHAR2(4000);  
    BEGIN
    
        pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbINICIO);    

        IF (NOT pkg_GestionArchivos.fblArchivoAbierto_SMF(ouFile)) THEN
            ouFile := pkg_gestionArchivos.ftAbrirArchivo_SMF (isbDirectorio, isbArchivo, sbModoEscritura);
        END IF;
        pkg_GestionArchivos.prcEscribirLinea_SMF(ouFile, isbLine);

        pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError2,sbError2);        
            pkg_traza.trace('sbError2 => ' || sbError2, csbNivelTraza );
            pkg_GestionArchivos.prcCerrarArchivo_SMF(ouFile,isbDirectorio,isbArchivo); --cerrar el archivo
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError2,sbError2);
            pkg_traza.trace('sbError2 => ' || sbError2, csbNivelTraza );
            pkg_GestionArchivos.prcCerrarArchivo_SMF(ouFile,isbDirectorio,isbArchivo); --cerrar el archivo
    END proEscFile;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    
    prcCierraCursores;  
  
    --identifica parametro de correo de envio osf
    sbSendEmail := dald_Parameter.fsbGetValue_Chain('LDC_SMTP_SENDER');
    
    --identifica parametro de correo de recibe notificacion de proceso de cupones
    sbRecEmail := dald_Parameter.fsbGetValue_Chain('EMAIL_RENO_CUPON');

    FOR rgPeriodo IN cuCuperiodo LOOP

        --IDENTIFICA EL MAXIMO CONSECUTIVO GENERADO POR DIA
        OPEN cuConsecutivo;
        FETCH cuConsecutivo INTO nuConsecutivo;
        CLOSE cuConsecutivo;
                
        --SE ARMA NOMBRE DE ARCHIVO A GENERAR
        sbNombArchivo := 'BC_CICLO' || rgPeriodo.ciclo ||
                     to_char(sysdate, 'yyyymmdd') || '.00' || nuConsecutivo;

        --SE INSERTA LOG DE INICIO
        INSERT INTO LOGCUPON
        (locuacci, locufere, locuobse, LOCUarch, locucons, locupefa)
        VALUES          
        (   'INICIO',
            SYSDATE,
            'ARCHIVO=>' || sbNombArchivo,
            sbNombArchivo,
            nuConsecutivo,
            rgPeriodo.prejcope
        );

        --GENERA ENCABEZADO ARCHIVO PLANO DE CUPONES A PAGAR
        sbEncabezado01 := '0108901016910000000000007' ||
                          to_char(sysdate, 'yyyymmddhhmi') ||
                          'A                                                                                                                                                                                      ';
        sbEncabezado05 := '0500008901016910001GASES DEL CARIB                                                                                                                                                                                          ';
        
        --ESCRIBE ENCABEZADO
        proEscFile(sbEncabezado01, sbDirectorio, sbNombArchivo, flArchivo);

        proEscFile(sbEncabezado05, sbDirectorio, sbNombArchivo, flArchivo);

        --INICIALIZA CUPON INICIAL EN NULL
        nuCuponIni := NULL;
        nuCuponFin := NULL;
        nuValor     := 0;
        nuCantidad  := 0;

        --Procesa los cupones a generar
        FOR rgCupon IN cuCupones(rgPeriodo.prejcope) LOOP

            IF nuCuponIni IS NULL THEN
                nuCuponIni := rgCupon.cupoNUME;
            END IF;

            nuCicl := rgPeriodo.ciclo;

            sbEncabezado06 := '06' ||
                            lpad(rgCupon.cuposusc, 48, 0) ||
                            lpad(rgCupon.cuponume, 30, 0) ||
                            lpad(nuCicl, 5, 0) ||
                            lpad(rgCupon.cupovalo, 12, 0) || '00' ||
                            '000000000000000000000000000' ||
                            to_char(rgCupon.cupofech, 'yyyymmdd') ||
                            '0000000000000000000000000000000000000                      007                        ';

            proEscFile(sbEncabezado06, sbDirectorio, sbNombArchivo, flArchivo);
            --acumula valores
            nuValor    := nuValor + rgCupon.cupovalo;
            nuCantidad := nuCantidad + 1;

            nuCuponFin := rgCupon.cupoNUME;
        END LOOP;
        
        sbEncabezado08 := '08' || lpad(nuCantidad, 9, 0) ||
                          lpad(nuValor, 16, 0) ||
                          '000000000000000000000001                                                                                                                                                                         ';
        sbEncabezado09 := '09' || lpad(nuCantidad, 9, 0) ||
                          lpad(nuValor, 16, 0) ||
                          '00000000000000000000                                                                                                                                                                             ';

        proEscFile(sbEncabezado08, sbDirectorio, sbNombArchivo, flArchivo);

        proEscFile(sbEncabezado09, sbDirectorio, sbNombArchivo, flArchivo);
        
        pkg_GestionArchivos.prcCerrarArchivo_SMF(flArchivo, sbDirectorio, sbNombArchivo);
        
        --registra log de finalizacion de proceso
        INSERT INTO LOGCUPON
        (
            locuacci,
            locufere,
            locuobse,
            LOCUarch,
            locucons,
            LOCUCUIN,
            LOCUCUFI,
            locupefa
        )
        VALUES
        (
            'FIN',
            SYSDATE,
            'ARCHIVO=>' || sbNombArchivo,
            sbNombArchivo,
            nuConsecutivo,
            nuCuponIni,
            nuCuponFin,
            rgPeriodo.prejcope
        );
        
        COMMIT;
        
        --SE ENVIA CORREO DE NOTIFICACION
        ld_bopackagefnb.prosendemail(isbsender     => sbSendEmail,
                                     isbrecipients => sbRecEmail,
                                     isbsubject    => 'Ejecucion JOb' || '-' ||
                                                      sbNombArchivo,
                                     isbmessage    => 'ARCHIVO=>' ||
                                                      sbNombArchivo || chr(10) ||
                                                      'Cupon Inicial=>' ||
                                                      nuCuponIni || chr(10) ||
                                                      'Cupon Final=>' ||
                                                      nuCuponFin ||
                                                      ', Periodo ' ||
                                                      rgPeriodo.prejcope,
                                     isbfilename   => null);

    END LOOP;
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_Error.getError(nuError,sbError);        
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        Insert Into LOGCUPON
          (locuacci, locufere, locuobse)
        Values
          ('ERROR', SYSDATE, sbError);
        COMMIT;

        prcCierraCursores;
        
        -- Call the procedure  SE ENVIA CORREO DE INCONSISTENCIA
        ld_bopackagefnb.prosendemail(isbsender     => sbSendEmail,
                                   isbrecipients => sbRecEmail,
                                   isbsubject    => 'ERROR Ejecucion JOb' || '-' ||
                                                    sbNombArchivo,
                                   isbmessage    => sbError,
                                   isbfilename   => null);        

    WHEN OTHERS THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
        pkg_error.setError;
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        Insert Into LOGCUPON
          (locuacci, locufere, locuobse)
        Values
          ('ERROR', SYSDATE, sbError);
        COMMIT;

        prcCierraCursores;
        
        -- Call the procedure  SE ENVIA CORREO DE INCONSISTENCIA
        ld_bopackagefnb.prosendemail(isbsender     => sbSendEmail,
                                   isbrecipients => sbRecEmail,
                                   isbsubject    => 'ERROR Ejecucion JOb' || '-' ||
                                                    sbNombArchivo,
                                   isbmessage    => sbError,
                                   isbfilename   => null);
END ProcGeneraCupon_BColombia;
/
PROMPT Otorgando permisos de ejecucion a PROCGENERACUPON_BCOLOMBIA
BEGIN
    pkg_utilidades.praplicarpermisos('PROCGENERACUPON_BCOLOMBIA', 'ADM_PERSON');
END;
/