declare
 cursor cuBase is
 select a.product_id, min(o.legalization_date) fecha
from open.or_order o
inner join open.or_order_activity a on a.order_id=o.order_id
where o.task_type_id in (10444,10795)
  and o.order_status_id=8
  and o.causal_id=3602
  and o.legalization_Date>='21/02/2022'
  and o.legalization_date<'23/03/2022'
  and a.product_id in (6593636,6594385,6594055,6593467,6512346,20501320,20501342,50319271,50027989,50188889,50089952,50885050,51287118,50101307,6533792,6065387,50458980,20500839,51405816,6100565,50187845,6565316,50052466,51347142,20500503,20501016,6597150,1053569,6527966,6507126,14505125,50004797,6501487,2073006,1092378,8089492,6520143,14502791,14506136,6522727,6138948,50552853,51336055,1509143,14516569,6593784,1100263,6526880,51395415,17100434,51413547,6639425,6592968,6587188,6595112,6527061,6593786,6503270,6593499,14521741,6509803,4067397,14513879,51377707,6513408,6520218,6508309,6564410,14510448,51365788,6137574,1138003,50020693,16000352,51318518,14525266,6513039,1034729,1021414,6526096,6593475,13000999,51378435,6528735,6532309,6565970,6593862,14521716,19000978,51410753,20500193,20500456,20501082,20501595,6510783)

 group by a.product_id;
 
 
 cursor cuOrdenes(nuProducto number, dtFecha date) is
 select a.product_id, p.package_id, p.package_type_id, p.comment_,  o.order_id, o.task_type_id, o.created_date, o.legalization_Date, o.causal_id, (select description from open.ge_causal c where c.causal_id=o.causal_id) desc_caus, a.activity_id, (select description from open.ge_items i where i.items_id=a.activity_id) desc_item, o.charge_status, o.order_value,
        (select replace(replace(cc.order_comment,chr(10),' '),chr(13),'') from open.or_order_comment cc where cc.order_id=o.order_id and cc.legalize_comment='Y') coment_ot
from open.or_order_activity a 
inner join open.or_order o  on a.order_id=o.order_id and o.legalization_date>=dtFecha
inner join open.mo_packages p on p.package_id=a.package_id
where o.task_type_id in (10444,10450,10723,10833,10795,10834,10835,10836)
  and a.product_id=nuProducto 
order by a.product_id, p.package_id, o.order_id;
nuOt10444 number;
nuOt10795 number;
nuOtRepa number;
nuOtRecon number;
sbSuspension number;
sbReparo     number;
sbDescuenta varchar2(10000);
sbError     varchar2(10000);
sbReconex varchar2(10000);
begin
       for reg in cuBase loop
          nuOt10444 :=null;
          nuOt10795 :=null;
          nuOtRepa :=null;
          nuOtRecon :=null; 
          sbReparo := 0;
          sbDescuenta :=null;
          sbError :=null;
          sbReconex :=null;
         for reg2 in cuOrdenes(reg.product_id, reg.fecha ) loop
             
             if reg2.task_Type_id not in (10833) and sbSuspension = 1 then
               sbSuspension := 0;
             end if;
             if reg2.task_type_id = 10444 and reg2.causal_id= 3602 then
                nuOt10444 := reg2.order_id;  
             end if;
             if reg2.task_type_id = 10795 and reg2.causal_id= 3602 then
                nuOt10795 := reg2.order_id;  
             end if;
             if reg2.task_type_id= 10450 and (reg2.comment_ like '%'||nuOt10444||'%' or reg2.comment_ like '%'||nuOt10795||'%') then
               sbSuspension :=1;
             end if;
             
             if reg2.task_type_id = 10833 and reg2.causal_id in (9074, 3635 ) and sbSuspension = 1 then
               sbReparo :=1;
               nuOtRepa :=reg2.order_id;
             elsif reg2.task_type_id = 10833 and reg2.causal_id not in (9074, 3635 ) then
               sbError :=sbError||' Reparacion legalizada con causal '||reg2.causal_id||' '||reg2.coment_ot;
             end if;
             
             if reg2.task_type_id in (10834,10835,10836) and reg2.charge_status='3' and reg2.comment_ like '%'||nuOtRepa||'%' and sbReparo = 1 then
               sbDescuenta := reg2.product_id||'|'||reg2.order_id;
                dbms_output.put_line(sbDescuenta);
             elsif reg2.task_type_id in (10834,10835,10836) and reg2.charge_status='3' and reg2.comment_ like '%'||nuOtRepa||'%' and sbReparo != 1 then
                sbReconex:=sbReconex||'-'||reg2.order_id;
             end if;
         end loop;
         if sbDescuenta is null then
            dbms_output.put_line(reg.product_id||'|'||sbError||' Reconex '||sbReconex);
         end if;
       end loop;

end;
