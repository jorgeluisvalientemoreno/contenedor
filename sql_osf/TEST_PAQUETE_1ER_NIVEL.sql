BEGIN
    pkg_generapaqueten1.prcGenerar
    (
        isbTabla            => 'LDC_TIPOTRABADICLEGO',
        isbEsquemaTabla     => 'OPEN',
        isbAutor            => 'Jorge Valiente',
        isbCaso             => 'OSF-6047',
        isbColsPseudoPK     => 'TIPOTRABLEGO_ID,TIPOTRABADICLEGO_ID',
        iblGenGetxColumna   => TRUE,
        iblGenUpdxColumna   => FALSE
    );
END;
