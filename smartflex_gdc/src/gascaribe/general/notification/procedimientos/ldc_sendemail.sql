create or replace PROCEDURE  LDC_SENDEMAIL (recipients   VARCHAR2,
                            subject    VARCHAR2,
                            message    VARCHAR2) IS
                            
   --                    .///.
    --                   (0 o)
    ---------------0000--(_)--0000---------------
    --
    --  Alexander Beltran
    --  alexander.beltran@surtigas.co
    --
    --             oooO      Oooo
    --------------(   )-----(   )---------------
    --             \ (       ) /
    --              \_)     (_/
                          
 /*****************************************************************
  Propiedad intelectual de PETI (c).
  
  Unidad         : LDC_Sendemail
  Descripcion    : Procedimiento para envio de correo simple.
  Autor          : Alexander Beltran
  Fecha          : 28/01/2013
  
  Parametros              Descripcion
  ============         ===================
  recipients           Destinatarios de Correo, personal al que se envia el mensaje.
  subject              Asunto del Mensaje
  message              Cuerpo del Mensaje, Texto del correo.
  
  Fecha             Autor               Modificacion
  =========         =========           ====================
  20/03/2024        jcatuchemvm         OSF-2336: Estandarización de traza, control de errores, validación de ambiente para actualizar asunto
                                        validación de remitentes, estandarización de separadores de correo
  28/01/2013        Alexander Beltran   Creación
  ******************************************************************/                           
    -- Constantes para el control de la traza
    csbProcedimiento    CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;                -- Constante para nombre de función    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado                        
                            
    sberror             VARCHAR2(4000);
    nuerror             NUMBER;
    
    smtp_host       VARCHAR2(256);
    smtp_port       PLS_INTEGER;
    smtp_domain     VARCHAR2(256);
    sender          VARCHAR2(250);
            
    sbDestinatarios VARCHAR2(2000);
    sbAsunto        VARCHAR2(2000);
    sbAmbiente      VARCHAR2(30);
    
    cursor cuDestinatarios (isbrecipients in varchar2) is
    SELECT trim(regexp_substr(isbrecipients,'[^;]+',1,LEVEL)) AS correo FROM dual
    CONNECT BY regexp_substr(isbrecipients,'[^;]+', 1, LEVEL) IS NOT NULL;
    
    
    
    procedure sendemail(isbrecipients in varchar2) is
        csbMetodo       CONSTANT VARCHAR2(100) := csbProcedimiento||'.sendemail';
        conn            utl_smtp.connection;
    begin
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('isbrecipients <= '||isbrecipients, csbNivelTraza);
        
        conn := utl_smtp.open_connection(smtp_host, smtp_port);
        utl_smtp.helo(conn, smtp_domain);

        -- Specify sender's address (our server allows bogus address
        -- as long as it is a full email address (xxx@yyy.com).
        utl_smtp.mail(conn, sender);

        -- Specify recipient(s) of the email.
        utl_smtp.rcpt(conn, isbrecipients); 

        -- Start body of email
        utl_smtp.open_data(conn);

        -- Set "From" MIME header
        utl_smtp.write_data(conn, 'From:'|| sender|| utl_tcp.CRLF);

        -- Set "To" MIME header
        utl_smtp.write_data(conn, 'To:'|| isbrecipients|| utl_tcp.CRLF);

        -- Set "Subject" MIME header
        utl_smtp.write_data(conn, 'Subject:'|| sbAsunto|| utl_tcp.CRLF);

        -- Set "Mime-Version" MIME header
        utl_smtp.write_data(conn, 'Mime-Version:'|| '1.0'|| utl_tcp.CRLF);

        -- Set "Content-Type" MIME header
        utl_smtp.write_data(conn, 'Content-Type:'|| 'text/html'|| utl_tcp.CRLF);

        -- Send an empty line to denotes end of MIME headers and
        -- beginning of message body.
        utl_smtp.write_data(conn, utl_tcp.CRLF);

        utl_smtp.write_data(conn, message);
        utl_smtp.close_data(conn);
        utl_smtp.quit(conn);
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);        
    exception 
        when pkg_Error.Controlled_Error then
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            ldcbi_log( 'LDC_SENDEMAIL', null, csbFin_Erc|| ':' || isbrecipients || chr(10) || '***' || chr(10) || sbAsunto || chr(10) || '***' || chr(10) || message, nuError, sbError );
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        when OTHERS then
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            ldcbi_log( 'LDC_SENDEMAIL', null, csbFin_Err|| ':' || isbrecipients || chr(10) || '***' || chr(10) || sbAsunto || chr(10) || '***' || chr(10) || message, nuError, sbError );
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    end sendemail;
   
BEGIN    
    pkg_traza.trace(csbProcedimiento, csbNivelTraza, csbInicio);
    pkg_traza.trace('recipients <= '||recipients, csbNivelTraza);
    pkg_traza.trace('subject    <= '||subject, csbNivelTraza);
    pkg_traza.trace('message    <= '||message, csbNivelTraza);
    
    smtp_host   := DALD_PARAMETER.fsbGetValue_Chain('LDC_SMTP_HOST');
    smtp_port   := DALD_PARAMETER.fnuGetNumeric_Value('LDC_SMTP_PORT');
    smtp_domain := DALD_PARAMETER.fsbgetvalue_chain('LDC_SMTP_DOMAIN');
    sender      := DALD_PARAMETER.fsbGetValue_Chain('LDC_SMTP_SENDER'); 
    
    sbDestinatarios := recipients;
    sbAmbiente := ldc_boConsGenerales.fsbGetDatabaseDesc;
    sbAmbiente := CASE WHEN sbAmbiente IS NOT NULL THEN 'BD '||sbAmbiente||': ' ELSE '' END;
    sbAsunto := sbAmbiente||subject;
    
    --Estandarización de separadores
    if instr(sbDestinatarios,',') > 0 then
        sbDestinatarios := replace(sbDestinatarios,',',';');
    elsif instr(sbDestinatarios,'|') > 0 then
        sbDestinatarios := replace(sbDestinatarios,'|',';');
    end if;
    
    --Validación para recorrido en loop
    if instr(sbDestinatarios,';') > 0 then
        pkg_traza.trace('Envio de correo a más de un destinatario', csbNivelTraza);
        for rc in cuDestinatarios(sbDestinatarios) loop
            sendemail(rc.correo);
        end loop;
    else
        pkg_traza.trace('Envio de correo a un destinatario', csbNivelTraza);
        sendemail(sbDestinatarios);
    end if;   
    
    pkg_traza.trace(csbProcedimiento, csbNivelTraza, csbFin);
    
EXCEPTION
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
        ldcbi_log( 'LDC_SENDEMAIL', null, csbFin_Err|| ':' || recipients || chr(10) || '***' || chr(10) || subject || chr(10) || '***' || chr(10) || message, nuError, sbError );
        pkg_traza.trace(csbProcedimiento, csbNivelTraza, csbFin_Err);
END;
/