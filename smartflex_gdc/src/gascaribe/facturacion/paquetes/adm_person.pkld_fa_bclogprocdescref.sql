CREATE OR REPLACE Package adm_person.Pkld_Fa_Bclogprocdescref Is
  /**********************************Paquete**************************************************
     Packages : Pkld_Fa_Bclogprocdescref
     Author  : Jery Ann Silvera De La Rans
     Created : 05/08/2013 10:21:31 a. m.
     Purpose : Servicio de componente que se encarga de Realizar transacciones
               sobre las entidad de Log de Error del Proceso de Descuento referido
  *******************************************************************************************/

  /*******************************************************************************
    Procedure   :   Pro_Insertloprdree
    Descripción :   Proceso que se encarga de insertar los registros en la entidad de Encabezado de Log de Proceso
    Autor       :   Jery Ann Silvera De La Rans
    Fecha       :   05/08/2013 10:21:31 a. m.
                                 Historia de Modificaciones
    Fecha       IDEntrega

    DD-MM-YYYY   Datos de quien entrega.
    05- 08- 2013  JsilveraSAO213632
    Creación del paquete y sus respectivos métodos
  *******************************************************************************/
  Procedure Pro_Insertloprdree(Nuloprcons Ld_Fa_Loprdree.Loprcons%Type,
                               Nuloprcode Ld_Fa_Loprdree.Loprcode%Type,
                               Sbloprtire Ld_Fa_Loprdree.Loprtire%Type,
                               Dtfechaini Ld_Fa_Loprdree.Loprfein%Type,
                               Dtfechafin Ld_Fa_Loprdree.Loprfefi%Type,
                               Nulopruse  Ld_Fa_Loprdree.Lopruse%Type,
                               Sbloprform Ld_Fa_Loprdree.Loprform%Type);

  /****************************************************************************
    Funcion       :  fsbVersion

    Descripcion :  Obtiene el SAO que identifica la version asociada a la
                     ultima entrega del paquete

    Retorno     :  csbVersion - Version del Paquete
  *****************************************************************************/

  Function Fsbversion Return Varchar2;
  /*******************************************************************************
    Procedure   :   Pro_Insertloprdred
    Descripción :   Proceso que se encarga de insertar los registros en la entidad de Detalle de Log de Proceso
    Autor       :   Jery Ann Silvera De La Rans
    Fecha       :   23/07/2013 10:21:31 a. m.
                                 Historia de Modificaciones
    Fecha       IDEntrega

    DD-MM-YYYY  Datos de quien entrega.
    Descripcion de la modificacion al objeto.
  *******************************************************************************/
  Procedure Pro_Insertloprdred(Nuloprcose Ld_Fa_Loprdred.Loprcose%Type,
                               Nuloprcodi Ld_Fa_Loprdred.Loprcodi%Type,
                               Nuloprsusc Ld_Fa_Loprdred.Loprsusc%Type,
                               Nuloprcuco Ld_Fa_Loprdred.LoprCUCO%Type,
                               Nuloprsecu Ld_Fa_Loprdred.Loprsecu%Type,
                               Sblopresta Ld_Fa_Loprdred.Lopresta%Type,
                               Sbloprmens Ld_Fa_Loprdred.Loprmens%Type,
                               Nuloprcrde Ld_Fa_Loprdred.Loprcrde%Type);

End Pkld_Fa_Bclogprocdescref;
/
CREATE OR REPLACE Package Body adm_person.Pkld_Fa_Bclogprocdescref Is

  /*******************************************************************************
    Procedure   :   Pro_Insertloprdree
    Descripción :   Proceso que se encarga de insertar los registros en la entidad de Encabezado de Log de Proceso
    Autor       :   Jery Ann Silvera De La Rans
    Fecha       :   05/08/2013 10:21:31 a. m.
                                 Historia de Modificaciones
    Fecha       IDEntrega

    DD-MM-YYYY  Datos de quien entrega.
    Descripcion de la modificacion al objeto.
  *******************************************************************************/

  Csbversion Constant Varchar2(250) := 'OSF-2884';
  Procedure Pro_Insertloprdree(Nuloprcons Ld_Fa_Loprdree.Loprcons%Type,
                               Nuloprcode Ld_Fa_Loprdree.Loprcode%Type,
                               Sbloprtire Ld_Fa_Loprdree.Loprtire%Type,
                               Dtfechaini Ld_Fa_Loprdree.Loprfein%Type,
                               Dtfechafin Ld_Fa_Loprdree.Loprfefi%Type,
                               Nulopruse  Ld_Fa_Loprdree.Lopruse%Type,
                               Sbloprform Ld_Fa_Loprdree.Loprform%Type) Is
    Pragma Autonomous_Transaction;
    /*****************************
         Historia de Modificaciones
        Fecha       IDEntrega

        DD-MM-YYYY   Datos de quien entrega.
        05- 08- 2013  JsilveraSAO213632
        Creación del paquete y sus respectivos métodos. Se crea un metodo para insertar el encabezado y detalle de la entidad de Log del proceso

        Sbterminal Ld_Fa_Loprdree.Loprterm%Type;
        Gsberrmsg  Ge_Message.Description%Type;
    **************************************************/

    Sbterminal Varchar2(90);
    Gsberrmsg ge_message.description%Type;
  Begin
    Pkerrors.Push('Pkld_Fa_Bclogprocdescref.Pro_Insertloprdree');

    Select Userenv('TERMINAL') Into Sbterminal From Dual;

    Insert Into Ld_Fa_Loprdree
      (Loprcons,
       Loprcode,
       Loprtire,
       Loprfein,
       Loprfefi,
       Lopruse,
       Loprfere,
       Loprterm,
       Loprform)
    Values
      (Nuloprcons,
       Nuloprcode,
       Sbloprtire,
       Dtfechaini,
       Dtfechafin,
       Nulopruse,
       Sysdate,
       Sbterminal,
       Sbloprform);
    Commit;
    Pkerrors.Pop;

  Exception
    When Others Then
      Ut_Trace.Trace('Error en el insert de la entidad Ld_Fa_Loprdree', 1);
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject,
                           'Error en el insert de la entidad Ld_Fa_Loprdree. ' ||
                           Sqlerrm,
                           Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
  End Pro_Insertloprdree;

  /*******************************************************************************
    Procedure   :   Pro_Insertloprdred
    Descripción :   Proceso que se encarga de insertar los registros en la entidad de Encabezado de Log de Proceso
    Autor       :   Jery Ann Silvera De La Rans
    Fecha       :   05/08/2013 10:21:31 a. m.
                                 Historia de Modificaciones
    Fecha       IDEntrega

    DD-MM-YYYY  Datos de quien entrega.
    Descripcion de la modificacion al objeto.
  *******************************************************************************/
  Procedure Pro_Insertloprdred(Nuloprcose Ld_Fa_Loprdred.Loprcose%Type,
                               Nuloprcodi Ld_Fa_Loprdred.Loprcodi%Type,
                               Nuloprsusc Ld_Fa_Loprdred.Loprsusc%Type,
                               Nuloprcuco Ld_Fa_Loprdred.Loprcuco%Type,
                               Nuloprsecu Ld_Fa_Loprdred.Loprsecu%Type,
                               Sblopresta Ld_Fa_Loprdred.Lopresta%Type,
                               Sbloprmens Ld_Fa_Loprdred.Loprmens%Type,
                               Nuloprcrde Ld_Fa_Loprdred.Loprcrde%Type) Is
    Pragma Autonomous_Transaction;

    Gsberrmsg Ge_Message.Description%Type;
  Begin

    Pkerrors.Push('Pkld_Fa_Bclogprocdescref.Pro_Insertloprdred');

    Insert Into Ld_Fa_Loprdred
      (Loprcose,
       Loprcodi,
       Loprsusc,
       Loprcuco,
       Loprsecu,
       Lopresta,
       Loprmens,
       Loprcrde)
    Values
      (Nuloprcose,
       Nuloprcodi,
       Nuloprsusc,
       Nuloprcuco,
       Nuloprsecu,
       Sblopresta,
       Sbloprmens,
       Nuloprcrde);
    Commit;
    Pkerrors.Pop;
  Exception
    When Others Then
      Ut_Trace.Trace('Error en el insert de la entidad Ld_Fa_Loprdred', 1);
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject,
                           'Error en el insert de la entidad Ld_Fa_Loprdred. ' ||
                           Sqlerrm,
                           Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
  End Pro_Insertloprdred;

  /****************************************************************************
    Funcion       :  fsbVersion

    Descripcion :  Obtiene el SAO que identifica la version asociada a la
                     ultima entrega del paquete

    Retorno     :  csbVersion - Version del Paquete
  *****************************************************************************/

  Function Fsbversion Return Varchar2 Is
  Begin
    --{
    -- Retorna el SAO con que se realizó la última entrega del paquete
    Return(Csbversion);
    --}
  End Fsbversion;
End Pkld_Fa_Bclogprocdescref;
/
Prompt Otorgando permisos sobre ADM_PERSON.Pkld_Fa_Bclogprocdescref
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('Pkld_Fa_Bclogprocdescref'), 'ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.PKLD_FA_BCLOGPROCDESCREF to REXEOPEN;
GRANT EXECUTE on ADM_PERSON.PKLD_FA_BCLOGPROCDESCREF to RSELSYS;
/
