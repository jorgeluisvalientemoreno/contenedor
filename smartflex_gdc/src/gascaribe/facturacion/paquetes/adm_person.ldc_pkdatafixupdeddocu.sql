CREATE OR REPLACE PACKAGE adm_person.LDC_PKDATAFIXUPDEDDOCU IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    23/07/2024              PAcosta         OSF-2952: Cambio de esquema ADM_PERSON                              
    **************************************************************/
    
  TYPE Ttb_archivo_texto IS TABLE OF CLOB;
  CAMPOS_SPOOLTXT CLOB := NULL;
  FAACTURATXT CLOB := NULL;

  /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : GENERAFACTXML
    Descripcion    : Ejecuta el formato y genera el XML de La Factura
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    20/11/2017      JBRITO              Creacion.
    ******************************************************************/
  PROCEDURE GENERAFACTXML(ID_FORMATO ED_FORMATO.FORMCODI%TYPE, ID_FACTURA ED_DOCUMENT.DOCUCODI%TYPE, XMLFACT OUT ED_DOCUMENT.DOCUDOCU%TYPE);

  /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : UPDATEDOCUMENTSFACT
    Descripcion    : (Procedimiento Inicial) Datafix para actualizar XML de la tabla ED_DOCUMENT
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    20/11/2017      JBRITO              Creacion.
    ******************************************************************/
  PROCEDURE UPDATEDOCUMENTSFACT(P_FACTURA IN FACTURA.FACTCODI%TYPE,
                                P_TITULOS_TXT IN CLOB,
                                P_FACT_TXT IN CLOB,
                                P_MENSAJE IN VARCHAR2,
                                P_EXISTE_SPOOL IN BOOLEAN);

  /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : READFILE
    Descripcion    : Lee el spool
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    20/11/2017      JBRITO              Creacion.
    ******************************************************************/
  FUNCTION READFILE(P_DIRECTORIO VARCHAR2, P_ARCHIVO VARCHAR2) RETURN Ttb_archivo_texto PIPELINED;

  /**************************************************************************
    Propiedad Intelectual de Horbath (c)

    Funcion     :   FNNOREGULADO
    Descripcion :   Valida si el contrato es de producto no regulado
    Autor       :   Josh Brito - Horbath Technologies

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    22/11/2017          JBRITO             Creacion
    **************************************************************************/
  FUNCTION FNNOREGULADO(P_SUSCCODI SUSCRIPC.SUSCCODI%TYPE) RETURN BOOLEAN;

  /**************************************************************************
    Propiedad Intelectual de Horbath (c)

    Funcion     :   splitStringsHorizont
    Descripcion :   Interpreta Spool y Genera Consultas en una Fila de registro
    Autor       :   Josh Brito - Horbath Technologies

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    22/11/2017          JBRITO             Creacion
    **************************************************************************/
  PROCEDURE splitStringsHorizont(P_DEL in VARCHAR2,
                                  P_DEL_INICIAL VARCHAR2,
                                  P_DEL_FINAL VARCHAR2,
                                  P_DEF_COLUMN VARCHAR2,
                                  P_QUERYS OUT clob);

  /**************************************************************************
    Propiedad Intelectual de Horbath (c)

    Funcion     :   splitStringsVertical
    Descripcion :   Interpreta Spool y Genera Consultas con varias filas de registro
    Autor       :   Josh Brito - Horbath Technologies

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    22/11/2017          JBRITO             Creacion
    **************************************************************************/
  PROCEDURE splitStringsVertical(P_DEL in VARCHAR2,
                                  P_DEL_INICIAL VARCHAR2,
                                  P_DEL_FINAL VARCHAR2,
                                  P_DEF_COLUMN VARCHAR2,
                                  P_NEED_ETIQUETA NUMBER, --SI REQUIERE ETIQUETA INICIAL DAR VALOR DIFERANTE DE NULL
                                  P_ETIQUETA CLOB,
                                  P_QUERYS OUT clob);

END LDC_PKDATAFIXUPDEDDOCU;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKDATAFIXUPDEDDOCU
IS

  /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : GENERAFACTXML
    Descripcion    : Ejecuta el formato y genera el XML de La Factura
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    20/11/2017      JBRITO              Creacion.
    ******************************************************************/
  PROCEDURE GENERAFACTXML(ID_FORMATO IN ED_FORMATO.FORMCODI%TYPE, ID_FACTURA IN ED_DOCUMENT.DOCUCODI%TYPE, XMLFACT OUT ED_DOCUMENT.DOCUDOCU%TYPE) IS
    clClobData          clob;

    BEGIN
      /* EJECUTA FORMATO */
      pkBODataExtractor.ExecuteRules(ID_FORMATO,clClobData);
      XMLFACT := clClobData;

  EXCEPTION
    WHEN OTHERS THEN
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END GENERAFACTXML;

   /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : UPDATEDOCUMENTSFACT
    Descripcion    : (Procedimiento Inicial) Datafix para actualizar XML de la tabla ED_DOCUMENT
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    20/11/2017      JBRITO              Creacion.
    ******************************************************************/
  PROCEDURE UPDATEDOCUMENTSFACT(P_FACTURA IN FACTURA.FACTCODI%TYPE,
                                P_TITULOS_TXT IN CLOB,
                                P_FACT_TXT IN CLOB,
                                P_MENSAJE IN VARCHAR2,
                                P_EXISTE_SPOOL IN BOOLEAN) IS

    vFORMATOID ED_FORMATO.FORMCODI%TYPE;
    vXMLANTERIOR ED_DOCUMENT.DOCUDOCU%TYPE;
    vXMLACTUAL ED_DOCUMENT.DOCUDOCU%TYPE;

    vSUSCRIPFACT FACTURA.FACTSUSC%TYPE;
    vFACT_IN_SPOOL BOOLEAN := FALSE;
    vMENSAJE LDCUPDOCFACTLOG.UPOBSERV%TYPE := P_MENSAJE;
    vTXTFCAT CLOB := P_FACT_TXT;
    vTXTTITULO CLOB := P_TITULOS_TXT;
   -- vQUERY CLOB;

    CURSOR cuED_Document IS
      SELECT DOCUCODI,DOCUTIDO,DOCUPEFA,DOCUFERE,DOCUDOCU
      FROM ED_DOCUMENT
      WHERE DOCUCODI = (P_FACTURA);

    CURSOR cuSuscrFact (FACT_ID FACTURA.FACTCODI%TYPE)IS
      SELECT FACTSUSC
      FROM FACTURA
      WHERE FACTCODI = FACT_ID;

  BEGIN

    FOR S IN cuED_Document
    LOOP
      /*OBTIENE EL CONTRATO DE LA FACTURA*/
      OPEN cuSuscrFact(S.DOCUCODI);
        FETCH cuSuscrFact
          INTO vSUSCRIPFACT;
      CLOSE cuSuscrFact;

      /*SI EXISTE EL SPOOL*/
      IF P_EXISTE_SPOOL THEN

          IF vTXTFCAT IS NOT NULL AND vTXTTITULO IS NOT NULL THEN
              LDC_PKDATAFIXUPDEDDOCU.CAMPOS_SPOOLTXT := vTXTTITULO;
              LDC_PKDATAFIXUPDEDDOCU.FAACTURATXT := vTXTFCAT;
          END IF;
          /*VALIDAD SI ES FACTURA REGULADA O NO REGULADA*/
          IF NOT FNNOREGULADO(vSUSCRIPFACT) THEN
            vFORMATOID :=  DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_PARFORMTOFACREG');
          ELSE
            vFORMATOID :=  DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_PARFORMTOFACNOREG');
          END IF;

          /*OBTIENE EL XML ANTERIOR*/
          vXMLANTERIOR := S.DOCUDOCU;
          /*GENERA XML DE FACTURA Y OBTIENE EL ACTUAL*/
          GENERAFACTXML(vFORMATOID, S.DOCUCODI, vXMLACTUAL);
          vMENSAJE := NULL;

        /*GENERA REGISTRO EN LA TABLA DE LOG*/
        INSERT INTO LDCUPDOCFACTLOG(UPDOCODI,UPDFECHA,UPDCONTR,UPDOFACT,UPDOPERF,UPFACTAN,UPFACTAC,UPOBSERV)
        VALUES(LDC_SEQ_UPDOCFACTLOG.NEXTVAL, SYSDATE,vSUSCRIPFACT,S.DOCUCODI,S.DOCUPEFA,vXMLANTERIOR,vXMLACTUAL,vMENSAJE);
       -- DBMS_OUTPUT.PUT_LINE(vXMLACTUAL);
        /*ACTUALIZA LA TABLA ED_DOCUMENT*/
        UPDATE ED_DOCUMENT SET DOCUDOCU = vXMLACTUAL WHERE DOCUCODI = S.DOCUCODI;
        COMMIT;
       --DBMS_OUTPUT.PUT_LINE(vMENSAJE);
     --  DBMS_OUTPUT.PUT_LINE(vQUERY);
      ELSE
          vXMLANTERIOR := NULL;
          vXMLACTUAL := NULL;
          /*GENERA REGISTRO EN LA TABLA DE LOG*/
          INSERT INTO LDCUPDOCFACTLOG(UPDOCODI,UPDFECHA,UPDCONTR,UPDOFACT,UPDOPERF,UPFACTAN,UPFACTAC,UPOBSERV)
          VALUES(LDC_SEQ_UPDOCFACTLOG.NEXTVAL, SYSDATE,vSUSCRIPFACT,S.DOCUCODI,S.DOCUPEFA,vXMLANTERIOR,vXMLACTUAL,vMENSAJE);
          COMMIT;
         -- DBMS_OUTPUT.PUT_LINE(vMENSAJE);
      END IF;
     -- DBMS_OUTPUT.PUT_LINE(S.DOCUCODI);
    END LOOP;

  END UPDATEDOCUMENTSFACT;

  /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : READFILE
    Descripcion    : Lee el spool
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    20/11/2017      JBRITO              Creacion.
    ******************************************************************/
  FUNCTION READFILE (P_DIRECTORIO VARCHAR2, P_ARCHIVO VARCHAR2) RETURN Ttb_archivo_texto PIPELINED AS
    vArchivo    utl_file.file_type;
    vLinea      CLOB;
  BEGIN
     UTL_FILE.FCLOSE_ALL;
    vArchivo := utl_File.fopen (P_DIRECTORIO, P_ARCHIVO, 'R',32767);
    -- Leemos cada una de las lÃ­neas del archivo y la retornamos
    Loop
      Begin
        utl_file.get_line (vArchivo, vLinea);
      exception
        when NO_DATA_FOUND then
          exit;
      end;

      Pipe row (vLinea);
    end loop;

    utl_file.fclose (vArchivo);

    return;
  exception
    when utl_file.access_denied then
      dbms_output.put_line ('Error: utl_file.access_denied');
    when utl_file.invalid_operation then
      dbms_output.put_line ('Error: utl_file.invalid_operation');
    when no_data_found then
      utl_file.fclose(vArchivo);

  END READFILE;

  /**************************************************************************
    Propiedad Intelectual de Horbath (c)

    Funcion     :   FNNOREGULADO
    Descripcion :   Valida si el contrato es de producto no regulado
    Autor       :   Josh Brito - Horbath Technologies

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    22/11/2017          JBRITO             Creacion
    **************************************************************************/

    FUNCTION FNNOREGULADO(P_SUSCCODI SUSCRIPC.SUSCCODI%TYPE) RETURN BOOLEAN IS
        nuCategori  NUMBER;
        vCATEG_NOREGULADAS ld_parameter.value_chain%TYPE := dald_parameter.fsbGetValue_Chain('CATEG_IDUSTRIA_NO_REG');

    BEGIN

        SELECT sesucate
        INTO   nuCategori
        FROM   servsusc
        WHERE  sesususc = P_SUSCCODI
        AND    rownum = 1;

        IF instr('|' || vCATEG_NOREGULADAS || '|', '|' || nuCategori || '|') > 0 THEN

            RETURN TRUE;
        END IF;

        RETURN FALSE;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN FALSE;
    END FNNOREGULADO;

  /**************************************************************************
    Propiedad Intelectual de Horbath (c)

    Funcion     :   splitStringsHorizont
    Descripcion :   Interpreta Spool y Genera Consultas en una Fila de registro
    Autor       :   Josh Brito - Horbath Technologies

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    22/11/2017          JBRITO             Creacion
    **************************************************************************/
  PROCEDURE splitStringsHorizont(P_DEL in VARCHAR2,
                                  P_DEL_INICIAL VARCHAR2,
                                  P_DEL_FINAL VARCHAR2,
                                  P_DEF_COLUMN VARCHAR2,
                                  P_QUERYS OUT clob) IS
      L_IDX  PLS_INTEGER;
      L_IDX2  PLS_INTEGER;
      L_LIST CLOB := LDC_PKDATAFIXUPDEDDOCU.CAMPOS_SPOOLTXT;
    L_LIST2 CLOB := LDC_PKDATAFIXUPDEDDOCU.FAACTURATXT;
      ARREGLO_CAMPO VARCHAR2(200);
      ARREGLO_FILA VARCHAR2(200);

      QUERYS clob;

      --VERTOR
      L_IDX_AUX  PLS_INTEGER;
      L_LIST_AUX CLOB;
      INICIO CLOB := P_DEL_INICIAL;
      FIN CLOB := P_DEL_FINAL;
      DEF_COLUM CLOB := P_DEF_COLUMN;

      COL_AUX CLOB;
      VECTOR BOOLEAN := FALSE;

    BEGIN
        LOOP
            L_IDX := instr(L_LIST, p_del);
            L_IDX2 := instr(L_LIST2, p_del);

            IF L_IDX > 0 THEN

                ARREGLO_CAMPO := SUBSTR(L_LIST, 1, L_IDX - 1);
                ARREGLO_FILA := SUBSTR(L_LIST2, 1, L_IDX2 - 1);
                IF ARREGLO_CAMPO = INICIO  THEN
                    VECTOR := TRUE;
                END IF;
                IF ARREGLO_CAMPO = FIN  THEN
                    VECTOR := FALSE;
                END IF;
                IF VECTOR = TRUE OR ARREGLO_CAMPO = FIN THEN
                    L_LIST_AUX := DEF_COLUM;
                    LOOP
                        L_IDX_AUX := instr(L_LIST_AUX, p_del);
                        IF L_IDX_AUX > 0 THEN
                            COL_AUX := SUBSTR(L_LIST_AUX, 1, L_IDX_AUX - 1);
                            IF INSTR(p_del||ARREGLO_CAMPO||p_del,p_del||COL_AUX||p_del)>0 THEN
                                QUERYS := QUERYS ||','||''''||ARREGLO_FILA||''' '||COL_AUX;
                            END IF;
                            L_LIST_AUX := substr(L_LIST_AUX, L_IDX_AUX + LENGTH(p_del));
                        ELSE
                            NULL;
                            EXIT;
                        END IF;
                    END LOOP;
                END IF;

                l_list := substr(l_list, l_idx + LENGTH(p_del));
                l_list2 := substr(l_list2, l_idx2 + LENGTH(p_del));
            ELSE
                NULL;
                EXIT;
            END IF;
        END LOOP;
        QUERYS := SUBSTR(QUERYS, 2, length(QUERYS));
        QUERYS := 'SELECT '||QUERYS||' FROM DUAL';
        P_QUERYS := QUERYS;
    --DBMS_OUTPUT.PUT_LINE(QUERYS);

  END splitStringsHorizont;

  /**************************************************************************
    Propiedad Intelectual de Horbath (c)

    Funcion     :   splitStringsVertical
    Descripcion :   Interpreta Spool y Genera Consultas con varias filas de registro
    Autor       :   Josh Brito - Horbath Technologies

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    22/11/2017          JBRITO             Creacion
    **************************************************************************/
  PROCEDURE splitStringsVertical(P_DEL in VARCHAR2,
                                  P_DEL_INICIAL VARCHAR2,
                                  P_DEL_FINAL VARCHAR2,
                                  P_DEF_COLUMN VARCHAR2,
                                  P_NEED_ETIQUETA NUMBER, --SI REQUIERE ETIQUETA INICIAL DAR VALOR DIFERANTE DE NULL
                                  P_ETIQUETA CLOB,
                                  P_QUERYS OUT clob) IS

    L_IDX  PLS_INTEGER;
    L_IDX2  PLS_INTEGER;
    L_LIST CLOB := LDC_PKDATAFIXUPDEDDOCU.CAMPOS_SPOOLTXT;
    L_LIST2 CLOB := LDC_PKDATAFIXUPDEDDOCU.FAACTURATXT;
    --p_del VARCHAR2(1) := '|';

    ARREGLO_CAMPO VARCHAR2(200);
    ARREGLO_FILA VARCHAR2(200);

    QUERYS CLOB;

    -- CREAR MATRIZ
    L_IDX_AUX  PLS_INTEGER;
    L_LIST_AUX CLOB;
    p_del_aux VARCHAR2(1) := '|';

    INICIO CLOB := P_DEL_INICIAL;
    FIN CLOB := P_DEL_FINAL;

    DEF_COLUM CLOB := P_DEF_COLUMN;
    COL_AUX CLOB;

    MATRIZ BOOLEAN := FALSE;

    --SI ES NECESARIO UN CONTADOR DE FILAS
    ETIQUETA CLOB := P_ETIQUETA;
    CONT_ETIQUETA NUMBER := P_NEED_ETIQUETA;
    DEF_COLUM_INI CLOB;

  BEGIN
    LOOP
        L_IDX := instr(L_LIST, p_del);
        L_IDX2 := instr(L_LIST2, p_del);

        IF L_IDX > 0 THEN

            ARREGLO_CAMPO := SUBSTR(L_LIST, 1, L_IDX - 1);
            ARREGLO_FILA := SUBSTR(L_LIST2, 1, L_IDX2 - 1);
            IF ARREGLO_CAMPO = INICIO  THEN
                MATRIZ := TRUE;
            END IF;
            IF ARREGLO_CAMPO = FIN  THEN
                MATRIZ := FALSE;
            END IF;

            IF MATRIZ = TRUE OR ARREGLO_CAMPO = FIN THEN
                L_LIST_AUX := DEF_COLUM;

                LOOP

                    L_IDX_AUX := instr(L_LIST_AUX, p_del);
                    IF L_IDX_AUX > 0 THEN
                        COL_AUX := SUBSTR(L_LIST_AUX, 1, L_IDX_AUX - 1);
                        IF INSTR(ARREGLO_CAMPO,COL_AUX)>0 THEN
                            IF LENGTH(L_LIST_AUX) = LENGTH(DEF_COLUM) THEN
                              IF CONT_ETIQUETA IS NOT NULL THEN --AND CONT_ETIQUETA <= 30 THEN
                                DEF_COLUM_INI := TO_CHAR(CONT_ETIQUETA)||' '||ETIQUETA||' ,';
                                CONT_ETIQUETA := CONT_ETIQUETA + 1;
                              END IF;
                              QUERYS := QUERYS||'UNION SELECT '||DEF_COLUM_INI||''''||ARREGLO_FILA||''' '||COL_AUX||' ';
                            ELSE
                              QUERYS := QUERYS||','||''''||ARREGLO_FILA||''' '||COL_AUX||' ';
                            END IF;

                            IF (LENGTH(L_LIST_AUX)-LENGTH(p_del)) = LENGTH(COL_AUX) THEN
                              QUERYS := QUERYS ||'FROM DUAL ';
                            END IF;
                        END IF;
                        L_LIST_AUX := substr(L_LIST_AUX, L_IDX_AUX + LENGTH(p_del));
                    ELSE
                        NULL;
                        EXIT;
                    END IF;

                END LOOP;

            END IF;

            L_LIST := substr(L_LIST, L_IDX + LENGTH(p_del));
            L_LIST2 := substr(L_LIST2, L_IDX2 + LENGTH(p_del));

        ELSE
            NULL;
             EXIT;
        END IF;
    END LOOP;

    QUERYS := SUBSTR(QUERYS, LENGTH('UNION '));
    P_QUERYS := QUERYS;
  --  DBMS_OUTPUT.PUT_LINE(QUERYS);

  END splitStringsVertical;

END LDC_PKDATAFIXUPDEDDOCU;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKDATAFIXUPDEDDOCU
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKDATAFIXUPDEDDOCU', 'ADM_PERSON');
END;
/