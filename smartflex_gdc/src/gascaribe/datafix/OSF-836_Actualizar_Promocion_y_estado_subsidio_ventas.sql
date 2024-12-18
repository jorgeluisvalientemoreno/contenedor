column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
DECLARE

    sbCaso  VARCHAR2(20) := 'OSF-836';
    
    PROCEDURE pActualizaSubsidio
    IS              

        nuEstadoPc     LD_SUBSIDY_STATES.SUBSIDY_STATES_ID%TYPE := 2; -- por cobrar

    CURSOR cuSuscripc
    IS
    SELECT susccodi
      FROM suscripc s
     WHERE susccodi in (67334745);

    BEGIN

    FOR rgSus IN cuSuscripc LOOP

      BEGIN

        dbms_output.put_line( 'Actualizamos estado de subsidio [' || nuEstadoPc  || '] Contrato[' || rgSus.susccodi || ']'  ); 

        update open.ld_asig_subsidy l
           set l.state_subsidy = nuEstadoPc
         where susccodi = rgSus.susccodi;

        COMMIT;

        dbms_output.put_line( 'Se actualizo el estado de subsidio del contrato [' || rgSus.susccodi ); 

        EXCEPTION 
          WHEN OTHERS THEN
                        dbms_output.put_line( 'ERROR actualizando el estado de subsidio del contrato[' || rgSus.susccodi); 
            ROLLBACK;      
      END;

    END LOOP;    

    END pActualizaSubsidio;
    /*
    */
    PROCEDURE pRegistraPromocion
    IS              

        nuTipoPromocion     Mo_Mot_promotion.Mot_promotion_Id%TYPE := 387;

    CURSOR cuSolicitud
    IS
    SELECT mo.package_id, mo.motive_id, pk.request_date
    FROM   mo_packages  pk,
           mo_motive   mo
    WHERE  pk.package_id in (192816452,192805212)
           AND mo.package_id = pk.package_id
           AND NOT EXISTS
           (
              SELECT '1'
              FROM MO_MOT_PROMOTION pm
              WHERE pm.motive_id = mo.motive_id
              AND pm.promotion_id = nuTipoPromocion
           );

    rcMot_promotion  DAMO_MOT_PROMOTION.styMo_Mot_ProMotion;

    BEGIN

    FOR rgSol IN cuSolicitud LOOP

      BEGIN

        dbms_output.put_line( 'NO EXISTE PROMOCION TIPO [' || nuTipoPromocion  || ']Solicitud[' || rgSol.package_id || ']'  ); 

                rcMot_promotion.Mot_promotion_Id     := SEQ_MO_MOT_PROMOTIO_182911.NextVal;
                rcMot_promotion.Promotion_id         := nuTipoPromocion;
                rcMot_promotion.Motive_Id            := rgSol.Motive_Id;
                rcMot_promotion.Register_Date        := rgSol.Request_Date;
                rcMot_promotion.Active               := 'Y'; 

                DAMO_MOT_PROMOTION.insRecord ( rcMot_promotion );

        COMMIT;

        dbms_output.put_line( 'SE INSERTO PROMOCION [' || rcMot_promotion.Mot_promotion_Id  || ']Solicitud[' || rgSol.package_id || ']'  ); 

        EXCEPTION 
          WHEN OTHERS THEN
                        dbms_output.put_line( 'ERROR INSERTANDO PROMOCION Solicitud[' || rgSol.package_id || '][' || SQLERRM || ']'  ); 
            ROLLBACK;      
      END;

    END LOOP;    

    END pRegistraPromocion;

begin

  pRegistraPromocion;
  pActualizaSubsidio;

end;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/