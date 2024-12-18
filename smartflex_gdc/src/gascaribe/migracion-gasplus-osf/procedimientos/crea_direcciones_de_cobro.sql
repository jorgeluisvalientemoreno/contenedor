CREATE OR REPLACE procedure      Crea_direcciones_de_cobro  (NUMINICIO number, numFinal number,inudatabase number)
AS
cursor cudico
is
select susccodi, suscdico, basedato from ldc_temp_suscripc_sge where basedato=inudatabase
and suscdico is not null;

nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuComplementoDI  number;
sbdepa  varchar2(200);
sbloca  varchar2(200);
sbdir varchar2(200);
onuErrorCode number;
    vfecha_ini             DATE;
    vfecha_fin             DATE;
    vcont                  NUMBER := 0;
    vcontLec               NUMBER := 0;
    vcontIns               NUMBER := 0;
    Verror                 Varchar2 (4000);
    Sbdocumento            Varchar2(30) := Null;
    nuDocumento            number(15);
    nuLog                  number;
    nuIndex                numbeR;
    nuestate_number        NUMBER;
    nuLogErrorPro number;
    nuProceso   number := 6501;
    nuLogError number;
    osbErrorMessage varchar2(2000);
    onuParserId number;
    osbAddressParsed varchar2(2000);
    osbsuccessmessage varchar2(2000);

    cursor culocalidad(nucodidepa number,nucodiloca number)
    is
    select colohomo
    from ldc_mig_localidad
    where codidepa=nucodidepa
    and codiloca=nucodiloca;
    nulocaosf number;

    CURSOR cuFatherAddress(nuaddressid number)
    is
    SELECT *
    FROM ab_address
    WHERE address_id=  nuaddressid;

    nupremise number;
BEGIN

    PKLOG_MIGRACION.prInsLogMigra (nuProceso,nuProceso,1,'Crea_direcciones_de_cobro_GNCV',0,0,'Finaliza Proceso','FIN',nuLogError);
    pkg_constantes.COMPLEMENTO(inudatabase,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);

    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inudatabase AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=6501;
  
    for r in cudico
    loop
    
    begin
           sbdepa:= ut_string.fsbsubstr(r.suscdico,1,  INSTR2(r.suscdico, '|',1,1)-1);
           sbloca:= ut_string.fsbsubstr(r.suscdico,INSTR2(r.suscdico, '|',1,1)+1, INSTR2(r.suscdico, '|',1,2)-INSTR2(r.suscdico, '|',1,1)-1);
           sbdir:=ut_string.fsbsubstr(r.suscdico,INSTR2(r.suscdico, '|',1,2)+1,ut_string.fnulength(r.suscdico));
           --dbms_output.put_line(sbdepa);
           --dbms_output.put_line(sbloca);
           --dbms_output.put_line(sbdir);

           open culocalidad(to_number(sbdepa),to_number(sbloca));
           fetch culocalidad into nulocaosf;
           close culocalidad;
            
           if  nulocaosf is not null  then 
            --dbms_output.put_line(nulocaosf);
            AB_BsADDRESSPARSER.insertaddressonnotfound
            (
             nulocaosf,
              sbdir,
             onuParserId,
             osbAddressParsed,
             osbsuccessmessage,
             onuerrorcode,
             osberrormessage,
             null,
             'Y'
             );
            commit;


            -- Validacion de Error en Urbano
            if nvl(onuParserId,0) <> -1 and ONUERRORCODE = 0 then

                vcontIns := vcontIns + 1;
                select estate_number into nuestate_number from ab_address where  address_id =onuParserId;

                begin
                        SELECT  LDC_INFO_PREDIO_ID into nupremise FROM       LDC_iNFO_PREDIO WHERE  PREMISE_ID=nuestate_number;
                EXCEPTION
                   when no_data_found
                   then
                    nupremise:=null;
                   END;
                if nupremise IS null then
                            insert into LDC_iNFO_PREDIO (LDC_INFO_PREDIO_ID,PREMISE_ID,IS_ZONA,PORC_PENETRACION,MULTIVIVIENDA)
                            values (SEQ_LDC_INFO_PREDIO.nextval,nuestate_number,null, null,null);
                END if;

                commit;

                        UPDATE suscripc SET  susciddi=onuParserId WHERE susccodi=r.susccodi+nuComplementoSU;

                commit;
            
            ELSE
                
                osbErrorMessage:=NULL;
                onuParserId:=NULL;
                osbAddressParsed:=NULL;
                osbsuccessmessage:=NULL;
                                                           
                  AB_BSADDRESSPARSER.INSERTADDRESSONNOTFOUND ( 
             nulocaosf,
              sbdir,
             onuParserId,
             osbAddressParsed,
             osbsuccessmessage,
             onuerrorcode,
             osberrormessage,
             null,'N');
                                                             
                -- Validacion de Error en Urbano
                        if nvl(onuParserId,0) <> -1 and ONUERRORCODE = 0 then
                          
                            update Ab_address set is_urban='Y' where address_id=onuerrorcode;
                             UPDATE suscripc SET  susciddi=onuParserId WHERE susccodi=r.susccodi+nuComplementoSU;
                        
                         end if;
                        
                        
                
                         PKLOG_MIGRACION.prInsLogMigra ( nuProceso,nuProceso,2,'crea_direcciones_de_cobro',nuDocumento,vcontLec,'NO PARSEA Basedato ['||Inudatabase||'] Predcodi: ['||sbdepa||'-'||sbloca||'-'||nuDocumento||'] '||Osberrormessage,to_char(ONUERRORCODE),nuLogErrorPro);

                end if;

            
            end if;
             
             insert into migra.LDC_MIG_DIR_CUENCOBR values (r.susccodi,sbdir,sbdepa,sbloca,nulocaosf,r.basedato,onuParserId,null);

            commit;

    Exception
        when others then
        null;
         
    end;
    end loop;

        PKLOG_MIGRACION.prInsLogMigra (nuProceso,nuProceso,3,'Crea_direcciones_de_cobro_GNVC',0,0,'Finaliza Proceso','FIN',nuLogError);
        UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inudatabase AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=6501;
        commit;
   --DBms_output.PUT_LINE('TEST');
   --DBms_output.PUT_LINE(onuParserId);
   --DBms_output.PUT_LINE(osbAddressParsed);
   --DBms_output.PUT_LINE(osbsuccessmessage);
   --DBms_output.PUT_LINE(onuerrorcode);
   --DBms_output.PUT_LINE(osberrormessage);
END; 
/
