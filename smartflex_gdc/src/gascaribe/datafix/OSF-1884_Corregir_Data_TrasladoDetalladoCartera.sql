column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    -- ciclo 9000
    CURSOR factura_ciclo9000  IS
        select DISTINCT(factcodi) as fcodigo, factura.rowid rw_fact, cuencobr.cucocodi ccodigo
        from open.cargos, open.cuencobr, open.factura where 
        cargcuco=cucocodi and factcodi=cucofact and factpefa =94781 and cargpefa=94781
        and trunc(cargfecr) > '01/07/2022' and cargprog=45 and cargtipr='P' order by 1 desc;
    
    CURSOR cuenta_ciclo9000 (inufactura cuencobr.cucofact%type) IS
        select DISTINCT(cucocodi) as Ccodigo, cuencobr.rowid rw_cuenta
        from open.cargos, open.cuencobr, open.factura where 
        cargcuco=cucocodi and factcodi=cucofact and cargpefa = 94781 and cucofact=inufactura
        and trunc(cargfecr) > '01/07/2022' and cargprog=45 and cargtipr='P' order by 1 desc;
    
    CURSOR cargos_ciclo9000 (inucarcuco cargos.cargcuco%type)IS
        select cargos.rowid rw_cargo
        ,perifact.pefacodi  PEFANEW
        , pericose.pecscons PECONEW
        from open.cargos, open.cuencobr, open.factura,open.perifact,open.pericose where 
        cargcuco=cucocodi and factcodi=cucofact and cargpefa =94781 and cargcuco=inucarcuco
        and trunc(cargfecr) > '01/07/2022' and cargprog=45 and cargtipr='P' 
        and pefafimo <= trunc(CARGFECR) and trunc(pefaffmo) >= trunc(CARGFECR)
        and pefacicl=9000 and pefacicl = pecscico and pecsfecf between pefafimo and pefaffmo
        order by 1 desc;
    
    -- ciclo 5602
    CURSOR factura_ciclo5602  IS
        select DISTINCT(factcodi) as fcodigo, factura.rowid rw_fact, cuencobr.cucocodi ccodigo
        from open.cargos, open.cuencobr, open.factura where 
        cargcuco=cucocodi and factcodi=cucofact and factpefa =100888 and cargpefa=100888
        and trunc(cargfecr) >= '01/07/2022' and cargprog=45  and cargtipr='P' order by 1 desc;
    
    CURSOR cuenta_ciclo5602 (inufactura cuencobr.cucofact%type) IS
        select DISTINCT(cucocodi) as Ccodigo, cuencobr.rowid rw_cuenta
        from open.cargos, open.cuencobr, open.factura where 
        cargcuco=cucocodi and factcodi=cucofact and cargpefa =100888 and cucofact=inufactura
        and trunc(cargfecr) > '01/07/2022' and cargprog=45 and cargtipr='P' order by 1 desc;

    CURSOR cargos_ciclo5602 (inucargcuco cargos.cargcuco%type) IS
        select cargos.rowid rw_cargo
        ,perifact.pefacodi  PEFANEW
        , pericose.pecscons PECONEW
        from open.cargos, open.cuencobr, open.factura,open.perifact,open.pericose where 
        cargcuco=cucocodi and factcodi=cucofact and cargpefa =100888 and cargcuco=inucargcuco
        and trunc(cargfecr) > '01/07/2022' and cargprog=45 and cargtipr='P' 
        and pefafimo <= trunc(CARGFECR) and trunc(pefaffmo) >= trunc(CARGFECR)
        and pefacicl=5602 and pefacicl = pecscico and pecsfecf between pefafimo and pefaffmo
        order by 1 desc;

    
    
    -- cursor datos del periodo a actualizar periodo y fecha
    
    CURSOR periodo_c (inuCargcuco cuencobr.cucocodi%TYPE,
                        inufactura factura.factcodi%type, 
                        inuciclo perifact.pefacicl%type) IS    
        select perifact.pefacodi newpefacodi ,  perifact.PEFAFEPA newPEFAFEPA ,
        min(CARGFECR) AS CARGFECR
        from open.perifact, open.cargos, open.cuencobr where cargcuco= inuCargcuco and 
        pefacicl=inuciclo and cucocodi=inuCargcuco and cucofact=inufactura
        and pefafimo <= trunc(CARGFECR) and trunc(pefaffmo) >= trunc(CARGFECR) 
        and rownum <2
        group by perifact.pefacodi,perifact.PEFAFEPA;
  
  

BEGIN

  DBMS_OUTPUT.PUT_LINE ('Inicia OSF-1884 Actualización de data Traslado detallado Cartera');
  
  DBMS_OUTPUT.PUT_LINE ('Inicia actualización de  ciclo 5602');
    FOR v_factura1 IN factura_ciclo5602 LOOP
	
        
            --periodo a cambiar la factura
            FOR v_periodo IN periodo_c (v_factura1.CCODIGO,v_factura1.FCODIGO,5602) LOOP
            BEGIN
                UPDATE FACTURA 
                SET factpefa = v_periodo.newpefacodi
                WHERE rowid = v_factura1.rw_fact and factcodi=v_factura1.fcodigo;
                DBMS_OUTPUT.PUT_LINE ('Actualización de  factura: '||v_factura1.fcodigo);
                EXCEPTION
                    WHEN OTHERS THEN
                        ut_trace.trace('TERMINO CON ERROR LA FACTURA: '||v_factura1.FCODIGO ||', sqlerrm'||sqlerrm);
                        dbms_output.put_line('TERMINO CON ERROR LA FACTURA: '||v_factura1.FCODIGO||', sqlerrm'||sqlerrm);
                        ROLLBACK;
            END;
                
                FOR rgCuCo in cuenta_ciclo5602(v_factura1.FCODIGO ) LOOP
                    
                        
                            BEGIN
                                UPDATE CUENCOBR 
                                SET cucofeve = v_periodo.newPEFAFEPA
                                WHERE rowid = rgCuCo.rw_cuenta and cucocodi=rgCuCo.ccodigo;
                                DBMS_OUTPUT.PUT_LINE ('Actualización de  cuenta de cobro: '||rgCuCo.ccodigo);

                                EXCEPTION    
                                WHEN OTHERS THEN
                                    ut_trace.trace('TERMINO CON ERROR LA CUENTA DE COBRO: '||rgCuCo.CCODIGO||', sqlerrm '||sqlerrm);
                                    dbms_output.put_line('TERMINO CON ERROR LA CUENTA DE COBRO: '||rgCuCo.CCODIGO ||', sqlerrm'||sqlerrm);
                                    RAISE; 
                            END;     
                                                    
                               FOR rgCarg IN cargos_ciclo5602( rgCuco.ccodigo ) LOOP
                                    BEGIN
                                        UPDATE CARGOS
                                        SET cargpefa=rgCarg.PEFANEW, cargpeco=rgCarg.PECONEW
                                        WHERE rowid= rgCarg.rw_cargo;
                                        DBMS_OUTPUT.PUT_LINE ('Actualización de  cargos rowid: '||rgCarg.rw_cargo);
                        
                                    EXCEPTION
                                        WHEN OTHERS THEN
                                            ut_trace.trace('TERMINO CON ERROR CARGO ROWID: '|| rgCarg.rw_cargo ||', sqlerrm'||sqlerrm);
                                            dbms_output.put_line('TERMINO CON ERROR CARGO ROWID: '|| rgCarg.rw_cargo ||', sqlerrm'||sqlerrm);
                                            RAISE;                
									END; 
                                END LOOP;                    
						
						
					
				END LOOP; 
				COMMIT;		
			END LOOP;
				
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE ('Inicia actualización de  ciclo 9000');
     FOR v_factura1 IN factura_ciclo9000 LOOP
	
        
            --periodo a cambiar la factura
            FOR v_periodo IN periodo_c (v_factura1.CCODIGO,v_factura1.FCODIGO,9000) LOOP
                BEGIN
                    UPDATE FACTURA 
                    SET factpefa = v_periodo.newpefacodi
                    WHERE rowid = v_factura1.rw_fact and factcodi=v_factura1.fcodigo;
                    DBMS_OUTPUT.PUT_LINE ('Actualización de  factura: '||v_factura1.fcodigo);
                    EXCEPTION
                        WHEN OTHERS THEN
                            ut_trace.trace('TERMINO CON ERROR LA FACTURA: '||v_factura1.FCODIGO ||', sqlerrm'||sqlerrm);
                            dbms_output.put_line('TERMINO CON ERROR LA FACTURA: '||v_factura1.FCODIGO||', sqlerrm'||sqlerrm);
                            ROLLBACK;
                END;
                
                FOR rgCuCo in cuenta_ciclo9000(v_factura1.FCODIGO ) LOOP
                           BEGIN
                                UPDATE CUENCOBR 
                                SET cucofeve = v_periodo.newPEFAFEPA
                                WHERE rowid = rgCuCo.rw_cuenta and cucocodi=rgCuCo.ccodigo;
                                DBMS_OUTPUT.PUT_LINE ('Actualización de  cuenta de cobro: '||rgCuCo.ccodigo);
                                EXCEPTION    
                                WHEN OTHERS THEN
                                    ut_trace.trace('TERMINO CON ERROR LA CUENTA DE COBRO: '||rgCuCo.CCODIGO||', sqlerrm '||sqlerrm);
                                    dbms_output.put_line('TERMINO CON ERROR LA CUENTA DE COBRO: '||rgCuCo.CCODIGO ||', sqlerrm'||sqlerrm);
                                    RAISE; 
                            END;     
                            
                               FOR rgCarg IN cargos_ciclo9000( rgCuco.ccodigo ) LOOP
                                    BEGIN
                                        UPDATE CARGOS
                                        SET cargpefa=rgCarg.PEFANEW, cargpeco=rgCarg.PECONEW
                                        WHERE rowid= rgCarg.rw_cargo;
                                        DBMS_OUTPUT.PUT_LINE ('Actualización de  cargos rowid: '||rgCarg.rw_cargo);
                        
                                    EXCEPTION
                                        WHEN OTHERS THEN
                                            ut_trace.trace('TERMINO CON ERROR CARGO ROWID: '|| rgCarg.rw_cargo ||', sqlerrm'||sqlerrm);
                                            dbms_output.put_line('TERMINO CON ERROR CARGO ROWID: '|| rgCarg.rw_cargo ||', sqlerrm'||sqlerrm);
                                            RAISE;                
									END; 
                                END LOOP;                    
						
						
					
				END LOOP; 
				COMMIT;		
			END LOOP;
				
    END LOOP;
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/