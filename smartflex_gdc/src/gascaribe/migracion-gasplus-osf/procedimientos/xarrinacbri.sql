CREATE OR REPLACE procedure xarrinacbri is
cursor ux is select * from seRVSUSC where sesuserv=7055 and sesuesco=95;
cuentas number;
difes   number;
estcorfact number;
estprofact number;
cicl number;
fefi date;
cursor dife (prd number) is select * from diferido where difenuse=prd and difecupa=0;
begin
     pkErrors.setapplication('MIGRA');
     estcorfact:=1;
     estprofact:=1;
     for u in ux loop
         SELECT COUNT(1) INTO CUENTAS FROM CUENCOBR WHERE CUCONUSE=U.SESUNUSE;
         SELECT  COUNT(1) INTO DIFES FROM DIFERIDO WHERE DIFENUSE=U.SESUNUSE;
         if cuentas>0 or difes>0 then
            UPDATE SERVSUSC SET SESUESCO=estcorfact WHERE SESUNUSE=U.SESUNUSE;
            upDATE pr_product SET product_status_id = estprofact WHERE product_id = U.SESUNUSE;
            update pr_component set component_status_id=5 where product_id=u.sesunuse;
            select sesucicl into cicl from servsusc where sesunuse=u.sesunuse;
            select pefaffmo+1 into fefi from perifact where pefacicl=cicl and pefaano=2014 and pefames=3;
            for d in dife(u.sesunuse) loop
                insert into CC_GRACE_PERI_DEFE (GRACE_PERI_DEFE_ID,GRACE_PERIOD_ID,DEFERRED_ID,
                       INITIAL_DATE,END_DATE,PROGRAM,PERSON_ID)
                values (seq_cc_grace_peri_d_185489.nextval,5,d.difecodi,d.difefeIN,fefi,-1,4104);
            end loop;
            commit;
         end if;
     end loop;
end;
/
