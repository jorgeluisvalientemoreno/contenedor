Begin
    update suscripc
    set    suscmail = null
    where susccodi in (select p.susccodi from PERSONALIZACIONES.FE_BK_SUSCMAIL P);

    commit;
End;
/