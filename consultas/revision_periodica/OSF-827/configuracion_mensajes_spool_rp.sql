select m.merpcons  consecutivo,
       m.merpedin  edad_inicial,
       m.merpedfi  edad_final,
       m.merptino  tipo_not,
       m.merpmens  mensaje_imp,
       m.merpimfs  impr_fech_susp,
       m.merpimfm  impr_fech_max,
       m.merpimcn  impr_carta_not
from open.ldc_confimensrp m
order by m.merpedin

