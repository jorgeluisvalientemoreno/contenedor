Prompt Creando sinonimos privados para sobre adm_person.pkg_pagos
BEGIN
    -- OSF-3893
    pkg_Utilidades.prCrearSinonimos(upper('pkg_pagos'), upper('adm_person'));
END;
/