BEGIN
    pkg_generapaqueten1.prcGenerar
    (
        isbTabla            => 'HICAESCO',
        isbEsquemaTabla     => 'OPEN',
        isbAutor            => 'Jorge Valiente',
        isbCaso             => 'OSF-4973',
        isbColsPseudoPK     => 'HCECNUSE,HCECSUSC,HCECSERV,HCECFECH',
        iblGenGetxColumna   => FALSE,
        iblGenUpdxColumna   => FALSE
    );
END;
