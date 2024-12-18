CREATE OR REPLACE TRIGGER ADM_PERSON.LDCTRGBUDI_GE_ITDO
  BEFORE UPDATE OR DELETE OR INSERT ON GE_ITEMS_DOCUMENTO
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
  /*  Propiedad intelectual de Gases de Occidente
      Trigger     :   LDCTRGBUDI_GE_ITDO
      Descripcion :   Trigger para almacenar los materiales
                      de la tabla "GE_ITEMS_DOCUMENTO"
            separados en bodegas de Activos fijos e Inventarios.
      Autor       :   Manuel Mejia
      Fecha       :   19-MAR-2015

      Historial de modificaciones
      Fecha            IDEntrega
      19-MAR-2015      Mmejia


      Autor            Fecha           Descripcion
      ------          --------        ---------------------------------
      Mmejia          19-03-2015      Creacion. Aranda 6358 y 6360
      Mmejia          07-04-2015      Modificacion. SAO.307171 Se modifica para verificar
                                      los tipos de documentos que se deben validar la causal
                                      y ademas de esto validar que el documento 103 solo se valide
                                      cuando exisa un traslado de items abierto.
      Mmejia          22-07-2015      Modificacion. Aranda 8004 se modifica para agregar la
									  validacion del programa GEITE con el fin de eliminar el error
									  que se presenta en los movimientos desde la interfaz con SAP.

     Socoro            07/03/2017    CA 100-10493 Se modifica para validar obligatoriedad de causal
     jpinedc            21/10/2024  OSF-3450: Se migra a ADM_PERSON
*/
DECLARE

  --Variables
  nuErrCode  GE_ERROR_LOG.error_log_id%TYPE;
  sbErrMsg   GE_ERROR_LOG.description%TYPE;

  sbCommentAcept LD_PARAMETER.VALUE_CHAIN%TYPE := DALD_PARAMETER.fsbGetValue_Chain('DESC_COMENT_ACEPT_ITEM',
                                                                                           NULL);


  --Cursor Valida tipos de documentos para validar causal nula
  CURSOR cuValDocType(inudocument_type_id GE_ITEMS_DOCUMENTO.document_type_id%TYPE)
  IS
  SELECT 'X' FROM
  (SELECT TO_NUMBER(COLUMN_VALUE) COLUMN_VALUE
                       FROM TABLE
                        (LDC_BOUTILITIES.SPLITSTRINGS(
                            DALD_PARAMETER.fsbGetValue_Chain('CODCAUS_DOC_ITIEM_NOTNULL',NULL),',')
                        )
                        ) WHERE COLUMN_VALUE = inudocument_type_id;

  rccuValDocType cuValDocType%ROWTYPE;

  --Cursor Valida tipos de documento Recepcion
  CURSOR cuValDocTypeRecp(inudocument_type_id GE_ITEMS_DOCUMENTO.document_type_id%TYPE)
  IS
  SELECT 'X' FROM
  (SELECT TO_NUMBER(COLUMN_VALUE) COLUMN_VALUE
                       FROM TABLE
                        (LDC_BOUTILITIES.SPLITSTRINGS(
                            DALD_PARAMETER.fsbGetValue_Chain('CODIGO_DOC_ITIEM_RECEPCION',NULL),',')
                        )
                        ) WHERE COLUMN_VALUE = inudocument_type_id;

  rccuValDocTypeRecp cuValDocTypeRecp%ROWTYPE;

  --cursor para determinar un traslado abierto para las unidades
  --operativas en curso
  CURSOR cuTRASLADOITEMSabierto
  IS
    SELECT g1.*
      FROM ge_items_documento g1
     WHERE
       --g1.operating_unit_id = :new.destino_oper_uni_id
       --AND
       g1.destino_oper_uni_id = :new.destino_oper_uni_id
       AND g1.estado = 'A'
       --AND trunc(g1.fecha) = trunc(sysdate)
       --Modificación CA 100 10493
       /*AND G1.CAUSAL_ID IS NOT NULL*/
       --AND g1.id_items_documento = :new.id_items_documento
       AND g1.DOCUMENT_TYPE_ID IN(SELECT TO_NUMBER(COLUMN_VALUE) COLUMN_VALUE
                       FROM TABLE
                        (LDC_BOUTILITIES.SPLITSTRINGS(
                            DALD_PARAMETER.fsbGetValue_Chain('CODIGO_DOC_ITIEM_TRASLADO',NULL),',')
                        ))--Tipo documento traslado de items
       AND G1.id_items_documento NOT IN
           (SELECT LID.id_items_documento
              FROM LDC_ITEMS_DOCUMENTO LID
             WHERE LID.ID_ITEMS_DOCUMENTO = G1.id_items_documento);

  tempcuTRASLADOITEMSabierto cuTRASLADOITEMSabierto%rowtype;

  boValCausal BOOLEAN :=TRUE ;
  sbProgram       VARCHAR2(100);

  /* Constante para formulario GEITE */
  csbGEITE CONSTANT VARCHAR2(5) := 'GEITE';
BEGIN
  ut_trace.trace('Inicio LDCTRGBUDI_GE_ITDO', 10);
  --Validar parametrización
  if NOT DALD_PARAMETER.fblExist('CODCAUS_DOC_ITIEM_NOTNULL') then
      Gi_BoErrors.SetErrorCodeArgument(2741,'ERROR => NO SE HA CONFIGURADO EL PARÁMETRO CODCAUS_DOC_ITIEM_NOTNULL');
      raise  ex.CONTROLLED_ERROR;
 end if;

 -- Obtiene el programa
 sbProgram := ut_session.getmodule();
 ut_trace.trace('Inicio LDCTRGBUDI_GE_ITDO sbProgram => '||sbProgram, 10);

 --Validacion de la causal del documento no sea nula
 --para los tipos de documento del parametro
 IF(INSERTING AND  sbProgram IN (csbGEITE) )THEN
    ut_trace.trace('Inicio LDCTRGBUDI_GE_ITDO IF => ', 10);
    --Valida el tipo de documento
    --105 TRASLADO, 115 DEVOLUCION  103 POR RECEPCION
    OPEN cuValDocType(:NEW.document_type_id);
    FETCH cuValDocType INTO rccuValDocType;
    --Valida si el tipo de documento esta en el parametro
    IF(cuValDocType%FOUND)THEN
      --Valida si existe un traslado abierto para
      --validar la causal de la aceptacion solo en ese caso
      OPEN cuTRASLADOITEMSabierto;
      FETCH cuTRASLADOITEMSabierto INTO tempcuTRASLADOITEMSabierto;

      --Valida si el tipo de documento es recepcion(103)
      OPEN cuValDocTypeRecp(:NEW.document_type_id);
      FETCH cuValDocTypeRecp INTO rccuValDocTypeRecp;

      --Valida que el cursor tenga datos y que el tipo de documento sea 103
      -- para descativar la validacino de causal.
      IF(cuTRASLADOITEMSabierto%NOTFOUND AND cuValDocTypeRecp%FOUND )THEN
         boValCausal := FALSE;
      END IF;
      CLOSE cuTRASLADOITEMSabierto;
      --Modificación CA 100-10493
      --Validar que la causal no sea nula
       ut_trace.trace('Inicio LDCTRGBUDI_GE_ITDO :NEW.causal_id => '||:NEW.causal_id , 10);
      --ut_trace.trace('Inicio LDCTRGBUDI_GE_ITDO boValCausal => '||boValCausal , 10);
     IF(:NEW.causal_id IS NULL AND boValCausal /*AND Lower(:NEW.comentario) LIKE Lower('%'||sbCommentAcept||'%') */)THEN
          Gi_BoErrors.SetErrorCodeArgument(2741,
                                                'La causal es requerida Tipo Doc:['||:NEW.document_type_id||']'||
                                                                              ' DocExt:['||:NEW.documento_externo||']'||
                                                                              ' Fecha:['||:NEW.fecha||']'||
                                                                              ' Estado:['||:NEW.estado||']'||
                                                                              ' OperUnit:['||:NEW.operating_unit_id||']'||
                                                                              ' OperUnitDes:['||:NEW.destino_oper_uni_id||']'||
                                                                              ' Terminal:['||:NEW.terminal_id||']'||
                                                                              ' User:['||:NEW.user_id||']'||
                                                                              ' Coment:['||:NEW.comentario||']'||
                                                                              ' Causal:['||:NEW.causal_id||']');


          raise  ex.CONTROLLED_ERROR;
      END IF;--Validacion causal nula
      CLOSE cuValDocTypeRecp;
     END IF;
     CLOSE cuValDocType;
 END IF;
   ut_trace.trace('Fin LDCTRGBUDI_GE_ITDO', 10);
EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
     if cuValDocTypeRecp%isopen then
        CLOSE cuValDocTypeRecp;
     end if;
     if cuValDocType%isopen then
        CLOSE cuValDocType;
     end if;

    RAISE;
  WHEN OTHERS THEN
    pkErrors.GetErrorVar(nuErrCode, sbErrMsg);
END LDCTRGBUDI_GE_ITDO;
/
