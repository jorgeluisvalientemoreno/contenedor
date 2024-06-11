CREATE OR REPLACE PACKAGE BODY GE_BCITEMSDOCUMENTO IS
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO189477';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   FUNCTION FNUGETITEMSDOCBYDOCEXT( INUTIPODOCUMENTO IN GE_ITEMS_DOCUMENTO.DOCUMENT_TYPE_ID%TYPE, INUUNIDADOPERATIVA IN GE_ITEMS_DOCUMENTO.OPERATING_UNIT_ID%TYPE, ISBDOCUMENTOEXTERNO IN GE_ITEMS_DOCUMENTO.DOCUMENTO_EXTERNO%TYPE )
    RETURN GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE
    IS
      NUIDITEMSDOCUMENTO GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE := NULL;
      CURSOR CUGETITEMSDOCBYDOCEXT IS
SELECT  id_items_documento
            FROM ge_items_documento
            WHERE   document_type_id  = inuTipoDocumento
                AND operating_unit_id = inuUnidadOperativa
                AND documento_externo = isbDocumentoExterno;
    BEGIN
      FOR RG IN CUGETITEMSDOCBYDOCEXT
       LOOP
         NUIDITEMSDOCUMENTO := RG.ID_ITEMS_DOCUMENTO;
      END LOOP;
      RETURN NUIDITEMSDOCUMENTO;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FNUGETITEMSDOCBYDOCEXT;
   FUNCTION FNUGETITEMSDOCREL( INUIDITEMSDOCORI IN GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE, INUIDITEMSDOCDES IN GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE )
    RETURN GE_ITEMS_DOC_REL.ID_ITEMS_DOC_RELACION%TYPE
    IS
      NUIDRELACION GE_ITEMS_DOC_REL.ID_ITEMS_DOC_RELACION%TYPE := NULL;
      CURSOR CUGETRELACIONDOC IS
SELECT  id_items_doc_relacion
            FROM ge_items_doc_rel
            WHERE id_items_doc_origen = inuIdItemsDocOri
            AND id_items_doc_destino = inuIdItemsDocDes;
    BEGIN
      FOR RG IN CUGETRELACIONDOC
       LOOP
         NUIDRELACION := RG.ID_ITEMS_DOC_RELACION;
      END LOOP;
      RETURN NUIDRELACION;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FNUGETITEMSDOCREL;
   PROCEDURE GETLOGBYDOCUMENT( INUDOCUMENT IN GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE, ORFLOGDOCS OUT CONSTANTS.TYREFCURSOR )
    IS
    BEGIN
      OPEN ORFLOGDOCS FOR SELECT  ge_items_doc_log.id_items_doc_log,
                    ge_items_doc_log.id_items_documento,
                    ge_items_doc_log.item,
                    ge_items_doc_log.clase,
                    ge_items_doc_log.estado,
                    ge_items_doc_log.observacion
              FROM  ge_items_doc_log
             WHERE  ge_items_doc_log.id_items_documento = inuDocument;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE OBTENERFACTURASPORORDEN( INUORDENCOMPRA IN GE_ITEMS_DOC_REL.ID_ITEMS_DOC_DESTINO%TYPE, OTBFACTURAS OUT GE_BCITEMSDOCUMENTO.TBFACTURAS )
    IS
      CURSOR CUOBTFACTURAS IS
SELECT  id_items_doc_origen
            FROM ge_items_doc_rel a
            WHERE id_items_doc_destino = inuOrdenCompra;
    BEGIN
      IF CUOBTFACTURAS%ISOPEN THEN
         CLOSE CUOBTFACTURAS;
      END IF;
      OPEN CUOBTFACTURAS;
      FETCH CUOBTFACTURAS
         BULK COLLECT INTO OTBFACTURAS;
      CLOSE CUOBTFACTURAS;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END OBTENERFACTURASPORORDEN;
   FUNCTION FNUOBTCANTDOCUMTRANSITO( INUDOCUMENTO IN GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE, INUOPERUNIT IN GE_ITEMS_DOCUMENTO.OPERATING_UNIT_ID%TYPE )
    RETURN NUMBER
    IS
      NUCANTDOCU NUMBER := 0;
      CURSOR CUDOCUMTRANSITO( INUDOCUMENTO IN GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE, INUOPERUNIT IN GE_ITEMS_DOCUMENTO.OPERATING_UNIT_ID%TYPE ) IS
SELECT 1 "Cantidad" FROM dual WHERE EXISTS (
            SELECT  or_uni_item_bala_mov.uni_item_bala_mov_id
              FROM  or_uni_item_bala_mov,
                    ge_items_documento,      -- documentos que tienen el movimiento, factura y traslado
                    ge_items_doc_rel         -- relacion entre orden y factura o traslado y traslado
             WHERE  ge_items_documento.id_items_documento = or_uni_item_bala_mov.id_items_documento
               AND  ge_items_documento.id_items_documento = ge_items_doc_rel.id_items_doc_origen
               AND  ge_items_doc_rel.id_items_doc_destino =  inuDocumento
               AND  or_uni_item_bala_mov.operating_unit_id = inuOperUnit
               AND  or_uni_item_bala_mov.movement_type = or_boitemsmove.csbNeutralMoveType  -- N
               AND  or_uni_item_bala_mov.support_document = ' ');
    BEGIN
      IF CUDOCUMTRANSITO%ISOPEN THEN
         CLOSE CUDOCUMTRANSITO;
      END IF;
      FOR RCDOCUMTRANSITO IN CUDOCUMTRANSITO( INUDOCUMENTO, INUOPERUNIT )
       LOOP
         NUCANTDOCU := 1;
      END LOOP;
      RETURN NUCANTDOCU;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF CUDOCUMTRANSITO%ISOPEN THEN
            CLOSE CUDOCUMTRANSITO;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         IF CUDOCUMTRANSITO%ISOPEN THEN
            CLOSE CUDOCUMTRANSITO;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
   END FNUOBTCANTDOCUMTRANSITO;
   FUNCTION FNUTOTREGEXTDOCXDOCTYP( ISBEXTERDOC IN GE_ITEMS_DOCUMENTO.DOCUMENTO_EXTERNO%TYPE, INUDOCTYPE IN GE_ITEMS_DOCUMENTO.DOCUMENT_TYPE_ID%TYPE )
    RETURN NUMBER
    IS
      NUCOUNT NUMBER;
    BEGIN
      SELECT  count(*)
        INTO    nuCount
        FROM    ge_items_documento
        WHERE   ge_items_documento.document_type_id = inuDocType
        AND     ge_items_documento.documento_externo = isbExterDoc;
      RETURN NUCOUNT;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FNUTOTREGEXTDOCXDOCTYP;
   FUNCTION FTBGETDOCSABIERTOS( INUDOCUMENT IN GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE, INUOPERATINGUNIT IN GE_ITEMS_DOCUMENTO.OPERATING_UNIT_ID%TYPE )
    RETURN DAGE_ITEMS_DOCUMENTO.TYTBID_ITEMS_DOCUMENTO
    IS
      TBORDENES DAGE_ITEMS_DOCUMENTO.TYTBID_ITEMS_DOCUMENTO;
      CURSOR CUDOCUMENTO IS
SELECT  ge_items_documento.id_items_documento
                FROM  ge_items_documento,
                      ge_items_doc_rel
               WHERE  ge_items_documento.id_items_documento = ge_items_doc_rel.id_items_doc_destino
                 AND  ge_items_doc_rel.id_items_doc_origen = inuDocument
                 AND  ge_items_documento.document_type_id = ge_boitemsconstants.cnuTipoOrdenCompra
                 AND  ge_items_documento.estado = ge_boitemsconstants.csbEstadoAbierto
                 AND  ge_items_documento.operating_unit_id = inuOperatingUnit;
    BEGIN
      IF CUDOCUMENTO%ISOPEN THEN
         CLOSE CUDOCUMENTO;
      END IF;
      OPEN CUDOCUMENTO;
      FETCH CUDOCUMENTO
         BULK COLLECT INTO TBORDENES;
      CLOSE CUDOCUMENTO;
      RETURN TBORDENES;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF CUDOCUMENTO%ISOPEN THEN
            CLOSE CUDOCUMENTO;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         IF CUDOCUMENTO%ISOPEN THEN
            CLOSE CUDOCUMENTO;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
   END FTBGETDOCSABIERTOS;
   FUNCTION FTBGETDOCSCOMPRA( INUDOCUMENT IN GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE, INUOPERATINGUNIT IN GE_ITEMS_DOCUMENTO.OPERATING_UNIT_ID%TYPE )
    RETURN DAGE_ITEMS_DOCUMENTO.TYTBID_ITEMS_DOCUMENTO
    IS
      TBORDENES DAGE_ITEMS_DOCUMENTO.TYTBID_ITEMS_DOCUMENTO;
      CURSOR CUDOCUMENTO IS
SELECT  ge_items_documento.id_items_documento
                FROM  ge_items_documento,
                      ge_items_doc_rel
               WHERE  ge_items_documento.id_items_documento = ge_items_doc_rel.id_items_doc_destino
                 AND  ge_items_doc_rel.id_items_doc_origen = inuDocument
                 AND  ge_items_documento.document_type_id = ge_boitemsconstants.cnuTipoOrdenCompra
                 AND  ge_items_documento.operating_unit_id = inuOperatingUnit
            ORDER BY  ge_items_documento.estado, ge_items_documento.fecha;
    BEGIN
      IF CUDOCUMENTO%ISOPEN THEN
         CLOSE CUDOCUMENTO;
      END IF;
      OPEN CUDOCUMENTO;
      FETCH CUDOCUMENTO
         BULK COLLECT INTO TBORDENES;
      CLOSE CUDOCUMENTO;
      RETURN TBORDENES;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF CUDOCUMENTO%ISOPEN THEN
            CLOSE CUDOCUMENTO;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         IF CUDOCUMENTO%ISOPEN THEN
            CLOSE CUDOCUMENTO;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
   END FTBGETDOCSCOMPRA;
END GE_BCITEMSDOCUMENTO;
/


