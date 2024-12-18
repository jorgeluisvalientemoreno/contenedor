CREATE OR REPLACE PROCEDURE  FIX_CICLOS_INDUSTRIAS
AS

CURSOR cususcripc
is
SELECT susccodi
FROM suscripc, servsusc
WHERE susccodi=sesususc
AND susccicl=113
AND sesucate=3;


BEGIN

    for r in  cususcripc
    loop
        UPDATE suscripc SET susccicl=136 WHERE susccodi= r.susccodi;
        commit;
        UPDATE servsusc SET sesucicl=136, sesucico = 136 WHERE sesususc= r.susccodi;
        commit;
    END loop;

END;
/
