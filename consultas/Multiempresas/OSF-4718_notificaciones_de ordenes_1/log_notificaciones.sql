--log_notificaciones
SELECT notification_id, MAX(date_) date_
FROM ge_notification_log
WHERE notification_id IN (
            SELECT notification_id
            FROM ge_notification
            WHERE xsl_template_id IN (2321, 2320, 2319,2061, 2021))
GROUP BY notification_id;

/*100471
100153
100472
100193
100473*/
