SELECT /*+ index(FA_Notaapro PK_FA_NOTAAPRO)*/
/* FA_Notaapro.noapnume,
FA_Notaapro.noapsusc,
FA_Notaapro.noaptino || ' - ' ||
decode(FA_Notaapro.noaptino,
       'D',
       'Debito',
       'C',
       'Credito',
       'R',
       'Reclasificacion',
       'U',
       'Castigo Cartera') Tipo_Nota,
FA_Notaapro.noapobse,
FA_Notaapro.noapdocu,
FA_Notaapro.noaptido || ' - ' ||
(SELECT description
   FROM open.ge_document_type
  WHERE document_type_id = FA_Notaapro.noaptido) noaptido,
FA_Notaapro.noapfact,
FA_Notaapro.noapterm,
FA_Notaapro.noapprog || ' - ' ||
(SELECT procdesc FROM open.procesos WHERE proccons = FA_Notaapro.noapprog) noapprog,
FA_Notaapro.noapapmo*/
 *
  FROM open.FA_Notaapro /*+ FA_BCUIBillingApprMvts.GetNoteToApprove */
--- WHERE FA_Notaapro.noapnume = inuNoApNume
;
select * FROM open.fa_novecata;
select * FROM open.fa_novecatp;
select * FROM open.FA_APROMOFA;
select * FROM open.FA_RESOGURE;
SELECT *
  FROM open.FA_Cargapro
 WHERE FA_Cargapro.caapnuse = 50090869
   and trunc(FA_Cargapro.caapfecr) = '31/01/2024'
