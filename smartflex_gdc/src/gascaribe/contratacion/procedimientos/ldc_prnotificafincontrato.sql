CREATE OR REPLACE PROCEDURE LDC_PRNOTIFICAFINCONTRATO
IS
/**************************************************************************
    Autor       : Santiago Gonzales / Horbath
    Fecha       : 2020-11-05
    Ticket      : 491
    Descripción: Notifica los contratos que se encuentra por finalizar

    Parámetros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    29/04/2024  jpinedc     OSF-2581: Se reemplaza ldc_sendemail por
                            pkg_Correo.prcEnviaCorreo
***************************************************************************/

    cnuSTATUSAB     CONSTANT ge_contrato.status%TYPE := 'AB';
    dtSysdate       DATE    := ut_date.fdtsysdate;
    nuCantDias      NUMBER;
    sbSubject       VARCHAR2(200);
    sbMessage       VARCHAR2(2000);
    tbEmails        ut_string.tytb_string;
    nuIdx           NUMBER;


    CURSOR cuContratoCierre
    IS
        SELECT  gc.id_contrato,
                gc.id_contratista,
                gc.fecha_final,
                UPPER(ma.diashabil) flag,
                ma.diascierre1,
                ma.diascierre2,
                ma.correo
        FROM LDC_MONTO_ACTA ma, ge_contrato gc
        WHERE ma.id_contrato = gc.id_contrato
        AND gc.status = cnuSTATUSAB
        AND gc.fecha_final > dtSysdate;


    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');

BEGIN
    pkg_Traza.Trace('Inicia LDC_PRNOTIFICAFINCONTRATO',5);

    FOR rcCont IN cuContratoCierre LOOP

        -- Se valida si el contrato está configurado con días habiles
        IF rcCont.flag = 'S' THEN
            nuCantDias := pkholidaymgr.fnugetnumofdaynonholiday(dtSysdate, rcCont.fecha_final);
        ELSE
            nuCantDias := TRUNC(rcCont.fecha_final) - TRUNC(dtSysdate);
        END IF;

        pkg_Traza.Trace('LDC_PRNOTIFICAFINCONTRATO - nuCantDias: '||nuCantDias,5);

        -- Se valida si la cantidad de días habiles está configurado
        IF nuCantDias = rcCont.diascierre1 OR nuCantDias = rcCont.diascierre2 THEN
            -- Se valida si el correo está configurado
            IF rcCont.correo IS NOT NULL THEN

                ut_string.extstring(rcCont.correo, ',' ,tbEmails);

                nuIdx := tbEmails.FIRST;
                WHILE nuIdx IS NOT NULL LOOP

                    sbSubject := 'Contrato próximo a vencer en '||nuCantDias||' días';
                    sbMessage := 'El contrato con código '||rcCont.id_contrato||' del contratista '||rcCont.id_contratista||' - '|| dage_contratista.fsbgetnombre_contratista(rcCont.id_contratista,0)
                                  ||', vencerá en '||nuCantDias||' días, por lo que debe gestionar los procesos que tenga pendientes.';

                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => sbRemitente,
                        isbDestinatarios    => TRIM(tbEmails(nuIdx)),
                        isbAsunto           => sbSubject,
                        isbMensaje          => sbMessage
                    );

                    pkg_Traza.Trace('Se envia correo correctamente',5);

                    nuIdx := tbEmails.NEXT(nuIdx);

                END LOOP;

            END IF;
        END IF;

    END LOOP;

    pkg_Traza.Trace('Finaliza LDC_PRNOTIFICAFINCONTRATO',5);
EXCEPTION
    when pkg_Error.CONTROLLED_ERROR then
        raise pkg_Error.CONTROLLED_ERROR;
    when OTHERS then
        pkg_Error.setError;
        raise pkg_Error.CONTROLLED_ERROR;
END LDC_PRNOTIFICAFINCONTRATO;
/
