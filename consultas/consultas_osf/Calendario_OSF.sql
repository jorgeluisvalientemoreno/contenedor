SELECT  *--count(*)
    FROM    open.ge_calendar
    WHERE   TRUNC( ge_calendar.date_ ) > '31/03/2024'
    AND     TRUNC( ge_calendar.date_ ) <= '01/06/2024'   ;
