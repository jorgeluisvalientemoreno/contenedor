SELECT --/*
 rowidtochar(FA_Cargapro.rowid) RowId_,
 FA_Cargapro.caapcuco,
 FA_Cargapro.caapnuse,
 FA_Cargapro.caapconc || ' - ' ||
 (SELECT concdesc FROM open.concepto WHERE conccodi = FA_Cargapro.caapconc) "Concepto",
 FA_Cargapro.caapcaca || ' - ' ||
 (SELECT cacadesc FROM open.causcarg WHERE cacacodi = FA_Cargapro.caapcaca) Causa_Cargo,
 FA_Cargapro.caapsign || ' - ' ||
 (SELECT signdesc FROM open.signo WHERE signcodi = FA_Cargapro.caapsign) "Signo",
 FA_Cargapro.caappefa || ' - ' ||
 (SELECT pefadesc FROM open.perifact WHERE pefacodi = FA_Cargapro.caappefa) Periodo_Facturacion,
 FA_Cargapro.caapvalo,
 FA_Cargapro.caapdoso,
 FA_Cargapro.caapcodo,
 FA_Cargapro.caapusua || ' - ' ||
 (SELECT mask FROM open.sa_user WHERE user_id = FA_Cargapro.caapusua) caapusua,
 FA_Cargapro.caaptipr || ' - ' ||
 decode(FA_Cargapro.caaptipr,
        'A',
        'Automatico',
        'P',
        'Post Facturacion',
        'F',
        'Facturacion Cruzada') Tipo_Proceso,
 FA_Cargapro.caapunid,
 FA_Cargapro.caapfecr,
 FA_Cargapro.caapprog || ' - ' ||
 (SELECT procdesc FROM open.procesos WHERE proccons = FA_Cargapro.caapprog) caapprog,
 FA_Cargapro.caapcoll,
 FA_Cargapro.caappeco,
 FA_Cargapro.caaptico,
 FA_Cargapro.caapvabl,
 FA_Cargapro.caaptaco,
 FA_Cargapro.caapnoap --*/
  FROM open.FA_Cargapro /*+ FA_BCUIBillingApprMvts.GetChargesToApprove */
 WHERE FA_Cargapro.caapnuse = 50090869
   and trunc(FA_Cargapro.caapfecr) = '29/01/2024'
