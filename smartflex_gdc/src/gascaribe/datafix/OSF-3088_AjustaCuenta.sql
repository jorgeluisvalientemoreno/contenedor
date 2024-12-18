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
DEFINE CASO=OSF-3088

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

declare 
    cursor cuenta is
    select cucocodi,cuconuse,cucofact,factfege,(select proccons||'-'||proccodi from procesos where proccons = factprog) factprog,
    (cucovato-cucovaab) cucosacu_calc,cucosacu,cucovato,cucovaab,cucovafa,cucovrap,
    (select sum(CASE WHEN cargsign IN ('CR', 'PA', 'AS', 'AD', 'RC', 'TS') THEN (NVL(cargvalo, 0))*-1 ELSE (NVL(cargvalo, 0)) END) from cargos b where b.cargcuco = cucocodi) saldocargos
    from cuencobr,factura
    where cucocodi in (3061016850)
    and factcodi = cucofact;
    
    s_out   varchar2(2000);
    
    procedure ajustaCuenta(inucuenta in cuencobr.cucocodi%type) is
        nuError NUMBER;
        sbError VARCHAR2(2000);
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

          pkg_traza.trace('cucocodi: ' || v_datos.CUENTA, PKG_TRAZA.CNUNIVELTRZDEF);

          pkg_traza.trace('Cuenta: ' || inucuenta || ' cucovato ' ||
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

          pkg_traza.trace('Despues updateCuenta: ' || v_datos.CUENTA || ' - ' ||
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

          pkg_traza.trace('Despues ajuste Cuenta: ' || v_datos.CUENTA || ' - ' ||
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
    dbms_output.put_line('Saldos Actual');
    dbms_output.put_line('Cuenta|Producto|Factura|Cucosacu|Cucovato|Cucovaab|Cucovafa|Cucovrap|SaldoCargos');
    for rc in cuenta loop
        s_out := rc.cucocodi;
        s_out := s_out||'|'||rc.cuconuse;
        s_out := s_out||'|'||rc.cucofact;
        s_out := s_out||'|'||rc.cucosacu;
        s_out := s_out||'|'||rc.cucovato;
        s_out := s_out||'|'||rc.cucovaab;
        s_out := s_out||'|'||rc.cucovrap;
        s_out := s_out||'|'||rc.saldocargos;
        dbms_output.put_line(s_out);
        ajustaCuenta(rc.cucocodi);
    end loop;
    
    dbms_output.put_line('Saldos Despues de Ajustar');
    dbms_output.put_line('Cuenta|Producto|Factura|Cucosacu|Cucovato|Cucovaab|Cucovafa|Cucovrap|SaldoCargos');
    for rc in cuenta loop
        s_out := rc.cucocodi;
        s_out := s_out||'|'||rc.cuconuse;
        s_out := s_out||'|'||rc.cucofact;
        s_out := s_out||'|'||rc.cucosacu;
        s_out := s_out||'|'||rc.cucovato;
        s_out := s_out||'|'||rc.cucovaab;
        s_out := s_out||'|'||rc.cucovrap;
        s_out := s_out||'|'||rc.saldocargos;
        dbms_output.put_line(s_out);
    end loop;
    
    commit;
    
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
