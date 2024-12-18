CREATE OR REPLACE TRIGGER adm_person.LDC_TRAISOLABOFNB

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_TRAISOLABOFNB
    Descripcion    : Valida si el tipo de causal seleccionado corresponde
                   con los pagos/abonos a realizar
    Autor          : Nivis Carrasquilla
    Fecha          : 15/11/2016

    Historia de Modificaciones
      Fecha             Autor             Modificacion
    =========         =========         ====================
    15/11/2016    Nivis Carrasquilla    Creacion
    18/10/2022    Jorge Valiente        OSF-621: Se coloca en comentario las siguientes lineas de codigo
                                                 v3 := pkBOAuthorizedPayAmount.fnuTipoCausal(v1);
                                                 :new.tipo_causal := v3;
    17/10/2024    Lubin Pineda          OSF-3383: Se migra a ADM_PERSON
  ******************************************************************/

  BEFORE INSERT ON LDC_SOLCAUFNB
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW

Declare

  v1    Number;
  v2    Number;
  v3    Number;

Begin

    v1 := :new.contrato;

    delete ldc_tmp_tiposoli where contrato = v1;


Exception
  When ex.controlled_error Then
    Raise;
  When Others Then
    errors.seterror;
    Raise ex.controlled_error;

End LDC_TRAISOLABOFNB;
/