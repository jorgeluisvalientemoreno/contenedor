SELECT  rtrim (xmlagg (xmlelement (e,phone || ' - ')).extract ('//text()'), ' - ')  Telefonos
            FROM
            (
                 SELECT  subscriber_id, phone
                 FROM    open.ge_subscriber
                 WHERE   subscriber_id = 403658
                 UNION ALL
                 SELECT  ge.subscriber_id, ph.phone
                 FROM    open.ge_subscriber ge, open.ge_subs_phone ph
                 WHERE   ge.subscriber_id = ph.subscriber_id
                 AND ge.subscriber_id = 403658
            )
           GROUP BY subscriber_id;
        