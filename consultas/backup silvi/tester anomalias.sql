declare
    tbAnomalias pkg_ANOMALIAS_PRODUCTO.tytbanomalias_producto;
    rcRegistro  pkg_ANOMALIAS_PRODUCTO.cuANOMALIAS_PRODUCTO%ROWTYPE;
begin
     tbAnomalias := pkg_bcanomalias.ftbObtieneAnomalias (1020253,40);

    if tbAnomalias.count > 0 then
        for i in tbAnomalias.first..tbAnomalias.last loop
            --Inactivación anomalías activas por tipo de anomalía
            tbAnomalias(i).activo := 'N';
            tbAnomalias(i).usuario := pkg_session.getUser;
            tbAnomalias(i).fecha_inactivacion := sysdate;
            pkg_ANOMALIAS_PRODUCTO.prActRegistroxRowId(tbAnomalias(i));

        end loop;
        commit;
    end if;
end;
