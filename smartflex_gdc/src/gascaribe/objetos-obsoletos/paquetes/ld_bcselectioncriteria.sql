CREATE OR REPLACE Package ld_bcselectioncriteria Is

  /*****************************************************************

   Historia de Modificaciones
   Fecha         Autor              Modificacion
   ==========    ================   =======================================
   20/05/2013    Javier Rodriguez   Optimización de procedimientos


   Historia de Modificaciones

    Fecha           IDEntrega

    08-08-2013      smunozSAO213862
    Se genera la muestra por sector y producto.
    Procedimiento: fbogetsectioncriteriaid
  ******************************************************************/

  Function fbogetselectioncriteriaid(inutypesector ld_selection_criteria.sector_id%Type,
                                     inucreditbu   ld_selection_criteria.credit_bureau%Type,
                                     ionuminuamou  In Out ld_selection_criteria.minimum_amount%Type,
                                     ionususbnumb  In Out ld_selection_criteria.subscriber_number%Type,
                                     ioduebills    In Out ld_selection_criteria.overdue_bills%Type,
                                     iocategory    In Out ld_selection_criteria.category%Type)

   Return Boolean;

  Function fsbversion Return Varchar2;
End ld_bcselectioncriteria;
/
CREATE OR REPLACE Package Body ld_bcselectioncriteria Is
  -- Esta constante se debe modificar cada vez que se entregue el
  -- paquete con un SAO
  csbversion Constant Varchar2(250) := '213862';

  -- Se maneja la información por sector. smunozSAO213862
  Function fbogetselectioncriteriaid(inutypesector ld_selection_criteria.sector_id%Type,
                                     inucreditbu   ld_selection_criteria.credit_bureau%Type,
                                     ionuminuamou  In Out ld_selection_criteria.minimum_amount%Type,
                                     ionususbnumb  In Out ld_selection_criteria.subscriber_number%Type,
                                     ioduebills    In Out ld_selection_criteria.overdue_bills%Type,
                                     iocategory    In Out ld_selection_criteria.category%Type)
  /******************************************************************
     Historia de Modificaciones

      Fecha           IDEntrega

      08-08-2013      smunozSAO213862
      Se genera la muestra por sector y producto.
      Procedimiento: fbogetsectioncriteriaid
    ******************************************************************/

   Return Boolean Is
    -- Selecciona por sector. smunozSAO213862
    Cursor cuselectcriter Is
      Select minimum_amount,
             subscriber_number,
             overdue_bills,
             category
        From ld_selection_criteria
       Where sector_id = inutypesector
         And credit_bureau = inucreditbu;

    gsberrmsg ge_error_log.description%Type;

  Begin
    pkerrors.push('ld_bcselectioncriteria.fbogetselectioncriteriaid');
    Open cuselectcriter;
    Fetch cuselectcriter
      Into ionuminuamou,
           ionususbnumb,
           ioduebills,
           iocategory;

    pkerrors.pop;
    If cuselectcriter%Found Then
      Close cuselectcriter;
      Return(True);
    Else
      Close cuselectcriter;
      Return(False);
    End If;

  Exception
    When Others Then
      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return(False);

  End;

  /****************************************************************************
    Funcion       :  fsbVersion

    Descripcion :  Obtiene el SAO que identifica la version asociada a la
                     ultima entrega del paquete

    Retorno     :  csbVersion - Version del Paquete
  *****************************************************************************/

  Function fsbversion Return Varchar2 Is
  Begin
    --{
    -- Retorna el SAO con que se realizó la última entrega del paquete
    Return(csbversion);
    --}
  End fsbversion;
End ld_bcselectioncriteria;
/
GRANT EXECUTE on LD_BCSELECTIONCRITERIA to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LD_BCSELECTIONCRITERIA to REXEOPEN;
GRANT EXECUTE on LD_BCSELECTIONCRITERIA to RSELSYS;
/
