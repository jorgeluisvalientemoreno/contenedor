BEGIN
    pkg_generapaqueten1.prcGenerar
    (
        isbTabla            => 'CONF_ASIG_CAMBIO_USO',
        isbEsquemaTabla     => 'OPEN',
        isbAutor            => 'Jorge Valiente',
        isbCaso             => 'OSF-4545',
        --isbColsPseudoPK     => 'PACKAGE_ID,DATO_ADICIONAL'--,
        iblGenGetxColumna   => TRUE,
        iblGenUpdxColumna   => TRUE
    );
END;
