CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGPLAZOMIN
  AFTER INSERT OR UPDATE on LDC_UNIT_RP_PLAMIN
  REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
/**************************************************************************
Propiedad Intelectual de Gases del caribe S.A E.S.P

  Funcion     : LDC_TRG_OA_TITRREV
  Descripcion : trigger que valida si en la tabla LDC_UNIT_RP_PLAMIN se registra una unida operativa para el mismo año, mes y departamento
  Autor       : Horbath
  Ticket      : 466
  Fecha       : 6-11-2020

Historia de Modificaciones
Fecha               Autor                Modificacion
=========           =========          ====================


**************************************************************************/
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
  nuAnio number;
  nuMes  number;
  nuDep  number;
  nuUniop number;
  nuVal  NUMBER:=0;

  CURSOR cuValunit (pAnio number,pMes number,pUniop number)  IS
    select 1 from LDC_UNIT_RP_PLAMIN
    where ANIO=pAnio
    and MES=pMes
    AND DEPARTAMENTO=pUniop;


BEGIN
  IF INSERTING THEN
      nuAnio:= :new.ANIO;
      nuMes:=:new.MES;
      nuDep:=:new.DEPARTAMENTO;
      nuUniop:=:new.OPERATING_UNIT_ID;

    open cuValunit(nuAnio,nuMes,nuDep);
    fetch cuValunit into nuVal ;
    close cuValunit;


  ELSIF UPDATING THEN

      IF :OLD.ANIO<>:new.ANIO OR :OLD.MES<>:new.MES OR :OLD.DEPARTAMENTO<>:new.DEPARTAMENTO  THEN

        nuAnio:= :new.ANIO;
        nuMes:= :new.MES;
        nuDep:= :new.DEPARTAMENTO;
        nuUniop:= :new.OPERATING_UNIT_ID;

        open cuValunit(nuAnio,nuMes,nuDep);
        fetch cuValunit into nuVal ;
        close cuValunit;

      END IF;

  END IF;

  if nuVal=1 then

        ge_boerrors.seterrorcodeargument(2741,
                                               'Error: No se puede configurar otra unidad operativa para el mismo año, mes y departamento.');
        RAISE ex.CONTROLLED_ERROR;
   end if;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise;
  when OTHERS then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
END LDC_TRGPLAZOMIN;
/
