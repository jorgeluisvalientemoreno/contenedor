select b1.*, i.description 
from open.LDC_CONDBLOQASIG  b1,
open.ge_items i
where b1.activity_id = i.items_id
