--SBCONSUMPTIONTYPE    := 'lectelme.leemtcon'|| CC_BOBOSSUTIL.CSBSEPARATOR ||'cc_boBssUtil.fsbConsumptionType(lectelme.leemtcon)';
select lectelme.leemcons leemcons,
       lectelme.leemsesu leemsesu,
       lectelme.leemtcon || ' -  ' || tipocons.tcondesc,
       lectelme.leemclec || ' -  ' ||
       open.CM_BCCONSUMOSMEDIDOS.fsbMeasurementCause(lectelme.leemclec),
       lectelme.leempecs || ' -  ' || pericose.pecsproc,
       lectelme.leempefa || ' -  ' || perifact.pefadesc,
       lectelme.leemcmss leemcmss,
       lectelme.leemdocu leemdocu,
       lectelme.leemfame leemfame,
       lectelme.leemflco leemflco,
       lectelme.leemlean leemlean,
       lectelme.leemfela leemfela,
       lectelme.leemleto leemleto,
       lectelme.leemfele leemfele,
       lectelme.leemelme leemelme,
       lectelme.leemoble || ' -  ' ||
       open.cc_boBssUtil.fsbMeasurementComment(lectelme.leemoble) obselect,
       lectelme.leemobsb || ' -  ' ||
       open.cc_boBssUtil.fsbMeasurementComment(lectelme.leemobsb) leemobsb,
       lectelme.leemobsc || ' -  ' ||
       open.cc_boBssUtil.fsbMeasurementComment(lectelme.leemobsc) leemobsc
  from open.lectelme, open.tipocons, open.pericose, open.perifact
 where tipocons.tconcodi = lectelme.leemtcon
   and pericose.pecscons(+) = lectelme.leempecs
   and perifact.pefacodi(+) = lectelme.leempefa
   --and lectelme.leemelme = 786034   
   --and lectelme.leemtcon = :ConsumptionType
   and lectelme.leemsesu = 1062540
   --and lectelme.leempecs = 102375
   order by lectelme.leemfele desc;
