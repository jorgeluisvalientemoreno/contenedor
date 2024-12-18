column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  Declare

  Cursor cudatos is
    SELECT  c.rowid, c.*
    FROM    open.cargos c, open.servsusc, open.cuencobr, open.factura, open.concepto
    WHERE   (
              factfege >= to_Date('10/09/2024 00:00:00', 'dd/mm/yyyy hh24:mi:ss')  AND 
              factfege <= to_Date('10/09/2024 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
            OR
              factfege >= to_Date('10/09/2024 00:00:00', 'dd/mm/yyyy hh24:mi:ss')  AND 
              factfege <= to_Date('10/09/2024 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
            )            
            AND cucofact =  factcodi
            AND cucocodi =  cargcuco
            AND sesunuse =  cargnuse
            AND cargfecr <= to_Date('10/09/2024 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
            AND cargcuco >  0
            AND cargtipr =  'A'
            AND cargsign in ('DB','CR')
            and cargconc = conccodi
            and cargpeco is not null
            and cargconc not in -- (31,32,33,34,35,36,37,196,130,167,931,935,142)
                                (
                                  31,	  --CONSUMO
                                  32,	  --CONSUMO  GLP
                                  33,	  --CONSUMO NO FACTURADO
                                  34,	  --CONSUMO SUBSISTENCIA A DIFERIR
                                  35,	  --CONTR. SOBRECOSTO CREG-NO REG.
                                  36,	  --CONTR. SOBRECOSTO RES-CREG 136
                                  37,	  --CONTRIBUCION
                                  130,	--CONSUMO - RESCREG048
                                  142,	--CONTRIBUCION - RESCREG048
                                  167,	--SUBSIDIO - RESCREG048
                                  196,	--SUBSIDIO
                                  931,	--SUBSIDIO RES.40236 MINMINAS
                                  935 	--SUBSIDIO ADICIONAL RES.40236
                                );
            
      nucontareg      NUMBER(15) DEFAULT 0;
      nucantiregcom   NUMBER(15) DEFAULT 0;
      nucantiregtot   NUMBER(15) DEFAULT 0;

  Begin
    
    nucontareg := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');
    
    For reg in cudatos loop
      
        update open.cargos c
          set cargpeco = null
        where c.rowid = reg.rowid;
        
        nucantiregcom := nucantiregcom + 1;
        IF nucantiregcom >= nucontareg THEN
          COMMIT;
          nucantiregtot := nucantiregtot + nucantiregcom;
          nucantiregcom := 0;
        END IF;
    
    End loop;
    --
    commit;
    --
    dbms_output.put_Line('Registros Actualizados : ' || nucantiregtot);
    --
  End;
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/