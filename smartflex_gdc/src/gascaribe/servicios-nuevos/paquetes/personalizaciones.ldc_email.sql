CREATE OR REPLACE PACKAGE PERSONALIZACIONES.LDC_Email IS

  ----------------------- Customizable Section -----------------------

  -- Customize the SMTP host, port and your domain name below.
  --smtp_host   VARCHAR2(256) := '172.17.8.62';
  smtp_host   VARCHAR2(256) := ldc_bcConsGenerales.fsbValorColumna('OPEN.GE_PARAMETER',
                                                                   'VALUE',
                                                                   'PARAMETER_ID',
                                                                   'HOST_MAIL');
  --OPEN.DAGE_PARAMETER.FSBGETVALUE('HOST_MAIL',NULL);--'192.168.10.110';
  --smtp_port   PLS_INTEGER := 25;
  smtp_port   PLS_INTEGER := TO_NUMBER(ldc_bcConsGenerales.fsbValorColumna('OPEN.GE_PARAMETER',
                                                                           'VALUE',
                                                                           'PARAMETER_ID',
                                                                           'HOST_MAIL_PORT'));
  --TO_NUMBER(OPEN.DAGE_PARAMETER.FSBGETVALUE('HOST_MAIL_PORT',NULL));-- 26;
  smtp_domain VARCHAR2(256) := 'gasesdeoccidente.com';

  -- Customize the signature that will appear in the email's MIME header.
  -- Useful for versioning.
  MAILER_ID CONSTANT VARCHAR2(256) := 'Mailer by Oracle UTL_SMTP';

  --------------------- End Customizable Section ---------------------

  -- A unique string that demarcates boundaries of parts in a multi-part email
  -- The string should not appear inside the body of any part of the email.
  -- Customize this if needed or generate this randomly dynamically.
  BOUNDARY CONSTANT VARCHAR2(256) := '-----7D81B75CCC90D2974F7A1CBD';

  FIRST_BOUNDARY CONSTANT VARCHAR2(256) := '--' || BOUNDARY || utl_tcp.CRLF;
  LAST_BOUNDARY  CONSTANT VARCHAR2(256) := '--' || BOUNDARY || '--' ||
                                           utl_tcp.CRLF;

  -- A MIME type that denotes multi-part email (MIME) messages.
  MULTIPART_MIME_TYPE   CONSTANT VARCHAR2(256) := 'multipart/mixed; boundary="' ||
                                                  BOUNDARY || '"';
  MAX_BASE64_LINE_WIDTH CONSTANT PLS_INTEGER := 76 / 4 * 3;

  -- A simple email API for sending email in plain text in a single call.
  -- The format of an email address is one of these:
  --   someone@some-domain
  --   "Someone at some domain" <someone@some-domain>
  --   Someone at some domain <someone@some-domain>
  -- The recipients is a list of email addresses  separated by
  -- either a "," or a ";"
  PROCEDURE mail(sender     IN VARCHAR2,
                 recipients IN VARCHAR2,
                 subject    IN VARCHAR2,
                 message    IN VARCHAR2);

    -- A simple email API for sending email in plain text in a single call.
  -- The format of an email address is one of these:
  --   someone@some-domain
  --   "Someone at some domain" <someone@some-domain>
  --   Someone at some domain <someone@some-domain>
  -- The recipients is a list of email addresses  separated by
  -- either a "," or a ";"
  -- Con copia y con copia oculta
  PROCEDURE mailcc(sender     IN VARCHAR2,
                   recipients IN VARCHAR2,
                   recip_CC   IN VARCHAR2 DEFAULT NULL,
                   recip_BCC  IN VARCHAR2 DEFAULT NULL,
                   subject    IN VARCHAR2,
                   message    IN VARCHAR2);

  -- Extended email API to send email in HTML or plain text with no size limit.
  -- First, begin the email by begin_mail(). Then, call write_text() repeatedly
  -- to send email in ASCII piece-by-piece. Or, call write_mb_text() to send
  -- email in non-ASCII or multi-byte character set. End the email with
  -- end_mail().
  FUNCTION begin_mail(sender     IN VARCHAR2,
                      recipients IN VARCHAR2,
                      subject    IN VARCHAR2,
                      mime_type  IN VARCHAR2 DEFAULT 'text/plain',
                      priority   IN PLS_INTEGER DEFAULT NULL)
    RETURN utl_smtp.connection;

  -- Extended email API to send email in HTML or plain text with no size limit.
  -- First, begin the email by begin_mail(). Then, call write_text() repeatedly
  -- to send email in ASCII piece-by-piece. Or, call write_mb_text() to send
  -- email in non-ASCII or multi-byte character set. End the email with
  -- end_mail().
  FUNCTION begin_mailcc(sender     IN VARCHAR2,
                        recipients IN VARCHAR2,
                        recip_CC   IN VARCHAR2 DEFAULT NULL,
                        recip_BCC  IN VARCHAR2 DEFAULT NULL,
                        subject    IN VARCHAR2,
                        mime_type  IN VARCHAR2 DEFAULT 'text/plain',
                        priority   IN PLS_INTEGER DEFAULT NULL)
    RETURN utl_smtp.connection;

  -- Write email body in ASCII
  PROCEDURE write_text(conn    IN OUT NOCOPY utl_smtp.connection,
                       message IN VARCHAR2);

  -- Write email body in non-ASCII (including multi-byte). The email body
  -- will be sent in the database character set.
  PROCEDURE write_mb_text(conn    IN OUT NOCOPY utl_smtp.connection,
                          message IN VARCHAR2);

  -- Write email body in binary
  PROCEDURE write_raw(conn    IN OUT NOCOPY utl_smtp.connection,
                      message IN RAW);

  -- APIs to send email with attachments. Attachments are sent by sending
  -- emails in "multipart/mixed" MIME format. Specify that MIME format when
  -- beginning an email with begin_mail().

  -- Send a single text attachment.
  PROCEDURE attach_text(conn      IN OUT NOCOPY utl_smtp.connection,
                        data      IN VARCHAR2,
                        mime_type IN VARCHAR2 DEFAULT 'text/plain',
                        inline    IN BOOLEAN DEFAULT TRUE,
                        filename  IN VARCHAR2 DEFAULT NULL,
                        last      IN BOOLEAN DEFAULT FALSE);

  -- Envia un archivo texto grande, usa path
  PROCEDURE attach_text_large(conn      IN OUT NOCOPY utl_smtp.connection,
                              sbPath    IN VARCHAR2,
                              filename  IN VARCHAR2,
                              mime_type IN VARCHAR2 DEFAULT 'text/plain',
                              last      IN BOOLEAN DEFAULT FALSE);

  -- Envia un archivo grande texto, usa directory en lugar de path
  PROCEDURE attach_raw_large(conn         IN OUT NOCOPY utl_smtp.connection,
                             sbDir        IN VARCHAR2,
                             filename     IN VARCHAR2,
                             mime_type    IN VARCHAR2 DEFAULT 'application/octet',
                             last         IN BOOLEAN DEFAULT FALSE);
  -- Envia un archivo grande sea binario o texto, usa directory en lugar de path
  PROCEDURE attach_raw_large2(conn         IN OUT NOCOPY utl_smtp.connection,
                              sbDir        IN VARCHAR2,
                              filename     IN VARCHAR2,
                              mime_type    IN VARCHAR2 DEFAULT 'application/octet',
                              last         IN BOOLEAN DEFAULT FALSE,
                              transfer_enc IN VARCHAR2 DEFAULT NULL);


  -- Send a binary attachment. The attachment will be encoded in Base-64
  -- encoding format.
  PROCEDURE attach_base64(conn      IN OUT NOCOPY utl_smtp.connection,
                          data      IN RAW,
                          mime_type IN VARCHAR2 DEFAULT 'application/octet',
                          inline    IN BOOLEAN DEFAULT TRUE,
                          filename  IN VARCHAR2 DEFAULT NULL,
                          last      IN BOOLEAN DEFAULT FALSE);

  -- Send an attachment with no size limit. First, begin the attachment
  -- with begin_attachment(). Then, call write_text repeatedly to send
  -- the attachment piece-by-piece. If the attachment is text-based but
  -- in non-ASCII or multi-byte character set, use write_mb_text() instead.
  -- To send binary attachment, the binary content should first be
  -- encoded in Base-64 encoding format using the demo package for 8i,
  -- or the native one in 9i. End the attachment with end_attachment.
  PROCEDURE begin_attachment(conn         IN OUT NOCOPY utl_smtp.connection,
                             mime_type    IN VARCHAR2 DEFAULT 'text/plain',
                             inline       IN BOOLEAN DEFAULT TRUE,
                             filename     IN VARCHAR2 DEFAULT NULL,
                             transfer_enc IN VARCHAR2 DEFAULT NULL);

  -- End the attachment.
  PROCEDURE end_attachment(conn IN OUT NOCOPY utl_smtp.connection,
                           last IN BOOLEAN DEFAULT FALSE);

  -- End the email.
  PROCEDURE end_mail(conn IN OUT NOCOPY utl_smtp.connection);

  -- Extended email API to send multiple emails in a session for better
  -- performance. First, begin an email session with begin_session.
  -- Then, begin each email with a session by calling begin_mail_in_session
  -- instead of begin_mail. End the email with end_mail_in_session instead
  -- of end_mail. End the email session by end_session.
  FUNCTION begin_session RETURN utl_smtp.connection;

  -- Begin an email in a session.
  PROCEDURE begin_mail_in_session(conn       IN OUT NOCOPY utl_smtp.connection,
                                  sender     IN VARCHAR2,
                                  recipients IN VARCHAR2,
                                  subject    IN VARCHAR2,
                                  mime_type  IN VARCHAR2 DEFAULT 'text/plain',
                                  priority   IN PLS_INTEGER DEFAULT NULL);

  -- Begin an email in a session con copia y con copia oculta.
  PROCEDURE begin_mail_in_sessioncc(conn       IN OUT NOCOPY utl_smtp.connection,
                                    sender     IN VARCHAR2,
                                    recipients IN VARCHAR2,
                                    recip_CC   IN VARCHAR2 DEFAULT NULL,
                                    recip_BCC  IN VARCHAR2 DEFAULT NULL,
                                    subject    IN VARCHAR2,
                                    mime_type  IN VARCHAR2 DEFAULT 'text/plain',
                                    priority   IN PLS_INTEGER DEFAULT NULL);

  -- End an email in a session.
  PROCEDURE end_mail_in_session(conn IN OUT NOCOPY utl_smtp.connection);

  -- End an email session.
  PROCEDURE end_session(conn IN OUT NOCOPY utl_smtp.connection);


  FUNCTION get_address(addr_list IN OUT VARCHAR2) RETURN VARCHAR2;

  FUNCTION get_file(file_list IN OUT VARCHAR2) RETURN VARCHAR2;

  PROCEDURE write_mime_header(conn  IN OUT NOCOPY utl_smtp.connection,
                              name  IN VARCHAR2,
                              value IN VARCHAR2);

  PROCEDURE write_boundary(conn IN OUT NOCOPY utl_smtp.connection,
                           last IN BOOLEAN DEFAULT FALSE);


END;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.LDC_Email IS

  -- Return the next email address in the list of email addresses, separated
  -- by either a "," or a ";".  The format of mailbox may be in one of these:
  --   someone@some-domain
  --   "Someone at some domain" <someone@some-domain>
  --   Someone at some domain <someone@some-domain>
  FUNCTION get_address(addr_list IN OUT VARCHAR2) RETURN VARCHAR2 IS

    addr VARCHAR2(256);
    i    pls_integer;

    FUNCTION lookup_unquoted_char(str IN VARCHAR2, chrs IN VARCHAR2)
      RETURN pls_integer AS
      c            VARCHAR2(5);
      i            pls_integer;
      len          pls_integer;
      inside_quote BOOLEAN;
    BEGIN
      inside_quote := false;
      i            := 1;
      len          := length(str);
      WHILE (i <= len) LOOP

        c := substr(str, i, 1);

        IF (inside_quote) THEN
          IF (c = '"') THEN
            inside_quote := false;
          ELSIF (c = '\') THEN
            i := i + 1; -- Skip the quote character
          END IF;
          GOTO next_char;
        END IF;

        IF (c = '"') THEN
          inside_quote := true;
          GOTO next_char;
        END IF;

        IF (instr(chrs, c) >= 1) THEN
          RETURN i;
        END IF;

        <<next_char>>
        i := i + 1;

      END LOOP;

      RETURN 0;

    END;

  BEGIN

    addr_list := ltrim(addr_list);
    i         := lookup_unquoted_char(addr_list, ',;');
    IF (i >= 1) THEN
      addr      := substr(addr_list, 1, i - 1);
      addr_list := substr(addr_list, i + 1);
    ELSE
      addr      := addr_list;
      addr_list := '';
    END IF;

    i := lookup_unquoted_char(addr, '<');
    IF (i >= 1) THEN
      addr := substr(addr, i + 1);
      i    := instr(addr, '>');
      IF (i >= 1) THEN
        addr := substr(addr, 1, i - 1);
      END IF;
    END IF;

    RETURN addr;
  END;

  -- Obtiene el proximo nombre de archivo de una lista de archivo separados por "," o ";"
  FUNCTION get_file(file_list IN OUT VARCHAR2) RETURN VARCHAR2 IS

    sbfile VARCHAR2(256);
    i      pls_integer;

    FUNCTION lookup_unquoted_char(str IN VARCHAR2, chrs IN VARCHAR2)
      RETURN pls_integer AS
      c            VARCHAR2(5);
      i            pls_integer;
      len          pls_integer;
    BEGIN
      i            := 1;
      len          := length(str);
      WHILE (i <= len) LOOP

        c := substr(str, i, 1);

        IF (instr(chrs, c) >= 1) THEN
          RETURN i;
        END IF;

        i := i + 1;

      END LOOP;

      RETURN 0;

    END;

  BEGIN

    file_list := ltrim(file_list);
    i         := lookup_unquoted_char(file_list, ',;');
    IF (i >= 1) THEN
      sbfile    := substr(file_list, 1, i - 1);
      file_list := substr(file_list, i + 1);
    ELSE
      sbfile    := file_list;
      file_list := '';
    END IF;

    RETURN sbfile;
  END;

  -- Write a MIME header
  PROCEDURE write_mime_header(conn  IN OUT NOCOPY utl_smtp.connection,
                              name  IN VARCHAR2,
                              value IN VARCHAR2) IS
  BEGIN
    utl_smtp.write_data(conn, name || ': ' || value || utl_tcp.CRLF);
  END;

  -- Mark a message-part boundary.  Set <last> to TRUE for the last boundary.
  PROCEDURE write_boundary(conn IN OUT NOCOPY utl_smtp.connection,
                           last IN BOOLEAN DEFAULT FALSE) AS
  BEGIN
    IF (last) THEN
      utl_smtp.write_data(conn, LAST_BOUNDARY);
    ELSE
      utl_smtp.write_data(conn, FIRST_BOUNDARY);
    END IF;
  END;

  ------------------------------------------------------------------------
  PROCEDURE mail(sender     IN VARCHAR2,
                 recipients IN VARCHAR2,
                 subject    IN VARCHAR2,
                 message    IN VARCHAR2) IS
    conn utl_smtp.connection;
  BEGIN
    conn := begin_mail(sender, recipients, subject);
    write_text(conn, message);
    end_mail(conn);
  END;

 ------------------------------------------------------------------------
  PROCEDURE mailcc(sender     IN VARCHAR2,
                   recipients IN VARCHAR2,
                   recip_CC   IN VARCHAR2 DEFAULT NULL,
                   recip_BCC  IN VARCHAR2 DEFAULT NULL,
                   subject    IN VARCHAR2,
                   message    IN VARCHAR2) IS
    conn utl_smtp.connection;
  BEGIN
    conn := begin_mailcc(sender, recipients, recip_CC, recip_BCC, subject);
    write_text(conn, message);
    end_mail(conn);
  END;

  ------------------------------------------------------------------------
  FUNCTION begin_mail(sender     IN VARCHAR2,
                      recipients IN VARCHAR2,
                      subject    IN VARCHAR2,
                      mime_type  IN VARCHAR2 DEFAULT 'text/plain',
                      priority   IN PLS_INTEGER DEFAULT NULL)
    RETURN utl_smtp.connection IS
    conn utl_smtp.connection;
  BEGIN
    conn := begin_session;
    begin_mail_in_session(conn,
                          sender,
                          recipients,
                          subject,
                          mime_type,
                          priority);
    RETURN conn;
  END;


  ------------------------------------------------------------------------
  FUNCTION begin_mailcc(sender     IN VARCHAR2,
                      recipients IN VARCHAR2,
                      recip_CC   IN VARCHAR2 DEFAULT NULL,
                      recip_BCC  IN VARCHAR2 DEFAULT NULL,
                      subject    IN VARCHAR2,
                      mime_type  IN VARCHAR2 DEFAULT 'text/plain',
                      priority   IN PLS_INTEGER DEFAULT NULL)
    RETURN utl_smtp.connection IS
    conn utl_smtp.connection;
  BEGIN
    conn := begin_session;
    begin_mail_in_sessioncc(conn,
                          sender,
                          recipients,
                          recip_CC,
                          recip_BCC,
                          subject,
                          mime_type,
                          priority);
    RETURN conn;
  END;

  ------------------------------------------------------------------------
  PROCEDURE write_text(conn    IN OUT NOCOPY utl_smtp.connection,
                       message IN VARCHAR2) IS
  BEGIN
    utl_smtp.write_data(conn, message);
  END;

  ------------------------------------------------------------------------
  PROCEDURE write_mb_text(conn    IN OUT NOCOPY utl_smtp.connection,
                          message IN VARCHAR2) IS
  BEGIN
    utl_smtp.write_raw_data(conn, utl_raw.cast_to_raw(message));
  END;

  ------------------------------------------------------------------------
  PROCEDURE write_raw(conn    IN OUT NOCOPY utl_smtp.connection,
                      message IN RAW) IS
  BEGIN
    utl_smtp.write_raw_data(conn, message);
  END;

  ------------------------------------------------------------------------
  PROCEDURE attach_text(conn      IN OUT NOCOPY utl_smtp.connection,
                        data      IN VARCHAR2,
                        mime_type IN VARCHAR2 DEFAULT 'text/plain',
                        inline    IN BOOLEAN DEFAULT TRUE,
                        filename  IN VARCHAR2 DEFAULT NULL,
                        last      IN BOOLEAN DEFAULT FALSE) IS
  BEGIN
    begin_attachment(conn, mime_type, inline, filename);
    write_text(conn, data);
    end_attachment(conn, last);
  END;

  ------------------------------------------------------------------------
  PROCEDURE attach_text_large(conn      IN OUT NOCOPY utl_smtp.connection,
                              sbPath    IN VARCHAR2,
                              filename  IN VARCHAR2,
                              mime_type IN VARCHAR2 DEFAULT 'text/plain',
                              last      IN BOOLEAN DEFAULT FALSE) IS
    v_file_handle  utl_file.file_type;
    v_line         varchar2(32000);
    data           varchar2(32000);
  BEGIN
    begin_attachment(conn, mime_type, false, filename);
    v_file_handle := utl_file.fopen(sbPath, filename, 'r');
    -- Se anexa el contenido del archivo al cuerpo del correo
    begin
      loop
        utl_file.get_line(v_file_handle, v_line);
        data := v_line||chr(10);
        write_text(conn, data);
      end loop;
    exception
      when others then
        null;
    end;
    utl_file.fclose(v_file_handle);
    end_attachment(conn, last);
  END;

  ------------------------------------------------------------------------
  PROCEDURE attach_raw_large(conn         IN OUT NOCOPY utl_smtp.connection,
                             sbDir        IN VARCHAR2,
                             filename     IN VARCHAR2,
                             mime_type    IN VARCHAR2 DEFAULT 'application/octet',
                             last         IN BOOLEAN DEFAULT FALSE) IS
    v_bfile_handle bfile;
    v_line raw(32767);
    vpi    integer;
    vcan   integer;
  BEGIN
    begin_attachment(conn, mime_type, false, filename);
    v_bfile_handle := bfilename(sbDir, filename);
    dbms_lob.fileopen(v_bfile_handle);
    -- Se anexa el contenido del archivo al cuerpo del correo
    begin
      vcan := 32767;
      vpi  := 1;
      loop
        dbms_lob.read(file_loc => v_bfile_handle, amount => vcan, offset => vpi, buffer => v_line);
        vpi := vpi + 32767;
        write_raw(conn, v_line);
      exit when vcan = 0;
      end loop;
    exception
      when others then
        null;
    end;
    dbms_lob.fileclose(v_bfile_handle);
    end_attachment(conn, last);
  END;

  ------------------------------------------------------------------------
  PROCEDURE attach_raw_large2(conn         IN OUT NOCOPY utl_smtp.connection,
                              sbDir        IN VARCHAR2,
                              filename     IN VARCHAR2,
                              mime_type    IN VARCHAR2 DEFAULT 'application/octet',
                              last         IN BOOLEAN DEFAULT FALSE,
                              transfer_enc IN VARCHAR2 DEFAULT NULL) IS
    v_bfile_handle bfile;
    v_bfile_len    number;
    v_line         raw(32767);
    vpi            integer;
    vcan           integer;
  BEGIN
    begin_attachment(conn, mime_type, false, filename, transfer_enc);
    v_bfile_handle := bfilename(sbDir, filename);
    v_bfile_len := dbms_lob.getlength(v_bfile_handle);
    dbms_lob.open(v_bfile_handle,dbms_lob.lob_readonly);
    -- Se anexa el contenido del archivo al cuerpo del correo
    vpi  := 1;
    loop
      begin
        if vpi + 57 - 1 > v_bfile_len then
           vcan := v_bfile_len - vpi + 1;
        else
           vcan := 57;
        end if;
        dbms_lob.read(file_loc => v_bfile_handle, amount => vcan, offset => vpi, buffer => v_line);
        write_raw(conn, utl_encode.base64_encode(v_line));
        vpi := vpi + 57;
        if vpi > v_bfile_len then
           exit;
        end if;
      exception
        when no_data_found then
          exit;
        when others then
          null;
      end;
    end loop;
    dbms_lob.fileclose(v_bfile_handle);
    end_attachment(conn, last);
  END;

  ------------------------------------------------------------------------
  PROCEDURE attach_base64(conn      IN OUT NOCOPY utl_smtp.connection,
                          data      IN RAW,
                          mime_type IN VARCHAR2 DEFAULT 'application/octet',
                          inline    IN BOOLEAN DEFAULT TRUE,
                          filename  IN VARCHAR2 DEFAULT NULL,
                          last      IN BOOLEAN DEFAULT FALSE) IS
    i   PLS_INTEGER;
    len PLS_INTEGER;
  BEGIN

    begin_attachment(conn, mime_type, inline, filename, 'base64');

    -- Split the Base64-encoded attachment into multiple lines
    i   := 1;
    len := utl_raw.length(data);
    WHILE (i < len) LOOP
      IF (i + MAX_BASE64_LINE_WIDTH < len) THEN
        null;
        -- utl_smtp.write_raw_data(conn,
        --utl_encode.base64_encode(utl_raw.substr(data, i,
        --MAX_BASE64_LINE_WIDTH)));
      ELSE
        --utl_smtp.write_raw_data(conn,
        -- utl_encode.base64_encode(utl_raw.substr(data, i)));
        null;
      END IF;
      utl_smtp.write_data(conn, utl_tcp.CRLF);
      i := i + MAX_BASE64_LINE_WIDTH;
    END LOOP;

    end_attachment(conn, last);

  END;

  ------------------------------------------------------------------------
  PROCEDURE begin_attachment(conn         IN OUT NOCOPY utl_smtp.connection,
                             mime_type    IN VARCHAR2 DEFAULT 'text/plain',
                             inline       IN BOOLEAN DEFAULT TRUE,
                             filename     IN VARCHAR2 DEFAULT NULL,
                             transfer_enc IN VARCHAR2 DEFAULT NULL) IS
  BEGIN
    write_boundary(conn);
    write_mime_header(conn, 'Content-Type', mime_type);

    IF (filename IS NOT NULL) THEN
      IF (inline) THEN
        write_mime_header(conn,
                          'Content-Disposition',
                          'inline; filename="' || filename || '"');
      ELSE
        write_mime_header(conn,
                          'Content-Disposition',
                          'attachment; filename="' || filename || '"');
      END IF;
    END IF;

    IF (transfer_enc IS NOT NULL) THEN
      write_mime_header(conn, 'Content-Transfer-Encoding', transfer_enc);
    END IF;

    utl_smtp.write_data(conn, utl_tcp.CRLF);
  END;

  ------------------------------------------------------------------------
  PROCEDURE end_attachment(conn IN OUT NOCOPY utl_smtp.connection,
                           last IN BOOLEAN DEFAULT FALSE) IS
  BEGIN
    utl_smtp.write_data(conn, utl_tcp.CRLF);
    IF (last) THEN
      write_boundary(conn, last);
    END IF;
  END;

  ------------------------------------------------------------------------
  PROCEDURE end_mail(conn IN OUT NOCOPY utl_smtp.connection) IS
  BEGIN
    end_mail_in_session(conn);
    end_session(conn);
  END;

  ------------------------------------------------------------------------
  FUNCTION begin_session RETURN utl_smtp.connection IS
    conn utl_smtp.connection;
  BEGIN
    -- open SMTP connection
    conn := utl_smtp.open_connection(smtp_host, smtp_port);
    utl_smtp.helo(conn, smtp_domain);
    RETURN conn;
  END;

  ------------------------------------------------------------------------
  PROCEDURE begin_mail_in_session(conn       IN OUT NOCOPY utl_smtp.connection,
                                  sender     IN VARCHAR2,
                                  recipients IN VARCHAR2,
                                  subject    IN VARCHAR2,
                                  mime_type  IN VARCHAR2 DEFAULT 'text/plain',
                                  priority   IN PLS_INTEGER DEFAULT NULL) IS
    my_sender     VARCHAR2(32767) := sender;
    my_recipients VARCHAR2(32767) := recipients;

  BEGIN

    -- Specify sender's address (our server allows bogus address
    -- as long as it is a full email address (xxx@yyy.com).
    utl_smtp.mail(conn, get_address(my_sender));

    -- Specify recipient(s) of the email.
    WHILE (my_recipients IS NOT NULL) LOOP
      utl_smtp.rcpt(conn, get_address(my_recipients));
    END LOOP;

    -- Start body of email
    utl_smtp.open_data(conn);

    -- Set "From" MIME header
    write_mime_header(conn, 'From', sender);

    -- Set "To" MIME header
    write_mime_header(conn, 'To', recipients);

    -- Set "Subject" MIME header
    write_mime_header(conn, 'Subject', subject);

    -- Set "Mime-Version" MIME header
    write_mime_header(conn, 'Mime-Version', '1.0');

    -- Set "Content-Type" MIME header
    write_mime_header(conn, 'Content-Type', mime_type);

    -- Set "X-Mailer" MIME header
    write_mime_header(conn, 'X-Mailer', MAILER_ID);

    -- Set priority:
    --   High      Normal       Low
    --   1     2     3     4     5
    IF (priority IS NOT NULL) THEN
      write_mime_header(conn, 'X-Priority', priority);
    END IF;

    -- Send an empty line to denotes end of MIME headers and
    -- beginning of message body.
    utl_smtp.write_data(conn, utl_tcp.CRLF);

    IF (mime_type LIKE 'multipart/mixed%') THEN
      write_text(conn,
                 'This is a multi-part message in MIME format.' ||
                 utl_tcp.crlf);
    END IF;

  END;


 ------------------------------------------------------------------------
  PROCEDURE begin_mail_in_sessioncc(conn       IN OUT NOCOPY utl_smtp.connection,
                                    sender     IN VARCHAR2,
                                    recipients IN VARCHAR2,
                                    recip_CC   IN VARCHAR2 DEFAULT NULL,
                                    recip_BCC  IN VARCHAR2 DEFAULT NULL,
                                    subject    IN VARCHAR2,
                                    mime_type  IN VARCHAR2 DEFAULT 'text/plain',
                                    priority   IN PLS_INTEGER DEFAULT NULL) IS
    my_sender     VARCHAR2(32767) := sender;
    my_recipients VARCHAR2(32767) := recipients;
    my_recip_CC   VARCHAR2(32767) := recip_CC;
    my_recip_BCC  VARCHAR2(32767) := recip_BCC;
  BEGIN

    -- Specify sender's address (our server allows bogus address
    -- as long as it is a full email address (xxx@yyy.com).
    utl_smtp.mail(conn, get_address(my_sender));

    -- Specify recipient(s) of the email.
    WHILE (my_recipients IS NOT NULL) LOOP
      utl_smtp.rcpt(conn, get_address(my_recipients));
    END LOOP;
    WHILE (my_recip_CC IS NOT NULL) LOOP
      utl_smtp.rcpt(conn, get_address(my_recip_CC));
    END LOOP;
    WHILE (my_recip_BCC IS NOT NULL) LOOP
      utl_smtp.rcpt(conn, get_address(my_recip_BCC));
    END LOOP;

    -- Start body of email
    utl_smtp.open_data(conn);

    -- Set "From" MIME header
    write_mime_header(conn, 'From', sender);

    -- Set "To" MIME header
    write_mime_header(conn, 'To', recipients);

    -- Set "Subject" MIME header
    write_mime_header(conn, 'Subject', subject);

    -- Set "Mime-Version" MIME header
    write_mime_header(conn, 'Mime-Version', '1.0');

    -- Set "Content-Type" MIME header
    write_mime_header(conn, 'Content-Type', mime_type);

    -- Set "X-Mailer" MIME header
    write_mime_header(conn, 'X-Mailer', MAILER_ID);

    -- Set priority:
    --   High      Normal       Low
    --   1     2     3     4     5
    IF (priority IS NOT NULL) THEN
      write_mime_header(conn, 'X-Priority', priority);
    END IF;

    -- Send an empty line to denotes end of MIME headers and
    -- beginning of message body.
    utl_smtp.write_data(conn, utl_tcp.CRLF);

    IF (mime_type LIKE 'multipart/mixed%') THEN
      write_text(conn,
                 'This is a multi-part message in MIME format.' ||
                 utl_tcp.crlf);
    END IF;

  END;

  ------------------------------------------------------------------------
  PROCEDURE end_mail_in_session(conn IN OUT NOCOPY utl_smtp.connection) IS
  BEGIN
    utl_smtp.close_data(conn);
  END;

  ------------------------------------------------------------------------
  PROCEDURE end_session(conn IN OUT NOCOPY utl_smtp.connection) IS
  BEGIN
    utl_smtp.quit(conn);
  END;

END;
/

GRANT execute on PERSONALIZACIONES.LDC_Email to ROLE_DESARROLLOOSF;
/

GRANT execute on PERSONALIZACIONES.LDC_Email to PERSONALIZACIONES;
/

GRANT execute on PERSONALIZACIONES.LDC_Email to SYSTEM_OBJ_PRIVS_ROLE;
/