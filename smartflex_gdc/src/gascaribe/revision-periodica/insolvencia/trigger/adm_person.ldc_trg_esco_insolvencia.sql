CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_ESCO_INSOLVENCIA
  BEFORE INSERT OR UPDATE ON SERVSUSC
  FOR EACH ROW
  when (new.SESUESCO <> nvl (old.SESUESCO, 0) and new.sesuserv = 7014)
declare

  /*******************************************************************************
  Trigger     :   LDC_TRG_ESTADOCORTE
  Descripcion :   Registra el prodcuto cuando se encuetra en motivo de exclucion por insolvencia
  
  Autor       : Jorge Valiente
  Fecha       : 13/10/2022
  CASO        : OSF-582
  
  Historia de Modificaciones
  Autor               Fecha                   IDEntrega - Descipcion 
  -------------       ------------------      --------------------------------
  
  *******************************************************************************/

  sbMOTIEXCLU_INSOLVENCIA VARCHAR2(4000) := Daldc_pararepe.fsbGetPARAVAST('MOTIEXCLU_INSOLVENCIA',
                                                                          null);
  sbExiste                VARCHAR2(1);
  sbExisteExclInsol       VARCHAR2(1);
  nuerror                 NUMBER;
  sberror                 VARCHAR2(4000);

  cursor cuExisteExcluInsol is
    SELECT 'X'
      FROM LDC_PRODEXCLRP
     where PRODUCT_ID = :new.sesunuse
       and motivo = sbMOTIEXCLU_INSOLVENCIA;

begin

  IF :new.SESUESCO in (111, 112) THEN
    OPEN cuExisteExcluInsol;
    FETCH cuExisteExcluInsol
      INTO sbExisteExclInsol;
    CLOSE cuExisteExcluInsol;
  
    IF sbExisteExclInsol IS NULL THEN
      LDC_PKGESTPREXCLURP.insprodexclrp(:new.sesunuse,
                                        sbMOTIEXCLU_INSOLVENCIA,
                                        null,
                                        nuerror,
                                        sberror);
      IF nuerror <> 0 THEN
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                         sberror);
      END IF;
    END IF;
  END IF;

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    ERRORS.seterror;
    RAISE EX.CONTROLLED_ERROR;
end LDC_TRG_ESCO_INSOLVENCIA;
/
