DECLARE
    clXml               clob;
    rcFile              dage_distribution_file.styGE_distribution_file;
BEGIN
    rcFile.distribution_file_id  := 'REST_SERVICES';
    rcFile.description           := 'REST Services for Web Apps';
    rcFile.file_version          := '1.0.0.0';
    rcFile.version_number        := 1;
    rcFile.file_name             := 'REST_SERVICES.sql';
    rcFile.md5_hash              := 'cb1942173abe78571184414dbb4ec7a2';
    rcFile.distri_group_id       := 8;

    dbms_lob.createtemporary(clXml, TRUE);
    dbms_lob.append(clXml, '<?xml version="1.0" encoding="UTF-8"?>
<SECURITYSERVICES>
  <APIS>
    <API>
      <NAME>openintl-api-pearc</NAME>
      <SERVICES>
        <SERVICE>
          <PATH>/v1/customs/pearc/minutes/{minute_id}</PATH>
          <METHOD>GET</METHOD>
        </SERVICE>
        <SERVICE>
          <PATH>/v1/customs/pearc/minutes</PATH>
          <METHOD>POST</METHOD>
        </SERVICE>
      </SERVICES>
      <SERVICE>
          <PATH>/v1/customs/pearc/products/{product_id}</PATH>
          <METHOD>GET</METHOD>
      </SERVICE>
      <SERVICE>
          <PATH>/v1/customs/pearc/clients/{document_no}</PATH>
          <METHOD>GET</METHOD>
      </SERVICE>
    </API>
  </APIS>
</SECURITYSERVICES>
');

    rcFile.app_xml := xmltype(clXml);
    dbms_lob.freetemporary(clXml);

    if (dage_distribution_file.fblExist(rcFile.distribution_file_id)) then
        dage_distribution_file.updRecord(rcFile);
    else
        dage_distribution_file.insRecord(rcFile);
    end if;

    commit;
EXCEPTION
	when others then
		rollback;
END;
