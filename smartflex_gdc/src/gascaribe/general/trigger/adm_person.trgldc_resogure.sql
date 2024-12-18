CREATE OR REPLACE TRIGGER ADM_PERSON.TRGLDC_RESOGURE
 BEFORE INSERT OR UPDATE ON LDC_RESOGURE
   FOR EACH ROW

   /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : TRGLDC_RESOGURE
    Descripcion    : Disparador que bloquea la insercion o actualizacion de registros repetidos en la tabla LDC_RESOGURE
    Autor          : Miguel Angel Lopez
    Fecha          : 04/08/2017

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha               Autor               Modificacion
    =========           =========           ====================
    18/10/2024          jpinedc             OSF-3383: Se migra a ADM_PERSON
  ******************************************************************/
DECLARE
 PRAGMA AUTONOMOUS_TRANSACTION;
      sbExecutable sa_executable.name%type;

      nuExiste number;

      cursor cuLDC_RESOGURE is
        select 1
        from LDC_RESOGURE
        where resolucion = :NEW.resolucion
          and ini_vigencia = :NEW.ini_vigencia
          and localidad = :NEW.localidad;

BEGIN
    begin
        sbExecutable := sa_boexecutable.getexecutablename;

    exception
      when others then
        sbExecutable := null;
    end;
    ut_trace.trace('sbExecutable  => '||sbExecutable ,10);

    open cuLDC_RESOGURE;
    fetch cuLDC_RESOGURE into nuExiste;

    IF nuExiste is not null then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             sbExecutable ||' - Insercion no permitida, ya existe un registro con esta configuraciÃ³n');
            raise ex.CONTROLLED_ERROR;
    end if;


    dbms_output.put_line('FIN');
EXCEPTION

        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
END;
/
