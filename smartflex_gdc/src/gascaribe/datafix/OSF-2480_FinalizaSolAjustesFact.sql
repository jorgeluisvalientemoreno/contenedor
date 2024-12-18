set serveroutput on size unlimited
set linesize 1000
set timing on
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25
DEFINE CASO=OSF2480

SELECT SYS_CONTEXT('USERENV', 'DB_NAME') instancia,
   TO_CHAR(SYSDATE, 'yyyymmdd_hh24miss') fecha_ejec,
   SYS_CONTEXT('USERENV','CURRENT_SCHEMA') esquema,
   USER ejecutado_por,
   SYS_CONTEXT('USERENV', 'OS_USER') usuario_so
FROM DUAL;

PROMPT
PROMPT =========================================
PROMPT  ****   Información de Ejecución    ****
PROMPT =========================================
PROMPT Instancia        : &instancia
PROMPT Fecha ejecución  : &fecha_ejec
PROMPT Usuario DB       : &ejecutado_por
PROMPT Usuario O.S      : &usuario_so
PROMPT Esquema          : &esquema
PROMPT CASO             : &CASO
PROMPT =========================================
PROMPT

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Marzo 2024 
JIRA:           OSF-2480

Descripción
Atiende solicitud de ajustes de facturación por MANOT con error 
Genera las financiaciones definidas, finaliza el flujo y cierra la solicitud
    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    14/03/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF2480';
    csbTitulo           constant varchar2(2000) := csbCaso||': Corrección solicitudes 289-Aprobacion de Ajustes de Facturación';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cnuSegundo          constant number         := 1/86400;
    cnuLimit            constant number         := 1000;
    cnuIdErr            constant number         := 1;
    cdtFecha            constant date           := sysdate;
    cnuPackage          constant number         :=  211119780;
    
    type tyTabla is table of varchar2( 2000 ) index by binary_integer;
    type tyrcArchivos is record
    (
        cabecera    varchar2(2000),
        nombre      varchar2(50),
        flgprint    varchar2(1),
        tblog       tyTabla
    );
    type tytbArchivos is table of tyrcArchivos index by binary_integer;
    tbArchivos          tytbArchivos;
    nuHash              number;
    nuOuts              number;     
    sbError             varchar2(2000);
    nuError             number;
    sbCabecera          varchar2(2000);
    sbComentario        varchar2(2000);
    nuContador          number;
    nuRowcount          number;
    raise_continuar     exception;
    s_out               varchar2(2000);
    
    
    cursor cudata is
    select c.rowid row_id,cargcuco,cargnuse,cargconc,cargsign,cargcaca,cargvalo,cargdoso,cargcodo,cargusua,cargfecr,cargvabl,cargprog,m.*,
    (select sesuserv from servsusc where sesunuse = cargnuse) sesuserv
    from cargos c,  ( select distinct * from ldc_mantenimiento_notas_dif a where a.package_id = cnuPackage ) m
    where cargcuco+0 = -1
    and cargnuse = m.product_id
    and cargconc = m.concepto_id
    and cargdoso = m.docsoporte;
    
    cursor cudife (inucta in number) is 
    select cargcuco,cargnuse,cargconc,cargsign,cargcaca,cargvalo,cargdoso,cargcodo,cargusua,cargfecr,cargvabl,m.*,
    difecodi,difecofi,difeconc,difevatd,difevacu,difesape,difenucu,difecupa,difetain,difepldi,difefein
    from cargos c,  ( select distinct * from ldc_mantenimiento_notas_dif a where a.package_id = cnuPackage ) m, diferido
    where 1 = 1
    and cargnuse = m.product_id
    and cargconc = m.concepto_id
    and cargdoso = m.docsoporte
    and cargcuco = inucta
    and difenuse = cargnuse
    and difeconc = cargconc 
    and difefein > trunc(sysdate)
    and difevatd = cargvalo;
    
    cursor cuInter is
    select wf_pack_interfac_id from mo_wf_pack_interfac 
    where package_id = cnuPackage and status_activity_id = 4;
    
    nuwf_pack_interfac_id    mo_wf_pack_interfac.wf_pack_interfac_id%type;
    
    -- obtiene el producto nuevo dmontes
    CURSOR cuDocument IS
    select distinct(product_id) product_id,DOCSOPORTE  from ldc_mantenimiento_notas_dif
    where package_id = cnuPackage;
    
    CURSOR cuConcIva (nuConcepto concepto.conccodi%type) is
    SELECT c.coblconc
      FROM concbali c
     WHERE c.coblcoba = nuConcepto
       AND c.coblcoba <> 137
       AND EXISTS (SELECT 1
              FROM concepto t
             WHERE t.conccodi = c.coblconc
               AND t.concticl = 4);
               
    
    rcDocument          cuDocument%rowtype;
    
    nunota              number;
    nucargos            number;
    nudiferidos         number;
    nuerr               number;
    
    sbDifeProg          CHAR(4) := 'FRNF';
    
    nuFactura           factura.factcodi%TYPE; -- Numero de factura
    nuContrato          NUMBER;
    grcSubscription     suscripc%ROWTYPE;
    nuCuentaCobro       cuencobr.cucocodi%TYPE;
    rcProduct           servsusc%ROWTYPE;
    nuNote              notas.notanume%TYPE;
    SBSIGNAPPLIED       cargos.cargsign%type;
    NUADJUSTAPPLIED     cargos.cargvalo%type;
    nuConcIva           number;
    nuMetodoCalculo     ld_parameter.numeric_value%TYPE; 
    nucuotas            number;
    nuplan              number;
    nuNroCuotas         NUMBER;
    nuSaldo             NUMBER;
    nuTotalAcumCapital  NUMBER;
    nuTotalAcumCuotExtr NUMBER;
    nuTotalAcumInteres  NUMBER;
    sbRequiereVisado    VARCHAR2(10);
    nuDifeCofi          NUMBER;
    nuvaloriva          NUMBER;
    nuPorIva            NUMBER;
    
    FUNCTION fnc_rs_CalculaTiempo
    (
        idtFechaIni IN DATE,
        idtFechaFin IN DATE
    )
    RETURN VARCHAR2
    IS
        nuTiempo NUMBER;
        nuHoras NUMBER;
        nuMinutos NUMBER;
        sbRetorno VARCHAR2( 100 );
    BEGIN
        -- Convierte los dias en segundos
        nuTiempo := ( idtFechaFin - idtFechaIni ) * 86400;
        -- Obtiene las horas
        nuHoras := TRUNC( nuTiempo / 3600 );
        -- Publica las horas
        sbRetorno := TO_CHAR( nuHoras ) ||'h ';
        -- Resta las horas para obtener los minutos
        nuTiempo := nuTiempo - ( nuHoras * 3600 );
        -- Obtiene los minutos
        nuMinutos := TRUNC( nuTiempo / 60 );
        -- Publica los minutos
        sbRetorno := sbRetorno ||TO_CHAR( nuMinutos ) ||'m ';
        -- Resta los minutos y obtiene los segundos redondeados a dos decimales
        nuTiempo := TRUNC( nuTiempo - ( nuMinutos * 60 ), 2 );
        -- Publica los segundos
        sbRetorno := sbRetorno ||TO_CHAR( nuTiempo ) ||'s';
        -- Retorna el tiempo
        RETURN( sbRetorno );
    EXCEPTION
        WHEN OTHERS THEN
            -- No se eleva excepcion, pues no es parte fundamental del proceso
            RETURN NULL;
    END fnc_rs_CalculaTiempo;
    
    PROCEDURE pInicializar IS
    BEGIN
        
        BEGIN
            --EXECUTE IMMEDIATE
            --'alter session set nls_date_format = "dd/mm/yyyy hh24:mi:ss"';
            
            EXECUTE IMMEDIATE 
            'alter session set nls_numeric_characters = ",."';
            
        END;

        dbms_output.enable;
        dbms_output.enable (buffer_size => null);
        
        pkerrors.setapplication(csbCaso);
        
        nucontador  := 0;
        nunota      := 0;
        nucargos    := 0;
        nudiferidos := 0;
        nuerr       := 0;
        
        tbArchivos.delete; 

        
        tbArchivos(1).nombre  := '--Log';
        tbArchivos(2).nombre  := '--Población';
        
        tbArchivos(1).flgprint  := 'S';
        tbArchivos(2).flgprint  := 'S';
       
        nuOuts := tbArchivos.last;
        
        sbCabecera := 'TipoError|Solicitud|Mensaje|Error'; 
        tbArchivos(cnuIdErr).cabecera := sbCabecera;
        
        sbCabecera := 'Cuenta|Producto|Concepto|Signo|Causa|Valor|Documento|CodFinancia|Diferido|Saldo|NumeroCuotas|PlanDiferido|TasaInteres';
        tbArchivos(2).cabecera := sbCabecera;
        
        dbms_output.put_line(csbTitulo);
        dbms_output.put_line('================================================');
        
        
    END pInicializar;
    
    Procedure pGuardaLog (ircArchivos  in out tyrcArchivos, sbMensaje  in varchar2) IS
        nuidxlog    binary_integer;
    Begin 
        
        if ircArchivos.tblog.last is null then
            nuidxlog := 1;
        else
            nuidxlog := ircArchivos.tblog.last + 1;
        end if;
                
        if ircArchivos.flgprint = 'S' then                
            ircArchivos.tblog(nuidxlog) := sbMensaje;                
        end if;
        
    exception
        when others then
            sbComentario := 'Error almacenamiento de log';
            raise raise_continuar;  
    END pGuardaLog;
    
    PROCEDURE pIniciaLog IS
    BEGIN
        for i in tbArchivos.first .. nuOuts loop
            if i >= cnuIdErr then
                pGuardaLog(tbArchivos(i),tbArchivos(i).cabecera);
            end if;
        end loop;        
    END pIniciaLog;
    
    PROCEDURE pCustomOutput(sbDatos in varchar2) is
        loop_count  number default 1;
        string_length number;    
    begin 
        string_length := length (sbDatos);
        
        while loop_count < string_length loop 
            dbms_output.put(substr (sbDatos,loop_count,255));
            --dbms_output.new_line;
            loop_count := loop_count +255;  
        end loop;
        dbms_output.new_line;
    exception
        when others then
        null;                  
    END pCustomOutput;
    
    Procedure pEsbribelog IS
    Begin        
        for i in reverse 1..nuOuts loop
            if tbArchivos(i).flgprint = 'S' then
                if tbArchivos(i).tblog.first is not null then
                    pCustomOutput(tbArchivos(i).nombre);
                    for j in tbArchivos(i).tblog.first..tbArchivos(i).tblog.last loop
                        pCustomOutput(tbArchivos(i).tblog(j));
                    end loop;
                end if;
            end if;           
        end loop;
    exception
        when others then
        dbms_output.put_line(sbComentario); 
    END pEsbribelog;
    
    PROCEDURE pCerrarLog IS
    BEGIN
        
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza gestión caso '||csbCaso);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de notas creadas: '||nunota);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de cargos creados: '||nucargos);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de diferidos creados: '||nudiferidos);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de errores: '||nuerr);  
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLog;
    
    PROCEDURE pCerrarLogE IS
    BEGIN
        -- Indica que termin� el proceso en el archivo de salida
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza gestión con Error ' ||csbCaso||': '||sqlerrm );
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de notas creadas: '||nunota);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de cargos creados: '||nucargos);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de diferidos creados: '||nudiferidos);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de errores: '||nuerr);  
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLogE;
    
    FUNCTION fnutraePIva
    (
        inuconcepto concepto.conccodi%TYPE, -- concepto
        inuserv     servsusc.sesuserv%TYPE -- porcentaje
    ) RETURN NUMBER IS
        nuporcentaje NUMBER := 0;
    BEGIN
        SELECT /*VITCCONS cons_tarifa, */
         nvl(ravtporc, 0) /*, cotcserv  servicio */
        INTO nuporcentaje
        FROM ta_tariconc a,
             ta_conftaco b,
             ta_vigetaco d,
             ta_rangvitc e
        WHERE b.cotcconc = inuconcepto -- inuConcepto
              AND a.tacocotc = b.cotccons
              AND d.vitctaco = a.tacocons
              AND D.VITCCONS = e.ravtvitc
              AND SYSDATE BETWEEN vitcfein AND vitcfefi
              AND ravtporc > 0
              AND cotcserv = inuserv;
        RETURN nuporcentaje;
    EXCEPTION
        WHEN no_data_found THEN
            nuporcentaje := 0;
            RETURN nuporcentaje;
    END;
    
    PROCEDURE pGestionCaso  IS
    BEGIN    
        rcDocument := null;
        open cuDocument;
        fetch cuDocument into rcDocument;
        close cuDocument;
        
        if rcDocument.product_id is null then
            --Ninguna solicitud para gestión
            sbComentario := 'Error 1.1|'||cnuPackage||'|Ninguna solicitud para gestión|NA';
            raise raise_continuar;
        end if;
        
        Pkg_Error.SetApplication(sbDifeProg);
        -- crear factura
        pkAccountStatusMgr.GetNewAccoStatusNum(nuFactura);
        
        nuContrato := dapr_product.fnugetsubscription_id(rcDocument.product_id);
        IF nuContrato IS NULL THEN
            sbComentario := 'Error 1.2|'||cnuPackage||'|No se encontró el contrato asociado al producto '||rcDocument.product_id||'|NA';
            raise raise_continuar;
        END IF;

        grcSubscription := pktblSuscripc.frcGetRecord(nuContrato);

        -- Crea una nueva FACTURA
        pkAccountStatusMgr.AddNewRecord(nuFactura, --
                                        pkGeneralServices.fnuIDProceso, --
                                        grcSubscription, --
                                        GE_BOconstants.fnuGetDocTypeCons);
                                        
        -- Obtiene el numero de la cuenta de cobro
        pkAccountMgr.GetNewAccountNum(nuCuentaCobro);
        
        -- Obtiene los datos del producto
        rcProduct := pktblservsusc.frcgetrecord(rcDocument.product_id);

        -- Crea una nueva cuenta de cobro
        pkAccountMgr.AddNewRecord(nuFactura, --
                                  nuCuentaCobro, --
                                  rcProduct);
                                  
        --Actualizo el numero de factura en la nota
        nuNote := to_number(substr(rcDocument.DocSoporte, 4, length(rcDocument.DocSoporte)));
        update notas
           set notafact = nuFactura
         where notafact =-1
         and notanume = nuNote;
         
        nuRowcount := sql%rowcount;
        
        if nuRowcount != 1 then
            sbComentario := 'Error 1.3|'||cnuPackage||'|No se realizó actualización de la factura a la nota: '||nuNote||' ['||nuRowcount||']'||'|NA';
            raise raise_continuar;
        end if;
        
        nunota := nunota + 1;
        
        nucuotas := null;
        nuplan := null;
        for rd in cudata loop
            begin 
                update cargos c
                set cargcuco = nuCuentaCobro
                where c.rowid = rd.row_id
                and cargnuse = rd.cargnuse
                and cargcuco = -1
                and cargdoso = rd.cargdoso
                and cargconc = rd.cargconc;
                
                nuRowcount := sql%rowcount;
                
                if nuRowcount != 1 then
                    sbComentario := 'Error 1.3|'||cnuPackage||'|Actualización de cuenta a conceptos diferentes a los esperados ['||nuRowcount||']'||'|NA';
                    raise raise_continuar;
                end if;
                
                nucargos := nucargos + 1;
                nuConcIva := null;
                open cuConcIva (rd.cargconc);
                fetch cuConcIva into nuConcIva;
                close cuConcIva;              
                
                nuValorIva := 0;
                nuPorIva := 0;
                if nuConcIva is not null then
                    nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => rd.sesuserv);
                    nuValorIva := round(rd.cargvalo * (nuPorIva / 100), 0);

                    
                    -- Crear Detalle Nota debito del IVA
                    FA_BOBillingNotes.DetailRegister(nuNote, --
                                                   rd.product_id, --
                                                   nuContrato, --
                                                   nuCuentaCobro, --
                                                   nuConcIva, --
                                                   rd.cargcaca, --
                                                   nuValorIva, --
                                                   nuValorIva, --
                                                   pkBillConst.csbTOKEN_NOTA_DEBITO ||
                                                   nuNote, --
                                                   pkBillConst.DEBITO, --
                                                   pkConstante.SI, --
                                                   NULL, --
                                                   pkConstante.SI);
                    nucargos := nucargos + 1;
                end if;     
                
                --Actualizamos la cartera del usario
                PKUPDACCORECEIV.UPDACCOREC(PKBILLCONST.CNUSUMA_CARGO,
                                           nuCuentaCobro,
                                           nuContrato,
                                           rd.cargnuse,
                                           rd.cargconc,
                                           rd.cargsign,
                                           rd.cargvalo + nuValorIva,
                                           PKBILLCONST.CNUUPDATE_DB);

                PKACCOUNTMGR.ADJUSTACCOUNT(nuCuentaCobro,
                                           rd.cargnuse,
                                           rd.cargcaca,
                                           rd.cargprog,
                                           PKBILLCONST.CNUUPDATE_DB,
                                           SBSIGNAPPLIED,
                                           NUADJUSTAPPLIED,
                                           PKBILLCONST.POST_FACTURACION);            
              
            exception
                when raise_continuar then
                    raise raise_continuar;
                when others then
                    pkg_error.geterror(nuerror,sberror);
                    sbComentario := 'Error 1.4|'||cnuPackage||'|Error en ajuste de cuenta '||nuCuentaCobro||' para el cargo '||rd.cargconc||'|'||sberror;
                    raise raise_continuar;
            end;
            
            nucuotas := rd.cuotas;
            nuplan  := rd.plan_dife;
        end loop;
        
        IF nucuotas IS NOT NULL AND nuplan IS NOT NULL THEN
            --Obtenemos el metodo de calculo para el plan de financiacion
            nuMetodoCalculo := pktblplandife.fnugetpldimccd(nuplan);

            begin
                -- Crea diferido si las cuotas y el plan son no nulos, si son nulos es porque se trae a presente mes
                ldc_validalegcertnuevas.financiarconceptosfactura(inunumprodsfinanc    => rcProduct.sesunuse,
                                                            inufactura           => nuFactura, --
                                                            inuplanid            => nuplan, --
                                                            inumetodo            => nuMetodoCalculo, --
                                                            inudifenucu          => nucuotas, --
                                                            isbdocusopo          => '-', --
                                                            isbdifeprog          => sbDifeProg, --
                                                            onuacumcuota         => nuNroCuotas, --
                                                            onusaldo             => nuSaldo, --
                                                            onutotalacumcapital  => nuTotalAcumCapital, --
                                                            onutotalacumcuotextr => nuTotalAcumCuotExtr, --
                                                            onutotalacuminteres  => nuTotalAcumInteres, --
                                                            osbrequierevisado    => sbRequiereVisado, --
                                                            onudifecofi          => nuDifeCofi);
                
                --MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU(cnuPackage,58);
                --elimina registro inconsistente MOPWP
                /*update mo_wf_pack_interfac 
                set status_activity_id = 3, causal_id_output = 1, executor_log_id = null, attendance_date = sysdate
                where package_id = cnuPackage and status_activity_id = 4;*/
                
            exception
                when others then
                    pkg_error.geterror(nuerror,sberror);
                    sbComentario := 'Error 1.6|'||cnuPackage||'|Error en registro de financiación para la factura '||nuFactura||'|'||sberror;
                    raise raise_continuar;
            end;
        END IF;
        
        commit;
        
        --diferidos 
        for rc in cudife(nuCuentaCobro) loop
            s_out := rc.cargcuco;
            s_out := s_out||'|'||rc.cargnuse;
            s_out := s_out||'|'||rc.cargconc;
            s_out := s_out||'|'||rc.cargsign;
            s_out := s_out||'|'||rc.cargcaca;
            s_out := s_out||'|'||rc.cargvalo;
            s_out := s_out||'|'||rc.cargdoso;
            s_out := s_out||'|'||rc.difecofi;
            s_out := s_out||'|'||rc.difecodi;
            s_out := s_out||'|'||rc.difesape;
            s_out := s_out||'|'||rc.difenucu;
            s_out := s_out||'|'||rc.difepldi;
            s_out := s_out||'|'||rc.difetain;
            
            nudiferidos := nudiferidos + 1;
            
            pGuardaLog(tbArchivos(2),s_out);
            
        end loop;
        
        delete from ldc_mantenimiento_notas_dif where package_id = cnuPackage;
        
        nuwf_pack_interfac_id :=null;
        open cuInter;
        fetch cuInter into nuwf_pack_interfac_id;
        close cuInter;
        
        MO_BSAttendActivities.ManualSendByPack(nuwf_pack_interfac_id,nuError,sbError);
        
        if nuError != 0 then
            sbComentario := 'Error 1.5|'||cnuPackage||'|Error en envio de actividad inconsistente|'||sberror;
            raise raise_continuar;
        end if;
        
        commit;
    
    EXCEPTION
        when raise_continuar then
            rollback;
            pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
            nuerr := nuerr + 1; 
            
    END pGestionCaso;
    
BEGIN

    pInicializar;
    pIniciaLog;
    pGestionCaso;
    pCerrarLog(); 
    
exception
    when others then
        pCerrarLogE();
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;

PROMPT **** FIN EJECUCIÓN ****
PROMPT CASO             : &CASO
PROMPT Fecha fin        : &fecha_fin
PROMPT =========================================

set timing off
set serveroutput off
quit
/
