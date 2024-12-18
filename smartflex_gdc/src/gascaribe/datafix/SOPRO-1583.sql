BEGIN
    --package
    update "OPEN".mo_packages set attention_date = sysdate, motive_status_id = 14 where package_id in (179600537);
    update mo_component set attention_date = sysdate, motive_status_id = 23 where package_id in (179600537);
    update MO_MOTIVE set attention_date = sysdate, status_change_date = sysdate, motive_status_id = 11 where package_id in (179600537);

    update "OPEN".mo_packages set attention_date = sysdate, motive_status_id = 14 where package_id in (175268419);
    update mo_component set attention_date = sysdate, motive_status_id = 23 where package_id in (175268419);
    update MO_MOTIVE set attention_date = sysdate, status_change_date = sysdate, motive_status_id = 11 where package_id in (175268419);

     update "OPEN".mo_packages set attention_date = sysdate, motive_status_id = 14 where package_id in (174504280);
    update mo_component set attention_date = sysdate, motive_status_id = 23 where package_id in (174504280);
    update MO_MOTIVE set attention_date = sysdate, status_change_date = sysdate, motive_status_id = 11 where package_id in (174504280);

    COMMIT;
 END;
/
