Imports System.Collections.Generic
Imports System.Data
Imports OpenSystems.Windows.Controls
Imports OpenSystems.Common.Interfaces
Imports LUDYCOM.LECTESP.ENTITIES
Imports LUDYCOM.LECTESP.BL
Imports System.Threading
Imports System.IO

Partial Public Class LECTESP
    Inherits OpenForm

    'Declaraciones
    'Dim Open As New OSF
    Dim BL As BLLECTESP
    Dim BLExcel As New BLTBLEXCEL

#Region "Formulario"

#Region "Inicializacion"

    Public Sub New(ByVal nodeId As String)

        ' Llamada necesaria para el diseñador.
        InitializeComponent()

        Call UI("Inicial")

        ' Agregue cualquier inicialización después de la llamada a InitializeComponent().
        BL = New BLLECTESP

        Dim ErrorGenCrit As String = String.Empty
        'Generar las criticas de los productos en el periodo de Facturacion Actual
        BL.GeneraCritica(ErrorGenCrit)

        'Cargo los errores al generar las criticas en el campo observacion del Formulario
        If ErrorGenCrit <> "" Then
            App.MsgObsDefault = ErrorGenCrit + vbCrLf + vbCrLf + App.MsgObsDefault
        Else
            App.MsgObsDefault = "*** Inicio Generacion de Criticas | " + Date.Now + " ***" + vbCrLf + "Sin Errores." + vbCrLf + "*** Fin Generacion de Criticas | " + Date.Now + " ***" + vbCrLf + vbCrLf + App.MsgObsDefault
        End If

        'Cargar el DataTable App.DataTablePeriodosHistoricos para cargar los datos de los combos localmente
        BL.BL_GetListado("PeriodosCiclosHistoricos")

        'Crea las Columnas del Grid con las propiedades de la clase Critica
        Call BL.CrearColumnasGrid(Grid)

        'Carga las criticas al grid principal
        BL.BL_CargarCriticas(Grid, String.Empty, True)

        'Formatear la interfaz Grafica
        Call UI("GRID")

    End Sub

    'Private Sub BGWInicial_RunWorkerCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles BGWInicial.RunWorkerCompleted
    'Call CargarCombosGrid("Inicial")
    'End Sub

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Se desbloquean las llamadas a los controles en las operaciones con Hilos (Exportar a Excel). 
        'Para evitar que den error cuando interactuan con los controles del formulario. 
        Control.CheckForIllegalCrossThreadCalls = False

        'UsarHilosAlExportar = True

        'Aviso de Información al Inicio:
        TxtObservacion.Text = App.MsgObsDefault

        'Inicia la carga de datos historicos en segundo plano
        If BGWorker.IsBusy = False Then
            BGWorker.RunWorkerAsync()
        End If

        'CA-869 Se carga lista de ciclos con los parametrizados en ldc_cm_lectesp_cicl
        ToolCmbCiclo.ComboBox.DataSource = BL.BL_getCiclos.Tables("Tabla")
        ToolCmbCiclo.ComboBox.ValueMember = "CODIGO"
        ToolCmbCiclo.ComboBox.DisplayMember = "DESCRIPCION"
        ToolCmbCiclo.ComboBox.FlatStyle = FlatStyle.Flat
        ToolCmbCiclo.ComboBox.Text = ""

        'Carga lista de periodos del ciclo seleccionado
        ToolCmbPefaCiclo.ComboBox.DataSource = BL.BL_getPefaCiclos("-1").Tables("Tabla")
        ToolCmbPefaCiclo.ComboBox.ValueMember = "CODIGO"
        ToolCmbPefaCiclo.ComboBox.DisplayMember = "DESCRIPCION"
        ToolCmbPefaCiclo.ComboBox.FlatStyle = FlatStyle.Flat
        ToolCmbPefaCiclo.ComboBox.Text = ""

        With ToolCmbEstado.ComboBox
            .ValueMember = "key"
            .DisplayMember = "value"
            .DataSource = BL.BL_GetListado("Estados")
            .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
        End With

    End Sub

#End Region

#Region "Controles"

#Region "UI"

    Sub UI(Optional ByVal Fase As String = "")

        Try
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
                TableLayoutPanel2.BackColor = Open.BodyColor
                TableLayoutPanel3.BackColor = Open.BodyColor
                TableLayoutPanel4.BackColor = Open.BodyColor

                Panel1.BackColor = Open.BandButtonColor
                Panel2.BackColor = Open.BandButtonColor

                '-- TabPages
                TabPrincipal.BackColor = Open.TabColor
                TabHistorico.BackColor = Open.TabColor
                TabImportacionExcel.BackColor = Open.TabColor

                '-- ToolStrip
                BarraMenuPrincipal.BackColor = Open.BodyColor
                BarraMenuHistorico.BackColor = Open.BodyColor
                BarraMenuImportacion.BackColor = Open.BodyColor
                BarraMenuPlantilla.BackColor = Open.BodyColor

                ToolBtnFiltrar.BackColor = Open.BandButtonColor

                '-- Grid
                With Grid
                    '.BackgroundColor = Open.BodyColor
                    .RowsDefaultCellStyle.SelectionBackColor = Open.GridSelectionColor
                    .ColumnHeadersDefaultCellStyle.BackColor = Open.GridHeaderColor
                    .RowsDefaultCellStyle.BackColor = Open.TextControlBlockedColor
                End With

                '--Barra Estado
                StatusStrip1.BackColor = Open.BodyColor

                TxtObservacion.BackColor = Open.BodyColor
                GroupBox3.BackColor = Open.BodyColor
                LabelStatus.BackColor = Color.Transparent
                LabelStatus.Text = "Importante: Solo se procesarán las filas que tengan datos en las Columnas <Presion Final> y <Lectura Final>." '+ _
                '" La columna <Estado> indica si una critica en el Periodo Facturacion actual fue procesada previamente."

            ElseIf Fase = "GRID" Then

                Grid.CurrentCell = Nothing
                Application.DoEvents()
                For Each Col As Object In Grid.Columns

                    With Col
                        .ContextMenuStrip = Me.MenuClickDerecho

                        Select Case .name

                            Case "Sort_ID"
                                .HeaderText = "Sort ID"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                                .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells
                                .visible = False
                                MenuGuardarConfigGrid.Enabled = True

                            Case "Critica_id"
                                .HeaderText = "No. Critica"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                                .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells

                            Case "Producto"
                                .HeaderText = "Producto"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                                .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells

                            Case "Suscriptor"
                                .HeaderText = "Cliente"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft
                                .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells

                            Case "Direccion"
                                .HeaderText = "Direccion"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft
                                .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells

                            Case "CicloConsumo"
                                .HeaderText = "Ciclo de Consumo"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "PeriodoFacturacion"
                                .HeaderText = "Periodo de Facturacion"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "PeriodoConsumo"
                                .HeaderText = "Periodo de Consumo"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "ConsumoPromedio"
                                .HeaderText = "Consumo Promedio"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

                            Case "ConsumoAñoAnterior"
                                .HeaderText = "Consumo 12 Periodos Atras"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

                            Case "LecturaAnterior"
                                .HeaderText = "Lectura Anterior"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

                            Case "LecturaActual"
                                .HeaderText = "Lectura Actual"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

                            Case "VolumenSinCorregir"
                                .HeaderText = "Volumen Sin Corregir"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

                            Case "PresionMesAnterior"
                                .HeaderText = "Presion Mes Anterior"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                                .DefaultCellStyle.Format = "N2"

                            Case "FactorCorrMesAnt"
                                .HeaderText = "F. Correccion Mes Anterior"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                                .DefaultCellStyle.Format = "N4"

                            Case "VolumenCorregEstimado"
                                .HeaderText = "Volumen Corregido Estimado"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

                            Case "LecturaPresion1"
                                .HeaderText = "Lectura Presion 1"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                                .DefaultCellStyle.Format = "N2"

                            Case "Funcionando1"
                                .HeaderText = "Funcionando 1"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "Causal1"
                                .HeaderText = "Causal 1"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft

                            Case "LecturaPresion2"
                                .HeaderText = "Lectura Presion 2"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                                .DefaultCellStyle.Format = "N2"

                            Case "Funcionando2"
                                .HeaderText = "Funcionando 2"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "Causal2"
                                .HeaderText = "Causal 2"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft

                            Case "LecturaPresion3"
                                .HeaderText = "Lectura Presion 3"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                                .DefaultCellStyle.Format = "N2"

                            Case "Funcionando3"
                                .HeaderText = "Funcionando 3"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "Causal3"
                                .HeaderText = "Causal 3"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft

                            Case "PresionFinal"
                                .HeaderText = "Presion Final"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                                .DefaultCellStyle.Format = "N2"

                            Case "LecturaFinal"
                                .HeaderText = "Lectura Final"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

                            Case "Estado"
                                .HeaderText = "Estado"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "Procesado"
                                .HeaderText = "Procesar"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "Cliente"
                                .HeaderText = "Cliente"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft
                                .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells

                            Case "Fecha_legal"
                                .HeaderText = "Fecha Legalizacion"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft

                            Case "Ano"
                                .HeaderText = "Año"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "Mes"
                                .HeaderText = "Mes"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "DPTO"
                                .HeaderText = "Departamento"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                                .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells

                            Case "VolFacturado"
                                .HeaderText = "Volumen Facturado"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

                            Case "Estado_corte"
                                .HeaderText = "Estado de Corte"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft

                            Case "Estado_financiero"
                                .HeaderText = "Estado Financiero"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft

                            Case "Usuario_lega"
                                .HeaderText = "Usuario"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft

                            Case "Ufech_lect"
                                .HeaderText = "Ultima fecha de lectura"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                                .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells

                        End Select
                    End With
                Next

            ElseIf Fase = "GRIDHISTORICO" Then
                Application.DoEvents()
                For Each colB As DataGridViewColumn In GridHistorico.Columns
                    '--
                    With colB
                        Select Case .Name.ToUpper

                            Case "SORT_ID"
                                .HeaderText = "Sort ID"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                                .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells
                                .Visible = False
                                MenuGuardarConfigGrid.Enabled = True

                            Case "CRITICA_ID"
                                .HeaderText = "No. Critica"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                                .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells

                            Case "SESUNUSE"
                                .HeaderText = "Producto"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                                .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells

                            Case "NOMBRE"
                                .HeaderText = "Cliente"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft
                                .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells

                            Case "ADDRESS_PARSED"
                                .HeaderText = "Direccion"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft
                                .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells

                            Case "SESUCICO"
                                .HeaderText = "Ciclo de Consumo"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "PEFACODI"
                                .HeaderText = "Periodo de Facturacion"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "PECSCONS"
                                .HeaderText = "Periodo de Consumo"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "CONSPROM"
                                .HeaderText = "Consumo Promedio"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

                            Case "CONSPROMDC"
                                .HeaderText = "Consumo 12 Periodos Atras"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

                            Case "LEEMLEAN"
                                .HeaderText = "Lectura Anterior"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

                            Case "LEEMLEAC"
                                .HeaderText = "Lectura Actual"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

                            Case "VOLNCORR"
                                .HeaderText = "Volumen Sin Corregir"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

                            Case "PRESMESANT"
                                .HeaderText = "Presion Mes Anterior"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                                .DefaultCellStyle.Format = "N2"

                            Case "FACORRMANT"
                                .HeaderText = "F. Correccion Mes Anterior"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                                .DefaultCellStyle.Format = "N4"

                            Case "VOLCORREST"
                                .HeaderText = "Volumen Corregido Estimado"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

                            Case "LEPRESA"
                                .HeaderText = "Lectura Presion 1"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                                .DefaultCellStyle.Format = "N2"

                            Case "FUNCA"
                                .HeaderText = "Funcionando 1"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "CAUPRESA"
                                .HeaderText = "Causal 1"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft

                            Case "LEPRESB"
                                .HeaderText = "Lectura Presion 2"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                                .DefaultCellStyle.Format = "N2"

                            Case "FUNCB"
                                .HeaderText = "Funcionando 2"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "CAUPRESB"
                                .HeaderText = "Causal 2"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft

                            Case "LEPRESC"
                                .HeaderText = "Lectura Presion 3"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                                .DefaultCellStyle.Format = "N2"

                            Case "FUNCC"
                                .HeaderText = "Funcionando 3"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "CAUPRESC"
                                .HeaderText = "Causal 3"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft

                            Case "PRESFIN"
                                .HeaderText = "Presion Final"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                                .DefaultCellStyle.Format = "N2"

                            Case "LECTFIN"
                                .HeaderText = "Lectura Final"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

                            Case "PROC"
                                .HeaderText = "Procesar"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "FECHA_LEGAL"
                                .HeaderText = "Fecha Legalizacion"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft

                            Case "ANO"
                                .HeaderText = "Año"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "MES"
                                .HeaderText = "Mes"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                            Case "DPTO"
                                .HeaderText = "Departamento"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                                .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells

                            Case "VOLFACTURADO"
                                .HeaderText = "Volumen Facturado"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

                            Case "ESTADO_CORTE"
                                .HeaderText = "Estado de Corte"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft

                            Case "ESTADO_FINANCIERO"
                                .HeaderText = "Estado Financiero"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft

                            Case "USUARIO_LEGA"
                                .HeaderText = "Usuario"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft

                            Case "UFECH_LECT"
                                .HeaderText = "Ultima fecha de lectura"
                                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                                .AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells

                        End Select
                    End With
                    '--
                Next

                With GridHistorico
                    .DefaultCellStyle.BackColor = Open.TextControlBlockedColor

                End With
            End If


        Catch ex As Exception

        End Try
    End Sub

#End Region

#Region "Botones"

    Private Sub BtnProcesar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnProcesar.Click
        Grid.CurrentCell = Nothing
        Dim outLog As String = String.Empty
        If Grid.Rows.Count >= 1 Then
            'Se ejecuta el procedimiento  y se valida el resultado de la operacion.
            'Si es True, existen datos a procesar en la tabla local de Criticas
            If BL.ExtraerFilasCompletasGrid(Grid) = True Then
                BL.ProcesarCritica(outLog)
                TxtObservacion.Text = outLog
                Call BL.BL_CargarCriticas(Grid, Nothing, True)
                'Formateo las columnas del grid cada vez que se rellene
                Call UI("GRID")
            End If
        End If
    End Sub

#End Region

#Region "Filtros Principales"

    Private Sub ToolCmbCiclo_Leave(ByVal sender As Object, ByVal e As System.EventArgs) Handles ToolCmbCiclo.Leave
        Dim sbCiclo As String
        sbCiclo = ToolCmbCiclo.ComboBox.SelectedValue.ToString()
        If sbCiclo <> "" Then
            'Carga lista de periodos del ciclo seleccionado
            ToolCmbPefaCiclo.ComboBox.DataSource = BL.BL_getPefaCiclos(sbCiclo).Tables("Tabla")
            ToolCmbPefaCiclo.ComboBox.ValueMember = "CODIGO"
            ToolCmbPefaCiclo.ComboBox.DisplayMember = "DESCRIPCION"
            ToolCmbPefaCiclo.ComboBox.FlatStyle = FlatStyle.Flat
            ToolCmbPefaCiclo.ComboBox.Text = ""
        End If
    End Sub

    Private Sub CmbEstado_SelectedValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ToolCmbEstado.SelectedIndexChanged
        If App.FormularioCargado = False Then
            App.FormularioCargado = True
            'Cargar por defecto solo las criticas sin procesar
            ToolCmbEstado.ComboBox.SelectedValue = "N"
        Else
            If Not ToolCmbEstado.ComboBox.SelectedValue = Nothing Then
                Filtro.Estado = ToolCmbEstado.ComboBox.SelectedValue.ToString
            End If
        End If
    End Sub

#End Region

#Region "Filtros Historicos"

    Private Sub ToolCmbCicloHist_SelectedValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ToolCmbCicloHist.SelectedIndexChanged
        If App.FormularioCargado = True Then
            If Not ToolCmbCicloHist.ComboBox.SelectedValue = Nothing Then
                FiltroCritHistorica.Ciclo = ToolCmbCicloHist.ComboBox.SelectedValue
                FiltroCritHistorica.Ano = String.Empty
                FiltroCritHistorica.Mes = String.Empty
                FiltroCritHistorica.Pefa = String.Empty
                'Call BL.BL_CargarCriticaHistorica(GridHistorico, FiltroCritHistorica.FiltroFinal, False)
                If ToolCmbCicloHist.Items.Count > 1 Then 'Si tiene datos aparte del item -Todos-
                    Call CargarCombosGrid("PefaAñoHist", ToolCmbCicloHist.ComboBox.SelectedValue.ToString)
                    If ToolCmbPefaAñoHist.Items.Count > 1 Then
                        ToolCmbPefaAñoHist.Enabled = True
                    Else
                        ToolCmbPefaAñoHist.Enabled = False
                    End If
                End If
                'Formateo las columnas del grid cada vez que se rellene
                'Call UI("GRID")
            End If
        End If
        'ToolbarLabel.Text = FiltroCritHistorica.FiltroFinal '--Debug Filtro
    End Sub

    Private Sub ToolCmbPefaAñoHist_SelectedValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ToolCmbPefaAñoHist.SelectedIndexChanged
        If App.FormularioCargado = True Then
            If Not ToolCmbPefaAñoHist.ComboBox.SelectedValue = Nothing Then
                FiltroCritHistorica.Ano = ToolCmbPefaAñoHist.ComboBox.SelectedValue.ToString
                FiltroCritHistorica.Mes = String.Empty
                FiltroCritHistorica.Pefa = String.Empty
                'Call BL.BL_CargarCriticaHistorica(GridHistorico, FiltroCritHistorica.FiltroFinal, False)
                If ToolCmbPefaAñoHist.Items.Count > 1 Then 'Si tiene datos aparte del item -Todos-
                    Call CargarCombosGrid("PefamesHist", ToolCmbPefaAñoHist.ComboBox.SelectedValue.ToString)
                    If ToolCmbPefaMesHist.Items.Count > 1 Then
                        ToolCmbPefaMesHist.Enabled = True
                    Else
                        ToolCmbPefaMesHist.Enabled = False
                    End If
                End If
                'Formateo las columnas del grid cada vez que se rellene
                'Call UI("GRID")
            End If
        End If
        'ToolbarLabel.Text = FiltroCritHistorica.FiltroFinal '--Debug Filtro
    End Sub

    Private Sub ToolCmbPefaMesHist_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ToolCmbPefaMesHist.SelectedIndexChanged
        If App.FormularioCargado = True Then
            If Not ToolCmbPefaCicloHist.ComboBox.SelectedValue = Nothing Then
                FiltroCritHistorica.Mes = ToolCmbPefaMesHist.ComboBox.SelectedValue.ToString
                FiltroCritHistorica.Pefa = String.Empty
                'Call BL.BL_CargarCriticaHistorica(GridHistorico, FiltroCritHistorica.FiltroFinal, False)
                If ToolCmbPefaMesHist.Items.Count > 1 Then 'Si tiene datos aparte del item -Todos-
                    Call CargarCombosGrid("PefacturaHist", ToolCmbPefaMesHist.ComboBox.SelectedValue.ToString)
                    If ToolCmbPefaCicloHist.Items.Count > 1 Then
                        ToolCmbPefaCicloHist.Enabled = True
                    Else
                        ToolCmbPefaCicloHist.Enabled = False
                    End If
                End If
                'Formateo las columnas del grid cada vez que se rellene
                'Call UI("GRID")
            End If
        End If
        'ToolbarLabel.Text = FiltroCritHistorica.FiltroFinal '--Debug Filtro
    End Sub

    Private Sub ToolCmbPefaCicloHist_SelectedValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ToolCmbPefaCicloHist.SelectedIndexChanged
        If App.FormularioCargado = False Then
            App.FormularioCargado = True
            'Cargar por defecto solo las criticas sin procesar
        End If
        If App.FormularioCargado = True Then
            If Not ToolCmbPefaCicloHist.ComboBox.SelectedValue = Nothing Then
                FiltroCritHistorica.Pefa = ToolCmbPefaCicloHist.ComboBox.SelectedValue.ToString
                'Call BL.BL_CargarCriticaHistorica(GridHistorico, FiltroCritHistorica.FiltroFinal, False) --ojo: habilitar denuevo
                'Formateo las columnas del grid cada vez que se rellene
                'Call UI("GRID")n 
                Call CargarCombosGrid("Hist", ToolCmbPefaCicloHist.ComboBox.SelectedValue.ToString)
            End If
        End If
        'ToolbarLabel.Text = FiltroCritHistorica.FiltroFinal '--Debug Filtro
    End Sub

#End Region



#End Region

#End Region

#Region "GRID EVENTS"

    Private Sub Grid_CellClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles Grid.CellClick

        'If e.ColumnIndex >= 0 Then
        '    MsgBox("e.RowIndex: " + e.RowIndex.ToString + " | " + "e.ColumnIndex: " + e.ColumnIndex.ToString)
        'End If
    End Sub

    Private Sub Grid_RowsAdded(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewRowsAddedEventArgs) Handles Grid.RowsAdded
        'Mantengo disponible el Index de la nueva Fila
        App.IndexFilaNueva = e.RowIndex
        Call EditarFila("S", Grid.Rows(e.RowIndex))
        'Application.DoEvents()
    End Sub

    Public Function EditarFila(ByVal CriticaProcesada As String, ByRef MyRow As DataGridViewRow)

        With MyRow
            'Coloco toda la fila ReadOnly para habilitar las celdas 
            .ReadOnly = True
            .DefaultCellStyle.BackColor = Open.TextControlBlockedColor

            Select Case CriticaProcesada
                Case "S"
                    'Coloca la fila en solo lectura
                    .ReadOnly = True
                    .DefaultCellStyle.BackColor = Open.TextControlBlockedColor

                Case "N"
                    'Habilito las columnas Presion y Lectura Final.
                    With .Cells("PresionFinal")
                        .ReadOnly = False
                        .Style.BackColor = Color.White
                    End With

                    With .Cells("LecturaFinal")
                        .ReadOnly = False
                        .Style.BackColor = Color.White
                    End With
                    With .Cells("Procesado")
                        .ReadOnly = False
                        .Style.BackColor = Color.White
                    End With

            End Select

            'CA 200-856
            'Columna Sort_ID siempre debe ser editable
            With .Cells("Sort_ID")
                .ReadOnly = False
                .Style.BackColor = Color.White
            End With
        End With
        Return MyRow
    End Function

    Private Sub Grid_CurrentCellDirtyStateChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Grid.CurrentCellDirtyStateChanged
        With Grid
            'Esta instruccion Confirma inmediatamente los cambios en los 
            'controles ComboBoxColumn para obtener la propieda Value
            'Solo se usa con la Columna Procesado
            If .CurrentCell.ColumnIndex >= 0 Then
                'If .Columns(.CurrentCell.ColumnIndex).Name = "Procesado" Then
                'And Grid.IsCurrentCellDirty = True
                '.CommitEdit(DataGridViewDataErrorContexts.Commit)
                'End If
            End If
        End With
    End Sub

    Private Sub Grid_CellValueChanged(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles Grid.CellValueChanged
        With Grid
            'Valido que se haya editado una celda
            If e.ColumnIndex >= 0 And e.RowIndex >= 0 Then
                With .Rows(e.RowIndex).Cells("Estado")
                    If .RowIndex = e.RowIndex And .ColumnIndex = e.ColumnIndex Then
                        'Valido si la critica ha sido procesada para bloquear la fila completa
                        If .Value = "True" Then
                            'CriticaProcesada? 1->S  Bloquea toda la fila
                            Call EditarFila("S", Grid.Rows(e.RowIndex))
                        Else
                            'CriticaProcesada? 0->N  habilita los campos Presion y Lectura Final
                            Call EditarFila("N", Grid.Rows(e.RowIndex))
                        End If
                    End If
                End With
            End If
        End With
    End Sub

    Sub CargarCombosGrid(ByVal Tipo As String, Optional ByVal Procesado As String = "")
        Select Case Tipo

            'Tipo debe coincidir con parametros en DAL.GetListado

            Case "Inicial"
                'Nota: No se agregan los Historicos pues son cargados individ. en segundo plano
                With ToolCmbCiclo.ComboBox
                    .ValueMember = "key" : .DisplayMember = "value"
                    .DataSource = BL.FiltrarCombo("CicloConsumo", Procesado)
                    .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
                End With

                With ToolCmbPefaCiclo.ComboBox
                    .ValueMember = "key" : .DisplayMember = "value"
                    .DataSource = BL.FiltrarCombo("Pefactura", Procesado)
                    .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
                End With

                With ToolCmbEstado.ComboBox
                    .ValueMember = "key" : .DisplayMember = "value"
                    .DataSource = BL.BL_GetListado("Estados")
                    .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
                End With

            Case "Ciclo"
                With ToolCmbCiclo.ComboBox
                    .ValueMember = "key" : .DisplayMember = "value"
                    .DataSource = BL.FiltrarCombo("CicloConsumo", Procesado)
                    .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
                End With

            Case "Pefactura"
                With ToolCmbPefaCiclo.ComboBox
                    .ValueMember = "key" : .DisplayMember = "value"
                    .DataSource = BL.FiltrarCombo("Pefactura", Procesado)
                    .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
                End With

            Case "CriticaHistorica"
                With ToolCmbCicloHist.ComboBox
                    .ValueMember = "key" : .DisplayMember = "value"
                    .DataSource = BL.FiltrarCombo("CicloConsumoHist", Procesado)
                    .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
                End With

                With ToolCmbPefaAñoHist.ComboBox
                    .ValueMember = "key" : .DisplayMember = "value"
                    .DataSource = BL.FiltrarCombo("PefaAñoHist", Procesado)
                    .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
                End With

                'With ToolCmbPefaMesHist.ComboBox
                '    .ValueMember = "key" : .DisplayMember = "value"
                '    .DataSource = BL.FiltrarCombo("PefamesHist", Procesado)
                '    .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
                'End With

                With ToolCmbPefaCicloHist.ComboBox
                    .ValueMember = "key" : .DisplayMember = "value"
                    .DataSource = BL.FiltrarCombo("PefacturaHist", Procesado)
                    .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
                End With

            Case "CicloConsumoHist"
                With ToolCmbCicloHist.ComboBox
                    .ValueMember = "key" : .DisplayMember = "value"
                    .DataSource = BL.FiltrarCombo("CicloConsumoHist", Procesado)
                    .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
                End With

            Case "PefaAñoHist"
                With ToolCmbPefaAñoHist.ComboBox
                    .ValueMember = "key" : .DisplayMember = "value"
                    .DataSource = BL.FiltrarCombo("PefaAñoHist", Procesado)
                    .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
                End With

            Case "PefamesHist"
                With ToolCmbPefaMesHist.ComboBox
                    .ValueMember = "key" : .DisplayMember = "value"
                    .DataSource = BL.FiltrarCombo("PefamesHist", Procesado)
                    .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
                End With

            Case "PefacturaHist"
                With ToolCmbPefaCicloHist.ComboBox
                    .ValueMember = "key" : .DisplayMember = "value"
                    .DataSource = BL.FiltrarCombo("PefacturaHist", Procesado)
                    .FlatStyle = FlatStyle.Flat 'Permite dar estilo al combo
                End With

            Case "Hist"
                With ToolCmbPefaCicloHist.ComboBox
                    BL.FiltrarCombo("Hist", Procesado)
                End With

        End Select
    End Sub

    Private Sub Grid_DataError(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewDataErrorEventArgs) Handles Grid.DataError
        With Grid.CurrentRow
            If Not IsNumeric(.Cells("PresionFinal").Value) Or Not IsNumeric(.Cells("PresionFinal").Value Is Nothing) Then
                e.Cancel = True
            End If
        End With
    End Sub

    Private Sub Grid_RowValidating(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellCancelEventArgs) Handles Grid.RowValidating

        With Grid.CurrentRow

            'Se valida que la fila sea editable (Critica No Procesada)
            If CType(.Cells("Estado").Value, Boolean) = False Then

                'No se valida nada si:
                'Los campos PresionFinal y LecturaFinal estan vacios.
                'se estan borrando las filas del Grid

                If ((IsDBNull(.Cells("PresionFinal").Value) Or .Cells("PresionFinal").Value Is Nothing) _
                    And (IsDBNull(.Cells("LecturaFinal").Value) Or .Cells("LecturaFinal").Value Is Nothing)) _
                    Or App.FlagBorradoCellsGrid = True Then
                    Exit Sub
                End If

                ''Or (IsNumeric(Grid.CurrentRow.Cells("PresionFinal").Value) = True And IsNumeric(Grid.CurrentRow.Cells("LecturaFinal").Value) = True) _

                'Valido que el usuario rellene los campos minimos requeridos antes que pueda cambiar de registro y si la columna valor es Numerica.
                Dim ChkColValorEsNumerico As Boolean = False

                If BL.CheckContenidoMinimoFila(Grid.CurrentRow, ChkColValorEsNumerico) = True And .IsNewRow = False Then

                    'Ca 200-856
                    'Trunca la presion solo con dos digitos decimales
                    '----------------------------------------------------------------------------------------------------------------------
                    If ChkColValorEsNumerico = True Then
                        Dim Valor As Double = (Fix(.Cells("PresionFinal").Value * 100)) / 100
                        .Cells("PresionFinal").Value = Valor
                        'se quita validacion en caso OSF-75
                        'If Not (Valor >= 0 And Valor < 100) Then
                        '  RaiseMensaje("Solo se permiten valores hasta de 2 digitos enteros + 2 decimales para Presion Final.", 0, MsgBoxStyle.Exclamation)
                        ' e.Cancel = True
                        ' Exit Sub
                        ' End If
                        'Valor = 16545.5684
                        'Valor = Format(Math.Truncate(.Cells("LecturaFinal").Value * 100) / 100, "0.000")
                        '.Cells("LecturaFinal").Value = Valor
                    End If
                    '----------------------------------------------------------------------------------------------------------------------
                Else
                    If ChkColValorEsNumerico = False Then
                        RaiseMensaje("Para procesar la critica, ambos campos deben tener valores numéricos.", 0, MsgBoxStyle.Exclamation)
                        e.Cancel = True
                        Exit Sub
                    End If
                End If
            End If
        End With
    End Sub

    Sub GridBorrarFila(ByRef Grid As DataGridView, ByVal RowIndex As Integer, ByVal IdNovedad As String)
        With Grid.Rows(RowIndex)
            .SetValues()
            '.Cells("ColComboNovedad").Value = IdNovedad
        End With
    End Sub

#End Region

#Region "Menus Contextuales"

    Private Sub MenuSeleccionarTodo_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuSeleccionarTodo.Click
        With Grid
            If .Rows.Count >= 1 Then
                App.FlagMenuSeleccionRegistros = True

                For Each Row As DataGridViewRow In .Rows
                    If Row.Cells("Estado").Value = False Then
                        Row.Cells("Procesado").Value = True
                    End If
                Next
                App.FlagMenuSeleccionRegistros = False
            End If
        End With
    End Sub

    Private Sub MenuInvertirSeleccion_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuInvertirSeleccion.Click
        With Grid
            If .Rows.Count >= 1 Then
                App.FlagMenuSeleccionRegistros = True
                For Each Row As DataGridViewRow In .Rows
                    .CurrentCell = Nothing
                    If Row.Cells("Estado").Value = False Then
                        If Row.Cells("Procesado").Value = True Then
                            CType(Row.Cells("Procesado"), DataGridViewCheckBoxCell).Value = False
                        Else
                            CType(Row.Cells("Procesado"), DataGridViewCheckBoxCell).Value = True
                        End If
                    End If
                Next
                App.FlagMenuSeleccionRegistros = False
            End If
        End With
    End Sub

    Private Sub MenuAnularSelección_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuAnularSelección.Click
        With Grid
            If .Rows.Count >= 1 Then
                App.FlagMenuSeleccionRegistros = True
                For Each Row As DataGridViewRow In .Rows
                    .CurrentCell = Nothing
                    If Row.Cells("Estado").Value = False Then
                        CType(Row.Cells("Procesado"), DataGridViewCheckBoxCell).Value = False
                    End If
                Next
                App.FlagMenuSeleccionRegistros = False
            End If

        End With
    End Sub

#End Region


    Dim GridActual As String = "GRID"

    Delegate Sub ExportarExcel()

    Private Sub MenuExportarExcel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuExportarExcel.Click, MenuExportarExcel2.Click
        'Me.SuspendLayout()
        'Obtener el Grid desde donde el usuario solicito ocultar la columna
        '----
        'Dim myItem As ToolStripMenuItem = CType(sender, ToolStripMenuItem) : Dim cms As ContextMenuStrip = CType(myItem.Owner, ContextMenuStrip)

        'With cms
        'Actualizo el Grid que se va a exportar en el proceso Asincrono RunWorkerAsync()
        If tabCPPal.SelectedTab Is TabHistorico Then
            GridActual = GridHistorico.Name.ToUpper
            'ExportarGridAExcel()
        ElseIf tabCPPal.SelectedTab Is TabPrincipal Then
            GridActual = Grid.Name.ToUpper
            'ExportarGridAExcel()
        End If

        Me.BeginInvoke(New ExportarExcel(AddressOf ExportarGridAExcel))

        'End With

        'Me.ResumeLayout()
    End Sub

    Dim Rutaexportar As String = String.Empty
    Dim UsarHilosAlExportar As Boolean = False

    Private Sub ExportarGridAExcel()
        Dim BoOK As Boolean = True

        Try
            Dim Directory As New FolderBrowserDialog
            'Directory.RootFolder = Environment.SpecialFolder.MyComputer
            Directory.Description = "Exportar a Excel"
            Dim DRes As MsgBoxResult = Directory.ShowDialog()

            If DRes = MsgBoxResult.Ok Or DRes = MsgBoxResult.Yes Then
                Rutaexportar = Directory.SelectedPath
                If UsarHilosAlExportar = False Then
                    If GridActual = Grid.Name.ToUpper Then
                        BoOK = BL.ExportarGridAExcel(Grid, Rutaexportar)
                    ElseIf GridActual = GridHistorico.Name.ToUpper Then
                        BoOK = BL.ExportarGridAExcel(GridHistorico, Rutaexportar)
                    End If

                    If BoOK = True Then
                        RaiseMensaje("Datos Exportados!", 0, MsgBoxStyle.Information)
                    End If
                Else
                    If BGWorkExportar.IsBusy = False Then
                        BGWorkExportar.RunWorkerAsync()

                    Else
                        RaiseMensaje("La aplicación aun esta ejecutando otro proceso en segundo plano. Intentelo mas tarde.", 0, MsgBoxStyle.Information)
                    End If
                End If
            Else
                Exit Sub
            End If




        Catch ex As Exception
            RaiseMensaje(ex.Message, 0, MsgBoxStyle.Critical)
        End Try
    End Sub

    Private Sub MenuOcultarColumna_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuOcultarColumna.Click
        Try
            'Obtener el Grid desde donde el usuario solicito ocultar la columna
            '----
            Dim myItem As ToolStripMenuItem = CType(sender, ToolStripMenuItem) : Dim cms As ContextMenuStrip = CType(myItem.Owner, ContextMenuStrip)

            With cms.SourceControl
                '----
                If App.ColumnaActualMenuStrip >= 0 Then
                    If .Name = Grid.Name Then
                        'Ocultar Columna
                        Grid.Columns(App.ColumnaActualMenuStrip).Visible = False
                    ElseIf .Name = GridHistorico.Name Then
                        'Ocultar Columna
                        GridHistorico.Columns(App.ColumnaActualMenuStrip).Visible = False
                    End If
                End If

            End With
        Catch ex As Exception
            RaiseMensaje("Error al ocultar columnas del Grid." + vbCrLf + "Detalle: " + ex.Message, 1000, MsgBoxStyle.Exclamation)
        Finally
            Call ContarColumnasOcultasGrid()
        End Try
    End Sub

    Private Sub MenuMostrarColumnas_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuMostrarColumnas.Click
        Try
            For Each Col As DataGridViewColumn In Grid.Columns

                If Col.Visible = False And LCase(Col.Name) <> "sort_id" Then
                    Col.Visible = True
                End If
            Next
        Catch ex As Exception
            RaiseMensaje("Error al restablecer las columnas ocultas del Grid." + vbCrLf + "Detalle: " + ex.Message, 1000, MsgBoxStyle.Exclamation)
        Finally
            Call ContarColumnasOcultasGrid()
        End Try
    End Sub

    Sub ContarColumnasOcultasGrid()
        Dim CeldasOcultas As Integer
        'Contar Columnas Ocultas
        For Each Col As DataGridViewColumn In Grid.Columns
            If Col.Visible = False And LCase(Col.Name) <> "sort_id" Then
                CeldasOcultas += 1
            End If
        Next
        If CeldasOcultas > 0 Then
            LabelStatus.Text = "Celdas ocultas >> " + CeldasOcultas.ToString
            LabelStatus.BackColor = Color.LightCoral
        Else
            LabelStatus.Text = String.Empty
            LabelStatus.BackColor = Color.Empty
        End If
    End Sub

    ''' <summary>
    ''' Valida las acciones de activacion/inactivacion de Menus Contextuales
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub Grid_MouseUp(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles Grid.MouseUp, GridHistorico.MouseUp

        Try
            If (e.Button = MouseButtons.Right) Then
                With CType(sender, DataGridView) 'Aplicar acciones sobre ambos grids
                    App.ColumnaActualMenuStrip = .HitTest(e.X, e.Y).ColumnIndex
                    If App.ColumnaActualMenuStrip >= 0 Then
                        MenuOcultarColumna.Visible = True
                    Else
                        MenuOcultarColumna.Visible = False
                    End If
                    'Activar Menu Exportar a Excel cuando hayan datos 
                    If .Columns.Count > 0 Then
                        MenuExportarExcel.Enabled = True
                        MenuExportarExcel2.Enabled = True
                    Else
                        MenuExportarExcel.Enabled = False
                        MenuExportarExcel2.Enabled = False
                    End If
                End With
            End If

        Catch ex As Exception
            RaiseMensaje("Error al activar menus contextuales en el Grid." + vbCrLf + "Detalle: " + ex.Message, 0, MsgBoxStyle.Information)
        End Try

    End Sub

    ''' <summary>
    ''' 'CA 200-856
    ''' Guardar Configuracion del Grid (Orden de lso registros)
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub MenuGuardarConfigGrid_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuGuardarConfigGrid.Click
        Try
            If App.BtnSwitchSortGrid = True Then
                Call BL.GuardarOrdenFilas(Grid)
                Call BL.ActOrdenamiento()
                Grid.Columns("Sort_ID").Visible = False
                App.BtnSwitchSortGrid = False
                MenuGuardarConfigGrid.Text = "Iniciar Ordenamiento Productos"
            Else
                App.BtnSwitchSortGrid = True
                Grid.Columns("Sort_ID").Visible = True
                MenuGuardarConfigGrid.Text = "Fin Ordenamiento Productos"
            End If

        Catch ex As Exception
            Grid.Columns("Sort_ID").Visible = False
            App.BtnSwitchSortGrid = False
            MenuGuardarConfigGrid.Text = "Iniciar Ordenamiento Productos"
            RaiseMensaje("Error al establecer la configuracion para ordenamiento de registros. " + vbCrLf + "Detalle: " + ex.Message, 1000, MsgBoxStyle.Exclamation)
        End Try
    End Sub

    '--Pruebas Drag and Drop LECSTEP 

    'Private fromIndex As Integer
    'Private dragIndex As Integer
    'Private dragRect As Rectangle

    'Private Sub DataGridView1_DragDrop(ByVal sender As Object, _
    '                               ByVal e As DragEventArgs) _
    '                               Handles Grid8.DragDrop
    '    Dim p As Point = Grid8.PointToClient(New Point(e.X, e.Y))
    '    dragIndex = Grid8.HitTest(p.X, p.Y).RowIndex
    '    If (e.Effect = DragDropEffects.Move) Then
    '        Dim dragRow As DataGridViewRow = e.Data.GetData(GetType(DataGridViewRow))
    '        Grid8.Rows.RemoveAt(fromIndex)
    '        Grid8.Rows.Insert(dragIndex, dragRow)
    '    End If
    'End Sub

    'Private Sub DataGridView1_DragOver(ByVal sender As Object, _
    '                                   ByVal e As DragEventArgs) _
    '                                   Handles Grid8.DragOver
    '    e.Effect = DragDropEffects.Move
    'End Sub

    'Private Sub DataGridView1_MouseDown(ByVal sender As Object, _
    '                                ByVal e As MouseEventArgs) _
    '                                Handles Grid8.MouseDown
    '    fromIndex = Grid8.HitTest(e.X, e.Y).RowIndex
    '    If fromIndex > -1 Then
    '        Dim dragSize As Size = SystemInformation.DragSize
    '        dragRect = New Rectangle(New Point(e.X - (dragSize.Width / 2), _
    '                                           e.Y - (dragSize.Height / 2)), _
    '                                 dragSize)
    '    Else
    '        dragRect = Rectangle.Empty
    '    End If
    'End Sub

    'Private Sub DataGridView1_MouseMove(ByVal sender As Object, _
    '                                    ByVal e As MouseEventArgs) _
    '                                    Handles Grid8.MouseMove
    '    If (e.Button And MouseButtons.Left) = MouseButtons.Left Then
    '        If (dragRect <> Rectangle.Empty _
    '        AndAlso Not dragRect.Contains(e.X, e.Y)) Then
    '            Grid8.DoDragDrop(Grid.Rows(fromIndex), _
    '                                     DragDropEffects.Move)
    '        End If
    '    End If
    'End Sub

#Region "Hilos"

    Private Sub BGWorker_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles BGWorker.DoWork
        Try
            'Restablecer la barra de Progreso
            Me.ProgressBar.Value = 0
            Call CargarCombosGrid("CriticaHistorica")

            'Cargar el Historial de Criticas en Segundo Plano
            Call BL.BL_CargarCriticaHistorica(GridHistorico, String.Empty, False)
            BindingSource1.DataSource = GridHistorico.DataSource
            ToolBindingNav.BindingSource = BindingSource1

            ''For x As Integer = 0 To 99
            Threading.Thread.Sleep(100)
            ''    Me.BGWorker.ReportProgress(1)
            ''    If x = 99 Then
            ''        Exit For
            ''    End If
            ''Next

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Private Sub BGWorker_ProgressChanged(ByVal sender As Object, ByVal e As System.ComponentModel.ProgressChangedEventArgs) Handles BGWorker.ProgressChanged
        Try
            Me.ProgressBar.Value += e.ProgressPercentage
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Private Sub BGWorker_RunWorkerCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles BGWorker.RunWorkerCompleted
        Try
            If e.Cancelled Then
                App.MsgObsDefault += vbCrLf + "Se canceló la carga de las Criticas Históricas."
            ElseIf e.Error IsNot Nothing Then
                App.MsgObsDefault += vbCrLf + "Se ha producido un error al cargar las Criticas Históricas"
            Else
                App.MsgObsDefault += vbCrLf + "Criticas Históricas cargadas con Exito!" + vbCrLf
                Call UI("GRIDHISTORICO")
            End If
            TxtObservacion.Text = App.MsgObsDefault
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Private Sub BGWorkExportar_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles BGWorkExportar.DoWork
        Dim boOK As Boolean
        If GridActual = Grid.Name Then
            boOK = BL.ExportarGridAExcel(Grid, Rutaexportar)
        ElseIf GridActual = GridHistorico.Name Then
            boOK = BL.ExportarGridAExcel(GridHistorico, Rutaexportar)
        End If

        If boOK = True Then
            ''Abrir archivo de Excel
            'Dim MsgResult As MsgBoxResult = MsgBox("Datos exportados correctamente!" + vbCrLf + "Archivo: " + IO.Path.GetFileName(Directory.SelectedPath) + vbCrLf + vbCrLf _
            '                                       + "Desea abrir el archivo?", MsgBoxStyle.OkCancel, Application.ProductName)
            RaiseMensaje("Datos exportados correctamente!" + vbCrLf + "Ruta: " + Rutaexportar, 0, MsgBoxStyle.Information)
            'If MsgResult = MsgBoxResult.Ok Then
            '    System.Diagnostics.Process.Start(Directory.SelectedPath)
            'End If

        End If
    End Sub

#End Region

    Private Sub MenuDescargarPlantilla_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuDescargarPlantilla.Click

        Dim fBrowse As New FolderBrowserDialog

        With fBrowse
            '.RootFolder = Environment.SpecialFolder.MyDocuments
            .Description = "Descargar Plantilla Excel Lecturas Complementarias"
        End With

        If fBrowse.ShowDialog() = DialogResult.OK Then
            Dim fileContent As Byte() = My.Resources.Plantilla_lectespcrit
            File.WriteAllBytes(Path.Combine(fBrowse.SelectedPath, "Plantilla_lectespcrit.xls"), fileContent)
        End If

        If IO.File.Exists(Path.Combine(fBrowse.SelectedPath, "Plantilla_lectespcrit.xls")) Then
            MsgBox("Plantilla guardada exitosamente!", MsgBoxStyle.Information, Application.ProductName)
        Else
            RaiseMensaje("Error al descargar la Plantilla", 1000, MsgBoxStyle.Exclamation)
        End If

    End Sub

    Private Sub MenuImportarExcel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuImportarExcel.Click, ToolStripButton2.Click
        'Me.SuspendLayout()
        Call Me.ImportarExcel()
        tabCPPal.SelectedTab = TabImportacionExcel
        'Me.ResumeLayout()
    End Sub

    Sub ImportarExcel()
        Dim fBrowse As New OpenFileDialog, boOk As Boolean
        With fBrowse
            .Filter = "Excel files(*.xls)|*.xls"
            .FilterIndex = 1
            .Title = "Importar desde Plantilla Excel"
        End With

        Try
            fBrowse.CheckFileExists = True
            If fBrowse.ShowDialog() = DialogResult.OK Then
                General.TblExcel.Ruta = fBrowse.FileName
                ToolTxtRutaPlantilla.Text = General.TblExcel.Ruta.ToLower
                'BLExcel = New BLTBLEXCEL
                GridImportacion.DataSource = Nothing
                boOk = BLExcel.ImportarExcel()
                If boOk Then
                    Call Me.CargarGrids()
                    'Activa/Inactiva el Boton de validacion segun el valor de General.BooValidacionHabilitada
                    'ToolBtnValidar.Enabled = General.BooValidacionHabilitada
                    'ToolbarLabel.Text = String.Empty
                End If
                GridImportacion.DataSource = App.DataTableImportacion
            End If

        Catch ex As Exception
            RaiseMensaje(ex.Message, 0, MsgBoxStyle.Critical)
        End Try
    End Sub

    ''' <summary>
    ''' Asigna a cada Grid su correspondiente DataTable
    ''' </summary>
    Sub CargarGrids()
        Try

            'App.DataTableImportacion.Columns.Add("USUARIO")
            'App.DataTableImportacion.Columns.Add("TERMINAL")
            App.DataTableImportacion.AcceptChanges()
            GridImportacion.DataSource = Nothing
            GridImportacion.DataSource = App.DataTableImportacion
            GridImportacion.Refresh()
            'Se establecen las Descripciones de las Columnas de cada Grid
            'For Each col As DataGridViewColumn In GridImportacion.Columns
            '    col.HeaderText = App.DataTableImportacion.Columns(col.Name).Caption
            'Next

        Catch ex As Exception
            RaiseMensaje("Error al establecer la fuente de informacion de los Grid. [DataSource]", 100, MsgBoxStyle.Exclamation)
        End Try

        Call UI("GRID")

    End Sub

    Dim _sw As Boolean = True
    Private Sub MenuInmovilizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuInmovilizar.Click

        'Obtener el Grid desde donde el usuario solicito ocultar la columna
        '----
        Dim myItem As ToolStripMenuItem = CType(sender, ToolStripMenuItem) : Dim cms As ContextMenuStrip = CType(myItem.Owner, ContextMenuStrip)

        With CType(cms.SourceControl, DataGridView) 'Aplicar acciones sobre ambos grids
            '----
            If IsNothing(.CurrentCell) = False Then
                If .Columns(.CurrentCell.ColumnIndex()).Frozen = False Then
                    MenuInmovilizar.Text = "Movilizar"
                    .Columns(.CurrentCell.ColumnIndex()).Frozen = True
                    _sw = False
                Else
                    MenuInmovilizar.Text = "Inmovilizar"
                    _sw = True
                    For i As Integer = 0 To .Columns.Count - 1
                        .Columns(i).Frozen = False
                    Next
                End If
                LabelStatus.Text = String.Empty
            Else
                LabelStatus.Text = "Debe seleccionar una celda para definir la columna a [in]movilizar."
            End If
        End With
    End Sub

    Private Sub BtnProcesarImportacion_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnProcesarImportacion.Click
        Dim sberror As String = String.Empty, sbImportacionParcial As String = String.Empty
        Dim DT As New DataTable
        Try
            If App.DataTableImportacion.Rows.Count >= 1 Then

                App.MsgObsDefault = vbCrLf + vbCrLf + String.Format(" *** Inicio Importacion {0}*** ", Date.Now) + vbCrLf

                'RaiseMensaje("Datos importados correctamente!", 0, MsgBoxStyle.Information)
                If ToolCmbImportacionParcial.Text.ToUpper <> "N" Then
                    BLExcel.Procesar(sberror, "S")
                Else
                    BLExcel.Procesar(sberror, "N")
                End If

                GridImportacion.DataSource = Nothing
                GridImportacion.DataSource = App.DataTableImportacion
                GridImportacion.Refresh()

                If String.IsNullOrEmpty(sberror) Then
                    App.MsgObsDefault += "Sin Errores!" + vbCrLf + vbCrLf + String.Format(" *** Fin Importacion {0}*** ", Date.Now) + vbCrLf
                End If
                ''vALIDO Si se procesaron exitosamente registros para actualizar
                'el tab Principal
                Dim rOWS() As DataRow = App.DataTableImportacion.Select("PROCESADO='S'")
                If rOWS.Length > 0 Then
                    MenuRefrescar.PerformClick()
                End If

                If Not String.IsNullOrEmpty(sberror) Then
                    'Se agrega error al LOG
                    App.MsgObsDefault += sberror + vbCrLf + vbCrLf + String.Format(" *** Fin Importacion {0}*** ", Date.Now) + vbCrLf
                    Throw New ApplicationException(sberror)
                End If

            Else
                RaiseMensaje("No hay datos para importar!", 0, MsgBoxStyle.Exclamation)
                App.MsgObsDefault = "No hay datos para importar!"
            End If
            TxtObservacion.Text = App.MsgObsDefault
        Catch ex As Exception
            TxtObservacion.Text = App.MsgObsDefault
            RaiseMensaje("Error al validar/procesar la importacion!" + vbCrLf + "Ver Pestaña log!", 0, MsgBoxStyle.Exclamation)
        End Try
    End Sub

    Private Sub MenuRefrescar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuRefrescar.Click
        'Borro el Log de Transacciones
        TxtObservacion.Text = String.Empty

        App.FlagCargarCriticasdesdeBDD = True
        Call BL.BL_CargarCriticas(Grid, String.Empty, True)

        'Aviso de Información al Inicio:
        TxtObservacion.Text = App.MsgObsDefault

        'Inicia la carga de datos historicos en segundo plano
        If BGWorker.IsBusy = True Then
            RaiseMensaje("El proceso de carga en segundo plano del Historial de Criticas esta ocupado, intentelo mas tarde.", 0, MsgBoxStyle.Information, "N")
        Else
            BGWorker.RunWorkerAsync()
        End If

        Call UI("GRID")
    End Sub

    Private Sub ToolStripComboBox7_Validating(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles ToolStripComboBox7.Validating
        If IsNumeric(ToolStripComboBox7.Text) = False Or (IsNumeric(ToolStripComboBox7.Text) = True And Val(ToolStripComboBox7.Text) = 0) Then
            RaiseMensaje("Debe escribir un valor numérico mayor a cero!", 1000, MsgBoxStyle.Exclamation)
            e.Cancel = True
        Else
            App.nuRegistrosImportacionExcel = Val(ToolStripComboBox7.Text)
        End If
    End Sub

    Private Sub BtnCancelar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnCancelar.Click
        Application.Exit()
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Application.Exit()
    End Sub

    Private Sub Grid_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Grid.Click

    End Sub

    Private Sub Grid_CellMouseClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellMouseEventArgs) Handles Grid.CellMouseClick
        If e.RowIndex >= 0 And e.ColumnIndex >= 0 Then
            'Grid.RowsDefaultCellStyle.SelectionBackColor
        End If
    End Sub

    Private Sub GridImportacion_DataError(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewDataErrorEventArgs) Handles GridImportacion.DataError

        Try
            'e.ColumnIndex
        Catch ex As Exception

        End Try

    End Sub

    Private Sub ToolBtnFiltrar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolBtnFiltrar.Click
        Call BL.BL_CargarCriticaHistorica(GridHistorico, FiltroCritHistorica.FiltroFinal, False)
        BindingSource1.DataSource = GridHistorico.DataSource
        ToolBindingNav.BindingSource = BindingSource1
        Call UI("GRIDHISTORICO")
    End Sub

    Private Sub tsButtonSearch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles tsButtonSearch.Click

        'Setea los filtros seleccionados
        Filtro.Ciclo = ToolCmbCiclo.ComboBox.SelectedValue.ToString
        'MsgBox("Ciclo: " + Filtro.Ciclo, MsgBoxStyle.Information, "Prueba")
        If Not (ToolCmbPefaCiclo.ComboBox.SelectedValue = Nothing) Then

            Filtro.Pefa = ToolCmbPefaCiclo.ComboBox.SelectedValue.ToString
        Else
            Filtro.Pefa = "-1"
        End If

        ' Filtro.Pefa = ToolCmbPefaCiclo.ComboBox.SelectedValue.ToString
        'MsgBox("Periodo: " + Filtro.Pefa, MsgBoxStyle.Information, "Prueba")
        Filtro.Estado = ToolCmbEstado.ComboBox.SelectedValue.ToString
        ' MsgBox("Estado: " + Filtro.Estado, MsgBoxStyle.Information, "Prueba")
        ' MsgBox("Filtro Final: " + Filtro.FiltroFinal, MsgBoxStyle.Information, "Prueba")
        Call BL.BL_CargarCriticas(Grid, Filtro.FiltroFinal, False)
        'Formateo las columnas del grid cada vez que se rellene
        Call UI("GRID")

    End Sub

    
End Class