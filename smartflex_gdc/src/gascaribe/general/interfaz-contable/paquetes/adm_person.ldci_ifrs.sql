CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_IFRS AS
--{
    /*****************************************************************
    Propiedad intelectual de GDO. (c).

    Package	: LDCI_IFRS
    Descripción	: Realiza clonación de configuración de interfaz contable

    Autor	: Carlos Andrés Dominguez Naranjo - Cdominguez
    Fecha	: 21-03-2014

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
    -----------  -------------------    -------------------------------------

    ******************************************************************/

    --------------------------------------------------------------------
    -- Constantes
    --------------------------------------------------------------------
    --------------------------------------------------------------------
    -- Variables
    --------------------------------------------------------------------
    --------------------------------------------------------------------
    -- Cursores
    --------------------------------------------------------------------
    -----------------------------------
    -- Metodos publicos del package
    -----------------------------------

    -- Obtiene la Version actual del Paquete
    FUNCTION fsbVersion  return varchar2;

    PROCEDURE ClonaComprobanteIFRS (nuTipoComprobante in number ,
                                    nuComprobante in number,
                                    sbCuenta in varchar2,
                                    blGraba in boolean
                                    );
    PROCEDURE ClonaComprobante (nuComprobante in number,
                          blGraba in boolean);

    PROCEDURE getConfigura (nuTipoComprobante in number ,
                            nuComprobante in number,
                            sbCuenta in varchar2);

    PROCEDURE ObtieneComprobante (nuComprobante in number);
--}
END LDCI_IFRS;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_IFRS AS

    /*****************************************************************
    Propiedad intelectual de GDO. (c).

    Package	: LDCI_IFRS
    Descripción	: Realiza clonación de configuración de interfaz contable

    Autor	: Carlos Andrés Dominguez Naranjo - Cdominguez
    Fecha	: 21-03-2014

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
    -----------  -------------------    -------------------------------------

    ******************************************************************/

    -----------------------
    -- Constants
    -----------------------
    -- Constante con la versión de la ultima version aplicada
    csbVERSION CONSTANT VARCHAR2(10) := '3580_7';

    sbErrMsg varchar2(2000);
    onuErrorCode number;
    osbErrorMessage varchar2(2000);

        CURSOR cuic_crcoreco (nuccrccorc ic_crcoreco.ccrccorc%type,
                              nuccrcclcr ic_crcoreco.ccrcclcr%type) is
        SELECT *
        FROM ic_crcoreco
        WHERE ccrccorc = nuccrccorc
        AND ccrcclcr = nuccrcclcr;

        CURSOR cuRecoclco ( nurcccclcr ic_recoclco.rcccclcr%type)IS
        SELECT * FROM ic_recoclco
        WHERE rcccclcr = nurcccclcr;


    type tyrcDatos IS record (
        tccocodi ic_ticocont.tccocodi%type,
        tccodesc ic_ticocont.tccodesc%type,
        cococodi ic_compcont.cococodi%type,
        cocodesc ic_compcont.cocodesc%type,
        corccons ic_confreco.corccons%type,
        corccoco ic_confreco.corccoco%type,
        corctido ic_confreco.corctido%type,
        tidcdesc ic_tipodoco.tidcdesc%type,
        clcrcons ic_clascore.clcrcons%type,
        clcrcorc ic_clascore.clcrcorc%type,
        clcocodi ic_clascont.clcocodi%type,
        clcodesc ic_clascont.clcodesc%type,
        clcodomi ic_clascont.clcodomi%type,
        clcrclco ic_clascore.clcrclco%type,
        rccccons ic_recoclco.rccccons%type,
        rcccclcr ic_recoclco.rcccclcr%type,
        rcccnatu ic_recoclco.rcccnatu%type,
        rccccuco ic_recoclco.rccccuco%type,
        rcccpopa ic_recoclco.rcccpopa%type
    );

    rcIC_COMPCONT IC_COMPCONT%rowtype;
    rcic_confreco ic_confreco%rowtype;

    sbSentencia varchar2(2000);

    type tyIC_COMPCONT IS table of IC_COMPCONT%rowtype index BY pls_integer;
    type tyic_confreco IS table of ic_confreco%rowtype index BY pls_integer;
    type tyic_clascore IS table of ic_clascore%rowtype index BY pls_integer;
    type tyic_recoclco IS table of ic_recoclco%rowtype index BY pls_integer;
    type tyic_auxicorc IS table of ic_auxicorc%rowtype index BY pls_integer;
    type tyic_crcoreco IS table of ic_crcoreco%rowtype index BY pls_integer;

    type tyrcLlaves IS record
    (
        Libro  varchar2(2),
        LlaveOrigi number,
        LlaveDesti number,
        Inserta varchar2(2)
    );

    type tyrcCuentas IS record
    (
        sbCtaOrigen varchar2(2000),
        sbCtaDestino varchar2(2000)
    );

    type tytbrcLlaves IS table of tyrcLlaves index BY varchar2(250);

    type tytbrcCuentas IS table of tyrcCuentas index BY varchar2(250);

    type tyDelete IS table of varchar2(2000) index BY pls_integer;
    nuDel number := 0;

    tbDelete tyDelete;
    tbIC_COMPCONT tyIC_COMPCONT;
    tbic_confreco tyic_confreco;
    tbic_clascore tyic_clascore;
    tbic_recoclco tyic_recoclco;
    tbic_auxicorc tyic_auxicorc;
    tbic_crcoreco tyic_crcoreco;
    -- Tabla para actualizar id
    tbrcCuentas tytbrcCuentas;

    IfrstbConfreco tyic_confreco;
    AlltbConfreco tyic_confreco;

    tbLlaveConfreco tytbrcLlaves;
    tbLlaveCLascore tytbrcLlaves;
    tbLlaveRecoclco tytbrcLlaves;
    tbLlaveCrcoreco tytbrcLlaves;
    tbLlaveAuxicorc tytbrcLlaves;

    tbConfreco pktblIc_Confreco.TYCORCCONS;
    tbClascore pktblIc_Clascore.tyclcrcons;
    tbRecoclco pktblIc_Recoclco.tyrccccons;
    tbClascoreBusca pktblIc_Clascore.tyclcrcons;

    nuSecuencia number;
    nuIndice number;


    /*****************************************************************
    Propiedad intelectual de GDO. (c).

    Procedure	: fsbVersion
    Descripcion	:

    Parametros	:	Descripcion
    Retorno     :
    	csbVersion        Version del Paquete

    Autor	   :
    Fecha	   :

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificación

    DD-MM-YYYY    <Autor>SAONNNNN
    Modificacion
    *****************************************************************/
    FUNCTION fsbVersion
    RETURN varchar2
    IS
    BEGIN
    --{
        pkErrors.Push('LDCI_IFRS.fsbVersion');

        pkErrors.Pop;
        -- Retorna el SAO con que se realizo la ultima entrega
        RETURN (csbVersion);
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
        when ex.CONTROLLED_ERROR then
            pkErrors.Pop;
            raise;
        when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
            pkErrors.Pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
    --}
    END fsbVersion;

   /*****************************************************************
    Propiedad intelectual de GDO. (c).

    Procedure	: InitSequence
    Descripcion	: Inicializa las secuencias

    Parametros	:	Descripcion
    Retorno     :

    Autor	   :
    Fecha	   :

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificación

    DD-MM-YYYY    <Autor>SAONNNNN
    Modificacion
    *****************************************************************/
PROCEDURE InitSequence is
    nuSeq number;
    sbSentencia varchar2(2000);
    nuMax number;
BEGIN
    sbSentencia := 'select max(corccons) FROM IC_CONFRECO';
    execute immediate sbSentencia INTO nuMax;
    dbms_output.put_Line('Maximo Valor Tabla IC_CONFRECO: '||nuMax);

    sbSentencia := 'select SQ_IC_CONFRECO_CORCCONS.nextval FROM dual';
    execute immediate sbSentencia INTO nuSeq;
    dbms_output.put_Line('Valor secuencia '||nuSeq);

    sbSentencia := 'select SQ_IC_CONFRECO_CORCCONS.currval FROM dual';
    execute immediate sbSentencia INTO nuSeq;
    dbms_output.put_Line('Valor Actual Secuencia '||nuSeq);
    if nuMax > nuSeq then
        sbSentencia := 'drop sequence SQ_IC_CONFRECO_CORCCONS';
        execute immediate sbSentencia;
        dbms_output.put_Line('Sequencia SQ_IC_CONFRECO_CORCCONS borrada ');
        ---------
        nuMax := nuMax +1;
        sbSentencia := 'CREATE SEQUENCE SQ_IC_CONFRECO_CORCCONS START WITH '||nuMax||' INCREMENT BY 1 NOCACHE NOCYCLE';
        execute immediate sbSentencia;
        dbms_output.put_Line('Sequencia SQ_IC_CONFRECO_CORCCONS creada ');

        sbSentencia := 'select SQ_IC_CONFRECO_CORCCONS.nextval FROM dual';
        execute immediate sbSentencia INTO nuSeq;
        dbms_output.put_Line('Valor secuencia '||nuSeq);

    END if;

    dbms_output.put_Line('-------------------------------------------------');

    sbSentencia := 'select max(aucrcons) FROM IC_AUXICORC';
    execute immediate sbSentencia INTO nuMax;
    dbms_output.put_Line('Maximo Valor Tabla IC_AUXICORC: '||nuMax);

    sbSentencia := 'select SQ_IC_AUXICORC_187974.nextval FROM dual';
    execute immediate sbSentencia INTO nuSeq;
    dbms_output.put_Line('Valor secuencia '||nuSeq);

    sbSentencia := 'select SQ_IC_AUXICORC_187974.currval FROM dual';
    execute immediate sbSentencia INTO nuSeq;
    dbms_output.put_Line('Valor Actual Secuencia '||nuSeq);
    if nuMax > nuSeq then
        sbSentencia := 'drop sequence SQ_IC_AUXICORC_187974';
        execute immediate sbSentencia;
        dbms_output.put_Line('Sequencia SQ_IC_AUXICORC_187974 borrada ');
        ---------
        nuMax := nuMax +1;
        sbSentencia := 'CREATE SEQUENCE SQ_IC_AUXICORC_187974 START WITH '||nuMax||' INCREMENT BY 1 NOCACHE NOCYCLE';
        execute immediate sbSentencia;
        dbms_output.put_Line('Sequencia SQ_IC_AUXICORC_187974 creada ');

        sbSentencia := 'select SQ_IC_AUXICORC_187974.nextval FROM dual';
        execute immediate sbSentencia INTO nuSeq;
        dbms_output.put_Line('Valor secuencia '||nuSeq);

    END if;

    dbms_output.put_Line('-------------------------------------------------');

    sbSentencia := 'SELECT max(clcrcons) FROM IC_CLASCORE';
    execute immediate sbSentencia INTO nuMax;
    dbms_output.put_Line('Maximo Valor Tabla IC_CLASCORE: '||nuMax);

    sbSentencia := 'select SQ_IC_CLASCORE_CLCRCONS.nextval FROM dual';
    execute immediate sbSentencia INTO nuSeq;
    dbms_output.put_Line('Valor secuencia '||nuSeq);

    sbSentencia := 'select SQ_IC_CLASCORE_CLCRCONS.currval FROM dual';
    execute immediate sbSentencia INTO nuSeq;
    dbms_output.put_Line('Valor Actual Secuencia '||nuSeq);
    if nuMax > nuSeq then
        sbSentencia := 'drop sequence SQ_IC_CLASCORE_CLCRCONS';
        execute immediate sbSentencia;
        dbms_output.put_Line('Sequencia SQ_IC_CLASCORE_CLCRCONS borrada ');
        ---------
        nuMax := nuMax +1;
        sbSentencia := 'CREATE SEQUENCE SQ_IC_CLASCORE_CLCRCONS START WITH '||nuMax||' INCREMENT BY 1 NOCACHE NOCYCLE';
        execute immediate sbSentencia;
        dbms_output.put_Line('Sequencia SQ_IC_CLASCORE_CLCRCONS creada ');

        sbSentencia := 'select SQ_IC_CLASCORE_CLCRCONS.nextval FROM dual';
        execute immediate sbSentencia INTO nuSeq;
        dbms_output.put_Line('Valor secuencia '||nuSeq);

    END if;

    dbms_output.put_Line('-------------------------------------------------');

    sbSentencia := 'SELECT max(ccrccons) FROM IC_CRCORECO';
    execute immediate sbSentencia INTO nuMax;
    dbms_output.put_Line('Maximo Valor Tabla IC_CRCORECO: '||nuMax);

    sbSentencia := 'select SQ_IC_CRCORECO_CCRCCONS.nextval FROM dual';
    execute immediate sbSentencia INTO nuSeq;
    dbms_output.put_Line('Valor secuencia '||nuSeq);

    sbSentencia := 'select SQ_IC_CRCORECO_CCRCCONS.currval FROM dual';
    execute immediate sbSentencia INTO nuSeq;
    dbms_output.put_Line('Valor Actual Secuencia '||nuSeq);
    if nuMax > nuSeq then
        sbSentencia := 'drop sequence SQ_IC_CRCORECO_CCRCCONS';
        execute immediate sbSentencia;
        dbms_output.put_Line('Sequencia SQ_IC_CRCORECO_CCRCCONS borrada ');
        ---------
        nuMax := nuMax +1;
        sbSentencia := 'CREATE SEQUENCE SQ_IC_CRCORECO_CCRCCONS START WITH '||nuMax||' INCREMENT BY 1 NOCACHE NOCYCLE';
        execute immediate sbSentencia;
        dbms_output.put_Line('Sequencia SQ_IC_CRCORECO_CCRCCONS creada ');

        sbSentencia := 'select SQ_IC_CRCORECO_CCRCCONS.nextval FROM dual';
        execute immediate sbSentencia INTO nuSeq;
        dbms_output.put_Line('Valor secuencia '||nuSeq);

    END if;

    dbms_output.put_Line('-------------------------------------------------');

    sbSentencia := 'SELECT max(rccccons) FROM IC_RECOCLCO';
    execute immediate sbSentencia INTO nuMax;
    dbms_output.put_Line('Maximo Valor Tabla IC_RECOCLCO: '||nuMax);

    sbSentencia := 'select SQ_IC_RECOCLCO_RCCCCONS.nextval FROM dual';
    execute immediate sbSentencia INTO nuSeq;
    dbms_output.put_Line('Valor secuencia '||nuSeq);

    sbSentencia := 'select SQ_IC_RECOCLCO_RCCCCONS.currval FROM dual';
    execute immediate sbSentencia INTO nuSeq;
    dbms_output.put_Line('Valor Actual Secuencia '||nuSeq);
    if nuMax > nuSeq then
        sbSentencia := 'drop sequence SQ_IC_RECOCLCO_RCCCCONS';
        execute immediate sbSentencia;
        dbms_output.put_Line('Sequencia SQ_IC_RECOCLCO_RCCCCONS borrada ');
        ---------
        nuMax := nuMax +1;
        sbSentencia := 'CREATE SEQUENCE SQ_IC_RECOCLCO_RCCCCONS START WITH '||nuMax||' INCREMENT BY 1 NOCACHE  NOCYCLE';
        execute immediate sbSentencia;
        dbms_output.put_Line('Sequencia SQ_IC_RECOCLCO_RCCCCONS creada ');

        sbSentencia := 'select SQ_IC_RECOCLCO_RCCCCONS.nextval FROM dual';
        execute immediate sbSentencia INTO nuSeq;
        dbms_output.put_Line('Valor secuencia '||nuSeq);

    END if;
END InitSequence;

   /*****************************************************************
    Propiedad intelectual de GDO. (c).

    Procedure	: CargaDatos
    Descripcion	: Obtiene los datos a clonar

    Parametros	:	Descripcion
    Retorno     :
    	csbVersion        Version del Paquete

    Autor	   :
    Fecha	   :

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificación

    DD-MM-YYYY    <Autor>SAONNNNN
    Modificacion
    *****************************************************************/
    PROCEDURE CargaDatosClona (nuComprobante in number)
    IS
        type tycuDatos  is ref cursor;
        cuDatos tycuDatos;

        nucorccons ic_ConfReco.corccons%type;
        nuClcrcons ic_clascore.clcrcons%type;
        nuaucrcons ic_auxicorc.aucrcons%type;
        nuccrccons ic_crcoreco.ccrccons%type;

        sbQuery varchar2(2000);
        rcDatos tyrcDatos;

        CURSOR cuConfreco (nucorccoco ic_confreco.corccoco%type) IS
        SELECT * FROM ic_confreco
        WHERE corccoco = nucorccoco;

        CURSOR cuic_auxicorc (nuaucrcorc ic_auxicorc.aucrcorc%type) is
        SELECT *
        FROM ic_auxicorc WHERE aucrcorc = nuaucrcorc;

        CURSOR cuClascore (nuclcrcorc ic_clascore.clcrcorc%type)
        IS
        SELECT *
        FROM ic_clascore
        WHERE clcrcorc = nuclcrcorc;

    BEGIN
    -- Recorre para cada tipo de comprobante
    sbSentencia := 'select max(cococodi) FROM ic_compcont';
    execute immediate sbSentencia INTO nuSecuencia;

    dbms_output.put_Line('COMPROBANTE: '||nuComprobante||chr(10));
    rcIC_COMPCONT := pktblIC_COMPCONT.frcGetRecord(nuComprobante);

    nuSecuencia := nuSecuencia +1;
    rcIC_COMPCONT.cococodi := nuSecuencia;
    tbIC_COMPCONT(nuSecuencia) := rcIC_COMPCONT;

    -- Recorre CONFIGURACION REGISTRO CONTABLE
    for rcConfreco in cuConfreco (nuComprobante) loop

        if NOT tbic_confreco.exists(rcConfreco.corccons) then
            rcConfreco.corccoco := tbIC_COMPCONT(nuSecuencia).cococodi;
            nucorccons := rcConfreco.corccons;
            rcConfreco.corccons := SQ_IC_CONFRECO_CORCCONS.nextval;
            tbic_confreco(nucorccons) := rcConfreco;
            --dbms_output.put_Line('Confreco: '||rcConfreco.corccons||'  '||rcConfreco.corccoco);

        END if;

        for rcic_auxicorc in cuic_auxicorc (nucorccons) loop
            if NOT tbic_auxicorc.exists(rcic_auxicorc.aucrcons) then
                nuaucrcons := rcic_auxicorc.aucrcons;
                rcic_auxicorc.aucrcons := SQ_IC_AUXICORC_187974.nextval;
                rcic_auxicorc.aucrcorc := tbic_confreco(nucorccons).corccons;
                tbic_auxicorc(nuaucrcons) := rcic_auxicorc;
                -- dbms_output.put_Line('auxicorc ' ||nuaucrcons||'  '||rcic_auxicorc.aucrcons||' - '||tbic_confreco(nucorccons).corccons);
            END if;
        END loop;

        for rcClascore in cuClascore(nucorccons) loop
            -- id orignal de clascore para usarlo en la busqueda base
            nuclcrcons := rcClascore.clcrcons;
            -- asinga nueva secuencia a id clascore
            rcClascore.clcrcons := SQ_IC_CLASCORE_CLCRCONS.nextval;
            -- asinga valor de referencia de confreco
            rcClascore.clcrcorc := tbic_confreco(nucorccons).corccons;
            -- almacena registro en tabla a clonar
            tbic_clascore(nuclcrcons) := rcClascore;
            --dbms_output.put_Line('busco con . '||nuclcrcons||'   nuevo id '||rcClascore.clcrcons);

            --dbms_output.put_Line('crcoreco: '||nucorccons||' | '||nuclcrcons);
            for rcic_crcoreco in cuic_crcoreco (nucorccons,nuclcrcons) loop
                nuccrccons := rcic_crcoreco.ccrccons;
                rcic_crcoreco.ccrccons := SQ_IC_CRCORECO_CCRCCONS.nextval;
                rcic_crcoreco.ccrccorc := tbic_confreco(nucorccons).corccons;
                rcic_crcoreco.ccrcclcr := tbic_clascore(nuclcrcons).clcrcons;
                tbic_crcoreco(nuccrccons) := rcic_crcoreco;
            END loop;

            --dbms_output.put_Line('Recoclco: '||nuclcrcons);
            -- busca configuracion con id original
            for rcRecoclco in cuRecoclco (nuclcrcons) loop
                -- Asigna id secuencia para Recoclco
                rcRecoclco.rccccons := SQ_IC_RECOCLCO_RCCCCONS.nextval;
                -- asigna valor de referencia de Clascore
                rcRecoclco.rcccclcr := tbic_clascore(nuclcrcons).clcrcons; -- rcClascore.clcrcons;
                -- guarda registro a duplicar
                tbic_recoclco(rcRecoclco.rccccons) := rcRecoclco;
            END loop;

        END loop;

    END loop;

    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
        when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbErrorMessage);
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
    --}
    END CargaDatosClona;


   /*****************************************************************
    Propiedad intelectual de GDO. (c).

    Procedure	: CargaDatosIFRS
    Descripcion	: Obtiene los datos a clonar

    Parametros	:	Descripcion
    Retorno     :
    	csbVersion        Version del Paquete

    Autor	   :
    Fecha	   :

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificación

    DD-MM-YYYY    <Autor>SAONNNNN
    Modificacion
    *****************************************************************/
    PROCEDURE CargaDatosIFRS (nuTipoComprobante in number , nuComprobante in number, sbCuenta varchar2)
    IS
        type tycuDatos  is ref cursor;
        cuDatos tycuDatos;


        CURSOR cuConfreco (nucorccoco ic_confreco.corccoco%type) IS
        SELECT * FROM ic_confreco
        WHERE corccoco = nucorccoco;

        nucorccons ic_ConfReco.corccons%type;
        nuClcrcons ic_clascore.clcrcons%type;
        nuaucrcons ic_auxicorc.aucrcons%type;
        nuccrccons ic_crcoreco.ccrccons%type;

        sbQuery varchar2(2000);

        nuIndice number;
        blExiste boolean;
    BEGIN
    --{
    sbQuery := 'SELECT distinct corccons, clcrcons, rccccons
                FROM ic_clascore, ic_recoclco, ic_confreco, ic_compcont
                WHERE rccccuco like (:sbCondicion)
                AND rcccclcr = clcrcons
                AND corccons = clcrcorc
                AND cococodi = corccoco
                AND cocotcco = :nucocotcco
                AND cococodi = :nuComprobante ORDER BY corccons';

    open cuDatos for sbQuery using sbCuenta, nuTipoComprobante, nuComprobante;
    fetch cuDatos BULK COLLECT INTO  tbConfreco,tbClascore, tbRecoclco;
    close cuDatos;

    nuIndice := tbClascore.first;
    loop
        exit when nuIndice IS null;
        tbClascoreBusca(tbClascore(nuIndice)) := tbClascore(nuIndice);
        nuIndice := tbClascore.next(nuIndice);
    END loop;

    -- Selecciona los registros que deben ser tenidos en cuenta para ifrs
    for rcConfreco in cuConfreco (nuComprobante) loop
        nuIndice := tbConfreco.first;
        blExiste := FALSE;
        loop
            exit when nuIndice IS null;
            if tbConfreco(nuIndice) = rcConfreco.corccons then
                blExiste := TRUE;
            END if;
            nuIndice := tbConfreco.next(nuIndice);
        END loop;
        if blExiste then
            IfrstbConfreco(rcConfreco.corccons) := rcConfreco;
            dbms_output.put_Line('IFRS : '||rcConfreco.corccons);
        else
            AlltbConfreco(rcConfreco.corccons) := rcConfreco;
            dbms_output.put_Line('RESTO : '||rcConfreco.corccons);
        END if;
    END loop;


    if IfrstbConfreco.count < 1 then -- Si existen datos para convertir a ifrs
        dbms_output.put_Line('No existen datos para convertir a IFRS');
        return;
    END if;

    -- Recorre para cada tipo de comprobante
    sbSentencia := 'select max(cococodi) FROM ic_compcont';
    execute immediate sbSentencia INTO nuSecuencia;

    rcIC_COMPCONT := pktblIC_COMPCONT.frcGetRecord(nuComprobante);

    nuSecuencia :=  nuSecuencia+1;
    rcIC_COMPCONT.cococodi := nuSecuencia;
    tbIC_COMPCONT(nuSecuencia) := rcIC_COMPCONT;

    dbms_output.put_Line('componentes new :'||tbIC_COMPCONT.count);
    return;

    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
        when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbErrorMessage);
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
    --}
    END CargaDatosIFRS;

    /*****************************************************************
    Propiedad intelectual de GDO. (c).

    Procedure	: GeneraDataIFRS
    Descripcion	: Genera la data obtenida, clona la información

    Parametros	:	Descripcion

    Retorno	:
	   onuErrorCode		Codigo del mensaje de Error Generado
	   			 0    - Proceso satisfactorio
				 <> 0 - Codigo del error
	   osbErrorMessage		Mensaje de Error

    Autor	   :
    Fecha	   :

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificación

    DD-MM-YYYY    <Autor>SAONNNNN
    Modificacion
    *****************************************************************/
    PROCEDURE GeneraDataIFRS (blClona in boolean)
    IS
        rcRecoclco  ic_recoclco%rowtype;
        nuIndice number;
        type tyPrimary IS table of number index BY pls_integer;
        tbPrimary tyPrimary;
        sbPrograma varchar2(250) := 'IFRS';

        CURSOR cuic_auxicorc (nuaucrcorc ic_auxicorc.aucrcorc%type) is
        SELECT *
        FROM ic_auxicorc WHERE aucrcorc = nuaucrcorc;

        CURSOR cuClascore (nuclcrcorc ic_clascore.clcrcorc%type)
        IS
        SELECT *
        FROM ic_clascore
        WHERE clcrcorc = nuclcrcorc;

        CURSOR cuCrcoreco (nuccrccorc ic_crcoreco.ccrccorc%type)
        IS
        SELECT *
        FROM ic_crcoreco
        WHERE ccrccorc = nuccrccorc
        ;

        CURSOR cuRecoclco (nucorccons ic_confreco.corccons%type)
        IS
        SELECT ic_recoclco.*
        FROM ic_recoclco, ic_clascore, ic_confreco
        WHERE clcrcorc = corccons
        AND rcccclcr =clcrcons
        AND corccons = nucorccons;

        sbLlave varchar2(250);
        sbLLaveAux varchar2(250);
        sbHash varchar2(250);
    BEGIN
    --{
        -- Crea la configuración encontrada
        dbms_output.put_Line('tbIC_COMPCONT  '||tbIC_COMPCONT.count);
        nuIndice := tbIC_COMPCONT.first;
        loop
            exit when nuIndice IS null;
            rcIC_COMPCONT.cococodi := tbIC_COMPCONT(nuIndice).cococodi;
            rcIC_COMPCONT.cocotcco := tbIC_COMPCONT(nuIndice).cocotcco;
            rcIC_COMPCONT.cocodesc := tbIC_COMPCONT(nuIndice).cocodesc||' - LOCAL ';
            rcIC_COMPCONT.cocofecr := sysdate;
            rcIC_COMPCONT.cocousua := ut_session.getuser;
            rcIC_COMPCONT.cocoterm := ut_session.getterminal;
            rcIC_COMPCONT.cocoprog := sbPrograma;
            rcIC_COMPCONT.cocosist := tbIC_COMPCONT(nuIndice).cocosist;

            INSERT INTO tmpic_compcont VALUES rcIC_COMPCONT;
            tbDelete(nuDel) := 'delete ic_compcont WHERE cococodi = '||rcIC_COMPCONT.cococodi||';';
            nuDel := nuDel+1;

            if blClona then
                INSERT INTO ic_compcont VALUES rcIC_COMPCONT;
                null;
            END if;
            tbPrimary(1) := rcIC_COMPCONT.cococodi;
            dbms_output.put_Line('insert ic_compcont - LOCAL '|| tbPrimary(1));

            rcIC_COMPCONT.cococodi := rcIC_COMPCONT.cococodi +1;
            rcIC_COMPCONT.cocodesc := tbIC_COMPCONT(nuIndice).cocodesc || ' IFRS';

            INSERT INTO tmpic_compcont VALUES rcIC_COMPCONT;
            tbDelete(nuDel) := 'delete ic_compcont WHERE cococodi = '||rcIC_COMPCONT.cococodi||';';
            nuDel := nuDel+1;

            if blClona then
                INSERT INTO ic_compcont VALUES rcIC_COMPCONT;
                null;
            END if;
            tbPrimary(2) := rcIC_COMPCONT.cococodi;
            dbms_output.put_Line('insert ic_compcont - IFRS '|| tbPrimary(2));

            nuIndice := tbIC_COMPCONT.next(nuIndice);

        END loop;

----------------------
-- Inserta LOCAL exclusivo
----------------------

    nuIndice := AlltbConfreco.first;
    dbms_output.put_Line('AlltbConfreco  '||AlltbConfreco.count||'  '||nuIndice);
    loop
        exit when nuIndice IS null;

        tbic_confreco(nuIndice) := AlltbConfreco(nuIndice);
        sbLlave := 'L'||nuIndice;
        tbLlaveConfreco(sbLlave).Libro := 'L';
        tbLlaveConfreco(sbLlave).LlaveOrigi := tbic_confreco(nuIndice).corccons;

        tbic_confreco(nuIndice).corccons := SQ_IC_CONFRECO_CORCCONS.nextval;
        tbLlaveConfreco(sbLlave).LlaveDesti := tbic_confreco(nuIndice).corccons;

        tbic_confreco(nuIndice).corccoco := tbPrimary(1);
        tbic_confreco(nuIndice).corcfecr := sysdate;
        tbic_confreco(nuIndice).corcusua := ut_session.getuser;
        tbic_confreco(nuIndice).corcterm := ut_session.getterminal;
        tbic_confreco(nuIndice).corcprog := sbPrograma;
        dbms_output.put_Line('confreco All '||sbLlave||'  new '||tbic_confreco(nuIndice).corccons);

        INSERT INTO tmpic_confreco VALUES tbic_confreco(nuIndice);
        tbDelete(nuDel) := 'delete ic_confreco WHERE corccons = '||tbic_confreco(nuIndice).corccons||';';
        nuDel := nuDel+1;

        if blClona then
            INSERT INTO ic_confreco VALUES tbic_confreco(nuIndice);
            null;
        END if;

        nuIndice := AlltbConfreco.next(nuIndice);
    END loop;

-------------------
-- Inserta en LOCAL lo que corresponde a la parte de IFRS
-------------------
    nuIndice := IfrstbConfreco.first;
    dbms_output.put_Line('AlltbConfreco  '||IfrstbConfreco.count||'  '||nuIndice);
    loop
        exit when nuIndice IS null;

        tbic_confreco(nuIndice) := IfrstbConfreco(nuIndice);
        sbLlave := 'LI'||nuIndice;
        tbLlaveConfreco(sbLlave).LlaveOrigi := tbic_confreco(nuIndice).corccons;
        tbLlaveConfreco(sbLlave).Libro := 'LI';

        tbic_confreco(nuIndice).corccons := SQ_IC_CONFRECO_CORCCONS.nextval;
        tbLlaveConfreco(sbLlave).LlaveDesti := tbic_confreco(nuIndice).corccons;

        tbic_confreco(nuIndice).corccoco := tbPrimary(1);
        tbic_confreco(nuIndice).corcfecr := sysdate;
        tbic_confreco(nuIndice).corcusua := ut_session.getuser;
        tbic_confreco(nuIndice).corcterm := ut_session.getterminal;
        tbic_confreco(nuIndice).corcprog := sbPrograma;
        dbms_output.put_Line('confreco IFRS '||sbLlave||'  new '||tbic_confreco(nuIndice).corccons);

        INSERT INTO tmpic_confreco VALUES tbic_confreco(nuIndice);
        tbDelete(nuDel) := 'delete ic_confreco WHERE corccons = '||tbic_confreco(nuIndice).corccons||';';
        nuDel := nuDel+1;

        if blClona then
            INSERT INTO ic_confreco VALUES tbic_confreco(nuIndice);
            null;
        END if;

        nuIndice := IfrstbConfreco.next(nuIndice);
    END loop;

-------------------
-- Inserta en la parte de IFRS lo que corresponde a IFRS
-------------------
    nuIndice := IfrstbConfreco.first;
    dbms_output.put_Line('IfrstbConfreco  '||IfrstbConfreco.count||'  '||nuIndice);
    loop
        exit when nuIndice IS null;

        tbic_confreco(nuIndice) := IfrstbConfreco(nuIndice);
        sbLlave := 'I'||nuIndice;
        tbLlaveConfreco(sbLlave).LlaveOrigi := tbic_confreco(nuIndice).corccons;
        tbLlaveConfreco(sbLlave).Libro := 'I';

        tbic_confreco(nuIndice).corccons := SQ_IC_CONFRECO_CORCCONS.nextval;
        tbLlaveConfreco(sbLlave).LlaveDesti := tbic_confreco(nuIndice).corccons;

        tbic_confreco(nuIndice).corccoco := tbPrimary(2);
        tbic_confreco(nuIndice).corcfecr := sysdate;
        tbic_confreco(nuIndice).corcusua := ut_session.getuser;
        tbic_confreco(nuIndice).corcterm := ut_session.getterminal;
        tbic_confreco(nuIndice).corcprog := sbPrograma;
        dbms_output.put_Line('confreco IFRS '||sbLlave||'  new '||tbic_confreco(nuIndice).corccons);

        INSERT INTO tmpic_confreco VALUES tbic_confreco(nuIndice);
        tbDelete(nuDel) := 'delete ic_confreco WHERE corccons = '||tbic_confreco(nuIndice).corccons||';';
        nuDel := nuDel+1;

        if blClona then
            INSERT INTO ic_confreco VALUES tbic_confreco(nuIndice);
            null;
        END if;

        nuIndice := IfrstbConfreco.next(nuIndice);
    END loop;

        dbms_output.put_Line('termine tbLlaveConfreco totales '||tbLlaveConfreco.count);

    sbLlave := tbLlaveConfreco.first;
    loop
        exit when sbLlave IS null;
        for rcAuxicorc in cuic_auxicorc(tbLlaveConfreco(sbLlave).LlaveOrigi) loop

            tbic_auxicorc(rcAuxicorc.aucrcons) := rcAuxicorc;

            sbHash := tbLlaveConfreco(sbLlave).Libro||rcAuxicorc.aucrcons;
            tbLlaveAuxicorc(sbHash).Libro := tbLlaveConfreco(sbLlave).Libro;
            tbLlaveAuxicorc(sbHash).LlaveOrigi := rcAuxicorc.aucrcons;

            tbic_auxicorc(rcAuxicorc.aucrcons).aucrcons := SQ_IC_AUXICORC_187974.nextval;
            tbic_auxicorc(rcAuxicorc.aucrcons).aucrcorc := tbLlaveConfreco(sbLlave).LlaveDesti;
            tbLlaveAuxicorc(sbHash).LlaveDesti := tbic_auxicorc(rcAuxicorc.aucrcons).aucrcons;

            INSERT INTO tmpic_auxicorc VALUES tbic_auxicorc(rcAuxicorc.aucrcons);
            tbDelete(nuDel) := 'delete ic_auxicorc WHERE aucrcons = '||tbic_auxicorc(rcAuxicorc.aucrcons).aucrcons||';';
            nuDel := nuDel+1;

            if blClona then
                INSERT INTO ic_auxicorc VALUES tbic_auxicorc(rcAuxicorc.aucrcons);
                null;
            END if;

        END loop;
        sbLlave := tbLlaveConfreco.next(sbLlave);
    END loop;

        dbms_output.put_Line('termine tbLlaveAuxicorc totales '||tbLlaveAuxicorc.count);


    sbLlave := tbLlaveConfreco.first;
    loop
        exit when sbLlave IS null;
        dbms_output.put_Line('Busca clascore con '||tbLlaveConfreco(sbLlave).LlaveOrigi);
        for rcClascore in cuClascore(tbLlaveConfreco(sbLlave).LlaveOrigi) loop
            tbic_clascore(rcClascore.clcrcons) := rcClascore;

            sbHash := tbLlaveConfreco(sbLlave).Libro||rcClascore.clcrcons;
            tbLlaveCLascore(sbHash).LlaveOrigi := rcClascore.clcrcons;
            tbLlaveCLascore(sbHash).Libro := tbLlaveConfreco(sbLlave).Libro;

            if tbClascoreBusca.exists(rcClascore.clcrcons) then
                tbLlaveCLascore(sbHash).Inserta := 'NO';
            else
                tbLlaveCLascore(sbHash).Inserta := 'SI';
            END if;

            tbic_clascore(rcClascore.clcrcons).clcrcons := SQ_IC_CLASCORE_CLCRCONS.nextval;
            tbic_clascore(rcClascore.clcrcons).clcrcorc := tbLlaveConfreco(sbLlave).LlaveDesti;
            tbLlaveCLascore(sbHash).LlaveDesti := tbic_clascore(rcClascore.clcrcons).clcrcons;

        dbms_output.put_Line('ic_clascore original: indice:'||sbHash||'  '||
        tbLlaveCLascore(sbHash).LlaveOrigi||
        ' destino: '||tbLlaveCLascore(sbHash).LlaveDesti||'  '||
        rcClascore.clcrcons);

            INSERT INTO tmpic_clascore VALUES tbic_clascore(rcClascore.clcrcons);
            tbDelete(nuDel) := 'delete ic_clascore WHERE clcrcons = '||tbic_clascore(rcClascore.clcrcons).clcrcons||';';
            nuDel := nuDel+1;


            if blClona then
                INSERT INTO ic_clascore VALUES tbic_clascore(rcClascore.clcrcons);
                null;
            END if;

        END loop;
        sbLlave := tbLlaveConfreco.next(sbLlave);
    END loop;

        dbms_output.put_Line('termine tbLlaveCLascore totales '||tbLlaveCLascore.count);


--------------
--------------

    sbLlave := tbLlaveConfreco.first;
    loop
        exit when sbLlave IS null;
        dbms_output.put_Line('Busca crcoreco con '||tbLlaveConfreco(sbLlave).LlaveOrigi);
        for rccrcoreco in cuCrcoreco(tbLlaveConfreco(sbLlave).LlaveOrigi) loop

            sbHash := tbLlaveConfreco(sbLlave).Libro||rccrcoreco.ccrccons;
            tbic_crcoreco(rccrcoreco.ccrccons) := rccrcoreco;
            tbLlaveCrcoreco(sbHash).LlaveOrigi := rccrcoreco.ccrccons;
            tbLlaveCrcoreco(sbHash).Libro := tbLlaveConfreco(sbLlave).Libro;


            tbic_crcoreco(rccrcoreco.ccrccons).ccrccons := SQ_IC_CLASCORE_CLCRCONS.nextval;
            tbLlaveCrcoreco(sbHash).LlaveDesti := tbic_crcoreco(rccrcoreco.ccrccons).ccrccons;
            tbic_crcoreco(rccrcoreco.ccrccons).ccrccorc := tbLlaveConfreco(sbLlave).LlaveDesti;

            sbLlaveAux := tbLlaveConfreco(sbLlave).Libro||rccrcoreco.ccrcclcr;
            if tbLlaveCLascore.exists(sbLlaveAux) then
                tbic_crcoreco(rccrcoreco.ccrccons).ccrcclcr := tbLlaveCLascore(sbLlaveAux).LlaveDesti;
            else
                dbms_output.put_Line('No existe '|| tbLlaveConfreco(sbLlave).Libro||rccrcoreco.ccrcclcr);
            END if;

            dbms_output.put_Line('inserta en ic_crcoreco: '||
            rccrcoreco.ccrccons||'  '||
            rccrcoreco.ccrccorc||'  '||
            tbLlaveCrcoreco(sbHash).LlaveOrigi||'  '||
            tbLlaveCrcoreco(sbHash).LlaveDesti||'  '||
            tbic_crcoreco(rccrcoreco.ccrccons).ccrccons||'  '||
            tbic_crcoreco(rccrcoreco.ccrccons).ccrcclcr||'  '||
            tbic_crcoreco(rccrcoreco.ccrccons).ccrccamp);

            INSERT INTO tmpic_crcoreco VALUES tbic_crcoreco(rccrcoreco.ccrccons);
            tbDelete(nuDel) := 'delete ic_crcoreco WHERE ccrccons = '||tbic_crcoreco(rccrcoreco.ccrccons).ccrccons||';';
            nuDel := nuDel+1;

            if blClona then
                INSERT INTO ic_crcoreco VALUES tbic_crcoreco(rccrcoreco.ccrccons);
                null;
            END if;

        END loop;
        sbLlave := tbLlaveConfreco.next(sbLlave);
    END loop;

dbms_output.put_Line('termine tbLlaveCrcoreco totales '||tbLlaveCrcoreco.count);


    --- ALL
    nuIndice := AlltbConfreco.first;
    loop
        exit when nuIndice IS null;
        dbms_output.put_Line('Recoclco ALL : '||AlltbConfreco(nuIndice).corccons);
        for rcRecoclco in cuRecoclco (AlltbConfreco(nuIndice).corccons) loop

            sbHash := 'L'||rcRecoclco.rcccclcr;
            rcRecoclco.rcccclcr := tbLlaveCLascore('L'||rcRecoclco.rcccclcr).LlaveDesti;
            tbic_recoclco(rcRecoclco.rccccons) := rcRecoclco;
            tbLlaveRecoclco(sbHash).LlaveOrigi := rcRecoclco.rccccons;
            tbLlaveRecoclco(sbHash).Libro := 'L';
            tbLlaveRecoclco(sbHash).Inserta := 'SI';

            tbic_recoclco(rcRecoclco.rccccons).rccccons := SQ_IC_RECOCLCO_RCCCCONS.nextval;
            tbLlaveRecoclco(sbHash).LlaveDesti := tbic_recoclco(rcRecoclco.rccccons).rccccons;

            INSERT INTO tmpic_recoclco VALUES tbic_recoclco(rcRecoclco.rccccons);
            tbDelete(nuDel) := 'delete ic_recoclco WHERE rccccons = '||tbic_recoclco(rcRecoclco.rccccons).rccccons||';';
            nuDel := nuDel+1;

            if blClona then
                INSERT INTO ic_recoclco VALUES tbic_recoclco(rcRecoclco.rccccons);
                null;
            END if;

        END loop;

        nuIndice := AlltbConfreco.next(nuIndice);
    END loop;

        dbms_output.put_Line('termine tbLlaveRecoclco totales '||tbLlaveRecoclco.count);

-- LOCAL + IFRS
    nuIndice := IfrstbConfreco.first;
    loop
        exit when nuIndice IS null;
        dbms_output.put_Line('Recoclco ALL + IFRS : '||IfrstbConfreco(nuIndice).corccons);

        for rcRecoclco in cuRecoclco (IfrstbConfreco(nuIndice).corccons) loop

            sbHash := 'LI'||rcRecoclco.rcccclcr;
            rcRecoclco.rcccclcr := tbLlaveCLascore('LI'||rcRecoclco.rcccclcr).LlaveDesti;
            tbic_recoclco(rcRecoclco.rccccons) := rcRecoclco;
            tbLlaveRecoclco(sbHash).LlaveOrigi := rcRecoclco.rccccons;
            tbLlaveRecoclco(sbHash).Libro := 'LI';

            tbic_recoclco(rcRecoclco.rccccons).rccccons := SQ_IC_RECOCLCO_RCCCCONS.nextval;
            tbLlaveRecoclco(sbHash).LlaveDesti := tbic_recoclco(rcRecoclco.rccccons).rccccons;
            tbLlaveRecoclco(sbHash).Inserta := 'SI';

            INSERT INTO tmpic_recoclco VALUES tbic_recoclco(rcRecoclco.rccccons);
            tbDelete(nuDel) := 'delete ic_recoclco WHERE rccccons = '||tbic_recoclco(rcRecoclco.rccccons).rccccons||';';
            nuDel := nuDel+1;

            if blClona then
                INSERT INTO ic_recoclco VALUES tbic_recoclco(rcRecoclco.rccccons);
                null;
            END if;

        END loop;

        nuIndice := IfrstbConfreco.next(nuIndice);
    END loop;

        dbms_output.put_Line('termine tbLlaveRecoclco totales '||tbLlaveRecoclco.count);

-- IFRS
    nuIndice := IfrstbConfreco.first;
    loop
        exit when nuIndice IS null;
        dbms_output.put_Line('Recoclco IFRS : '||IfrstbConfreco(nuIndice).corccons);
        for rcRecoclco in cuRecoclco (IfrstbConfreco(nuIndice).corccons) loop

            sbHash := 'I'||rcRecoclco.rcccclcr;
            rcRecoclco.rcccclcr := tbLlaveCLascore('I'||rcRecoclco.rcccclcr).LlaveDesti;
            tbic_recoclco(rcRecoclco.rccccons) := rcRecoclco;
            tbLlaveRecoclco(sbHash).LlaveOrigi := rcRecoclco.rccccons;
            tbLlaveRecoclco(sbHash).Libro := 'I';
            tbLlaveRecoclco(sbHash).Inserta := 'NO';

            tbic_recoclco(rcRecoclco.rccccons).rccccons := SQ_IC_RECOCLCO_RCCCCONS.nextval;
            tbLlaveRecoclco(sbHash).LlaveDesti := tbic_recoclco(rcRecoclco.rccccons).rccccons;

            if tbrcCuentas.exists(tbic_recoclco(rcRecoclco.rccccons).rccccuco) then
                tbic_recoclco(rcRecoclco.rccccons).rccccuco := tbrcCuentas(tbic_recoclco(rcRecoclco.rccccons).rccccuco).sbCtaDestino;
            END if;

            INSERT INTO tmpic_recoclco VALUES tbic_recoclco(rcRecoclco.rccccons);
            tbDelete(nuDel) := 'delete ic_recoclco WHERE rccccons = '||tbic_recoclco(rcRecoclco.rccccons).rccccons||';';
            nuDel := nuDel+1;

            if blClona then
                INSERT INTO ic_recoclco VALUES tbic_recoclco(rcRecoclco.rccccons);
                null;
            END if;

        END loop;

        nuIndice := IfrstbConfreco.next(nuIndice);
    END loop;

        dbms_output.put_Line('termine tbLlaveRecoclco totales '||tbLlaveRecoclco.count);
        dbms_output.put_Line(' ');

-- ELIMINA REGISTROS QUE NO SE REQUIEREN EN IFRS
    sbLlave := tbLlaveCLascore.first;
    loop
        exit when sbLlave IS null;

        if (tbLlaveCLascore(sbLlave).Libro = 'I' AND tbLlaveCLascore(sbLlave).Inserta = 'SI') then
            sbSentencia := 'delete tmpic_recoclco WHERE rcccclcr = :1';
            execute immediate sbSentencia using tbLlaveCLascore(sbLlave).LlaveDesti;
            if blClona then
                sbSentencia := 'delete ic_recoclco WHERE rcccclcr = :1';
                execute immediate sbSentencia using tbLlaveCLascore(sbLlave).LlaveDesti;
                dbms_output.put_Line(sbSentencia||'  '||tbLlaveCLascore(sbLlave).LlaveDesti);
            END if;
        END if;
        /*
        dbms_output.put_Line(tbLlaveCLascore(sbLlave).LlaveOrigi||' '||
            tbLlaveCLascore(sbLlave).LlaveDesti||'  '||
            tbLlaveCLascore(sbLlave).Libro||'  '||
            tbLlaveCLascore(sbLlave).Inserta);
        */
        sbLlave := tbLlaveCLascore.next(sbLlave);
    END loop;

    dbms_output.put_Line(' ');
    sbLlave := tbLlaveCLascore.first;
    loop
        exit when sbLlave IS null;

        if (tbLlaveCLascore(sbLlave).Libro = 'I' AND tbLlaveCLascore(sbLlave).Inserta = 'SI') then
            sbSentencia := 'delete tmpic_CLascore WHERE clcrcons = :1';
            execute immediate sbSentencia using tbLlaveCLascore(sbLlave).LlaveDesti;
            if blClona then
                sbSentencia := 'delete ic_clascore WHERE clcrcons = :1';
                execute immediate sbSentencia using tbLlaveCLascore(sbLlave).LlaveDesti;
                dbms_output.put_Line(sbSentencia||' '||tbLlaveCLascore(sbLlave).LlaveDesti);
            END if;
        END if;
        /*
        dbms_output.put_Line(tbLlaveCLascore(sbLlave).LlaveOrigi||' '||
            tbLlaveCLascore(sbLlave).LlaveDesti||'  '||
            tbLlaveCLascore(sbLlave).Libro||'  '||
            tbLlaveCLascore(sbLlave).Inserta);
        */
        sbLlave := tbLlaveCLascore.next(sbLlave);
    END loop;

    EXCEPTION

        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);

        when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbErrorMessage);
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
    --}
    END GeneraDataIFRS;

    /*****************************************************************
    Propiedad intelectual de GDO. (c).

    Procedure	: GeneraDataClona
    Descripcion	: Genera la data obtenida, clona la información

    Parametros	:	Descripcion

    Retorno	:
	   onuErrorCode		Codigo del mensaje de Error Generado
	   			 0    - Proceso satisfactorio
				 <> 0 - Codigo del error
	   osbErrorMessage		Mensaje de Error

    Autor	   :
    Fecha	   :

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificación

    DD-MM-YYYY    <Autor>SAONNNNN
    Modificacion
    *****************************************************************/
    PROCEDURE GeneraDataClona (blClona in boolean)
    IS
        nuCcrcclcr ic_crcoreco.ccrcclcr%type;
        nuIndice number;
        type tyPrimary IS table of number index BY pls_integer;
        tbPrimary tyPrimary;
        sbPrograma varchar2(250) := 'CLON';
    BEGIN
    --{
        -- Crea la configuración encontrada
        dbms_output.put_Line('tbIC_COMPCONT  '||tbIC_COMPCONT.count);
        nuIndice := tbIC_COMPCONT.first;
        tbDelete(nuDel) := 'delete ic_compcont WHERE cococodi = '||rcIC_COMPCONT.cococodi||';';
        nuDel := nuDel+1;
        loop
            exit when nuIndice IS null;
            rcIC_COMPCONT.cococodi := tbIC_COMPCONT(nuIndice).cococodi;
            rcIC_COMPCONT.cocotcco := tbIC_COMPCONT(nuIndice).cocotcco;
            rcIC_COMPCONT.cocodesc := tbIC_COMPCONT(nuIndice).cocodesc||' - '||sbPrograma;
            rcIC_COMPCONT.cocofecr := sysdate;
            rcIC_COMPCONT.cocousua := ut_session.getuser;
            rcIC_COMPCONT.cocoterm := ut_session.getterminal;
            rcIC_COMPCONT.cocoprog := sbPrograma;
            rcIC_COMPCONT.cocosist := tbIC_COMPCONT(nuIndice).cocosist;

            INSERT INTO tmpic_compcont VALUES rcIC_COMPCONT;

            if blClona then
                INSERT INTO ic_compcont VALUES rcIC_COMPCONT;
            END if;

            nuIndice := tbIC_COMPCONT.next(nuIndice);

        END loop;

        nuIndice := tbic_confreco.first;
        dbms_output.put_Line('tbic_confreco  '||tbic_confreco.count);
        tbDelete(nuDel) := 'delete ic_confreco WHERE corccoco = '||tbic_confreco(nuIndice).corccoco||';';
        nuDel := nuDel+1;

        loop
            exit when nuIndice IS null;
            tbic_confreco(nuIndice).corcfecr := sysdate;
            tbic_confreco(nuIndice).corcusua := ut_session.getuser;
            tbic_confreco(nuIndice).corcterm := ut_session.getterminal;
            tbic_confreco(nuIndice).corcprog := sbPrograma;

            INSERT INTO tmpic_confreco VALUES tbic_confreco(nuIndice);

            if blClona then
                INSERT INTO ic_confreco VALUES tbic_confreco(nuIndice);
            END if;

            nuIndice := tbic_confreco.next(nuIndice);
        END loop;

        nuIndice := tbic_auxicorc.first;
        dbms_output.put_Line('tbic_auxicorc  '||tbic_auxicorc.count);
        loop
            exit when nuIndice IS null;

            INSERT INTO tmpic_auxicorc VALUES tbic_auxicorc(nuIndice);
            tbDelete(nuDel) := 'delete ic_auxicorc WHERE aucrcorc = '||tbic_auxicorc(nuIndice).aucrcorc||';';
            nuDel := nuDel+1;

            if blClona then
                INSERT INTO ic_auxicorc VALUES tbic_auxicorc(nuIndice);
            END if;

            nuIndice := tbic_auxicorc.next(nuIndice);
        END loop;

        nuIndice := tbic_clascore.first;
        dbms_output.put_Line('tbic_clascore  '||tbic_clascore.count);
        loop
            exit when nuIndice IS null;
            tbic_clascore(nuIndice).clcrfecr := sysdate;
            tbic_clascore(nuIndice).clcrusua := ut_session.getuser;
            tbic_clascore(nuIndice).clcrterm := ut_session.getterminal;
            tbic_clascore(nuIndice).clcrprog := sbPrograma;

            INSERT INTO tmpic_clascore VALUES tbic_clascore(nuIndice);
            tbDelete(nuDel) := 'delete ic_clascore WHERE clcrcorc = '||tbic_clascore(nuIndice).clcrcorc||';';
            nuDel := nuDel+1;

            if blClona then
                INSERT INTO ic_clascore VALUES tbic_clascore(nuIndice);
            END if;

            nuIndice := tbic_clascore.next(nuIndice);
        END loop;

        nuIndice := tbic_crcoreco.first;
        dbms_output.put_Line('tbic_crcoreco  '||tbic_crcoreco.count);
        loop
            exit when nuIndice IS null;
            tbic_crcoreco(nuIndice).ccrcfecr := sysdate;
            tbic_crcoreco(nuIndice).ccrcusua := ut_session.getuser;
            tbic_crcoreco(nuIndice).ccrcterm := ut_session.getterminal;
            tbic_crcoreco(nuIndice).ccrcprog := sbPrograma;

            dbms_output.put_Line(tbic_crcoreco(nuIndice).ccrccons);
            INSERT INTO tmpic_crcoreco VALUES tbic_crcoreco(nuIndice);
            tbDelete(nuDel) := 'delete ic_crcoreco WHERE  ccrccorc = '||tbic_crcoreco(nuIndice).ccrccorc||';';
            nuDel := nuDel+1;

            if blClona then
                INSERT INTO ic_crcoreco VALUES tbic_crcoreco(nuIndice);
            END if;
            nuIndice := tbic_crcoreco.next(nuIndice);
        END loop;

        nuCcrcclcr := tbic_confreco.first;
        nuIndice := tbic_crcoreco.first;

        dbms_output.put_Line(tbic_confreco.count||'  '||tbic_crcoreco.count);
        loop
            exit when nuCcrcclcr IS null;
            dbms_output.put_Line('Where General crcoreco: '||nuCcrcclcr||' | '||-1);
            for rcic_crcoreco in cuic_crcoreco (nuCcrcclcr,-1) loop
                rcic_crcoreco.ccrccons := SQ_IC_CRCORECO_CCRCCONS.nextval;
                rcic_crcoreco.ccrccorc := tbic_confreco(nuCcrcclcr).corccons;
                rcic_crcoreco.ccrcclcr := -1;
                rcic_crcoreco.ccrcfecr := sysdate;
                rcic_crcoreco.ccrcusua := ut_session.getuser;
                rcic_crcoreco.ccrcterm := ut_session.getterminal;
                rcic_crcoreco.ccrcprog := sbPrograma;

                INSERT INTO tmpic_crcoreco VALUES rcic_crcoreco;
                tbDelete(nuDel) := 'delete ic_crcoreco WHERE ccrccorc = '||rcic_crcoreco.ccrccorc||';';
                nuDel := nuDel+1;
                if blClona then
                    INSERT INTO ic_crcoreco VALUES rcic_crcoreco;
                END if;

                dbms_output.put_Line('null -> '||rcic_crcoreco.ccrccons||' '||rcic_crcoreco.ccrccorc||' '||rcic_crcoreco.ccrcclcr);
            END loop;

            nuCcrcclcr := tbic_confreco.next(nuCcrcclcr);
        END loop;


        nuIndice := tbic_recoclco.first;
        dbms_output.put_Line('tbic_recoclco  '||tbic_recoclco.count);
        loop
            exit when nuIndice IS null;
            tbic_recoclco(nuIndice).rcccfecr := sysdate;
            tbic_recoclco(nuIndice).rcccusua := ut_session.getuser;
            tbic_recoclco(nuIndice).rcccterm := ut_session.getterminal;
            tbic_recoclco(nuIndice).rcccprog := sbPrograma;

            INSERT INTO tmpic_recoclco VALUES tbic_recoclco(nuIndice);
            tbDelete(nuDel) := 'delete ic_recoclco WHERE rcccclcr  = '||tbic_recoclco(nuIndice).rcccclcr||';';
            nuDel := nuDel+1;

            if blClona then
                INSERT INTO ic_recoclco VALUES tbic_recoclco(nuIndice);
            END if;
            nuIndice := tbic_recoclco.next(nuIndice);
        END loop;

    EXCEPTION

        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);

        when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbErrorMessage);
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
    --}
    END GeneraDataClona;

    /*****************************************************************
    Propiedad intelectual de GDO. (c).

    Procedure	: ObtieneConfiguracion
    Descripcion	: Obtiene Configuración de un comprobante

    Parametros	:	Descripcion

    Retorno	:
	   onuErrorCode		Codigo del mensaje de Error Generado
	   			 0    - Proceso satisfactorio
				 <> 0 - Codigo del error
	   osbErrorMessage		Mensaje de Error

    Autor	   :
    Fecha	   :

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificación

    DD-MM-YYYY    <Autor>SAONNNNN
    Modificacion
    *****************************************************************/
    PROCEDURE ObtieneConfiguracion (blClona in boolean)
    IS
        nuCcrcclcr ic_crcoreco.ccrcclcr%type;
        nuIndice number;
        sbConfigura varchar2(2000);
    BEGIN
    --{
        -- Crea la configuración encontrada
        nuIndice := tbIC_COMPCONT.first;
        tbDelete(nuDel) := chr(10)||'IC_COMPCONT ';
        nuDel := nuDel+1;
        loop
            exit when nuIndice IS null;
            tbDelete(nuDel) :=
                            'COCOCODI	=	'||rcIC_COMPCONT.COCOCODI||chr(10)||
                            'COCOTCCO	=	'||rcIC_COMPCONT.COCOTCCO||chr(10)||
                            'COCODESC	=	'||rcIC_COMPCONT.COCODESC||chr(10)||
                            'COCOFECR	=	'||rcIC_COMPCONT.COCOFECR||chr(10)||
                            'COCOUSUA	=	'||rcIC_COMPCONT.COCOUSUA||chr(10)||
                            'COCOTERM	=	'||rcIC_COMPCONT.COCOTERM||chr(10)||
                            'COCOPROG	=	'||rcIC_COMPCONT.COCOPROG||chr(10)||
                            'COCOSIST	=	'||rcIC_COMPCONT.COCOSIST;
            nuDel := nuDel+1;
            nuIndice := tbIC_COMPCONT.next(nuIndice);
        END loop;


        nuIndice := tbic_confreco.first;
            tbDelete(nuDel) := chr(10)||'IC_CONFRECO ';
            nuDel := nuDel+1;
        loop
            exit when nuIndice IS null;
            tbDelete(nuDel) :=  'CORCCONS ='||tbic_confreco(nuIndice).CORCCOCO||chr(10)||
                                'CORCCOCO ='||tbic_confreco(nuIndice).CORCTIDO||chr(10)||
                                'CORCTIDO ='||tbic_confreco(nuIndice).CORCTIMO||chr(10)||
                                'CORCTIMO ='||tbic_confreco(nuIndice).CORCCRIT||chr(10)||
                                'CORCCRIT ='||tbic_confreco(nuIndice).CORCFECR||chr(10)||
                                'CORCFECR ='||tbic_confreco(nuIndice).CORCUSUA||chr(10)||
                                'CORCUSUA ='||tbic_confreco(nuIndice).CORCTERM||chr(10)||
                                'CORCTERM ='||tbic_confreco(nuIndice).CORCPROG||chr(10)||
                                'CORCPROG ='||tbic_confreco(nuIndice).CORCPROG||chr(10);
            nuDel := nuDel+1;
            nuIndice := tbic_confreco.next(nuIndice);
        END loop;


        nuIndice := tbic_auxicorc.first;
            tbDelete(nuDel) := chr(10)||'IC_AUXICORC ';
            nuDel := nuDel+1;
        loop
            exit when nuIndice IS null;
            tbDelete(nuDel) :=
                    'AUCRCONS ='||tbic_auxicorc(nuIndice).AUCRCONS||chr(10)||
                    'AUCRCORC ='||tbic_auxicorc(nuIndice).AUCRCORC||chr(10)||
                    'AUCRSIGN ='||tbic_auxicorc(nuIndice).AUCRSIGN||chr(10)||
                    'AUCRANME ='||tbic_auxicorc(nuIndice).AUCRANME||chr(10)||
                    'AUCRBARE ='||tbic_auxicorc(nuIndice).AUCRBARE||chr(10)||
                    'AUCRBATR ='||tbic_auxicorc(nuIndice).AUCRBATR||chr(10)||
                    'AUCRCALE ='||tbic_auxicorc(nuIndice).AUCRCALE||chr(10)||
                    'AUCRCATE ='||tbic_auxicorc(nuIndice).AUCRCATE||chr(10)||
                    'AUCRCECO ='||tbic_auxicorc(nuIndice).AUCRCECO||chr(10)||
                    'AUCRCICL ='||tbic_auxicorc(nuIndice).AUCRCICL||chr(10)||
                    'AUCRCLDP ='||tbic_auxicorc(nuIndice).AUCRCLDP||chr(10)||
                    'AUCRCLIE ='||tbic_auxicorc(nuIndice).AUCRCLIE||chr(10)||
                    'AUCRCONC ='||tbic_auxicorc(nuIndice).AUCRCONC||chr(10)||
                    'AUCRCUPO ='||tbic_auxicorc(nuIndice).AUCRCUPO||chr(10)||
                    'AUCRDOSO ='||tbic_auxicorc(nuIndice).AUCRDOSO||chr(10)||
                    'AUCREDDE ='||tbic_auxicorc(nuIndice).AUCREDDE||chr(10)||
                    'AUCRFETR ='||tbic_auxicorc(nuIndice).AUCRFETR||chr(10)||
                    'AUCRFOPA ='||tbic_auxicorc(nuIndice).AUCRFOPA||chr(10)||
                    'AUCRNIBR ='||tbic_auxicorc(nuIndice).AUCRNIBR||chr(10)||
                    'AUCRNIBT ='||tbic_auxicorc(nuIndice).AUCRNIBT||chr(10)||
                    'AUCRNICA ='||tbic_auxicorc(nuIndice).AUCRNICA||chr(10)||
                    'AUCRNIPS ='||tbic_auxicorc(nuIndice).AUCRNIPS||chr(10)||
                    'AUCRNITE ='||tbic_auxicorc(nuIndice).AUCRNITE||chr(10)||
                    'AUCRNUFA ='||tbic_auxicorc(nuIndice).AUCRNUFA||chr(10)||
                    'AUCRPROY ='||tbic_auxicorc(nuIndice).AUCRPROY||chr(10)||
                    'AUCRSERV ='||tbic_auxicorc(nuIndice).AUCRSERV||chr(10)||
                    'AUCRSICI ='||tbic_auxicorc(nuIndice).AUCRSICI||chr(10)||
                    'AUCRSIFA ='||tbic_auxicorc(nuIndice).AUCRSIFA||chr(10)||
                    'AUCRSIPR ='||tbic_auxicorc(nuIndice).AUCRSIPR||chr(10)||
                    'AUCRSIRE ='||tbic_auxicorc(nuIndice).AUCRSIRE||chr(10)||
                    'AUCRSUCA ='||tbic_auxicorc(nuIndice).AUCRSUCA||chr(10)||
                    'AUCRTIBR ='||tbic_auxicorc(nuIndice).AUCRTIBR||chr(10)||
                    'AUCRTICA ='||tbic_auxicorc(nuIndice).AUCRTICA||chr(10)||
                    'AUCRTIUO ='||tbic_auxicorc(nuIndice).AUCRTIUO||chr(10)||
                    'AUCRUNNE ='||tbic_auxicorc(nuIndice).AUCRUNNE||chr(10)||
                    'AUCRVABA ='||tbic_auxicorc(nuIndice).AUCRVABA||chr(10)||
                    'AUCRUBG1 ='||tbic_auxicorc(nuIndice).AUCRUBG1||chr(10)||
                    'AUCRUBG2 ='||tbic_auxicorc(nuIndice).AUCRUBG2||chr(10)||
                    'AUCRUBG3 ='||tbic_auxicorc(nuIndice).AUCRUBG3||chr(10)||
                    'AUCRUBG4 ='||tbic_auxicorc(nuIndice).AUCRUBG4||chr(10)||
                    'AUCRUBG5 ='||tbic_auxicorc(nuIndice).AUCRUBG5||chr(10)||
                    'AUCRUNCO ='||tbic_auxicorc(nuIndice).AUCRUNCO||chr(10)||
                    'AUCRSUBA ='||tbic_auxicorc(nuIndice).AUCRSUBA||chr(10)||
                    'AUCRDIPR ='||tbic_auxicorc(nuIndice).AUCRDIPR||chr(10)||
                    'AUCRCLIT ='||tbic_auxicorc(nuIndice).AUCRCLIT||chr(10)||
                    'AUCRTITR ='||tbic_auxicorc(nuIndice).AUCRTITR||chr(10)||
                    'AUCRBACO ='||tbic_auxicorc(nuIndice).AUCRBACO||chr(10)||
                    'AUCRITEM ='||tbic_auxicorc(nuIndice).AUCRITEM||chr(10);
            nuDel := nuDel+1;
            nuIndice := tbic_auxicorc.next(nuIndice);
        END loop;


        nuIndice := tbic_clascore.first;
            tbDelete(nuDel) := chr(10)||'IC_CLASCORE ';
            nuDel := nuDel+1;
        loop
            exit when nuIndice IS null;
            tbDelete(nuDel) :=
                    'CLCRCONS ='||tbic_clascore(nuIndice).CLCRCONS||chr(10)||
                    'CLCRCORC ='||tbic_clascore(nuIndice).CLCRCORC||chr(10)||
                    'CLCRCLCO ='||tbic_clascore(nuIndice).CLCRCLCO||chr(10)||
                    'CLCRCRIT ='||tbic_clascore(nuIndice).CLCRCRIT||chr(10)||
                    'CLCRFECR ='||tbic_clascore(nuIndice).CLCRFECR||chr(10)||
                    'CLCRUSUA ='||tbic_clascore(nuIndice).CLCRUSUA||chr(10)||
                    'CLCRTERM ='||tbic_clascore(nuIndice).CLCRTERM||chr(10)||
                    'CLCRPROG ='||tbic_clascore(nuIndice).CLCRPROG||chr(10);
            nuDel := nuDel+1;
            nuIndice := tbic_clascore.next(nuIndice);
        END loop;

        nuIndice := tbic_crcoreco.first;
        tbDelete(nuDel) := chr(10)||'IC_CRCORECO ';
        nuDel := nuDel+1;
        loop
            exit when nuIndice IS null;
            tbDelete(nuDel) :=
                    'CCRCCONS ='||tbic_crcoreco(nuIndice).CCRCCONS||chr(10)||
                    'CCRCCORC ='||tbic_crcoreco(nuIndice).CCRCCORC||chr(10)||
                    'CCRCCLCR ='||tbic_crcoreco(nuIndice).CCRCCLCR||chr(10)||
                    'CCRCCAMP ='||tbic_crcoreco(nuIndice).CCRCCAMP||chr(10)||
                    'CCRCOPER ='||tbic_crcoreco(nuIndice).CCRCOPER||chr(10)||
                    'CCRCVALO ='||tbic_crcoreco(nuIndice).CCRCVALO||chr(10)||
                    'CCRCFECR ='||tbic_crcoreco(nuIndice).CCRCFECR||chr(10)||
                    'CCRCUSUA ='||tbic_crcoreco(nuIndice).CCRCUSUA||chr(10)||
                    'CCRCTERM ='||tbic_crcoreco(nuIndice).CCRCTERM||chr(10)||
                    'CCRCPROG ='||tbic_crcoreco(nuIndice).CCRCPROG||chr(10);
            nuDel := nuDel+1;
            nuIndice := tbic_crcoreco.next(nuIndice);
        END loop;


        nuCcrcclcr := tbic_confreco.first;
        nuIndice := tbic_crcoreco.first;
        loop
            exit when nuCcrcclcr IS null;
            tbDelete(nuDel) := chr(10)||'IC_CRCORECO ';
            nuDel := nuDel+1;
            for rcic_crcoreco in cuic_crcoreco (nuCcrcclcr,-1) loop
                tbDelete(nuDel) :=
                        'CCRCCONS ='||rcic_crcoreco.CCRCCONS||chr(10)||
                        'CCRCCORC ='||rcic_crcoreco.CCRCCORC||chr(10)||
                        'CCRCCLCR ='||rcic_crcoreco.CCRCCLCR||chr(10)||
                        'CCRCCAMP ='||rcic_crcoreco.CCRCCAMP||chr(10)||
                        'CCRCOPER ='||rcic_crcoreco.CCRCOPER||chr(10)||
                        'CCRCVALO ='||rcic_crcoreco.CCRCVALO||chr(10)||
                        'CCRCFECR ='||rcic_crcoreco.CCRCFECR||chr(10)||
                        'CCRCUSUA ='||rcic_crcoreco.CCRCUSUA||chr(10)||
                        'CCRCTERM ='||rcic_crcoreco.CCRCTERM||chr(10)||
                        'CCRCPROG ='||rcic_crcoreco.CCRCPROG||chr(10);
                nuDel := nuDel+1;
            END loop;
            nuCcrcclcr := tbic_confreco.next(nuCcrcclcr);
        END loop;

        nuIndice := tbic_recoclco.first;
        tbDelete(nuDel) := chr(10)||'IC_RECOCLCO ';
        nuDel := nuDel+1;
        loop
            exit when nuIndice IS null;
            tbDelete(nuDel) :=
                    'RCCCCONS ='||tbic_recoclco(nuIndice).RCCCCONS||chr(10)||
                    'RCCCCLCR ='||tbic_recoclco(nuIndice).RCCCCLCR||chr(10)||
                    'RCCCNATU ='||tbic_recoclco(nuIndice).RCCCNATU||chr(10)||
                    'RCCCVALO ='||tbic_recoclco(nuIndice).RCCCVALO||chr(10)||
                    'RCCCCUCO ='||tbic_recoclco(nuIndice).RCCCCUCO||chr(10)||
                    'RCCCFECR ='||tbic_recoclco(nuIndice).RCCCFECR||chr(10)||
                    'RCCCUSUA ='||tbic_recoclco(nuIndice).RCCCUSUA||chr(10)||
                    'RCCCTERM ='||tbic_recoclco(nuIndice).RCCCTERM||chr(10)||
                    'RCCCPROG ='||tbic_recoclco(nuIndice).RCCCPROG||chr(10)||
                    'RCCCPOPA ='||tbic_recoclco(nuIndice).RCCCPOPA||chr(10)||
                    'RCCCPORE ='||tbic_recoclco(nuIndice).RCCCPORE||chr(10);
            nuDel := nuDel+1;

            nuIndice := tbic_recoclco.next(nuIndice);
        END loop;

    EXCEPTION

        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);

        when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbErrorMessage);
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
    --}
    END ObtieneConfiguracion;

PROCEDURE Initialize is
BEGIN
--{

    pkErrors.Push('LDCI_IFRS.ClonaComprobanteIFRS.Initialize');

    -- Inicializa variables de Error

    pkErrors.Initialize;

    onuErrorCode 	:= pkConstante.EXITO;
    osbErrorMessage	:= pkConstante.NULLSB;

    begin
        sbSentencia := 'delete from tmpic_compcont';
        execute immediate sbSentencia;
        sbSentencia := 'delete from tmpic_ConfReco';
        execute immediate sbSentencia;
        sbSentencia := 'delete from tmpic_clascore';
        execute immediate sbSentencia;
        sbSentencia := 'delete from tmpic_recoclco';
        execute immediate sbSentencia;
        sbSentencia := 'delete from tmpic_auxicorc';
        execute immediate sbSentencia;
        sbSentencia := 'delete from tmpic_crcoreco';
        execute immediate sbSentencia;

     EXCEPTION
    when others then
        null;
    END;

    begin
        sbSentencia := 'create table tmpic_compcont AS SELECT * FROM ic_compcont WHERE 1= 2';
        execute immediate sbSentencia;
        sbSentencia := 'create table tmpic_ConfReco AS SELECT * FROM ic_ConfReco WHERE 1= 2';
        execute immediate sbSentencia;
        sbSentencia := 'create table tmpic_clascore AS SELECT * FROM ic_clascore WHERE 1= 2';
        execute immediate sbSentencia;
        sbSentencia := 'create table tmpic_recoclco AS SELECT * FROM ic_recoclco WHERE 1= 2';
        execute immediate sbSentencia;
        sbSentencia := 'create table tmpic_auxicorc AS SELECT * FROM ic_auxicorc WHERE 1= 2';
        execute immediate sbSentencia;
        sbSentencia := 'create table tmpic_crcoreco AS SELECT * FROM ic_crcoreco WHERE 1= 2';
        execute immediate sbSentencia;
    EXCEPTION when others then
        null;
    END;

    pkErrors.Pop;

--}
END Initialize;

PROCEDURE UnInstall is
BEGIN
--{

    pkErrors.Push('LDCI_IFRS.ClonaComprobanteIFRS.UnInstall');

    begin
        sbSentencia := 'drop table tmpic_compcont';
        execute immediate sbSentencia;
        sbSentencia := 'drop table tmpic_ConfReco';
        execute immediate sbSentencia;
        sbSentencia := 'drop table tmpic_clascore';
        execute immediate sbSentencia;
        sbSentencia := 'drop table tmpic_recoclco';
        execute immediate sbSentencia;
        sbSentencia := 'drop table tmpic_auxicorc';
        execute immediate sbSentencia;
        sbSentencia := 'drop table tmpic_crcoreco';
        execute immediate sbSentencia;
    EXCEPTION when others then
        null;
    END;

    pkErrors.Pop;

--}
END UnInstall;

/* -------------------------------------------------------------- */

PROCEDURE ClearMemory IS
BEGIN
--{

    pkErrors.Push('LDCI_IFRS.ClonaComprobanteIFRS.ClearMemory');

    -- Limpia toda la memoria cache
    tbIC_COMPCONT.delete;
    tbic_confreco.delete;
    tbic_clascore.delete;
    tbic_recoclco.delete;
    tbic_auxicorc.delete;
    tbic_crcoreco.delete;
    IfrstbConfreco.delete;
    AlltbConfreco.delete;

    tbLlaveConfreco.delete;
    tbLlaveCLascore.delete;
    tbLlaveRecoclco.delete;
    tbLlaveCrcoreco.delete;
    tbLlaveAuxicorc.delete;

    tbConfreco.delete;
    tbClascore.delete;
    tbRecoclco.delete;
    tbClascoreBusca.delete;

    pkErrors.Pop;

--}
END ClearMemory;


    /*****************************************************************
    Propiedad intelectual de GDO. (c).

    Procedure	: ClonaComprobanteIFRS
    Descripcion	: Proceso principal para ejecutar clonación

    Parametros	:	Descripcion


    Retorno	:
	   onuErrorCode		Codigo del mensaje de Error Generado
	   			 0    - Proceso satisfactorio
				 <> 0 - Codigo del error
	   osbErrorMessage		Mensaje de Error

    Autor	: <Nombre Apellido del Autor>
    Fecha	: <DD-MM-YYYY>

    Historia de Modificaciones
    Fecha	   IDEntrega

    DD-MM-YYYY    <Autor>SAONNNNN
    Modificacion
    ******************************************************************/
    PROCEDURE ClonaComprobanteIFRS (nuTipoComprobante in number ,
                          nuComprobante in number,
                          sbCuenta in varchar2,
                          blGraba in boolean)
    IS
        --------------------------------------------------------------------
        -- Constantes
        --------------------------------------------------------------------
        --------------------------------------------------------------------
        -- Variables
        --------------------------------------------------------------------
        --------------------------------------------------------------------
        -- Cursores
        --------------------------------------------------------------------
        /* ***************************************************************** */
        /* ********              Metodos Encapsulados               ******** */
        /* ***************************************************************** */


        /* ***************************************************************** */

    BEGIN
    --{
        pkErrors.Push('LDCI_IFRS.ClonaComprobanteIFRS');

        -- Inicializa variables para proceso
        Initialize;

        -- Limpia memoria cache
        ClearMemory;

        -- Inicializa secuencias
        InitSequence;

        -- Carga Datos en memoria
        dbms_output.put_Line(nuTipoComprobante||','||nuComprobante||','||sbCuenta);
        CargaDatosIFRS(nuTipoComprobante, nuComprobante, sbCuenta);

        -- Genera datos en tablas
        GeneraDataIFRS (blGraba) ;

        -- Desintala objetos creados

        /*
        dbms_output.put_Line('Datos a Borrar '||tbDelete.count);
        nuIndice := tbDelete.last;
        loop
            exit when nuIndice IS null;
            dbms_output.put_Line(tbDelete(nuIndice));
            nuIndice := tbDelete.prior(nuIndice);
        END loop;
        */
        if blGraba then
            --UnInstall;
            null;
        END if;

    pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
        when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbErrorMessage);
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
    --}
    END ClonaComprobanteIFRS;


    /*****************************************************************
    Propiedad intelectual de GDO. (c).

    Procedure	: ClonaComprobante
    Descripcion	: Proceso principal para ejecutar clonación

    Parametros	:	Descripcion


    Retorno	:
	   onuErrorCode		Codigo del mensaje de Error Generado
	   			 0    - Proceso satisfactorio
				 <> 0 - Codigo del error
	   osbErrorMessage		Mensaje de Error

    Autor	: <Nombre Apellido del Autor>
    Fecha	: <DD-MM-YYYY>

    Historia de Modificaciones
    Fecha	   IDEntrega

    DD-MM-YYYY    <Autor>SAONNNNN
    Modificacion
    ******************************************************************/
    PROCEDURE ClonaComprobante (nuComprobante in number,
                          blGraba in boolean)
    IS
        --------------------------------------------------------------------
        -- Constantes
        --------------------------------------------------------------------
        --------------------------------------------------------------------
        -- Variables
        --------------------------------------------------------------------
        --------------------------------------------------------------------
        -- Cursores
        --------------------------------------------------------------------
        /* ***************************************************************** */
        /* ********              Metodos Encapsulados               ******** */
        /* ***************************************************************** */

        /* ***************************************************************** */

    BEGIN
    --{
        pkErrors.Push('LDCI_IFRS.ClonaComprobante');

        -- Inicializa variables para proceso
        Initialize;

        -- Limpia memoria cache
        ClearMemory;

        -- Inicializa secuencias
        InitSequence;

        -- Carga Datos en memoria
        dbms_output.put_Line('Clona Comprobante: '||nuComprobante);
        CargaDatosClona(nuComprobante);

        -- Genera datos en tablas
        GeneraDataClona (blGraba) ;

        -- Desintala objetos creados
        --UnInstall;
        /*
        dbms_output.put_Line('Datos a Borrar '||tbDelete.count);
        nuIndice := tbDelete.last;
        loop
            exit when nuIndice IS null;
            dbms_output.put_Line(tbDelete(nuIndice));
            nuIndice := tbDelete.prior(nuIndice);
        END loop;
        */
        if blGraba then
            --UnInstall;
            null;
        END if;

    pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
        when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbErrorMessage);
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
    --}
    END ClonaComprobante;

    /************************************************************************* */

    /*****************************************************************
    Propiedad intelectual de GDO. (c).

    Procedure	: ObtieneComprobante
    Descripcion	: Proceso principal para obtener la configuración de un comprobante

    Parametros	:	Descripcion


    Retorno	:
	   onuErrorCode		Codigo del mensaje de Error Generado
	   			 0    - Proceso satisfactorio
				 <> 0 - Codigo del error
	   osbErrorMessage		Mensaje de Error

    Autor	: <Nombre Apellido del Autor>
    Fecha	: <DD-MM-YYYY>

    Historia de Modificaciones
    Fecha	   IDEntrega

    DD-MM-YYYY    <Autor>SAONNNNN
    Modificacion
    ******************************************************************/
    PROCEDURE ObtieneComprobante (nuComprobante in number)
    IS
        --------------------------------------------------------------------
        -- Constantes
        --------------------------------------------------------------------
        --------------------------------------------------------------------
        -- Variables
        --------------------------------------------------------------------
        --------------------------------------------------------------------
        -- Cursores
        --------------------------------------------------------------------
        /* ***************************************************************** */
        /* ********              Metodos Encapsulados               ******** */
        /* ***************************************************************** */

        /* ***************************************************************** */

    BEGIN
    --{
        pkErrors.Push('LDCI_IFRS.ObtieneComprobante');

        -- Inicializa variables para proceso
        Initialize;

        -- Limpia memoria cache
        ClearMemory;

        -- Carga Datos en memoria
        CargaDatosClona(nuComprobante);

        -- Genera datos en tablas
        ObtieneConfiguracion (TRUE) ;

        nuIndice := tbDelete.first;
        loop
            exit when nuIndice IS null;
            dbms_output.put_Line(tbDelete(nuIndice));
            nuIndice := tbDelete.next(nuIndice);
        END loop;

    pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
        when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbErrorMessage);
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
    --}
    END ObtieneComprobante;

    /************************************************************************* */

    PROCEDURE SetCuenta
    IS
        CURSOR culdc_ctaifrs IS
        SELECT *
        FROM ldci_ctaifrs;
    BEGIN
        pkErrors.Push('LDCI_IFRS.SetCuenta');

        for rcCta in culdc_ctaifrs loop
            tbrcCuentas(rcCta.ctaOrigen).sbCtaOrigen := rcCta.ctaOrigen;
            tbrcCuentas(rcCta.ctaOrigen).sbCtaDestino := rcCta.ctaDestino;

        END loop;

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
        when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbErrorMessage);
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
    --}
    END SetCuenta;

    /************************************************************************ */

PROCEDURE GetConfigura (nuTipoComprobante in number ,
                        nuComprobante in number,
                        sbCuenta in varchar2)
IS
    type tycuDatos  is ref cursor;
    cuDatos tycuDatos;

    type tyrcDatos IS record (
        tccocodi ic_ticocont.tccocodi%type,
        tccodesc ic_ticocont.tccodesc%type,
        cococodi ic_compcont.cococodi%type,
        cocodesc ic_compcont.cocodesc%type
        );

    sbQuery varchar2(2000);
    rcDatos tyrcDatos;

BEGIN
    sbQuery := ' SELECT unique
                        tccocodi,tccodesc,
                        cococodi,cocodesc
                    FROM ic_clascore, ic_clascont, ic_confreco, ic_compcont, ic_ticocont, ic_tipodoco,ic_recoclco
                    WHERE rccccuco like (:sbCondicion)
                    AND rcccclcr = clcrcons
                    AND clcocodi = clcrclco
                    AND corccons = clcrcorc
                    AND cococodi = corccoco
                    AND cocotcco = tccocodi
                    AND corctido = tidccodi
                    AND cocotcco = decode(:1,-1,cocotcco,:2)
                    AND cococodi = decode(:3,-1,cococodi,:4)
                    ORDER BY tccocodi,cococodi';

     open cuDatos for sbQuery using sbCuenta, nuTipoComprobante, nuTipoComprobante, nuComprobante, nuComprobante;
     -- Recorre las cuentas que tienen el patron de busqueda
     loop --cuentas
        fetch cuDatos INTO rcDatos;
        exit when cuDatos%notfound;
        dbms_output.put_Line(rcDatos.tccocodi||'  '||rcDatos.tccodesc||'  '||rcDatos.cococodi||'  '||rcDatos.cocodesc);
     end loop;

END;

BEGIN
    SetCuenta;
END LDCI_IFRS;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_IFRS', 'ADM_PERSON'); 
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_IFRS to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_IFRS to INTEGRADESA;
/



