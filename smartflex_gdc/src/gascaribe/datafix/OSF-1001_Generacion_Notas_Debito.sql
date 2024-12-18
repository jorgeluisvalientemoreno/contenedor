set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/
declare
 cursor cugecuentas is
  select abs(cucosacu) saldo, cucocodi, sesususc,  cuconuse, (SELECT CARGCONC FROM open.CARGOS WHERE CARGCUCO = CUCOCODI AND CARGSIGN = 'DB') concepto
  from open.cuencobr, open.servsusc
  where sesunuse = cuconuse
  and cucosacu < 0
  and cucoCODI in ( 3020450740,
                    3020450739,
                    3020450738,
                    3020450737,
                    3020450741,
                    3020450736,
                    3020450735);

 nuNote number;
begin
 pkErrors.SetApplication('CUSTOMER');
 
 for reg in cugecuentas loop
    nuNote := null;
 --  Crea la nota debito
        pkBillingNoteMgr.CreateBillingNote
        (
            reg.cuconuse,
            reg.cucocodi,
            GE_BOConstants.fnuGetDocTypeDebNote,
            sysdate,
            'NOTA GENERADA POR ERROR EN DESARROLLO DE DESCUENTO DE DIFERIDOS EN JULIO DEL 2022 - OSFF-1395',
            pkBillConst.csbTOKEN_NOTA_DEBITO,
            nuNote
        );

        -- Crea detalle de la nota debito
        FA_BOBillingNotes.DetailRegister
        (
            nuNote,
            reg.cuconuse,
            reg.sesususc,
            reg.cucocodi,
            reg.concepto,
            20,
            reg.saldo,
            NULL,
            pkBillConst.csbTOKEN_NOTA_DEBITO || nuNote,
            pkBillConst.DEBITO,
            pkConstante.SI,
            NULL,
            pkConstante.SI,
            FALSE
        );
        commit;
  end loop;
exception
  when others then
    errors.seterror;
    dbms_output.put_line('error no controlado '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/