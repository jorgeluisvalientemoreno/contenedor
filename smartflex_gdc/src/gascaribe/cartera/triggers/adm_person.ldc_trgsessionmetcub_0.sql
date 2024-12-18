CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGSESSIONMETCUB_0  BEFORE INSERT OR UPDATE  ON LDC_CATMETCUB
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW

/**************************************************************************
      Autor       : Horbath
      Fecha       : 2020-09-21
      Ticket      : 000316
      Proceso     : LDC_TRGSESSIONMETCUB_0
      Descripcion : trigger para actualizar usuario, maquina y fecha ultima actalizacion

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
DECLARE

  cursor cuDATA is
    select user USUARIO, sys_context('USERENV', 'TERMINAL') TERMINAL
      from dual;

  sbUsuario  varchar2(30);
  sbTerminal varchar2(200);

begin

  --IF FBLAPLICAENTREGAXCASO('0000316') then

    open cuDATA;
    fetch cuDATA
      into sbUsuario, sbTerminal;
    close cuDATA;

    :new.usuario := sbUsuario;
    :new.maquina := sbTerminal;

    :new.fecultactu := sysdate;

  --END IF;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    --RAISE_APPLICATION_ERROR(-20001,'Fecha Inicio no puede ser mayor a fecha fin');
    raise;
  when OTHERS then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;

end LDC_TRGLEGAORDRTR;
/
