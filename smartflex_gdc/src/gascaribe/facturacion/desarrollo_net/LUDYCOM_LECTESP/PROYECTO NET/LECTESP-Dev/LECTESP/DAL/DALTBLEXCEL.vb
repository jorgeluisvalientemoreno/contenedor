'Imports System.Reflection
Imports System.Data.Common
Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports Oracle.DataAccess.Types
Imports Oracle.DataAccess.Client
Imports OpenSystems.Common.Data
Imports OpenSystems.EnterpriseLibrary
Imports Excel = Microsoft.Office.Interop.Excel
Imports System.Xml
Imports LUDYCOM.LECTESP.ENTITIES
Imports System.IO
Imports OpenSystems.Common.Util

Namespace DAL

    Public Class DALTBLEXCEL

        'Instancia la conexion

        '-----------------------------------------------------------------------------------------------------------
        ''' <summary>
        ''' Definicion de Procesos y funciones de BDD
        ''' </summary>
        Public ReadOnly Fn_ObtenerEstructuraTablas As String = "ldc_pkcm_lectesp.frfobtenerestructuratablas" 'Estructura de Tablas para Validacion de datos importados
        Public ReadOnly SP_ProDatosValidacion As String = "ldc_pkcm_lectesp.prodatosvalidacion"
        Public ReadOnly SP_proActualizaCritExcel As String = "ldc_pkcm_lectesp.proActualizaCritExcel"
        Public ReadOnly SP_proborrarimpprevia As String = "ldc_pkcm_lectesp.proborrarimpprevia"


        Public ReadOnly SP_obtSegCom_Activas As String = "cc_bscommercialsegm.getcommercialsegments" 'Obtengo ID's y descripcion de todas las segm. comercial activas
        Public ReadOnly SP_obtSegCom_byId As String = "cc_bscommercialsegm.getcommsegmentdata"
        Public ReadOnly SP_SegCom As String = "OS_SETCOMMERCIALSEGMENT"

        'Paquete BO >> Procesa XML con informacion de un segmento comercial >> Retorno CLOB con resultados >> 
        Public ReadOnly SP_CC_BOUI_ComSegmnt As String = "ldc_pkcc_scm.setcommercialsegment" '"cc_bouicommercialsegm.setcommercialsegment"
        Public ReadOnly Fn_ObtenerConsecutivos As String = "ldc_pkcc_scm.frfobtconsecutivos"
        Public ReadOnly SP_ProInsDatosImportacion As String = "ldc_pkcc_scm.proinsdatosimportacion"

        '-----------------------------------------------------------------------------------------------------------

        ''' <summary>
        ''' Valida la conexion que se esta utilizando. OPEN
        ''' </summary>
        ''' <returns>String con el nombre de la conexion ( LOCAL >> "ORACLE" | INTEGRADO OSF >> "OPEN" )</returns>
        ''' <remarks></remarks>
        Public Function CheckConnection() As String
            Dim var As String = "OPEN"
            If Not (OpenDataBase.DBConnectionState = ConnectionState.Closed Or OpenDataBase.DBConnectionState = ConnectionState.Broken) Then
                var = "OPEN"
            Else
                'Oracle = New DAL.Oracle
                'If Not DAL.Oracle. Is Nothing Then
                '    Oracle = DAL.Oracle
                'End If
                If Not (General.Oracle.Conexion.State = ConnectionState.Closed Or General.Oracle.Conexion.State = ConnectionState.Broken) Then
                    var = "ORACLE"
                Else
                    var = "SIN CONEXION"
                End If
            End If
            TipoConexion = var

            Return var
        End Function

        ' <summary>
        ' Consulta los datos segmentos .
        ' </summary>
        ' <returns> Cursor referenciado (DataTable) </returns>
        Public Function ObtenerListado(ByVal Proceso As String, ByRef onuerror As Integer, ByRef osberror As String) As DataTable
            Dim Listado = New Dictionary(Of Integer, String)
            Dim DST As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(Proceso)
                    Using cmd
                        OpenDataBase.db.AddReturnRefCursor(cmd)
                        OpenDataBase.db.AddOutParameter(cmd, "onuerror", DbType.Int64, 4000)
                        OpenDataBase.db.AddOutParameter(cmd, "osberror", DbType.String, 4000)
                        OpenDataBase.db.LoadDataSet(cmd, DST, "Tabla")
                    End Using
                Case "ORACLE"
                    DST.Tables.Add("Tabla")
                    Dim cmd As New OracleCommand(Proceso, General.Oracle.Conexion)
                    Using cmd
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.BindByName = True
                        cmd.Parameters.Add(New OracleParameter("onuerror", OracleDbType.Int64, 4000, vbNull, ParameterDirection.Output))
                        cmd.Parameters.Add(New OracleParameter("osberror", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                        cmd.Parameters.Add(New OracleParameter("RETURN_VALUE", OracleDbType.RefCursor, ParameterDirection.ReturnValue))
                        DST.Tables("Tabla").Load(cmd.ExecuteReader)
                    End Using
            End Select

            Return DST.Tables("Tabla")

        End Function

        Public Function ObtenerConsecutivos(ByVal Proceso As String, ByRef onuerror As Integer, ByRef osberror As String) As DataTable
            Dim Listado = New Dictionary(Of Integer, String)
            Dim DST As New DataSet
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(Fn_ObtenerConsecutivos)
                    Using cmd
                        OpenDataBase.db.AddReturnRefCursor(cmd)
                        OpenDataBase.db.AddOutParameter(cmd, "onuerror", DbType.Int64, 4000)
                        OpenDataBase.db.AddOutParameter(cmd, "osberror", DbType.String, 4000)
                        OpenDataBase.db.LoadDataSet(cmd, DST, "Tabla")
                    End Using
                Case "ORACLE"
                    DST.Tables.Add("Tabla")
                    Dim cmd As New OracleCommand(Fn_ObtenerConsecutivos, General.Oracle.Conexion)
                    Using cmd
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.BindByName = True
                        cmd.Parameters.Add(New OracleParameter("onuerror", OracleDbType.Int64, 4000, vbNull, ParameterDirection.Output))
                        cmd.Parameters.Add(New OracleParameter("osberror", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                        cmd.Parameters.Add(New OracleParameter("RETURN_VALUE", OracleDbType.RefCursor, ParameterDirection.ReturnValue))
                        DST.Tables("Tabla").Load(cmd.ExecuteReader)
                    End Using
            End Select

            Return DST.Tables("Tabla")

        End Function

        Public Sub ObtenerSegComActivas(ByRef orfcommercialsegments As DataTable, ByRef onuerrorcode As Int64, ByRef osberrormessage As String)
            Dim Resultado As Boolean = True
            Dim DST As New DataSet
            Dim Da As New OracleDataAdapter
            Select Case CheckConnection()
                Case "OPEN"
                    Dim cmd As DbCommand
                    cmd = OpenDataBase.db.GetStoredProcCommand(SP_obtSegCom_Activas)
                    Using cmd
                        'OJO: EL ORDEN DE LOS PARAMETROS ES IMPORTANTE
                        OpenDataBase.db.AddParameterRefCursor(cmd, "orfcommercialsegments")
                        OpenDataBase.db.AddOutParameter(cmd, "onuerrorcode", DbType.Int64, 4000)
                        OpenDataBase.db.AddOutParameter(cmd, "osberrormessage", DbType.String, 4000)
                        OpenDataBase.db.ExecuteNonQuery(cmd)

                        Try
                            Dim rfc As OracleRefCursor = cmd.Parameters("orfcommercialsegments").Value
                            onuerrorcode = cmd.Parameters("onuerrorcode").Value.ToString
                            osberrormessage = cmd.Parameters("osberrormessage").Value.ToString

                            If (osberrormessage = String.Empty Or osberrormessage = "null") And onuerrorcode = 0 Then
                                Da.Fill(orfcommercialsegments, rfc)
                            Else
                                Resultado = False
                            End If
                        Catch ex As Exception
                            Resultado = False
                            onuerrorcode = 1000
                            osberrormessage = ex.Message
                        End Try
                    End Using

                Case "ORACLE"
                    Dim cmd As New OracleCommand(SP_obtSegCom_Activas, General.Oracle.Conexion)
                    cmd.CommandType = CommandType.StoredProcedure
                    Using cmd
                        DST.Tables.Add("Tabla")
                        cmd.Parameters.Add(New OracleParameter("orfcommercialsegments", OracleDbType.RefCursor, vbNull, vbNull, ParameterDirection.Output))
                        cmd.Parameters.Add(New OracleParameter("onuerrorcode", OracleDbType.Int64, 15, vbNull, ParameterDirection.Output))
                        cmd.Parameters.Add(New OracleParameter("osberrormessage", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                        cmd.ExecuteNonQuery()
                        Dim rfc As OracleRefCursor = cmd.Parameters("orfcommercialsegments").Value

                        Try
                            onuerrorcode = cmd.Parameters("onuerrorcode").Value.ToString
                            osberrormessage = cmd.Parameters("osberrormessage").Value.ToString

                            If (osberrormessage = String.Empty Or osberrormessage = "null") And onuerrorcode = 0 Then
                                Da.Fill(orfcommercialsegments, rfc)
                            Else
                                Resultado = False
                            End If
                        Catch ex As Exception
                            Resultado = False
                            onuerrorcode = 1000
                            osberrormessage = ex.Message
                        End Try

                    End Using
            End Select

        End Sub

        ''' <summary>
        ''' Obtiene los datos de las tablas vinculadas (Fk) para validacion de datos local
        ''' </summary>
        ''' <param name="Dset"></param>
        ''' <param name="onuerrorcode"></param>
        ''' <param name="osberrormessage"></param>
        ''' <remarks></remarks>
        Public Sub ObtenerDatosValidacion(ByRef Dset As DataSet, ByRef onuerrorcode As Int64, ByRef osberrormessage As String)
            Dim Resultado As Boolean = True
            Dim DST As New DataSet
            Dim Da As New OracleDataAdapter
            Dim rfc As OracleRefCursor
            Dim cmd As New OracleCommand
            Try
                Using cmd
                    Select Case CheckConnection()
                        Case "OPEN"
                            cmd = CType(cmd, DbCommand)
                            cmd = OpenDataBase.db.GetStoredProcCommand(SP_ProDatosValidacion)

                            'OJO: EL ORDEN DE LOS PARAMETROS ES IMPORTANTE
                            OpenDataBase.db.AddParameterRefCursor(cmd, "orfestructuratablas")
                            OpenDataBase.db.AddParameterRefCursor(cmd, "orfdatosvalidacion")
                            OpenDataBase.db.AddOutParameter(cmd, "onuerrorcode", DbType.Int64, 15)
                            OpenDataBase.db.AddOutParameter(cmd, "osberrormessage", DbType.String, 32000)
                            OpenDataBase.db.ExecuteNonQuery(cmd)

                        Case "ORACLE"
                            'Modo desarrollo >> TRUE
                            cmd = New OracleCommand(SP_ProDatosValidacion, General.Oracle.Conexion)
                            cmd.CommandType = CommandType.StoredProcedure

                            cmd.Parameters.Add(New OracleParameter("orfestructuratablas", OracleDbType.RefCursor, vbNull, vbNull, ParameterDirection.Output))
                            cmd.Parameters.Add(New OracleParameter("orfdatosvalidacion", OracleDbType.RefCursor, vbNull, vbNull, ParameterDirection.Output))
                            cmd.Parameters.Add(New OracleParameter("onuerrorcode", OracleDbType.Decimal, 18, vbNull, ParameterDirection.Output))
                            cmd.Parameters.Add(New OracleParameter("osberrormessage", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                            cmd.ExecuteNonQuery()

                        Case Else
                            Resultado = False
                    End Select

                    With General.TblExcel
                        Da.SelectCommand = cmd
                        rfc = cmd.Parameters("orfestructuratablas").Value
                        Da.Fill(.DTValEstrucTablas, rfc)

                        rfc = cmd.Parameters("orfdatosvalidacion").Value
                        Da.Fill(.DTValDatosLectespCrit, rfc)

                    End With

                    If Not IsDBNull(cmd.Parameters("onuerrorcode").Value) And String.IsNullOrEmpty(cmd.Parameters("onuerrorcode").Value.ToString) Then
                        onuerrorcode = cmd.Parameters("onuerrorcode").Value
                    End If

                    osberrormessage = cmd.Parameters("osberrormessage").Value.ToString
                    If osberrormessage <> "" And osberrormessage <> "null" Then
                        Resultado = False
                    Else
                        osberrormessage = String.Empty
                    End If
                End Using

            Catch ex As Exception
                onuerrorcode = 1000
                osberrormessage += ex.Message
                Resultado = False
                Throw New ApplicationException("Error al obtener los datos de validacion de importacion.")
            End Try
        End Sub

        Function ImportarExcel()
            Dim boOK As Boolean
            Try
                Dim ExcelConnection As OleDb.OleDbConnection

                'Dim TipoExcel As String = Path.GetExtension(Plantilla)
                'MsgBox(Path.GetExtension(Plantilla).ToString)

                'Call CloseExcel()

                Dim MyCommand As New OleDb.OleDbDataAdapter
                Dim RangoExcel As String

                With Plantilla
                    'boOK = Me.ObtenerRangosPlantillaExcel(Plantilla)
                    'ExcelConnection.Dispose()
                    'If boOK = True Then
                    App.DataTableImportacion.Rows.Clear()

                    ExcelConnection = New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + General.TblExcel.Ruta + ";Extended Properties='Excel 8.0;HDR=NO;IMEX=1'")
                    ' ExcelConnection = New OleDbConnection("Provider=Microsoft.Jet.OLEDB.12.0;Data Source=" + General.TblExcel.Ruta + ";Extended Properties='Excel 12.0;HDR=NO;IMEX=1'")
                        'ExcelConnection.Open()
                        Plantilla.Nombre = "LECTESPCRIT"
                        RangoExcel = String.Format("select * from [{0}$A1:G{1}]", .Nombre, App.nuRegistrosImportacionExcel + 3)
                        'Cargar los datos seleccionados en el DataTable
                        MyCommand = New OleDb.OleDbDataAdapter(RangoExcel, ExcelConnection)
                        MyCommand.Fill(App.DataTableImportacion)
                        'Cerrar la conexion
                        ExcelConnection.Close()

                        With App.DataTableImportacion
                            'Se recorre desde la 3ra fila para no borrar los encabezados
                            For i As Integer = 2 To .Rows.Count - 1
                                If String.IsNullOrEmpty(.Rows(i)(4).ToString) Then
                                    'Borrar filas vacias
                                    .Rows(i).Delete()
                                End If
                            Next
                        End With

                        'Confirmo el borrado de las filas vacias
                        App.DataTableImportacion.AcceptChanges()
                        'Si hay registros se devuelvee True
                        If App.DataTableImportacion.Rows.Count > 0 Then
                            boOK = True
                        Else
                            boOK = False
                        End If
                        'Else
                        'Throw New ApplicationException()
                        'End If
                End With
                'Call CloseExcel()

            Catch ex As Exception
                boOK = False
                Throw New ApplicationException("Error al importar los datos de la Plantilla." + vbCrLf + "Validar en la Plantilla: " + vbCrLf + "Columnas, extension de archivo (xls), archivo abierto, etc..." + ex.Message
                                               )
            End Try

            Return boOK

        End Function



        ''' <summary>
        ''' Restablece tablas locales y los datos de la aplicacion
        ''' </summary>
        Sub ResetDataTableImportacion()
            App.DataTableImportacion.Clear()
        End Sub

        ''' <summary>
        ''' Renombra las columnas del Datatable segun los encabezados importados de la plantilla 
        ''' o las crea automaticamente con las propiedades de la Clase pasada por Parametro
        ''' Adicionalmente, borra las filas de encabezados
        ''' </summary>
        Sub FormatearDataTables()
            Call Plantilla.ColumnasDataTables(App.DataTableImportacion, TblExcel)
            App.DataTableImportacion.AcceptChanges()
        End Sub

        ' ''' <summary>
        ' ''' Elimina las filas que no estan asociadas a una Segmentacion Comercial
        ' ''' </summary>
        ' ''' <param name="DT">Datatable que sera depurado</param>
        ' ''' <remarks></remarks>
        'Sub FiltrarDatos(ByRef DT As DataTable)
        '    Try
        '        Dim DV As New DataView(DT)
        '        Dim Filter As String = ""

        '        For Each I As String In App.DiccionarioActID.Keys
        '            Filter += "," + I
        '        Next
        '        If Filter.Length > 0 Then
        '            Filter = Filter.Substring(1)
        '            Filter = String.Format("COMMERCIAL_SEGM_ID IN ({0})", Filter)
        '            DV.RowFilter = Filter
        '        Else
        '            DV.RowFilter = "COMMERCIAL_SEGM_ID IS NOT NULL"
        '        End If
        '        DT = DV.ToTable

        '    Catch ex As Exception
        '        Throw New Exception(ex.Message)
        '    End Try
        'End Sub

        Public Function GuardarAuditoriaSegmMasiva(ByVal sbplantilla As String, ByVal sbrutaplantilla As String, ByVal sbsegmentaciones As String, ByRef onuerror As Int64, ByRef osberror As String) As Boolean
            Dim Resultado As Boolean = True
            Try
                Select Case CheckConnection()
                    Case "OPEN"

                        Dim cmd As DbCommand = OpenDataBase.db.GetStoredProcCommand(SP_ProInsDatosImportacion)
                        Using cmd
                            'OJO: EL ORDEN DE LOS PARAMETROS ES IMPORTANTE
                            OpenDataBase.db.AddInParameter(cmd, "sbplantilla", DbType.String, sbplantilla)
                            OpenDataBase.db.AddInParameter(cmd, "sbrutaplantilla", DbType.String, sbrutaplantilla)
                            OpenDataBase.db.AddInParameter(cmd, "sbsegmentaciones", DbType.String, sbsegmentaciones)
                            OpenDataBase.db.AddOutParameter(cmd, "onuerror", DbType.Int64, 15)
                            OpenDataBase.db.AddOutParameter(cmd, "osberror", DbType.String, 4000)
                            OpenDataBase.db.ExecuteNonQuery(cmd)

                            onuerror = Val(OpenDataBase.db.GetParameterValue(cmd, "onuerror").ToString)
                            osberror = OpenDataBase.db.GetParameterValue(cmd, "osberror").ToString

                            If (osberror <> "" And osberror <> "null") Or onuerror > 0 Then
                                Resultado = False
                                OpenDataBase.Transaction.Rollback()
                            Else
                                OpenDataBase.Transaction.Commit()
                            End If
                        End Using

                    Case "ORACLE"
                        Dim Trans As OracleTransaction = General.Oracle.Conexion.BeginTransaction
                        Dim cmd As New OracleCommand(SP_ProInsDatosImportacion, General.Oracle.Conexion)
                        cmd.CommandType = CommandType.StoredProcedure
                        Using cmd
                            cmd.BindByName = True
                            cmd.Parameters.Add(New OracleParameter("sbplantilla", OracleDbType.Varchar2, 4000)).Value = sbplantilla
                            cmd.Parameters.Add(New OracleParameter("sbrutaplantilla", OracleDbType.Varchar2, 4000)).Value = sbrutaplantilla
                            cmd.Parameters.Add(New OracleParameter("sbsegmentaciones", OracleDbType.Varchar2, 4000)).Value = sbsegmentaciones
                            cmd.Parameters.Add(New OracleParameter("onuerror", OracleDbType.Int64, 15, vbNull, ParameterDirection.Output))
                            cmd.Parameters.Add(New OracleParameter("osberror", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                            cmd.ExecuteNonQuery()

                            Dim obj As Object
                            onuerror = Val(cmd.Parameters("onuerror").Value.ToString)
                            obj = cmd.Parameters("osberror").Value : osberror = obj.ToString

                            If (osberror <> "" And osberror <> "null") Or onuerror > 0 Then
                                Resultado = False
                                Trans.Rollback()
                            Else
                                Trans.Commit()
                            End If
                            Trans.Dispose()
                        End Using
                End Select

            Catch ex As Exception
                onuerror = 1000
                osberror += vbCrLf + ex.Message
                Resultado = False
            End Try
            Return Resultado
        End Function

        Sub BulkInsertExcel(ByRef osbError As String)

            Dim bulkCopy As OracleBulkCopy
            If General.ModoDesarrollo = False Then
                bulkCopy = New OracleBulkCopy(OpenDataBase.db.OpenConnection)
            Else
                If Not General.EstadoConexion = ConnectionState.Open Then
                    General.Oracle.Conexion.Open()
                End If

                bulkCopy = New OracleBulkCopy(General.Oracle.Conexion, OracleBulkCopyOptions.Default)
            End If

            'bulkCopy.ColumnMappings.Add("ID", "ID")
            'bulkCopy.ColumnMappings.Add("AÑO", "ANO")
            'bulkCopy.ColumnMappings.Add("MES", "MES")
            'bulkCopy.ColumnMappings.Add("CICLO", "CICLO")
            'bulkCopy.ColumnMappings.Add("PERIODO", "PERIODO")
            'bulkCopy.ColumnMappings.Add("PRODUCTO", "PRODUCTO")
            'bulkCopy.ColumnMappings.Add("LECTURA", "LECTURA")
            'bulkCopy.ColumnMappings.Add("PRESION", "PRESION")
            'bulkCopy.ColumnMappings.Add("FECHA", "FECHA")
            'bulkCopy.ColumnMappings.Add("MAQUINA", "MAQUINA")
            'bulkCopy.ColumnMappings.Add("PROCESADO", "PROCESADO")
            'bulkCopy.ColumnMappings.Add("OBSERVACION", "OBSERVACION")

            With App.DataTableImportacion
                Try
                    If Not .Columns.Contains("ID") Then
                        .Columns.Add("ID", GetType(Integer))
                    End If
                    If Not .Columns.Contains("ANO") Then
                        .Columns.Add("ANO", GetType(Integer))
                    End If
                    If Not .Columns.Contains("MES") Then
                        .Columns.Add("MES", GetType(Integer))
                    End If
                    If Not .Columns.Contains("CICLO") Then
                        .Columns.Add("CICLO", GetType(Integer))
                    End If
                    If Not .Columns.Contains("PERIODO") Then
                        .Columns.Add("PERIODO", GetType(Integer))
                    End If
                    If Not .Columns.Contains("PRODUCTO") Then
                        .Columns.Add("PRODUCTO", GetType(Integer))
                    End If
                    If Not .Columns.Contains("LECTURA") Then
                        .Columns.Add("LECTURA", GetType(Integer))
                    End If
                    If Not .Columns.Contains("PRESION") Then
                        .Columns.Add("PRESION", GetType(Double))
                    End If
                    If Not .Columns.Contains("FECHA") Then
                        .Columns.Add("FECHA", GetType(Date))
                    End If
                    If Not .Columns.Contains("MAQUINA") Then
                        .Columns.Add("MAQUINA", GetType(String))
                    End If
                    If Not .Columns.Contains("PROCESADO") Then
                        .Columns.Add("PROCESADO", GetType(String))
                    End If
                    If Not .Columns.Contains("OBSERVACION") Then
                        .Columns.Add("OBSERVACION", GetType(String))
                    End If

                    Dim contador As Integer = 0
                    For Each r As DataRow In .Rows
                        r("FECHA") = Date.Now
                        r("PROCESADO") = "-"
                        r("OBSERVACION") = "-"
                        r("MAQUINA") = My.Computer.Name.ToString
                        r("ID") = contador
                        'MsgBox(r("ID").ToString)
                        contador += 1
                        Application.DoEvents()
                    Next

                    App.DataTableImportacion.AcceptChanges()

                Catch ex As Exception
                    osbError = "Error al agregar Campos ID, Fecha y Procesado a la plantilla." + vbCrLf + ex.Message
                    Throw New ApplicationException(osbError)
                End Try
            End With

            Using bulkCopy
                bulkCopy.DestinationTableName = "LDC_CM_LECTESP_EXCEL"

                'Dim DtCopy As DataTable = App.DataTableImportacion.Copy

                'DtCopy.Columns.Remove("PROCESADO")
                'DtCopy.Columns.Remove("OBSERVACION")
                'copy.DefaultView()

                Try
                    bulkCopy.BatchSize = 5000
                    bulkCopy.BulkCopyTimeout = 20000
                    'bulkCopy.ColumnMappings.Clear()
                    'bulkCopy.ColumnMappings.Add("ID", "ID")
                    'bulkCopy.ColumnMappings.Add("AÑO", "ANO")
                    'bulkCopy.ColumnMappings.Add("MES", "MES")
                    'bulkCopy.ColumnMappings.Add("CICLO", "CICLO")
                    'bulkCopy.ColumnMappings.Add("PERIODO", "PERIODO")
                    'bulkCopy.ColumnMappings.Add("PRODUCTO", "PRODUCTO")
                    'bulkCopy.ColumnMappings.Add("LECTURA", "LECTURA")
                    'bulkCopy.ColumnMappings.Add("PRESION", "PRESION")
                    'bulkCopy.ColumnMappings.Add("FECHA", "FECHA")
                    'bulkCopy.ColumnMappings.Add("MAQUINA", "MAQUINA")
                    'bulkCopy.ColumnMappings.Add("PROCESADO", "PROCESADO")
                    'bulkCopy.ColumnMappings.Add("OBSERVACION", "OBSERVACION")

                    bulkCopy.WriteToServer(App.DataTableImportacion)
                    bulkCopy.Close()
                    bulkCopy.Dispose()
                    'Me.Oracle.Connection.Close()
                    'bulkCopy.Connection.Close()
                Catch ex As SqlException
                    If ex.ErrorCode = 604 Then
                        osbError = "No se pudieron insertar los datos (Timeout)" + vbCrLf + ex.Message
                    Else
                        osbError = "Error al insertar los datos de la plantilla. Validar los datos!" + vbCrLf + ex.Message
                    End If
                Catch ex As Exception
                    osbError = "Error al insertar los datos de la plantilla. Validar los datos!" + vbCrLf + ex.Message
                    'MsgBox(ex.ToString)
                    Throw
                End Try
            End Using

        End Sub


        Public Function BorrarImportacionPrevia(ByRef osberror) As Boolean
            Dim Resultado As Boolean = True
            Dim DT As New DataTable
            Dim Da As New OracleDataAdapter

            Try
                Select Case CheckConnection()

                    Case "OPEN"
                        Dim cmd As DbCommand
                        cmd = OpenDataBase.db.GetStoredProcCommand(SP_proborrarimpprevia)
                        Using cmd
                            'OJO: EL ORDEN DE LOS PARAMETROS ES IMPORTANTE
                            OpenDataBase.db.AddOutParameter(cmd, "osberror", DbType.String, 4000)
                            OpenDataBase.db.ExecuteNonQuery(cmd)
                            osberror = OpenDataBase.db.GetParameterValue(cmd, "osberror").ToString
                        End Using

                    Case "ORACLE"
                        Dim cmd As New OracleCommand(SP_proborrarimpprevia, General.Oracle.Conexion)
                        cmd.CommandType = CommandType.StoredProcedure
                        Using cmd
                            'cmd.BindByName = True
                            cmd.Parameters.Add(New OracleParameter("osberror", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                            cmd.ExecuteNonQuery()
                            osberror = cmd.Parameters("osberror").Value.ToString
                        End Using

                    Case Else
                        Resultado = False
                End Select

                If String.IsNullOrEmpty(osberror) Or osberror = "null" Then
                    osberror = String.Empty
                    Resultado = True
                Else
                    Resultado = False
                End If

            Catch ex As Exception
                osberror += ex.Message
                Resultado = False
                Throw New ApplicationException("Error al borrar los registros previos a la importacion de la Plantilla.")
            End Try

            Return Resultado

        End Function
        ''' <summary>
        ''' Procesa los registros importados desde la tabla de excel
        ''' </summary>
        ''' <param name="osberrormessage"></param>
        ''' <remarks></remarks>
        Public Function ProcesarImportacion(ByRef osberrormessage As String, Optional ByVal isbProcParciales As String = "N") As DataTable
            Dim Resultado As Boolean = True
            Dim DT As New DataTable("Importacion"), DS As New DataSet
            Dim Da As New OracleDataAdapter
            Dim rfc As OracleRefCursor
            Dim cmd As New OracleCommand
            Try
                Using cmd
                    Select Case CheckConnection()
                        Case "OPEN"
                            cmd = CType(cmd, DbCommand)
                            cmd = OpenDataBase.db.GetStoredProcCommand(SP_proActualizaCritExcel)

                            'OJO: EL ORDEN DE LOS PARAMETROS ES IMPORTANTE
                            OpenDataBase.db.AddParameterRefCursor(cmd, "ocrdatosprocesados")
                            OpenDataBase.db.AddInParameter(cmd, "isbProcParciales", DbType.String, isbProcParciales)
                            OpenDataBase.db.AddOutParameter(cmd, "osberror", DbType.String, 32000)
                            'OpenDataBase.db.AddOutParameter(cmd, "ocrdatosprocesados", DbType.Object, 20000)
                            OpenDataBase.db.ExecuteNonQuery(cmd)
                            osberrormessage = OpenDataBase.db.GetParameterValue(cmd, "osberror").ToString

                            'DS = OpenDataBase.db.ExecuteDataSet(cmd)
                            'Dim a As DbCommand = OpenDataBase.db.GetStoredProcCommand(SP_proActualizaCritExcel)
                            'a.Parameters(0).Direction.ToString()

                        Case "ORACLE"
                            'Modo desarrollo >> TRUE
                            cmd = New OracleCommand(SP_proActualizaCritExcel, General.Oracle.Conexion)
                            cmd.CommandType = CommandType.StoredProcedure
                            Da.SelectCommand = cmd
                            cmd.Parameters.Add(New OracleParameter("ocrdatosprocesados", OracleDbType.RefCursor, vbNull, vbNull, ParameterDirection.Output))
                            cmd.Parameters.Add(New OracleParameter("isbProcParciales", OracleDbType.Varchar2, 4000)).Value = isbProcParciales
                            cmd.Parameters.Add(New OracleParameter("osberror", OracleDbType.Varchar2, 4000, vbNull, ParameterDirection.Output))
                            cmd.ExecuteNonQuery()
                            osberrormessage = cmd.Parameters("osberror").Value.ToString
                        Case Else
                            Resultado = False
                    End Select

                    With General.TblExcel
                        App.DataTableImportacion.Clear()
                        App.DataTableImportacion.Columns.Clear()
                        rfc = cmd.Parameters("ocrdatosprocesados").Value
                        If rfc.FetchSize > 0 Then
                            Da.Fill(App.DataTableImportacion, rfc)
                            App.DataTableImportacion.AcceptChanges()
                        Else
                            osberrormessage = "No se proceso ningun registro. Favor validar informacion de la plantilla."
                        End If
                    End With

                    If String.IsNullOrEmpty(osberrormessage) Or osberrormessage = "null" Then
                        osberrormessage = String.Empty
                        Resultado = True
                    Else
                        Resultado = False
                    End If

                End Using

            Catch ex As Exception
                osberrormessage += ex.Message
                Resultado = False
                Throw New ApplicationException("Error al obtener los registros procesados en la importacion de la Plantilla.")
            End Try

            Return DT

        End Function

    End Class
End Namespace