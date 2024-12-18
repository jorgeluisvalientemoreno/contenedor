column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  onuErrorCode    number;
  osbErrorMessage varchar2(4000);

  -- Local variables here
  cursor cuDATAPNO is
   select 221868564 ot_padre, 223323141 ot_hija from dual union all
  select 221868572 ot_padre, 223323144 ot_hija from dual union all
  select 221868584 ot_padre, 223323143 ot_hija from dual union all
  select 222196293 ot_padre, 225125163 ot_hija from dual union all
  select 222779207 ot_padre, 223810348 ot_hija from dual union all
  select 222779280 ot_padre, 224144370 ot_hija from dual union all
  select 222779299 ot_padre, 224134391 ot_hija from dual union all
  select 223671588 ot_padre, 225159575 ot_hija from dual union all
  select 225261912 ot_padre, 226616479 ot_hija from dual union all
  select 227726836 ot_padre, 229933210 ot_hija from dual union all
  select 230511587 ot_padre, 231806677 ot_hija from dual union all
  select 230511719 ot_padre, 231812423 ot_hija from dual union all
  select 230511758 ot_padre, 231816676 ot_hija from dual union all
  select 235226838 ot_padre, 236049534 ot_hija from dual union all
  select 235226859 ot_padre, 236050175 ot_hija from dual union all
  select 245503193 ot_padre, 252941878 ot_hija from dual union all
  select 249702987 ot_padre, 293257066 ot_hija from dual union all
  select 252756326 ot_padre, 292004473 ot_hija from dual union all
  select 255424727 ot_padre, 263787718 ot_hija from dual union all
  select 257061581 ot_padre, 289430858 ot_hija from dual union all
  select 257349682 ot_padre, 280020174 ot_hija from dual union all
  select 257546653 ot_padre, 280632439 ot_hija from dual union all
  select 258281487 ot_padre, 292359359 ot_hija from dual union all
  select 269495719 ot_padre, 291682759 ot_hija from dual union all
  select 274397556 ot_padre, 292816710 ot_hija from dual union all
  select 275194010 ot_padre, 290410155 ot_hija from dual union all
  select 276726642 ot_padre, 291959561 ot_hija from dual union all
  select 279650297 ot_padre, 289430536 ot_hija from dual union all
  select 280521452 ot_padre, 290668338 ot_hija from dual union all
  select 280521463 ot_padre, 293580305 ot_hija from dual union all
  select 280537903 ot_padre, 290409535 ot_hija from dual union all
  select 280537982 ot_padre, 293512223 ot_hija from dual union all
  select 280537996 ot_padre, 290911662 ot_hija from dual union all
  select 280538237 ot_padre, 292250192 ot_hija from dual union all
  select 280775090 ot_padre, 280775098 ot_hija from dual union all
  select 281296599 ot_padre, 290916420 ot_hija from dual union all
  select 281350840 ot_padre, 291481317 ot_hija from dual union all
  select 283718460 ot_padre, 290533377 ot_hija from dual union all
  select 283718493 ot_padre, 289431436 ot_hija from dual union all
  select 284258736 ot_padre, 290533434 ot_hija from dual union all
  select 284374728 ot_padre, 291414796 ot_hija from dual union all
  select 284376839 ot_padre, 293749483 ot_hija from dual union all
  select 284625518 ot_padre, 291495903 ot_hija from dual union all
  select 284789608 ot_padre, 290668457 ot_hija from dual union all
  select 285765069 ot_padre, 291908214 ot_hija from dual union all
  select 286502544 ot_padre, 291341133 ot_hija from dual union all
  select 288660543 ot_padre, 293149475 ot_hija from dual union all
  select 288897869 ot_padre, 290409410 ot_hija from dual union all
  select 289256235 ot_padre, 291340585 ot_hija from dual union all
  select 289264480 ot_padre, 290409272 ot_hija from dual union all
  select 289678950 ot_padre, 291264578 ot_hija from dual union all
  select 289982552 ot_padre, 290526578 ot_hija from dual union all
  select 289984917 ot_padre, 290896623 ot_hija from dual union all
  select 290408317 ot_padre, 290863380 ot_hija from dual union all
  select 290411937 ot_padre, 291435504 ot_hija from dual union all
  select 290685494 ot_padre, 291621880 ot_hija from dual union all
  select 291618987 ot_padre, 291800438 ot_hija from dual union all
  select 291626799 ot_padre, 292589959 ot_hija from dual union all
  select 291798617 ot_padre, 292001612 ot_hija from dual union all
  select 292000874 ot_padre, 293151148 ot_hija from dual union all
  select 292057781 ot_padre, 292096864 ot_hija from dual union all
  select 292250236 ot_padre, 293154611 ot_hija from dual union all
  select 292256279 ot_padre, 292564049 ot_hija from dual union all
  select 293059342 ot_padre, 293249616 ot_hija from dual union all
  select 293395667 ot_padre, 293613579 ot_hija from dual;
  
  rfcuDATAPNO cuDATAPNO%rowtype;

begin

  -- Test statements here
  --dbms_output.put_line('Tipo|Contrato|Producto|Solicitud|Estado_Solicitud|OT_PNO|Tipo_Trabajo|Estado_Orden|Causal_Legalizacion');
  for rfcuDATAPNO in cuDATAPNO loop
  
    begin
      api_related_order(rfcuDATAPNO.ot_padre,
                        rfcuDATAPNO.ot_hija,
                        onuErrorCode,
                        osbErrorMessage);
      if onuErrorCode = 0 then
        commit;
        dbms_output.put_line('Ok. Relacionar la OT ' ||
                             rfcuDATAPNO.ot_padre || ' con la OT ' ||
                             rfcuDATAPNO.ot_hija);
      else
        rollback;
        dbms_output.put_line('No se pudo relacionar la OT ' ||
                             rfcuDATAPNO.ot_padre || ' con la OT ' ||
                             rfcuDATAPNO.ot_hija ||
                             ' con error ' || osbErrorMessage);
      
      end if;
    end;
  
  end loop;

end;

/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/