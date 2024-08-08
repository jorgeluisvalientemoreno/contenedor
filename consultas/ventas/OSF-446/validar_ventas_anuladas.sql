select *
from open.ldc_solianeco ls
where ls.producto  in (52111493, 51446390, 50891018)
and ls.estado = 'P';
