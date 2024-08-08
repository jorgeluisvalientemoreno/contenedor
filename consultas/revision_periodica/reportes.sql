SELECT Reinrepo ,
            reindes1 Entidad,
            REINVAL1 Producto,
            REINVAL2 MarcaAct,
            REINVAL3 MarcaSuspAct,
            REINVAL4 MarcaSuspPro,
            REINVAL5 inuMarcaRecoPro,
            REINVAL6 NuevaMarc,
            REINDES2 Accion,
            REINDES3 ActuaRe,
            REINDES4 isbActuaSu,
            REINDES5 isbActuaPr,
            REINDAT1
            FROM OPEN.REPOINCO WHERE REINREPO in (215453/*, 215452*/) --and reincodi>699460;
            --order by reincodi;
            and reindat1>='15/03/2018 16:17:24'
              AND not EXISTS(select prodcuto from open.ldc_usuarios_susp_y_noti where FLAG_NOTI_SUSP='S' AND REINVAL1=prodcuto)
