SELECT /*+ index (fm_preinvoice_pno idx_fm_preinvoice_pno01)
                   index (pericose pk_pericose)
                   use_nl (fm_preinvoice_pno pericose)
                   leading (fm_preinvoice_pno)
                */
 fm_preinvoice_pno.*, (select b.mask ||'-'|| a.name_
  from open.ge_person a, open.sa_user b
 where a.user_id = b.user_id
 --and b.user_id = 5916
 and a.user_id = fm_preinvoice_pno.user_id) Funcional
  FROM open.fm_preinvoice_pno, open.pericose
/*+ ubicacion:  FM_BCPNOPreinvoice.frfConsumptionConcepts */
 WHERE pericose.pecscons = 111641
      --fm_preinvoice_pno.pnoliq_version = inuLiqVersion
      --  AND fm_preinvoice_pno.package_id = inuPackageId
      --  AND fm_preinvoice_pno.cargvalotype = csbPNOConsConceptType
   AND pericose.pecscons = fm_preinvoice_pno.pecscons
   and fm_preinvoice_pno.UNITS_AVG_NEGOT is not null
order by fm_preinvoice_pno.PNOLIQ_DATE desc;
