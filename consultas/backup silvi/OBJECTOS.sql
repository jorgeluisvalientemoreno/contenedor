select *
from all_source 
where upper(text) like upper('%UO_ENTREGA_SALDO_A_FAVOR%');

select *
from dba_dependencies
where  upper(referenced_name) like upper('%UO_ENTREGA_SALDO_A_FAVOR%');

select * from dba_source d where upper(d.TEXT) like upper('%UO_ENTREGA_SALDO_A_FAVOR%'); 

select *
from   open.ge_statement
where  upper(statement) like upper('%LDC_CICLOS_FICTICIOS%')


