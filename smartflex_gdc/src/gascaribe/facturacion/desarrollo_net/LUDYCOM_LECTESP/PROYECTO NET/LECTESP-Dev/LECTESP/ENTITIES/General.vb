Imports System.Collections.Generic
Imports System.Threading
Imports LUDYCOM.LECTESP.ENTITIES

Module General

#Region "Declaraciones"

#Region "Conexion"
    Public Oracle As New DAL.Oracle
    Public EstadoConexion As ConnectionState
    Public TipoConexion As String
    Public BDD As String
#End Region

    'Parametros Generales
    Public TblExcel As New TBLEXCEL

#Region "Flags Generales"
    Public ModoDesarrollo As Boolean = False
    Public BooValidacionHabilitada As Boolean = False
    Public BoProcesarHabilitado As Boolean = False
#End Region

    '-------------------Contenedores-----------------------
    'Paginador de datos Default
    Public BS As New BindingSource

#Region "Inicializacion Clases Personalizadas"
    Public Open As New OSF
    Public ListCriticas As New List(Of General.Critica)
    Public ListCriticaHistorica As New List(Of General.Critica)
    Public NewCritica As New General.Critica
    'Public ListLecturas As List(Of General.Lectura)
    Public HiloExportarExcel As Threading.Thread
    Public Plantilla As New HojasExcel
#End Region

    Public Filtro As New Filtros
    Public FiltroCritHistorica As New FiltrosHistoricos
    'Parametros Generales
    Public App As New Datos 'Datos utilizados frecuentemente en la aplicacion
    Public DataTablePeriodosHistoricos As New DataTable

#End Region

#Region "Clases Personalizadas"
    Public Class Datos

        Property IndexFilaActual As Integer
        Property IndexFilaNueva As Integer
        '-------- DataTables --------
        Property DataTableCritica As New DataTable
        Property DataTableCriticaHistorica As New DataTable
        Property DataTableActualizarCritica As New DataTable
        Property DataTableImportacion As New DataTable

        '-------- DataTables --------
        Property FormularioCargado As Boolean = False
        Property FlagBorradoCellsGrid As Boolean = False
        Property FlagCargarCriticasdesdeBDD As Boolean = False
        Property FlagMenuSeleccionRegistros As Boolean = False
        Property FlagPlantillaTieneEncabezados As Boolean = False
        Property MsgObsDefault As String

        'CA200-856
        Property ColumnaActualMenuStrip As Integer

        'CA 200-1105
        Property nuRegistrosImportacionExcel As Integer = 5000

        Private _BtnSwitch As Boolean = False
        Public Property BtnSwitchSortGrid() As Boolean
            Get
                Return _BtnSwitch
            End Get
            Set(ByVal value As Boolean)
                _BtnSwitch = value
            End Set
        End Property

        Sub InicializarTablaActualizarCritica()
            'Restablezco la tabla Final de Criticas para cargar nuevos datos
            With Me.DataTableActualizarCritica
                .Reset()
                .Rows.Clear()
                .Columns.Clear()
                .Columns.Add("Critica_id")
                .Columns.Add("Producto")
                .Columns.Add("LecturaFinal")
                .Columns.Add("PresionFinal", Type.GetType("System.Double"))
            End With
        End Sub
    End Class

    Public Class Filtros

        Private _Ciclo As String
        Public Property Ciclo() As String
            Get
                Return _Ciclo
            End Get
            Set(ByVal value As String)
                If value = 999999999 Then
                    _Ciclo = ""
                Else
                    _Ciclo = "sesucico='" + value + "'"
                End If
            End Set
        End Property

        Private _Pefa As String
        Public Property Pefa() As String
            Get
                Return _Pefa
            End Get
            Set(ByVal value As String)
                If value = 999999999 Then
                    _Pefa = ""
                Else
                    _Pefa = "pefacodi='" + value + "'"
                End If
            End Set
        End Property

        Private _Estado As String
        Public Property Estado() As String
            Get
                Return _Estado
            End Get
            Set(ByVal value As String)
                If value = "0" Then
                    _Estado = ""
                Else
                    _Estado = "proc='" + value + "'"
                End If
            End Set
        End Property

        Private _FiltroFinal As String
        Public ReadOnly Property FiltroFinal() As String
            Get
                If _Ciclo <> "" And InStr(_Ciclo, "-1") = 0 Then
                    If _Pefa = "" And _Estado = "" Then
                        _FiltroFinal = _Ciclo
                    ElseIf _Pefa <> "" And _Estado = "" Then
                        _FiltroFinal = _Ciclo + " and " + _Pefa
                    ElseIf _Pefa <> "" And _Estado <> "" Then
                        _FiltroFinal = _Ciclo + " and " + _Pefa + " and " + _Estado
                    ElseIf _Pefa = "" And _Estado <> "" Then
                        _FiltroFinal = _Ciclo + " and " + _Estado
                    End If
                ElseIf _Pefa <> "" And InStr(_Pefa, "-1") = 0 Then
                    If _Ciclo = "" And _Estado = "" Then
                        _FiltroFinal = _Pefa
                    ElseIf _Ciclo <> "" And _Estado = "" Then
                        _FiltroFinal = _Ciclo + " and " + _Pefa
                    ElseIf _Ciclo <> "" And _Estado <> "" Then
                        _FiltroFinal = _Ciclo + " and " + _Pefa + " and " + _Estado
                    ElseIf _Ciclo = "" And _Estado <> "" Then
                        _FiltroFinal = _Pefa + " and " + _Estado
                    End If
                ElseIf _Estado <> "" Then
                    If (_Ciclo = "" Or InStr(_Ciclo, "-1") > 0) And (InStr(_Pefa, "-1") > 0 Or _Pefa = "") Then
                        _FiltroFinal = _Estado
                    ElseIf _Ciclo <> "" And InStr(_Ciclo, "-1") = 0 And (_Pefa = "" Or InStr(_Pefa, "-1") > 0) Then
                        _FiltroFinal = _Ciclo + " and " + _Estado
                    ElseIf _Ciclo <> "" And InStr(_Ciclo, "-1") = 0 And _Pefa <> "" And InStr(_Pefa, "-1") = 0 Then
                        _FiltroFinal = _Ciclo + " and " + _Pefa + " and " + _Estado
                    End If
                Else
                    _FiltroFinal = ""
                End If
                'RaiseError(_FiltroFinal, 0, MsgBoxStyle.Information)
                Return _FiltroFinal
            End Get

        End Property

    End Class

    Public Class FiltrosHistoricos

        'Private _Ciclo As String
        Public Property Ciclo() As String
        '    Get
        '        Return _Ciclo
        '    End Get
        '    Set(ByVal value As String)
        '        If value = "999999999" Then
        '            _Ciclo = ""
        '        Else
        '            _Ciclo = "sesucico='" + value + "'"
        '        End If
        '    End Set
        'End Property

        'Private _Ano As String
        Public Property Ano() As String
        '    Get
        '        Return _Ano
        '    End Get
        '    Set(ByVal value As String)
        '        If value = "999999999" Then
        '            _Ano = ""
        '        Else
        '            _Ano = "pefaano='" + value + "'"
        '        End If
        '    End Set
        'End Property

        'Private _Mes As String
        Public Property Mes() As String
        '    Get
        '        Return _Mes
        '    End Get
        '    Set(ByVal value As String)
        '        If value = 999999999 Then
        '            _Mes = ""
        '        Else
        '            _Mes = "pefames='" + value + "'"
        '        End If
        '    End Set
        'End Property

        'Private _Pefa As String
        Public Property Pefa() As String
        '    Get
        '        Return _Pefa
        '    End Get
        '    Set(ByVal value As String)
        '        If value = 999999999 Then
        '            _Pefa = ""
        '        Else
        '            _Pefa = "pefacodi='" + value + "'"
        '        End If
        '    End Set
        'End Property

        'Private _Estado As String
        Public Property Estado() As String
        '    Get
        '        Return _Estado
        '    End Get
        '    Set(ByVal value As String)
        '        If value = "0" Then
        '            _Estado = ""
        '        Else
        '            _Estado = "proc='" + value + "'"
        '        End If
        '    End Set
        'End Property

        'Private _FiltroFinal As String
        Public Property FiltroFinal() As String
        '    Get
        '        If _Ciclo <> "" Then
        '            If _Pefa = "" And _Estado = "" Then
        '                _FiltroFinal = _Ciclo
        '            ElseIf _Pefa <> "" And _Estado = "" Then
        '                _FiltroFinal = _Ciclo + " and " + _Pefa
        '            ElseIf _Pefa <> "" And _Estado <> "" Then
        '                _FiltroFinal = _Ciclo + " and " + _Pefa + " and " + _Estado
        '            ElseIf _Pefa = "" And _Estado <> "" Then
        '                _FiltroFinal = _Ciclo + " and " + _Estado
        '            End If
        '        ElseIf _Pefa <> "" Then
        '            If _Ciclo = "" And _Estado = "" Then
        '                _FiltroFinal = _Pefa
        '            ElseIf _Ciclo <> "" And _Estado = "" Then
        '                _FiltroFinal = _Ciclo + " and " + _Pefa
        '            ElseIf _Ciclo <> "" And _Estado <> "" Then
        '                _FiltroFinal = _Ciclo + " and " + _Pefa + " and " + _Estado
        '            ElseIf _Ciclo = "" And _Estado <> "" Then
        '                _FiltroFinal = _Pefa + " and " + _Estado
        '            End If
        '        ElseIf _Estado <> "" Then
        '            If _Ciclo = "" And _Pefa = "" Then
        '                _FiltroFinal = _Estado
        '            ElseIf _Ciclo <> "" And _Pefa = "" Then
        '                _FiltroFinal = _Ciclo + " and " + _Estado
        '            ElseIf _Ciclo <> "" And _Pefa <> "" Then
        '                _FiltroFinal = _Ciclo + " and " + _Pefa + " and " + _Estado
        '            End If
        '        Else
        '            _FiltroFinal = ""
        '        End If
        '        'RaiseError(_FiltroFinal, 0, MsgBoxStyle.Information)
        '        Return _FiltroFinal
        '    End Get

        'End Property

    End Class

    Public Class Critica

        Property Sort_ID As Int64 'CA 200-856
        Property Ano As Int64 'CA 200-1105
        Property Mes As Int64 'CA 200-1105
        Property Critica_id As Int64
        Property Producto As Int64
        Property Suscriptor As String
        Property Dpto As String 'CA 200-1105
        Property Direccion As String
        Property Estado_corte As String 'CA 200-1105
        Property Estado_financiero As String 'CA 200-1105
        Property CicloConsumo As String
        Property PeriodoFacturacion As Int64
        Property PeriodoConsumo As Int64
        Property ConsumoPromedio As Int64
        Property ConsumoAñoAnterior As Int64
        Property LecturaAnterior As Int64
        Property LecturaActual As Int64
        Property VolumenSinCorregir As Int64
        Property PresionMesAnterior As Double
        Property FactorCorrMesAnt As Double
        Property VolumenCorregEstimado As Int64
        Property LecturaPresion1 As String
        Property Funcionando1 As String
        Property Causal1 As String
        Property LecturaPresion2 As String
        Property Funcionando2 As String
        Property Causal2 As String
        Property LecturaPresion3 As String
        Property Funcionando3 As String
        Property Causal3 As String
        Property PresionFinal As Double
        Property LecturaFinal As String
        Property Estado As Boolean
        Property Procesado As Boolean

        Property VolFacturado As Int64 'CA 200-1105
        Property Fecha_legal As String 'CA 200-1105
        Property Impexcel As String 'CA 200-1105
        Property Usuario_lega As String 'CA 200-1105
        Property Terminal As String 'CA 200-1105

        Property Ufech_lect As String 'CA 200-1983

    End Class

    Class Lectura
        Property order_id As Int64
        Property sesunuse As Int64
        Property consec_ext As Int64
        Property pecscons As Int64
        Property pefacodi As Int64
        Property felectura As Date
        Property feregistro As Date
        Property lectura As Int64
        Property temperatura As Int64
        Property pres As Int64
        Property presalt As Int64
        Property presbj As Int64
        Property volcorr As Int64
        Property volncorr As Int64
        Property lect_eagle As Int64
        Property voltbat As Int64
        Property usocons As String
        Property procesado As String
    End Class

    Public Class OSF

        ' Define aspecto visual de la UI

        Private VarBandButtonColor As Color = Color.FromArgb(109, 148, 220)
        Public ReadOnly Property BandButtonColor() As Color
            Get
                Return VarBandButtonColor
            End Get
        End Property

        Private VarBodyColor As Color = Color.FromArgb(224, 240, 255)
        Public ReadOnly Property BodyColor() As Color
            Get
                Return VarBodyColor
            End Get
        End Property

        Private VarLineColor As Color = Color.FromArgb(255, 127, 0)
        Public ReadOnly Property LineColor() As Color
            Get
                Return VarLineColor
            End Get
        End Property

        Private VarTabColor As Color = Color.FromArgb(240, 241, 243)
        Public ReadOnly Property TabColor() As Color
            Get
                Return VarTabColor
            End Get
        End Property

        Private VarGridSelectionColor As Color = Color.FromArgb(124, 177, 228)
        Public ReadOnly Property GridSelectionColor() As Color
            Get
                Return VarGridSelectionColor
            End Get
        End Property

        Private VarGridHeaderColor As Color = Color.FromArgb(213, 232, 246)
        Public ReadOnly Property GridHeaderColor() As Color
            Get
                Return VarGridHeaderColor
            End Get
        End Property

        Private VarTextControlColor As Color = Color.White
        Public ReadOnly Property TextControlColor() As Color
            Get
                Return VarTextControlColor
            End Get
        End Property

        Private VarTextControlBlockedColor As Color = Color.FromArgb(241, 240, 238)
        Public ReadOnly Property TextControlBlockedColor() As Color
            Get
                Return VarTextControlBlockedColor
            End Get
        End Property

        Private varLabelTitleColor As Color = Color.FromArgb(80, 114, 179)
        Public ReadOnly Property LabelTitleColor() As Color
            Get
                Return varLabelTitleColor
            End Get
        End Property

        Private VarDefaultControlColor As Color = Color.FromArgb(246, 245, 244)
        Public ReadOnly Property DefaultControlColor() As Color
            Get
                Return VarDefaultControlColor
            End Get
        End Property
    End Class

#End Region

#Region "Procesos/Funciones Generales"

    Public Sub RaiseMensaje(ByVal MSG As String, ByVal Number As Integer, ByVal tipo As MsgBoxStyle, Optional ByVal EsNotificacionEstado As String = "")
        'If EsNotificacionEstado = String.Empty Then
        App.MsgObsDefault += vbCrLf + MSG
        MsgBox(MSG, tipo, Application.ProductName)
        'Application.OpenForms.Item(0).Controls.Item("LabelStatus").Text = String.Empty
        'Else
        'Application.OpenForms.Item(0).Controls.Item("LabelStatus").Text = MSG
        'End If
    End Sub

    Public Sub ReleaseObject(ByVal obj As Object)
        Try
            System.Runtime.InteropServices.Marshal.ReleaseComObject(obj)
            obj = Nothing
        Catch ex As Exception
            obj = Nothing
        Finally
            GC.Collect()
        End Try
    End Sub

#End Region

End Module
