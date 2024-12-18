CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_INSER_TRANBANC
 BEFORE INSERT OR UPDATE ON TRANBANC
   FOR EACH ROW
   /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_INSER_TRANBANC
    Descripcion    : Disparador que bloquea la insercion o actualizacion de transacciones bancarias
                     de entidades de recaudo financieras.
    Autor          : Sayra Ocoro
    Fecha          : 25/11/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
DECLARE
      sbExecutable sa_executable.name%type;
BEGIN
    begin
        sbExecutable := sa_boexecutable.getexecutablename;

    exception
      when others then
        sbExecutable := null;
    end;
    ut_trace.trace('sbExecutable  => '||sbExecutable ,10);


    IF (sbExecutable is not null
         and sbExecutable ='FRTB'
         and (instr(:NEW.TRBANUEB,'CIERRE AUTOMATICO') = 0 or :NEW.TRBANUEB is null)
         and  Pktblbanco.fnugetBANCTIER(:NEW.TRBABARE) = 1 ) THEN

            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             sbExecutable ||' - Insercion no permitida para entidades de recaudo financieras');
            raise ex.CONTROLLED_ERROR;

    END IF;
    dbms_output.put_line('FIN');
EXCEPTION

        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
END;

/
