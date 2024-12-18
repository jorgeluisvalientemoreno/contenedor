Imports System.IO
Imports System.Xml
Imports LUDYCOM.ENTITIES

Namespace BL

    Public Class BLCCSM

#Region "Declaraciones"

        Dim DAL As New DAL.DALCCSM
        Dim EstadoConexion As ConnectionState = DAL.EstadoConexion

        Public ExcelConnection As OleDb.OleDbConnection

#End Region

        Sub New()
            ExcelConnection = DAL.ExcelConnection
            Call CargarDatosValidacion()
            Call CargarConsecutivos()
        End Sub

        ''' <summary>
        ''' Realiza el proceso de inicializar la tablas internas, leer/extraer los datos de excel 
        ''' y Se renombran las columnas del DataTable con los encabezados de la plantilla
        ''' </summary>
        ''' <remarks></remarks>
        Sub ImportarExcel()
            Try
                Call DAL.ResetDataTables()
                Call DAL.ImportarExcel()
                Call DAL.FormatearDataTables()
                Call Me.AsociarConsecSegm()
                Call Me.FiltrarDatos()

            Catch ex As Exception
                RaiseError(ex.Message, 0, MsgBoxStyle.Critical)
            End Try
        End Sub

        Sub CargarDatosValidacion()
            Dim onuError As Int64, osbError As String = String.Empty
            Try
                DAL.ObtenerDatosValidacion(App.DtSetValidaciones, onuError, osbError)
                If onuError = 0 And String.IsNullOrEmpty(osbError) Then
                    If General.Validacion.DTValEstrucTablas.Rows.Count > 0 Then
                        General.BooValidacionHabilitada = True
                    End If
                Else
                    Throw New ApplicationException("Error al obtener la estructura de tablas para validar los datos importados." + vbCrLf + "Detalle: " + osbError)
                End If
            Catch ex As Exception
                RaiseError(ex.Message, 0, MsgBoxStyle.Critical)
            End Try
        End Sub

        Sub CargarConsecutivos()
            Dim onuError As Int64, osbError As String = String.Empty
            Try
                General.DTConsecutivos = DAL.ObtenerListado(DAL.Fn_ObtenerConsecutivos, onuError, osbError)
                If Not (onuError = 0 And String.IsNullOrEmpty(osbError)) Then
                    Throw New ApplicationException("Error al obtener los consecutivos de las tablas de segmentacion comercial." + vbCrLf + "Detalle: " + osbError)
                End If
            Catch ex As Exception
                RaiseError(ex.Message, 0, MsgBoxStyle.Critical)
            End Try
        End Sub

        Sub ConfirmarCambiosDataTable(ByVal Grid As DataGridView)
            Dim tabla As String
            If Not TryCast(Grid.DataSource, DataTable) Is Nothing Then
                tabla = CType(Grid.DataSource, DataTable).TableName

                For Each Tb As DataTable In App.DtSetPrincipal.Tables
                    If Tb.TableName = tabla Then
                        'If Not Tb.GetChanges Is Nothing Then
                        'If Tb.GetChanges.Rows.Count Then
                        Tb.AcceptChanges()
                        'End If
                        'Else
                        Exit For
                        'End If
                    End If
                Next
            End If
        End Sub

        ''' <summary>
        ''' Valida la estructura y datos de la Segmentacion
        ''' Si el resultado de alguna operacion tienen error, la validacion es fallida (boOK=false)
        ''' </summary>
        Function Validar() As Boolean
            Dim boOK As Boolean = True
            Try
                If General.BooValidacionHabilitada = True Then

                    'Validar segmentaciones duplicadas
                    Me.ValidarSegmentosDuplicados()

                    If Me.ValidarEstructura(App.DTSegmentacionComercial) = False Then
                        boOK = False
                    End If
                    If Me.ValidarEstructura(App.DTCaractDemograficas) = False Then
                        boOK = False
                    End If
                    If Me.ValidarEstructura(App.DTCaractGeoPoliticas) = False Then
                        boOK = False
                    End If
                    If Me.ValidarEstructura(App.DTCaractComerciales) = False Then
                        boOK = False
                    End If
                    If Me.ValidarEstructura(App.DTCaractFinancieras) = False Then
                        boOK = False
                    End If
                    If Me.ValidarEstructura(App.DTPromociones) = False Then
                        boOK = False
                    End If
                    If Me.ValidarEstructura(App.DTPlanComercial) = False Then
                        boOK = False
                    End If
                    If Me.ValidarEstructura(App.DTPlanFinanciacion) = False Then
                        boOK = False
                    End If


                    'Empieza la validacion de llaves foraneas
                    If Me.ValidarDatos(App.DTSegmentacionComercial) = False Then
                        boOK = False
                    End If
                    If Me.ValidarDatos(App.DTCaractDemograficas) = False Then
                        boOK = False
                    End If
                    If Me.ValidarDatos(App.DTCaractGeoPoliticas) = False Then
                        boOK = False
                    End If
                    If Me.ValidarDatos(App.DTCaractComerciales) = False Then
                        boOK = False
                    End If
                    If Me.ValidarDatos(App.DTCaractFinancieras) = False Then
                        boOK = False
                    End If
                    If Me.ValidarDatos(App.DTPromociones) = False Then
                        boOK = False
                    End If
                    If Me.ValidarDatos(App.DTPlanComercial) = False Then
                        boOK = False
                    End If
                    If Me.ValidarDatos(App.DTPlanFinanciacion) = False Then
                        boOK = False
                    End If

                    If boOK = True Then
                        General.BoProcesarHabilitado = True
                    End If
                Else
                    Throw New ApplicationException("Los datos de las tablas de segmentacion no estan disponibles." + vbCrLf + "Verifique la conexion o importe nuevamente la plantilla.")
                End If

            Catch ex As Exception
                boOK = False
                RaiseError(ex.Message, 0, MsgBoxStyle.Critical)
            End Try

            Return boOK

        End Function

        ''' <summary>
        ''' Valida la estructura de los datos extraidos de la plantilla Excel
        ''' </summary>
        ''' <param name="DT"></param>
        ''' <remarks></remarks>
        Function ValidarEstructura(ByRef DT As DataTable) As Boolean
            Dim BoOK As Boolean = True
            DT.AcceptChanges()
            Try
                If General.BooValidacionHabilitada = True Then

                    Dim FiltroTabla As String

                    If DT.TableName.Contains("__") Then
                        'Se valida si la tabla procesada pertenece a las Caracteristicas de Segmentacion 
                        'Se ajusta el nombre de la tabla EJ: CC_COM_SEG_FEA_VAL__DEM >> CC_COM_SEG_FEA_VAL para poder validar contra el DataTable App.DTValidaciones
                        FiltroTabla = "TABLE_NAME='" + App.NombreTablaCaracteristicas + "'"
                    Else
                        FiltroTabla = "TABLE_NAME='" + DT.TableName + "'"
                    End If

                    With DT
                        If App.FlagColErroresOnTop = False Then
                            If .Columns.Contains("ERRORES") Then
                                'Si no hay errores (BoOK=True) y existe la columna, se borran las notificacion en la Fila
                                '.Columns("ERRORES").
                                .Columns.Remove("ERRORES")
                                DT.AcceptChanges()
                                'rowDT.RowError = String.Empty
                            End If
                        End If
                    End With

                    'Se validan con los datos devueltos de las tablas ALL_TAB_COLUMNS COL y ALL_COL_COMMENTS
                    Dim ColTipoDato As String = "DATA_TYPE"
                    Dim ColTamañoDato As String = "DATA_PRECISION"

                    'Filtro la info de la tabla que se validará
                    Dim DV As New DataView(General.Validacion.DTValEstrucTablas)

                    For Each rowDT As DataRow In DT.Rows

                        Dim ContarCeldasVacias As New Integer
                        Dim ContarCeldasConDatos As New Integer
                        Dim ContarCeldasRequeridas As New Integer

                        Dim sError As String = String.Empty


                        If rowDT.HasErrors = True Then
                            'Borro los errores previos para colocar los nuevos
                            rowDT.ClearErrors()
                        End If

                        For Each colDT As DataColumn In DT.Columns

                            'Filtro el DT para obtener los datos de la tabla que se validara
                            DV.RowFilter = FiltroTabla + " AND COLUMN_NAME='" + colDT.ColumnName + "'"

                            If DT.Rows.Count > 0 Then

                                If DV.Count > 0 Then
                                    'Indica que la tabla y columna estan en la BDD y se pueden validar

                                    ' -- Validar NULL --
                                    Dim nuEsNULL As String = DV(0).Row("NULLABLE")
                                    Select Case nuEsNULL
                                        Case "Y"
                                            If Not DT.Columns.Item(colDT.ColumnName).AllowDBNull Then
                                                DT.Columns.Item(colDT.ColumnName).AllowDBNull = True
                                            End If

                                            '    If Not IsDBNull(rowDT.Item(colDT)) Then
                                            '        BoOK = False
                                            '    End If
                                        Case "N"
                                            If IsDBNull(rowDT.Item(colDT)) Then
                                                'Si es NULL>>Error
                                                BoOK = False
                                                sError += colDT.ColumnName + ": El campo es requerido | "
                                                rowDT.SetColumnError(colDT, "El campo es requerido")
                                                Continue For
                                            End If
                                    End Select

                                    ' -- Validar Tipo de Dato -- 
                                    If rowDT.Item(colDT).ToString.Length > 0 Then
                                        ContarCeldasConDatos += 1
                                        Dim sTipoDato As String = DV(0).Row("DATA_TYPE")
                                        Select Case sTipoDato
                                            Case "NUMBER"
                                                If Not IsNumeric(rowDT.Item(colDT)) Then
                                                    'Si no es numerico>>Error
                                                    BoOK = False
                                                    rowDT.SetColumnError(colDT, "Tipo de dato esperado " + sTipoDato)
                                                    sError += colDT.ColumnName + ": Tipo de dato esperado " + sTipoDato + " | "
                                                End If
                                            Case "VARCHAR2"
                                                If Not TypeOf (rowDT.Item(colDT)) Is String Then
                                                    'Si no es Texto>>Error
                                                    BoOK = False
                                                    rowDT.SetColumnError(colDT, "Tipo de dato esperado " + sTipoDato)
                                                    sError += colDT.ColumnName + ": Tipo de dato esperado " + sTipoDato + " | "
                                                End If
                                        End Select

                                        ' -- Validar Tamaño del Dato -- 
                                        Dim nuTamañoDato As Integer = DV(0).Row("DATA_PRECISION")
                                        If rowDT.Item(colDT).ToString.Length > nuTamañoDato Then
                                            BoOK = False
                                            rowDT.SetColumnError(colDT, "Tamaño maximo de campo (" + nuTamañoDato.ToString + ")")
                                            sError += colDT.ColumnName + ": Tamaño maximo de campo (" + nuTamañoDato.ToString + ") | "
                                        End If

                                    Else
                                        'Si la celda no tiene datos se cuenta para validar que el usuario no deje todas las celdas vacias
                                        ContarCeldasVacias += 1
                                    End If
                                Else
                                    'Valida Columnas Locales (no estan en el DTValidaciones)
                                    If Not colDT.ColumnName = "ERRORES" And Not colDT.ColumnName = "ROW_ID" Then
                                        sError += "Columna " + colDT.ColumnName + " no existe en la BDD. | "
                                    End If
                                End If
                            End If

                        Next

                        'Validar que el usuario no deje todas las celdas vacias
                        DV.RowFilter = FiltroTabla + " AND NULLABLE='N'"
                        ContarCeldasRequeridas = DV.Count
                        Dim NumColumnas As Integer = DT.Columns.Count - 1 '[Row_ID]
                        If BoOK = False Then
                            NumColumnas -= 1 '[Errores(opcional)]
                        End If
                        ''If ContarCeldasConDatos < ContarCeldasRequeridas Then
                        ''    BoOK = False
                        ''    sError += " Datos Insuficientes |"
                        ''End If

                        If BoOK = False Then
                            'Cuando hay errores, se agrega la columna "ERRORES"
                            If Not DT.Columns.Contains("ERRORES") Then
                                DT.Columns.Add("ERRORES", System.Type.GetType("System.String"))
                            End If
                            'Se establece la notificacion grafica y de texto en la Fila
                            rowDT("ERRORES") = sError
                            rowDT.RowError = sError
                            rowDT.SetColumnError("ERRORES", sError)
                        Else
                            If DT.Columns.Contains("ERRORES") Then
                                'Si no hay errores (BoOK=True) y existe la columna, se borran las notificacion en la Fila
                                rowDT("ERRORES") = String.Empty
                                rowDT.ClearErrors()
                                'rowDT.RowError = String.Empty
                            End If
                        End If
                    Next ' -- Siguiente Fila
                    DT.AcceptChanges()
                Else
                    BoOK = False
                End If
            Catch ex As Exception
                BoOK = False
                'Throw New Exception(ex.Message)
                ' Get stack trace for the exception with source file information
                Dim st = New StackTrace(ex, True)
                ' Get the top stack frame
                Dim frame = st.GetFrame(0)
                ' Get the line number from the stack frame
                Dim line = frame.GetFileLineNumber()
                RaiseError("Error de validación de Estructura de Campos/Celdas. Linea " + line.ToString + vbCrLf + ex.Message, 0, MsgBoxStyle.Critical)
            End Try

            Return BoOK

        End Function

        ''' <summary>
        ''' Valida la integridad de datos (FK) contra las tablas maestras y setea los errores en las celdas con inconsistencias
        ''' Realiza acciones diferentes de acuerdo a la tabla que se este validando
        ''' </summary>
        ''' <param name="DT">La tabla que se esta validando</param>
        ''' <returns>True/False</returns>
        ''' <remarks>Cuando por lo menos se haya encontrado un error el proceso devolverara false</remarks>
        Function ValidarDatos(ByRef DT As DataTable) As Boolean
            Dim BoOK As Boolean = True, BoRes As Boolean = True
            Try
                DT.AcceptChanges()
                Select Case DT.TableName

                    Case App.DTSegmentacionComercial.TableName

                        For Each Row As DataRow In DT.Rows

                            'If Row.HasErrors Then
                            '    Row.ClearErrors()
                            'End If

                            Dim Campo As String = "COMMERCIAL_SEGM_ID"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValSegmentacionDuplicada(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(DT, Row, BoRes, "La descripcion de la Segmentacion Comercial ya existe en la BDD.", Campo)
                            End If
                        Next

                    Case App.DTCaractDemograficas.TableName
                        For Each Row As DataRow In DT.Rows

                            If Row.HasErrors Then
                                Row.ClearErrors()
                            End If

                            Dim Campo As String = "COMMERCIAL_SEGM_ID"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValSegmentacionExistente(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(DT, Row, BoRes, "No se encontro la Segmentacion Comercial referenciada.", Campo)
                            End If

                            Campo = "SUBS_TYPE_ID"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValFkTipoCliente(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(DT, Row, BoRes, "Tipo de Cliente No Valido.", Campo)
                            End If

                            Campo = "SUBS_SCORING"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValFkClasificacion(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(App.DTCaractDemograficas, Row, BoRes, "Clasificacion de Cliente No Valida.", Campo)
                            End If

                            Campo = "SUBS_VINCULATED"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.EdadAntiguedad(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(App.DTCaractDemograficas, Row, BoRes, "Antiguedad debe estar entre 1 y 99.", Campo)
                            End If

                            Campo = "SUBS_CIVIL_STATE"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ChkEstadoCivil(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(App.DTCaractDemograficas, Row, BoRes, "Estado Civil No Valido.", Campo)
                            End If

                            Campo = "SUBS_SCHL_DEGREE_ID"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValFkEscolaridad(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(App.DTCaractDemograficas, Row, BoRes, "Grado de Escolaridad No Valido.", Campo)
                            End If

                            Campo = "SUBS_WAGE_LEVEL_ID"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValFkNivelIngresos(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(App.DTCaractDemograficas, Row, BoRes, "Nivel de Ingresos No Valido.", Campo)
                            End If
                        Next

                    Case App.DTCaractGeoPoliticas.TableName
                        For Each Row As DataRow In DT.Rows

                            If Row.HasErrors Then
                                Row.ClearErrors()
                            End If

                            Dim Campo As String = "COMMERCIAL_SEGM_ID"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValSegmentacionExistente(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(DT, Row, BoRes, "No se encontro la Segmentacion Comercial referenciada.", Campo)
                            End If

                            'No se valida la ubicacion geografica porque son muchos registros que debe cargar la app
                            'y se ralentizaria
                        Next

                    Case App.DTCaractComerciales.TableName
                        For Each Row As DataRow In DT.Rows
                            Try
                                If Row.HasErrors Then
                                    Row.ClearErrors()
                                End If
                                Row.AcceptChanges()

                                Dim Campo As String = "COMMERCIAL_SEGM_ID"
                                If Not IsDBNull(Row(Campo)) Then
                                    BoRes = General.Validacion.ValSegmentacionExistente(Row(Campo))
                                    If BoRes = False Then
                                        BoOK = False
                                    End If
                                    Call SetRowError(DT, Row, BoRes, "No se encontro la Segmentacion Comercial referenciada.", Campo)
                                End If

                                Campo = "PROD_CUTTING_STATE"
                                If Not IsDBNull(Row(Campo)) Then
                                    BoRes = General.Validacion.ValFkEstadoCorte(Row(Campo))
                                    If BoRes = False Then
                                        BoOK = False
                                    End If
                                    Call SetRowError(DT, Row, BoRes, "Estado de Corte No Valido.", Campo)
                                End If

                                Campo = "PROD_COMMERCIAL_PLAN"
                                If Not IsDBNull(Row(Campo)) Then
                                    BoRes = General.Validacion.ValFkPlanComercial(Row(Campo))
                                    If BoRes = False Then
                                        BoOK = False
                                    End If
                                    Call SetRowError(DT, Row, BoRes, "Plan Comercial No Valido o no vigente.", Campo)
                                End If

                            Catch ex As Exception
                                MsgBox("Error: " + ex.Message.ToString)
                            End Try
                        Next

                    Case App.DTCaractFinancieras.TableName
                        For Each Row As DataRow In DT.Rows

                            If Row.HasErrors Then
                                Row.ClearErrors()
                            End If

                            Dim Campo As String = "COMMERCIAL_SEGM_ID"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValSegmentacionExistente(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(DT, Row, BoRes, "No se encontro la Segmentacion Comercial referenciada.", Campo)
                            End If

                            Campo = "FINAN_FINAN_STATE"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValFkEstadoFinan(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(DT, Row, BoRes, "Estado Financiero No Valido.", Campo)
                            End If
                            Campo = "FINAN_LAST_FIN_PLAN"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValFkPlanFinanciacion(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(DT, Row, BoRes, "Diferido No Valido.", Campo)
                            End If
                        Next

                    Case App.DTPromociones.TableName
                        For Each Row As DataRow In DT.Rows

                            Dim Campo As String = "COMMERCIAL_SEGM_ID"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValSegmentacionExistente(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(DT, Row, BoRes, "No se encontro la Segmentacion Comercial referenciada.", Campo)
                            End If

                            Campo = "PROMOTION_ID"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValFkPromociones(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(DT, Row, BoRes, "Promocion No valida.", Campo)
                            End If

                            Campo = "OFFER_CLASS"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValFkOfferClass(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(DT, Row, BoRes, "Clase de Oferta No valida.", Campo)
                            End If
                        Next

                    Case App.DTPlanComercial.TableName
                        For Each Row As DataRow In DT.Rows

                            Dim Campo As String = "COMMERCIAL_SEGM_ID"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValSegmentacionExistente(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(DT, Row, BoRes, "No se encontro la Segmentacion Comercial referenciada.", Campo)
                            End If

                            Campo = "COMMERCIAL_PLAN_ID"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValFkPlanComercial(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(DT, Row, BoRes, "Plan Comercial No Valido o no vigente.", Campo)
                            End If

                            Campo = "OFFER_CLASS"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValFkOfferClass(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(DT, Row, BoRes, "Clase de Oferta No valida.", Campo)
                            End If
                        Next

                    Case App.DTPlanFinanciacion.TableName

                        For Each Row As DataRow In DT.Rows

                            Dim Campo As String = "COMMERCIAL_SEGM_ID"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValSegmentacionExistente(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(DT, Row, BoRes, "No se encontro la Segmentacion Comercial referenciada.", Campo)
                            End If

                            Campo = "FINANCING_PLAN_ID"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValFkPlanFinanciacion(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(DT, Row, BoRes, "Diferido No Valido.", Campo)
                            End If
                            Campo = "OFFER_CLASS"
                            If Not IsDBNull(Row(Campo)) Then
                                BoRes = General.Validacion.ValFkOfferClass(Row(Campo))
                                If BoRes = False Then
                                    BoOK = False
                                End If
                                Call SetRowError(DT, Row, BoRes, "Clase de Oferta No valida.", Campo)
                            End If
                        Next

                End Select

            Catch ex As Exception
                BoOK = False
                ' Get stack trace for the exception with source file information
                Dim st = New StackTrace(ex, True)
                ' Get the top stack frame
                Dim frame = st.GetFrame(0)
                ' Get the line number from the stack frame
                Dim line = frame.GetFileLineNumber()
                RaiseError("Error de validación de datos. Linea " + line.ToString + vbCrLf + ex.Message, 0, MsgBoxStyle.Critical)
            End Try

            Return BoOK

        End Function



        ''' <summary>
        ''' Elimina de las tablas internas, las filas que no estan asociadas a una Segmentacion Comercial
        ''' </summary>
        ''' <remarks></remarks>
        Sub FiltrarDatos()
            Try
                If General.FiltrarDatosPlantilla = True Then
                    Call DAL.FiltrarDatos(App.DTSegmentacionComercial)
                    Call DAL.FiltrarDatos(App.DTCaractDemograficas)
                    Call DAL.FiltrarDatos(App.DTCaractGeoPoliticas)
                    Call DAL.FiltrarDatos(App.DTCaractComerciales)
                    Call DAL.FiltrarDatos(App.DTCaractFinancieras)
                    Call DAL.FiltrarDatos(App.DTPromociones)
                    Call DAL.FiltrarDatos(App.DTPlanComercial)
                    Call DAL.FiltrarDatos(App.DTPlanFinanciacion)
                End If
            Catch ex As Exception
                RaiseError(ex.Message, 0, MsgBoxStyle.Critical)
            End Try
        End Sub

        ''' <summary>
        ''' Marcar la fila de un color cuando la hoja de excel tenga datos invalidos en una fila
        ''' </summary>
        ''' <remarks></remarks>
        Sub MarcarFila()

        End Sub

        Public Function PrettyXML(ByVal XMLString As String) As String
            Dim sw As New StringWriter()
            Dim xw As New XmlTextWriter(sw)
            xw.Formatting = Formatting.Indented
            xw.Indentation = 4
            Dim doc As New XmlDocument
            doc.CreateXmlDeclaration("1.0", "UTF-8", "yes")
            doc.LoadXml(XMLString)
            doc.Save(xw)
            Dim Xml As String = sw.ToString()
            'Establezco el Doctype del XML
            'Xml = "<?xml version=""1.0"" standalone=""yes""?>" + vbCrLf + Xml
            'Xml = General.PrettyXML(Xml)
            Xml = Xml.Replace("<?xml version=""1.0"" encoding=""utf-16""?>", "<?xml version=""1.0"" standalone=""yes""?>")

            Return Xml
        End Function

        Function Procesar() As String
            Dim sbIDSegmentacion As String = String.Empty
            Dim sbLog As String = String.Empty
            Dim Resultado As Boolean

            Try
                'Genero los XML segun los datos validados de los DataTables
                Call DAL.GenerarXML(sbLog)

                If App.XML.Count > 0 Then

                    App.sbSegmentaciones = String.Empty

                    For Each XMLSegment As XmlDocument In App.XML

                        'Declaracion Variables
                        Dim osbClobResults As String = String.Empty, iblValidate As Integer = 0
                        Dim nuError As Integer = 0, sbError As String = String.Empty
                        Dim XML As String = XMLSegment.OuterXml

                        'Se obtiene el ID de la Segmentacion del usuario y se borra el ID para indicar "Adicion"
                        sbIDSegmentacion = XMLSegment.SelectSingleNode("/Segmentation/Id").InnerText
                        XMLSegment.SelectSingleNode("/Segmentation/Id").InnerText = String.Empty

                        XML = Me.PrettyXML(XMLSegment.OuterXml)

                        'Se envia el XML a procesar
                        Resultado = DAL.Procesar(XML, osbClobResults, iblValidate, nuError, sbError)

                        'Se valida el resultado de la operacion
                        If (sbError <> "" And sbError <> "null") Or nuError > 0 Then
                            sbLog += vbCrLf + " ************* | *************" + sbError + vbCrLf
                            Resultado = False
                        Else
                            'Valida si el CLOB devuelto contiene errores
                            If osbClobResults.Contains("<Segmentation>") Then
                                Me.PrettyXML(osbClobResults)
                                Resultado = True
                            Else
                                Resultado = False
                                sbLog = " ************* | *************" + "Error: La BDD no devolvió el CLOB con los nuevos ID de la segmentacion " + sbIDSegmentacion + vbCrLf + sbLog
                            End If
                        End If


                        If Resultado = True Then
                            Dim XmlDoc As New XmlDocument : XmlDoc.InnerXml = osbClobResults
                            Dim sbNuevoID As String = XmlDoc.SelectSingleNode("/Segmentation/Id").InnerText

                            With App.DiccionarioActID
                                'Si ID de Segmentacion del Clob devuelto por parametro tiene datos
                                If Not String.IsNullOrEmpty(sbNuevoID) Then
                                    Dim cadena As String = String.Empty

                                    'Se compara para validar que se tengan que reemplazar el consecutivo
                                    If sbNuevoID <> sbIDSegmentacion Then

                                        For Each Idx As String In .Keys
                                            If .Item(Idx) = sbIDSegmentacion Or .Item(Idx) = sbNuevoID Then
                                                'Concateno los Keys del diccionario para su posterior borrado
                                                cadena += Idx + "|"
                                            End If
                                        Next

                                        For Each Idx As String In cadena.Split("|")
                                            .Remove(Idx)
                                        Next

                                        If Not .ContainsValue(sbNuevoID) Then
                                            'Inserto datos en el diccionario para actualizar posteriormente los ID de las Segmentaciones
                                            .Add(sbIDSegmentacion, sbNuevoID)
                                        End If
                                    End If
                                    'Concateno las segmentaciones que fueron insertadas en esta operacion masiva
                                    App.sbSegmentaciones += sbNuevoID + "|"
                                End If
                            End With
                        End If
                    Next

                    Call Me.GuardarAuditoriaSegmMasiva(sbLog)

                Else
                    Throw New ApplicationException("No hay XML generados para procesar")
                End If
            Catch ex As Exception
                sbLog += vbCrLf + ex.Message.ToString + vbCrLf
            End Try

            Return sbLog

        End Function

        Private Sub GuardarAuditoriaSegmMasiva(ByRef osberror As String)

            'Inserto el registro de Auditoria en la tabla LDC_CC_SCMA
            If App.sbSegmentaciones.Contains("|") Then
                Dim nuError As Integer = 0, sbError As String = String.Empty
                If Not String.IsNullOrEmpty(General.RutaPlantilla) Then
                    Call DAL.GuardarAuditoriaSegmMasiva(Path.GetFileName(General.RutaPlantilla), Path.GetFullPath(General.RutaPlantilla), "|" + App.sbSegmentaciones, nuError, sbError)
                    'Se valida el resultado de la operacion
                    If (sbError <> "" And sbError <> "null") Or nuError > 0 Then
                        osberror += vbCrLf + " ************* | *************" + nuError.ToString + "-" + sbError + vbCrLf
                    End If
                Else
                    Throw New ApplicationException("Error: El nombre de la plantilla no se cargo correctamente. Intentelo de nuevo.")
                End If
            End If

        End Sub

        Private Function ValidarSegmentosDuplicados() As Boolean
            Dim OnuErroCode As Integer, osbMensaje As String = String.Empty, boResult As Boolean = False

            'Obtengo las segmentaciones activas de la BDD
            Dim miDT As DataTable = Me.ObtenerSegmentacionComercial(OnuErroCode, osbMensaje)

            'Reinicio la lista de Segmentaciones unicas
            App.LstSegmentosDuplicados.Clear()
            App.DTSegmentacionComercial.AcceptChanges()

            For Each Row As DataRow In App.DTSegmentacionComercial.Rows
                Dim Rows() As DataRow = miDT.Select(String.Format("name='{0}'", Row("name")))

                If Rows.Length > 0 Then 'ya existe en la BBD
                    If Not App.LstSegmentosDuplicados.Contains(Row("COMMERCIAL_SEGM_ID")) Then
                        App.LstSegmentosDuplicados.Add(Row("COMMERCIAL_SEGM_ID"))
                        boResult = True
                    End If
                End If
            Next

            Return boResult

        End Function

        Public Sub AsociarConsecSegm()
            Dim nuConsecSegmID As String = String.Empty
            Try
                '*********************** Prueba Local ***********************
                If ModoDesarrollo = True And Not EstadoConexion = ConnectionState.Open Then
                    Try
                        General.DTConsecutivos = New DataTable
                        General.DTConsecutivos.Columns.Add("COMMERCIAL_SEGM_ID")
                        General.DTConsecutivos.Rows.Clear()
                        General.DTConsecutivos.Rows.Add()
                        General.DTConsecutivos.Rows(0)("COMMERCIAL_SEGM_ID") = 2000
                    Catch ex As Exception

                    End Try
                End If
                '*********************** Fin Prueba Local ***********************
                With App.DTSegmentacionComercial
                    nuConsecSegmID = General.DTConsecutivos.Rows(0)("COMMERCIAL_SEGM_ID")

                    'Cuando no se hayan insertado las segmentaciones
                    'If App.sbSegmentaciones.Length = 0 Then
                    App.LstSegmentosUnicos.Clear()
                    App.LstSegmentosDuplicados.Clear()

                    For Each Row As DataRow In .Rows
                        If Not App.LstSegmentosUnicos.Contains(Row("COMMERCIAL_SEGM_ID")) Then
                            App.LstSegmentosUnicos.Add(Row("COMMERCIAL_SEGM_ID"))
                        Else
                            If Not App.LstSegmentosDuplicados.Contains(Row("COMMERCIAL_SEGM_ID")) Then
                                App.LstSegmentosDuplicados.Add(Row("COMMERCIAL_SEGM_ID"))
                            End If
                        End If
                    Next

                    App.DiccionarioActID = New Dictionary(Of String, String)

                    For Each i As String In App.LstSegmentosUnicos
                        nuConsecSegmID += 1
                        App.DiccionarioActID.Add(i, nuConsecSegmID)
                    Next

                    App.LstSegmentosUnicos.Clear()
                    For Each i As String In App.DiccionarioActID.Values
                        'BoActIDSegAlValidar
                        App.LstSegmentosUnicos.Add(i)
                    Next
                    'Else
                    '    'Despues de insertar las Segmentaciones

                    'End If
                End With


            Catch ex As Exception
                RaiseError("AsociarConsecSegm | Error al actualizar los consecutivos de segmentacion importados." + vbCrLf + ex.Message, 0, MsgBoxStyle.Exclamation)
            End Try

        End Sub

        Public Sub ActualizarIDSegmentacion(ByRef DT As DataTable)
            If DT.Columns.Contains("COMMERCIAL_SEGM_ID") Then
                For i As Integer = 0 To DT.Rows.Count - 1
                    With DT.Rows(i)
                        If Not IsDBNull(.Item("COMMERCIAL_SEGM_ID")) Then
                            Dim ID As String = .Item("COMMERCIAL_SEGM_ID")
                            'MsgBox("ID" + .Item("COMMERCIAL_SEGM_ID") + " | DICT " + App.DiccionarioActID.Item(ID))
                            If App.DiccionarioActID.ContainsKey(ID) Then
                                .Item("COMMERCIAL_SEGM_ID") = App.DiccionarioActID.Item(ID).ToString
                            End If
                            'MsgBox("ID" + .Item("COMMERCIAL_SEGM_ID") + " | DICT " + App.DiccionarioActID.Item(ID))
                        End If
                    End With
                Next
            End If
        End Sub

        Function ObtenerSegmentacionComercial(ByRef onuerrorcode As Int64, ByRef osberrormessage As String) As DataTable
            Dim DT As New DataTable
            Try
                ObtenerSegmentacionComercial = New DataTable
                Call DAL.ObtenerSegComActivas(DT, onuerrorcode, osberrormessage)
                Select Case onuerrorcode
                    Case 0
                        Return DT
                    Case Else
                        Throw New ApplicationException("Error al cargar las segmentaciones comerciales activas. | " + osberrormessage)
                End Select
            Catch ex As Exception
                RaiseError(ex.Message, 0, MsgBoxStyle.Critical)
            End Try

            Return DT

        End Function

    End Class

End Namespace