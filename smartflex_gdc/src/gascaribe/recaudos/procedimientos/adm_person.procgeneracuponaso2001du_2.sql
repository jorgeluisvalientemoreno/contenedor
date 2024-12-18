create or replace procedure adm_person.ProcGeneraCuponAso2001Du_2 IS
  /************************************************************************
    Copyright (c) 2014 GASES DEL CARIBE

    NOMBRE       : ProcGeneraCuponAso2001Du_2
    AUTOR        : Sincecomp - Samuel Alberto Pacheco Orozco
    FECHA        : 22-05-2014
    DESCRIPCION  : Procedimiento mediante el cual se obtiene la informacion
                   de los cupones duplicado pendiente de pago
                   para su envio a entidades de recaudo


    Historia de Modificaciones
    Autor       Fecha        Descripcion
    jpinedc     15/02/2024   OSF-2328: Ajustes ultimas directrices desarrollo     
  ************************************************************************/
    csbMetodo        CONSTANT VARCHAR2(70) := 'ProcGeneraCuponAso2001Du_2';

    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
        
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    
    CURSOR cuCuponesD IS
    SELECT cuponume,
           cupotipo,
           cupodocu,
           cupovalo,
           ADD_MONTHS((SELECT MAX(CUCOFEVE)
              FROM CUENCOBR
             WHERE cucofaag IN (SELECT FACTCODI
                                  FROM factura
                                 WHERE FACTCODI = cupodocu
                                   AND FACTSUSC = CUPOSUSC)),1) cupofech,
           cupoprog,
           cupocupa,
           cuposusc,
           cupoflpa
    FROM cupon
    WHERE cupoprog in ('OS_COUPGEN')
    AND trunc(cupofech) >= trunc(sysdate) - 1
    AND cuponume >
    (SELECT max(LOCUCUFI) FROM logcupon WHERE locuacci = 'FIND2')
    AND CUPOFLPA = 'N'
    ORDER BY CUPONUME;

    --DECLARACION DE VARIABLES
    sbEncabezado01  VARCHAR2(500) := '';
    sbEncabezado05  VARCHAR2(500) := '';
    sbEncabezado06  VARCHAR2(500) := '';
    sbEncabezado08  VARCHAR2(500) := '';
    sbEncabezado09  VARCHAR2(500) := '';
    nuConsecutivo   NUMBER;
    nuCuponIni      CUPON.CUPONUME%TYPE;
    nuCuponFin      CUPON.CUPONUME%TYPE;
    sbSendEmail     ld_parameter.value_chain%TYPE; --Direccion de email quine firma el email
    sbrecEmail      ld_parameter.value_chain%TYPE; --Direccion de email que recibe
    nuValor         VARCHAR2(20) := 0;
    nuCantidad      NUMBER(15) := 0;
    nuCiclo         NUMBER(4);
    sbNombArchivoD  VARCHAR2(4000); --Nombre de Archivo a Generar DUPLICADO
    sbDirectorio    VARCHAR2(4000) := pkg_parametros.fsbGetValorCadena('DIREC_ARCH_CUPON_PEND_PAGO_2');
    flArchivo       pkg_GestionArchivos.styArchivo;

    sbModoEscritura VARCHAR2(1) := pkg_gestionArchivos.csbMODO_ESCRITURA;    
    
    --IDENTIFICA EL MAXIMO CONSECUTIVO GENERADO POR DIA
    CURSOR cuConsecutivo
    IS
    SELECT NVL(MAX(LOCUCONS), 0) + 1
    FROM LOGCUPON
    WHERE TRUNC(LOCUFERE) = TRUNC(SYSDATE)
    AND locuacci = 'FIND2';    
    
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

    --identifica parametro de correo de envio osf
    sbSendEmail := dald_Parameter.fsbGetValue_Chain('LDC_SMTP_SENDER');
    --identifica parametro de correo de recibe notificacion de proceso de cupones
    sbrecEmail := dald_Parameter.fsbGetValue_Chain('EMAIL_RENO_CUPON');

    --IDENTIFICA EL MAXIMO CONSECUTIVO GENERADO POR DIA
    OPEN cuConsecutivo;
    FETCH cuConsecutivo INTO nuConsecutivo;
    CLOSE cuConsecutivo;

    sbNombArchivoD := 'T0593' || to_char(sysdate, 'ymmdd') || '_DUP' || '.00' ||
                    nuConsecutivo;

    --<<PROCESO CUPON DUPLICADO>>--
    --SE INSERTA LOG DE INICIO
    INSERT INTO LOGCUPON
    (locuacci, locufere, locuobse, LOCUarch, locucons)
    VALUES
    ('INICIOD2',
     SYSDATE,
     'ARCHIVO=>' || sbNombArchivoD,
     sbNombArchivod,
     nuConsecutivo);

    ----------------------GENERA ENCABEZADO ARCHIVO PLANO DE CUPONES A PAGAR
    sbEncabezado01 := '0189010169120000000000001' ||
                    to_char(sysdate, 'yyyymmddhhmi') ||
                    'A                                                                                                                                                                                      ';
    sbEncabezado05 := '0500008901016910001GASES DEL CARIB                                                                                                                                                                                          ';
    --ESCRIBE ENCABEZADO
    proEscFile(sbEncabezado01, sbDirectorio, sbNombArchivoD, flArchivo);

    proEscFile(sbEncabezado05, sbDirectorio, sbNombArchivoD, flArchivo);

    --INICIALIZA CUPON INICIAL EN NULL
    nuCuponIni := NULL;
    nuCuponFin := NULL;
    nuValor     := 0;
    nuCantidad  := 0;
  
    --procesa los cupones a generar
    for rgCuponesD in cuCuponesD LOOP

        IF nuCuponIni IS NULL THEN
            nuCuponIni := rgCuponesD.cupoNUME;
        END IF;
        
        nuCiclo := NVL(pkg_BCContrato.fnuCicloFacturacion(rgCuponesD.cuposusc),0);
                
        sbEncabezado06 := '06' || lpad(rgCuponesD.cuponume, 48, 0) ||
                          lpad(rgCuponesD.cuposusc, 30, 0) || lpad(nuCiclo, 5, 0) ||
                          lpad(rgCuponesD.cupovalo, 12, 0) || '00' ||
                          '000000000000000000000000000' ||
                          to_char(rgCuponesD.cupofech, 'yyyymmdd') ||
                          '0000000000000000000000000000000000000                      000                        ';

        proEscFile(sbEncabezado06, sbDirectorio, sbNombArchivoD, flArchivo);
        
        --acumula valores
        nuValor    := nuValor + rgCuponesD.cupovalo;
        nuCantidad := nuCantidad + 1;

        nuCuponFin := rgCuponesD.cupoNUME;

    END LOOP;
    
    sbEncabezado08 := '08' || lpad(nuCantidad, 9, 0) || lpad(nuValor, 16, 0) ||
                    '000000000000000000000001                                                                                                                                                                         ';
    sbEncabezado09 := '09' || lpad(nuCantidad, 9, 0) || lpad(nuValor, 16, 0) ||
                    '00000000000000000000                                                                                                                                                                             ';

    proEscFile(sbEncabezado08, sbDirectorio, sbNombArchivoD, flArchivo);

    proEscFile(sbEncabezado09, sbDirectorio, sbNombArchivoD, flArchivo);
        
    pkg_GestionArchivos.prcCerrarArchivo_SMF(flArchivo, sbDirectorio, sbNombArchivoD);

    --registra log de finalizacion de proceso
    INSERT INTO LOGCUPON
    (
        locuacci, 
        locufere, 
        locuobse, 
        LOCUarch, 
        locucons, 
        LOCUCUIN, 
        LOCUCUFI
    )
    VALUES
    (
        'FIND2',
        SYSDATE,
        'ARCHIVO=>' || sbNombArchivoD,
        sbNombArchivoD,
        nuConsecutivo,
        nuCuponIni,
        nuCuponFin
    );
    
    COMMIT;

    --SE ENVIA CORREO DE NOTIFICACION
    ld_bopackagefnb.prosendemail
    (
        isbsender     => sbSendEmail,
        isbrecipients => sbrecEmail,
        isbsubject    => 'Ejecucion JOb' || '-' || sbNombArchivoD,
        isbmessage    => 'ARCHIVO=>' ||
                         sbNombArchivoD || chr(10) ||
                         'Cupon Inicial=>' ||
                         nuCuponIni || chr(10) ||
                         'Cupon Final=>' ||
                         nuCuponFin,
                         isbfilename   => null
    );
    
EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_Error.getError(nuError,sbError);        
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        INSERT INTO LOGCUPON
          (locuacci, locufere, locuobse)
        VALUES
          ('ERROR', SYSDATE, sbError);
        COMMIT;

        prcCierraCursores;
        
        -- Call the procedure  SE ENVIA CORREO DE INCONSISTENCIA
        ld_bopackagefnb.prosendemail
        (
            isbsender       => sbSendEmail,
            isbrecipients   => sbrecEmail,
            isbsubject      => 'ERROR Ejecucion JOb' || '-' || sbNombArchivoD,
            isbmessage      => sbError,
            isbfilename     => null
        );      

    WHEN OTHERS THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
        pkg_error.setError;
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        
        INSERT INTO LOGCUPON
        (locuacci, locufere, locuobse)
        VALUES
        ('ERROR', SYSDATE, sbError);
        
        COMMIT;
    
        prcCierraCursores;
    
        -- Call the procedure  SE ENVIA CORREO DE INCONSISTENCIA
        ld_bopackagefnb.prosendemail
        (
            isbsender       => sbSendEmail,
            isbrecipients   => sbrecEmail,
            isbsubject      => 'ERROR Ejecucion JOb' || '-' || sbNombArchivoD,
            isbmessage      => sbError,
            isbfilename     => null
        );
END ProcGeneraCuponAso2001Du_2;
/

