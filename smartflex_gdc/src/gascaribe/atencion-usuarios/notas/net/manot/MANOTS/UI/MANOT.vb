Imports System.Collections.Generic
Imports OpenSystems.Windows.Controls
Imports LUDYCOM.MANOT.ENTITIES
Imports LUDYCOM.MANOT.BL
Imports System.Data
Imports OpenSystems.Common.Data

Partial Public Class MANOT
    Inherits OpenForm

    'Declaraciones
    Dim Open As New OSF
    Dim BL As New BLMANOTS

    Private _valorReg As Decimal

    Public Property valorReg As Decimal
        Get
            Return _valorReg
        End Get
        Set(ByVal value As Decimal)
            _valorReg = value
        End Set
    End Property

    Private _valorN As Decimal

    Public Property valorN As Decimal
        Get
            Return _valorN
        End Get
        Set(ByVal value As Decimal)
            _valorN = value
        End Set
    End Property

    Private _stateReg As Integer

    Public Property stateReg As Integer
        Get
            Return _stateReg
        End Get
        Set(ByVal value As Integer)
            _stateReg = value
        End Set
    End Property

#Region "Formulario"

#Region "Inicializacion"

    Public Sub New(ByVal SubcriptionId As Integer)

        'MsgBox("prueba dvm")

        ' Llamada necesaria para el diseñador.
        InitializeComponent()

        ' Agregue cualquier inicialización después de la llamada a InitializeComponent().
        If IsNumeric(SubcriptionId) Then
            'Se asigna el contrato a la variable global
            Contrato.ID = SubcriptionId
            TxtProducto.Text = Contrato.ID
            Call CargarCombosGrid("CONFIGURACION INICIAL", "Inicial")
            Contrato.CadenaServicioSeleccionado = CmbServicio.Text
            If CmbServicio.SelectedValue = Nothing Then
                BtnGrabar.Enabled = False
                BtnProyeccion.Enabled = False
            End If
        End If

    End Sub

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Se oculta el tab proyeccion y se establecen los estilos de la ventana.
        TabProyeccion.Parent = Nothing
        Call UI("Inicial")
    End Sub

#End Region

#Region "Controles"

#Region "UI"

    Sub UI(Optional ByVal Fase As String = "")
        'If Grid.Rows.Count = 0 Then
        '    Grid.Rows.Add()
        'End If
        If Fase = "Inicial" Then
            'Form
            Me.Text += " | " + TipoConexion

            'Formulario
            Me.BackColor = Open.BodyColor

            '-- Paneles
            TableLayoutPanel1.BackColor = Open.BodyColor
            TLayoutPanelProy.BackColor = Open.BodyColor
            Panel1.BackColor = Open.BandButtonColor
            Panel2.BackColor = Open.BandButtonColor

            '-- TabPages
            TabPrincipal.BackColor = Open.TabColor
            TabProyeccion.BackColor = Open.TabColor

            '-- Grid
            With Grid
                '.BackgroundColor = Open.BodyColor
                .RowsDefaultCellStyle.SelectionBackColor = Open.GridSelectionColor
                .ColumnHeadersDefaultCellStyle.BackColor = Open.GridHeaderColor
                .RowsDefaultCellStyle.BackColor = Open.TextControlBlockedColor
            End With

            With GridDeuda
                .BackgroundColor = Open.BodyColor
                .RowsDefaultCellStyle.SelectionBackColor = Open.GridSelectionColor
                .RowsDefaultCellStyle.BackColor = Open.TextControlBlockedColor
                .ColumnHeadersDefaultCellStyle.BackColor = Open.GridHeaderColor
            End With

            With GridProyeccion
                .BackgroundColor = Open.BodyColor
                .RowsDefaultCellStyle.SelectionBackColor = Open.GridSelectionColor
                .RowsDefaultCellStyle.BackColor = Open.TextControlBlockedColor
                .ColumnHeadersDefaultCellStyle.BackColor = Open.GridHeaderColor
            End With
        End If
        '***** Se ejecuta siempre *****
        With GridDeuda
            If .Columns.Count = 7 Then
                With .Columns(0)
                    .HeaderText = "Producto"
                    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                    .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells
                End With
                With .Columns(1)
                    .HeaderText = "Concepto"
                    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                    .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells
                End With
                With .Columns(2)
                    .HeaderText = "Descripción Concepto"
                    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft
                    .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells
                End With
                'With .Columns(3)
                '    .HeaderText = "Presente Mes"
                '    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                'End With
                'With .Columns(4)
                '    .HeaderText = "Diferido"
                '    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                'End With
                'With .Columns(5)
                '    .HeaderText = "Total Deuda"
                '    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                'End With
                'DANVAL 07-12-2018
                'SE APLICARON LAS NUEVAS COLUMNAS AL DISEÑO DEL GRID
                With .Columns(3)
                    .HeaderText = "Deuda Actual"
                    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                End With
                With .Columns(4)
                    .HeaderText = "Deuda Vencida"
                    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                End With
                With .Columns(5)
                    .HeaderText = "Diferido"
                    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                End With
                With .Columns(6)
                    .HeaderText = "Total Deuda"
                    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                End With
            End If
        End With

        With GridProyeccion
            If .Columns.Count = 7 Then
                With .Columns(0)
                    .HeaderText = "Producto"
                    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                    .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells
                End With
                With .Columns(1)
                    .HeaderText = "Concepto"
                    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                    .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells
                End With
                With .Columns(2)
                    .HeaderText = "Descripción Concepto"
                    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft
                    .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells
                End With
                'With .Columns(3)
                '    '.HeaderText = "Presente Mes"
                '    .HeaderText = "Deuda Corriente"
                '    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                'End With
                'With .Columns(4)
                '    .HeaderText = "Diferido"
                '    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                'End With
                'With .Columns(5)
                '    .HeaderText = "Total Deuda"
                '    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                'End With
                'DANVAL 07-12-2018
                'SE APLICARON LAS NUEVAS COLUMNAS AL DISEÑO DEL GRID
                With .Columns(3)
                    .HeaderText = "Deuda Actual"
                    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                End With
                With .Columns(4)
                    .HeaderText = "Deuda Vencida"
                    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                End With
                With .Columns(5)
                    .HeaderText = "Diferido"
                    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                End With
                With .Columns(6)
                    .HeaderText = "Total Deuda"
                    .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                End With
            End If
        End With

        '-- Line
        'LineShape1.SelectionColor = Open.LineColor
        'LineShape1.BorderColor = Open.LineColor
    End Sub

#End Region

#Region "Botones"

    Private Sub BtnProyeccion_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnProyeccion.Click
        'mostrarProyeccionTab()
    End Sub



#End Region

    Private Sub TabControl1_Selected(ByVal sender As Object, ByVal e As System.Windows.Forms.TabControlEventArgs) Handles TabControl1.Selected
        'Oculto la pestaña Proyección cuando el usuario 
        'If TabControl1.SelectedTab.Name = "TabPrincipal" Then
        '    TabProyeccion.Parent = Nothing
        'End If
    End Sub

    Private Sub CmbServicio_SelectedValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles CmbServicio.SelectedValueChanged
        If Not CmbServicio.SelectedValue = Nothing Then
            'MsgBox(CmbServicio.SelectedValue.ToString)
            Contrato.ProductoSeleccionado = CmbServicio.SelectedValue
            Contrato.CadenaServicioSeleccionado = CmbServicio.Text
        End If
    End Sub

#End Region

#End Region

#Region "GRID EVENTS"

    'Procedimiento que controla los eventos de los DatagridviewComboboxColumn
    Sub ProcesarNovedad(ByRef Grid As DataGridView, ByVal Columna As String, ByVal Novedad As String, Optional ByVal CtaCobro As Int64 = 0, Optional ByVal Concepto As Int64 = 0, Optional ByVal Cuotas As Int64 = 0)

        'Solo se ejecutan las acciones mientras se haya seleccionado un producto.
        If Not Contrato.ProductoSeleccionado = Nothing Then
            With Grid
                Select Case Columna

                    Case "ColComboNovedad"
                        '########    Columna Novedad    ########

                        'Borro el contenido de la fila
                        'Call BL.GridBorrarFila(Grid, Grid.CurrentRow.Index, IdNovedad)

                        'Paso la fila actual para que se habiliten los campos segun la novedad seleccionada
                        Call Me.EditarFila(Novedad, .Rows(.CurrentRow.Index))
                        .CurrentRow.Cells("ColValor").Value = 0

                        Select Case Novedad
                            ' **** TIPOS DE NOVEDAD ****
                            Case "AD"
                                ' **** TIPOS DE NOVEDAD **** ACREDITAR DEUDA
                                .CurrentRow.Cells("ColValor").Value = BL.BL_ObtenerDeudaCorrienteProducto(Contrato.ProductoSeleccionado)

                            Case "AC"
                                ' **** TIPOS DE NOVEDAD **** ACREDITAR POR CONCEPTO
                                Call Me.CargarCombosGrid(Novedad, "ConceptosProducto")

                            Case "ACC", "DCC"
                                ' **** TIPOS DE NOVEDAD **** ACREDITAR POR CUENTA DE COBRO
                                Call Me.CargarCombosGrid(Novedad, "CtasCobroProducto")

                            Case "ACCC", "DCCC"
                                ' **** TIPOS DE NOVEDAD **** ACREDITAR POR CUENTA DE COBRO Y CONCEPTO
                                Call Me.CargarCombosGrid(Novedad, "CtasCobroProducto")

                            Case "DC"
                                ' **** TIPOS DE NOVEDAD **** DEBITAR POR CONCEPTO
                                Call Me.CargarCombosGrid(Novedad, "ConceptosProducto")

                        End Select


                    Case "ColComboCtaCobro"

                        .CurrentRow.Cells("ColValor").Value = 0

                        Select Case Novedad

                            Case "ACC", "DCC"
                                ' **** TIPOS DE NOVEDAD **** ACREDITAR POR CUENTA DE COBRO
                                Contrato.CtaCobroSeleccionada = CtaCobro
                                .CurrentRow.Cells("ColValor").Value = BL.BL_ObtenerDeudaCtaCobro(Contrato.ProductoSeleccionado, NotaActual.CuentadeCobro)

                            Case "ACCC", "DCCC"
                                ' **** TIPOS DE NOVEDAD **** ACREDITAR POR CUENTA DE COBRO Y CONCEPTO
                                Call Me.CargarCombosGrid(Novedad, "ConceptosCtaCobro")

                        End Select 'Novedad

                    Case "ColComboConcepto"
                        valorN = 0
                        .CurrentRow.Cells("ColValor").Value = 0
                        valorReg = 0
                        Select Case Novedad
                            Case "AC"
                                ' **** TIPOS DE NOVEDAD **** ACREDITAR POR CONCEPTO
                                .CurrentRow.Cells("ColValor").Value = BL.BL_ObtenerDeudaConcepto(Contrato.ProductoSeleccionado, inuConcepto:=Concepto)
                                valorReg = .CurrentRow.Cells("ColValor").Value
                                stateReg = 1
                            Case "ACC", "DCC"
                                ' **** TIPOS DE NOVEDAD **** ACREDITAR POR CONCEPTO
                                .CurrentRow.Cells("ColValor").Value = BL.BL_ObtenerDeudaConcepto(Contrato.ProductoSeleccionado, inuConcepto:=Concepto)
                                valorReg = .CurrentRow.Cells("ColValor").Value
                                stateReg = 1
                            Case "ACCC", "DCCC"
                                ' **** TIPOS DE NOVEDAD **** ACREDITAR POR CUENTA DE COBRO Y CONCEPTO
                                .CurrentRow.Cells("ColValor").Value = BL.BL_ObtenerDeudaConceptoCtaCobro(inuCuenCobr:=Contrato.NotaActual.CuentadeCobro, inuConcepto:=Concepto)
                                valorReg = .CurrentRow.Cells("ColValor").Value
                                stateReg = 1
                            Case "DC"
                                ' **** TIPOS DE NOVEDAD **** DEBITAR POR CONCEPTO
                                .CurrentRow.Cells("ColValor").Value = 0
                                '.CurrentRow.Cells("ColValor").Value = BL.BL_ObtenerDeudaConcepto(Contrato.ProductoSeleccionado, inuConcepto:=Concepto)
                                stateReg = 0
                        End Select 'Concepto

                    Case "ColCuotas"
                        If .Columns(Columna).ReadOnly = False And NotaActual.Cuotas >= 0 Then
                            Call Me.CargarCombosGrid(Novedad, "PlanesFinanciacion")
                        End If
                        stateReg = 0
                End Select 'Columna
            End With
        End If
    End Sub

    Private Sub Grid_RowsAdded(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewRowsAddedEventArgs) Handles Grid.RowsAdded
        With Grid.Rows(e.RowIndex)
            .DefaultCellStyle.BackColor = Open.TextControlBlockedColor
            .ReadOnly = True
            .Cells(ColComboNovedad.DisplayIndex).ReadOnly = False
            .Cells(ColComboNovedad.DisplayIndex).Style.BackColor = Color.White
            .Cells(ColComboCausaCargo.DisplayIndex).ReadOnly = False
            .Cells(ColComboCausaCargo.DisplayIndex).Style.BackColor = Color.White
        End With
    End Sub

    Public Function EditarFila(ByVal IdNovedad As String, ByRef MyRow As DataGridViewRow)

        With MyRow
            'Coloco toda la fila ReadOnly para habilitar las celdas segun la novedad seleccionada
            .ReadOnly = True
            .DefaultCellStyle.BackColor = Open.TextControlBlockedColor
            .Cells("ColComboCtaCobro").Style.BackColor = Open.TextControlBlockedColor
            .Cells("ColComboConcepto").Style.BackColor = Open.TextControlBlockedColor
            .Cells("ColComboPlanDife").Style.BackColor = Open.TextControlBlockedColor

            With Grid
                .CurrentRow.Cells("ColComboCtaCobro") = New DataGridViewTextBoxCell
                .CurrentRow.Cells("ColComboConcepto") = New DataGridViewTextBoxCell
                .CurrentRow.Cells("ColComboPlanDife") = New DataGridViewTextBoxCell
                .CurrentRow.Cells("ColValor") = New DataGridViewTextBoxCell
                .CurrentRow.Cells("ColCuotas") = New DataGridViewTextBoxCell
            End With

            'Habilito las columnas Novedad y Causa Cargo.
            .Cells("ColComboNovedad").ReadOnly = False : .Cells("ColComboNovedad").Style.BackColor = Color.White
            .Cells("ColComboCausaCargo").ReadOnly = False : .Cells("ColComboCausaCargo").Style.BackColor = Color.White

            'ColComboNovedad
            'ColComboConcepto
            'ColComboCtaCobro
            'ColValor
            'ColComboCausaCargo
            'ColCuotas
            'ColComboPlanDife

            Select Case IdNovedad
                Case "AD"
                    'ACREDITAR(DEUDA)

                Case "AC"
                    'ACREDITAR POR CONCEPTO

                    'Habilitar campo Concepto
                    .Cells("ColComboConcepto").ReadOnly = False : .Cells("ColComboConcepto").Style.BackColor = Color.White
                    'Habilitar campo Valor
                    .Cells("ColValor").ReadOnly = False : .Cells("ColValor").Style.BackColor = Color.White : .Cells("ColValor").Value = 0

                Case "ACC"
                    'ACREDITAR POR CUENTA DE COBRO

                    'Habilitar campo Cuenta de Cobro
                    .Cells("ColComboCtaCobro").ReadOnly = False : .Cells("ColComboCtaCobro").Style.BackColor = Color.White
                    'Habilitar campo Valor
                    .Cells("ColValor").ReadOnly = False : .Cells("ColValor").Style.BackColor = Color.White : .Cells("ColValor").Value = 0
                Case "DCC"
                    'ACREDITAR POR CUENTA DE COBRO

                    'Habilitar campo Cuenta de Cobro
                    .Cells("ColComboCtaCobro").ReadOnly = False : .Cells("ColComboCtaCobro").Style.BackColor = Color.White
                    'Habilitar campo Valor
                    .Cells("ColValor").Value = 0

                Case "ACCC", "DCCC"
                    'ACREDITAR POR CUENTA DE COBRO Y CONCEPTO

                    'Habilitar campo Concepto
                    .Cells("ColComboConcepto").ReadOnly = False : .Cells("ColComboConcepto").Style.BackColor = Color.White
                    'Habilitar campo Cuenta de Cobro
                    .Cells("ColComboCtaCobro").ReadOnly = False : .Cells("ColComboCtaCobro").Style.BackColor = Color.White
                    'Habilitar campo Valor
                    .Cells("ColValor").ReadOnly = False : .Cells("ColValor").Style.BackColor = Color.White : .Cells("ColValor").Value = 0

                Case "DC"
                    'DEBITAR POR CONCEPTO
                    'Habilitar campo Concepto
                    .Cells("ColComboConcepto").ReadOnly = False : .Cells("ColComboConcepto").Style.BackColor = Color.White
                    'Habilitar campo Valor
                    .Cells("ColValor").ReadOnly = False : .Cells("ColValor").Style.BackColor = Color.White : .Cells("ColValor").Value = 0
                    'Habilitar campo Numero de Cuotas
                    .Cells("ColCuotas").ReadOnly = False : .Cells("ColCuotas").Style.BackColor = Color.White
                    .Cells("ColComboPlanDife").ReadOnly = False : .Cells("ColComboPlanDife").Style.BackColor = Color.White

            End Select
        End With
        Return MyRow
    End Function

    Private Sub Grid_CurrentCellDirtyStateChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Grid.CurrentCellDirtyStateChanged
        With Grid
            'Esta instruccion Confirma inmediatamente los cambios en los 
            'controles ComboBoxColumn para obtener la propieda Value
            If .CurrentCell.ColumnIndex >= 0 Then
                If .Columns(.CurrentCell.ColumnIndex).Name <> "ColValor" And _
                    .Columns(.CurrentCell.ColumnIndex).Name <> "ColCuotas" And Grid.IsCurrentCellDirty = True Then
                    .CommitEdit(DataGridViewDataErrorContexts.Commit)
                End If
            End If
        End With
    End Sub

    Dim ingresoC As Boolean

    Private Sub Grid_CellValueChanged(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles Grid.CellValueChanged
        Dim Columna As String
        With Grid
            'Valido que se haya editado una celda
            If e.ColumnIndex >= 0 And e.RowIndex >= 0 Then
                'Valido que se haya seleccionado una novedad del combo
                If Not .CurrentRow.Cells("ColComboNovedad").Value = Nothing Then
                    If NotaActual Is Nothing Then
                        NotaActual = New NOTA
                    End If
                    'Se actualiza la novedad que el usuario esta editando en la fila actual
                    Contrato.NovedadSeleccionada = Grid.CurrentRow.Cells("ColComboNovedad").Value
                    NotaActual.Novedad = Grid.CurrentRow.Cells("ColComboNovedad").Value

                    If Not .CurrentRow.Cells("ColProducto").Value = Contrato.ProductoSeleccionado Then
                        'Inserto valor del Producto en la fila actual
                        .CurrentRow.Cells("ColProducto").Value = Contrato.ProductoSeleccionado
                    End If
                End If
                If Not .CurrentCell.Value = Nothing Then
                    'Establezco acciones segun la columna donde se produzcan los cambios
                    Columna = .Columns(e.ColumnIndex).Name

                    Select Case Columna
                        Case "ColComboNovedad"
                            ingresoC = True
                            valorReg = 0
                            Call ProcesarNovedad(Grid, Columna, Contrato.NovedadSeleccionada)
                            valorReg = .CurrentRow.Cells("ColValor").Value
                            stateReg = 1
                            ingresoC = False

                        Case "ColComboCtaCobro"
                            ingresoC = True
                            valorReg = 0
                            Dim CtaCobro As Int64 = Convert.ToInt64(.CurrentCell.Value.ToString)
                            NotaActual.CuentadeCobro = CtaCobro
                            'Ojo: Siempre pasar parametro con la estructura CtaCobro:=MiVariable para prevenir errores en el orden en que se envian.
                            Call ProcesarNovedad(Grid, Columna, Contrato.NovedadSeleccionada, CtaCobro:=NotaActual.CuentadeCobro)
                            valorReg = .CurrentRow.Cells("ColValor").Value
                            stateReg = 1
                            ingresoC = False

                        Case "ColComboConcepto"
                            ingresoC = True
                            valorReg = 0
                            Dim Concepto As Int64 = Convert.ToInt64(.CurrentCell.Value.ToString)
                            NotaActual.Concepto = Concepto
                            'Ojo: Siempre pasar parametro con la estructura Concepto:=MiVariable para prevenir errores en el orden en que se envian.
                            Call ProcesarNovedad(Grid, Columna, Contrato.NovedadSeleccionada, , Concepto:=NotaActual.Concepto)
                            valorReg = .CurrentRow.Cells("ColValor").Value
                            stateReg = 1
                            ingresoC = False

                        Case "ColCuotas"

                            With .CurrentRow.Cells(Columna)
                                If NotaActual.Novedad = "DC" And IsNumeric(.Value) And .ReadOnly = False Then
                                    Dim Valor As Int64 = Convert.ToInt64(.Value)
                                    NotaActual.Cuotas = Valor
                                    Call ProcesarNovedad(Grid, Columna, NotaActual.Novedad, Cuotas:=NotaActual.Cuotas)
                                Else
                                    Grid.CurrentRow.Cells("ColComboPlanDife") = New DataGridViewTextBoxCell
                                End If
                            End With

                        Case "ColValor"
                            With .CurrentRow.Cells(Columna)
                                If valorReg >= Grid.CurrentRow.Cells("ColValor").Value And stateReg = 1 Then
                                    If valorN = 0 Then
                                        valorN = Grid.CurrentRow.Cells("ColValor").Value
                                        stateReg = 0
                                    Else
                                        stateReg = 1
                                    End If

                                    Dim n_val As Decimal = Grid.CurrentRow.Cells("ColValor").Value

                                    'If (n_val < valorReg) Then
                                    If (n_val <= 0 And ingresoC = False) Then
                                        stateReg = 0
                                    Else
                                        stateReg = 1
                                    End If

                                    If stateReg = 0 Then
                                        stateReg = 1
                                        Grid.CurrentRow.Cells("ColValor").Value = valorReg
                                        MessageBox.Show("EL valor digitado no puede ser menor al de la deuda.", "Valor no permitido", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                                        Exit Sub
                                    End If
                                Else
                                    Grid.CurrentRow.Cells("ColComboPlanDife") = New DataGridViewTextBoxCell
                                End If
                            End With

                    End Select
                Else
                    Columna = .Columns(e.ColumnIndex).Name
                    Select Case Columna
                        Case "ColComboPlanDife"
                            With .CurrentRow.Cells(Columna)
                                Grid.CurrentRow.Cells("ColCuotas").Value = ""
                            End With
                    End Select
                End If
            End If
        End With
    End Sub

    Sub CargarCombosGrid(ByVal Novedad As String, Optional ByVal Tipo As String = "")
        Select Case Tipo
            'Tipo debe coincidir con parametros en DAL.GetListado
            Case "Inicial"

                With CmbServicio
                    .ValueMember = "key" : .DisplayMember = "value"
                    .DataSource = BL.BL_GetListado("Servicios")
                    .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
                End With
                With ColComboNovedad
                    .ValueMember = "key" : .DisplayMember = "value"
                    .DataSource = BL.BL_GetListado("Novedades")
                    .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
                End With
                With ColComboCausaCargo
                    .ValueMember = "key" : .DisplayMember = "value"
                    .DataSource = BL.BL_GetListado("Causas")
                    .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
                End With

            Case "CtasCobroProducto"
                With Grid
                    'IMPORTANTE:    De manera individual convierto la celda en un DataGridViewComboBoxCell
                    '               Colocar los ValueMember y DisplayMember despues de la asignacion del DataSource para que no genere Error.
                    .CurrentRow.Cells("ColComboCtaCobro") = New DataGridViewComboBoxCell
                    With CType(.Rows(.CurrentRow.Index).Cells("ColComboCtaCobro"), DataGridViewComboBoxCell)
                        .ValueMember = "key" : .DisplayMember = "value"
                        .DataSource = BL.BL_GetListado(Tipo)
                        .FlatStyle = FlatStyle.Flat
                        .Style.BackColor = Color.White
                    End With
                End With
                Grid.CurrentRow.Cells("ColComboCtaCobro").Selected = True

            Case "ConceptosCtaCobro"
                With Grid
                    'IMPORTANTE:    De manera individual convierto la celda en un DataGridViewComboBoxCell
                    '               Colocar los ValueMember y DisplayMember despues de la asignacion del DataSource para que no genere Error.
                    .CurrentRow.Cells("ColComboConcepto") = New DataGridViewComboBoxCell
                    With CType(.Rows(.CurrentRow.Index).Cells("ColComboConcepto"), DataGridViewComboBoxCell)
                        .ValueMember = "key" : .DisplayMember = "value"
                        .DataSource = BL.BL_GetListado(Tipo)
                        .FlatStyle = FlatStyle.Flat
                        .Style.BackColor = Color.White
                    End With
                End With
                Grid.CurrentRow.Cells("ColComboConcepto").Selected = True

            Case "ConceptosProducto"
                With Grid
                    'IMPORTANTE:    De manera individual convierto la celda en un DataGridViewComboBoxCell
                    '               Colocar los ValueMember y DisplayMember despues de la asignacion del DataSource para que no genere Error.
                    .CurrentRow.Cells("ColComboConcepto") = New DataGridViewComboBoxCell
                    With CType(.Rows(.CurrentRow.Index).Cells("ColComboConcepto"), DataGridViewComboBoxCell)
                        .DataSource = BL.BL_GetListado(Tipo)

                        .ValueMember = "key" : .DisplayMember = "value"
                        .FlatStyle = FlatStyle.Flat
                        .Style.BackColor = Color.White
                    End With
                End With
                Grid.CurrentRow.Cells("ColComboConcepto").Selected = True

            Case "PlanesFinanciacion"
                With Grid
                    'IMPORTANTE:    De manera individual convierto la celda en un DataGridViewComboBoxCell
                    '               Colocar los ValueMember y DisplayMember despues de la asignacion del DataSource para que no genere Error.
                    .CurrentRow.Cells("ColComboPlanDife") = New DataGridViewComboBoxCell
                    With CType(.Rows(.CurrentRow.Index).Cells("ColComboPlanDife"), DataGridViewComboBoxCell)
                        If BL.BL_GetListado(Tipo).Count > 0 Then
                            .DataSource = BL.BL_GetListado(Tipo)
                            .ValueMember = "key" : .DisplayMember = "value"
                        End If
                        .FlatStyle = FlatStyle.Flat
                        .Style.BackColor = Color.White
                    End With
                End With
                Grid.CurrentRow.Cells("ColComboPlanDife").Selected = True

        End Select
    End Sub

    Private Sub Grid_RowValidating(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellCancelEventArgs) Handles Grid.RowValidating
        'Valido que el usuario rellene los campos minimos requeridos antes que pueda cambiar de registro y si la columna valor es Numerica.
        Dim ChkColValorEsNumerico As Boolean = False
        If Grid.CurrentRow.IsNewRow = False Then
            If BL.CheckContenidoMinimoFila(Grid.CurrentRow, ChkColValorEsNumerico) = False Then
                With Grid.CurrentRow
                    If ChkColValorEsNumerico = False Then
                        RaiseError("Debe rellenar los campos minimos requeridos para la Novedad seleccionada o verificar que el campo de la Columna Valor sea numérico.", 0, MsgBoxStyle.Exclamation)
                    Else
                        RaiseError("Debe rellenar los campos minimos requeridos para la Novedad seleccionada.", 0, MsgBoxStyle.Exclamation)
                    End If
                    e.Cancel = True
                End With
            Else
                mostrarProyeccionTab()
            End If
        End If


        Dim act1 = 0
        Dim act2 = 0
        Dim act3 = 0
        Dim act4 = 0

        Dim pro1 = 0
        Dim pro2 = 0
        Dim pro3 = 0
        Dim pro4 = 0
        'recorro las filas de la grilla DEUDA ACTUAL
        For x = 0 To GridDeuda.RowCount - 1
            If String.IsNullOrEmpty(GridDeuda.Rows(x).Cells(3).Value) Then
                act1 += 0
            Else
                act1 += FormatNumber(CDbl(GridDeuda.Rows(x).Cells(3).Value), 2)
            End If
            If String.IsNullOrEmpty(GridDeuda.Rows(x).Cells(4).Value) Then
                act2 += 0
            Else
                act2 += FormatNumber(CDbl(GridDeuda.Rows(x).Cells(4).Value), 2)
            End If
            If String.IsNullOrEmpty(GridDeuda.Rows(x).Cells(5).Value) Then
                act3 += 0
            Else
                act3 += FormatNumber(CDbl(GridDeuda.Rows(x).Cells(5).Value), 2)
            End If
            If String.IsNullOrEmpty(GridDeuda.Rows(x).Cells(6).Value) Then
                act4 += 0
            Else
                act4 += FormatNumber(CDbl(GridDeuda.Rows(x).Cells(6).Value), 2)
            End If
        Next

        txtTotalActual1.Text = act1
        txtTotalActual2.Text = act2
        txtTotalActual3.Text = act3
        txtTotalActual4.Text = act4

        'recorro las filas de la grilla DEUDA PROYECTADA

        For x = 0 To GridProyeccion.RowCount - 1
            If String.IsNullOrEmpty(GridProyeccion.Rows(x).Cells(3).Value) Then
                pro1 += 0
            Else
                pro1 += FormatNumber(CDbl(GridProyeccion.Rows(x).Cells(3).Value), 2)
            End If
            If String.IsNullOrEmpty(GridProyeccion.Rows(x).Cells(4).Value) Then
                pro2 += 0
            Else
                pro2 += FormatNumber(CDbl(GridProyeccion.Rows(x).Cells(4).Value), 2)
            End If
            If String.IsNullOrEmpty(GridProyeccion.Rows(x).Cells(5).Value) Then
                pro3 += 0
            Else
                pro3 += FormatNumber(CDbl(GridProyeccion.Rows(x).Cells(5).Value), 2)
            End If
            If String.IsNullOrEmpty(GridProyeccion.Rows(x).Cells(6).Value) Then
                pro4 += 0
            Else
                pro4 += FormatNumber(CDbl(GridProyeccion.Rows(x).Cells(6).Value), 2)
            End If
        Next

        txtTotalProyectado1.Text = pro1
        txtTotalProyectado2.Text = pro2
        txtTotalProyectado3.Text = pro3
        txtTotalProyectado4.Text = pro4

    End Sub

    Private Sub Grid_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Grid.SelectionChanged
        If Grid.Rows.Count = 1 Then
            MenuBorrarFila.Enabled = False
        Else
            MenuBorrarFila.Enabled = True
        End If
    End Sub

    Sub GridBorrarFila(ByRef Grid As DataGridView, ByVal RowIndex As Integer, ByVal IdNovedad As String)
        With Grid.Rows(RowIndex)
            .SetValues()
            '.Cells("ColComboNovedad").Value = IdNovedad
        End With
    End Sub

#End Region

#Region "Menus Contextuales"

    Private Sub MenuBorrarFila_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuBorrarFila.Click
        With Grid
            If .Rows.Count >= 2 Then
                If .CurrentRow.Index >= 0 Then
                    .Rows.RemoveAt(.CurrentRow.Index)
                End If
            End If
        End With
    End Sub

    Private Sub MenuLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuLimpiar.Click
        With Grid
            If .Rows.Count >= 2 Then
                Dim index As Integer = .CurrentRow.Index
                .Rows.RemoveAt(index)
                .Rows.Insert(index)
                '.ClearSelection()
                '.Rows(index).Cells("ColComboNovedad").Selected = True
            End If
        End With
    End Sub

#End Region

    Private Sub CmbServicio_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CmbServicio.SelectedIndexChanged
        Contrato.CadenaServicioSeleccionado = CmbServicio.Text
    End Sub

    Private Sub TxtObservacion_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TxtObservacion.TextChanged
        'RaiseError("Cambio el texto", 0, MsgBoxStyle.Information)
        'RaiseError("La observaciones es:   " + TxtObservacion.Text, 0, MsgBoxStyle.Information)

    End Sub

    Private Sub BtnGrabar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnGrabar.Click
        If TxtObservacion.Text <> "" Then
            If Grid.Rows.Count >= 1 Then
                'Ejecuto los procedimientos de proyección: Insertar nota de encabezado, calcularproyeccion
                'Nota: No se muestra el Tab de la Proyeccion.
                If BL.Proyeccion(Grid, GridDeuda, GridProyeccion) = True Then
                    'Se ejecuta el procedimiento para grabar las notas y se valida el resultado de la operacion.

                    'If TxtObservacion.Text <> "" Then
                    If BL.BL_GrabarNotas(TxtObservacion.Text) = True Then
                        BtnGrabar.Enabled = False
                        BtnProyeccion.Enabled = False
                        'Cierro el formulario cuando la grabacion ha sido exitosa.
                        Me.Close()
                    End If
                    'Else                
                    '    RaiseError("No es posible almacenar la información sin diligenciar el campo Observación. ", 0, MsgBoxStyle.Critical)
                    'End If
                End If
            End If
        Else
            RaiseError("No es posible almacenar la información sin diligenciar el campo Observación. ", 0, MsgBoxStyle.Exclamation)
        End If
    End Sub


    Private Sub mostrarProyeccionTab()
        'Se Realiza la proyeccion
        Dim datos As String = ""
        If BL.Proyeccion(Grid, GridDeuda, GridProyeccion) Then
            'DANVAL MODIFICACION 10.12.18
            'SE AGREGO EL LLAMADO DE LOS SALDOS
            Dim respuesta As String
            Dim resp As String()
            respuesta = BL.BL_CargarGridDeudaActual_1(CmbServicio.SelectedValue)
            resp = respuesta.Split("|")
            txt_saldofavor.Text = resp(0)
            txt_valorreclamo.Text = resp(1)
            txt_valorreclamodiferido.Text = resp(2)
            '
            'Habilito y cambio a la pestaña Proyección
            TabProyeccion.Parent = TabControl1
            TabControl1.SelectedTab = TabProyeccion
            'Se formatean de nuevo las columnas de los Grid
            Call UI()
        End If
    End Sub


    Private Sub MANOT_FormClosed(ByVal sender As System.Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles MyBase.FormClosed
        BL.BorradoTemporales()
        OpenDataBase.Transaction.Commit()
    End Sub
End Class