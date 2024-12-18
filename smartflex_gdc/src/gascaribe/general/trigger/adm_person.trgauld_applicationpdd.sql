CREATE OR REPLACE TRIGGER ADM_PERSON.trgauLD_ApplicationPDD
  AFTER UPDATE ON procejec
  FOR EACH Row


  /*******************************************************************************
    Este trigger se dispara una vez que se realice actualización sobre la entidad
    PROCEJEC (Procesos Ejecutados por Periodo de Facturación) para indicar que el
    procesos de Generación de Facturas (FGCC) del Periodo abierto ha terminado y
    se encargará de ejecutar el proceso encargado de realizar la aplicación de
    Descuentos por Pronto Pago (FGDP).

    Historia de Modificaciones (De la más reciente a la más antigua)

    Fecha           IDEntrega
    22-03-2014      JsilveraSAO236331
    Se setea el nombre del aplicativo dentro del condicional de If (Upper(:New.Prejprog) = 'FGCC' And Upper(:New.Prejespr) = 'T') Then
    para el programa de aplicación de descuento pronto pago FGDP
    y se vuelve a setear antes de finalizar el If al programa original FGCC

    21-08-2013      jsilveraSAO215198
    Se ajustan las rutinas que llenan los logs y el progreso del programa.

    13-08-2013      smunozSAO213460
    Se incluye el historial de modificaciones al trigger


    DD-MM-2013      usuarioSAO######
    Descripción breve, precisa y clara de la modificación realizada.
  *******************************************************************************/




Declare
  Pragma Autonomous_Transaction;

  Sbvalorpa    Ld_Fa_Paragene.Pagevate%Type := 'FGDP'; -- Programa
  Cantidad     Number := 0; -- Contador de Registros
  Seq_Estaprog Number; -- Consecutivo del Registro
  Inuerror     Ge_Error_Log.Error_Log_Id%Type; -- Código de Error
  Isbmenserror Ge_Error_Log.Description%Type; -- Mensaje de Error

Begin
  --{
  Pkerrors.Push('trgauLD_ApplicationPDD');

  -- Valida que el proceso de Generación de Facturas haya Terminado exitosamente

  If (Upper(:New.Prejprog) = 'FGCC' And Upper(:New.Prejespr) = 'T') Then
    --{
    Pkerrors.Setapplication(Sbvalorpa);

    -- Obtiene el siguiente consecutivo del registro
    Seq_Estaprog := Sqesprprog.Nextval;

    -- Valida si el registro ya existe en PROCEJEC

    Begin
      --{
      Select Count(1)
        Into Cantidad
        From Procejec
       Where Prejcope = :New.Prejcope
         And Prejprog = Sbvalorpa;

    Exception
      When Others Then
        Null;
        --}
    End;

    If (Cantidad = 0) Then
      --{
      -- Inserta en Procesos Ejecutados
      -- Inserta en Procejec <<Jsilvera SAO213460 02/08/2013>>
      -- Se ajustan la rutina que llena el log del programa. jsilveraSAO215198
      Pkexecutedprocessmgr.Addrecord(:New.Prejcope, -- Periodo
                                     Sbvalorpa /*|| Seq_Estaprog*/, -- programa,
                                     'pkLD_FA_BcApplicationPDD.Prc_SeleccionarSuscriptores(' ||
                                     :New.Prejcope || ',' || Sbvalorpa || ',' ||
                                     Seq_Estaprog || ')', -- sentencia a ejecutar
                                     -1,
                                     Pksessionmgr.Fsbgetprocsession); -- Session

      --}
    End If;

    -- Inserta en Estado del Proceso
    Pkstatusexeprogrammgr.Addrecord(Sbvalorpa || Seq_Estaprog, -- programa,
                                    'Proceso automatico en Ejecución...',
                                    0, -- total de registros
                                    0, -- Registros a facturar
                                    :New.Prejcope); -- periodo

    Pkgeneralservices.Committransaction;

    -- Selecciona los suscriptores a procesar en la Aplicación del Descuento por Pronto Pago
    Pkld_Fa_Bcapplicationpdd.Prc_Seleccionarsuscriptores(:New.Prejcope,
                                                         Sbvalorpa,
                                                         Seq_Estaprog);

    -- Actualiza el Estado del Proceso
    Pkstatusexeprogrammgr.Processfinishok(Sbvalorpa || Seq_Estaprog);

    -- Actualiza en Procesos Ejecutados como Terminado
    Pkexecutedprocessmgr.Upendprocess_Status(:New.Prejcope, Sbvalorpa, -1);
    --}

    Pkerrors.Setapplication('FGCC');

  End If; -- Fin Validacion del Proceso FGCC

  -- Asienta la Transaccion
  Pkgeneralservices.Committransaction;

  Pkerrors.Pop;

Exception
  When Others Then
    Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Isbmenserror);
    Pkstatusexeprogrammgr.Processfinishnok(Sbvalorpa || Seq_Estaprog); -- Finalizado con Errores
    Pkerrors.Pop;
    Pkgeneralservices.Rollbacktransaction; -- Reversa la Transaccion
    Raise_Application_Error(Pkconstante.Nuerror_Level2, Isbmenserror);
    --}
End Trgauld_Applicationpdd;
/
