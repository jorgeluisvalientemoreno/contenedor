select a.actividad_padre,
       open.dage_items.fsbgetdescription(a.actividad_padre, null) desc_padre,
       a.actividad_hija,
       open.dage_items.fsbgetdescription(a.actividad_hija, null) desc_hija
from open.ldc_act_father_act_hija a