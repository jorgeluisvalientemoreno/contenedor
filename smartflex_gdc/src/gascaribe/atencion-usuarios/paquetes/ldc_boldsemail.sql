CREATE OR REPLACE PACKAGE LDC_BoLDSEMAIL IS
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BoLDSEMAIL
    Descripcion    : Servicios para gestionar la forma LDSEMAIL
    Autor          : Horbath
    Fecha          : 23/09/2020

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    23-06-2021      Horbath             CA684: Se modifica GetCuponByCont y pEnvioCorreo
                                        Se crea GetTipoImpByTipoSoli
    01-03-2024      jpinedc             OSF-2376: Se cambia utl_file por
                                        pkg_gestionArchivos
    20-03-2024      jpinedc             OSF-2376: Ajustes Validación Técnica
    28-05-2024      jpinedc             OSF-2603: Se reemplaza LDC_ManagementEmailFNB.PROENVIARCHIVO
                                        por pkg_Correo.prcEnviaCorreo
    20-06-2024      felipe.valencia     OSF-2866: Se modifica el procedimiento pEnvioCorreo
  ******************************************************************/

  /*****************************************************************
    Propiedad intelectual de PETI (c).
    Unidad         : GetLOVPackType
    Descripcion    : Obtiene los tipos de solicitud para la lista de valores
  ******************************************************************/
    PROCEDURE GetLOVPackType
    (
        orfPackType  out  nocopy constants_per.tyRefCursor
    );
    /*****************************************************************
    Propiedad intelectual de PETI (c).
    Unidad         : GetCuponByCont
    Descripcion    : Obtiene los cupones teniendo en cuenta el contrato y el tipo de solicitud
  ******************************************************************/
    PROCEDURE GetCuponByCont
    (
        inuSubscripId   in  servsusc.sesususc%TYPE,
        inuPackType     in  ps_package_type.package_type_id%TYPE,
        inuTipoImpre    in  NUMBER,
        orfCupones      out  nocopy constants_per.tyRefCursor
    );
    
    /*****************************************************************
    Propiedad intelectual de PETI (c).
    Unidad         : pSaveFile
    Descripcion    : Almacena el archivo en la base de datos
  ******************************************************************/
    PROCEDURE pSaveFile
    (
        inuCuponId      in  cupon.cuponume%TYPE,
        isbNameFile     in  LDC_CUPON_EMAIL.name_file%TYPE,
        iblFile         in  LDC_CUPON_EMAIL.cupon_file%TYPE,
        isbCorreo       in  LDC_CUPON_EMAIL.email_%TYPE,
        inuPackageId    IN  LDC_CUPON_EMAIL.tipo_soli%type
    );
    
    /*****************************************************************
    Propiedad intelectual de PETI (c).
    Unidad         : pEnvioCorreo
    Descripcion    : Envia archivo del cupon por correo electronico
  ******************************************************************/

    PROCEDURE pEnvioCorreo
    (
        inuCuponId      IN      cupon.cuponume%type,
        inuTipoImpre    IN      NUMBER
    );
    
    /*****************************************************************
    Propiedad intelectual de PETI (c).
    Unidad         : GetTipoImpByTipoSoli
    Descripcion    : Obtiene el tipo de impresion dada la solicitud
  ******************************************************************/
    PROCEDURE GetTipoImpByTipoSoli
    (
        inuPackType     in  ps_package_type.package_type_id%TYPE,
        onuTipoImpre    out  NUMBER
    );
    

END LDC_BoLDSEMAIL;
/

CREATE OR REPLACE PACKAGE BODY LDC_BoLDSEMAIL IS
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BoLDSEMAIL
    Descripcion    : Servicios para gestionar la forma LDSEMAIL
    Autor          : Horbath
    Fecha          : 23/09/2020

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    23-06-2021      Horbath             CA684: Se modifica GetCuponByCont y pEnvioCorreo
                                        Se crea GetTipoImpByTipoSoli
  ******************************************************************/

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : GetLOVPackType
    Descripcion    : Obtiene los tipos de solicitud para la lista de valores
    Autor          : Horbath
    Fecha          : 23/09/2020

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================
    orfPackType   Cursor con los tipos de solicitud

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
    PROCEDURE GetLOVPackType
    (
        orfPackType  out  nocopy constants_per.tyRefCursor
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'GetLOVPackType';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
        sbPackagType    ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_TIPOS_SOLI_EMAIL');
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
          
        open orfPackType for
            SELECT  ps_package_type.package_type_id ID,
                    ps_package_type.description
            FROM    ps_package_type
            WHERE   INSTR(','||sbPackagType||',' , ','||ps_package_type.package_type_id||',') > 0
            ORDER BY ps_package_type.package_type_id;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN       
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);               
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END GetLOVPackType;
    
    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : GetCuponByCont
    Descripcion    : Obtiene los cupones teniendo en cuenta el contrato y el tipo de solicitud
    Autor          : Horbath
    Fecha          : 23/09/2020

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================
    orfPackType   Cursor con los tipos de solicitud

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    23-06-2021      Horbath             CA684: Se modifica para tener en cuenta el nuevo
                                        parametro inuTipoImpre
  ******************************************************************/
    PROCEDURE GetCuponByCont
    (
        inuSubscripId   in  servsusc.sesususc%TYPE,
        inuPackType     in  ps_package_type.package_type_id%TYPE,
        inuTipoImpre    in  NUMBER,
        orfCupones      out  nocopy constants_per.tyRefCursor
    )
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'GetCuponByCont';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
         
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        -- Si el tipo de impresion es anticipo
        IF inuTipoImpre = 1 THEN
            open orfCupones for
                WITH solicitudes AS
                (
                    SELECT  mt.package_id, mt.motive_type_id
                    FROM    mo_motive mt, mo_packages m
                    WHERE   mt.package_id = m.package_id
                    AND     m.package_type_id = inuPackType
                    AND     mt.subscription_id = inuSubscripId
                )
                SELECT c.CUPONUME,
                        c.cupofech FECHA_REGISTRO,
                        c.cupovalo VALOR,
                        c.cupotipo TIPO_CUPON,
                        c.cuposusc CONTRATO,
                        c.cupodocu DOCUMENTO_SOPORTE
                FROM mo_package_payment mpp,
                     mo_motive_payment mmp,
                     cupon c,
                     solicitudes
                WHERE mpp.PACKAGE_id = solicitudes.package_id
                AND mpp.package_payment_id = mmp.package_payment_id
                AND c.cuponume = mmp.coupon_id
                AND mmp.active = 'Y'
                AND c.cupotipo <> 'PP'
                ORDER BY c.cupofech desc;
        
        -- Si el tipo de impresion es pagare
        ELSIF inuTipoImpre = 2 THEN
            open orfCupones for
                SELECT distinct
                       pagacofi CUPONUME,
                       pagafech FECHA_REGISTRO,
                       pagavtdi VALOR,
                       'PA' TIPO_CUPON,
                       difesusc CONTRATO,
                       difenudo DOCUMENTO_SOPORTE
                FROM pagare, diferido
                WHERE pagacofi = difecofi
                AND difesusc = inuSubscripId
                ORDER BY pagafech desc;

        -- Si el tipo de impresion es cupon
        ELSIF inuTipoImpre = 3 THEN
            open orfCupones for
                SELECT  c.CUPONUME,
                        c.cupofech FECHA_REGISTRO,
                        c.cupovalo VALOR,
                        c.cupotipo TIPO_CUPON,
                        c.cuposusc CONTRATO,
                        c.cupodocu DOCUMENTO_SOPORTE
                FROM mo_packages mp,
                     cupon c
                WHERE TO_NUMBER(c.cupodocu) = mp.package_id
                AND c.cupotipo = 'DE'
                AND mp.package_type_id = inuPackType
                AND c.cuposusc = inuSubscripId
                ORDER BY c.cupofech desc;

        -- En caso de que llegue nulo
        ELSE
            open orfCupones for
                SELECT NULL CUPONUME,
                       NULL FECHA_REGISTRO,
                       NULL VALOR,
                       NULL TIPO_CUPON,
                       NULL CONTRATO,
                       NULL DOCUMENTO_SOPORTE
                FROM DUAL;

        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN       
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);               
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END GetCuponByCont;
    
    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : pSaveFile
    Descripcion    : Almacena el archivo en la base de datos
    Autor          : Horbath
    Fecha          : 23/09/2020

    Nombre         :
    Parametros         Descripcion
    ============  ===================
    orfPackType   Cursor con los tipos de solicitud

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
    PROCEDURE pSaveFile
    (
        inuCuponId      in  cupon.cuponume%TYPE,
        isbNameFile     in  LDC_CUPON_EMAIL.name_file%TYPE,
        iblFile         in  LDC_CUPON_EMAIL.cupon_file%TYPE,
        isbCorreo       in  LDC_CUPON_EMAIL.email_%TYPE,
        inuPackageId    IN  LDC_CUPON_EMAIL.tipo_soli%type
    )
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pSaveFile';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
        CURSOR cuExiste
        IS
            SELECT count(1)
            FROM   LDC_CUPON_EMAIL
            WHERE  LDC_CUPON_EMAIL.cod_cupon = inuCuponId;
            
        nuExiste    NUMBER;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        OPEN cuExiste;
        FETCH cuExiste INTO nuExiste;
        CLOSE cuExiste;

        IF nuExiste = 0 THEN
            INSERT INTO LDC_CUPON_EMAIL(COD_CUPON, NAME_FILE, CUPON_FILE, EMAIL_,tipo_soli)
            VALUES(inuCuponId, isbNameFile, iblFile, isbCorreo,inuPackageId);
        ELSE
            UPDATE LDC_CUPON_EMAIL
                SET NAME_FILE = isbNameFile,
                    CUPON_FILE = iblFile,
                    EMAIL_ = isbCorreo,
                    tipo_soli = inuPackageId
            WHERE COD_CUPON = inuCuponId;
        
        END IF;
        
        COMMIT;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN       
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);               
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END pSaveFile;
    /*****************************************************************
    Propiedad intelectual de PETI (c).
    Unidad         : pEnvioCorreo
    Descripcion    : Envia archivo del cupon por correo electronico
  ******************************************************************/
    PROCEDURE pSendMail
    (
        isbFileName      IN      VARCHAR2,
        isbRuta          IN      VARCHAR2,
        isbExtension     IN      VARCHAR2,
        isbReceptor      IN      VARCHAR2,
        inuPackageType   IN      LDC_CUPON_EMAIL.tipo_soli%type
    )
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pSendMail';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
            
        CURSOR cuGetData
        (
            inuPackageType   IN      LDC_CUPON_EMAIL.tipo_soli%type
        )
        IS
            SELECT SENDER,
            SUBJECT,
            CONTENT
            FROM LDC_CONF_SEND_MAIL
            WHERE PACKAGE_TYPE_ID = inuPackageType;

        rcData          cuGetData%rowtype;
        nuErrorCode     NUMBER;
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
         
        OPEN cuGetData(inuPackageType);
        FETCH cuGetData INTO rcData;
        close cuGetData;
                
        IF rcData.SENDER IS NULL THEN

            pkg_error.setErrorMessage( isbMsgErrr => 'No existe configuración para el tipo de solicitud ['||inuPackageType||']. Favor validar en LDCMAIL' );   

        END IF;
        
        -- Ojo: depende de la entrega donde se agrega iblElevaErrores
        pkg_Correo.prcEnviaCorreo
        (
            isbRemitente        => rcData.SENDER,
            isbDestinatarios    => isbReceptor,
            isbAsunto           => rcData.SUBJECT,
            isbMensaje          => rcData.CONTENT,
            isbArchivos         => isbRuta || '/' || isbFileName,
            iblElevaErrores     => TRUE
        );         
            
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN       
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);               
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END pSendMail;
    
    /*****************************************************************
    Propiedad intelectual de PETI (c).
    Unidad         : pEnvioCorreo
    Descripcion    : Envia archivo del cupon por correo electronico
    
    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    23-06-2021      Horbath             CA684: Se modifica para tener en cuenta el nuevo
                                        parametro inuTipoImpre y asi validar la extension del archivo
    20-06-2024      felipe.valencia     OSF-2866: Se modifica ruta de archivo 
                                        por modificación correo electronico v8
  ******************************************************************/
    PROCEDURE pEnvioCorreo
    (
        inuCuponId      IN      cupon.cuponume%type,
        inuTipoImpre    IN      NUMBER
    )
    
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pEnvioCorreo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);      
    
        csbFileType     constant VARCHAR2(10) := 'pdf';
        csbFileTypeHtml constant VARCHAR2(10) := 'html';
        csbRuta         CONSTANT VARCHAR2(100) := '/tmp';

        nuCount         NUMBER;

        blDataBlob      LDC_CUPON_EMAIL.cupon_file%type := EMPTY_BLOB();
        blDataAux       LDC_CUPON_EMAIL.cupon_file%type := EMPTY_BLOB();
        nuLength        NUMBER := 0;
        nuValueX        NUMBER := 0;
        sbFileName      LDC_CUPON_EMAIL.name_file%type;
        
        ftFileOutput    pkg_gestionArchivos.styArchivo;
        nuStart         NUMBER := 1;
        nuBytelength    NUMBER := 32000;
        rwData          RAW(32000);
        boExistsFile    BOOLEAN;
        nuLengthBytes   NUMBER;
        nuBlocks        NUMBER;
        sbExtenFile     VARCHAR2(10);
        
        nuPackageType   LDC_CUPON_EMAIL.tipo_soli%type;
        sbEmailReceptor LDC_CUPON_EMAIL.email_%type;
        
        CURSOR cuGetFileBlob
        (
            inuCupon        IN      cupon.cuponume%type
        )
        IS
            SELECT cupon_file,
            name_file,
            tipo_soli,
            email_
            FROM LDC_CUPON_EMAIL
            WHERE cod_cupon = inuCupon;

        CURSOR cuCuentaCupones
        (
            inuCupon        IN      cupon.cuponume%type
        )
        IS
        SELECT count(1)
        FROM LDC_CUPON_EMAIL
        WHERE cod_cupon = inuCupon;
    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        IF (cuCuentaCupones%ISOPEN) THEN
            CLOSE cuCuentaCupones;
        END IF;

        OPEN cuCuentaCupones(inuCuponId);
        FETCH cuCuentaCupones INTO nuCount;
        CLOSE cuCuentaCupones;
        
        IF nuCount = 0 THEN
        
            pkg_error.setErrorMessage( isbMsgErrr => 'No existen datos asociados al cupon' );  
        
        END IF;
        
        sbExtenFile := csbFileType;
        
        IF inuTipoImpre = 2 THEN
            sbExtenFile := csbFileTypeHtml;
        END IF;

        IF (cuGetFileBlob%ISOPEN) THEN
            CLOSE cuGetFileBlob;
        END IF;

        OPEN cuGetFileBlob(inuCuponId);
        FETCH cuGetFileBlob INTO blDataBlob,sbFileName,nuPackageType,sbEmailReceptor;
        CLOSE cuGetFileBlob;
        
        sbFileName := sbFileName || '.'||sbExtenFile;
        
        pkg_gestionArchivos.prcAtributosArchivo_SMF( csbRuta, sbFileName, boExistsFile, nuLengthBytes, nuBlocks);
        
        IF boExistsFile THEN
        
            pkg_gestionArchivos.prcBorrarArchivo_SMF(csbRuta, sbFileName);
        
        END IF;
        
        ftFileOutput := pkg_gestionArchivos.ftAbrirArchivo_SMF(csbRuta, sbFileName,'wb');

        nuStart := 1;
        nuBytelength := 32000;
        
        blDataAux := blDataBlob;
        
        nuLength := dbms_lob.getlength(blDataAux);

        nuValueX := nuLength;
        
        IF nuLength < 32760 THEN
            pkg_gestionArchivos.prcEscribeSegmentoBinario_SMF(ftFileOutput,blDataBlob, TRUE);
            pkg_gestionArchivos.prcCerrarArchivo_SMF(ftFileOutput,csbRuta, sbFileName);
        ELSE -- write in pieces
            nuStart := 1;
            WHILE nuStart < nuLength and nuBytelength > 0
            LOOP
               dbms_lob.read(blDataBlob,nuBytelength,nuStart,rwData);
                
               pkg_gestionArchivos.prcEscribeSegmentoBinario_SMF(ftFileOutput,rwData,TRUE);

               -- set the start position for the next cut
               nuStart := nuStart + nuBytelength;

               -- set the end position if less than 32000 bytes
               nuValueX := nuValueX - nuBytelength;
               IF nuValueX < 32000 THEN
                  nuBytelength := nuValueX;
               END IF;
            END LOOP;

            pkg_gestionArchivos.prcCerrarArchivo_SMF(ftFileOutput,csbRuta, sbFileName);

        END IF;

        IF sbExtenFile = csbFileTypeHtml THEN       
            pSendMail(sbFileName,csbRuta,csbFileType,sbEmailReceptor,nuPackageType);
        ELSE
            pSendMail(sbFileName,'XML_DIR',csbFileType,sbEmailReceptor,nuPackageType);
        END IF;        
        
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN       
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);               
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END pEnvioCorreo;
    
    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : GetTipoImpByTipoSoli
    Descripcion    : Obtiene el tipo de impresion dada la solicitud
    Autor          : Horbath
    Fecha          : 23/09/2020

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    23-06-2021      Horbath             CA684: Creacion
  ******************************************************************/
    PROCEDURE GetTipoImpByTipoSoli
    (
        inuPackType     in  ps_package_type.package_type_id%TYPE,
        onuTipoImpre    out  NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'GetTipoImpByTipoSoli';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
        CURSOR cuTipoImpresion
        IS
            SELECT tipo_impresion
            FROM LDC_CONF_SEND_MAIL
            WHERE LDC_CONF_SEND_MAIL.package_type_id = inuPackType;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio); 
        
        OPEN cuTipoImpresion;
        FETCH cuTipoImpresion INTO onuTipoImpre;
        CLOSE cuTipoImpresion;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN       
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);               
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END GetTipoImpByTipoSoli;

END LDC_BoLDSEMAIL;
/

