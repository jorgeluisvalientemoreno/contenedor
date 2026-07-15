 --order by feregistro desc 
102056
select * from LDC_CM_LECTESP where pefacodi= 102056 and sesunuse =50292733 order by feregistro desc 
--4293331778 
select * from or_order_items i where i.order_id= 321957010;
select * from LDC_CM_LECTESP_CICL
select * from pericose where pecscons = 102031
--update LDC_CM_LECTESP set felectura ='20/10/2022 08:00:00' where pefacodi=102056 and sesunuse=50292733 and consec_ext =25909609;

--update LDC_CM_LECTESP set observacion =79 where pefacodi=102056 and sesunuse=1000981 ;
--update LDC_CM_LECTESP set lectura =0 where pefacodi=102056 and sesunuse=1000981 ;

--delete from  LDC_CM_LECTESP_CRIT where sesunuse = 1999546 and pefacodi = 111366; 


/*insert into LDC_CM_LECTESP_CRIT_sil 
select * from LDC_CM_LECTESP_CRIT  l where pefacodi=111366 and sesunuse=1999546*/
select * from LDC_CM_LECTESP  l where procesado='N'
order by  feregistro desc 
select max(consec_ext) + 1 from LDC_CM_LECTESP


insert into LDC_CM_LECTESP 
select * from LDC_CM_LECTESP  where order_id = 263008586 for  update 

select * from LDC_CM_LECTESP_CRIT where pefacodi=111366 and sesunuse=1999546



























DECLARE
BEGIN
    DBMS_SCHEDULER.RUN_JOB ('REGISTRA_LECTESP_CRIT');
    COMMIT;
END;
