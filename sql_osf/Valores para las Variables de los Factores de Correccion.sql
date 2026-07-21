select a.*, rowid
  from OPEN.CM_VAVAFACO a
 where a.vvfcfeiv >= '01/02/2026'
   and a.vvfcvalo = 0
 order by a.vvfcfeiv desc
