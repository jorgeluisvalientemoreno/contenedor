PL/SQL Developer Test script 3.0
37
DECLARE
        isbAllReads     varchar2(4000):='K-2367178-13;1=419=T===';

        tbEquipmentReads    ut_string.TyTb_String;

        nuIndexRead         number;

    BEGIN

        ut_trace.trace('-- INICIO OR_BOActivitiesLegalizeByFile.processReadByLine',3);

        IF(isbAllReads IS not null) THEN
            ut_string.ExtString(isbAllReads, '<', tbEquipmentReads);

            --QUE PASA SI LA NUEVA TABLA ES NULA
             nuIndexRead := tbEquipmentReads.first;

            -- Se obtiene cada registro de lectura
            while(nuIndexRead IS not null) Loop

                -- Se procesa la lectura para un equipo
                --OR_BOActivitiesLegalizeByFile.processReadData(tbEquipmentReads(nuIndexRead), nuIndexRead);
                DBMS_OUTPUT.PUT_LINE(tbEquipmentReads(nuIndexRead)||'//'|| nuIndexRead);

                nuIndexRead := tbEquipmentReads.next(nuIndexRead);
            END LOOP;
        END IF;

        ut_trace.trace('-- FIN OR_BOActivitiesLegalizeByFile.processReadByLine',3);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END processReadByLine;
0
0
