--424511
select * from (SELECT  --+ index_desc (fa_histcodi IX_FA_HISTCODI01)
                    a.*
            FROM    fa_histcodi a
            WHERE a.hicdunop is not null and a.hicdcore is null and a.hicdfebl is null/* and a.hicdobse = 'asignar'*/) a1
            where 
            a1.hicdunop >= 4021 --in (4021,4022)
            --and hicdtico = inuTipocomp
            --AND     hicdnume = inuNumero;
