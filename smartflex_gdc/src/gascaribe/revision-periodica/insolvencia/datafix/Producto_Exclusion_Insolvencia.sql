declare
  --Se debe crear un script que busque los productos con estado de corte 111 y 112
  --registrarlos en la tabla de exclusion con su respectivo log.

  cursor cuEstadoCorteInsolvencia is
    select a.*
      from open.servsusc a
     where a.sesuesco in (111, 112)
       and a.sesuserv = 7014;

  sbMOTIEXCLU_INSOLVENCIA VARCHAR2(4000) := Daldc_pararepe.fsbGetPARAVAST('MOTIEXCLU_INSOLVENCIA',
                                                                          null);

  rfInsolvencia cuEstadoCorteInsolvencia%ROWTYPE;

  sbExiste          VARCHAR2(1);
  sbExisteExclInsol VARCHAR2(1);
  nuerror           NUMBER;
  sberror           VARCHAR2(4000);

  cursor cuExisteExcluInsol(Inusesunuse number) is
    SELECT 'X'
      FROM LDC_PRODEXCLRP
     where PRODUCT_ID = Inusesunuse
       and motivo = sbMOTIEXCLU_INSOLVENCIA;
begin

  DBMS_OUTPUT.put_line('Motivo Insolvencia: ' || sbMOTIEXCLU_INSOLVENCIA);

  FOR rfInsolvencia IN cuEstadoCorteInsolvencia LOOP
  
    OPEN cuExisteExcluInsol(rfInsolvencia.sesunuse);
    FETCH cuExisteExcluInsol
      INTO sbExisteExclInsol;
    CLOSE cuExisteExcluInsol;
  
    IF sbExisteExclInsol IS NULL THEN
      LDC_PKGESTPREXCLURP.insprodexclrp(rfInsolvencia.sesunuse,
                                        sbMOTIEXCLU_INSOLVENCIA,
                                        null,
                                        nuerror,
                                        sberror);
      DBMS_OUTPUT.put_line('Exclusion del producto : ' ||
                           rfInsolvencia.sesunuse ||
                           ' con el motivo de insolvencia: ' ||
                           sbMOTIEXCLU_INSOLVENCIA);
      commit;
      IF nuerror <> 0 THEN
        DBMS_OUTPUT.put_line('No se pudo registrar Exclusion del producto : ' ||
                             rfInsolvencia.sesunuse || ' - Error: ' ||
                             nuerror || ' - ' || sberror);
        Rollback;
      
      END IF;
    END IF;
  
  END LOOP;

end;
/
