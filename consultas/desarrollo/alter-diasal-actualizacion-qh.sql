--habilitar  consultas en SAASE para poder consultar otros perfiles
UPDATE sa_user
   SET USER_TYPE_ID=3
--select * from open.sa_user
where mask='DIASAL';


---El rol 50 lo requiere GCNED para permitir negociaciones a nivel de contrato a un usuario
INSERT INTO
SA_USER_ROLES ( ROLE_ID, USER_id )
values
( 50, 5423 );

commit;
/
GRANT ADMIN_SYSTEM_ROLE TO DIASAL; 
REVOKE PUBLIC_SYSTEM_ROLE FROM DIASAL;
GRANT select any table TO DIASAL; 
grant ALTER USER to diasal;
update ge_person set ORGANIZAT_AREA_ID=64 where user_id in (select s.user_id from open.sa_user s where mask='DIASAL');
commit;
/

declare
  cursor cuunidad is
  select * from open.or_operating_unit u
  where not exists(select null from or_oper_unit_persons p where p.person_id=38963 and u.operating_unit_id=p.operating_unit_id)
     and not exists(select null from open.ge_organizat_area a where a.organizat_area_id=u.operating_unit_id);
begin
  for reg in cuunidad loop
    begin
      insert into or_oper_unit_persons values(reg.operating_unit_id, 38963);
      commit;
    exception
      when others then
        rollback;
    end;
  end loop;
end;
/

--insert lego 
insert into LDC_USUALEGO select 38963 person_id, 43 agente_id, 38963 tecnico_unidad, 'N' unico_tecnico, null causal_id  from dual where not exists(select null from ldc_usualego where person_id=38963) ;

update ld_parameter set value_chain ='dsaltarin@gascaribe.com' where parameter_id='LDC_EMAILNOLE';
update ld_parameter set value_chain ='N' where parameter_id='PRINTER_AUTOMATIC_KIOSCO';

--resoluciones de fact elect
update  recofael set prefijo = 'SETT' where tipo_documento in (1,2) ;

--tasa de usura
update ldc_conftain
set cotifefi = '31/12/2025'
where cotitain = 2
and cotifein = (select cotifein from (
                    select cotifein 
                    from ldc_conftain 
                    where cotitain = 2 
                    order by cotifein desc
                ) 
                where rownum = 1);
                
update conftain
set cotifefi = '31/12/2025'
where cotitain = 2
and cotifein = (select cotifein from (
                    select cotifein 
                    from conftain 
                    where cotitain = 2 
                    order by cotifein desc
                ) 
                where rownum = 1);

--perfiles financieros

insert into ge_financial_profile values(1456, 1, 99999999999);
insert into ge_financial_profile values(1456, 2, 99999999999);
insert into ge_financial_profile values(1456, 3, 99999999999);
insert into ge_financial_profile values(1456, 4, 99999999999);
insert into ge_financial_profile values(1456, 5, 99999999999);
insert into ge_financial_profile values(1456, 6, 99999999999);
INSERT INTO ta_perfusua 
VALUES (SQ_ta_perfusua_PEUSCONS.NEXTVAL, 21, 5423);
commit;
/
  begin
   CC_BOPlan_Comisiones.InsCanVenVendedor(38963, 64);
   commit;
 exception
 when others then
   rollback;
 end;
/  
BEGIN
        execute immediate 'alter trigger CSE.TRG_TIPOSERV DISABLE';
END;
/
  
--Quitar correos de los contratos y guardarlos en tabla dummy

create table contratos_correos as 
select  susccodi , suscmail   
from suscripc  ; 
/

update suscripc
set suscmail = null
where suscmail is not null ;

commit;
/

CREATE OR REPLACE TRIGGER TRG_SUSCRIPC_NULL_MAIL
BEFORE INSERT OR UPDATE ON SUSCRIPC
FOR EACH ROW
BEGIN
     
   IF :NEW.SUSCMAIL IS NOT NULL THEN
      INSERT INTO CONTRATOS_CORREOS (SUSCCODI, SUSCMAIL)
      VALUES (:NEW.SUSCCODI, :NEW.SUSCMAIL);
   END IF;

   :NEW.SUSCMAIL := NULL;
END;

/

begin
  --deshabiltar jobs de facturaci�n electronica para que no se consuman las secuencias 
  dbms_scheduler.disable('ADM_PERSON.JOB_NOTAS_FACTELECGEN');
  dbms_scheduler.disable('ADM_PERSON.JOB_VENTAS_ELECGEN');
  dbms_scheduler.disable('ADM_PERSON.JOB_FACTURACION_ELECGEN');
  dbms_scheduler.disable('ADM_PERSON.JOB_ELIMFACTURACION_ELECGEN');
end;
/
