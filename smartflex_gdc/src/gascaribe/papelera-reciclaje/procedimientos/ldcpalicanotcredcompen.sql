CREATE OR REPLACE PROCEDURE ldcpalicanotcredcompen(nupanuse NUMBER,nupacuencobr NUMBER,nupaconcep NUMBER,nupacausa NUMBER,sbpadesc VARCHAR2,nupavalor NUMBER,sbpasigno VARCHAR2,nupasolicitud NUMBER) IS
sbdocudoso VARCHAR2(1000);
nuconpericose  NUMBER;
PROCEDURE registernote(
                        nuServSusc    IN servsusc.sesunuse%TYPE,
                        nucuencobr    IN cuencobr.cucocodi%TYPE,
                        nuConcept     IN concepto.conccodi%TYPE,
                        nuNoteCuase   IN ld_parameter.numeric_value%TYPE,
                        sbDescription IN VARCHAR2,
                        nuValue       ld_item_work_order.value%TYPE,
                        sbtiponota    cargos.cargsign%TYPE
                        ) IS
  nuSubsc      servsusc.sesususc%TYPE;
  nuNote       notas.notanume%TYPE;
  svvatipnot   VARCHAR2(10);
  svvacatipnot cargos.cargsign%TYPE;
 BEGIN
  ut_trace.trace('Inicia LD_BOSUBSIDY.REVERSESUBSIDY.RegisterNote', 5);
  pkErrors.SetApplication('LDRSS');
  nuSubsc := pktblservsusc.fnugetsesususc(nuServSusc);
  IF sbtiponota = 'DB' THEN
   svvatipnot   := pkBillConst.csbTOKEN_NOTA_CREDITO;
   svvacatipnot := pkBillConst.CREDITO;
  ELSIF sbtiponota = 'CR' THEN
   svvatipnot   := pkBillConst.csbTOKEN_NOTA_DEBITO;
   svvacatipnot := pkBillConst.DEBITO;
  END IF;
  --  Crea la nota por el pago inicial
  pkBillingNoteMgr.CreateBillingNote(
                                     nuServSusc,
                                     nucuencobr,
                                     GE_BOConstants.fnuGetDocTypeDebNote,
                                     SYSDATE,
                                     sbDescription,
                                     TRIM(svvatipnot),--pkBillConst.csbTOKEN_NOTA_DEBITO,
                                     nuNote
                                     );
  ut_trace.trace('Termino pkBillingNoteMgr.CreateBillingNote', 5);
  -- Crear Detalle Nota Credito
  fa_bobillingnotes.detailregister(
                                   nuNote,
                                   nuServSusc,
                                   nuSubsc,
                                   nucuencobr,
                                   nuConcept,
                                   nuNoteCuase,
                                   nuValue,
                                   NULL,
                                   TRIM(svvatipnot) || nuNote,
                                   svvacatipnot,
                                   pkConstante.SI,
                                   NULL,
                                   pkConstante.SI);
  ut_trace.trace('Termina LD_boflowFNBPack.CreateDelivOrderCharg.RegisterNote',5);
 EXCEPTION
  WHEN ex.controlled_error THEN
   RAISE ex.controlled_error;
  WHEN OTHERS THEN
      errors.seterror;
      RAISE ex.controlled_error;
 END registernote;
BEGIN
  registernote(nupanuse,nupacuencobr,nupaconcep,nupacausa,sbpadesc,nupavalor,sbpasigno);
  SELECT 'TFS-D-'||t.timeout_component_id INTO sbdocudoso
    FROM pr_timeout_component t
   WHERE t.package_id = nupasolicitud
     AND t.component_id IN(SELECT t.component_id
                             FROM pr_component t
                            WHERE t.product_id = nupanuse);

  SELECT cargpeco INTO nuconpericose
    FROM(
         SELECT DISTINCT vc.cargpeco
           FROM open.cargos vc
          WHERE vc.cargcuco = nupacuencobr
            AND vc.cargpeco IS NOT NULL
          ORDER BY 1 DESC
        )
   WHERE rownum = 1;

  UPDATE cargos
     SET cargdoso        = TRIM(sbdocudoso)
        ,cargpeco        = nuconpericose
   WHERE cargnuse        = nupanuse
     AND cargcuco        = nupacuencobr
     AND cargconc        = nupaconcep
     AND trunc(cargfecr) = trunc(SYSDATE);
EXCEPTION
  WHEN OTHERS THEN
   RAISE_APPLICATION_ERROR(-20000,SQLERRM);
END;
/
