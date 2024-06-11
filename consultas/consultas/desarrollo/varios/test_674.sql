declare
 nuValor number;
 
 cursor cuServsusc is
 select *
 from open.servsusc
 where sesunuse=52399619;
 
 cursor cuSolicitud is
 select request_date
 from mo_packages
 where package_id=186491943;
 
 NUCONCEPT number:=674;
 RCSERVSUSC cuServsusc%rowtype;
 DTREQUESTDATE date;
 NUPACKAGEID number:=186491943;
 nuorden number:=246607380;
 
 onuFinanId number;

begin
  open cuServsusc;
  fetch cuServsusc into RCSERVSUSC;
  close  cuServsusc;
  
  open cuSolicitud;
  fetch cuSolicitud into DTREQUESTDATE;
  close cuSolicitud;
 
  nuValor:=CC_BOREQUESTCHARGES.GETREQUESTBASICCHARGE
                (
              RCSERVSUSC.SESUNUSE,
              RCSERVSUSC.SESUSERV,
              RCSERVSUSC.SESUDEPA,
              RCSERVSUSC.SESULOCA,
              RCSERVSUSC.SESUCATE,
              RCSERVSUSC.SESUSUCA,
              RCSERVSUSC.SESUPLFA,
              NUCONCEPT,
              DTREQUESTDATE);
  dbms_output.put_line(nuValor);
  
  "OPEN".PKERRORS.SETAPPLICATION('CUSTOMER');
  
   "OPEN".PKCHARGEMGR.GENERATECHARGE(INUNUMESERV  => RCSERVSUSC.SESUNUSE,
                                      INUCUCOCODI  => -1,
                                      INUCONCCODI  => NUCONCEPT,
                                      INUCAUSCARG  => 53,
                                      IONUCARGVALO => nuValor,
                                      ISBCARGSIGN  => 'DB',
                                      ISBCARGDOSO  => 'PP-' || NUPACKAGEID,
                                      ISBCARGTIPR  => 'A',
                                      INUCARGCODO  => nuorden,
                                      INUCARGUNID  => 1,
                                      INUCARGCOLL  => null,
                                      INUSESUCARG  => null,
                                      IBOKEEPTIPR  => true,
                                      IDTCARGFECR  => sysdate);
  CC_BOACCOUNTS.GENERATEACCOUNTBYPACK(NUPACKAGEID);
  
  
  FI_BOFINANCVENTAPRODUCTOS.FINANCIARFACTURAVENTA(NUPACKAGEID, onuFinanId);
end;
/

select cargos.*,
       (select cucofact from cuencobr where cucocodi=cargcuco)
from open.cargos 
inner join concepto on conccodi=cargconc
where cargnuse=52399619
and cargfecr>='29/10/2022';

select *
from diferido
where difenuse=52399619;
select MO_BOPACKAGEPAYMENT.FNUGETACCOUNTBYPACKAGE( 186491943 ) from dual;
