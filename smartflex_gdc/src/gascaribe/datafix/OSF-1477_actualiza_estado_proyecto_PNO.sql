column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/

-- Created on 29/08/2023 by JORGE VALIENTE 
declare

  sbImprime     varchar2(4000);
  sbCadenaFinal varchar2(4000);
  sbCadenaPadre varchar2(4000);
  nuEstadoOTout number;
  Cantidad      number;

  -- Local variables here
  cursor cuDATAPNO is
    select ooa.subscription_id Contrato,
           ooa.product_id Producto,
           oo.order_id OT_Inicio_PNO,
           ooa.address_id codigo_direccon,
           oo.task_type_id || ' - ' ||
           (select a.description
              from open.or_task_type a
             where a.task_type_id = oo.task_type_id) Tipo_Trabajo,
           oo.order_status_id || ' - ' ||
           (select oos.description
              from open.or_order_status oos
             where oos.order_status_id = oo.order_status_id) Estado_Orden,
           oo.causal_id || ' - ' ||
           (select gc.description
              from open.ge_causal gc
             where gc.causal_id = oo.causal_id) Causal_Legalizacion,
           oo.created_date Fecha_Creacion,
           oo.legalization_date Fecha_Legalizacion,
           decode(fpn.comment_,
                  'GENERADO POR ACTIVDAD DE PNO POR CASO OSF-1426',
                  'S',
                  'N') Datafix,
           oo.order_status_id EstadoPNO,
           fpn.possible_ntl_id Proyecto,
           fpn.status Estado_Proyecto
      from open.or_order_activity ooa,
           open.or_order          oo,
           open.fm_possible_ntl   fpn
     where ooa.order_id = oo.order_id
       and oo.order_id = fpn.order_id
       and fpn.status in ('R', 'P')
       and fpn.register_date < '01/09/2023'
       and fpn.order_id not in (236174463,
                                244692497,
                                247024279,
                                254649705,
                                255424158,
                                255424233,
                                260802675,
                                263086452,
                                264926187,
                                267508338,
                                269673215,
                                270011435,
                                270334617,
                                270594767,
                                270736695,
                                271391900,
                                271570814,
                                271653996,
                                271654018,
                                271794240,
                                271817837,
                                271818022,
                                271968180,
                                272444309,
                                272721522,
                                272846600,
                                272848644,
                                272978749,
                                273082636,
                                273174622,
                                273348440,
                                273355520,
                                273356677,
                                273657016,
                                273744777,
                                273967591,
                                273975559,
                                273979055,
                                274325753,
                                274375248,
                                274399724,
                                274718741,
                                274728012,
                                274925282,
                                274927869,
                                275094590,
                                275335490,
                                275443766,
                                275751832,
                                277669177,
                                277752735,
                                277886707,
                                277887243,
                                278010967,
                                278020186,
                                278248728,
                                278256907,
                                278264505,
                                278341818,
                                278345340,
                                278351703,
                                278354209,
                                278356025,
                                278357411,
                                278357929,
                                278435190,
                                278438851,
                                278438929,
                                278619788,
                                278620439,
                                278729449,
                                278729478,
                                278849503,
                                278854286,
                                278854458,
                                278857769,
                                278864890,
                                278954088,
                                279088603,
                                279188581,
                                279197126,
                                279198441,
                                279481919,
                                279482418,
                                279646227,
                                279650297,
                                279763518,
                                279875977,
                                279879474,
                                279880042,
                                279941592,
                                280021770,
                                280021811,
                                280159570,
                                280390438,
                                280533630,
                                280997389,
                                281021506,
                                281021521,
                                281296599,
                                281350840,
                                281691118,
                                281691563,
                                281691654,
                                282024463,
                                282027723,
                                282189299,
                                282191624,
                                282286147,
                                282301912,
                                282301924,
                                282301957,
                                282411691,
                                282411743,
                                282413732,
                                282487402,
                                282488052,
                                284258736,
                                284374728,
                                284376839,
                                284625518,
                                284789608,
                                285765069,
                                286502544,
                                286768858,
                                288025695,
                                288167284,
                                288168122,
                                288176108,
                                288182876,
                                288185766,
                                288269630,
                                288274664,
                                288277861,
                                288279449,
                                288279665,
                                288319204,
                                288355525,
                                288355849,
                                288365395,
                                288365545,
                                288410497,
                                288410498,
                                288410899,
                                288418163,
                                288424687,
                                288435011,
                                288441614,
                                288523216,
                                288524700,
                                288526716,
                                288537786,
                                288540614,
                                288546100,
                                288547270,
                                288547546,
                                288547613,
                                288548361,
                                288555286,
                                288588109,
                                288588117,
                                288650657,
                                288653296,
                                288654713,
                                288655386,
                                288657810,
                                288660433,
                                288660543,
                                288660862,
                                288679760,
                                288682740,
                                288683828,
                                288754731,
                                288754803,
                                288761085,
                                288761474,
                                288763572,
                                288764909,
                                288788922,
                                288792179,
                                288893128,
                                288894117,
                                288895365,
                                288895473,
                                288895633,
                                288896312,
                                288896438,
                                288897029,
                                288897869,
                                288905196,
                                288906120,
                                288906446,
                                288906449,
                                288950930,
                                289067684,
                                289067848,
                                289070022,
                                289072156,
                                289072425,
                                289091643,
                                289091690,
                                289165650,
                                289165784,
                                289165851,
                                289165901,
                                289166151,
                                289166170,
                                289166741,
                                289256235,
                                289257111,
                                289260774,
                                289261211,
                                289264480,
                                289265124,
                                289265166,
                                289430844,
                                289430871,
                                289430873,
                                289430883,
                                289430884,
                                289431068,
                                289431090,
                                289431174,
                                289436691,
                                289436783,
                                289581101,
                                289584269,
                                289584714,
                                289585421,
                                289588958,
                                289590002,
                                289633423,
                                289678950,
                                289746673,
                                289762641,
                                289859438,
                                289900796,
                                289901209,
                                289982552,
                                289982845,
                                289984917,
                                289987566,
                                289987765,
                                290193921,
                                290199993,
                                290382102,
                                290408317,
                                290411937,
                                290412769,
                                290413865,
                                290527708,
                                290531200,
                                290533274,
                                290656372,
                                290656990,
                                290659869,
                                290664646,
                                290665823,
                                290667000,
                                290669089,
                                290675996,
                                290675998,
                                290676000,
                                290676006,
                                290676011,
                                290676013,
                                290685494,
                                290687325,
                                290780581,
                                290856931,
                                291098763,
                                291098862,
                                291103505,
                                291104444,
                                291138998,
                                291139003,
                                291167416,
                                291337484,
                                291414696,
                                291417919,
                                291417921,
                                291434850,
                                291449596,
                                291450966,
                                291456927,
                                291474775,
                                291492128,
                                291495790,
                                291545270,
                                291547264,
                                291547312,
                                291593283,
                                291593381,
                                291593841,
                                291617663,
                                291617776,
                                291617829,
                                291618987,
                                291626799,
                                291798617,
                                292000874,
                                292057781,
                                292250236,
                                292256279,
                                292741615,
                                292816571,
                                293059342,
                                293149653,
                                293253875)
    --order by fpn.order_id    
    ;

  rfcuDATAPNO cuDATAPNO%rowtype;

  cursor cuDATARelacionada1(InuOrden number) is
    select oro.related_order_id Orden_Hija,
           oo.task_type_id || ' - ' ||
           (select a.description
              from open.or_task_type a
             where a.task_type_id = oo.task_type_id) Tipo_Trabajo_Hija,
           oo.order_status_id || ' - ' ||
           (select oos.description
              from open.or_order_status oos
             where oos.order_status_id = oo.order_status_id) Estado_Orden_Hija,
           oo.causal_id || ' - ' ||
           (select gc.description
              from open.ge_causal gc
             where gc.causal_id = oo.causal_id) Causal_Legalizacion_Hija,
           oo.order_status_id Estado_orden,
           oo.legalization_date Fecha_Legalizacion_Hija,
           'S' Relacionada
      from open.or_order oo, open.or_related_order oro
     where oro.order_id = InuOrden
       and oo.order_id = oro.related_order_id;

  rfcuDATARelacionada1 cuDATARelacionada1%rowtype;

  cursor cuDATARelacionada2(InuOrden number) is
    select oro.related_order_id Orden_Hija,
           oo.task_type_id || ' - ' ||
           (select a.description
              from open.or_task_type a
             where a.task_type_id = oo.task_type_id) Tipo_Trabajo_Hija,
           oo.order_status_id || ' - ' ||
           (select oos.description
              from open.or_order_status oos
             where oos.order_status_id = oo.order_status_id) Estado_Orden_Hija,
           oo.causal_id || ' - ' ||
           (select gc.description
              from open.ge_causal gc
             where gc.causal_id = oo.causal_id) Causal_Legalizacion_Hija,
           oo.order_status_id Estado_orden,
           oo.legalization_date Fecha_Legalizacion_Hija,
           'S' Relacionada
      from open.or_order oo, open.or_related_order oro
     where oro.order_id = InuOrden
       and oo.order_id = oro.related_order_id;

  rfcuDATARelacionada2 cuDATARelacionada2%rowtype;

  cursor cuDATARelacionada3(InuOrden number) is
    select oro.related_order_id Orden_Hija,
           oo.task_type_id || ' - ' ||
           (select a.description
              from open.or_task_type a
             where a.task_type_id = oo.task_type_id) Tipo_Trabajo_Hija,
           oo.order_status_id || ' - ' ||
           (select oos.description
              from open.or_order_status oos
             where oos.order_status_id = oo.order_status_id) Estado_Orden_Hija,
           oo.causal_id || ' - ' ||
           (select gc.description
              from open.ge_causal gc
             where gc.causal_id = oo.causal_id) Causal_Legalizacion_Hija,
           oo.order_status_id Estado_orden,
           oo.legalization_date Fecha_Legalizacion_Hija,
           'S' Relacionada
      from open.or_order oo, open.or_related_order oro
     where oro.order_id = InuOrden
       and oo.order_id = oro.related_order_id;

  rfcuDATARelacionada3 cuDATARelacionada3%rowtype;

  cursor cuDATARelacionada4(InuOrden number) is
    select oro.related_order_id Orden_Hija,
           oo.task_type_id || ' - ' ||
           (select a.description
              from open.or_task_type a
             where a.task_type_id = oo.task_type_id) Tipo_Trabajo_Hija,
           oo.order_status_id || ' - ' ||
           (select oos.description
              from open.or_order_status oos
             where oos.order_status_id = oo.order_status_id) Estado_Orden_Hija,
           oo.causal_id || ' - ' ||
           (select gc.description
              from open.ge_causal gc
             where gc.causal_id = oo.causal_id) Causal_Legalizacion_Hija,
           oo.order_status_id Estado_orden,
           oo.legalization_date Fecha_Legalizacion_Hija,
           'S' Relacionada
      from open.or_order oo, open.or_related_order oro
     where oro.order_id = InuOrden
       and oo.order_id = oro.related_order_id;

  rfcuDATARelacionada4 cuDATARelacionada4%rowtype;

begin

  -- Test statements here
  --dbms_output.put_line('Tipo|Contrato|Producto|Solicitud|Estado_Solicitud|OT_PNO|Tipo_Trabajo|Estado_Orden|Causal_Legalizacion');
  for rfcuDATAPNO in cuDATAPNO loop
  
    sbCadenaFinal := null;
    sbCadenaPadre := null;
    nuEstadoOTout := null;
    sbImprime     := null;
    Cantidad      := 1;
  
    sbCadenaPadre :=  --'Padre' || '|' || 
     nvl(rfcuDATAPNO.Contrato, 0) || '|' ||
                     nvl(rfcuDATAPNO.Producto, 0) || '|' ||
                     rfcuDATAPNO.OT_Inicio_PNO || '|' ||
                     rfcuDATAPNO.Fecha_Creacion || '|' ||
                     rfcuDATAPNO.Fecha_Legalizacion || '|' ||
                     rfcuDATAPNO.Datafix || '|' || rfcuDATAPNO.Tipo_Trabajo || '|' ||
                     rfcuDATAPNO.Estado_Orden || '|' ||
                     rfcuDATAPNO.Causal_Legalizacion || '|';
  
    nuEstadoOTout := rfcuDATAPNO.EstadoPNO;
  
    open cuDATARelacionada1(rfcuDATAPNO.OT_Inicio_PNO);
    fetch cuDATARelacionada1
      into rfcuDATARelacionada1;
    if cuDATARelacionada1%found then
      sbCadenaFinal :=  --'Hija_' || Cantidad || '|' ||
       rfcuDATARelacionada1.Orden_Hija || '|' ||
                       rfcuDATARelacionada1.Tipo_Trabajo_Hija || '|' ||
                       rfcuDATARelacionada1.Estado_Orden_Hija || '|' ||
                       rfcuDATARelacionada1.Causal_Legalizacion_Hija || '|' ||
                       rfcuDATARelacionada1.Fecha_Legalizacion_Hija || '|' ||
                       rfcuDATARelacionada1.Relacionada || '|';
      Cantidad      := Cantidad + 1;
      nuEstadoOTout := rfcuDATARelacionada1.Estado_orden;
      ----Inicio Hijo nivel 2
      open cuDATARelacionada2(rfcuDATARelacionada1.Orden_Hija);
      fetch cuDATARelacionada2
        into rfcuDATARelacionada2;
      if cuDATARelacionada2%found then
        sbCadenaFinal := 'Hija_' || Cantidad || '|' ||
                         rfcuDATARelacionada2.Orden_Hija || '|' ||
                         rfcuDATARelacionada2.Tipo_Trabajo_Hija || '|' ||
                         rfcuDATARelacionada2.Estado_Orden_Hija || '|' ||
                         rfcuDATARelacionada2.Causal_Legalizacion_Hija || '|' ||
                         rfcuDATARelacionada2.Fecha_Legalizacion_Hija || '|' ||
                         rfcuDATARelacionada2.Relacionada || '|';
        Cantidad      := Cantidad + 1;
        nuEstadoOTout := rfcuDATARelacionada2.Estado_orden;
        ----Inicio Hijo nivel 3
        open cuDATARelacionada3(rfcuDATARelacionada2.Orden_Hija);
        fetch cuDATARelacionada3
          into rfcuDATARelacionada3;
        if cuDATARelacionada3%found then
          sbCadenaFinal := 'Hija_' || Cantidad || '|' ||
                           rfcuDATARelacionada3.Orden_Hija || '|' ||
                           rfcuDATARelacionada3.Tipo_Trabajo_Hija || '|' ||
                           rfcuDATARelacionada3.Estado_Orden_Hija || '|' ||
                           rfcuDATARelacionada3.Causal_Legalizacion_Hija || '|' ||
                           rfcuDATARelacionada3.Fecha_Legalizacion_Hija || '|' ||
                           rfcuDATARelacionada3.Relacionada || '|';
          Cantidad      := Cantidad + 1;
          nuEstadoOTout := rfcuDATARelacionada3.Estado_orden;
          ----Inicio Hijo nivel 4
          open cuDATARelacionada4(rfcuDATARelacionada3.Orden_Hija);
          fetch cuDATARelacionada4
            into rfcuDATARelacionada4;
          if cuDATARelacionada4%found then
            sbCadenaFinal := 'Hija_' || Cantidad || '|' ||
                             rfcuDATARelacionada4.Orden_Hija || '|' ||
                             rfcuDATARelacionada4.Tipo_Trabajo_Hija || '|' ||
                             rfcuDATARelacionada4.Estado_Orden_Hija || '|' ||
                             rfcuDATARelacionada4.Causal_Legalizacion_Hija || '|' ||
                             rfcuDATARelacionada4.Fecha_Legalizacion_Hija || '|' ||
                             rfcuDATARelacionada4.Relacionada || '|';
            Cantidad      := Cantidad + 1;
            nuEstadoOTout := rfcuDATARelacionada4.Estado_orden;
          end if;
          close cuDATARelacionada4;
          ----Fin Hijo nivel 4        
        end if;
        close cuDATARelacionada3;
        ----Fin Hijo nivel 3        
      end if;
      close cuDATARelacionada2;
      ----Fin Hijo nivel 2
    end if;
  
    close cuDATARelacionada1;
  
    if nuEstadoOTout = 12 or nuEstadoOTout = 8 then
    
      begin
        update open.FM_POSSIBLE_NTL
           set STATUS = 'N'
         where POSSIBLE_NTL_ID = rfcuDATAPNO.Proyecto
           and nvl(PRODUCT_ID, 0) = nvl(rfcuDATAPNO.Producto, 0)
           And ORDER_ID = rfcuDATAPNO.OT_Inicio_PNO;
      
        COMMIT;
        dbms_output.put_line('Proyecto PNO [' || rfcuDATAPNO.Proyecto ||
                             '] actualiza su estado de [' ||
                             rfcuDATAPNO.Estado_Proyecto ||
                             '] al nuevo estado [N]');
      exception
        when OTHERS then
          rollback;
        
          dbms_output.put_line('Error: Proyecto PNO [' ||
                               rfcuDATAPNO.Proyecto ||
                               '] No actualizo su estado de [' ||
                               rfcuDATAPNO.Estado_Proyecto ||
                               '] al nuevo estado [N]');
      end;
    
    end if;
  
  end loop;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/