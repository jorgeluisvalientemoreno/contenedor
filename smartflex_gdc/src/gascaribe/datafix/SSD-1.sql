BEGIN
    update MO_PACKAGES set attention_date = sysdate, motive_status_id = 14 where package_id in (
        194101711,
        192695604,
        186107257,
        185393680,
        174190171,
        180118597,
        191116700
    );
    update MO_MOTIVE set attention_date = sysdate, status_change_date = sysdate, motive_status_id = 11 where package_id in (
        194101711,
        192695604,
        186107257,
        185393680,
        174190171,
        180118597,
        191116700
    );
    update mo_component set attention_date = sysdate, motive_status_id = 23 where MOTIVE_ID in (
        65777469,
        70255176,
        74244475,
        74783066,
        78678173,
        79905434,
        81194107
    );

    COMMIT;

EXCEPTION
    WHEN others THEN
        ROLLBACK;
END;
/
