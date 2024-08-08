select *
from OPEN.GE_ITEMS_DOC_LOG l
where l.id_items_documento=120292;

select *
from OPEN.GE_ITEMS_DOC_REL r
where r.id_items_doc_origen =120292 or r.id_items_doc_destino=120292;
