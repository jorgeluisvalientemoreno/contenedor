--Set Serveroutput On;
Declare
Inuopeuniterp_Id Number(15) := -1;
Osbrequestsregs clob;
Osbrequestsregs1 clob;
osbErrorMessage varchar2(2000);
Onuerrorcode Number(15);

Begin 
  --  ejecución en base de datos de desarrollo
  --LDCI_PKRESERVAMATERIAL.proNotificaDocumentosERP;
  --SetSystemEnviroment;
  -- ejecuciçpn en base de datos de calidad
  /*"OPEN".*/LDCI_PKRESERVAMATERIAL.proNotificaDocumentosERP;
  --"OPEN".LDCI_PKRESERVAMATERIAL.proNotificaDevoluciones;  
  
  DBMS_OUTPUT.PUT_LINE('Error: ' ||  ONUERRORCODE || ' | ' ||  OSBERRORMESSAGE);
  
End;
/
