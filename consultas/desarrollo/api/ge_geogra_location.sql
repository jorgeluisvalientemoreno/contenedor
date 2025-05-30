OS_INSGEOGRAPLOCATION@smartflex(un_Nombre, -- Nombre de la ubicacion
                              nuIdParent, -- Area Padre: Una Localidad
                              4, -- Tipo de area: 4 = Sector Operativo
                              'Y', -- Assing Level
                              'Y', -- Normalized
                              null, --id oper sector
                              NULL,
                              NULL,
                              NULL,
                              NULL,
                              NULL,
                              NULL, --
                              NULL, -- shape
                              nuid, -- Id de la nueva ubicacion creada
                              nuError,
                              sbError -- Errores
                              );
11:07
OS_CREATE_OPER_SECTOR@smartflex(nuId,
                          un_Nombre, -- Nombre de la ubicacion
                          inuClassifOperSector,
                          isbShape,
                          nuError,
                          sbError);