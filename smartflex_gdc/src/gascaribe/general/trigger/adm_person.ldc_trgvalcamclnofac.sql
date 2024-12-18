CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGVALCAMCLNOFAC  BEFORE
 UPDATE  ON servsusc
FOR EACH ROW
when (new.SESUCICL <> old.SESUCICL and new.sesuserv = 7014)
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
  sbCicloNofact VARCHAR2(4000) := Daldc_pararepe.fsbGetPARAVAST('CICLOS_NO_FACTURABLES', null);
  sbMotCiclNofact VARCHAR2(400) := Daldc_pararepe.fsbGetPARAVAST('MOTIEXCLU_CINFACTRP', null);

  sbExiste VARCHAR2(1);
  sbExisteExcl VARCHAR2(1);
  nuerror  NUMBER;
  sberror  VARCHAR2(4000);

 cursor cuExisteCicl(inuciclo number) is
 select 'x'
 from ( select to_number(column_value) ciclo
       from table(ldc_boutilities.splitstrings(sbCicloNofact, ',')))
  where ciclo = inuciclo;

  cursor cuExisteExclu is
  SELECT 'X'
  FROM LDC_PRODEXCLRP
  where PRODUCT_ID = :new.sesunuse
   and motivo = sbMotCiclNofact;

begin
  IF fblaplicaentregaxcaso('0000337') THEN
     IF :new.sesucicl IS NOT NULL THEN
        OPEN cuExisteCicl(:new.sesucicl);
        FETCH cuExisteCicl INTO sbExiste;
        CLOSE cuExisteCicl;

        IF sbExiste IS NOT NULL THEN
            OPEN cuExisteExclu;
            FETCH cuExisteExclu INTO sbExisteExcl;
            CLOSE cuExisteExclu;

            IF sbExisteExcl IS NULL THEN
               LDC_PKGESTPREXCLURP.insprodexclrp(:new.sesunuse, sbMotCiclNofact, null, nuerror, sberror);

               IF nuerror <> 0 THEN
                 ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sberror);
               END IF;
            END IF;
        ELSE

          OPEN cuExisteCicl(:OLD.sesucicl);
          FETCH cuExisteCicl INTO sbExiste;
          CLOSE cuExisteCicl;

          IF sbExiste IS NOT NULL THEN
             LDC_PKGESTPREXCLURP.delprodexclrp(:new.sesunuse, sbMotCiclNofact, nuerror, sberror);
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
end LDC_TRGVALCAMCLNOFAC;
/
