CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGVALCATEG  BEFORE
 INSERT OR UPDATE  ON servsusc
FOR EACH ROW
when (new.SESUCATE <> nvl(old.SESUCATE,0) and new.sesuserv = 7014)
  /**************************************************************************
  Proceso     : LDC_TRGNOTITERMPROC
  Autor       : Luis Javier Lopez/ Horbath
  Fecha       : 2020-12-07
  Ticket      : 337
  Descripcion : trigger para marcar excluir productos con ciclos no facturables

  Parametros Entrada
  Parametros de salida
  HISTORIA DE MODIFICACIONES
  FECHA         AUTOR       DESCRIPCION
  21/10/2024    jpinedc     OSF-3450: Se migra a ADM_PERSON
  ***************************************************************************/
declare
  sbCategEds VARCHAR2(4000) := Daldc_pararepe.fsbGetPARAVAST('CODIGO_CATG_EDS', null);
  sbMotCateEds VARCHAR2(400) := Daldc_pararepe.fsbGetPARAVAST('MOTIEXCLU_EDSRP', null);

  sbExiste VARCHAR2(1);
  sbExisteExcl VARCHAR2(1);
  nuerror  NUMBER;
  sberror  VARCHAR2(4000);

 cursor cuExisteCate(inucate number) is
 select 'x'
 from ( select to_number(column_value) cate
       from table(ldc_boutilities.splitstrings(sbCategEds, ',')))
  where cate = inucate;

  cursor cuExisteExclu is
  SELECT 'X'
  FROM LDC_PRODEXCLRP
  where PRODUCT_ID = :new.sesunuse
   and motivo = sbMotCateEds;

begin
  IF fblaplicaentregaxcaso('0000337') THEN
     IF :new.sesucate IS NOT NULL THEN
        OPEN cuExisteCate(:new.sesucate);
        FETCH cuExisteCate INTO sbExiste;
        CLOSE cuExisteCate;

        IF sbExiste IS NOT NULL THEN
            OPEN cuExisteExclu;
            FETCH cuExisteExclu INTO sbExisteExcl;
            CLOSE cuExisteExclu;

            IF sbExisteExcl IS NULL THEN
               LDC_PKGESTPREXCLURP.insprodexclrp(:new.sesunuse, sbMotCateEds, null, nuerror, sberror);

               IF nuerror <> 0 THEN
                 ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sberror);
               END IF;
            END IF;
        ELSE

          OPEN cuExisteCate(:OLD.sesucate);
          FETCH cuExisteCate INTO sbExiste;
          CLOSE cuExisteCate;

          IF sbExiste IS NOT NULL THEN
             LDC_PKGESTPREXCLURP.delprodexclrp(:new.sesunuse, sbMotCateEds, nuerror, sberror);
             IF nuerror <> 0 THEN
                ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sberror);
             END IF;
          END IF;

        END IF;
     END IF;
  END IF;

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    ERRORS.seterror;
    RAISE EX.CONTROLLED_ERROR;
end LDC_TRGVALCATEG;
/
