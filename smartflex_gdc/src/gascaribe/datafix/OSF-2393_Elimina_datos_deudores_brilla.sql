column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    /*
        OSF-2393_Elimina_datos_deudores_brilla

        Se solicita por favor la eliminación de registros de deudores que fueron
        victimas de fraude, por lo tanto, hay que eliminar su datos del sistema
        para evitar reportes a centrales de riesgo.

        GDGuevara - GlobalMVM - 23/feb/2024
    */

    -- Cursor con la poblacion de solicitudes a marcar como NO FACTURABLE
    CURSOR cuLD_Promissory is
        SELECT LD_PROMISSORY.*, LD_PROMISSORY.rowid
        FROM open.ld_promissory
        WHERE  (identification = '22448900'   and package_id = 181886502)
            OR (identification = '22848746'   and package_id = 190213145)
            OR (identification = '22527654'   and package_id = 184555622)
            OR (identification = '39055616'   and package_id = 108970242)
            OR (identification = '92503154'   and package_id = 159274468)
            OR (identification = '8749223'    and package_id = 192517110)
            OR (identification = '22443789'   and package_id = 192402266)
            OR (identification = '36530795'   and package_id = 192379414)
            OR (identification = '8730979'    and package_id = 193169368)
            OR (identification = '72140411'   and package_id = 110684561)
            OR (identification = '32796089'   and package_id = 140746736)
            OR (identification = '22446472'   and package_id = 93054616)
            OR (identification = '1082943176' and package_id = 197899625)
            OR (identification = '12541742'   and package_id = 145077615)
            OR (identification = '22691949'   and package_id = 180459931)
            OR (identification = '19602298'   and package_id = 159614255);

    nuCont          NUMBER;
    nuTotal         NUMBER;
    rcLdPromNul     DALD_PROMISSORY.styLD_PROMISSORY;
    rcLdPromFin     DALD_PROMISSORY.styLD_PROMISSORY;

BEGIN
    nuCont   := 0;
    nuTotal  := 0;

    -- Inicia el registro con los datos a guardar por default
    rcLdPromNul := NULL;
    rcLdPromNul.holder_bill	     := 'Y';
    rcLdPromNul.debtorname       := 'BORRADO POR CASO OSF-2393';
    rcLdPromNul.identification	 := -1;
    rcLdPromNul.ident_type_id	 := 1;
    rcLdPromNul.forwardingplace  := -1;
    rcLdPromNul.forwardingdate	 := to_date ('02/01/1900','dd/mm/yyyy');
    rcLdPromNul.gender	         := 'M';
    rcLdPromNul.civil_state_id	 := -1;
    rcLdPromNul.birthdaydate	 := to_date ('02/01/1900','dd/mm/yyyy');
    rcLdPromNul.address_id	     := 1;
    rcLdPromNul.dependentsnumber := 0;

    -- Recorre los registros a actualizar
    FOR rcLD IN cuLD_Promissory LOOP
        BEGIN

            nuTotal := nuTotal + 1;
 
            -- Inicia en null el registro
            rcLdPromFin := rcLdPromNul;

            -- Actualiza con los datos que se convervan
            rcLdPromFin.promissory_id := rcLD.promissory_id;
            rcLdPromFin.rowid         := rcLD.rowid;

            -- Actualiza el registro
            DALD_PROMISSORY.updRecord (rcLdPromFin);

            commit;
            DBMS_OUTPUT.PUT_LINE(' Actualizado OK promissory_id: ' || rcLD.promissory_id);
            nuCont := nuCont + 1;

        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR: no pudo actualizar promissory_id' || rcLD.promissory_id || ' SQLERRM: '||SQLERRM);
                ROLLBACK;
        END;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(chr(10)||'Proceso termina OK. Registros seleccionados: '||nuTotal||', Registros Actualizados: ' || nuCont);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: no pudo actualizar LD_PROMISSORY. ' ||SQLERRM);
        ROLLBACK;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/