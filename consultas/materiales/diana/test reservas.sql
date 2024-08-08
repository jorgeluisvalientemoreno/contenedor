declare
        Osbrequestsregs    VARCHAR2(32000);
        Onuerrorcode       NUMBER(15);
        OSBERRORMESSAGE    open.ge_error_log.description%TYPE;

        cursor cuUnidadOperativa Is
                Select OPERATING_UNIT_ID, OPER_UNIT_CODE
                    From open.OR_OPERATING_UNIT
                    Where OPER_UNIT_CLASSIF_ID = 11;

        reUnidadOperativa cuUnidadOperativa%rowtype;
        doc                DBMS_XMLDOM.DOMDocument;
				ndoc               DBMS_XMLDOM.DOMNode;
				docelem            DBMS_XMLDOM.DOMElement;
				node               DBMS_XMLDOM.DOMNode;
				childnode          DBMS_XMLDOM.DOMNode;
				Nodelist           Dbms_Xmldom.Domnodelist;
				Buf                Varchar2(4000);
				ITEMS_DOCUMENTO_ID number(15);
  Begin
    -- carga las variables requeridas para las solicitudes
    --"OPEN".proCargaVarGlobal('WS_RESERVA_MATERIALES');


    -- recorre las unidades operativas de tipo 17 - CUARDILLA
    for reUnidadOperativa in cuUnidadOperativa loop
        -- carga las solicitudes
        "OPEN".OS_GET_REQUESTS_REG(reUnidadOperativa.OPERATING_UNIT_ID,
                            OSBREQUESTSREGS,
                            ONUERRORCODE,
                            OSBERRORMESSAGE);

        dbms_output.put_line('UO: '||reUnidadOperativa.OPERATING_UNIT_ID||', CADENA: '||OSBREQUESTSREGS);
        
        doc     := DBMS_XMLDOM.newDOMDocument(Osbrequestsregs);
        ndoc    := DBMS_XMLDOM.makeNode(doc);

        Dbms_Xmldom.Writetobuffer(Ndoc, Buf);
        docelem := DBMS_XMLDOM.getDocumentElement(doc);

        -- Access element
        Nodelist := Dbms_Xmldom.Getelementsbytagname(Docelem, 'ITEMS_DOCUMENTO_ID');
        
    end loop;
    dbms_output.put_line('PROCESO TERMINO');
End;

