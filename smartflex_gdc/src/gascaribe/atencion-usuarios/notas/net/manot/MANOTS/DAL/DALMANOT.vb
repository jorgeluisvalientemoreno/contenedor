Imports System.Data.Common
Imports OpenSystems.Common
Imports OpenSystems.Common.Data
Imports OpenSystems.Common.Util
Imports OpenSystems.Common.ExceptionHandler
Imports Oracle.DataAccess.Client
Imports Oracle.DataAccess.Types
Imports LUDYCOM.MANOT
Imports LUDYCOM.MANOT.ENTITIES


Namespace DAL

    Public Class DALMANOT

        Public Oracle As New Oracle

        '[ Funciones y Procedimientos]
        ReadOnly Fn_GetSubscription As String = "cc_boosssubscription.getsubscription"  'Datos del Contrato

        '[Proyeccion]
        ReadOnly SP_proCalcularProyectado As String = "ldc_pkmantenimientonotas.proCalcularProyectado"  'Genera el detalle de la proyeccion.
        ReadOnly SP_proMostrarDeudaActual As String = "ldc_pkmantenimientonotas.proMostrarDeudaActual" 'Carga la info del Grid Deuda Actual
        ReadOnly SP_proMostrarProyectado As String = "ldc_pkmantenimientonotas.proMostrarProyectado" 'Carga la info del Grid Proyectado

        '[Deuda]
        ReadOnly SP_DeudaCorrienteProducto As String = "ldc_pkmantenimientonotas.proDeudaProducto"  'Saldo de un Producto
        ReadOnly SP_proDeudaCuentaCobro As String = "ldc_pkmantenimientonotas.proDeudaCuentaCobro" 'Carga la deuda de una cta de cobro.
        ReadOnly Fn_proDeudaConceptoReal As String = "ldc_pkmantenimientonotas.proDeudaConceptoReal" 'Carga la deuda de un concepto
        ReadOnly SP_proDeudaConceptoCC As String = "ldc_pkmantenimientonotas.proDeudaConceptoCC"     'Carga la deuda de un concepto en una cuenta de cobro

        '[Concepto]
        ReadOnly Fn_fcrConceptosProducto As String = "ldc_pkmantenimientonotas.fcrConceptosProducto" 'Carga Listado de conceptos que han sido aplicados al producto
        ReadOnly Fn_fcrConceptosCtaCobro As String = "ldc_pkmantenimientonotas.fcrConceptosCtaCobro" 'Carga Listado de conceptos de una cta de Cobro
        
        '[Cta de Cobro]
        ReadOnly Fn_CtasCobro_x_Producto As String = "ldc_pkmantenimientonotas.fcrCtasCobroProducto" 'Listado de Ctas de Cobro de un producto.

        '[Planes de Financiación]
        ReadOnly Fn_fcrplanesfinanciacion As String = "ldc_pkmantenimientonotas.fcrplanesfinanciacion"  'Planes de Financiacion aplicables segun numero de cuotas

        '[Procedimientos de Tabla]
        ReadOnly SP_proInsMantenimientoNotaEnc As String = "ldc_pkmantenimientonotas.proInsMantenimientoNotaEnc"    'Insertar encabezado de Notas
        ReadOnly SP_proborradatostemporales As String = "ldc_pkmantenimientonotas.proborradatostemporales"    'Borra todas las tablas temporales generadas durante el proceso.
        ReadOnly Fn_proGrabar As String = "ldc_pkmantenimientonotas.proGrabar"                                      'Graba las notas definitivamente en OSF
        ReadOnly Fn_validarMonto As String = "ldc_pkmantenimientonotas.validamonto"

#Region "Querys"
        '"Select Catecodi Codigo, Catedesc Descripcion from Categori Where Catecodi != -1 Order by Catecodi"
        'ReadOnly QueryServiciosxContrato As String = "SELECT SERVICIO.SERVCODI AS ID,UPPER(SERVICIO.SERVDESC) AS SERVICIO FROM SERVSUSC INNER JOIN SERVICIO ON SERVSUSC.SESUSERV=SERVICIO.SERVCODI AND SERVSUSC.SESUSUSC = :ContratoId"
#End Region

        ' <summary>
        ' Consulta los datos basicos del contrato enviando el id como parametro
        ' </summary>
        ' <returns>Cursor con los datos del contrato (DataTable)</returns>
        Public Function GetSubscription(ByVal inusubscription As Integer) As DataTable
            Dim DSMANOT As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(Fn_GetSubscription)
                    Using cmd
                        OpenDataBase.db.AddInParameter(cmd, "inusubscription", DbType.Int64, Convert.ToInt64(inusubscription))
                        OpenDataBase.db.AddParameterRefCursor(cmd)
                        OpenDataBase.db.LoadDataSet(cmd, DSMANOT, "Contrato")
                    End Using
                Case "ORACLE"
                    Dim cmd As New OracleCommand(Fn_GetSubscription, Oracle.OracleConnection)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add(New OracleParameter("inusubscription", OracleDbType.Int32)).Value = inusubscription
                    cmd.Parameters.Add(New OracleParameter("ocucursor", OracleDbType.RefCursor, ParameterDirection.Output))
                    DSMANOT.Tables.Add("Contrato")
                    DSMANOT.Tables("Contrato").Load(cmd.ExecuteReader)
            End Select
            Return DSMANOT.Tables("Contrato")
        End Function

        ' <summary>
        ' Valida la conexion que se esta utilizando. OPEN
        ' </summary>
        ' <returns>String con el nombre de la conexion ( LOCAL >> "ORACLE" | INTEGRADO OSF >> "OPEN" ) </returns>
        Public Function CheckConnection() As String
            Dim var As String = "OPEN"
            If Not (OpenDataBase.DBConnectionState = ConnectionState.Closed Or OpenDataBase.DBConnectionState = ConnectionState.Broken) Then
                var = "OPEN"
            ElseIf Not (Oracle.OracleConnection.State = ConnectionState.Closed Or Oracle.OracleConnection.State = ConnectionState.Broken) Then
                var = "ORACLE"
            Else
                var = "SIN CONEXION"
            End If
            TipoConexion = var
            Return var
        End Function

#Region "DATOS BASICOS"

#Region "Inicialización Combos en Grid"

        Function espacios(ByVal numeroEspacios As Integer, ByVal simbolo As String) As String
            Dim texto As String = ""
            For i = 1 To numeroEspacios Step 1
                texto += simbolo
            Next i
            Return texto
        End Function

        Public Function GetListado(ByVal Tipo As String) As BindingSource
            Dim Dr As DataTableReader
            Dim Dr1 As DataTableReader
            GetListado = New BindingSource

            Select Case Tipo

                Case "Causas"
                    Dim Listado = New Dictionary(Of Integer, String)
                    Listado.Add(1, "1-ANULACION")
                    Listado.Add(3, "3-DESCUENTO")
                    Listado.Add(4, "4-INGRESO")
                    Listado.Add(5, "5-MOVIMIENTOS DE CARTERA")
                    Listado.Add(73, "73-AJUSTE MIGRACION")
                    Listado.Add(75, "75-CRUCE DE CUENTAS POR PAGO")
                    GetListado = New BindingSource(Listado, Nothing)

                Case "Novedades"
                    Dim Listado = New Dictionary(Of String, String)
                    Listado.Add("AD", "ACREDITAR(DEUDA)")
                    Listado.Add("AC", "ACREDITAR POR CONCEPTO")
                    Listado.Add("ACC", "ACREDITAR POR CUENTA DE COBRO")
                    Listado.Add("ACCC", "ACREDITAR POR CUENTA DE COBRO Y CONCEPTO")
                    Listado.Add("DC", "DEBITAR POR CONCEPTO")
                    Listado.Add("DCC", "DEBITAR POR CUENTA DE COBRO")
                    Listado.Add("DCCC", "DEBITAR POR CUENTA DE COBRO Y CONCEPTO")
                    GetListado = New BindingSource(Listado, Nothing)

                Case "Servicios"
                    Dim MyDT As DataTable = Me.ObtenerListadoServiciosContrato(Contrato.ID)
                    Dim Listado = New Dictionary(Of Integer, String)
                    Dr = MyDT.CreateDataReader
                    While Dr.Read
                        Listado.Add(Dr(0), Dr(0).ToString + " | Servicio: " + Dr(1).ToString + " - " + Dr(2))
                    End While
                    If MyDT.Rows.Count > 0 Then
                        GetListado = New BindingSource(Listado, Nothing)
                    Else
                        GetListado.DataSource = Nothing
                    End If

                Case "CtasCobroProducto"
                    Dim MyDT As DataTable = Me.ObtenerListadoCtasCobroProducto(Contrato.ProductoSeleccionado)
                    Dim Listado = New Dictionary(Of Int64, String)
                    Dim texto As String
                    Dr = MyDT.CreateDataReader
                    Dr1 = MyDT.CreateDataReader
                    ''CONTAR ESPACIOS
                    Dim PAL1 As Integer = 0
                    Dim PAL2 As Integer = 0
                    Dim PAL3 As Integer = 0
                    While Dr1.Read
                        If Dr1(0).ToString.Length > PAL1 Then
                            PAL1 = Dr1(0).ToString.Length
                        End If
                        If Dr1(1).ToString.Length > PAL2 Then
                            PAL2 = Dr1(1).ToString.Length
                        End If
                        If Dr1(2).ToString.Length > PAL3 Then
                            PAL3 = Dr1(2).ToString.Length
                        End If
                    End While
                    ''
                    While Dr.Read
                        texto = " " + espacios(PAL1 - Dr(0).ToString.Length, "*") + Dr(0).ToString + " | " + espacios(PAL2 - Dr(1).ToString.Length, "0") + Dr(1).ToString + " | " + espacios(PAL3 - Dr(2).ToString.Length, "0") + Dr(2).ToString + " | " + Dr(3).ToString
                        Listado.Add(Dr(0), texto)
                    End While
                    If MyDT.Rows.Count > 0 Then
                        GetListado.DataSource = New BindingSource(Listado, Nothing)
                    Else
                        GetListado.DataSource = Nothing
                    End If

                Case "ConceptosCtaCobro"
                    Dim MyDT As DataTable = Me.ObtenerListadoConceptosCtaCobro(NotaActual.CuentadeCobro)
                    Dim Listado = New Dictionary(Of Integer, String)
                    Dr = MyDT.CreateDataReader
                    While Dr.Read
                        Listado.Add(Dr(0), Dr(0).ToString + " - " + Dr(1).ToString)
                    End While
                    If MyDT.Rows.Count > 0 Then
                        GetListado = New BindingSource(Listado, Nothing)
                    Else
                        GetListado.DataSource = Nothing
                    End If

                Case "ConceptosProducto"
                    Dim MyDT As DataTable = Me.ObtenerListadoConceptosProducto(Contrato.ProductoSeleccionado, Contrato.NovedadSeleccionada)
                    Dim Listado = New Dictionary(Of Integer, String)
                    Try
                        Dr = MyDT.CreateDataReader
                        While Dr.Read
                            Listado.Add(Dr(0), Dr(0).ToString + " - " + Dr(1).ToString)
                        End While
                        If MyDT.Rows.Count > 0 Then
                            GetListado = New BindingSource(Listado, Nothing)
                        Else
                            GetListado.DataSource = Nothing
                        End If
                    Catch ex As Exception
                        MsgBox("gETlISTADO" + vbCrLf + ex.Message)
                    End Try

                Case "PlanesFinanciacion"
                    'hacer split a contrato.productoseleccionado para q agarre solo el SERVICIO.
                    Dim prodSelected As String
                    prodSelected = Contrato.CadenaServicioSeleccionado
                    Dim ArrCadena As String() = prodSelected.Split(":")
                    Dim valor = ArrCadena(1)
                    ArrCadena = valor.Split("-")
                    valor = ArrCadena(0)


                    Dim MyDT As DataTable = Me.ObtenerListadoPlanesFinanciacion(Contrato.NotaActual.Cuotas, valor.Trim())



                    Dim Listado = New Dictionary(Of Integer, String)
                    Dr = MyDT.CreateDataReader
                    While Dr.Read
                        Listado.Add(Dr(0), Dr(0).ToString + " - " + Dr(1).ToString)
                    End While
                    If MyDT.Rows.Count > 0 Then
                        Listado.Add(-1, "")
                        GetListado = New BindingSource(Listado, Nothing)
                    Else
                        GetListado.DataSource = Nothing
                    End If

                Case "GridProyeccion"
                    Dim MyDT As DataTable = Me.ObtenerDatatableGridProyectado(Contrato.ProductoSeleccionado)
                    If MyDT.Rows.Count > 0 Then
                        GetListado = New BindingSource(MyDT, Nothing)
                    Else
                        GetListado.DataSource = Nothing
                    End If

                Case "GridDeudaActual"
                    Dim MyDT As DataTable = Me.ObtenerDatatableGridDeudaActual(Contrato.ProductoSeleccionado)
                    If MyDT.Rows.Count > 0 Then
                        GetListado = New BindingSource(MyDT, Nothing)
                    Else
                        GetListado.DataSource = Nothing
                    End If

            End Select

            Return GetListado
        End Function

#End Region

#End Region

#Region "FUNCIONES QUE DEVUELVEN CURSORES"
        ' <summary>
        ' Consulta los productos que tiene un contrato pasandolo por parametro.
        ' </summary>
        ' <returns>Cursor con el listado de los productos del cliente (DataTable)</returns>
        Public Function ObtenerListadoServiciosContrato(ByVal idContrato As Integer) As DataTable
            Dim Listado = New Dictionary(Of Integer, String)
            Dim DSMANOT As New DataSet
            DSMANOT.Tables.Add("Productos")

            Select Case CheckConnection()
                Case "OPEN"
                    'Dim QueryServiciosxContrato As String = "SELECT SERVSUSC.SESUNUSE AS ID,SERVICIO.SERVCODI AS IDSERVICIO,UPPER(SERVICIO.SERVDESC) AS SERVICIO FROM SERVSUSC INNER JOIN SERVICIO ON SERVSUSC.SESUSERV=SERVICIO.SERVCODI AND SERVSUSC.SESUSUSC = {0}"
                    Dim QueryServiciosxContrato As String = "SELECT SERVSUSC.SESUNUSE AS ID, SERVICIO.SERVCODI AS IDSERVICIO, UPPER(SERVICIO.SERVDESC) AS SERVICIO FROM SERVSUSC INNER JOIN SERVICIO ON SERVSUSC.SESUSERV = SERVICIO.SERVCODI AND SERVSUSC.SESUSUSC = {0} where exists (SELECT DISTINCT cargconc concepto, concdesc descripcion FROM cargos, concepto WHERE cargnuse = sesunuse AND cargconc = conccodi AND cargconc NOT IN (SELECT l.CONCCODI FROM LDC_CONC_NO_ACRED l))" 
                    Dim cmd As DbCommand
                    Dim Query As String = String.Format(QueryServiciosxContrato, idContrato)
                    cmd = OpenDataBase.db.GetSqlStringCommand(Query)
                    Using cmd
                        OpenDataBase.db.AddParameterRefCursor(cmd)
                        OpenDataBase.db.LoadDataSet(cmd, DSMANOT, "Productos")
                    End Using
                Case "ORACLE"
                    'Dim QueryServiciosxContrato As String = "SELECT SERVSUSC.SESUNUSE AS ID,SERVICIO.SERVCODI AS IDSERVICIO,UPPER(SERVICIO.SERVDESC) AS SERVICIO FROM SERVSUSC INNER JOIN SERVICIO ON SERVSUSC.SESUSERV=SERVICIO.SERVCODI AND SERVSUSC.SESUSUSC = :ContratoId"
                    Dim QueryServiciosxContrato As String = "SELECT SERVSUSC.SESUNUSE AS ID,SERVICIO.SERVCODI AS IDSERVICIO,UPPER(SERVICIO.SERVDESC) AS SERVICIO FROM SERVSUSC INNER JOIN SERVICIO ON SERVSUSC.SESUSERV=SERVICIO.SERVCODI AND SERVSUSC.SESUSUSC = :ContratoId where exists (SELECT DISTINCT cargconc concepto, concdesc descripcion FROM cargos, concepto WHERE cargnuse = sesunuse AND cargconc = conccodi AND cargconc NOT IN (SELECT l.CONCCODI FROM LDC_CONC_NO_ACRED l))" 
                    Dim cmd As New OracleCommand(QueryServiciosxContrato, Oracle.OracleConnection)
                    cmd.Parameters.Add(":ContratoId", idContrato)
                    cmd.CommandType = CommandType.Text
                    DSMANOT.Tables("Productos").Load(cmd.ExecuteReader)
            End Select
            'Asigno el resultado al Datatable Productos de la Clase Contrato
            Contrato.Productos = DSMANOT.Tables("Productos")

            Return Contrato.Productos
        End Function

        ' <summary>
        ' Consulta las Cuentas de Cobro asociadas a un Producto.
        ' </summary>
        ' <returns>Cursor con el listado de las Ctas de Cobro (DataTable)</returns>
        Public Function ObtenerListadoCtasCobroProducto(ByVal inuproducto As Integer) As DataTable
            Dim Listado = New Dictionary(Of Integer, String)
            Dim DSMANOT As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(Fn_CtasCobro_x_Producto)
                    Using cmd
                        OpenDataBase.db.AddInParameter(cmd, "inuproducto", DbType.Int64, Convert.ToInt64(inuproducto))
                        OpenDataBase.db.AddReturnRefCursor(cmd)
                        OpenDataBase.db.LoadDataSet(cmd, DSMANOT, "Tabla")
                    End Using
                Case "ORACLE"
                    DSMANOT.Tables.Add("Tabla")
                    Dim cmd As New OracleCommand(Fn_CtasCobro_x_Producto, Oracle.OracleConnection)
                    Using cmd
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.BindByName = True
                        cmd.Parameters.Add(New OracleParameter("inuproducto", OracleDbType.Int32)).Value = inuproducto
                        cmd.Parameters.Add(New OracleParameter("RETURN_VALUE", OracleDbType.RefCursor, ParameterDirection.ReturnValue))
                        DSMANOT.Tables("Tabla").Load(cmd.ExecuteReader)
                    End Using
            End Select
            Contrato.ProductoCtasCobro = DSMANOT.Tables("Tabla")

            Return Contrato.ProductoCtasCobro
        End Function

        ' <summary>
        ' Consulta los Conceptos asociados a un Producto.
        ' </summary>
        ' <returns>Cursor con el listado de los Conceptos (DataTable)</returns>
        Public Function ObtenerListadoConceptosProducto(ByVal inuproducto As Integer, ByVal isbnovedad As String) As DataTable
            Dim Listado = New Dictionary(Of Integer, String)
            Dim DSMANOT As New DataSet("Tabla")
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(Fn_fcrConceptosProducto)
                    Using cmd
                        OpenDataBase.db.AddInParameter(cmd, "inuProducto", DbType.Int64, inuproducto)
                        OpenDataBase.db.AddInParameter(cmd, "isbnovedad", DbType.String, isbnovedad)
                        OpenDataBase.db.AddReturnRefCursor(cmd)
                        OpenDataBase.db.LoadDataSet(cmd, DSMANOT, "Tabla")
                    End Using
                Case "ORACLE"
                    DSMANOT.Tables.Add("Tabla")
                    Dim cmd As New OracleCommand(Fn_fcrConceptosProducto, Oracle.OracleConnection)
                    Using cmd
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.BindByName = True
                        cmd.Parameters.Add(New OracleParameter("inuProducto", OracleDbType.Int32)).Value = inuproducto
                        cmd.Parameters.Add(New OracleParameter("isbnovedad", OracleDbType.Varchar2)).Value = isbnovedad
                        cmd.Parameters.Add(New OracleParameter("RETURN_VALUE", OracleDbType.RefCursor, ParameterDirection.ReturnValue))
                        DSMANOT.Tables("Tabla").Load(cmd.ExecuteReader)
                    End Using
            End Select
            Contrato.ProductoConceptos = DSMANOT.Tables("Tabla")

            Return Contrato.ProductoConceptos
        End Function

        Public Function ObtenerListadoConceptosCtaCobro(ByVal inuCuentaCobro As Int64) As DataTable
            Dim Listado = New Dictionary(Of Integer, String)
            Dim DSMANOT As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(Fn_fcrConceptosCtaCobro)
                    Using cmd
                        OpenDataBase.db.AddInParameter(cmd, "inuCuentaCobro", DbType.Int64, Convert.ToInt64(inuCuentaCobro))
                        OpenDataBase.db.AddReturnRefCursor(cmd)
                        OpenDataBase.db.LoadDataSet(cmd, DSMANOT, "Tabla")
                    End Using
                Case "ORACLE"
                    DSMANOT.Tables.Add("Tabla")
                    Dim cmd As New OracleCommand(Fn_fcrConceptosCtaCobro, Oracle.OracleConnection)
                    Using cmd
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.BindByName = True
                        cmd.Parameters.Add(New OracleParameter("inuCuentaCobro", OracleDbType.Int64, 15)).Value = inuCuentaCobro
                        cmd.Parameters.Add(New OracleParameter("RETURN_VALUE", OracleDbType.RefCursor, ParameterDirection.ReturnValue))
                        DSMANOT.Tables("Tabla").Load(cmd.ExecuteReader)
                    End Using
            End Select
            Contrato.ProductoCtasCobro = DSMANOT.Tables("Tabla")

            Return Contrato.ProductoCtasCobro
        End Function

        Public Function ObtenerListadoPlanesFinanciacion(ByVal inunrocuotas As Integer, ByVal inuservicio As  Integer) As DataTable
            Dim Listado = New Dictionary(Of Integer, String)
            Dim DSMANOT As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(Fn_fcrplanesfinanciacion)
                    Using cmd
                        OpenDataBase.db.AddInParameter(cmd, "inunrocuotas", DbType.Int64, Convert.ToInt64(inunrocuotas))
                        OpenDataBase.db.AddInParameter(cmd, "inuservicio", DbType.Int64, Convert.ToInt64(inuservicio))
                        OpenDataBase.db.AddReturnRefCursor(cmd)
                        OpenDataBase.db.LoadDataSet(cmd, DSMANOT, "Tabla")
                    End Using
                Case "ORACLE"
                    DSMANOT.Tables.Add("Tabla")
                    Dim cmd As New OracleCommand(Fn_fcrplanesfinanciacion, Oracle.OracleConnection)
                    Using cmd
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.BindByName = True
                        cmd.Parameters.Add(New OracleParameter("inunrocuotas", OracleDbType.Int32)).Value = inunrocuotas
                        cmd.Parameters.Add(New OracleParameter("inuservicio", OracleDbType.Int32)).Value = inuservicio
                        cmd.Parameters.Add(New OracleParameter("RETURN_VALUE", OracleDbType.RefCursor, ParameterDirection.ReturnValue))
                        DSMANOT.Tables("Tabla").Load(cmd.ExecuteReader)
                    End Using
            End Select
            Contrato.ProductoConceptos = DSMANOT.Tables("Tabla")

            Return Contrato.ProductoConceptos
        End Function

#End Region

#Region "FUNCIONES ESCALARES"

        Public Function ObtenerDeudaCorrienteProducto(ByVal inuproducto As Int64) As Int64
            Dim Valor As System.Nullable(Of Int64)
            Dim DSMANOT As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(SP_DeudaCorrienteProducto)
                    Using cmd
                        OpenDataBase.db.AddInParameter(cmd, "inuproducto", DbType.Int64, inuproducto)
                        OpenDataBase.db.AddOutParameter(cmd, "onudeuda", DbType.Int64, 15)
                        OpenDataBase.db.AddOutParameter(cmd, "osberror", DbType.String, 4000)
                        OpenDataBase.db.ExecuteNonQuery(cmd)
                        Valor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmd, "onudeuda").ToString)
                    End Using

                Case "ORACLE"
                    Dim cmd As New OracleCommand(SP_DeudaCorrienteProducto, Oracle.OracleConnection)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.BindByName = True
                    cmd.Parameters.Add(New OracleParameter("inuproducto", OracleDbType.Int64)).Value = inuproducto
                    cmd.Parameters.Add(New OracleParameter("onudeuda", OracleDbType.Int64, 15, vbNull, ParameterDirection.Output))
                    cmd.Parameters.Add(New OracleParameter("osberror", OracleDbType.Varchar2, 4000))
                    cmd.ExecuteNonQuery()
                    Valor = Convert.ToInt64(cmd.Parameters("onuDeuda").Value.ToString)
            End Select

            Return Valor
        End Function

        Public Function ObtenerDeudaCtaCobro(ByVal inuProducto As Int64, ByVal inuCuenCobr As Int64, ByRef osbError As String) As Int64
            Dim Valor As System.Nullable(Of Int64)
            Dim DSMANOT As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(SP_proDeudaCuentaCobro)
                    Using cmd
                        OpenDataBase.db.AddInParameter(cmd, "inuProducto", DbType.Int64, inuProducto)
                        OpenDataBase.db.AddInParameter(cmd, "inuCuenCobr", DbType.Int64, inuCuenCobr)
                        OpenDataBase.db.AddOutParameter(cmd, "onuSaldoCuenCobr", DbType.Int64, 15)
                        OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                        OpenDataBase.db.ExecuteNonQuery(cmd)
                        Valor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmd, "onuSaldoCuenCobr"))
                    End Using

                Case "ORACLE"

                    Dim cmd As New OracleCommand(SP_proDeudaCuentaCobro, Oracle.OracleConnection)
                    cmd.CommandType = CommandType.StoredProcedure
                    Using cmd
                        cmd.Parameters.Add(New OracleParameter("inuProducto", OracleDbType.Int64)).Value = inuProducto
                        cmd.Parameters.Add(New OracleParameter("inuCuenCobr", OracleDbType.Int64, 10, vbNull, ParameterDirection.Input)).Value = inuCuenCobr
                        cmd.Parameters.Add(New OracleParameter("onuSaldoCuenCobr", OracleDbType.Int64, 15, vbNull, ParameterDirection.Output))
                        cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                        cmd.ExecuteNonQuery()
                        Valor = Convert.ToInt64(cmd.Parameters("onuSaldoCuenCobr").Value.ToString)
                    End Using
            End Select

            Return Valor
        End Function

        Public Function ObtenerDeudaConcepto(ByVal inuProducto As Int64, ByVal inuConcepto As Int64, ByRef osbError As String) As Int64
            Dim Valor As System.Nullable(Of Int64)
            Dim DSMANOT As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(Fn_proDeudaConceptoReal)
                    Using cmd
                        OpenDataBase.db.AddInParameter(cmd, "inuProducto", DbType.Int64, inuProducto)
                        OpenDataBase.db.AddInParameter(cmd, "inuConcepto", DbType.Int64, inuConcepto)
                        OpenDataBase.db.AddOutParameter(cmd, "onuDeuda", DbType.Int64, 15)
                        OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                        OpenDataBase.db.ExecuteNonQuery(cmd)
                        Valor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmd, "onuDeuda"))
                    End Using

                Case "ORACLE"

                    Dim cmd As New OracleCommand(Fn_proDeudaConceptoReal, Oracle.OracleConnection)
                    cmd.CommandType = CommandType.StoredProcedure
                    Using cmd
                        'cmd.BindByName = True
                        cmd.Parameters.Add(New OracleParameter("inuProducto", OracleDbType.Int64)).Value = inuProducto
                        cmd.Parameters.Add(New OracleParameter("inuConcepto", OracleDbType.Int64, 10, vbNull, ParameterDirection.Input)).Value = inuConcepto
                        cmd.Parameters.Add(New OracleParameter("onuDeuda", OracleDbType.Int64, 15, vbNull, ParameterDirection.Output))
                        cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                        cmd.ExecuteNonQuery()
                        Valor = Convert.ToInt64(cmd.Parameters("onuDeuda").Value.ToString)
                    End Using
            End Select

            Return Valor
        End Function

        Public Function ObtenerDeudaConceptoCtaCobro(ByVal inuCuenCobr As Int64, ByVal inuConcepto As Int64, ByRef osbError As String) As Int64
            Dim Valor As Int64
            Dim DSMANOT As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(SP_proDeudaConceptoCC)
                    Using cmd
                        OpenDataBase.db.AddInParameter(cmd, "inuCuenCobr", DbType.Int32, inuCuenCobr)
                        OpenDataBase.db.AddInParameter(cmd, "inuConcepto", DbType.Int32, inuConcepto)
                        OpenDataBase.db.AddOutParameter(cmd, "onuSaldoConcepto", DbType.Int64, 15)
                        OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                        OpenDataBase.db.ExecuteNonQuery(cmd)
                        'osbError = OpenDataBase.db.GetParameterValue(cmd, "osbError")
                        Valor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmd, "onuSaldoConcepto"))
                    End Using

                Case "ORACLE"

                    Dim cmd As New OracleCommand(SP_proDeudaConceptoCC, Oracle.OracleConnection)
                    cmd.CommandType = CommandType.StoredProcedure
                    Using cmd
                        cmd.Parameters.Add(New OracleParameter("inuCuenCobr", OracleDbType.Int64)).Value = inuCuenCobr
                        cmd.Parameters.Add(New OracleParameter("inuConcepto", OracleDbType.Int64, 10, vbNull, ParameterDirection.Input)).Value = inuConcepto
                        cmd.Parameters.Add(New OracleParameter("onuSaldoConcepto", OracleDbType.Int64, 15, vbNull, ParameterDirection.Output))
                        cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                        cmd.ExecuteNonQuery()
                        'osbError = cmd.Parameters("osbError").Value.ToString
                        Valor = Convert.ToInt64(cmd.Parameters("onuSaldoConcepto").Value.ToString)
                    End Using
            End Select

            Return Valor
        End Function

#End Region

#Region "PROYECCION"
        '[BORRAR NOTAS DE LA SESION ACTUAL EN LDC_MANTENIMIENTO_NOTAS_ENC]
        Public Function BorrarTablasTemporales() As String
            Dim osbError As String = String.Empty
            Dim DSMANOT As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(SP_proborradatostemporales)
                    Using cmd
                        OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                        OpenDataBase.db.ExecuteNonQuery(cmd)
                        osbError = OpenDataBase.db.GetParameterValue(cmd, "osbError").ToString
                    End Using

                Case "ORACLE"
                    Dim cmd As New OracleCommand(SP_proborradatostemporales, Oracle.OracleConnection)
                    cmd.CommandType = CommandType.StoredProcedure
                    Using cmd
                        cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                        cmd.ExecuteNonQuery()
                        osbError = cmd.Parameters("osbError").Value.ToString
                    End Using
            End Select

            Return osbError
        End Function

        Public Function ValidarMonto(ByVal producto As Int64, ByRef osbError As String) As String
            Dim DSMANOT As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(Fn_validarMonto)
                    Using cmd
                        'OJO: EL ORDEN DE LOS PARAMETROS ES IMPORTANTE
                        OpenDataBase.db.AddInParameter(cmd, "inuProducto", DbType.Int64, producto)
                        OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                        OpenDataBase.db.ExecuteNonQuery(cmd)
                        osbError = OpenDataBase.db.GetParameterValue(cmd, "osbError").ToString
                    End Using

                Case "ORACLE"
                    Dim cmd As New OracleCommand(Fn_validarMonto, Oracle.OracleConnection)
                    cmd.CommandType = CommandType.StoredProcedure
                    Using cmd
                        cmd.Parameters.Add(New OracleParameter("inuProducto", OracleDbType.Int64, 15)).Value = Convert.ToInt64(producto)
                        cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                        cmd.ExecuteNonQuery()
                        osbError = cmd.Parameters("osbError").Value.ToString
                    End Using
            End Select

            Return osbError
        End Function

        '[INSERTAR NOTAS EN LDC_MANTENIMIENTO_NOTAS_ENC CON LA SESION ACTUAL]
        Public Function InsertarNotaEncabezado(ByVal inuProducto As Int64, ByVal isbNovedad As String, ByVal inuConcepto As String, _
                                                     ByVal inuCuenta_cobro As String, ByVal inuValor As Int64, ByVal inuCausa_cargo As String, _
                                                     ByVal inuCuotas As String, ByVal inuPlan_diferido As String) As String
            Dim osbError As String = String.Empty
            Dim DSMANOT As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(SP_proInsMantenimientoNotaEnc)
                    Using cmd
                        'OJO: EL ORDEN DE LOS PARAMETROS ES IMPORTANTE
                        OpenDataBase.db.AddInParameter(cmd, "inuProducto", DbType.Int64, inuProducto)
                        OpenDataBase.db.AddInParameter(cmd, "isbNovedad", DbType.String, isbNovedad)
                        If inuConcepto <> "" Then
                            OpenDataBase.db.AddInParameter(cmd, "inuConcepto", DbType.Int64, Convert.ToInt64(inuConcepto))
                        Else
                            OpenDataBase.db.AddInParameter(cmd, "inuConcepto", DbType.Int64, DBNull.Value)
                        End If
                        If inuCuenta_cobro <> "" Then
                            OpenDataBase.db.AddInParameter(cmd, "inuCuenta_cobro", DbType.Int64, inuCuenta_cobro)
                        Else
                            OpenDataBase.db.AddInParameter(cmd, "inuCuenta_cobro", DbType.Int64, DBNull.Value)
                        End If
                        OpenDataBase.db.AddInParameter(cmd, "inuValor", DbType.Int64, inuValor)
                        OpenDataBase.db.AddInParameter(cmd, "inuCausa_cargo", DbType.Int32, inuCausa_cargo)
                        If inuCuotas <> "" Then
                            OpenDataBase.db.AddInParameter(cmd, "inuCuotas", DbType.Int64, inuCuotas)
                        Else
                            OpenDataBase.db.AddInParameter(cmd, "inuCuotas", DbType.Int64, DBNull.Value)
                        End If
                        If inuPlan_diferido <> "" Then
                            OpenDataBase.db.AddInParameter(cmd, "inuPlan_diferido", DbType.Int64, inuPlan_diferido)
                        Else
                            OpenDataBase.db.AddInParameter(cmd, "inuPlan_diferido", DbType.Int64, DBNull.Value)
                        End If
                        OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                        OpenDataBase.db.ExecuteNonQuery(cmd)
                        osbError = OpenDataBase.db.GetParameterValue(cmd, "osbError").ToString
                    End Using

                Case "ORACLE"

                    Dim cmd As New OracleCommand(SP_proInsMantenimientoNotaEnc, Oracle.OracleConnection)
                    cmd.CommandType = CommandType.StoredProcedure
                    Using cmd
                        'cmd.BindByName = True
                        cmd.Parameters.Add(New OracleParameter("inuProducto", OracleDbType.Int64, 15)).Value = Convert.ToInt64(inuProducto)
                        cmd.Parameters.Add(New OracleParameter("isbNovedad", OracleDbType.Varchar2, 4)).Value = isbNovedad
                        If inuConcepto <> "" Then
                            cmd.Parameters.Add(New OracleParameter("inuConcepto", OracleDbType.Int64, 4)).Value = Convert.ToInt64(inuConcepto)
                        Else
                            cmd.Parameters.Add(New OracleParameter("inuConcepto", OracleDbType.Int64)).Value = DBNull.Value
                        End If
                        If inuCuenta_cobro <> "" Then
                            cmd.Parameters.Add(New OracleParameter("inuCuenta_cobro", OracleDbType.Int64, 10)).Value = Convert.ToInt64(inuCuenta_cobro)
                        Else
                            cmd.Parameters.Add(New OracleParameter("inuCuenta_cobro", DBNull.Value))
                        End If
                        cmd.Parameters.Add(New OracleParameter("inuValor", OracleDbType.Int64, 11)).Value = Convert.ToInt64(inuValor)
                        cmd.Parameters.Add(New OracleParameter("inuCausa_cargo", OracleDbType.Int64, 2)).Value = inuCausa_cargo
                        If inuCuotas <> "" Then
                            cmd.Parameters.Add(New OracleParameter("inuCuotas", OracleDbType.Int64, 3)).Value = Convert.ToInt64(inuCuotas)
                        Else
                            cmd.Parameters.Add(New OracleParameter("inuCuotas", DBNull.Value))
                        End If
                        If inuPlan_diferido <> "" Then
                            cmd.Parameters.Add(New OracleParameter("inuPlan_diferido", OracleDbType.Int64, 4)).Value = Convert.ToInt64(inuPlan_diferido)
                        Else
                            cmd.Parameters.Add(New OracleParameter("inuPlan_diferido", DBNull.Value))
                        End If
                        cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                        cmd.ExecuteNonQuery()
                        If Not IsDBNull(cmd.Parameters("osbError").Value) Then
                            osbError = cmd.Parameters("osbError").Value.ToString
                        End If
                    End Using
            End Select

            Return osbError
        End Function

        '[CALCULAR PROYECTADO]
        Public Function CalcularProyectado(ByVal inuProducto As Int64, ByRef osbError As String) As String
            Dim DSMANOT As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(SP_proCalcularProyectado)
                    Using cmd
                        OpenDataBase.db.AddInParameter(cmd, "inuProducto", DbType.Int32, inuProducto)
                        OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                        OpenDataBase.db.ExecuteNonQuery(cmd)
                        osbError = OpenDataBase.db.GetParameterValue(cmd, "osbError").ToString
                    End Using
                Case "ORACLE"
                    Dim cmd As New OracleCommand(SP_proCalcularProyectado, Oracle.OracleConnection)
                    cmd.CommandType = CommandType.StoredProcedure
                    Using cmd
                        'cmd.BindByName = True
                        cmd.Parameters.Add(New OracleParameter("inuProducto", OracleDbType.Int64)).Value = inuProducto
                        cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                        cmd.ExecuteNonQuery()
                        If Not IsDBNull(cmd.Parameters("osbError").Value) Then
                            osbError = cmd.Parameters("osbError").Value.ToString
                        End If
                    End Using
            End Select

            Return osbError
        End Function

        '[OBTENER DATATABLE GRID DEUDA ACTUAL]
        Public Function ObtenerDatatableGridDeudaActual(ByVal inuProducto As Integer) As DataTable
            Dim Listado = New Dictionary(Of Integer, String)
            Dim DSMANOT As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(SP_proMostrarDeudaActual)
                    Using cmd
                        'OJO: EL ORDEN DE LOS PARAMETROS ES IMPORTANTE
                        OpenDataBase.db.AddInParameter(cmd, "inuProducto", DbType.Int64, Convert.ToInt64(inuProducto))
                        OpenDataBase.db.AddParameterRefCursor(cmd)
                        ''DANVAL modificacion 10.12.18
                        OpenDataBase.db.AddOutParameter(cmd, "onucreditbalance", DbType.Int64, 15)
                        OpenDataBase.db.AddOutParameter(cmd, "onuclaimvalue", DbType.Int64, 15)
                        OpenDataBase.db.AddOutParameter(cmd, "onudefclaimvalue", DbType.Int64, 15)
                        ''
                        OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                        Try
                            OpenDataBase.db.LoadDataSet(cmd, DSMANOT, "Tabla")
                        Catch ex As Exception
                            MsgBox("SP_proMostrarDeudaActual: ERROR" + vbCrLf + "Rows.Count: " + DSMANOT.Tables(0).Rows.Count.ToString + vbCrLf + ex.Message)
                        End Try
                    End Using
                Case "ORACLE"
                    DSMANOT.Tables.Add("Tabla")
                    Dim cmd As New OracleCommand(SP_proMostrarDeudaActual, Oracle.OracleConnection)
                    Using cmd
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.BindByName = True
                        'OJO: EL ORDEN DE LOS PARAMETROS ES IMPORTANTE
                        cmd.Parameters.Add(New OracleParameter("inuProducto", OracleDbType.Int32)).Value = inuProducto
                        cmd.Parameters.Add(New OracleParameter("ocrldc_mantenimiento_notas_pr", OracleDbType.RefCursor, ParameterDirection.Output))
                        cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                        DSMANOT.Tables("Tabla").Load(cmd.ExecuteReader)
                    End Using
            End Select
            Contrato.ProductoConceptos = DSMANOT.Tables("Tabla")

            Return Contrato.ProductoConceptos
        End Function

        'DANVAL 10-12-18
        Public Function ObtenerDatatableGridDeudaActual_1(ByVal inuProducto As Integer) As String
            Dim Listado = New Dictionary(Of Integer, String)
            Dim DSMANOT As New DataSet
            Dim d1 As String = ""
            Dim d2 As String = ""
            Dim d3 As String = ""
            Dim datos As String = ""
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(SP_proMostrarDeudaActual)
                    Using cmd
                        'OJO: EL ORDEN DE LOS PARAMETROS ES IMPORTANTE
                        OpenDataBase.db.AddInParameter(cmd, "inuProducto", DbType.Int64, Convert.ToInt64(inuProducto))
                        OpenDataBase.db.AddParameterRefCursor(cmd)
                        ''danval modificacion 10.12.18
                        OpenDataBase.db.AddOutParameter(cmd, "onucreditbalance", DbType.Int64, 15)
                        OpenDataBase.db.AddOutParameter(cmd, "onuclaimvalue", DbType.Int64, 15)
                        OpenDataBase.db.AddOutParameter(cmd, "onudefclaimvalue", DbType.Int64, 15)
                        ''
                        OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                        Try
                            OpenDataBase.db.LoadDataSet(cmd, DSMANOT, "Tabla")
                            d1 = OpenDataBase.db.GetParameterValue(cmd, "onucreditbalance")
                            d2 = OpenDataBase.db.GetParameterValue(cmd, "onuclaimvalue")
                            d3 = OpenDataBase.db.GetParameterValue(cmd, "onudefclaimvalue")
                            datos = d1 + "|" + d2 + "|" + d3
                        Catch ex As Exception
                            MsgBox("SP_proMostrarDeudaActual: ERROR" + vbCrLf + "Rows.Count: " + DSMANOT.Tables(0).Rows.Count.ToString + vbCrLf + ex.Message)
                        End Try
                    End Using
                Case Else
                    datos = "0|0|0"
            End Select

            Return datos
        End Function

        '[OBTENER DATATABLE GRID PROYECTADO]
        Public Function ObtenerDatatableGridProyectado(ByVal inuProducto As Integer) As DataTable
            Dim Listado = New Dictionary(Of Integer, String)
            Dim DSMANOT As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(SP_proMostrarProyectado)
                    Using cmd
                        'OJO: EL ORDEN DE LOS PARAMETROS ES IMPORTANTE
                        OpenDataBase.db.AddInParameter(cmd, "inuProducto", DbType.Int64, Convert.ToInt64(inuProducto))
                        OpenDataBase.db.AddParameterRefCursor(cmd)
                        OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                        Try
                            OpenDataBase.db.LoadDataSet(cmd, DSMANOT, "Tabla")
                        Catch ex As Exception
                            MsgBox("SP_proMostrarProyectado: ERROR" + vbCrLf + "Rows.Count: " + DSMANOT.Tables(0).Rows.Count.ToString + vbCrLf + ex.Message)
                        End Try
                    End Using
                Case "ORACLE"
                    DSMANOT.Tables.Add("Tabla")
                    Dim cmd As New OracleCommand(SP_proMostrarProyectado, Oracle.OracleConnection)
                    Using cmd
                        cmd.CommandType = CommandType.StoredProcedure
                        'OJO: EL ORDEN DE LOS PARAMETROS ES IMPORTANTE
                        cmd.Parameters.Add(New OracleParameter("inuProducto", OracleDbType.Int64)).Value = inuProducto
                        cmd.Parameters.Add(New OracleParameter("ocrldc_mantenimiento_notas_pr", OracleDbType.RefCursor, ParameterDirection.Output))
                        cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                        DSMANOT.Tables("Tabla").Load(cmd.ExecuteReader)
                    End Using
            End Select
            Contrato.ProductoConceptos = DSMANOT.Tables("Tabla")

            Return Contrato.ProductoConceptos
        End Function

#End Region

#Region "GRABACION"

        '[GRABAR NOTAS]
        Public Function GrabarNotas(ByVal inuProducto As Int64, ByVal isbObservacion As String, ByRef onuSolicitud As String, ByRef osbError As String) As String
            Dim DSMANOT As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(Fn_proGrabar)
                    Using cmd
                        OpenDataBase.db.AddInParameter(cmd, "inuProducto", DbType.Int32, inuProducto)
                        OpenDataBase.db.AddInParameter(cmd, "isbObservacion", DbType.String, isbObservacion)
                        OpenDataBase.db.AddOutParameter(cmd, "onuSolicitud", DbType.String, 4000)
                        OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                        OpenDataBase.db.ExecuteNonQuery(cmd)
                        osbError = OpenDataBase.db.GetParameterValue(cmd, "osbError").ToString
                        onuSolicitud = OpenDataBase.db.GetParameterValue(cmd, "onuSolicitud").ToString
                    End Using

                Case "ORACLE"
                    Dim cmd As New OracleCommand(Fn_proGrabar, Oracle.OracleConnection)
                    cmd.CommandType = CommandType.StoredProcedure
                    Using cmd
                        'cmd.BindByName = True
                        cmd.Parameters.Add(New OracleParameter("inuProducto", OracleDbType.Int64)).Value = inuProducto
                        cmd.Parameters.Add(New OracleParameter("isbObservacion", OracleDbType.Varchar2, 180, vbNull, ParameterDirection.Input)).Value = isbObservacion
                        cmd.Parameters.Add(New OracleParameter("onuSolicitud", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                        cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                        cmd.ExecuteNonQuery()
                        osbError = cmd.Parameters("osbError").Value.ToString
                        onuSolicitud = cmd.Parameters("onuSolicitud").Value.ToString
                    End Using
            End Select

            Return osbError
        End Function

#End Region

        'MODIFICACION DANVAL - APOYO RONCOL 10.12.18
        Public Sub ServicioSaldos(ByVal inuproductid As Int32, ByVal onucurrentaccounttotal As String, ByVal onudeferredaccounttotal As String, ByVal onucreditbalance As String, ByVal onuclaimvalue As String, ByVal onudefclaimvalue As String)
            onucurrentaccounttotal = "0"
            onudeferredaccounttotal = "0"
            onucreditbalance = "0"
            onuclaimvalue = "0"
            onudefclaimvalue = "0"
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand("fa_boaccountstatustodate.productbalanceaccountstodate")
                    Using cmd
                        OpenDataBase.db.AddInParameter(cmd, "inuproductid", DbType.Int32, inuproductid)
                        OpenDataBase.db.AddInParameter(cmd, "idtdate", DbType.Date, Date.Now)
                        OpenDataBase.db.AddOutParameter(cmd, "onucurrentaccounttotal", DbType.Double, 15)
                        OpenDataBase.db.AddOutParameter(cmd, "onudeferredaccounttotal", DbType.Double, 15)
                        OpenDataBase.db.AddOutParameter(cmd, "onucreditbalance", DbType.Double, 15)
                        OpenDataBase.db.AddOutParameter(cmd, "onuclaimvalue", DbType.Double, 15)
                        OpenDataBase.db.AddOutParameter(cmd, "onudefclaimvalue", DbType.Double, 15)
                        OpenDataBase.db.ExecuteNonQuery(cmd)
                        onucurrentaccounttotal = OpenDataBase.db.GetParameterValue(cmd, "onucurrentaccounttotal")
                        onudeferredaccounttotal = OpenDataBase.db.GetParameterValue(cmd, "onudeferredaccounttotal")
                        onucreditbalance = OpenDataBase.db.GetParameterValue(cmd, "onucreditbalance")
                        onuclaimvalue = OpenDataBase.db.GetParameterValue(cmd, "onuclaimvalue")
                        onudefclaimvalue = OpenDataBase.db.GetParameterValue(cmd, "onudefclaimvalue")
                    End Using

                Case "ORACLE"

            End Select
        End Sub

    End Class

End Namespace