create or replace procedure adm_person.ProcGeneraCuponAso2001Du is
  /************************************************************************
    Copyright (c) 2014 GASES DEL CARIBE

    NOMBRE       : ProcGeneraCuponAso2001Du
    AUTOR        : Sincecomp - Samuel Alberto Pacheco Orozco
    FECHA        : 22-05-2014
    DESCRIPCION  : Procedimiento mediante el cual se obtiene la informacion
                   de los cupones duplicado pendiente de pago
                   para su envio a entidades de recaudo


    Historia de Modificaciones
    Autor       Fecha        Descripcion
    jpinedc     15/02/2024   OSF-2328: Ajustes migración V8      
  ************************************************************************/

    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    csbMetodo        CONSTANT VARCHAR2(70) := 'ProcGeneraCuponAso2001Du';
    
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    
    cursor cuCuponesD is
    select cuponume,
           cupotipo,
           cupodocu,
           cupovalo,
           (SELECT MAX(CUCOFEVE)
              FROM CUENCOBR
             WHERE cucofaag IN (select FACTCODI
                                  from factura
                                 where FACTCODI = cupodocu
                                   AND FACTSUSC = CUPOSUSC)) cupofech,
           cupoprog,
           cupocupa,
           cuposusc,
           cupoflpa
      from cupon
     where cupoprog in ('OS_COUPGEN')
       AND trunc(cupofech) >= trunc(sysdate) - 1
       and cuponume >
           (select max(LOCUCUFI) from logcupon where locuacci = 'FIND')
       AND CUPOFLPA = 'N'
     ORDER BY CUPONUME;

    --DECLARACION DE VARIABLES
    sbEncabezado01 varchar2(500) := '';
    sbEncabezado05 varchar2(500) := '';
    sbEncabezado06 varchar2(500) := '';
    sbEncabezado08 varchar2(500) := '';
    sbEncabezado09 varchar2(500) := '';

    nuConsecutivo        NUMBER;
    nuCuponIni    CUPON.CUPONUME%TYPE;
    nuCuponFin    CUPON.CUPONUME%TYPE;
    sbSendEmail   ld_parameter.value_chain%TYPE; --Direccion de email quine firma el email
    sbrecEmail    ld_parameter.value_chain%TYPE; --Direccion de email que recibe
    nuValor        varchar2(20) := 0;
    nuCantidad     number(15) := 0;
    nuCicl         number(4);
    sbNombArchivoD VARCHAR2(4000); --Nombre de Archivo a Generar DUPLICADO
    sbDirectorio        VARCHAR2(4000) := pkg_parametros.fsbGetValorCadena('DIREC_ARCH_CUPON_PEND_PAGO_1');
    flArchivo           pkg_gestionArchivos.styArchivo;
    sbModoEscritura VARCHAR2(1) := pkg_gestionArchivos.csbMODO_ESCRITURA;    

    --IDENTIFICA EL MAXIMO CONSECUTIVO GENERADO POR DIA
    CURSOR cuConsecutivo
    IS
    SELECT NVL(MAX(LOCUCONS), 0) + 1
    FROM LOGCUPON
    WHERE TRUNC(LOCUFERE) = TRUNC(SYSDATE)
    AND locuacci = 'FIND';
    
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

begin
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    
    prcCierraCursores;  
    
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
    Insert Into LOGCUPON
    (locuacci, locufere, locuobse, LOCUarch, locucons)
    Values
    ('INICIOD',
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
    for i in cuCuponesD loop

        IF nuCuponIni IS NULL THEN
          nuCuponIni := i.cupoNUME;
        END IF;

        begin
          select sUSCCICL
            into nuCicl
            from SUSCRIPC
           where suscCODI = i.cuposusc;
        exception
          when others then
            nuCicl := 0;
        end;
    
        sbEncabezado06 := '06' || lpad(i.cuponume, 48, 0) ||
                          lpad(i.cuposusc, 30, 0) || lpad(nuCicl, 5, 0) ||
                          lpad(i.cupovalo, 12, 0) || '00' ||
                          '000000000000000000000000000' ||
                          to_char(i.cupofech, 'yyyymmdd') ||
                          '0000000000000000000000000000000000000                      000                        ';
        /*DBMS_OUTPUT.PUT_LINE(sbEncabezado06);*/
        proEscFile(sbEncabezado06, sbDirectorio, sbNombArchivoD, flArchivo);
        --acumula valores
        nuValor    := nuValor + i.cupovalo;
        nuCantidad := nuCantidad + 1;

        nuCuponFin := i.cupoNUME;

    end loop;
    
    sbEncabezado08 := '08' || lpad(nuCantidad, 9, 0) || lpad(nuValor, 16, 0) ||
                    '000000000000000000000001                                                                                                                                                                         ';
    sbEncabezado09 := '09' || lpad(nuCantidad, 9, 0) || lpad(nuValor, 16, 0) ||
                    '00000000000000000000                                                                                                                                                                             ';
  
    /*DBMS_OUTPUT.PUT_LINE(sbEncabezado08);*/
    proEscFile(sbEncabezado08, sbDirectorio, sbNombArchivoD, flArchivo);
    /*DBMS_OUTPUT.PUT_LINE(sbEncabezado09);*/
    proEscFile(sbEncabezado09, sbDirectorio, sbNombArchivoD, flArchivo);

    pkg_GestionArchivos.prcCerrarArchivo_SMF(flArchivo, sbDirectorio, sbNombArchivoD);

    --registra log de finalizacion de proceso
    Insert Into LOGCUPON
    (locuacci, locufere, locuobse, LOCUarch, locucons, LOCUCUIN, LOCUCUFI)
    Values
    ('FIND',
     SYSDATE,
     'ARCHIVO=>' || sbNombArchivoD,
     sbNombArchivoD,
     nuConsecutivo,
     nuCuponIni,
     nuCuponFin);
    COMMIT;

    --SE ENVIA CORREO DE NOTIFICACION
    ld_bopackagefnb.prosendemail(isbsender     => sbSendEmail,
                               isbrecipients => sbrecEmail,
                               isbsubject    => 'Ejecucion JOb' || '-' ||
                                                sbNombArchivoD,
                               isbmessage    => 'ARCHIVO=>' ||
                                                sbNombArchivoD || chr(10) ||
                                                'Cupon Inicial=>' ||
                                                nuCuponIni || chr(10) ||
                                                'Cupon Final=>' ||
                                                nuCuponFin,
                               isbfilename   => null);
                               
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
                                                    sbNombArchivoD,
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
                               isbrecipients => sbrecEmail,
                               isbsubject    => 'ERROR Ejecucion JOb' || '-' ||
                                                sbNombArchivoD,
                               isbmessage    => sbError,
                               isbfilename   => null);

end ProcGeneraCuponAso2001Du;
/

