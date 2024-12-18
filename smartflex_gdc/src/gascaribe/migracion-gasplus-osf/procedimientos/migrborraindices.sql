CREATE OR REPLACE procedure      migrborraindices is
SBSQL VARCHAR2(800);
cursor  idx (tables varchar2) is select index_name from user_indexes where table_name=tables;
type vector is varray(200) of varchar(30);
tablas vector;
begin
     tablas := vector('CONSSESU','LECTELME','CARGOS','MOVIDIFE','CUPON','PAGOS');
     for i in 1..tablas.count loop
         FOR J IN IDX(tablas(i)) LOOP
             SBSQL:='DROP INDEX '||J.INDEX_NAME;
             BEGIN
                  execute immediate sbsql;
             EXCEPTION
                  WHEN OTHERS THEN
                       NULL;
             END;
         END LOOP;
     END LOOP;
end; 
/
