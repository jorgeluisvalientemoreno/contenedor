declare
        Osbrequestsregs    VARCHAR2(32000);
        Onuerrorcode       NUMBER(15);
        OSBERRORMESSAGE    open.ge_error_log.description%TYPE;

        cursor cuUnidadOperativa Is
                Select OPERATING_UNIT_ID, OPER_UNIT_CODE
                    From open.OR_OPERATING_UNIT
                    Where OPER_UNIT_CLASSIF_ID = 11
                    and operating_unit_id!=1774;

        reUnidadOperativa cuUnidadOperativa%rowtype;
        doc                DBMS_XMLDOM.DOMDocument;
				ndoc               DBMS_XMLDOM.DOMNode;
				docelem            DBMS_XMLDOM.DOMElement;
				node               DBMS_XMLDOM.DOMNode;
				childnode          DBMS_XMLDOM.DOMNode;
				Nodelist           Dbms_Xmldom.Domnodelist;
				Buf                Varchar2(4000);
        	Iclxmlsearchtransit   Clob;
          Oclxmltransititems    Clob;
				ITEMS_DOCUMENTO_ID number(15);
        sbreserva varchar2(4000);
        
 cursor cuTRANSIT_ITEM(clXML in CLOB) is
								SELECT ITEMS.*
										FROM XMLTable('/TRANSIT_ITEMS/ITEMS' PASSING XMLType(clXML)
												COLUMNS row_num for ordinality,
												        "ITEM_CODE"       NUMBER PATH 'ITEM_CODE',
																				"ITEM_ID"         NUMBER PATH 'ITEM_ID',
																				"ITEM_CLASSIF_ID"  NUMBER PATH 'ITEM_CLASSIF_ID',
																				"TRANSIT_QUANTITY" NUMBER PATH 'TRANSIT_QUANTITY',
																				"VALUE"           NUMBER PATH 'VALUE',
																				"DOCUMENT_ID"      NUMBER PATH 'DOCUMENT_ID',
																				"ORIG_OPER_UNIT"   NUMBER PATH 'ORIG_OPER_UNIT',
																				"TARG_OPER_UNIT"   NUMBER PATH 'TARG_OPER_UNIT') AS ITEMS;        
  Begin
    -- carga las variables requeridas para las solicitudes
    --"OPEN".proCargaVarGlobal('WS_RESERVA_MATERIALES');

     dbms_output.enable(NULL);
    -- recorre las unidades operativas de tipo 17 - CUARDILLA
    for reUnidadOperativa in cuUnidadOperativa loop
        Iclxmlsearchtransit := '<?xml version="1.0"?><SEARCH_TRANSIT_ITEM><OPERATING_UNIT>' || reUnidadOperativa.OPERATING_UNIT_ID ||'</OPERATING_UNIT></SEARCH_TRANSIT_ITEM>';
		-- carga las solicitudes
        "OPEN".OS_GET_TRANSIT_ITEM(ICLXMLSEARCHTRANSIT, OCLXMLTRANSITITEMS, ONUERRORCODE, OSBERRORMESSAGE);

        --dbms_output.put_line(' CADENA: '||OCLXMLTRANSITITEMS);
        for reTRANSIT_ITEM in cuTRANSIT_ITEM(oclXmltransititems) loop
          begin
            	Select DOTRDOCU
              into sbreserva
			        From open.LDCI_DOCUTRAN
			        Where DOTRDOCU = to_char(reTRANSIT_ITEM.document_id);
          exception
            when no_data_found then
              sbreserva:='0';
              dbms_output.put_line(reTRANSIT_ITEM.document_id);
              
          end;
          if sbreserva='0' then 
                    dbms_output.put_line(reTRANSIT_ITEM.document_id);
                    sbreserva:='1';
          end if;
        end loop;
        
    end loop;
    dbms_output.put_line('PROCESO TERMINO');
End;
