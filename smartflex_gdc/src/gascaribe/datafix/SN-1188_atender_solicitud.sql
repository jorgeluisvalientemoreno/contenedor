BEGIN
    --package
    update "OPEN".mo_packages set attention_date = sysdate, motive_status_id = 14 where package_id in (119565379);
    update mo_component set attention_date = sysdate, motive_status_id = 23 where package_id in (119565379);
    update MO_MOTIVE set attention_date = sysdate, status_change_date = sysdate, motive_status_id = 11 where package_id in (119565379);

    COMMIT;
 END;
/
