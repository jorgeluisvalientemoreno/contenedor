CREATE OR REPLACE Package adm_person.pkLD_FA_BcDescPrPago IS

  /*************************************************************************************************************
        Propiedad intelectual de Ludycom S.A.

        Unidad         : pkLD_FA_BcDescPrPago
        Descripción    : Componente de negocio que encarga de  llevar a los registros de los descuentos por pronto pago.
        Autor          : yennis.thorrens.SAOYennis thorrens.
        Fecha          : 19/09/2012

        Métodos

        Nombre         : InsertDescprpa
        Descripción    : Componente de negocio que permite registrar los descuentos por pronto pago
                         realizado a los suscriptores.

        Parámetros     :

        Nombre Parámetro  Tipo de parámetro        Tipo de dato del parámetro                     Descripción
          inudeppcode          Entrada                   ld_fa_descprpa.deppcode%TYPE                   Parámetro de código de matrícula de descuento
          inudeppgelo          Entrada                   ld_fa_descprpa.deppgelo%TYPE                   Parámetro de código de la ubicación geografica (departamento, localidad, barrio)
          inudeppcate          Entrada                   ld_fa_descprpa.deppcate%TYPE                   Parámetro de categoría (uso)
          inudeppsuca          Entrada                   ld_fa_descprpa.deppsuca%TYPE                   Parámetro de subcategoría (estrato)
          inudeppsusc          Entrada                   ld_fa_descprpa.deppsusc%TYPE                   Parámetro de suscripción
          inudeppcoba          Entrada                   ld_fa_descprpa.deppcoba%TYPE                   Parámetro de concepto base
          inudeppvade          Entrada                   ld_fa_descprpa.deppvade%TYPE                   Parámetro de valor de descuento
          inudeppcoap          Entrada                   ld_fa_descprpa.deppcoap%TYPE                   Parámetro de concepto a aplicar
          inudeppdife          Entrada                   ld_fa_descprpa.deppdife%TYPE                   Parámetro de código diferido
          inudeppnucu          Entrada                   ld_fa_descprpa.deppnucu%TYPE                   Parámetro de número de cuotas
          inudeppvacu          Entrada                   ld_fa_descprpa.deppvacu%TYPE                   Parámetro de valor cuota
          inudeppusid          Entrada                   ld_fa_descprpa.deppusid%TYPE                   Parámetro de usuario que ingresa registro
          idtdeppfere          Entrada                   ld_fa_descprpa.deppfere%TYPE                   Parámetro de fecha que ingresa registro
          inuesdecodi          Entrada                   ld_fa_estadesc.esdecodi%TYPE                   Parámetro de estado del proceso
          inucrdecode          Entrada                   ld_fa_critdesc.crdecode%TYPE                   Parámetro de código del criterio de descuento
          onuResp              Salida                    NUMBER                                         Parámetro para código de error
  **************************************************************************************************************************************

        Nombre         : UpdateDescPrPa
        Descripción    : Componente de negocio que permite actualizar los descuentos por pronto pago
                         realizado a los suscriptores.

        Parámetros     :

        Nombre Parámetro  Tipo de parámetro        Tipo de dato del parámetro                     Descripción
          inudeppsusc           Entrada                 Suscripc.Susccodi%TYPE                       Parámetro del código de suscripción
          inudeppgelo           Entrada                 ld_fa_descprpa.deppgelo%TYPE                 Parámetro de código de la ubicación geografica (departamento, localidad, barrio)
          inudeppcate           Entrada                 ld_fa_descprpa.deppcate%TYPE                 Parámetro de categoría (uso)
          inudeppsuca           Entrada                 ld_fa_descprpa.deppsuca%TYPE                 Parámetro de subcategoría (estrato)
          inudeppcoba           Entrada                 ld_fa_descprpa.deppcoba%TYPE                 Parámetro de concepto base
          inudeppdife           Entrada                 ld_fa_descprpa.deppdife%TYPE                 Parámetro de código diferido
          inuesdecodi           Entrada                 ld_fa_descprpa.esdecodi%TYPE                 Parámetro de estado del proceso
  **************************************************************************************************************************************

        Historia de Modificaciones
        Fecha             Autor             Modificación
        =========         =========         ====================
  ******************************************************************************************************************/

  PROCEDURE InsertDescPrPa (Inudeppcode In  Ld_Fa_Descprpa.Deppcode%Type,
                            Inudeppgepa In  Ld_Fa_Descprpa.Deppgelo%Type,
                            Inudeppgede In  Ld_Fa_Descprpa.Deppgelo%Type,
                            Inudeppgelo In  Ld_Fa_Descprpa.Deppgelo%Type,
                            Inudeppgeba In  Ld_Fa_Descprpa.Deppgelo%Type,
                            Inudeppcate In  Ld_Fa_Descprpa.Deppcate%Type,
                            Inudeppsuca In  Ld_Fa_Descprpa.Deppsuca%Type,
                            Inudeppsusc In  Ld_Fa_Descprpa.Deppsusc%Type,
                            Inudeppcoba In  Ld_Fa_Descprpa.Deppcoba%Type,
                            Inudeppvade In  Ld_Fa_Descprpa.Deppvade%Type,
                            Inudeppcoap In  Ld_Fa_Descprpa.Deppcoap%Type,
                            Inudeppdife In  Ld_Fa_Descprpa.Deppdife%Type,
                            Inudeppnucu In  Ld_Fa_Descprpa.Deppnucu%Type,
                            Inudeppvacu In  Ld_Fa_Descprpa.Deppvacu%Type,
                            Inudeppusid In  Ld_Fa_Descprpa.Deppusid%Type,
                            Idtdeppfere In  Ld_Fa_Descprpa.Deppfere%Type,
                            Inuesdecodi In  Ld_Fa_Estadesc.Esdecodi%Type,
                            Inucrdecode In  Ld_Fa_Critdesc.Crdecode%Type,
                            Onuresp     Out Number);

  PROCEDURE UpdateDescPrPa (Inudeppsusc In  Suscripc.Susccodi%Type,
                            Inudeppdife In  Ld_Fa_Descprpa.Deppdife%Type,
                            Inuesdecodi In  Ld_Fa_Descprpa.deppcoes%Type,
                            InuSaldo    In  Ld_Fa_Descprpa.Deppsade%Type);

  -- Obtiene la Version actual del Paquete
  FUNCTION fsbVersion RETURN varchar2;

End pkLD_FA_BcDescPrPago;
/
CREATE OR REPLACE Package Body adm_person.pkLD_FA_BcDescPrPago Is
--{

    -- Esta constante se debe modificar cada vez que se entregue el
    -- paquete con un SAO
    csbVersion constant varchar2(250) := 'OSF-2884';

  -- Registra la Matricula del Descuento por Pronto Pago

  PROCEDURE InsertDescPrPa
  (
   Inudeppcode In Ld_Fa_Descprpa.Deppcode%Type,
   Inudeppgepa In Ld_Fa_Descprpa.Deppgelo%Type,
   Inudeppgede In Ld_Fa_Descprpa.Deppgelo%Type,
   Inudeppgelo In Ld_Fa_Descprpa.Deppgelo%Type,
   Inudeppgeba In Ld_Fa_Descprpa.Deppgelo%Type,
   Inudeppcate In Ld_Fa_Descprpa.Deppcate%Type,
   Inudeppsuca In Ld_Fa_Descprpa.Deppsuca%Type,
   Inudeppsusc In Ld_Fa_Descprpa.Deppsusc%Type,
   Inudeppcoba In Ld_Fa_Descprpa.Deppcoba%Type,
   Inudeppvade In Ld_Fa_Descprpa.Deppvade%Type,
   Inudeppcoap In Ld_Fa_Descprpa.Deppcoap%Type,
   Inudeppdife In Ld_Fa_Descprpa.Deppdife%Type,
   Inudeppnucu In Ld_Fa_Descprpa.Deppnucu%Type,
   Inudeppvacu In Ld_Fa_Descprpa.Deppvacu%Type,
   Inudeppusid In Ld_Fa_Descprpa.Deppusid%Type,
   Idtdeppfere In Ld_Fa_Descprpa.Deppfere%Type,
   Inuesdecodi In Ld_Fa_Estadesc.Esdecodi%Type,
   Inucrdecode In Ld_Fa_Critdesc.Crdecode%Type,
   Onuresp     Out Number
  )
  IS

    Gsberrmsg Ge_Error_Log.Description%Type; -- Mensaje de Error

  BEGIN
  --{
    Pkerrors.Push('pkLD_FA_BcDescPrPago.InsertDescPrPa');

    -- Inserta el registro de la Matriculas en la tabla de Descuentos por Pronto Pago
    Insert Into Ld_Fa_Descprpa
      (Deppcode,
       Deppgepa,
       Deppgede,
       Deppgelo,
       Deppgeba,
       Deppcate,
       Deppsuca,
       Deppsusc,
       Deppcoba,
       Deppvade,
       Deppcoap,
       Deppdife,
       Deppnucu,
       Deppvacu,
       Deppusid,
       Deppfere,
       Deppcoes,
       Deppcrde)
    Values
      (Inudeppcode,
       Inudeppgepa,
       Inudeppgede,
       Inudeppgelo,
       Inudeppgeba,
       Inudeppcate,
       Inudeppsuca,
       Inudeppsusc,
       Inudeppcoba,
       Inudeppvade,
       Inudeppcoap,
       Inudeppdife,
       Inudeppnucu,
       Inudeppvacu,
       Inudeppusid,
       Idtdeppfere,
       Inuesdecodi,
       Inucrdecode);

    Onuresp := 1;
    Pkerrors.Pop;

  Exception
    When Others Then
      Onuresp := -1;
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
  --}
  End Insertdescprpa;

  -- Actualiza el Estado y el Saldo de los Descuentos por Pronto Pago (matricula)

  PROCEDURE UpdateDescPrPa
  (
    Inudeppsusc In  Suscripc.Susccodi%Type,
    Inudeppdife In  Ld_Fa_Descprpa.Deppdife%Type,
    Inuesdecodi In  Ld_Fa_Descprpa.deppcoes%Type,
    InuSaldo    In  Ld_Fa_Descprpa.Deppsade%Type
  )
  IS

    Gsberrmsg Ge_Error_Log.Description%Type; -- Mensaje de Error

  BEGIN
  --{
    Pkerrors.Push('pkLD_FA_BcDescPrPago.UpdateDescPrPa');

    UPDATE Ld_Fa_Descprpa
    SET    deppcoes = Inuesdecodi,  -- Estado del Descuento
           deppsade = InuSaldo      -- Saldo del Descuento
    WHERE  Deppsusc = Inudeppsusc
    AND    Deppdife = Inudeppdife;

    Pkerrors.Pop;

  EXCEPTION
    When Others Then
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
  --}
  End Updatedescprpa;

    /****************************************************************************
      Funcion       :  fsbVersion

      Descripcion	:  Obtiene el SAO que identifica la version asociada a la
                       ultima entrega del paquete

      Retorno	    :  csbVersion - Version del Paquete
    *****************************************************************************/

    FUNCTION fsbVersion RETURN varchar2 IS
    BEGIN
    --{
        -- Retorna el SAO con que se realizó la última entrega del paquete
        return (csbVersion);
    --}
    END fsbVersion;

--}
End pkLD_FA_BcDescPrPago;
/
Prompt Otorgando permisos sobre ADM_PERSON.pkLD_FA_BcDescPrPago
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkLD_FA_BcDescPrPago'), 'ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.PKLD_FA_BCDESCPRPAGO to REXEOPEN;
GRANT EXECUTE on ADM_PERSON.PKLD_FA_BCDESCPRPAGO to RSELSYS;
/
