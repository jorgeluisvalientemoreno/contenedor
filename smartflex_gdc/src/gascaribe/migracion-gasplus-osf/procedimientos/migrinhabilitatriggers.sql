CREATE OR REPLACE procedure      migrinhabilitatriggers is
cursor  TRG (tables varchar2) is select TRIGGER_NAME from user_TRIGGERS where table_NAME=tables;
type vector is varray(200) of varchar(30);
tablas vector;
sbsql varchar2(800);
begin 
     tablas := vector('AB_BLOCK','PERIFACT','PERICOSE','PAGOS','SERVSUSC','AB_PREMISE','AB_ADDRESS','PR_SUBS_TYPE_PROD','GE_SUBSCRIBER','GE_SUBS_GENERAL_DATA','GE_SUBS_FAMILY_DATA','pr_subs_type_prod','GE_SUBS_WORK_RELAT','GE_SUBS_PHONE','GE_SUBS_REFEREN_DATA','LDC_PROTECCION_DATOS','GE_ITEMS','OR_OPE_UNI_ITEM_BALA','OR_ORDER_ACTIVITY','OR_EXTERN_SYSTEMS_ID','LD_QUOTA_BLOCK','LD_MANUAL_QUOTA','OR_ORDER','GE_ITEMS_SERIADO');
     FOR I IN 1..TABLAS.COUNT LOOP
         FOR J IN TRG(TABLAS(I)) LOOP
             sbsql:='alter trigger '||J.TRIGGER_NAME||'  disable';
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
