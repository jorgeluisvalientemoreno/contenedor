column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_inicio from dual;

declare

  --Tabla PL que llevara el regisdtro de JOBs creados
  TYPE TYTRCSOLICITUDES IS RECORD(
    SOLICITUD        NUMBER,
    CANTIDAD_ORDENES NUMBER);

  TYPE tbltytSolicitudes IS TABLE OF TYTRCSOLICITUDES INDEX BY BINARY_INTEGER;

  V_TYTRCSOLICITUDES     TYTRCSOLICITUDES;
  V_TYTRCSOLICITUDESnull TYTRCSOLICITUDES;
  tbSolicitudes          tbltytSolicitudes;

  TYPE tytbSusc IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
  tbSusc tytbSusc;

  cursor cuSolicitudesVentas is
    select count(1) Cantidad_ordenes, mp.package_id Solicitud
      from open.mo_packages mp
      left join open.or_order_activity ooa
        on ooa.package_id = mp.package_id
      left join open.or_order oo
        on oo.order_id = ooa.order_id
     where mp.package_type_id = 323
       and mp.motive_status_id = 13
       and mp.package_id in (176206149,
                             181826330,
                             175228757,
                             178000631,
                             174904643,
                             174893704,
                             177151552,
                             175314496,
                             183165271,
                             189563328,
                             176697204,
                             176516823,
                             176202504,
                             177730556,
                             176783988,
                             176206141,
                             177730476,
                             178141442,
                             178213914,
                             176404913,
                             179760009,
                             180031043,
                             178599734,
                             179080527,
                             178836754,
                             176339488,
                             180122496,
                             179772348,
                             180529329,
                             180258121,
                             186304794,
                             179564810,
                             182099615,
                             182136595,
                             180969726,
                             180817036,
                             180902919,
                             186811545,
                             174538386,
                             183800007,
                             182636491,
                             184452142,
                             183007532,
                             183006410,
                             189889905,
                             183164834,
                             184499586,
                             185904580,
                             184078434,
                             184224743,
                             184774135,
                             183165099,
                             183298489,
                             194065261,
                             194194969,
                             190546173,
                             185033861,
                             185280342,
                             185314842,
                             194368425,
                             185175524,
                             185409327,
                             186411354,
                             188699402,
                             186577400,
                             185656378,
                             186117774,
                             186941307,
                             186692900,
                             187061657,
                             186715913,
                             187231620,
                             186720384,
                             186740198,
                             186805443,
                             191030783,
                             187917867,
                             190499453,
                             187609761,
                             189554700,
                             188501765,
                             190033313,
                             203292460,
                             188723076,
                             185596665,
                             190645038,
                             188403015,
                             183308985,
                             189262105,
                             180096702,
                             189349426,
                             189780414,
                             189495322,
                             183000986,
                             189354989,
                             189022402,
                             190210888,
                             192024730,
                             187626444,
                             189985765,
                             189051233,
                             190501765,
                             190147145,
                             190016167,
                             183799745,
                             188757464,
                             180095740,
                             190200929,
                             186304647,
                             190686635,
                             190693973,
                             191037305,
                             190694186,
                             191084645,
                             190752887,
                             185890574,
                             183548550,
                             182219074,
                             190541875,
                             191645343,
                             191454110,
                             183799546,
                             191226013,
                             190263018,
                             192079862,
                             192028549,
                             194533704,
                             192843976,
                             192790886,
                             192483462,
                             192546153,
                             193638382,
                             189593158,
                             193125608,
                             192844118,
                             193185071,
                             193798094,
                             192980100,
                             193568017,
                             194171509,
                             185318391,
                             194363503,
                             194380218,
                             194363561,
                             188194601,
                             192283560,
                             194855829,
                             187890112,
                             194825000,
                             191628089,
                             184224811,
                             195028197,
                             188198596,
                             192616388,
                             194831746,
                             196110115,
                             196014667,
                             196891333,
                             197165944,
                             195390433,
                             196505852,
                             195634397,
                             195377220,
                             187578605,
                             192970403,
                             194855323,
                             194828248,
                             197400101,
                             178237836,
                             197399572,
                             199768407,
                             197702969,
                             198837749,
                             197974171,
                             195160412,
                             202551324,
                             199237665,
                             198130480,
                             197721438,
                             198867258,
                             197049356,
                             198888652,
                             199110672,
                             201111752,
                             194066594,
                             198046028,
                             199947301,
                             199923950,
                             199962065,
                             199630784,
                             201410043,
                             200566759,
                             201643344,
                             201428139,
                             190656698,
                             202366205,
                             190820647,
                             196604951,
                             198134848,
                             203360962,
                             201975403,
                             202090943,
                             193206355,
                             201408498,
                             201483428,
                             204150734,
                             202678050,
                             203879724,
                             203753930,
                             203722330,
                             203818297,
                             204584188,
                             203879836,
                             204058619,
                             205076666,
                             204683177,
                             204868762,
                             205882028,
                             205978058,
                             204172968,
                             207385461,
                             207282357,
                             186601129,
                             205324480,
                             211007937,
                             208059142,
                             212552189,
                             210316380,
                             209565158,
                             211599692,
                             212446982,
                             190929760,
                             213437964,
                             201669771)
     group by mp.package_id;

  rfSolicitudesVentas cuSolicitudesVentas%rowtype;

  cursor cuTotalOrdenesFinalizadas(InuSolicitud number) is
    select count(1) Cantidad_legalizada, mp.package_id Solicitud
      from open.mo_packages mp
      left join open.or_order_activity ooa
        on ooa.package_id = mp.package_id
      left join open.or_order oo
        on oo.order_id = ooa.order_id
       and oo.order_status_id in (8, 12)
     where mp.package_type_id = 323
       and mp.motive_status_id = 13
       and mp.package_id = InuSolicitud
     group by mp.package_id;

  rfTotalOrdenesFinalizadas cuTotalOrdenesFinalizadas%rowtype;

  posicion number := 0;

  recorrer number := 0;

  dtFechaSistema date := sysdate;

  current_table_namevar MO_PACKAGE_CHNG_LOG.CURRENT_TABLE_NAME%type := 'MO_PACKAGES';
  current_event_idvar   MO_PACKAGE_CHNG_LOG.CURRENT_EVENT_ID%type := ge_boconstants.UPDATE_;
  current_even_descvar  MO_PACKAGE_CHNG_LOG.CURRENT_EVEN_DESC%type := 'UPDATE';
  o_motive_status_idvar MO_PACKAGE_CHNG_LOG.o_motive_status_id%TYPE;
  sbComment CONSTANT VARCHAR2(200) := 'SE ATIENDE SOLICITUD CON EL CASO OSF-2867';
  cust_care_reques_numvar MO_PACKAGE_CHNG_LOG.CUST_CARE_REQUES_NUM%type := null;
  package_type_idvar      MO_PACKAGE_CHNG_LOG.PACKAGE_TYPE_ID%type := null;
  package_idvar           MO_PACKAGE_CHNG_LOG.PACKAGE_ID%type := null;

begin

  tbSolicitudes.DELETE;
  V_TYTRCSOLICITUDES := V_TYTRCSOLICITUDESnull;

  for rfcuSolicitudesVentas in cuSolicitudesVentas loop
  
    V_TYTRCSOLICITUDES.SOLICITUD        := rfcuSolicitudesVentas.Solicitud;
    V_TYTRCSOLICITUDES.CANTIDAD_ORDENES := rfcuSolicitudesVentas.Cantidad_ordenes;
  
    tbSolicitudes(tbSolicitudes.COUNT + 1) := V_TYTRCSOLICITUDES;
  
  end loop;

  FOR indtbPr IN 1 .. tbSolicitudes.COUNT LOOP
  
    for rfTotalOrdenesFinalizadas in cuTotalOrdenesFinalizadas(tbSolicitudes(indtbPr).SOLICITUD) loop
    
      if tbSolicitudes(indtbPr)
       .CANTIDAD_ORDENES = rfTotalOrdenesFinalizadas.Cantidad_legalizada then
      
        begin
        
          update open.mo_packages mp
             set mp.motive_status_id = 14,
                 mp.attention_date   = dtFechaSistema
           where mp.package_id = tbSolicitudes(indtbPr).SOLICITUD
             and mp.motive_status_id = 13;
        
          update open.mo_motive mm
             set mm.motive_status_id   = 11,
                 mm.attention_date     = dtFechaSistema,
                 mm.status_change_date = dtFechaSistema
           where mm.package_id = tbSolicitudes(indtbPr).SOLICITUD
             and mm.motive_status_id = 1;
        
          -- Adiciona log de cambio de estado de la solicitud
          package_idvar           := tbSolicitudes(indtbPr).SOLICITUD;
          cust_care_reques_numvar := damo_packages.fsbgetcust_care_reques_num(package_idvar,
                                                                              null);
          package_type_idvar      := damo_packages.fnugetpackage_type_id(package_idvar,
                                                                         null);
          o_motive_status_idvar   := damo_packages.fnugetmotive_status_id(package_idvar,
                                                                          null);
        
          INSERT INTO MO_PACKAGE_CHNG_LOG
            (CURRENT_USER_ID,
             CURRENT_USER_MASK,
             CURRENT_TERMINAL,
             CURRENT_TERM_IP_ADDR,
             CURRENT_DATE,
             CURRENT_TABLE_NAME,
             CURRENT_EXEC_NAME,
             CURRENT_SESSION_ID,
             CURRENT_EVENT_ID,
             CURRENT_EVEN_DESC,
             CURRENT_PROGRAM,
             CURRENT_MODULE,
             CURRENT_CLIENT_INFO,
             CURRENT_ACTION,
             PACKAGE_CHNG_LOG_ID,
             PACKAGE_ID,
             CUST_CARE_REQUES_NUM,
             PACKAGE_TYPE_ID,
             O_MOTIVE_STATUS_ID,
             N_MOTIVE_STATUS_ID)
          VALUES
            (AU_BOSystem.getSystemUserID,
             AU_BOSystem.getSystemUserMask,
             ut_session.getTERMINAL,
             ut_session.getIP,
             ut_date.fdtSysdate,
             current_table_namevar,
             AU_BOSystem.getSystemProcessName,
             ut_session.getSESSIONID,
             current_event_idvar,
             current_even_descvar,
             ut_session.getProgram || '-' || SBCOMMENT,
             ut_session.getModule,
             ut_session.GetClientInfo,
             ut_session.GetAction,
             MO_BOSEQUENCES.fnuGetSeq_MO_PACKAGE_CHNG_LOG,
             package_idvar,
             cust_care_reques_numvar,
             package_type_idvar,
             13,
             14);
        
          commit;
          dbms_output.put_line('Se cambia estado de solicitud y motivo de la venta [' || tbSolicitudes(indtbPr).SOLICITUD || ']');
        exception
          when others then
            rollback;
            dbms_output.put_line('Error. No se cambia esatdo de solicitud y motivo de la venta [' || tbSolicitudes(indtbPr).SOLICITUD ||
                                 '] - ' || sqlerrm);
        end;
      
      end if;
    
    end loop;
  
  end loop;

end;
/

select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/