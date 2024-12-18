CREATE OR REPLACE TRIGGER ADM_PERSON.trgbirconssesu
  BEFORE UPDATE ON conssesu
  REFERENCING OLD AS old NEW AS new
  FOR EACH ROW

/**************************************************************
Propiedad intelectual de Gases del Caribe. (c).

Trigger      : trgbirconssesu
Descripcion  : Trigger que REALIZA VALIDACIONES EN EL MANTENIMIENTO DE CONSUMO (FMACO).
Autor        : gdc
Fecha        : 10/JUNIO/2015

Historia de Modificaciones
Fecha        IDEntrega           Modificacion
19/12/2019.  Caso 218(CA).       Horbath (EHGv3). Se habilita control para manejar las dos formas de cambios de consumo. OK++
                                 Se cambia cualquier referencia a la palabra FMLE por la palabra FMACO.
**************************************************************/
DECLARE
  /******************************************
      Declaracion de variables y Constantes
  ******************************************/

  /* Constantes para formularios de FMACO y APRFMACO (Mantenimiento de Consumo)*/
  --REQ. 218. Formas PB para el cambio de consumo.
  csbFMACO      CONSTANT VARCHAR2(5)  := 'FMACO';--Cambios de consumo de manera directa.
  csbAPRFMACO   CONSTANT VARCHAR2(10) := 'APRFMACO';--Cambios de consumo bajo aprobación.
  sbFUENTE      varchar2(50);--Variable fuente
  --
  vnuExpf       number;
  vnuExpc       number;
  VnuExLCPc     number;
  osbmodulename varchar2(20);
  osbaction     varchar2(20);

BEGIN
  /*
  --valida que la operacion viene de al forma FMACO
  --CASE UT_SESSION.GETMODULE()
  -- WHEN csbFMACO THEN
  */

  --REQ. 218(CA). Se obtiene la Fuente
  sbFUENTE := UT_SESSION.GETMODULE();

  --REQ. 218(CA). Se valida si la fuente que dispara el Trigger es alguna de las dos formas PB habilitadas para hacer cambios de consumo.
  IF ((sbFUENTE = csbFMACO) or (sbFUENTE = csbAPRFMACO)) then
      --si hay cambio de periodo de facturacion
      if :new.cosspefa <> :old.cosspefa then
        --valida que el perido actualizada pertenezca al pruducto
        SELECT count(*)
          into vnuExpf
          FROM PERIFACT
         where pefacicl in (pktblservsusc.fnugetsesucicl(:new.cosssesu))
           and pefacodi = :new.cosspefa;

        if vnuExpf = 0 then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           'El Periodo de Factuacion no esta asociado al producto, Verifique.');
        end if;
      end if;
      -- si hay cambio de periodo consumo
      if :new.cosspecs <> :old.cosspecs then
        --valida que el peridodo de consumo actualizado pertenezca al pruducto
        select count(*)
          into vnuExpc
          from pericose t
         where t.pecscico in (pktblservsusc.fnugetsesucicl(:new.cosssesu))
           and t.pecscons = :new.cosspecs;

        if vnuExpf = 0 then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           'El Periodo de Consumo no esta asociado al producto, Verifique.');
        end if;
        --valida que el periodo de consumo actualizado tenga critica y lectura ademas que la fecha
        --final de periodo de consumo sea menos que el sysdate
        select COUNT(*)
          INTO VnuExLCPc
          from pericose t
         where t.pecscons = :new.cosspecs
           and pecsproc = 'S'
           AND PECSFLAV = 'S'
           and pecsfecf < sysdate;

        if VnuExLCPc = 0 then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           'El Periodo de Consumo no tiene Critica/Lectura o su fecha final es mayor o igual al dia de hoy, Verifique.');
        end if;
      end if;
      --registra auditoria
      BEGIN
        insert into aucamcons
          (aucosesu,
           aucopefa_ac,
           aucopefa_an,
           aucococa_ac,
           aucococa_an,
           aucoelme_ac,
           aucoelme_an,
           aucopecs_ac,
           aucopecs_an,
           aucofere,
           aucopers,
           aucousna,
           aucoterm,
           aucodiip,
           aucohost)
        values
          (:new.cosssesu,
           :new.cosspefa,
           :OLD.cosspefa,
           :new.cosscoca,
           :OLD.cosscoca,
           :new.cosselme,
           :OLD.cosselme,
           :new.cosspecs,
           :OLD.cosspecs,
           SYSDATE,
           GE_BOPersonal.fnuGetPersonId,
           USER,
           userenv('TERMINAL'),
           sys_context('userenv', 'ip_address'),
           sys_context('userenv', 'host'));
      EXCEPTION
        WHEN OTHERS THEN
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           'Error al registrar Auditoria. ' ||
                                           sqlerrm);
      END;

      /*ELSE
        null;
        END CASE;*/
 END IF;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    RAISE ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    Errors.setError;
    RAISE ex.CONTROLLED_ERROR;
END trgbirconssesu;
/
