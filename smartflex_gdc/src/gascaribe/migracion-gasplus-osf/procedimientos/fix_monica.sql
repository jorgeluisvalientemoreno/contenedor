CREATE OR REPLACE PROCEDURE FIX_MONICA AS
cursor us is select * from servsusc where sesunuse in
 (14575,56180,381825,452036,459822,459926,460686,460687,
578814,591873,605528,638905,688281,688282,855853,855854,895146,
895149,937880,937886,946091,946095) ;
BEGIN
    for u in us loop
        delete FROM open.pr_component_link
               WHERE parent_component_id in (select component_id
                                                    FROM open.pr_component
                                                    WHERE component_type_ID=7039 AND
                                                          component_status_id=5 AND
                                                          product_id=u.sesunuse);

       delete FROM open.pr_component_link
              WHERE child_component_id in (select component_id
                                                  FROM open.pr_component
                                                  WHERE component_type_ID=7039 AND
                                                        component_status_id=5 AND
                                                        product_id=u.sesunuse);
        delete from elmesesu where emsssesu=u.sesunuse and emssfere='01/01/4731';
        update elmesesu set emssfere='01/01/4731' where emsssesu=u.sesunuse;
        delete FROM open.pr_component WHERE component_type_ID=7039 AND
               component_status_id=5 AND product_id=u.sesunuse;
        update open.pr_component SET component_status_id=5
               WHERE component_type_ID=7039 AND component_status_id=9 AND
               product_id=u.sesunuse;
        delete FROM open.compsesu WHERE CMSSTCOM=7039 AND
               CMSSESCM=5 AND CMSSSESU=u.sesunuse;
        update open.COMPSESU SET CMSSESCM=5
               WHERE CMSSTCOM=7039 AND CMSSESCM=9 AND
               CMSSSESU=u.sesunuse;
    end loop;
    update lectelme set leemelme=707040,LEEMCMSS=1080511 where leemsesu=280142;
    update conssesu set cosselme=707040,cosscmss=1080511 where cosssesu=280142;

    update lectelme set leemelme=155731,LEEMCMSS=251317 where leemsesu=414938;
    update conssesu set cosselme=155731,cosscmss=251317 where cosssesu=414938;

    UPDATE ELMESESU SET EMSSFERE=SYSDATE-365 WHERE EMSSELME IN (155758,936792);
    UPDATE ELMESESU SET EMSSFEIN=SYSDATE-364 WHERE EMSSELME=155731;

    UPDATE ELMESESU SET EMSSFERE=SYSDATE-365 WHERE EMSSELME IN (935632,935633);
    UPDATE ELMESESU SET EMSSFEIN=SYSDATE-364 WHERE EMSSELME=707040;
    COMMIT;

END FIX_MONICA;
/
