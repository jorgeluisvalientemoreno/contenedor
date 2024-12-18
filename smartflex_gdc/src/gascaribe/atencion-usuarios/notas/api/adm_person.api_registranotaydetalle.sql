create or replace PROCEDURE adm_person.api_registranotaydetalle(    ircNota           IN pkg_bcnotasrecord.tyrcNota,
                                                                    itbCargos         IN pkg_bcnotasrecord.tytbCargos,
                                                                    onuNote           OUT  NUMBER,
                                                                    onuCodigoError    OUT  NUMBER,
                                                                    osbMensajeError   OUT  VARCHAR2 ) IS

/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : api_registranotaydetalle
     Descripcion     : api para registrar notas y detalle de notas
     Autor           : Diana Patricia Montes Hurtado
     Fecha           : 07-07-2023

    Parametros de Entrada
    ircNota                 Nota
    itbCargos               Cargos
    Parametros de Salida
     onuNote                numero de la nota
     onuCodigoError         codigo de error
     osbMensajeError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    ljlb         11/09/2023    OSF-1561: se ajusta api para quitar validacion de campo
                               notacons y campo cargdoso
    diana.montes 01/08/2023    OSF-1246: retorna el numero de la nota creada
    diana.montes 01/08/2023    OSF-1246: Se inicializan las variales
                               onuCodigoError y osbMensajeError.
  ***************************************************************************/


    sbnotaNulos varchar2(200);
    sbCargDoso  varchar2(200);
    PROCEDURE prValidaNota( ircNota IN pkg_bcnotasrecord.tyrcNota) IS
    BEGIN
        UT_Trace.Trace('Inicio adm_person.api_registranotaydetalle.prValidaNota',10);
        IF ircNota.nuProducto IS NULL
        THEN
            sbnotaNulos :='nuProducto';
        END IF;
        IF ircNota.nuCuencobr IS NULL
        THEN
            sbnotaNulos := sbnotaNulos||', nuCuencobr';
        END IF;
        
        IF ircNota.dtNotafeco IS NULL
        THEN
            sbnotaNulos := sbnotaNulos||', dtNotafeco';
        END IF;
        IF ircNota.sbNotaobse IS NULL
        THEN
            sbnotaNulos := sbnotaNulos||', sbNotaobse';
        END IF;
        IF ircNota.sbNotaToken IS NULL
        THEN
            sbnotaNulos := sbnotaNulos||',sbNotaToken';
        END IF;

        if sbnotaNulos is not null
        THEN
            pkg_Error.setErrorMessage(isbMsgErrr=>'No se enviaron valores en los siguientes campos del registro de notas '||sbnotaNulos);
        END IF;
        UT_Trace.Trace('Fin adm_person.api_registranotaydetalle.prValidaNota',10);
    END prValidaNota;

BEGIN
       UT_Trace.Trace('Inicio adm_person.api_registranotaydetalle',10);
        pkg_error.prInicializaError(onuCodigoError,osbMensajeError);
        prValidaNota(ircNota);

        pkg_error.setApplication(ircNota.sbPrograma);
        pkBillingNoteMgr.CreateBillingNote
        (
            ircNota.nuProducto,
            ircNota.nuCuencobr,
            ircNota.nuNotacons,
            ircNota.dtNotafeco,
            ircNota.sbNotaobse,
            ircNota.sbNotaToken,
            onuNote
        );
        UT_Trace.Trace('crea la nota: '||onuNote,10);

        IF itbCargos.count = 0 then
            --No hay cargos a crear detalle
            UT_Trace.Trace('No hay cargos a crear detalle',10);
            pkg_Error.setErrorMessage(isbMsgErrr=>'No se enviaron valores en cargos '||sbnotaNulos);

        ELSE
            FOR idx IN 1..itbCargos.Count
            LOOP
                IF itbCargos(idx).sbCargdoso IS NULL THEN
                   sbCargDoso := itbCargos(idx).sbSigno||'-'||onuNote;
                ELSE
                   sbCargDoso := itbCargos(idx).sbCargdoso;
                END IF;
                -- crea detalle
                FA_BOBillingNotes.DetailRegister
                (
                    onuNote,
                    itbCargos(idx).nuProducto,
                    itbCargos(idx).nuContrato,
                    itbCargos(idx).nuCuencobr,
                    itbCargos(idx).nuConcepto,
                    itbCargos(idx).NuCausaCargo,
                    itbCargos(idx).nuValor,
                    itbCargos(idx).nuValorBase,
                    sbCargDoso,
                    itbCargos(idx).sbSigno,
                    itbCargos(idx).sbAjustaCuenta,
                    itbCargos(idx).sbNotaDocu,
                    itbCargos(idx).sbBalancePostivo,
                    itbCargos(idx).boApruebaBal
                );
                UT_Trace.Trace('Crear detalle del cargo al producto: '||itbCargos(idx).nuProducto,10);
            END LOOP;
        END IF;
        UT_Trace.Trace('Fin adm_person.api_registranotaydetalle',10);
    EXCEPTION
      WHEN PKG_ERROR.CONTROLLED_ERROR THEN
        pkg_Error.setError;
        pkg_Error.GETERROR(onuCodigoError, osbMensajeError);
      WHEN OTHERS THEN
        pkg_Error.SETERROR;
        pkg_Error.GETERROR(onuCodigoError, osbMensajeError);
END api_registranotaydetalle;
/
PROMPT Otorgando permisos de ejecución a API_REGISTRANOTAYDETALLE
BEGIN
  pkg_utilidades.prAplicarPermisos('API_REGISTRANOTAYDETALLE', 'ADM_PERSON'); 
END;
/