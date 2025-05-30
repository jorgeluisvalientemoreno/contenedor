select gi.*,rowid from open.ge_items gi where gi.items_id in (100009108,100009109,100009111,100009112); 
select gi.*,rowid from open.ge_items gi where gi.items_id in (100009106,100009107,100009113,100009114); 
select ott.*,rowid from open.or_task_type ott where ott.task_type_id in (11216,11217,11407,11408);--12982
select ott.*,rowid from open.or_task_type ott where ott.task_type_id in (11214,11215,11409,11410);--12982
select max(gi.items_id) from open.ge_items gi; 
select max(ott.task_type_id) from open.or_task_type ott;
