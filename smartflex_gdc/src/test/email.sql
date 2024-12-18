declare
  req   utl_http.req;
  resp  utl_http.resp;
  value varchar2(1024);
  content varchar2(4000) := '{ "recipients": "rebratt@gascaribe.com", "text": "Correo desde QH", "html": "<b>QH</b> Este es un correo !", "subject": "Asunto de Prueba QH" }';
begin
  req := utl_http.begin_request('http://servicio.gascaribe.com/general/notification/email', 'POST');
  utl_http.set_header(req, 'content-type', 'application/json');
  utl_http.set_header(req, 'content-length', length(content));
  utl_http.write_text(req, content);
  resp := utl_http.get_response(req);
  loop
    utl_http.read_line(resp, value, true);
    dbms_output.put_line(value);
  end loop;
  utl_http.end_response(resp);
exception
  when utl_http.end_of_body then
    utl_http.end_response(resp);
end;

/

