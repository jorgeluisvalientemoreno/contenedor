PL/SQL Developer Test script 3.0
49
declare
  req utl_http.req;
  res utl_http.resp;
  url varchar2(4000) := 'https://rest.messagebird.com/messages';
  name varchar2(4000);
  buffer varchar2(4000); 
  content varchar2(4000) := 'recipients=573004722229&originator=YourName&shortcode=1008&body=This%20is%20a%20test%20message';
  
/*  content varchar2(4000):='''recipients'':''573004722229''
  ''originator'':''YourName''
  ''shortcode'':''1008''
  ''body'': ''prueba''';*/
  sbPathWallet LDCI_CARASEWE.CASEVALO%type;
  sbPasswordWallet VARCHAR2(100);
  sbSoapSuccess LDCI_CARASEWE.CASEVALO%type;
  sbMens VARCHAR2(1000);
 
begin
  --sbPathWallet:='file:/oraclesfqh/certificado/wallet';}
  sbPathWallet:='file:/oracle11_R24/app/oracle/11.2.0/db/owm/wallets/oracle';
  sbPasswordWallet:='gascaribe2022#';
  utl_http.set_wallet(sbPathWallet,sbPasswordWallet);
  req := utl_http.begin_request(url, 'POST',' HTTP/1.1');
  utl_http.set_header(req, 'user-agent', 'mozilla/4.0'); 
  --utl_http.set_header(req, 'content-type', 'application/json'); 
  utl_http.set_header(req, 'Content-Length', length(content));
  utl_http.set_header(req, 'Authorization', 'AccessKey 9IPyDl789PxHCG4MfKIiM76EQ');
 
  utl_http.set_header(req, 'Content-Type' ,'application/x-www-form-urlencoded');

  dbms_output.put_line(content); 
 
  utl_http.write_text(req, content);
  res := utl_http.get_response(req);
  dbms_output.put_line(res.status_code);
  -- process the response from the HTTP call
  begin
    loop
      utl_http.read_line(res, buffer);
      dbms_output.put_line(buffer);
    end loop;
    utl_http.end_response(res);
  exception
    when utl_http.end_of_body 
    then
      utl_http.end_response(res);
  end;
end 
;
0
0
