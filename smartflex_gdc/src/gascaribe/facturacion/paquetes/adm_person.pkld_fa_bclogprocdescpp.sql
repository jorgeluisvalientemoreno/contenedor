CREATE OR REPLACE Package adm_person.Pkld_Fa_Bclogprocdescpp Is
  /**********************************Paquete**************************************************
     Packages : Pkld_Fa_Bclogprocdescpp
     Author  : Jery Ann Silvera De La Rans
     Created : 23/07/2013 10:21:31 a. m.
     Purpose : Servicio de componente que se encarga de Realizar transacciones
               sobre las entidad de Log de Error del Proceso de Descuento pronto Pago
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    19/06/2024              PAcosta         OSF-2845: Cambio de esquema ADM_PERSON  
  *******************************************************************************************/

  /*******************************************************************************
    Procedure   :   Pro_Insertloprdppe
    Descripción :   Proceso que se encarga de insertar los registros en la entidad de Encabezado de Log de Proceso
    Autor       :   Jery Ann Silvera De La Rans
    Fecha       :   23/07/2013 10:21:31 a. m.
                                 Historia de Modificaciones
    Fecha       IDEntrega

    DD-MM-YYYY   Datos de quien entrega.
    30- 07- 2013  JsilveraSAO212458
    Creación del paquete y sus respectivos métodos
  *******************************************************************************/
  Procedure Pro_Insertloprdppe(Nuloprcons Ld_Fa_Loprdppe.Loprcons%Type,
                               Nuloprcode Ld_Fa_Loprdppe.Loprcode%Type,
                               Sbloprtire Ld_Fa_Loprdppe.Loprtire%Type,
                               Dtfechaini Ld_Fa_Loprdppe.Loprfein%Type,
                               Dtfechafin Ld_Fa_Loprdppe.Loprfefi%Type,
                               Nuloprperi Ld_Fa_Loprdppe.Loprperi%Type,
                               Nulopruse  Ld_Fa_Loprdppe.Lopruse%Type,
                               Sbloprform Ld_Fa_Loprdppe.Loprform%Type);

  /****************************************************************************
    Funcion       :  fsbVersion

    Descripcion :  Obtiene el SAO que identifica la version asociada a la
                     ultima entrega del paquete

    Retorno     :  csbVersion - Version del Paquete
  *****************************************************************************/

  Function Fsbversion Return Varchar2;
  /*******************************************************************************
    Procedure   :   Pro_Insertloprdppd
    Descripción :   Proceso que se encarga de insertar los registros en la entidad de Detalle de Log de Proceso
    Autor       :   Jery Ann Silvera De La Rans
    Fecha       :   23/07/2013 10:21:31 a. m.
                                 Historia de Modificaciones
    Fecha       IDEntrega

    DD-MM-YYYY  Datos de quien entrega.
    Descripcion de la modificacion al objeto.
  *******************************************************************************/
  Procedure Pro_Insertloprdppd(Nuloprcose Ld_Fa_Loprdppd.Loprcose%Type,
                               Nuloprcodi Ld_Fa_Loprdppd.Loprcodi%Type,
                               Nuloprsusc Ld_Fa_Loprdppd.Loprsupr%Type,
                               Nuloprdife Ld_Fa_Loprdppd.Loprdffi%Type,
                               Nuloprsecu Ld_Fa_Loprdppd.Loprsecu%Type,
                               Sblopresta Ld_Fa_Loprdppd.Lopresta%Type,
                               Sbloprmens Ld_Fa_Loprdppd.Loprmens%Type,
                               Nuloprcrde Ld_Fa_Loprdppd.Loprcrde%Type,
                               Nuloprtiso Ld_Fa_Loprdppd.Loprtiso%Type);

End Pkld_Fa_Bclogprocdescpp;
/
CREATE OR REPLACE Package Body adm_person.Pkld_Fa_Bclogprocdescpp Is

  /*******************************************************************************
    Procedure   :   Pro_Insertloprdppe
    Descripción :   Proceso que se encarga de insertar los registros en la entidad de Encabezado de Log de Proceso
    Autor       :   Jery Ann Silvera De La Rans
    Fecha       :   23/07/2013 10:21:31 a. m.
                                 Historia de Modificaciones
    Fecha       IDEntrega

    DD-MM-YYYY  Datos de quien entrega.
    Descripcion de la modificacion al objeto.
  *******************************************************************************/

  Csbversion Constant Varchar2(250) := 'SAO212458';
  Procedure Pro_Insertloprdppe(Nuloprcons Ld_Fa_Loprdppe.Loprcons%Type,
                               Nuloprcode Ld_Fa_Loprdppe.Loprcode%Type,
                               Sbloprtire Ld_Fa_Loprdppe.Loprtire%Type,
                               Dtfechaini Ld_Fa_Loprdppe.Loprfein%Type,
                               Dtfechafin Ld_Fa_Loprdppe.Loprfefi%Type,
                               Nuloprperi Ld_Fa_Loprdppe.Loprperi%Type,
                               Nulopruse  Ld_Fa_Loprdppe.Lopruse%Type,
                               Sbloprform Ld_Fa_Loprdppe.Loprform%Type) Is
    Pragma Autonomous_Transaction;
    /*****************************
         Historia de Modificaciones
        Fecha       IDEntrega

        DD-MM-YYYY   Datos de quien entrega.
        30- 07- 2013  JsilveraSAO212458
        Creación del paquete y sus respectivos métodos. Se crea un metodo para insertar el encabezado y detalle de la entidad de Log del proceso

        Sbterminal Ld_Fa_Loprdppe.Loprterm%Type;
        Gsberrmsg  Ge_Message.Description%Type;
    **************************************************/

    Sbterminal Varchar2(90);
    Gsberrmsg ge_message.description%Type;
  Begin
    Pkerrors.Push('Pkld_Fa_Bclogprocdescpp.Pro_Insertloprdppe');

    Select Userenv('TERMINAL') Into Sbterminal From Dual;

    Insert Into Ld_Fa_Loprdppe
      (Loprcons,
       Loprcode,
       Loprtire,
       Loprfein,
       Loprfefi,
       Loprperi,
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
       Nuloprperi,
       Nulopruse,
       Sysdate,
       Sbterminal,
       Sbloprform);
    Commit;
    Pkerrors.Pop;

  Exception
    When Others Then
      Ut_Trace.Trace('Error en el insert de la entidad Ld_Fa_Loprdppe', 1);
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject,
                           'Error en el insert de la entidad Ld_Fa_Loprdppe. ' ||
                           Sqlerrm,
                           Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
  End Pro_Insertloprdppe;

  /*******************************************************************************
    Procedure   :   Pro_Insertloprdppe
    Descripción :   Proceso que se encarga de insertar los registros en la entidad de Encabezado de Log de Proceso
    Autor       :   Jery Ann Silvera De La Rans
    Fecha       :   23/07/2013 10:21:31 a. m.
                                 Historia de Modificaciones
    Fecha       IDEntrega

    DD-MM-YYYY  Datos de quien entrega.
    Descripcion de la modificacion al objeto.
  *******************************************************************************/
  Procedure Pro_Insertloprdppd(Nuloprcose Ld_Fa_Loprdppd.Loprcose%Type,
                               Nuloprcodi Ld_Fa_Loprdppd.Loprcodi%Type,
                               Nuloprsusc Ld_Fa_Loprdppd.Loprsupr%Type,
                               Nuloprdife Ld_Fa_Loprdppd.Loprdffi%Type,
                               Nuloprsecu Ld_Fa_Loprdppd.Loprsecu%Type,
                               Sblopresta Ld_Fa_Loprdppd.Lopresta%Type,
                               Sbloprmens Ld_Fa_Loprdppd.Loprmens%Type,
                               Nuloprcrde Ld_Fa_Loprdppd.Loprcrde%Type,
                               Nuloprtiso Ld_Fa_Loprdppd.Loprtiso%Type) Is
    Pragma Autonomous_Transaction;

    Gsberrmsg Ge_Message.Description%Type;
  Begin

    Pkerrors.Push('Pkld_Fa_Bclogprocdescpp.Pro_Insertloprdppd');

    Insert Into Ld_Fa_Loprdppd
      (Loprcose,
       Loprcodi,
       Loprsupr,
       Loprdffi,
       Loprsecu,
       Lopresta,
       Loprmens,
       Loprcrde,
       Loprtiso)
    Values
      (Nuloprcose,
       Nuloprcodi,
       Nuloprsusc,
       Nuloprdife,
       Nuloprsecu,
       Sblopresta,
       Sbloprmens,
       Nuloprcrde,
       Nuloprtiso);
    Commit;
    Pkerrors.Pop;
  Exception
    When Others Then
      Ut_Trace.Trace('Error en el insert de la entidad Ld_Fa_Loprdppd', 1);
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject,
                           'Error en el insert de la entidad Ld_Fa_Loprdppd. ' ||
                           Sqlerrm,
                           Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
  End Pro_Insertloprdppd;

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
End Pkld_Fa_Bclogprocdescpp;
/
PROMPT Otorgando permisos de ejecucion a PKLD_FA_BCLOGPROCDESCPP
BEGIN
    pkg_utilidades.praplicarpermisos('PKLD_FA_BCLOGPROCDESCPP', 'ADM_PERSON');
END;
/