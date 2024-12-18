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
DEFINE CASO=OSF-2525

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
FECHA:          Abril 2024
JIRA:           OSF-2525

Actualiza cargos liquidados sin facturación por cambio de ciclo antes del cierre

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    05/03/2024 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    cnuPefa     number := 110859;
    cnuPecs     number := 110798;
    cnuPefaAnt  number := 110866;
    
    cursor cudata is
    select 
    (
        select unique 
        first_value (pecscons) over (partition by pefacodi order by pecsfeaf desc) 
        from pericose,perifact
        where pecscico = pefacicl
        and pefacodi = cargpefa
        and pecsfecf < pefaffmo
    ) pecscons,
    (
        select unique 
        first_value (pecsfeci) over (partition by pefacodi order by pecsfeaf desc) 
        from pericose,perifact
        where pecscico = pefacicl
        and pefacodi = cargpefa
        and pecsfecf < pefaffmo
    ) pecsfeci,
    (
        select unique 
        first_value (pecsfecf) over (partition by pefacodi order by pecsfeaf desc) 
        from pericose,perifact
        where pecscico = pefacicl
        and pefacodi = cargpefa
        and pecsfecf < pefaffmo
    ) pecsfecf,
    (
        select felifeul from feullico 
        where  felisesu = cargnuse and feliconc = cargconc
    ) felifeul,
    decode(cargnuse,52378338,3058503646,-1) cuenta,
    c.*
    from cargos c
    where cargnuse in (52378338)
    and cargpefa = cnuPefa
    and cargconc in (31,196)
    and cargcuco = -1
    and cargprog = 5
    order by cargnuse
    ; 
    
    cursor cucuenta is 
    select * from cuencobr where cucocodi in (3058503646)
    ;
    
    nuRowcount          number;
    raise_continuar     exception;
    sbcomentario        varchar2(2000);
    nucontador          number;
    nuerr               number;
    nuok                number;
    nufe                number;
    nuco                number;
    nule                number;
    nucu                number;
    nuError             number;
    sbError             varchar2(2000);
    
    procedure ajustaCuenta(inucuenta in cuencobr.cucocodi%type) is

        
        nuIndex number;

        rcCargos       cargos%ROWTYPE := NULL;
        varcucovato    cuencobr.cucovato%type;
        varCUCOVAAB    cuencobr.cucovaab%type;
        varcucovafa    cuencobr.cucovafa%type;
        varcucoimfa    cuencobr.cucoimfa%type;
        inuConcSaFa    cargos.cargconc%type default NULL;
        inuSalFav      pkBCCuencobr.styCucosafa Default pkBillConst.CERO;
        isbTipoProceso cargos.cargtipr%type Default pkBillConst.POST_FACTURACION;
        idtFechaCargo  cargos.cargfecr%type Default sysdate;

        CURSOR cuDatos(inuCucocodi in cuencobr.cucocodi%type) IS
          SELECT cargos.cargcuco CUENTA,
                 cargos.cargnuse PRODUCTO,
                 NVL(SUM(DECODE(cargsign,
                                'DB',
                                (cargvalo),
                                'CR',
                                - (cargvalo),
                                0)),
                     0) cucovato,
                 NVL(SUM(DECODE(cargsign,
                                'PA',
                                cargvalo,
                                'AS',
                                cargvalo,
                                'SA',
                                -cargvalo,
                                0)),
                     0) cucovaab,
                 NVL(SUM(DECODE(cargtipr,
                                'P',
                                0,
                                DECODE(INSTR('DF-CX-',
                                             LPAD(SUBSTR(cargdoso, 1, 3), 3, ' ')),
                                       0,
                                       DECODE(cargsign,
                                              'DB',
                                              (cargvalo),
                                              'CR',
                                              - (cargvalo),
                                              0),
                                       0))),
                     0) cucovafa,
                 NVL(SUM(DECODE(cargtipr,
                                'P',
                                0,
                                DECODE(INSTR('DF-CX-',
                                             LPAD(SUBSTR(cargdoso, 1, 3), 3, ' ')),
                                       0,
                                       CASE
                                         WHEN concticl = pkBillConst.fnuObtTipoImp THEN
                                          DECODE(cargsign, 'DB', cargvalo, 'CR', -cargvalo, 0)
                                         ELSE
                                          0
                                       END,
                                       0))),
                     0) cucoimfa,
                 NVL(SUM(DECODE(SIGN(cargvalo), -1, 1, 0)), 0) cucocane
            FROM cargos, concepto
           WHERE cargcuco = inuCucocodi
             AND cargconc = conccodi
             AND cargsign IN ('DB', 'CR', -- Facturado
                  'PA', -- Pagos
                  'RD', 'RC', 'AD', 'AC', -- Reclamos
                  'AS', 'SA', 'ST', 'TS' -- Saldo favor
                 )
           GROUP BY cargos.cargcuco, cargos.cargnuse;

        v_datos cuDatos%rowtype;

    BEGIN

        pkerrors.setapplication(CC_BOConstants.csbCUSTOMERCARE);

        open cuDatos(inucuenta);
        fetch cuDatos
          into v_datos;
        close cuDatos;

        SELECT CUENCOBR.cucovato,
               CUENCOBR.CUCOVAAB,
               CUENCOBR.cucovafa,
               CUENCOBR.cucoimfa
          INTO varcucovato, varCUCOVAAB, varcucovafa, varcucoimfa
          FROM CUENCOBR
         WHERE CUCOCODI = v_datos.CUENTA;

        if (v_datos.cucovato != varcucovato OR v_datos.cucovaab != varCUCOVAAB OR
           v_datos.cucoimfa != varcucoimfa) then

          ut_trace.SetOutPut(ut_trace.cnuTRACE_OUTPUT_DB);
          ut_trace.SetLevel(2);

          ut_trace.trace('SDFGHKL Seguros cucocodi: ' || v_datos.CUENTA, 1);

          ut_trace.trace('Cuenta: ' || inucuenta || ' cucovato ' ||
                         v_datos.cucovato || '/' || varcucovato ||
                         ' - Cucovaab ' || v_datos.cucovaab || '/' ||
                         varCUCOVAAB,
                         2);

          UPDATE cuencobr
             SET cucovato = NVL(v_datos.cucovato, 0),
                 cucovaab = NVL(v_datos.cucovaab, 0),
                 cucovafa = NVL(v_datos.cucovafa, 0),
                 cucoimfa = NVL(v_datos.cucoimfa, 0)
           WHERE cucocodi = v_datos.CUENTA;

          ut_trace.trace('Despues updateCuenta: ' || v_datos.CUENTA || ' - ' ||
                         pktblcuencobr.fnugetcucovato(v_datos.CUENTA, 0) ||
                         ' - ' ||
                         pktblcuencobr.fnugetcucovaab(v_datos.CUENTA, 0),
                         2);

          pkAccountMgr.AdjustAccount(v_datos.CUENTA,
                                     v_datos.PRODUCTO,
                                     47,
                                     1,
                                     rcCargos.cargsign,
                                     rcCargos.cargvalo);

          ut_trace.trace('Despues ajuste Cuenta: ' || v_datos.CUENTA || ' - ' ||
                         pktblcuencobr.fnugetcucovato(v_datos.CUENTA, 0) ||
                         ' - ' ||
                         pktblcuencobr.fnugetcucovaab(v_datos.CUENTA, 0),
                         2);


        END if;

    EXCEPTION
        when pkg_error.CONTROLLED_ERROR then
            raise pkg_error.CONTROLLED_ERROR;
        when others then
            pkg_error.setError;
            raise pkg_error.CONTROLLED_ERROR;
    END ajustaCuenta;


begin
    dbms_output.put_line('OSF-2445: Actualización de cargo sin facturar');
    dbms_output.put_line('=============================================');
    dbms_output.put_line('Producto|Cuenta|Concepto|Mensaje|Error');
    begin
        nucontador := 0;
        nuerr := 0;
        nuok  := 0;
        nufe  := 0;
        nuco  := 0;
        nule  := 0;
        nucu  := 0;
        
        for rc in cudata loop
            update cargos
            set cargcuco = rc.cuenta,cargpeco = rc.pecscons
            where cargcuco = rc.cargcuco
            and cargconc = rc.cargconc
            and cargpefa = rc.cargpefa
            and cargnuse = rc.cargnuse;
            
            nuRowcount := sql%rowcount;
            if nuRowcount <= 0 or  nuRowcount != 1 then
                sbcomentario :=  rc.cargnuse||'|'||rc.cargcuco||'|'||rc.cargconc||'|No se realizó la actualización de cuenta para el cargo|NA';
                raise raise_continuar;
            else
                nuok := nuok + nuRowcount;
            end if;
            
            update feullico
            set felifeul = rc.pecsfecf
            where felisesu = rc.cargnuse
            and feliconc = rc.cargconc;
            
            nuRowcount := sql%rowcount;
            if nuRowcount <= 0 then
                sbcomentario :=  rc.cargnuse||'|'||rc.cargcuco||'|'||rc.cargconc||'|No se realizó la actualización de fecha para el concepto en feullico|NA';
                raise raise_continuar;
            else
                nufe := nufe + nuRowcount;
            end if;
            
            nucontador := nucontador + 1;
                
        end loop;
        
        if nucontador = 0  then
            sbcomentario  := '|||Sin cargos para actualizar|NA';
            raise raise_continuar;
        end  if;
        
        for rc in cucuenta loop 
            update conssesu 
            set cosspefa = cnuPefa, cosspecs = cnuPecs
            where cosssesu = rc.cuconuse and cosspefa = cnuPefaAnt;
            
            nuRowcount := sql%rowcount;
            if nuRowcount <= 0 then
                sbcomentario :=  rc.cuconuse||'|'||rc.cucocodi||'||No se realizó la actualización de periodos en conssesu|NA';
                raise raise_continuar;
            else
                nuco := nuco + nuRowcount;
            end if;
            
            update lectelme
            set leempefa = cnuPefa, leempecs = cnuPecs
            where leemsesu = rc.cuconuse and leempefa = cnuPefaAnt;
            
            nuRowcount := sql%rowcount;
            if nuRowcount <= 0 then
                sbcomentario :=  rc.cuconuse||'|'||rc.cucocodi||'||No se realizó la actualización de periodos en lectelme|NA';
                raise raise_continuar;
            else
                nule := nule + nuRowcount;
            end if;
            
          
            ajustaCuenta(rc.cucocodi);
            nucu := nucu + 1;
            commit;
        end loop;
        
    exception
        when raise_continuar then 
            rollback;
            nuerr := nuerr + 1;
            dbms_output.put_line(sbcomentario);
        when pkg_error.CONTROLLED_ERROR then
            pkg_error.getError(nuError,sbError);
            rollback;
            nuerr := nuerr + 1;
            sbcomentario := '|||Error en ajusta cuenta|'||sbError;
            dbms_output.put_line(sbcomentario);
    end;
    
    dbms_output.put_line('=============================================');
    dbms_output.put_line('Cantidad de cargos actualizados: '||nuok);
    dbms_output.put_line('Cantidad de feullicos actualizados: '||nufe);
    dbms_output.put_line('Cantidad de consumos actualizados: '||nuco);
    dbms_output.put_line('Cantidad de lecturas actualizadas: '||nule);
    dbms_output.put_line('Cantidad de cuentas actualizados: '||nucu);
    dbms_output.put_line('Cantidad de erroes encontrados: '||nuerr);
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
