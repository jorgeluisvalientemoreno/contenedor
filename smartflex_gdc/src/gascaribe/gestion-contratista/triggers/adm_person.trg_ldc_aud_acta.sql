CREATE OR REPLACE trigger ADM_PERSON.TRG_LDC_AUD_ACTA
  after insert or update or delete on ge_acta
  referencing
         new as new
         old as old
  for each row
 /*****************************************************************
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  18/05/2017       Diana Saltarin    Caso 200-1291: Se creara el registro de la persona que cierra el acta
													           solo cuando el estado anterior sea diferente de C

  ******************************************************************/
Declare

  cursor cuaudacta is
    select *
      from ldc_audi_actas laa
     where laa.id_acta = NVL(:new.id_acta, :OLD.ID_ACTA);

  rfcuaudacta cuaudacta%rowtype;

  nuexiste number := 0;

  nucontratista Number;
  nuordenes     Number;

Begin

  If fblaplicaentrega('OSS_SA_JLV_200869_1') Then
    ut_trace.trace('entro trg_ldc_val_confing_tt_local', 10);

    open cuaudacta;
    fetch cuaudacta
      into rfcuaudacta;
    if cuaudacta%found then
      nuexiste := 1;
    end if;
    close cuaudacta;

    if DELETING then
      if nuexiste = 1 then
        update ldc_audi_actas laa
           set laa.usu_rev_acta = open.UT_SESSION.GETUSER
         where laa.id_acta = :old.id_acta;
      else
        insert into ldc_audi_actas
        values
          (:old.id_acta, null, null, open.UT_SESSION.GETUSER);
      end if;

    else

      If (:new.estado = 'C' and :old.estado != 'C') Then
        if nuexiste = 1 then
          update ldc_audi_actas laa
             set laa.usu_cer_acta = open.UT_SESSION.GETUSER
           where laa.id_acta = :old.id_acta;
        else
          insert into ldc_audi_actas
          values
            (:old.id_acta, null, open.UT_SESSION.GETUSER, null);
        end if;

      elsif INSERTING then
        if nuexiste = 1 then
          update ldc_audi_actas laa
             set laa.usu_gen_acta = open.UT_SESSION.GETUSER
           where laa.id_acta = :new.id_acta;
        else
          insert into ldc_audi_actas
          values
            (:new.id_acta, open.UT_SESSION.GETUSER, null, null);
        end if;

      End If;
    end if;

  End If;
Exception
  When ex.controlled_error Then
    Raise;
  When Others Then
    errors.seterror;
    Raise ex.controlled_error;
End TRG_LDC_AUD_ACTA;
/
