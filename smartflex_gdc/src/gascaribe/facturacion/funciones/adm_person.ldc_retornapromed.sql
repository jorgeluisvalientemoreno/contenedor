CREATE OR REPLACE FUNCTION adm_person.ldc_retornapromed (
    iene IN NUMBER,
    ifeb IN NUMBER,
    imar IN NUMBER,
    iabr IN NUMBER,
    imay IN NUMBER,
    ijun IN NUMBER,
    ijul IN NUMBER,
    iago IN NUMBER,
    isep IN NUMBER,
    ioct IN NUMBER,
    inov IN NUMBER,
    idic IN NUMBER
) RETURN NUMBER IS
 /**************************************************************************
  Autor       : John Jairo Jimienez imarimon
  Fecha       : 2013-08-29
  Descripcion : Gieneramos promedio para el reporte FRAP y FRAC
  Parametros Entrada
    nuano Año
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA           AUTOR               DESCRIPCION
   06/03/2024      Paola Acosta        OSF-2104: Se agregan permisos para REXEREPORTES por solicitud de CGonzalez
   28/02/2024      Paola Acosta        OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON  
 ***************************************************************************/

    nuconta NUMBER(4) DEFAULT 0;
    nusuma  NUMBER(15, 2) DEFAULT 0;
    prome   NUMBER(13, 2) DEFAULT 0;
BEGIN
    nuconta := 0;
    nusuma := 0;
    prome := 0;
    IF iene > 0 THEN
        nuconta := nuconta + 1;
        nusuma := nusuma + iene;
    END IF;

    IF ifeb > 0 THEN
        nuconta := nuconta + 1;
        nusuma := nusuma + ifeb;
    END IF;

    IF imar > 0 THEN
        nuconta := nuconta + 1;
        nusuma := nusuma + imar;
    END IF;

    IF iabr > 0 THEN
        nuconta := nuconta + 1;
        nusuma := nusuma + iabr;
    END IF;

    IF imay > 0 THEN
        nuconta := nuconta + 1;
        nusuma := nusuma + imay;
    END IF;

    IF ijun > 0 THEN
        nuconta := nuconta + 1;
        nusuma := nusuma + ijun;
    END IF;

    IF ijul > 0 THEN
        nuconta := nuconta + 1;
        nusuma := nusuma + ijul;
    END IF;

    IF iago > 0 THEN
        nuconta := nuconta + 1;
        nusuma := nusuma + iago;
    END IF;

    IF isep > 0 THEN
        nuconta := nuconta + 1;
        nusuma := nusuma + isep;
    END IF;

    IF ioct > 0 THEN
        nuconta := nuconta + 1;
        nusuma := nusuma + ioct;
    END IF;

    IF inov > 0 THEN
        nuconta := nuconta + 1;
        nusuma := nusuma + inov;
    END IF;

    IF idic > 0 THEN
        nuconta := nuconta + 1;
        nusuma := nusuma + idic;
    END IF;

    IF nuconta > 0 THEN
        prome := nusuma / nuconta;
    ELSE
        prome := 0;
    END IF;

    RETURN round(nvl(prome, 0), 0);
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END ldc_retornapromed;
/

BEGIN
    pkg_utilidades.praplicarpermisos('LDC_RETORNAPROMED', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON adm_person.ldc_retornapromed TO REXEREPORTES;
/