select ldc_prodrerp.prreprod,
       ldc_prodrerp.prreacti,
       ldc_prodrerp.prrefege,
       ldc_prodrerp.prreproc,
       ldc_prodrerp.prrefepr,
       ldc_prodrerp.prreobse,
       ldc_prodrerp.prrefuen,
       ldc_prodrerp.prreinte
  from open.ldc_prodrerp 
  where ldc_prodrerp.prreprod = 1999612
  order by ldc_prodrerp.prrefege desc
