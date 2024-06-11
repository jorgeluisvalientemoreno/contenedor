declare
        INUORDERID         OPEN.OR_ORDER.ORDER_ID%TYPE:=&orden;
        ONUCONTRACTORID    OPEN.GE_CONTRATO.ID_CONTRATISTA%TYPE;
        ONUCONTRACTID      OPEN.GE_CONTRATO.ID_CONTRATO%TYPE;
    

        NUOPERUNIT          OPEN.OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE;
        NUTASKTYPE          OPEN.OR_ORDER.TASK_TYPE_ID%TYPE;

        TBCONTRACTS     OPEN.DAGE_CONTRATO.TYTBGE_CONTRATO;

        NUINDICE        NUMBER;

        DTDATE          DATE;

        DTLEGALDATE      OPEN.OR_ORDER.LEGALIZATION_DATE%TYPE;

    BEGIN

        ONUCONTRACTID:= NULL;

        
        begin
		select contractor_id 
		  into ONUCONTRACTORID
		 from open.or_operating_unit u, open.or_order o
		 where u.operating_unit_id=o.operating_unit_id
		   and o.order_id=INUORDERID;
		END;

        
        NUTASKTYPE := 12587;--OPEN.DAOR_ORDER.FNUGETTASK_TYPE_ID(INUORDERID);

        
        DTLEGALDATE := OPEN.DAOR_ORDER.FDTGETLEGALIZATION_DATE(INUORDERID);



        
        DTLEGALDATE := NVL(DTLEGALDATE, "OPEN".UT_DATE.FDTSYSDATE);


        
        "OPEN".CT_BCCONTRACT.GETOPENACTIVECONTRACTS
        (
            ONUCONTRACTORID,
            DTLEGALDATE,
            TBCONTRACTS
        );

        IF (TBCONTRACTS.COUNT = 0) THEN
            dbms_output.put_line('ENTRO 1 TBCONTRACTS.COUNT = 0');
            "OPEN".CT_BCCONTRACT.GETACTIVECONTRACTS
            (
                ONUCONTRACTORID,
                DTLEGALDATE,
                TBCONTRACTS
            );
       END IF;

        
        IF TBCONTRACTS.COUNT > 0 THEN
            dbms_output.put_line('ENTRO 2 TBCONTRACTS.COUNT');
            
            NUINDICE := TBCONTRACTS.FIRST;
            
            
            LOOP
                dbms_output.put_line('ENTRO 3 TBCONTRACTS(NUINDICE).ID_CONTRATO'||TBCONTRACTS(NUINDICE).ID_CONTRATO);
                IF  OPEN.CT_BCCONTRACT.FBLHASCONTRACTTASKTYPES(TBCONTRACTS(NUINDICE).ID_CONTRATO) AND
                    TBCONTRACTS(NUINDICE).STATUS != OPEN.CT_BOCONSTANTS.FSBGETCLOSEDSTATUS()
                THEN
                    dbms_output.put_line('ENTRO 4 TOPEN.CT_BCCONTRACT.FBLHASCONTRACTTASKTYPES(TBCONTRACTS(NUINDICE).ID_CONTRATO)=Y');
                    IF OPEN.CT_BCCONTRACT.FBLAPPLYCONTBYTASKTYPE( TBCONTRACTS(NUINDICE).ID_CONTRATO, NUTASKTYPE) THEN
                        
                        ONUCONTRACTID := TBCONTRACTS(NUINDICE).ID_CONTRATO;
						            DBMS_OUTPUT.PUT_LINE(ONUCONTRACTID);
                        RETURN;
                    END IF;
                
                ELSIF OPEN.CT_BCCONTRACT.FBLHASCONTTYPETASKTYPES(TBCONTRACTS(NUINDICE).ID_TIPO_CONTRATO) AND
                      TBCONTRACTS(NUINDICE).STATUS != OPEN.CT_BOCONSTANTS.FSBGETCLOSEDSTATUS()
                THEN
                    
                    IF OPEN.CT_BCCONTRACT.FBLAPPLYCONTTYPEBYTSKTYPE(TBCONTRACTS(NUINDICE).ID_TIPO_CONTRATO,NUTASKTYPE) THEN
                        
                        ONUCONTRACTID := TBCONTRACTS(NUINDICE).ID_CONTRATO;
						DBMS_OUTPUT.PUT_LINE(ONUCONTRACTID);
                        RETURN;
                    END IF;
                ELSE
                    IF ONUCONTRACTID IS NULL THEN
                        
                        ONUCONTRACTID := TBCONTRACTS(NUINDICE).ID_CONTRATO;
						DBMS_OUTPUT.PUT_LINE(ONUCONTRACTID);
                    END IF;

                END IF;

                
                NUINDICE := TBCONTRACTS.NEXT(NUINDICE);
                
                IF NUINDICE IS NULL THEN EXIT; END IF;
            END LOOP;

        END IF;


    EXCEPTION
        WHEN "OPEN".EX.CONTROLLED_ERROR THEN
            "OPEN".ERRORS.SETERROR;
            RAISE "OPEN".EX.CONTROLLED_ERROR;
    END GETCONTRACTTOLIQORDER;


    







