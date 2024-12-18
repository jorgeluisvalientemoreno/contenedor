CREATE OR REPLACE PROCEDURE adm_person.ldcproListaCausal ( INUCAUSALID IN GE_CAUSAL.CAUSAL_ID%TYPE, ISBCAUSALNAME IN GE_CAUSAL.DESCRIPTION%TYPE, ORFANSWERS OUT SYS_REFCURSOR )
    IS
    /********************************************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P
    
    Funcion     : LDCPROLISTACAUSAL
    Descripcion : 
    
    Historia de Modificaciones
    Fecha               Autor                Modificacion
    =========           =========          ====================  
    02/05/2024          PACOSTA            OSF-2638: Se crea el objeto en el esquema adm_person                                                 
    *********************************************************************************************************/
    
       SBCAUSALID GE_BOINSTANCECONTROL.STYSBNAME;


      nuIndex          ge_boInstanceControl.stynuIndex;

    BEGIN
      UT_TRACE.TRACE( 'Begin ldcproListaCausal', 10 );
      ge_boinstancecontrol.AcckeyAttributeStack('PAQUETE-1',
                                              Null,
                                              MO_BOCONSTANTS.CSBMO_PROCESS,
                                              MO_BOCONSTANTS.CSBCAUSAL_ID,
                                              nuIndex);
    GE_BOInstanceControl.GetAttributeNewValue('PAQUETE-1',
                                              Null,
                                              MO_BOCONSTANTS.CSBMO_PROCESS,
                                              MO_BOCONSTANTS.CSBCAUSAL_ID,
                                              SBCAUSALID);

   --  SBCAUSALID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( MO_BOCONSTANTS.CSBMO_PROCESS, MO_BOCONSTANTS.CSBCAUSAL_ID );


      open ORFANSWERS for 'select b.answer_id ID, b.description DESCRIPTION
                            from LDC_CAUSAL_ANSWER f,
                                cc_answer b
                            where f.CAANCAUS = :causal
                             and f.CAANANSW = b.answer_id
                             and b.request_type_id = 100030
                             and b.is_immediate_attent = :si' using SBCAUSALID, 'Y';

      UT_TRACE.TRACE( 'End ldcproListaCausal', 10 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
END ldcproListaCausal;
/
PROMPT Otorgando permisos de ejecucion a LDCPROLISTACAUSAL
BEGIN
    pkg_utilidades.praplicarpermisos('LDCPROLISTACAUSAL', 'ADM_PERSON');
END;
/