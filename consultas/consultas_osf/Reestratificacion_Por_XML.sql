declare
  api_xml_request  VARCHAR2(2000) := '';
  api_package_id   NUMBER;
  api_motive_id    NUMBER;
  api_errorcode    NUMBER := 0;
  api_errormessage VARCHAR2(2000) := '';
begin
  
  ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);
  api_xml_request := '
            <P_RE_ESTRATIFICACION_POR_XML_325 ID_TIPOPAQUETE="325">
                <CONTRACT>6044995</CONTRACT>
                <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID>
                <CONTACT_ID>504900</CONTACT_ID>
                <ADDRESS_ID>364892</ADDRESS_ID>
                <COMMENT_>Observación de Prueba</COMMENT_>
                <M_RE_ESTRATIFICACION_POR_XML_117>
                    <RESTRAT_RESOLUTION>SP-AE-0017</RESTRAT_RESOLUTION>
                    <NEW_CATEGORY_ID>2</NEW_CATEGORY_ID>
                    <NEW_SUBCATEGORY_ID>3</NEW_SUBCATEGORY_ID>
                    <NEW_CONTACT_ADDRESS>567802</NEW_CONTACT_ADDRESS>
                   <REQUIERE_RELIQUIDACION>Y</REQUIERE_RELIQUIDACION>
                </M_RE_ESTRATIFICACION_POR_XML_117>
            </P_RE_ESTRATIFICACION_POR_XML_325>';

  OS_REGISTERREQUESTWITHXML(api_xml_request,
                            api_package_id,
                            api_motive_id,
                            api_errorcode,
                            api_errormessage);

  dbms_output.put_line(api_package_id);
  dbms_output.put_line(api_motive_id);
  dbms_output.put_line(api_errorcode);
  dbms_output.put_line(api_errormessage);

end;
