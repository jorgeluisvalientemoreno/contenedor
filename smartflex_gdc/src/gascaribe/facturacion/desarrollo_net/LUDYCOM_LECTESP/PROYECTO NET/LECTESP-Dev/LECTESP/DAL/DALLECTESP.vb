Imports System.Data.Common
Imports OpenSystems.Common.Data
Imports Oracle.DataAccess.Client
Imports Oracle.DataAccess.Types
Imports System.Data.SqlClient
Imports System.Data.SqlTypes
Imports LUDYCOM.LECTESP
Imports LUDYCOM.LECTESP.ENTITIES
Imports System.Globalization
Imports System.Data.OleDb
Imports Excel = Microsoft.Office.Interop.Excel



Public Class DALLECTESP


    '[Ciclos]
    ReadOnly Fn_fcrCiclos As String = "ldc_pkcm_lectesp.fcrCiclosParam"    'Obtener los ciclos de la tabla LDC_CM_LECTESP.
    ReadOnly Fn_fcrPeriodosCriticaHist As String = "ldc_pkcm_lectesp.fcrperiodoscriticahist"    'Obtener los ciclos de la tabla LDC_CM_LECTESP.

    ReadOnly Fn_fcrPefaCiclos As String = "ldc_pkcm_lectesp.fcrPefaCiclos"    'Obtener los periodos de facturacion de un ciclo.
    ReadOnly Fn_fcrObtenerCriticas As String = "ldc_pkcm_lectesp.fcrObtenerCriticas"    'Obtener la tabla LDC_CM_LECTESP_CRIT con datos descriptivos.

    ReadOnly SP_proGeneraCritica As String = "ldc_pkcm_lectesp.progeneracritica"    'Generar las criticas y las inserta en LDC_CM_LECTESP_CRIT con estado No Procesado.
    ReadOnly SP_proActualizaPresFaco As String = "ldc_pkcm_lectesp.proactualizapresfaco"    'Actualiza la presion del producto en la variable 'PRESION_OPERACION' de la tabla CM_VAVAFACO.
    ReadOnly SP_proProcesaCritica As String = "ldc_pkcm_lectesp.proprocesacritica"    'Actualiza la presion del producto en la variable 'PRESION_OPERACION' de la tabla CM_VAVAFACO.

    ReadOnly SP_proactordenamiento As String = "ldc_pkcm_lectesp.proactordenamiento"


    ''' <summary>
    ''' Constructor
    ''' </summary>
    Sub New()
        If General.ModoDesarrollo = False Then
            General.EstadoConexion = OpenDataBase.DBConnectionState
        Else
            General.EstadoConexion = General.Oracle.Conexion.State
        End If
    End Sub

    ' <summary>
    ' Valida la conexion que se esta utilizando. OPEN
    ' </summary>
    ' <returns>String con el nombre de la conexion ( LOCAL >> "ORACLE" | INTEGRADO OSF >> "OPEN" ) </returns>
    Public Function CheckConnection() As String
        Dim var As String = String.Empty
        If General.ModoDesarrollo = False Then
            If Not (OpenDataBase.DBConnectionState = ConnectionState.Closed Or OpenDataBase.DBConnectionState = ConnectionState.Broken) Then
                var = "OPEN"
            End If
        Else
            If Not (Oracle.Conexion.State = ConnectionState.Closed Or Oracle.Conexion.State = ConnectionState.Broken) Then
                var = "ORACLE"
            Else
                var = "SIN CONEXION"
                App.MsgObsDefault += vbCrLf + "Error de Conexion!"
            End If
        End If
        TipoConexion = var
        Return General.TipoConexion
    End Function

    ' <summary>
    ' Consulta los ciclos de clientes especiales parametrizados en la tabla LDC_CM_LECTESP_CICL.
    ' </summary>
    ' <returns> Cursor referenciado (DataTable) </returns>
    Public Function ObtenerListadoCiclos() As DataTable
        Dim Listado = New Dictionary(Of Integer, String)
        Dim DST As New DataSet
        Select Case CheckConnection()
            Case "OPEN"
                Dim cmd As DbCommand
                cmd = OpenDataBase.db.GetStoredProcCommand(Fn_fcrCiclos)
                Using cmd
                    OpenDataBase.db.AddReturnRefCursor(cmd)
                    OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                    OpenDataBase.db.LoadDataSet(cmd, DST, "Tabla")
                End Using
            Case "ORACLE"
                DST.Tables.Add("Tabla")
                Dim cmd As New OracleCommand(Fn_fcrCiclos, Oracle.Conexion)
                Using cmd
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.BindByName = True
                    cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                    cmd.Parameters.Add(New OracleParameter("RETURN_VALUE", OracleDbType.RefCursor, ParameterDirection.ReturnValue))
                    DST.Tables("Tabla").Load(cmd.ExecuteReader)
                End Using
        End Select

        Return DST.Tables("Tabla")
    End Function


    Public Function getCiclos() As DataSet
        Dim Listado = New Dictionary(Of Integer, String)
        Dim DST As New DataSet
        Select Case CheckConnection()
            Case "OPEN"
                Dim cmd As DbCommand
                cmd = OpenDataBase.db.GetStoredProcCommand(Fn_fcrCiclos)
                Using cmd
                    OpenDataBase.db.AddReturnRefCursor(cmd)
                    OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                    OpenDataBase.db.LoadDataSet(cmd, DST, "Tabla")
                End Using
            Case "ORACLE"
                DST.Tables.Add("Tabla")
                Dim cmd As New OracleCommand(Fn_fcrCiclos, Oracle.Conexion)
                Using cmd
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.BindByName = True
                    cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                    cmd.Parameters.Add(New OracleParameter("RETURN_VALUE", OracleDbType.RefCursor, ParameterDirection.ReturnValue))
                    DST.Tables("Tabla").Load(cmd.ExecuteReader)
                End Using
        End Select

        Return DST
    End Function

    Public Function getPefaCiclos(ByVal nuCiclo As Integer) As DataSet
        Dim DST As New DataSet
        Select Case CheckConnection()
            Case "OPEN"
                Dim cmd As DbCommand
                cmd = OpenDataBase.db.GetStoredProcCommand(Fn_fcrPefaCiclos)
                Using cmd
                    OpenDataBase.db.AddReturnRefCursor(cmd)
                    OpenDataBase.db.AddInParameter(cmd, "inupefaciclo", DbType.Int32, nuCiclo)
                    OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                    OpenDataBase.db.LoadDataSet(cmd, DST, "Tabla")
                End Using
            Case "ORACLE"
                DST.Tables.Add("Tabla")
                Dim cmd As New OracleCommand(Fn_fcrPefaCiclos, Oracle.Conexion)
                Using cmd
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.BindByName = True
                    cmd.Parameters.Add(New OracleParameter("inupefaciclo", OracleDbType.Int32, 15, ParameterDirection.Input)).Value = nuCiclo
                    cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                    cmd.Parameters.Add(New OracleParameter("RETURN_VALUE", OracleDbType.RefCursor, ParameterDirection.ReturnValue))
                    DST.Tables("Tabla").Load(cmd.ExecuteReader)
                End Using
        End Select

        Return DST
    End Function
    ' <summary>
    ' Consulta los periodos de un ciclo.
    ' </summary>
    ' <returns> Cursor referenciado (DataTable) </returns>
    Public Function ObtenerPeriodByCiclo(ByVal nuCiclo As Integer) As DataTable
        Dim Listado = New Dictionary(Of Integer, String)
        Dim DST As New DataSet
        Select Case CheckConnection()
            Case "OPEN"
                Dim cmd As DbCommand
                cmd = OpenDataBase.db.GetStoredProcCommand(Fn_fcrPefaCiclos)
                Using cmd
                    OpenDataBase.db.AddReturnRefCursor(cmd)
                    OpenDataBase.db.AddInParameter(cmd, "inupefaciclo", DbType.Int32)
                    OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                    OpenDataBase.db.LoadDataSet(cmd, DST, "Tabla")
                End Using
            Case "ORACLE"
                DST.Tables.Add("Tabla")
                Dim cmd As New OracleCommand(Fn_fcrPefaCiclos, Oracle.Conexion)
                Using cmd
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.BindByName = True
                    cmd.Parameters.Add(New OracleParameter("inupefaciclo", OracleDbType.Int32, vbNull, ParameterDirection.Input))
                    cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                    cmd.Parameters.Add(New OracleParameter("RETURN_VALUE", OracleDbType.RefCursor, ParameterDirection.ReturnValue))
                    DST.Tables("Tabla").Load(cmd.ExecuteReader)
                End Using
        End Select

        Return DST.Tables("Tabla")
    End Function

    ' <summary>
    ' 'Obtener los periodos de facturacion de un ciclo.
    ' </summary>
    ' <returns>Cursor referenciado (DataTable)</returns>
    Public Function ListadoPeriodosCiclosHistCritica() As DataTable
        Dim Listado = New Dictionary(Of Integer, String)
        Dim DST As New DataSet("Tabla")
        Select Case CheckConnection()
            Case "OPEN"
                Dim cmd As DbCommand
                cmd = OpenDataBase.db.GetStoredProcCommand(Fn_fcrPeriodosCriticaHist)
                Using cmd
                    OpenDataBase.db.AddReturnRefCursor(cmd)
                    OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                    OpenDataBase.db.LoadDataSet(cmd, DST, "Tabla")
                End Using
            Case "ORACLE"
                DST.Tables.Add("Tabla")
                Dim cmd As New OracleCommand(Fn_fcrPeriodosCriticaHist, Oracle.Conexion)
                Using cmd
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.BindByName = True
                    cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                    cmd.Parameters.Add(New OracleParameter("RETURN_VALUE", OracleDbType.RefCursor, ParameterDirection.ReturnValue))
                    DST.Tables("Tabla").Load(cmd.ExecuteReader)
                End Using
        End Select


        Return DST.Tables("Tabla")
    End Function

    ' <summary>
    ' Obtener un listado de datos de acuerdo al proceso enviado.
    ' </summary>
    ' <returns>Cursor referenciado (DataTable)</returns>
    Public Function ObtenerListado(ByVal Proceso As String, Optional ByVal Flag As String = "") As DataTable
        Dim Listado = New Dictionary(Of Integer, String)
        Dim DST As New DataSet("Tabla")
        Select Case CheckConnection()
            Case "OPEN"
                Dim cmd As DbCommand
                cmd = OpenDataBase.db.GetStoredProcCommand(Proceso)
                Using cmd
                    OpenDataBase.db.AddReturnRefCursor(cmd)
                    If Flag = "CriticaHistorica" Then
                        OpenDataBase.db.AddInParameter(cmd, "isbAccion", DbType.String, "HP") 'HP - Historico de Procesados
                    ElseIf Flag = "Criticas" Then
                        OpenDataBase.db.AddInParameter(cmd, "isbAccion", DbType.String, "NP") 'NP - No Procesados
                    End If
                    OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                    OpenDataBase.db.LoadDataSet(cmd, DST, "Tabla")
                End Using
            Case "ORACLE"
                DST.Tables.Add("Tabla")
                Dim cmd As New OracleCommand(Proceso, Oracle.Conexion)
                Using cmd
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.BindByName = True
                    If Flag = "CriticaHistorica" Then
                        cmd.Parameters.Add(New OracleParameter("isbAccion", OracleDbType.Varchar2, 15)).Value = "HP" 'HP - Historico de Procesados
                    End If
                    cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                    cmd.Parameters.Add(New OracleParameter("RETURN_VALUE", OracleDbType.RefCursor, ParameterDirection.ReturnValue))
                    DST.Tables("Tabla").Load(cmd.ExecuteReader)
                End Using
        End Select

        Return DST.Tables("Tabla")
    End Function

    ' <summary>
    ' Obtener un listado de datos de acuerdo al proceso enviado.
    ' </summary>
    ' <returns>Cursor referenciado (DataTable)</returns>
    Public Function ObtenerListadoF(ByVal Proceso As String, ByVal ciclo As String, ByVal periodo As String, ByVal procesado As String) As DataTable
        Dim Listado = New Dictionary(Of Integer, String)
        Dim DST As New DataSet("Tabla")
        Select Case CheckConnection()
            Case "OPEN"
                Dim cmd As DbCommand
                cmd = OpenDataBase.db.GetStoredProcCommand(Proceso)
                Using cmd
                    OpenDataBase.db.AddReturnRefCursor(cmd)
                    OpenDataBase.db.AddInParameter(cmd, "isbAccion", DbType.String, "NP") 'NP - No Procesados
                    OpenDataBase.db.AddInParameter(cmd, "isbCiclo", DbType.String, ciclo)
                    OpenDataBase.db.AddInParameter(cmd, "isbPeriodo", DbType.String, periodo)
                    OpenDataBase.db.AddInParameter(cmd, "isbProcess", DbType.String, procesado)
                    OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                    OpenDataBase.db.LoadDataSet(cmd, DST, "Tabla")
                End Using
            Case "ORACLE"
                DST.Tables.Add("Tabla")
                Dim cmd As New OracleCommand(Proceso, Oracle.Conexion)
                Using cmd
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.BindByName = True
                    cmd.Parameters.Add(New OracleParameter("isbAccion", OracleDbType.Varchar2, 15)).Value = "NP" 'NP - No Procesados
                    cmd.Parameters.Add(New OracleParameter("isbCiclo", OracleDbType.Varchar2, 15)).Value = ciclo
                    cmd.Parameters.Add(New OracleParameter("isbPeriodo", OracleDbType.Varchar2, 15)).Value = periodo
                    cmd.Parameters.Add(New OracleParameter("isbProcesado", OracleDbType.Varchar2, 15)).Value = procesado
                    cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                    cmd.Parameters.Add(New OracleParameter("RETURN_VALUE", OracleDbType.RefCursor, ParameterDirection.ReturnValue))
                    DST.Tables("Tabla").Load(cmd.ExecuteReader)
                End Using
        End Select

        Return DST.Tables("Tabla")
    End Function

    ' <summary>
    ' Actualiza la presion del producto en la variable 'PRESION_OPERACION' de la tabla CM_VAVAFACO.
    ' </summary>
    ' <returns> Nada </returns>
    Public Function ActualizarPresionFaco(ByVal inuproducto As Int64, ByVal inupresionact As Double, ByVal inuorden As Int64, ByRef osberror As String) As Boolean
        Dim Resultado As Boolean = True
        Select Case CheckConnection()
            Case "OPEN"
                Dim cmd As DbCommand
                cmd = OpenDataBase.db.GetStoredProcCommand(SP_proActualizaPresFaco)
                Using cmd
                    'OJO: EL ORDEN DE LOS PARAMETROS ES IMPORTANTE
                    OpenDataBase.db.AddInParameter(cmd, "inuproducto", DbType.Int64, inuproducto)
                    OpenDataBase.db.AddInParameter(cmd, "inuorden", DbType.Int64, inuorden)
                    OpenDataBase.db.AddInParameter(cmd, "inupresionact", DbType.Double, inupresionact)
                    OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                    OpenDataBase.db.ExecuteNonQuery(cmd)
                    osberror = OpenDataBase.db.GetParameterValue(cmd, "osbError").ToString
                    If osberror <> "" Then
                        Resultado = False
                    End If
                End Using

            Case "ORACLE"

                Dim cmd As New OracleCommand(SP_proActualizaPresFaco, Oracle.Conexion)
                cmd.CommandType = CommandType.StoredProcedure
                Using cmd
                    'cmd.BindByName = True
                    cmd.Parameters.Add(New OracleParameter("inuProducto", OracleDbType.Int64, 15)).Value = Convert.ToInt64(inuproducto)
                    cmd.Parameters.Add(New OracleParameter("inuorden", OracleDbType.Int64, 15)).Value = Convert.ToInt64(inuorden)
                    cmd.Parameters.Add(New OracleParameter("inupresionact", OracleDbType.Double, 15)).Value = inupresionact
                    cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                    cmd.ExecuteNonQuery()
                    osberror = cmd.Parameters("osbError").Value.ToString
                    If osberror <> "" And osberror <> "null" Then
                        Resultado = False
                    End If
                End Using
        End Select

        Return Resultado
    End Function

    ' <summary>
    ' Actualizar la tabla de criticas con la presion y lectura final digitada por el usuario
    ' </summary>
    ' <returns> Boolean segun el resultado de la operacion </returns>
    Public Function ProcesarCritica(ByVal inucriticaid As Int64, ByVal inupresionfinal As Double, ByVal inulecturafinal As Int64, ByRef osberror As String) As Boolean
        Dim Resultado As Boolean = True
        Select Case CheckConnection()
            Case "OPEN"
                Dim cmd As DbCommand
                cmd = OpenDataBase.db.GetStoredProcCommand(SP_proProcesaCritica)
                Using cmd
                    'OJO: EL ORDEN DE LOS PARAMETROS ES IMPORTANTE
                    OpenDataBase.db.AddInParameter(cmd, "inucriticaid", DbType.Int64, inucriticaid)
                    OpenDataBase.db.AddInParameter(cmd, "inupresionfinal", DbType.Double, inupresionfinal)
                    OpenDataBase.db.AddInParameter(cmd, "inulecturafinal", DbType.Int64, inulecturafinal)
                    OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                    OpenDataBase.db.ExecuteNonQuery(cmd)
                    osberror = OpenDataBase.db.GetParameterValue(cmd, "osbError").ToString
                    If osberror <> "" Then
                        Resultado = False
                    End If
                End Using

            Case "ORACLE"
                'Dim MiCultura As CultureInfo

                'Dim Posicion As Integer

                'Dim MiFormato As NumberFormatInfo = New CultureInfo(CultureInfo.CurrentCulture.ToString(), False).NumberFormat

                'MiFormato.NumberDecimalSeparator = ","
                'Dim Numero As Decimal
                'Cifra = TextBox1.Text

                'Posicion = InStr(Cifra.ToString("N", MiFormato), MiFormato.NumberDecimalSeparator)

                'Cifra = Mid(Cifra.ToString, 1, Posicion + MiFormato.NumberDecimalDigits)

                'MessageBox.Show(Cifra.ToString("N", MiFormato))
                Dim cmd As New OracleCommand(SP_proProcesaCritica, Oracle.Conexion)
                cmd.CommandType = CommandType.StoredProcedure
                Using cmd
                    'cmd.BindByName = True
                    cmd.Parameters.Add(New OracleParameter("inucriticaid", OracleDbType.Int64, 15)).Value = Convert.ToInt64(inucriticaid)
                    cmd.Parameters.Add(New OracleParameter("inupresionfinal", OracleDbType.Double, 15)).Value = inupresionfinal
                    cmd.Parameters.Add(New OracleParameter("inulecturafinal", OracleDbType.Int64, 15)).Value = Convert.ToInt64(inulecturafinal)
                    cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                    cmd.ExecuteNonQuery()
                    osberror = cmd.Parameters("osbError").Value.ToString
                    If osberror <> "" And osberror <> "null" Then
                        Resultado = False
                    End If
                End Using
        End Select

        Return Resultado
    End Function

    Public Function ActOrdenamiento(ByVal isbdatos As String, ByRef onuerrorcode As Int64, ByRef osberror As String) As Boolean
        Dim Resultado As Boolean = True
        Select Case CheckConnection()
            Case "OPEN"
                Dim cmd As DbCommand
                cmd = OpenDataBase.db.GetStoredProcCommand(SP_proactordenamiento)
                Using cmd
                    'OJO: EL ORDEN DE LOS PARAMETROS ES IMPORTANTE
                    OpenDataBase.db.AddInParameter(cmd, "isbdatos", DbType.String, isbdatos)
                    OpenDataBase.db.AddOutParameter(cmd, "onuerrorcode", DbType.Int64, 14)
                    OpenDataBase.db.AddOutParameter(cmd, "osberror", DbType.String, 4000)
                    OpenDataBase.db.ExecuteNonQuery(cmd)
                    onuerrorcode = OpenDataBase.db.GetParameterValue(cmd, "onuerrorcode").ToString
                    osberror = OpenDataBase.db.GetParameterValue(cmd, "osbError").ToString
                    If String.IsNullOrEmpty(osberror) = False Then
                        Resultado = False
                    End If
                End Using

            Case "ORACLE"
                Dim cmd As New OracleCommand(SP_proactordenamiento, Oracle.Conexion)
                cmd.CommandType = CommandType.StoredProcedure
                Using cmd
                    'cmd.BindByName = True
                    cmd.Parameters.Add(New OracleParameter("isbdatos", OracleDbType.Varchar2, 15)).Value = isbdatos
                    cmd.Parameters.Add(New OracleParameter("onuerrorcode", OracleDbType.Int64, 15, vbNull, ParameterDirection.Output))
                    cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                    cmd.ExecuteNonQuery()
                    onuerrorcode = Convert.ToInt64(cmd.Parameters("onuerrorcode").Value.ToString)
                    osberror = cmd.Parameters("osbError").Value.ToString
                    If String.IsNullOrEmpty(osberror) = False And osberror <> "null" Then
                        Resultado = False
                    Else
                        osberror = String.Empty
                    End If
                End Using
        End Select

        Return Resultado
    End Function


    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="Grid"></param>
    ''' <param name="RutaArchivo"></param>
    ''' <param name="osbMensajeError"></param>
    ''' <returns></returns>
    ''' <remarks>
    ''' See more at: http://www.visual-basic-tutorials.com/export-datagridview-to-excel-in-visual-basic.html#sthash.h477cGnj.dpuf 
    ''' https://social.msdn.microsoft.com/Forums/es-ES/a34cae9a-0d22-472b-a022-26f544881826/exportar-de-datagridview-a-excel-con-formato-en-visual-basic?forum=dotnetes
    ''' </remarks>
    ''' 
    Public Function ExportarGridAExcel(ByVal Grid As DataGridView, ByVal RutaArchivo As String, ByRef osbMensajeError As String) As Boolean

        Dim APP As New Excel.Application, worksheet As Excel.Worksheet, workbook As Excel.Workbook
        Dim BoOK As Boolean = True
        Dim columnIndex As Integer = 0

        Application.DoEvents()

        workbook = APP.Workbooks.Add

        worksheet = workbook.Sheets(1)

        Try
            With Grid
                'Export Header Names Start
                Dim columnsCount As Integer = .Columns.Count
                For Each column In .Columns
                    worksheet.Cells(1, column.Index + 1).Value = column.Name
                Next
                'Export Header Name End

                'Export Each Row Start
                For i As Integer = 0 To .Rows.Count - 1
                    columnIndex = 0
                    Do Until columnIndex = columnsCount
                        Dim Value As String = String.Empty
                        If TypeOf .Columns(columnIndex) Is DataGridViewCheckBoxColumn Then
                            Value = CType(.Item(columnIndex, i).Value, Integer).ToString
                        Else
                            If Not .Item(columnIndex, i).Value Is Nothing Then
                                Value = .Item(columnIndex, i).Value.ToString
                            Else
                                Value = String.Empty
                            End If
                        End If
                        worksheet.Cells(i + 2, columnIndex + 1).Value = Value
                        columnIndex += 1
                    Loop
                Next
                'Export Each Row End

                Dim objRango As Excel.Range = worksheet.Range("A1:AL" + (.Rows.Count + 1).ToString)
                objRango.AutoFilter(Field:=1, Operator:=Excel.XlAutoFilterOperator.xlFilterValues)
                objRango.Columns.AutoFit()

                workbook.SaveAs(RutaArchivo, Excel.XlFileFormat.xlExcel8)
                APP.Visible = True
                'workbook.Close() 'Cierra el libro
                'APP.Quit() 'Cierra la instancia de Excel creada pero no cierra el proceso
            End With

        Catch ex As Exception
            osbMensajeError = "Error al exportar datos a Excel" + vbCrLf + "Detalle: " + ex.Message
            BoOK = False
        Finally
            General.ReleaseObject(worksheet)
            General.ReleaseObject(workbook)
            General.ReleaseObject(APP)
        End Try

        Return BoOK

    End Function

    ' <summary>
    ' inserta las criticas a partir de los datos de la tabla de Lecturas de Moviles (LDC_CM_LECTESP)
    ' </summary>
    ' <returns> Boolean segun el resultado de la operacion </returns>
    Public Function GeneraCritica(ByRef osberror As String) As Boolean
        Dim Resultado As Boolean = True

        Select Case CheckConnection()
            Case "OPEN"
                Dim cmd As DbCommand
                cmd = OpenDataBase.db.GetStoredProcCommand(SP_proGeneraCritica)
                Using cmd
                    'OJO: EL ORDEN DE LOS PARAMETROS ES IMPORTANTE
                    OpenDataBase.db.AddInParameter(cmd, "isbAccion", DbType.String, 20)
                    OpenDataBase.db.AddOutParameter(cmd, "osbError", DbType.String, 4000)
                    OpenDataBase.db.ExecuteNonQuery(cmd)
                    osberror = OpenDataBase.db.GetParameterValue(cmd, "osbError").ToString
                    If osberror <> "" Then
                        Resultado = False
                    End If
                End Using

            Case "ORACLE"
                Dim cmd As New OracleCommand(SP_proGeneraCritica, Oracle.Conexion)
                cmd.CommandType = CommandType.StoredProcedure
                Using cmd
                    'cmd.BindByName = True
                    cmd.Parameters.Add(New OracleParameter("isbAccion", OracleDbType.Varchar2, 20, vbNull, ParameterDirection.Input))
                    cmd.Parameters.Add(New OracleParameter("osbError", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                    cmd.ExecuteNonQuery()
                    osberror = cmd.Parameters("osbError").Value.ToString
                    If Not osberror = "null" Then
                        osberror = cmd.Parameters("osbError").Value.ToString
                        Resultado = False
                    Else
                        osberror = String.Empty
                    End If
                End Using
        End Select

        Return Resultado
    End Function

    ' <summary>
    ' Carga procesos de BDD que devuelven cursores
    ' </summary>
    ' <returns> Boolean segun el resultado de la operacion </returns>
    Public Function getPefaByCiclo(ByVal nuCiclo As Integer) As BindingSource
        Dim Dr As DataTableReader
        getPefaByCiclo = New BindingSource
        Dim MyDT As DataTable = Me.ObtenerPeriodByCiclo(nuCiclo)
        Dr = MyDT.CreateDataReader
        Dim Listado = New Dictionary(Of Integer, String)
        While Dr.Read
            Listado.Add(Dr(0), Dr(1).ToString)
        End While

        If MyDT.Rows.Count > 0 Then
            getPefaByCiclo = New BindingSource(Listado, Nothing)
        Else
            getPefaByCiclo.DataSource = Nothing
        End If

    End Function

    ' <summary>
    ' Carga procesos de BDD que devuelven cursores
    ' </summary>
    ' <returns> Boolean segun el resultado de la operacion </returns>
    Public Function GetListado(ByVal Tipo As String) As BindingSource
        Dim Dr As DataTableReader
        GetListado = New BindingSource
        Select Case Tipo

            Case "Estados"
                Dim Listado = New Dictionary(Of String, String)
                Listado.Add("0", "-Todos-")
                Listado.Add("N", "N - NO PROCESADO")
                Listado.Add("S", "S - PROCESADO")
                GetListado = New BindingSource(Listado, Nothing)

            Case "Ciclos"
                Dim MyDT As DataTable = Me.ObtenerListadoCiclos()
                Dr = MyDT.CreateDataReader
                Dim Listado = New Dictionary(Of Integer, String)
                Listado.Add(-1, "-Todos-")
                While Dr.Read
                    Listado.Add(Dr(0), Dr(1).ToString)
                End While

                If MyDT.Rows.Count > 0 Then
                    GetListado = New BindingSource(Listado, Nothing)
                Else
                    GetListado.DataSource = Nothing
                End If

            Case "PeriodosCiclosHistoricos"
                'Se carga (App.DataTablePeriodosHistoricos) la primera vez y busca los datos a la BDD
                'Establezco le BindinSource de los Periodos y ciclos historicos de las Criticas
                If App.FormularioCargado = False Then
                    DataTablePeriodosHistoricos = New DataTable
                    DataTablePeriodosHistoricos = Me.ListadoPeriodosCiclosHistCritica()
                End If
                If DataTablePeriodosHistoricos.Rows.Count > 0 Then
                    GetListado = New BindingSource(DataTablePeriodosHistoricos, Nothing)
                Else
                    GetListado.DataSource = Nothing
                End If

            Case "PeriodosCiclosHistoricosLocales"
                'Trabaja con los datos localmente (App.DataTablePeriodosHistoricos)
                Dr = DataTablePeriodosHistoricos.CreateDataReader
                Dim Listado = New Dictionary(Of Integer, String)
                Listado.Add(999999999, "-Todos-")
                While Dr.Read
                    Listado.Add(Dr(0), Dr(0).ToString + " - " + Dr(1).ToString)
                End While
                If DataTablePeriodosHistoricos.Rows.Count > 0 Then
                    GetListado = New BindingSource(Listado, Nothing)
                Else
                    GetListado.DataSource = Nothing
                End If

            Case "Criticas"
                'Se carga desde la BDD si los Flag coinciden
                If App.FormularioCargado = False Or App.FlagCargarCriticasdesdeBDD = True Then
                    App.DataTableCritica = New DataTable
                    App.DataTableCritica = Me.ObtenerListado(Fn_fcrObtenerCriticas, "Criticas")
                End If
                Try
                    If Not App.DataTableCritica Is Nothing Then
                        If App.DataTableCritica.Rows.Count > 0 Then
                            GetListado = New BindingSource(App.DataTableCritica, Nothing)
                        Else
                            GetListado.DataSource = Nothing
                        End If
                    Else
                        GetListado.DataSource = Nothing
                    End If
                Catch ex As Exception
                    RaiseMensaje("Error cargando Criticas." + vbCrLf + ex.Message, 1000, MsgBoxStyle.Critical)
                End Try

            Case "CriticaHistorica"
                'Se carga desde la BDD si los Flag coinciden
                'If App.FormularioCargado = True Or App.FlagCargarCriticasdesdeBDD = True Then
                App.DataTableCriticaHistorica = New DataTable
                App.DataTableCriticaHistorica = Me.ObtenerListado(Fn_fcrObtenerCriticas, "CriticaHistorica")
                'End If
                Try
                    If Not App.DataTableCriticaHistorica Is Nothing Then
                        If App.DataTableCriticaHistorica.Rows.Count > 0 Then
                            GetListado = New BindingSource(App.DataTableCriticaHistorica, Nothing)
                        Else
                            GetListado.DataSource = Nothing
                        End If
                    Else
                        GetListado.DataSource = Nothing
                    End If
                Catch ex As Exception
                    RaiseMensaje("Error cargando Critica Historica." + vbCrLf + ex.Message, 1000, MsgBoxStyle.Critical)
                End Try
        End Select

        Return GetListado
    End Function


#Region "Combos Filtrados"
    ' <summary>
    ' Carga los datos de los combos
    ' </summary>
    ' <returns> BindingSource </returns>
    Public Function FiltrarCombo(ByVal tipo As String, ByVal value As String) As BindingSource
        FiltrarCombo = New BindingSource

        '-------- Inicio Filtrado de Datos -----------
        'Le aplico los filtros si se pasaron en los parametros
        Dim Filter As String = String.Empty
        If Not tipo.ToLower.Contains("hist") Then
            If tipo = "Ciclofactura" Then
                Filter = "Procesado='N'"
            ElseIf tipo = "CicloConsumo" Then
                Filter = "Procesado='N'"
            ElseIf tipo = "Pefactura" Then
                If value.ToString = "999999999" Or value = "" Then
                    Filter = "Procesado='N'"
                Else
                    Filter = "Procesado='N' and sesucico='" + value + "'"
                End If
            ElseIf tipo = "PeConsumo" Then
                Filter = "Procesado='N' and pecscico='" + value + "'"
            End If
        End If

        If tipo.ToLower.Contains("hist") Then
            If String.IsNullOrEmpty(FiltroCritHistorica.Ciclo) Or FiltroCritHistorica.Ciclo = "999999999" Then
                FiltroCritHistorica.Ciclo = "sesucico"
            End If
            If String.IsNullOrEmpty(FiltroCritHistorica.Ano) Or FiltroCritHistorica.Ano = "999999999" Then
                FiltroCritHistorica.Ano = "ano"
            End If
            If String.IsNullOrEmpty(FiltroCritHistorica.Mes) Or FiltroCritHistorica.Mes = "999999999" Then
                FiltroCritHistorica.Mes = "mes"
            End If
            If String.IsNullOrEmpty(FiltroCritHistorica.Pefa) Or FiltroCritHistorica.Pefa = "999999999" Then
                FiltroCritHistorica.Pefa = "pefacodi"
            End If
            Filter = "Procesado='S' " + " and sesucico=" + FiltroCritHistorica.Ciclo + " and ano=" + FiltroCritHistorica.Ano _
             + " and mes=" + FiltroCritHistorica.Mes + " and pefacodi=" + FiltroCritHistorica.Pefa
            FiltroCritHistorica.FiltroFinal = Filter.Replace("Procesado", "proc")
        End If

        'Clono el Datatable Principal al Filtrado (Solo el Esquema) -Clear Rows
        Dim FilterDT As New DataTable
        FilterDT.Load(DataTablePeriodosHistoricos.CreateDataReader)
        'FilterDT.Rows.Clear()

        'Hago el filtro con el Dataview
        Dim Dview As DataView = FilterDT.DefaultView
        Dview.RowFilter = Filter

        ''----------Fin Filtros ------------------------

        If Dview.Count > 0 Then

            'Se arma el listado con el primer registro definido. -Todos-
            Dim Listado = New Dictionary(Of String, String)
            Listado.Add(999999999, "-Todos-")

            'Importo solo las filas filtradas
            For i = 0 To Dview.Count - 1
                With Dview.Item(i)
                    'FilterDT.ImportRow(Dview.Item(i).Row)
                    Try
                        If tipo.ToLower = "ciclofactura" Then
                            Listado.Add(.Row("sesucico").ToString, .Row("ciclofactdesc").ToString)
                        ElseIf tipo.ToLower = "cicloconsumo" Then
                            Listado.Add(.Row("pecscico").ToString, .Row("cicloconsudesc").ToString)
                        ElseIf tipo.ToLower = "pefactura" Then
                            Listado.Add(.Row("pefacodi").ToString, .Row("pefacodi").ToString)
                        ElseIf tipo = "peconsumo" Then
                            Listado.Add(.Row("pecscons").ToString, .Row("pecscons").ToString)
                        End If

                        'Historico
                        If tipo.ToLower = "cicloconsumohist" Then
                            Listado.Add(.Row("pecscico").ToString, .Row("cicloconsudesc").ToString)
                        ElseIf tipo.ToLower = "pefaañohist" Then
                            Listado.Add(.Row("ano").ToString, .Row("ano").ToString)
                        ElseIf tipo.ToLower = "pefameshist" Then
                            Listado.Add(.Row("mes").ToString, .Row("mes").ToString)
                        ElseIf tipo.ToLower = "pefacturahist" Then
                            Listado.Add(.Row("pefacodi").ToString, .Row("pefacodi").ToString)
                        End If

                    Catch ex As Exception
                        'Intercepto el error de insercion de items duplicados
                        'No se ejecuta ningun codigo para dejar solo valores unicos
                    End Try
                End With
            Next

            FiltrarCombo = New BindingSource(Listado, Nothing)
        Else
            FiltrarCombo.DataSource = Nothing
        End If

        Return FiltrarCombo
    End Function

#End Region

End Class
