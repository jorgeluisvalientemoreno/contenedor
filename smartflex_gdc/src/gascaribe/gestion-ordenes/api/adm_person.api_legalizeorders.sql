create or replace PROCEDURE  adm_person.api_legalizeOrders(isbDataOrder     IN VARCHAR2,
                                                          idtInitDate      IN DATE,
                                                          idtFinalDate     IN DATE,
                                                          idtChangeDate    IN DATE,
                                                          onuErrorCode     OUT NUMBER,
                                                          osbErrorMessage  OUT VARCHAR2) is
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : api_legalizeOrders
    Descripcion     : api para realizar legalizacion de orden
    Autor           : Diana Saltarin
    Fecha           : 01-06-2023
    Parametros de Entrada
      isbDataOrder     cadena de legalizacion de orden
      idtInitDate      fecha inicial de ejecucion
      idtFinalDate     fecha final de ejecucion
      idtChangeDate    fecha de cambio
    Parametros de Salida
       onuErrorCode      codigo de error
       osbErrorMessage   mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    LJLB        01/06/2023      CASO OSF-1152 se agrega proceso para realizar el llamdo de los procesos
                                PRE y POST
  ***************************************************************************/
  v_tStringTable ldc_bcConsGenerales.tyTblStringTable ;

  regEstruLega        PKG_GESTIONORDENES.tytRegiEstrLega;
  V_tblObjetosAccion  PKG_GESTIONORDENES.tblObjetosAccion;

BEGIN
  UT_TRACE.TRACE('Inicio api_legalizeOrders', 10);
   v_tStringTable.delete;
   --se mapean datos de la cadena de legalizacion
   v_tStringTable := ldc_bcConsGenerales.ftbAllSplitString
                    (
                        isbDataOrder,
                        PKG_GESTIONORDENES.CSBSEPARADOR_LEGA
                    );
   --se valida que la cadena esta correcta
   IF v_tStringTable.COUNT <> PKG_GESTIONORDENES.CSBCANTCAMP_LEGA AND  v_tStringTable.COUNT <>  PKG_GESTIONORDENES.CSBCANTCAMPO_LEGA THEN
      onuErrorCode := -1;
      osbErrorMessage := 'Cadena de legalizacion esta mal formada';
      UT_TRACE.TRACE('Cadena de legalizacion esta mal formada', 10);
      return;
   END IF;

   --se realiza registro de estructura de legalizacion
   PKG_GESTIONORDENES.prGetRegiLega( v_tStringTable,
                                      regEstruLega,
                                      onuErrorCode,
                                      osbErrorMessage);

   IF onuErrorCode <> 0 THEN
      RETURN;
   END IF;

   --objeto de legalizacion pre
   PKG_GESTIONORDENES.prGetObjetosEjecutar( regEstruLega.nuOrden,
                                            regEstruLega.nuCausal,
                                            7,
                                            'PRE' ,
                                            V_tblObjetosAccion,
                                            onuErrorCode,
                                            osbErrorMessage);
   IF onuErrorCode <> 0 THEN
      RETURN;
   END IF;
   --se recorre tabla de objetos a procesar
   IF V_tblObjetosAccion.COUNT > 0 THEN
      UT_TRACE.TRACE('Inicio Ejecucion acciones PRE '||osbErrorMessage, 10);
      FOR IDX IN 1..V_tblObjetosAccion.COUNT LOOP
        IF V_tblObjetosAccion(IDX).nombreobjeto IS NOT NULL THEN
          EXECUTE IMMEDIATE 'BEGIN '||PKG_GESTIONORDENES.CSBESQUEMA_PERSON||'.'||V_tblObjetosAccion(IDX).nombreobjeto||'(:inuOrden, :InuCausal, :InuPersona, :idtFechIniEje,'||
            ':idtFechaFinEje, :IsbDatosAdic, :IsbActividades, :IsbItemsElementos, :IsbLecturaElementos, :IsbComentariosOrden); '||' END; '
           USING regEstruLega.nuOrden, regEstruLega.nuCausal, regEstruLega.nuPersona, idtInitDate, idtFinalDate, regEstruLega.sbDatosAdic,
                regEstruLega.sbActividades, regEstruLega.sbItemsElementos, regEstruLega.sbLecturaElementos , regEstruLega.sbComentariosOrden;
        END IF;
      END LOOP;
       UT_TRACE.TRACE('Fin Ejecucion acciones PRE '||osbErrorMessage, 10);
   END IF;
  UT_TRACE.TRACE('Inicio OS_LEGALIZEORDERS', 10);
   --api de legalizacion
   OS_LEGALIZEORDERS(isbDataOrder,idtInitDate,idtFinalDate,idtChangeDate,onuErrorCode,osbErrorMessage);
  UT_TRACE.TRACE('Fin OS_LEGALIZEORDERS '||osbErrorMessage, 10);
   IF onuErrorCode = 0 THEN
       V_tblObjetosAccion.DELETE;
        --objeto de legalizacion post
        PKG_GESTIONORDENES.prGetObjetosEjecutar( regEstruLega.nuOrden,
                                                regEstruLega.nuCausal,
                                                7,
                                                'POST' ,
                                                V_tblObjetosAccion,
                                                onuErrorCode,
                                                osbErrorMessage);

          IF onuErrorCode <> 0 THEN
              RETURN;
           END IF;

         IF V_tblObjetosAccion.COUNT > 0 THEN
            UT_TRACE.TRACE('Inicio Ejecucion acciones POST '||osbErrorMessage, 10);
            FOR IDX IN 1..V_tblObjetosAccion.COUNT LOOP

               dbms_output.put_line(' obejto '|| V_tblObjetosAccion(IDX).nombreobjeto);
                IF V_tblObjetosAccion(IDX).nombreobjeto IS NOT NULL THEN
                  EXECUTE IMMEDIATE 'BEGIN '||PKG_GESTIONORDENES.CSBESQUEMA_PERSON||'.'||V_tblObjetosAccion(IDX).nombreobjeto||'(:inuOrden, :InuCausal, :InuPersona, :idtFechIniEje,'||
                    ':idtFechaFinEje, :IsbDatosAdic, :IsbActividades, :IsbItemsElementos, :IsbLecturaElementos, :IsbComentariosOrden); '||' END; '
                   USING regEstruLega.nuOrden, regEstruLega.nuCausal, regEstruLega.nuPersona, idtInitDate, idtFinalDate, regEstruLega.sbDatosAdic,
                        regEstruLega.sbActividades, regEstruLega.sbItemsElementos, regEstruLega.sbLecturaElementos , regEstruLega.sbComentariosOrden;
                END IF;
             END LOOP;
              UT_TRACE.TRACE('Fin Ejecucion acciones POST '||osbErrorMessage, 10);
          END IF;
   END IF;
 UT_TRACE.TRACE('Fin api_legalizeOrders', 10);
EXCEPTION
  when pkg_Error.CONTROLLED_ERROR then
    pkg_Error.GETERROR(onuErrorCode, osbErrorMessage);
     UT_TRACE.TRACE('Fin CONTROLLED_ERROR api_legalizeOrders '||osbErrorMessage, 10);
  WHEN OTHERS THEN
    pkg_Error.SETERROR;
    pkg_Error.GETERROR(onuErrorCode, osbErrorMessage);
    UT_TRACE.TRACE('Fin OTHERS api_legalizeOrders '||osbErrorMessage, 10);
END;
/
begin
  pkg_utilidades.prAplicarPermisos('API_LEGALIZEORDERS', 'ADM_PERSON');
end;
/