Imports System.Data.SqlClient
Imports LUDYCOM.MANOT.BL


Module Contrato

    Public NotaActual As NOTA
    Public TipoConexion As String
    Public DataTableNotas As New DataTable

    Public Sub RaiseError(ByVal MSG As String, ByVal Number As Integer, ByVal tipo As MsgBoxStyle)
        MsgBox(MSG, tipo, "MANOTS")
    End Sub

    Private VarID As Int64
    Public Property ID() As Int64
        Get
            Return VarID
        End Get
        Set(ByVal value As Int64)
            VarID = value
        End Set
    End Property

    Private VarProductos As DataTable
    Public Property Productos() As DataTable
        Get
            Return VarProductos
        End Get
        Set(ByVal value As DataTable)
            VarProductos = value
        End Set
    End Property

    Private VarProductoSeleccionado As Int64
    Public Property ProductoSeleccionado() As Int64
        Get
            Return VarProductoSeleccionado
        End Get
        Set(ByVal value As Int64)
            VarProductoSeleccionado = value
        End Set
    End Property

    Private VarServicioSeleccionado As Int64
    Public Property ServicioSeleccionado() As Int64
        Get
            Return VarServicioSeleccionado
        End Get
        Set(ByVal value As Int64)
            VarServicioSeleccionado = value
        End Set
    End Property

    Private varDeudaCorriente As Int64
    Public Property DeudaCorriente() As Int64
        Get
            Return varDeudaCorriente
        End Get
        Set(ByVal value As Int64)
            varDeudaCorriente = value
        End Set
    End Property

    Private VarCtasCobro As DataTable
    Public Property ProductoCtasCobro() As DataTable
        Get
            Return VarCtasCobro
        End Get
        Set(ByVal value As DataTable)
            VarCtasCobro = value
        End Set
    End Property

    Private VarCtaCobroSeleccionada As Int64
    Public Property CtaCobroSeleccionada() As Int64
        Get
            Return VarCtaCobroSeleccionada
        End Get
        Set(ByVal value As Int64)
            VarCtaCobroSeleccionada = value
        End Set
    End Property

    Private VarConceptos As DataTable
    Public Property ProductoConceptos() As DataTable
        Get
            Return VarConceptos
        End Get
        Set(ByVal value As DataTable)
            VarConceptos = value
        End Set
    End Property

    Private VarNovedadSel As String
    Public Property NovedadSeleccionada() As String
        Get
            Return VarNovedadSel
        End Get
        Set(ByVal value As String)
            VarNovedadSel = value
        End Set
    End Property



    Public Class NOTA

        Private VarNovedad As String
        Public Property Novedad() As String
            Get
                Return VarNovedad
            End Get
            Set(ByVal value As String)
                VarNovedad = value
            End Set
        End Property

        Private VarCtaCobro As Int64
        Public Property CuentadeCobro() As Int64
            Get
                Return VarCtaCobro
            End Get
            Set(ByVal value As Int64)
                VarCtaCobro = value
            End Set
        End Property

        Private VarConcepto As String
        Public Property Concepto() As String
            Get
                Return VarConcepto
            End Get
            Set(ByVal value As String)
                VarConcepto = value
            End Set
        End Property

        Private VarValor As Int64
        Public Property Valor() As Int64
            Get
                Return VarValor
            End Get
            Set(ByVal value As Int64)
                VarValor = value
            End Set
        End Property

        Private VarCausaCargo As Int64
        Public Property CausaCargo() As Int64
            Get
                Return VarCausaCargo
            End Get
            Set(ByVal value As Int64)
                VarCausaCargo = value
            End Set
        End Property

        Private VarCuotas As Int64
        Public Property Cuotas() As Int64
            Get
                Return VarCuotas
            End Get
            Set(ByVal value As Int64)
                VarCuotas = value
            End Set
        End Property

        Private VarPlanDife As Int64
        Public Property PlanDiferido() As Int64
            Get
                Return VarPlanDife
            End Get
            Set(ByVal value As Int64)
                VarPlanDife = value
            End Set
        End Property

    End Class

    Private VarCadenaServicioSeleccionado As String
    Public Property CadenaServicioSeleccionado() As String
        Get
            Return VarCadenaServicioSeleccionado
        End Get
        Set(ByVal value As String)
            VarCadenaServicioSeleccionado = value
        End Set
    End Property

End Module
