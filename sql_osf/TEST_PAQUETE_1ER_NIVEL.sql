BEGIN
    pkg_generapaqueten1.prcGenerar
    (
        isbTabla            => 'LOG_INFO_ADICIONAL_SOLICITUD',
        isbEsquemaTabla     => 'PERSONALIZACIONES',
        isbAutor            => 'jorge valiente',
        isbCaso             => 'OSF-3742',
        isbColsPseudoPK     => 'PACKAGE_ID,DATO_ADICIONAL'--,
        --iblGenGetxColumna   => TRUE,
        --iblGenUpdxColumna   => TRUE
    );
END;
