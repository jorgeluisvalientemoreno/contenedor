PL/SQL Developer Test script 3.0
66
declare
				Inuopeuniterp_Id   NUMBER(15);
				Osbrequestsregs    VARCHAR2(32000);
				Onuerrorcode       NUMBER(15);
        OSBERRORMESSAGE    ge_error_log.description%TYPE;
        doc                DBMS_XMLDOM.DOMDocument;
        ndoc               DBMS_XMLDOM.DOMNode;
        docelem            DBMS_XMLDOM.DOMElement;
        node               DBMS_XMLDOM.DOMNode;
        childnode          DBMS_XMLDOM.DOMNode;
        Nodelist           Dbms_Xmldom.Domnodelist;
        Buf                Varchar2(2000);
        ITEMS_DOCUMENTO_ID number(15);
        Contador           Number(10);
        Osbrequest         Varchar2(32000);
        Nuoperunitid       Number;
        Nuerpoperunitid    Number;
        --Dtdate             date;
        Docitem            Dbms_Xmldom.Domdocument;
        Ndocitem           Dbms_Xmldom.Domnode;
        Docelemitem        Dbms_Xmldom.Domelement;
        Nodeitem           Dbms_Xmldom.Domnode;
        Nuitemid           Number(15);
        Sbitemcode         Varchar2(60);
        Sbitemdesc         Varchar2(100);
        Nuitemcant         number;
        Nuitemcosto        Number;
        Nuclassitem        Number;
        sbFlagHta          varchar2(1);
        oclXMLItemsData    CLOB;
        Nodelistitem       Dbms_Xmldom.Domnodelist;
        Bufitem            Varchar2(32767);
        contadorItem       Number(10);
        Nodelisteleitem    Dbms_Xmldom.Domnodelist;
        nodedummy          Dbms_Xmldom.Domnode;
        onuProcCodi        NUMBER;
        icbProcPara        CLOB;
        cursor cuUnidadOperativa Is
                Select OPERATING_UNIT_ID, OPER_UNIT_CODE
                    From OR_OPERATING_UNIT
                    Where OPER_UNIT_CLASSIF_ID = 11;

        reUnidadOperativa cuUnidadOperativa%rowtype;

        -- cursor de las solicitudes
        cursor cuREQUEST_REG(clXML in CLOB) is
          SELECT REQUEST.*
          FROM XMLTable('/REQUESTS_REG/ITEMS_DOCUMENTO_ID' PASSING XMLType(clXML)
                        COLUMNS
                        ITEMS_DOCUMENTO_ID NUMBER PATH '.'
                       ) AS REQUEST;


begin
  for reUnidadOperativa in cuUnidadOperativa loop
          -- carga las solicitudes
          OS_GET_REQUESTS_REG(reUnidadOperativa.OPERATING_UNIT_ID,
                              OSBREQUESTSREGS,
                              ONUERRORCODE,
                              OSBERRORMESSAGE);
          For reREQUEST_REG in cuREQUEST_REG(OSBREQUESTSREGS) loop
              Items_Documento_Id := reREQUEST_REG.ITEMS_DOCUMENTO_ID;
              dbms_output.put_line(Items_Documento_Id);              
          end loop;
  end loop;
end;
0
0
