CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_UPD_VENTA_FNB
 AFTER UPDATE ON LD_APPROVE_SALES_ORDER
   FOR EACH ROW
   /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_TRG_UPD_VENTA_FNB
    Descripcion    : Disparador que actualiza la solicitud de venta FNB asociada al registro de la tabla
                    LD_APPROVE_SALES_ORDER que se esta actualizando
    Autor          : Sayra Ocoro
    Fecha          : 21/12/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
   21/12/2013       Sayra Ocoró      Se adiciona validación para ejecutable LDOA
  ******************************************************************/

DECLARE

 nuPackageId       mo_packages.package_id%type;
 sbComment         mo_packages.comment_%type;
 nuCausal          cc_causal.causal_id%type;
 dtApprovedDate    date;
 sbExecutable sa_executable.name%type;

BEGIN
    begin
        sbExecutable := sa_boexecutable.getexecutablename;
    exception
      when no_data_found then
        sbExecutable := null;
    end;
    ut_trace.trace('sbExecutable  => '||sbExecutable ,10);


    IF (sbExecutable is not null
         and sbExecutable ='LDOA'
         and :new.approved = 'N') then
       --Actualizar observación de solicitud asociada
       dbms_output.put_line('INICIO');

       nuCausal := :new.causal_id;
       dbms_output.put_line('nuCausal => '||nuCausal);

       nuPackageId:= :new.package_id;
       dbms_output.put_line('nuPackageId => '||nuPackageId);

       dtApprovedDate := :new.approved_date;
       sbComment  := damo_packages.fsbgetcomment_(nuPackageId);
       sbComment  := sbComment||' // CAUSAL DE ANULACION ('||dtApprovedDate||'): '||nuCausal||' - '||dacc_causal.fsbgetdescription(nuCausal);
       dbms_output.put_line('sbComment => '||sbComment);
       damo_packages.updcomment_(nuPackageId,sbComment);
       dbms_output.put_line('FIN');
   end if;


EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
END;
/
