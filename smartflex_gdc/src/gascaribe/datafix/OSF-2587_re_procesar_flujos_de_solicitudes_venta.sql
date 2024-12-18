column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  DECLARE
      nuErrorCode NUMBER;
      sbErrorMessage VARCHAR2(4000);

      cursor cuDatos is
      select d.package_id,  i.instance_id
      from open.wf_data_external d
      inner join open.wf_instance i on i.plan_id=d.plan_id and i.unit_type_id=100221 and status_id=4
      where d.package_id in (210996876,
  210996975,
  210997151,
  210996915,
  210997270,
  210996969,
  210997117,
  210997352,
  210996966,
  210997362,
  210996747,
  210996753,
  210997304,
  210997228,
  210997100,
  210997189,
  210997389,
  210997219,
  210997238,
  210997806,
  210997809,
  210997822,
  210997875,
  210997864,
  210997585,
  210997712,
  210997550,
  210997461,
  210997736,
  210997603,
  210997569,
  210997886,
  210997502,
  210997692,
  210997424,
  210996934,
  210997312,
  210997043,
  210997260,
  210997344,
  210997280,
  210996777,
  210997014,
  210996771,
  210996760,
  210996748,
  210997131,
  210997325,
  210997172,
  210997347,
  210996943,
  210997249,
  210996926,
  210997759,
  210997561,
  210997750,
  210997491,
  210997478,
  210997629,
  210997675,
  210997464,
  210997446,
  210997427,
  210997724,
  210997471,
  210997957,
  210997816,
  210997947,
  210997904,
  210997794,
  210997929,
  210997537,
  210997890,
  210997634,
  210997301,
  210996998,
  210997276,
  210997768,
  210997085,
  210997894,
  210996995,
  210996730,
  210996766,
  210996952,
  210996728,
  210996757,
  210996990,
  210996727,
  210997076,
  210997565,
  210997789,
  210997828,
  210997687,
  210997784,
  210997509,
  210997619,
  210997840,
  210997484,
  210997574,
  210997936,
  210997337,
  210997157,
  210997192,
  210997292,
  210997409,
  210996731,
  210997419,
  210997075,
  210997321,
  210997367,
  210996782,
  210996765,
  210997019,
  210997378,
  210997534,
  210996899,
  210997663,
  210997224,
  210996885,
  210997113,
  210997852,
  210996889,
  210997145,
  210997951,
  210997498,
  210997606,
  210997742,
  210997003,
  210997235,
  210997520,
  210997898,
  210997128,
  210997582,
  210997186,
  210997286,
  210997595,
  210997847,
  210997107,
  210997680,
  210997434,
  210997213,
  210997353,
  210997334,
  210997160,
  210997030,
  210997451,
  210997543,
  210996732,
  210997729,
  210996895,
  210997371,
  210997437,
  210997046,
  210997063,
  210996785,
  210997670,
  210997704,
  210997754,
  210997836,
  210997922,
  210997937,
  210996920,
  210996958,
  210996979,
  210997179,
  210997204,
  210997401,
  210997415,
  210997033,
  210997056,
  210997059,
  210997093,
  210997122,
  210996788,
  210996791,
  210997615,
  210997644,
  210997650,
  210997658,
  210997698,
  210997717,
  210997772,
  210997777,
  210997843,
  210997911,
  210996729,
  210996726,
  210996774,
  210996935,
  210996911,
  210997208,
  210997253);

  BEGIN
      dbms_output.put_line('Solicitud|Error');

      for reg in cuDatos loop
        begin
          errors.Initialize;
          ut_trace.Init;
          ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
          ut_trace.SetLevel(0);
          ut_trace.Trace('INICIO');

          --se notifican las ventas que tienen todas sus ordenes legalizadas, para que continuen
          WF_BOAnswer_Receptor.AnswerReceptor(reg.instance_id, MO_BOCausal.fnuGetSuccess);

          commit;
          dbms_output.put_line(reg.package_id  ||'|'|| 'ok');
      Exception
        When others then
          Errors.setError;
          Errors.getError(nuErrorCode, sbErrorMessage);
          dbms_output.put_line(reg.package_id  ||'|'|| 'fail');
        End;
      end loop;

  EXCEPTION
      when ex.CONTROLLED_ERROR  then
          Errors.getError(nuErrorCode, sbErrorMessage);
          dbms_output.put_line('ERROR CONTROLLED ');
          dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
          dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

      when OTHERS then
          Errors.setError;
          Errors.getError(nuErrorCode, sbErrorMessage);
          dbms_output.put_line('ERROR OTHERS ');
          dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
          dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
  END;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/