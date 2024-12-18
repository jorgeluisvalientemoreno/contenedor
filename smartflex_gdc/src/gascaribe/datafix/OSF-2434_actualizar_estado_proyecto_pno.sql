column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  cursor cuDATA is
    select 273744566 orden, 17023441  producto from dual union all 
    select 294249417 orden, 6103168  producto from dual union all 
    select 260058149 orden, 52401732  producto from dual union all 
    select 295308551 orden, 6511313  producto from dual union all 
    select 240028426 orden, 1026971  producto from dual union all 
    select 284294710 orden, 6526710  producto from dual union all 
    select 309339432 orden, 14505169  producto from dual union all 
    select 280537851 orden, 1151412  producto from dual union all 
    select 255988930 orden, 12001910  producto from dual union all 
    select 290270325 orden, 1508701  producto from dual union all 
    select 282415417 orden, 1005267  producto from dual union all 
    select 280521256 orden, 14521202  producto from dual union all 
    select 247641617 orden, 6612221  producto from dual union all 
    select 281692813 orden, 18000198  producto from dual union all 
    select 254119420 orden, 2063950  producto from dual union all 
    select 312883254 orden, 6525762  producto from dual union all 
    select 306420794 orden, 52444409  producto from dual union all 
    select 280538078 orden, 6121492  producto from dual union all 
    select 280539061 orden, 50129207  producto from dual union all 
    select 303938492 orden, 2056606  producto from dual union all 
    select 252255519 orden, 1087616  producto from dual union all 
    select 283718385 orden, 6519126  producto from dual union all 
    select 282015425 orden, 2076282  producto from dual union all 
    select 273488085 orden, 1026971  producto from dual union all 
    select 280995398 orden, 6120812  producto from dual union all 
    select 298541853 orden, 1053467  producto from dual union all 
    select 291404488 orden, 50022931  producto from dual union all 
    select 257349682 orden, 6633382  producto from dual union all 
    select 293144860 orden, 6529180  producto from dual union all 
    select 280521421 orden, 51496731  producto from dual union all 
    select 291992518 orden, 1503552  producto from dual union all 
    select 250548268 orden, 52292281  producto from dual union all 
    select 245503193 orden, 1013822  producto from dual union all 
    select 290196291 orden, 50604367  producto from dual union all 
    select 270747134 orden, 17161176  producto from dual union all 
    select 284894978 orden, 14525024  producto from dual union all 
    select 282415394 orden, 50280428  producto from dual union all 
    select 283668666 orden, 1166097  producto from dual union all 
    select 253803327 orden, 50133260  producto from dual union all 
    select 242644063 orden, 17027848  producto from dual union all 
    select 291991163 orden, 1136637  producto from dual union all 
    select 286314016 orden, 6513991  producto from dual union all 
    select 280387440 orden, 51801542  producto from dual union all 
    select 239072537 orden, 1020490  producto from dual union all 
    select 282415376 orden, 50117923  producto from dual union all 
    select 280386938 orden, 6623469  producto from dual union all 
    select 280521269 orden, 6592881  producto from dual union all 
    select 281469659 orden, 50593834  producto from dual union all 
    select 250753590 orden, 14506808  producto from dual union all 
    select 281021242 orden, 17040164  producto from dual union all 
    select 265041390 orden, 6122645  producto from dual union all 
    select 262856108 orden, 17026352  producto from dual union all 
    select 247925861 orden, 6111724  producto from dual union all 
    select 264202209 orden, 6609743  producto from dual union all 
    select 278646594 orden, 1123196  producto from dual union all 
    select 240745600 orden, 1103963  producto from dual union all 
    select 250547308 orden, 52292287  producto from dual union all 
    select 280521460 orden, 17080721  producto from dual union all 
    select 314633152 orden, 1145413  producto from dual union all 
    select 309404781 orden, 6523412  producto from dual union all 
    select 310005450 orden, 1506915  producto from dual union all 
    select 255424727 orden, 52340211  producto from dual union all 
    select 288545861 orden, 14509468  producto from dual union all 
    select 276543871 orden, 50042756  producto from dual union all 
    select 294326868 orden, 17037885  producto from dual union all 
    select 305944639 orden, 1095981  producto from dual union all 
    select 296624526 orden, 5061237  producto from dual union all 
    select 307621943 orden, 7056453  producto from dual union all 
    select 284296302 orden, 1042211  producto from dual union all 
    select 311135710 orden, 6617917  producto from dual union all 
    select 296386076 orden, 1702395  producto from dual union all 
    select 275095628 orden, 6096891  producto from dual union all 
    select 314902765 orden, 50262510  producto from dual union all 
    select 307099118 orden, 17093528  producto from dual union all 
    select 282415398 orden, 50280427  producto from dual union all 
    select 307870423 orden, 51473830  producto from dual union all 
    select 316027305 orden, 14525906  producto from dual union all 
    select 281695165 orden, 6045066  producto from dual union all 
    select 292743879 orden, 14522691  producto from dual union all 
    select 298351064 orden, 50618003  producto from dual union all 
    select 280903673 orden, 51667623  producto from dual union all 
    select 307499776 orden, 50880295  producto from dual union all 
    select 307866828 orden, 51694468  producto from dual union all 
    select 309342929 orden, 50357866  producto from dual union all 
    select 280521442 orden, 52158007  producto from dual union all 
    select 280537816 orden, 1022967  producto from dual union all 
    select 240574348 orden, 50034474  producto from dual union all 
    select 281876130 orden, 6615143  producto from dual union all 
    select 286027584 orden, 1187956  producto from dual union all 
    select 280521451 orden, 17117418  producto from dual union all 
    select 291784892 orden, 1190224  producto from dual union all 
    select 291992339 orden, 1503551  producto from dual union all 
    select 285748242 orden, 4064346  producto from dual union all 
    select 269797942 orden, 16000133  producto from dual union all 
    select 256166339 orden, 17166464  producto from dual union all 
    select 309339330 orden, 14524501  producto from dual union all 
    select 314951534 orden, 2070283  producto from dual union all 
    select 309367155 orden, 6623458  producto from dual union all 
    select 259898527 orden, 17124696  producto from dual union all 
    select 285071747 orden, 50074107  producto from dual union all 
    select 291679950 orden, 1035258  producto from dual union all 
    select 288754602 orden, 2077924  producto from dual union all 
    select 290980619 orden, 14502250  producto from dual union all 
    select 252331029 orden, 8089479  producto from dual union all 
    select 298562741 orden, 6084182  producto from dual union all 
    select 284889814 orden, 50099034  producto from dual union all 
    select 279085886 orden, 17024112  producto from dual union all 
    select 314676040 orden, 1051807  producto from dual union all 
    select 295518031 orden, 1031184  producto from dual union all 
    select 280538075 orden, 51967781  producto from dual union all 
    select 310336946 orden, 6570728  producto from dual union all 
    select 251356336 orden, 6562513  producto from dual union all 
    select 288657697 orden, 1013767  producto from dual union all 
    select 311563429 orden, 52240247  producto from dual union all 
    select 280521293 orden, 1051583  producto from dual union all 
    select 291785164 orden, 1118449  producto from dual union all 
    select 294150278 orden, 7058006  producto from dual union all 
    select 297958198 orden, 17049099  producto from dual union all 
    select 309367772 orden, 14520543  producto from dual union all 
    select 310015674 orden, 50314729  producto from dual union all 
    select 284886183 orden, 2014614  producto from dual union all 
    select 314533242 orden, 50684225  producto from dual union all 
    select 280521466 orden, 2018937  producto from dual union all 
    select 245511025 orden, 51532627  producto from dual union all 
    select 291790180 orden, 1117198  producto from dual union all 
    select 310132205 orden, 17090027  producto from dual union all 
    select 296048211 orden, 51790410  producto from dual union all 
    select 301956401 orden, 8085584  producto from dual union all 
    select 283386293 orden, 52059010  producto from dual union all 
    select 313458384 orden, 1502540  producto from dual union all 
    select 280521456 orden, 2066495  producto from dual union all 
    select 316026841 orden, 1186907  producto from dual union all 
    select 287104774 orden, 14506031  producto from dual union all 
    select 309795955 orden, 14521623  producto from dual union all 
    select 295347772 orden, 50021667  producto from dual union all 
    select 289977363 orden, 1162543  producto from dual union all 
    select 314486206 orden, 2066645  producto from dual union all 
    select 310780120 orden, 17001070  producto from dual union all 
    select 293746650 orden, 50911776  producto from dual union all 
    select 271994415 orden, 1066354  producto from dual union all 
    select 296386047 orden, 1182947  producto from dual union all 
    select 314892721 orden, 51372868  producto from dual union all 
    select 311520542 orden, 6607617  producto from dual union all 
    select 261165261 orden, 50492254  producto from dual union all 
    select 291991156 orden, 1000192  producto from dual union all 
    select 296045142 orden, 6514556  producto from dual union all 
    select 305781347 orden, 1019382  producto from dual union all 
    select 309398382 orden, 17011526  producto from dual union all 
    select 285879211 orden, 2060539  producto from dual union all 
    select 280538161 orden, 17101721  producto from dual union all 
    select 296386158 orden, 1182948  producto from dual union all 
    select 297569108 orden, 2056501  producto from dual union all 
    select 315450845 orden, 50880627  producto from dual union all 
    select 263475336 orden, 17151457  producto from dual union all 
    select 291622875 orden, 6509272  producto from dual union all 
    select 281021270 orden, 2060083  producto from dual union all 
    select 310679728 orden, 50945226  producto from dual union all 
    select 298800742 orden, 52210994  producto from dual union all 
    select 293395667 orden, 50044668  producto from dual union all 
    select 283718505 orden, 17089605  producto from dual union all 
    select 280538165 orden, 17035486  producto from dual union all 
    select 307621698 orden, 50319939  producto from dual union all 
    select 303558682 orden, 2056462  producto from dual union all 
    select 309710427 orden, 6518912  producto from dual union all 
    select 285718926 orden, 1163206  producto from dual union all 
    select 313631775 orden, 51932046  producto from dual union all 
    select 283718410 orden, 6634412  producto from dual union all 
    select 262201709 orden, 1099658  producto from dual union all 
    select 311426044 orden, 51281282  producto from dual union all 
    select 308494123 orden, 14518158  producto from dual union all 
    select 311519426 orden, 6519099  producto from dual union all 
    select 316735268 orden, 2074814  producto from dual union all 
    select 283718465 orden, 4068126  producto from dual union all 
    select 277997945 orden, 17114231  producto from dual union all 
    select 292057843 orden, 6602888  producto from dual union all 
    select 312141681 orden, 51887964  producto from dual union all 
    select 286768636 orden, 50682534  producto from dual union all 
    select 285235123 orden, 51686144  producto from dual union all 
    select 313451375 orden, 2064823  producto from dual union all 
    select 309391987 orden, 1506496  producto from dual union all 
    select 255098692 orden, 51540043  producto from dual union all 
    select 291679977 orden, 1191321  producto from dual union all 
    select 262043559 orden, 51381768  producto from dual union all 
    select 312045077 orden, 52470247  producto from dual union all 
    select 284589116 orden, 1702361  producto from dual union all 
    select 284292302 orden, 1061174  producto from dual union all 
    select 301004104 orden, 17019049  producto from dual union all 
    select 314488822 orden, 51170294  producto from dual union all 
    select 276335919 orden, 1169683  producto from dual union all 
    select 313481156 orden, 2056840  producto from dual union all 
    select 291991167 orden, 2064823  producto from dual union all 
    select 286096800 orden, 17020571  producto from dual union all 
    select 309367951 orden, 6509686  producto from dual union all 
    select 298958989 orden, 1015385  producto from dual union all 
    select 286370802 orden, 51834327  producto from dual union all 
    select 285358235 orden, 16002710  producto from dual union all 
    select 311750165 orden, 1071501  producto from dual union all 
    select 285917511 orden, 17147925  producto from dual union all 
    select 298676770 orden, 50219395  producto from dual union all 
    select 308693836 orden, 2085908  producto from dual union all 
    select 314902722 orden, 1191046  producto from dual union all 
    select 287064676 orden, 51739033  producto from dual union all 
    select 299178003 orden, 1068740  producto from dual union all 
    select 288338500 orden, 1188550  producto from dual union all 
    select 311429439 orden, 51373292  producto from dual union all 
    select 291992244 orden, 1503550  producto from dual union all 
    select 292737056 orden, 17017004  producto from dual union all 
    select 310783105 orden, 50026154  producto from dual union all 
    select 313037656 orden, 2078489  producto from dual;  

  rfcuDATA cuDATA%rowtype;

  cursor cuDATAPNO(nuProducto number, nuOrden number) is
    select fpn.possible_ntl_id, fpn.status, fpn.product_id
      from open.fm_possible_ntl fpn
     where fpn.product_id = nuProducto
       and fpn.order_id = nuOrden
       and fpn.status in ('R','P');

  rfcuDATAPNO cuDATAPNO%rowtype;

begin

  for rfcuDATA in cuDATA loop
    for rfcuDATAPNO in cuDATAPNO(rfcuDATA.Producto, rfcuDATA.Orden) loop
    
      begin
        update open.fm_possible_ntl fpn
           set fpn.status = 'N'
         where fpn.possible_ntl_id = rfcuDATAPNO.possible_ntl_id
           and fpn.product_id = rfcuDATAPNO.product_id;
      
        commit;
      
        dbms_output.put_line('Actualizar estado del proyecto PNO ' ||
                             rfcuDATAPNO.possible_ntl_id || ' de estado ' ||
                             rfcuDATAPNO.status ||
                             ' a un nuevo estado N del producto ' ||
                             rfcuDATAPNO.product_id);
      exception
        when others then
          rollback;
          dbms_output.put_line('Error al actualizar estado del proyecto PNO ' ||
                               rfcuDATAPNO.possible_ntl_id || ' de estado ' ||
                               rfcuDATAPNO.status ||
                               ' a un nuevo estado N del producto ' ||
                               rfcuDATAPNO.product_id);
      end;
    
    end loop;
  end loop;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

