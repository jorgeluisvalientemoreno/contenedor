CREATE OR REPLACE procedure fix_cucofepa1 is
cursor cuentas is SELECT  cucocodi
FROM    cuencobr
WHERE   cucofepa > sysdate;
f date;
begin
     for c in cuentas loop
         select max(cargfecr) into f from cargos where cargcuco=
                c.cucocodi and cargsign in ('PA','AS');
         UPDATE CUENCOBR SET CUCOFEPA=F WHERE CUCOCODI=C.CUCOCODI;
     end loop;
     COMMIT;
end;
/
