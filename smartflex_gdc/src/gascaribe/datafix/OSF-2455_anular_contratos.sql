column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
/*
    OSF-2455: Se solicita la anulación de los motivos de solicitud, de ordenes de trabajo (Anuladas), 
              retiro de productos (16-Retirado sin instalación), cambio de estado de corte (110-Retirado sin instalación), 
              retiro de componentes de producto (18-Retirado sin instalación), actualización fecha de retiro, 
              de los 179 contratos y productos anexos que pertenecen a diferentes solicitudes de venta que según 
              memorando 23-006260 instalaciones realizo la visita y les notifico a los usuarios el proceso que 
              se va a seguir ya que no se van a construir. Esto no se puede anular por la herramienta porque 
              son ventas fuera del módulo de constructoras 
    Autor:    German Dario Guevara Alzate - GlobaMVM
    Fecha:    11/03/2024
*/
    -- Informacion general
    sbComment       CONSTANT VARCHAR2(200) := 'SE ANULA ORDEN CON EL CASO OSF-2455';
    nuCommentType   CONSTANT NUMBER        := 1277;
    
    -- Tipo de dato de tabla PL, donde el indice es el contrato y el valor es la solicitud
    TYPE tytbSusc IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    tbSusc      tytbSusc;    

    -- Cursor para traer las ordenes del contrato dado
    CURSOR cuOrderActiv 
    (
        inuSusc     NUMBER, 
        inuPackage  NUMBER
    )
    IS
        select oa.product_id       PRODUCTO,
               oa.order_id         ORDEN,
               gc.class_causal_id  CLASS_CAUSAL
        from open.or_order_activity oa
            inner join open.or_order o   ON o.order_id  = oa.order_id
                                        AND o.order_status_id not in (8,12)
            left  join open.ge_causal gc ON o.causal_id = gc.causal_id
        where oa.package_id = inuPackage
          and oa.motive_id in (select motive_id
                               from open.mo_motive mo
                               where mo.package_id = oa.package_id
                                 and mo.subscription_id = inuSusc);

    -- Cursor de Person ID para el comentario
    CURSOR cuLoadData IS
        select person_id
        from ge_person
        where person_id = 13549; -- Pablo

    rcOR_ORDER_COMMENT  open.daor_order_comment.styor_order_comment;
    nuPersonID          open.ge_person.person_id%type;
    nuErrorCode         NUMBER;
    nuSusc              NUMBER;
    nuCont              NUMBER;
    nuTotal             NUMBER;
    nuTotOrd            NUMBER;
    nuPackage           NUMBER;
    sbErrorMessage      VARCHAR2(4000);
    exError             EXCEPTION;

BEGIN
    nuCont   := 0;
    nuTotal  := 0;
    nuTotOrd := 0;
    tbSusc.DELETE;
    
    -- Carga la data del Excel "Anular ventas constructora Memorando 23-006260.xlsx"
    -- tbSusc(SUSCCODI) := PACKAGE_ID
    tbSusc(66296084) := 12005320;
    tbSusc(66296086) := 12005320;
    tbSusc(66296117) := 12005320;
    tbSusc(66296120) := 12005320;
    tbSusc(66296208) := 13023782;
    tbSusc(66307044) := 15248907;
    tbSusc(66320966) := 18011068;
    tbSusc(66348065) := 27680746;
    tbSusc(66348066) := 27680746;
    tbSusc(66348067) := 27680746;
    tbSusc(66348068) := 27680746;
    tbSusc(66348069) := 27680746;
    tbSusc(66348070) := 27680746;
    tbSusc(66348071) := 27680746;
    tbSusc(66348072) := 27680746;
    tbSusc(66348073) := 27680746;
    tbSusc(66348074) := 27680746;
    tbSusc(66348075) := 27680746;
    tbSusc(66348076) := 27680746;
    tbSusc(66348077) := 27680746;
    tbSusc(66348078) := 27680746;
    tbSusc(66348079) := 27680746;
    tbSusc(66348080) := 27680746;
    tbSusc(66348081) := 27680746;
    tbSusc(66348082) := 27680746;
    tbSusc(66348083) := 27680746;
    tbSusc(66348084) := 27680746;
    tbSusc(66348085) := 27680746;
    tbSusc(66348086) := 27680746;
    tbSusc(66348087) := 27680746;
    tbSusc(66348088) := 27680746;
    tbSusc(66348089) := 27680746;
    tbSusc(66348090) := 27680746;
    tbSusc(66348091) := 27680746;
    tbSusc(66348092) := 27680746;
    tbSusc(66348093) := 27680746;
    tbSusc(66348094) := 27680746;
    tbSusc(66348095) := 27680746;
    tbSusc(66348096) := 27680746;
    tbSusc(66348097) := 27680746;
    tbSusc(66348098) := 27680746;
    tbSusc(66348099) := 27680746;
    tbSusc(66348100) := 27680746;
    tbSusc(66348101) := 27680746;
    tbSusc(66348102) := 27680746;
    tbSusc(66348103) := 27680746;
    tbSusc(66365601) := 24936007;
    tbSusc(66365606) := 24936007;
    tbSusc(66383352) := 30463541;
    tbSusc(66383385) := 30463541;
    tbSusc(66399828) := 10745151;
    tbSusc(66399829) := 10745151;
    tbSusc(66399830) := 10745151;
    tbSusc(66399831) := 10745151;
    tbSusc(66399832) := 10745151;
    tbSusc(66399833) := 10745151;
    tbSusc(66399834) := 10745151;
    tbSusc(66399835) := 10745151;
    tbSusc(66399836) := 10745151;
    tbSusc(66399837) := 10745151;
    tbSusc(66399838) := 10745151;
    tbSusc(66399839) := 10745151;
    tbSusc(66399840) := 10745151;
    tbSusc(66399841) := 10745151;
    tbSusc(66399842) := 10745151;
    tbSusc(66399843) := 10745151;
    tbSusc(66399844) := 10745151;
    tbSusc(66399845) := 10745151;
    tbSusc(66399846) := 10745151;
    tbSusc(66399847) := 10745151;
    tbSusc(66399848) := 10745151;
    tbSusc(66399849) := 10745151;
    tbSusc(66399850) := 10745151;
    tbSusc(66399851) := 10745151;
    tbSusc(66399852) := 10745151;
    tbSusc(66399853) := 10745151;
    tbSusc(66399854) := 10745151;
    tbSusc(66399855) := 10745151;
    tbSusc(66399856) := 10745151;
    tbSusc(66399857) := 10745151;
    tbSusc(66399858) := 10745151;
    tbSusc(66399859) := 10745151;
    tbSusc(66399860) := 10745151;
    tbSusc(66399861) := 10745151;
    tbSusc(66402363) := 10745151;
    tbSusc(66434122) := 37320421;
    tbSusc(66440361) := 38573930;
    tbSusc(66479921) := 46916361;
    tbSusc(66479922) := 46916361;
    tbSusc(66479923) := 46916361;
    tbSusc(66485732) := 30676574;
    tbSusc(66491097) := 47928816;
    tbSusc(66530900) := 57028649;
    tbSusc(66537970) := 58375701;
    tbSusc(66538021) := 58375701;
    tbSusc(66554989) := 59510628;
    tbSusc(66568578) := 60467550;
    tbSusc(66572695) := 60830681;
    tbSusc(66573164) := 61250330;
    tbSusc(66576654) := 61627351;
    tbSusc(66595554) := 66595554;
    tbSusc(66605269) := 63965701;
    tbSusc(66605270) := 63965701;
    tbSusc(66605304) := 64004718;
    tbSusc(66605310) := 64004718;
    tbSusc(66605311) := 64004718;
    tbSusc(66605312) := 64004718;
    tbSusc(66605313) := 64004718;
    tbSusc(66631078) := 66109081;
    tbSusc(66641419) := 68008050;
    tbSusc(66662703) := 69128445;
    tbSusc(66686286) := 70522135;
    tbSusc(66716718) := 72611767;
    tbSusc(66723070) := 73855498;
    tbSusc(66733998) := 76282494;
    tbSusc(66746430) := 78672099;
    tbSusc(66764319) := 82764096;
    tbSusc(66764320) := 82764096;
    tbSusc(66764321) := 82764096;
    tbSusc(66764322) := 82764096;
    tbSusc(66764323) := 82764096;
    tbSusc(66764324) := 82764096;
    tbSusc(66764325) := 82764096;
    tbSusc(66764326) := 82764096;
    tbSusc(66764327) := 82764096;
    tbSusc(66764328) := 82764096;
    tbSusc(66764329) := 82764096;
    tbSusc(66764330) := 82764096;
    tbSusc(66764331) := 82764096;
    tbSusc(66764332) := 82764096;
    tbSusc(66764333) := 82764096;
    tbSusc(66764334) := 82764096;
    tbSusc(66764335) := 82764096;
    tbSusc(66764336) := 82764096;
    tbSusc(66764337) := 82764096;
    tbSusc(66764338) := 82764096;
    tbSusc(66786802) := 88376077;
    tbSusc(66802288) := 92099120;
    tbSusc(66818537) := 96984138;
    tbSusc(66818542) := 96984138;
    tbSusc(66818543) := 96984138;
    tbSusc(66818545) := 96984138;
    tbSusc(66818547) := 96984138;
    tbSusc(66820513) := 96983898;
    tbSusc(66820523) := 96983898;
    tbSusc(66820524) := 96983898;
    tbSusc(66820527) := 96983898;
    tbSusc(66828354) := 100073097;
    tbSusc(66828357) := 100073097;
    tbSusc(66851969) := 106083859;
    tbSusc(66874332) := 110190124;
    tbSusc(66880241) := 112644000;
    tbSusc(66880292) := 112644150;
    tbSusc(66880301) := 112644180;
    tbSusc(66880304) := 112644187;
    tbSusc(66921430) := 120482550;
    tbSusc(66921431) := 120482550;
    tbSusc(66921432) := 120482550;
    tbSusc(66921433) := 120482550;
    tbSusc(66921434) := 120482550;
    tbSusc(66921435) := 120482550;
    tbSusc(66921436) := 120482550;
    tbSusc(66921437) := 120482550;
    tbSusc(66921438) := 120482550;
    tbSusc(66921439) := 120482550;
    tbSusc(66921441) := 120482550;
    tbSusc(66921442) := 120482550;
    tbSusc(66921444) := 120482550;
    tbSusc(66921445) := 120482550;
    tbSusc(66921446) := 120482550;
    tbSusc(66921448) := 120482550;
    tbSusc(66921449) := 120482550;
    tbSusc(66921450) := 120482550;
    tbSusc(66921453) := 120482550;
    tbSusc(66921454) := 120482550;
    tbSusc(66921455) := 120482550;
    tbSusc(66921456) := 120482550;
    tbSusc(66933659) := 120919964;
    tbSusc(67030097) := 124925160;

    -- Carga de Person ID para el comentario
    open cuLoadData;
    fetch cuLoadData into nuPersonID;
    close cuLoadData;

    -- sino existe la persona pone la default de OPEN
    IF nuPersonID is null THEN
        nuPersonID := ge_bopersonal.fnugetpersonid;
    END IF;

    dbms_output.put_line('Inicia Proceso OSF-2455_Anular_Productos_Constructora');
    dbms_output.put_line('---------------------------------------------------------------------------------');
    dbms_output.put_line('Codigo Tipo Comentario[' || nuCommentType || ']');
    dbms_output.put_line('Mensaje del Comentario[' || sbComment || ']'); 
    dbms_output.put_line('Person ID             [' || nuPersonID || ']');
    dbms_output.put_line('Fecha sistema         [' || open.pkgeneralservices.fdtgetsystemdate || ']');

    -- Total de registros de la coleccion
    nuTotal := tbSusc.COUNT;

    -- Primer registro
    nuSusc  := tbSusc.FIRST;
    
    -- Recorre la coleccion
    LOOP
        EXIT WHEN nuSusc IS NULL;
        nuPackage := tbSusc(nuSusc);
        --Recorrer ordenes de venta de cada contrato x solicitud
        FOR rcOrderActiv in cuOrderActiv (nuSusc, nuPackage) LOOP
            nuTotOrd := nuTotOrd + 1;
            BEGIN
                dbms_output.put_line(chr(10)||'ANULA ORDEN: ['||rcOrderActiv.ORDEN||'] CONTRATO: ['||nuSusc||']');
                
                -- Si la Orden no esta legalizada con causal de exito, anula
                IF NVL(rcOrderActiv.CLASS_CAUSAL, 0) = 1 THEN
                    dbms_output.put_line('Contrato: '||nuSusc||', con Orden: '|| rcOrderActiv.ORDEN ||' Esta legalizada con Exito y No se puede Anular');
                    RAISE exError;
                END IF;

                -- Se reemplaza por el nuevo API para anular ordenes - GDGA 20/02/2024
                api_anullorder
                (
                    rcOrderActiv.ORDEN,
                    null,
                    null,
                    nuErrorCode,
                    sbErrorMessage
                );
                IF (nuErrorCode <> 0) THEN
                    dbms_output.put_line('Error en api_anullorder, Contrato: '||nuSusc||', con Orden: '|| rcOrderActiv.ORDEN ||', '|| sbErrorMessage);
                    RAISE exError;
                END IF;

                -- Arma el registro con el comentario
                rcOR_ORDER_COMMENT.ORDER_COMMENT_ID := seq_or_order_comment.nextval;
                rcOR_ORDER_COMMENT.ORDER_COMMENT    := sbComment;
                rcOR_ORDER_COMMENT.ORDER_ID         := rcOrderActiv.ORDEN;
                rcOR_ORDER_COMMENT.COMMENT_TYPE_ID  := nuCommentType;
                rcOR_ORDER_COMMENT.REGISTER_DATE    := open.pkgeneralservices.fdtgetsystemdate;
                rcOR_ORDER_COMMENT.LEGALIZE_COMMENT := 'N';
                rcOR_ORDER_COMMENT.PERSON_ID        := nuPersonID;

                -- Inserta el registro en or_order_comment
                daor_order_comment.insrecord(rcOR_ORDER_COMMENT);

                -- Cambia el estado de la orden a Finalizada
                update open.or_order_activity
                  set status     = 'F',
                      final_date = sysdate
                where order_id = rcOrderActiv.ORDEN;

                -- Se actualiza la fecha de retiro en el producto y componente - GDGA 15/02/2024
                update open.pr_product
                  set product_status_id = 16,  -- Retirado sin instalacion
                      suspen_ord_act_id = null,
                      retire_date       = sysdate
                where product_id = rcOrderActiv.PRODUCTO;

                -- Estado de corte
                update open.servsusc s
                  set s.sesuesco = 110,         -- Retirado sin Instalacion
                      s.sesufere = sysdate
                where sesunuse = rcOrderActiv.PRODUCTO;

                -- componente del producto
                update open.pr_component
                  set component_status_id = 18, -- Retirado sin instalacion
                      last_upd_date       = sysdate
                where product_id = rcOrderActiv.PRODUCTO;

                update open.compsesu
                  set cmssescm = 18,            -- Retirado sin instalacion
                      cmssfere = sysdate
                where cmsssesu = rcOrderActiv.PRODUCTO;

                -- Cambia estado del motivo
                update open.mo_motive m
                  set m.motive_status_id   = 5,
                      m.status_change_date = sysdate,
                      m.annul_date         = sysdate
                where m.package_id = nuPackage
                  and m.product_id in rcOrderActiv.PRODUCTO;

                -- Componentes del motivo
                update mo_component m
                  set m.motive_status_id   = 26,
                      m.status_change_date = sysdate,
                      m.annul_date         = sysdate
                where m.package_id = nuPackage
                  and m.product_id = rcOrderActiv.PRODUCTO;

                nuCont := nuCont + 1;

                -- Asienta la transaccion
                commit;

            EXCEPTION
                WHEN exError THEN
                    rollback;
                WHEN OTHERS THEN
                    rollback;
                    dbms_output.put_line('Error: Contrato '||nuSusc||', con Orden: '|| rcOrderActiv.ORDEN ||', no se pudo Anular. SQLERRM: '|| SQLERRM );
            END;       

        END LOOP;
        -- Siguiente registro
        nuSusc := tbSusc.NEXT(nuSusc);
    END LOOP;    

    tbSusc.DELETE;
    dbms_output.put_line('---------------------------------------------------------------------------------');
    dbms_output.put_line('Fin del Proceso. Total Contratos: '||nuTotal||', Ordenes Selecc.: '||nuTotOrd||', Ordenes Anuladas: '||nuCont);
    
EXCEPTION
    WHEN OTHERS THEN
        rollback;
        dbms_output.put_line('Error del proceso. Total Contratos: '||nuTotal||', Ordenes Selecc.: '||nuTotOrd||', Ordenes Anuladas: '||nuCont ||', '||SQLERRM );
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/