declare
  
  cursor cuTitr is
   select distinct  task_type_id,t.description, t.concept||'-'||case when t.concept is not null then open.pktblconcepto.fsbgetdescription(t.concept, null) else null end  concept, substr(ccc.ccbgceco, 5, 2) ceco, (select c.cuctcodi||'-'||c.cuctdesc from open.ldci_cuentacontable c where c.cuctcodi=c.cuencosto) cuenta
   from open.ic_clascott cc
   inner join open.or_task_type t on cc.clcttitr=t.task_type_id
  inner join open.ldci_cugacoclasi c on c.cuenclasifi=cc.clctclco
  inner join open.ldci_cecoubigetra ccc on ccc.ccbgtitr=cc.clcttitr
  where  CLCTTITR in (10714,10834,10835,10836,10715,10716,10717,10718,10719,10720,10721,10722,12173,12460,12135,12143,12147,12148,12138,12453,12465,12487,10075,12187,12188,12189,12190,10339,12136,12146,10011,12139,12140,12142)
  order by 1;

  SBRUTA       VARCHAR2(4000) := '/smartfiles/Construcciones/Contratos_fijos';
  SBLINEA      VARCHAR2(4000) := NULL;
  SBNEWLINEA   VARCHAR2(4000) := NULL;
  SBARCHI      VARCHAR2(4000) := NULL;
  SBMESSAGE    VARCHAR2(4000);
  ARCH         UTL_FILE.FILE_TYPE;
  ASBA         UTL_FILE.FILE_TYPE;
  INCO         UTL_FILE.FILE_TYPE;

  i date;
  j date;
  
  cursor cuDatosOt(nuTitr number,
                   dtFecha date) IS
  select o.order_id, 
       o.task_type_id, 
       o.created_date, 
       o.assigned_date, 
       o.legalization_date,
       o.causal_id,
       o.charge_status,
       o.external_address_id
from open.or_order o
where o.task_type_id = nuTitr
  and o.order_status_id=8
  and trunc(o.legalization_Date)=dtFecha;
 
  
  cursor cuCausalExito is
  select causal_id, description
  from open.ge_causal c 
  where c.class_causal_id =1;
  
  
  
  TYPE  rcCausal  IS RECORD
    (
        causal_id      open.ge_causal.causal_id%TYPE,
        descripcion    open.ge_causal.description%TYPE
    );

 TYPE tbCausal is table of rcCausal index by varchar2(20);
 causal tbCausal;
 
 cursor cuTipoSol is
 select package_type_id,
        description 
from open.ps_package_type;

TYPE  rcTipoSoll  IS RECORD
    (
        package_type_id      number,
        descripcion     varchar2(4000)
    );

 TYPE tbTiso is table of rcTipoSoll index by varchar2(20);
 tipoSol tbTiso;
 
  cursor cuDeparta is 
 select de.geograp_location_id depa,
       de.description desc_depa,
       lo.geograp_location_id loca,
       lo.description desc_loca
from open.ge_geogra_location lo, open.ge_geogra_location de
where lo.geog_loca_area_type=3
  and lo.geo_loca_father_id=de.geograp_location_id;
  
  TYPE  rcDepartam  IS RECORD
    (
        depa      number,
        desc_depa     varchar2(4000),
        loca          number,
        desc_loca     varchar2(4000)
    );

 TYPE tbDepa is table of rcDepartam index by varchar2(20);
 Depart tbDepa;
 
 
 cursor cuOrderActivity(nuOrden number) is
 select a.subscription_id, a.product_id, a.package_id, (select package_type_id from open.mo_packages p where p.package_id=a.package_id) tipo_sol, a.address_id
 from open.or_order_activity a 
 where a.order_id=nuOrden
   and a.order_activity_id=open.LDC_BCFINANCEOT.fnuGetActivityId(nuOrden);
   
 cursor Diferido(nuProducto number,
                 nuOrden number) is
 SELECT difevatd
FROM OPEN.DIFERIDO
WHERE DIFENUSE=nuProducto
  AND DIFENUDO='OR-'||nuOrden;
  
 cursor cuDireccion(nuDireccion number) is
 select di.address, di.geograp_location_id
 from open.ab_address di
 where address_id=nuDireccion;
 

  
    NUDIFERIDO NUMBER:=0;
    sbDireccion open.ab_address.address%type;
    nuLoca      open.ge_geogra_location.geograp_location_id%type;
    nuDepart    open.ge_geogra_location.geograp_location_id%type;
    sbDepart    open.ge_geogra_location.description%type;
    nuLocali    open.ge_geogra_location.geograp_location_id%type;
    sbLocali    open.ge_geogra_location.description%type;
begin
     IF &MES != 12 THEN
    i :=to_date(to_char('01/'||&MES||'/'||&NUANO),'dd/mm/yyyy');
    j :=to_date(to_char('01/'||(&MES+1)||'/'||&NUANO),'dd/mm/yyyy');
  ELSE
     i :=to_date(to_char('01/'||&MES||'/'||&NUANO),'dd/mm/yyyy');
     j :=to_date(to_char('01/'||01||'/'||(&NUANO+1)),'dd/mm/yyyy');
  END IF;
  SBARCHI:=REPLACE(TO_CHAR(i,'MONTH')||'_'||&NUANO||'.CSV',' ','');
  --SBARCHI      := 'ENERO.CSV';
  INCO := UTL_FILE.FOPEN(SBRUTA, SBARCHI, 'W');
  SBMESSAGE:='ORDEN|TITR|CONCEPTO|FECHA_CREACION|FECHA_ASIGNACION|FECHA_LEGALIZACION|CAUSAL|CONTRATO|PRODUCTO|SOLICITUD|TIPO_SOL|VALOR_DIFERIDO|CECO|DEPA|LOCA|DIR|CUENTA|CHARGE_STATUS';
  UTL_FILE.PUT_LINE(INCO, SBMESSAGE);
  for c in cuCausalExito loop
    causal(c.causal_id).causal_id:=c.causal_id;
    causal(c.causal_id).descripcion:=c.description;
  end loop;
  
  for c in cuTipoSol loop
    tipoSol(c.package_type_id).package_type_id:=c.package_type_id;
    tipoSol(c.package_type_id).descripcion:=c.description;
  end loop;
  
  for c in cuDeparta loop
    Depart(c.loca).depa:=c.depa;
    Depart(c.loca).desc_depa:=c.desc_depa;
    Depart(c.loca).loca:=c.loca;
    Depart(c.loca).desc_loca:=c.desc_loca;
  end loop;
  
    while i < j loop
       for reg in cuTitr loop
           FOR REG2 IN cuDatosOt(reg.task_type_id, i) LOOP
             if causal.exists(reg2.causal_id) then
               for reg3 in cuOrderActivity(REG2.ORDER_ID) loop
                 open cuDireccion(nvl(reg2.external_address_id, reg3.address_id));
                 fetch cuDireccion into sbDireccion, nuLoca;
                 if cuDireccion%notfound then
                   sbDireccion:=null;
                   nuLoca:=null;
                   nuDepart:=null;
                   sbDepart:=null;
                   nuLocali:=null;
                   sbLocali:=null;
                 else
                   nuDepart:= Depart(nuLoca).depa;
                   sbDepart:= Depart(nuLoca).desc_depa;
                   nuLocali:= Depart(nuLoca).loca;
                   sbLocali:= Depart(nuLoca).desc_loca;
                 end if;
                 close cuDireccion;
                 for reg4 in Diferido(reg3.product_id, reg2.order_id) loop
                   NUDIFERIDO:=1;
                   if REG3.tipo_sol is not null then
                      SBMESSAGE:=REG2.ORDER_ID||'|'||REG.TASK_TYPE_ID||'-'||REG.DESCRIPTION||'|'||REG.CONCEPT||'|'||REG2.CREATED_DATE||'|'||REG2.ASSIGNED_DATE||'|'||REG2.LEGALIZATION_DATE||'|'||REG2.CAUSAL_ID||'|'||REG3.SUBSCRIPTION_ID||'|'||REG3.PRODUCT_ID||'|'||REG3.PACKAGE_ID||'|'||REG3.tipo_sol||'-'||tipoSol(REG3.tipo_sol).descripcion||'|'||REG4.DIFEVATD||'|'||REG.CECO||'|'||nuDepart||'|'||sbDepart||'|'||nuLocali||'|'||sbLocali||'|'||sbDireccion||'|'||reg.cuenta||'|'||reg2.charge_status;
                   else
                     SBMESSAGE:=REG2.ORDER_ID||'|'||REG.TASK_TYPE_ID||'-'||REG.DESCRIPTION||'|'||REG.CONCEPT||'|'||REG2.CREATED_DATE||'|'||REG2.ASSIGNED_DATE||'|'||REG2.LEGALIZATION_DATE||'|'||REG2.CAUSAL_ID||'|'||REG3.SUBSCRIPTION_ID||'|'||REG3.PRODUCT_ID||'|'||REG3.PACKAGE_ID||'|'||REG3.tipo_sol||'|'||REG4.DIFEVATD||'|'||REG.CECO||'|'||nuDepart||'|'||sbDepart||'|'||nuLocali||'|'||sbLocali||'|'||sbDireccion||'|'||reg.cuenta||'|'||reg2.charge_status;
                   end if;
                   
                 end loop;
                 IF NUDIFERIDO = 0 THEN
                     if REG3.tipo_sol is not null then
                      SBMESSAGE:=REG2.ORDER_ID||'|'||REG.TASK_TYPE_ID||'-'||REG.DESCRIPTION||'|'||REG.CONCEPT||'|'||REG2.CREATED_DATE||'|'||REG2.ASSIGNED_DATE||'|'||REG2.LEGALIZATION_DATE||'|'||REG2.CAUSAL_ID||'|'||REG3.SUBSCRIPTION_ID||'|'||REG3.PRODUCT_ID||'|'||REG3.PACKAGE_ID||'|'||REG3.tipo_sol||'-'||tipoSol(REG3.tipo_sol).descripcion||'|'||0||'|'||REG.CECO||'|'||nuDepart||'|'||sbDepart||'|'||nuLocali||'|'||sbLocali||'|'||sbDireccion||'|'||reg.cuenta||'|'||reg2.charge_status;
                   else
                     SBMESSAGE:=REG2.ORDER_ID||'|'||REG.TASK_TYPE_ID||'-'||REG.DESCRIPTION||'|'||REG.CONCEPT||'|'||REG2.CREATED_DATE||'|'||REG2.ASSIGNED_DATE||'|'||REG2.LEGALIZATION_DATE||'|'||REG2.CAUSAL_ID||'|'||REG3.SUBSCRIPTION_ID||'|'||REG3.PRODUCT_ID||'|'||REG3.PACKAGE_ID||'|'||REG3.tipo_sol||'|'||0||'|'||REG.CECO||'|'||nuDepart||'|'||sbDepart||'|'||nuLocali||'|'||sbLocali||'|'||sbDireccion||'|'||reg.cuenta||'|'||reg2.charge_status;
                   end if;
                 END IF;
                 NUDIFERIDO := 0;
                 UTL_FILE.PUT_LINE(INCO, SBMESSAGE);
               end loop;
             end if;
           end loop;
       end loop;
       i:=i+1;
    end loop;
    UTL_FILE.FCLOSE(INCO);
end;
