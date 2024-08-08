declare
        nuExecutable sa_executable.executable_id%type;
        sbExecutable varchar2(4000);        
begin
    select executable_id
     into nuExecutable
    from sa_executable
   where name='LDCREVPM';

   SELECT extract(f.app_xml,'//APPLICATION/EXECUTABLE_ID/text()')||''
      into sbExecutable
        FROM OPeN.GE_DISTRIBUTION_FILE f
        WHERE distribution_file_id='LDCREVPM';
   if to_char(nuExecutable)!=sbExecutable then
     UPDATE OPeN.GE_DISTRIBUTION_FILE
           SET APP_XML=UPDATEXML(APP_XML, '//APPLICATION/EXECUTABLE_ID/text()',to_char(nuExecutable))
        WHERE distribution_file_id='LDCREVPM'
        ;
        UPDATE OPeN.GE_DISTRIBUTION_FILE
           SET APP_XML=UPDATEXML(APP_XML, '//COMPOSITION/EXTERNAL_TYPE_ID/text()',to_char(nuExecutable))
        WHERE distribution_file_id='LDCREVPM'
        ;
        UPDATE OPeN.GE_DISTRIBUTION_FILE
           SET APP_XML=UPDATEXML(APP_XML, '//COMPOSITION/EXTERNAL_ID/text()',to_char(nuExecutable))
        WHERE distribution_file_id='LDCREVPM'
        ;
        UPDATE OPeN.GE_DISTRIBUTION_FILE
           SET APP_XML=UPDATEXML(APP_XML, '//COMPOSITION/ATTRIBUTE/EXTERNAL_TYPE_ID/text()',to_char(nuExecutable))
        WHERE distribution_file_id='LDCREVPM'
        ;
		commit;
		dbms_output.put_line('ACTUALIZADO CORRECTAMENTE.');
   end if;
exception
  when others then 
       rollback;
       dbms_output.put_line('error'||sqlerrm);
end;
/
        


