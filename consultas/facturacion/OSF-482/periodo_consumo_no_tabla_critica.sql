select *
  from open.pericose c
 where c.pecsfeci >= sysdate
   and not exists (select null
          from open.ldc_bi_proc_critica_consumo p
         where p.idperiodoconsumo = c.pecscons)
