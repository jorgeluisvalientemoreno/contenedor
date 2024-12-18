CREATE OR REPLACE FUNCTION adm_person.FNUGETNUMCUONEG (inuMetodo in number,
                                            inuOrden in number,
                                            inuSolicitud in number)return number is


nuCuotas                                    number;

begin
 if inuMetodo = 1 then -- por la orden de gestion
  begin
    SELECT  numerocuotas
       into nuCuotas
                 FROM (select xmltype (xml_solicitud) data
                         from LDCI_INFGESTOTMOV
                        where order_id = inuOrden
                          and rownum = 1 ) t,
                 XMLTABLE ('/OS_RegisterDebtFinancing'
                 PASSING t.data
                 COLUMNS numeroCuotas number PATH 'numeroCuotas');
   exception when others then
     nuCuotas := 0;
   end;
  elsif inuMetodo = 2 then -- por la solicitud de negociacion y la orden
   begin
    select fr.quotas_number
      into nuCuotas
      from cc_financing_request fr
     where fr.subscription_id = (select oa.subscription_id
                                   from or_order_activity oa
                                  where oa.order_id = inuOrden)
      and fr.package_id = inuSolicitud;
   exception when others then
     nuCuotas := 0;
   end;
  else -- por la solicitud de negociacion
    begin
     select fr.quotas_number
       into nuCuotas
       from cc_financing_request fr
      where fr.financing_request_id = inuSolicitud;
    exception when others then
      nuCuotas := 0;
    end;
  end if;
  return (nucuotas);
end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUGETNUMCUONEG', 'ADM_PERSON');
END;
/