Public Class BLTBLEXCEL

    Public DalTbExcel As New DAL.DALTBLEXCEL

    Sub New()
        With TblExcel.DtSetValidaciones.Tables
            .Clear()
            .Add(TblExcel.DTValEstrucTablas)
            .Add(TblExcel.DTImportacion)
            .Add(TblExcel.DTValPeriodoFacturacion)
            .Add(TblExcel.DTValCicloFacturacion)
            .Add(TblExcel.DTValProductos)
            .Add(TblExcel.DTValDatosLectespCrit)
        End With
    End Sub

    Function FnValFkPerifact(ByVal ID As Integer, ByVal AÑO As Integer, ByVal MES As Integer) As Boolean
        Dim BoOK As Boolean = False
        Dim Rows As DataRow() = TblExcel.DTValPeriodoFacturacion.Select("ID=" + ID.ToString, "")
        For Each Row As DataRow In Rows
            If AÑO = Row("PEFAANO") And MES = Row("PEFAMES") Then
                BoOK = True
            End If
        Next
        Return BoOK
    End Function

    Function FnValFkCicloFacturacion(ByVal ID As Integer) As Boolean
        Dim BoOK As Boolean = False
        For Each Row As DataRow In TblExcel.DTValCicloFacturacion.Rows
            If ID = Row("ID") Then
                BoOK = True
            End If
        Next
        Return BoOK
    End Function

    Function FnValFkProductos(ByVal ID As Integer) As Boolean
        Dim BoOK As Boolean = False
        For Each Row As DataRow In TblExcel.DTValProductos.Rows
            If ID = Row("ID") Then
                BoOK = True
            End If
        Next
        Return BoOK
    End Function

    'Function ValFkOfferClass(ByVal ID As Integer) As Boolean
    '    Dim BoOK As Boolean = False
    '    If ID >= 1 And ID <= 3 Then
    '        BoOK = True
    '    End If
    '    Return BoOK
    'End Function

    'Listados
    Dim LstTblExcel As List(Of ENTITIES.TBLEXCEL)
    Dim ListEstCivil As New List(Of Integer)
    Dim ListEscolaridad As New List(Of Integer)
    Dim ListClasificacion As New List(Of Integer)
    Dim ListTipoSuscripcion As New List(Of Integer)
    Dim ListNivelIngresos As New List(Of Integer)
    Dim ListPromocion As New List(Of Integer)
    Dim ListNumOferta As Integer() = {1, 2, 3}
    Dim ListPlanFinanciacion As New List(Of Integer)

    'Consultas
    Dim Segmentacion As String = "select COMMERCIAL_SEGM_ID from CC_COMMERCIAL_SEGM WHERE COMMERCIAL_SEGM_ID>0"
    Dim EstadoCivil As String = "SELECT civil_state_id FROM ge_civil_state WHERE civil_state_id>0"
    Dim Escolaridad As String = "SELECT school_degree_id FROM ge_school_degree WHERE school_degree_id>0"
    Dim Clasificacion As String = "SELECT clasificacion_id FROM cc_tipo_scoring WHERE clasificacion_id>0"
    Dim TipoSuscripcion As String = "SELECT subscriber_type_id FROM ge_subscriber_type WHERE subscriber_type_id>0"
    Dim NivelIngresos As String = "SELECT wage_scale_id FROM ge_wage_scale WHERE wage_scale_id>0"
    Dim PlanComercial As String = "Select Distinct commercial_plan_id, initial_date, final_date From cc_commercial_plan Where commercial_plan_id > 0"
    Dim Promocion As String = "select PROMOTION_id from CC_PROMOTION WHERE PROMOTION_id>0"
    Dim PlanFinanciacion As String = "select PLDICODI from PLANDIFE WHERE PLDICODI>0"

    ''' <summary>
    ''' Realiza el proceso de inicializar la tablas internas, leer/extraer los datos de excel 
    ''' y Se renombran las columnas del DataTable con los encabezados de la plantilla
    ''' </summary>
    ''' <remarks></remarks>
    Function ImportarExcel()
        Dim boOk As Boolean = True
        Try
            'Se agrega columna consecutivo
            With App.DataTableImportacion
                .Clear()
                .Columns.Clear()
                'Dim A As DataColumn
                .Columns.Add("ID", Type.GetType("System.Int32"))
                .Columns("ID").ReadOnly = True
                .Columns("ID").AutoIncrement = True : .Columns("ID").AutoIncrementSeed = Plantilla.FilaEncabezado * -1 : .Columns("ID").AutoIncrementStep = 1
                boOk = DalTbExcel.ImportarExcel()
                If boOk = True Then
                    App.FlagPlantillaTieneEncabezados = True
                    Call DalTbExcel.FormatearDataTables()
                End If
            End With
        Catch ex As Exception
            boOk = False
            Throw
        End Try

        Return boOk

    End Function

    Function Procesar(ByRef sberror As String, Optional ByVal isbProcParciales As String = "N") As DataTable
        Dim boOK As Boolean = True
        Dim DT As New DataTable
        sberror = String.Empty
        Try

            'Call DalTbExcel.FormatearDataTables()

            If DalTbExcel.BorrarImportacionPrevia(sberror) = True Then
                'Insertar los datos en la tabla Excel
                DalTbExcel.BulkInsertExcel(sberror)
                If String.IsNullOrEmpty(sberror) Then
                    DT = DalTbExcel.ProcesarImportacion(sberror, isbProcParciales)
                    If String.IsNullOrEmpty(sberror) Or DT.Rows.Count > 0 Then
                        boOK = True
                    Else
                        boOK = False
                    End If
                Else
                    boOK = False
                End If
            Else
                boOK = False
            End If

            If Not String.IsNullOrEmpty(sberror) Then
                boOK = False
            Else
                boOK = True
            End If


        Catch ex As Exception
            boOK = False
            sberror = ex.Message
        End Try

        Return DT

    End Function

    Function Validar() As Boolean

        Dim boOK As Boolean = True, nuerror As Integer = 0, sberror As String = String.Empty
        Try
            DalTbExcel.ObtenerDatosValidacion(General.TblExcel.DtSetValidaciones, nuerror, sberror)
            Dim nucolConsctvo As Integer = 0 '-->1
            Dim nucolAño As Integer = 1 '-->2
            Dim nucolMes As Integer = 2 '-->3...
            Dim nucolCicloFact As Integer = 3
            Dim nucolPeriodo As Integer = 4
            Dim nucolProducto As Integer = 5
            Dim nucolLectura As Integer = 6
            Dim nucolPresion As Integer = 7

            With App.DataTableImportacion
                'For i As Integer = 0 To .Rows.Count

                '    If Me.FnValFkCicloFacturacion(.Rows(i)(nucolCicloFact)) = False Then
                '        boOK = False
                '    End If

                'Next
            End With



        Catch ex As Exception
            boOK = False
            sberror = ex.Message
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

                Dim FiltroTabla As String= "TABLE_NAME='" + DT.TableName + "'"

                'With DT
                '    If App.FlagColErroresOn = False Then
                '        If .Columns.Contains("ERRORES") Then
                '            'Si no hay errores (BoOK=True) y existe la columna, se borran las notificacion en la Fila
                '            '.Columns("ERRORES").
                '            .Columns.Remove("ERRORES")
                '            DT.AcceptChanges()
                '            'rowDT.RowError = String.Empty
                '        End If
                '    End If
                'End With

                'Se validan con los datos devueltos de las tablas ALL_TAB_COLUMNS COL y ALL_COL_COMMENTS
                Dim ColTipoDato As String = "DATA_TYPE"
                Dim ColTamañoDato As String = "DATA_PRECISION"

                'Filtro la info de la tabla que se validará
                Dim DV As New DataView(General.TblExcel.DTValEstrucTablas)

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
            RaiseMensaje("Error de validación de Estructura de Campos/Celdas. Linea " + line.ToString + vbCrLf + ex.Message, 0, MsgBoxStyle.Critical)
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
                Case App.DataTableImportacion.TableName
                    For Each Row As DataRow In DT.Rows

                        If Row.HasErrors Then
                            Row.ClearErrors()
                        End If

                        Dim Campo As String = "PERIODO"
                        If Not IsDBNull(Row(Campo)) Then
                            BoRes = FnValFkPerifact(Row(Campo), Row("ANO"), Row("ANO"))
                            If BoRes = False Then
                                BoOK = False
                            End If
                            Call SetRowError(DT, Row, BoRes, "Periodo de Facturación No es el Actual y/o corresponde a los " + vbCrLf _
                                             + "Ciclos (Consumo) de Lecturas Complementarias", Campo)
                        End If

                        Campo = "CICLO"
                        If Not IsDBNull(Row(Campo)) Then
                            BoRes = FnValFkCicloFacturacion(Row(Campo))
                            If BoRes = False Then
                                BoOK = False
                            End If
                            Call SetRowError(DT, Row, BoRes, "Ciclo No Valido. Revisar que perteneza al Ciclo de Lecturas Complementarias.", Campo)
                        End If

                        Campo = "PRODUCTO"
                        If Not IsDBNull(Row(Campo)) Then
                            BoRes = FnValFkProductos(Row(Campo))
                            If BoRes = False Then
                                BoOK = False
                            End If
                            Call SetRowError(DT, Row, BoRes, String.Format("Producto {0} no se encuentran en la tabla de Criticas actuales.", Row(Campo)), Campo)
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
            RaiseMensaje("Error de validación de datos. Linea " + line.ToString + vbCrLf + ex.Message, 0, MsgBoxStyle.Critical)
        End Try

        Return BoOK

    End Function

    Public Sub SetRowError(ByRef DT As DataTable, ByRef Row As DataRow, ByVal BoOK As Boolean, Optional ByVal Data As String = "", Optional ByVal campo As String = "")
        Try
            If BoOK = False Then
                'Cuando hay errores, se agrega la columna "ERRORES"
                If Not DT.Columns.Contains("ERRORES") Then
                    DT.Columns.Add("ERRORES", System.Type.GetType("System.String"))
                    If Not Row("ERRORES").ToString.Contains(Data) Then
                        Row("ERRORES") += Data + " | "
                        Row.RowError = Row("ERRORES")
                    End If
                    DT.AcceptChanges()
                Else
                    If Not Row("ERRORES").ToString.Contains(Data) Then
                        Row("ERRORES") += Data + " | "
                        Row.RowError = Row("ERRORES")
                    End If
                End If
                'Row("ERRORES") = String.Empty
                'Se establece la notificacion grafica y de texto en la Fila

                'Row.SetColumnError("ERRORES", Row("ERRORES"))
                'Coloca el error en la celda
                If DT.Columns.Contains(campo) Then
                    Row.SetColumnError(campo, Data)
                End If
            Else
                'If DT.Columns.Contains("ERRORES") Then
                '    'Si no hay errores (BoOK=True) y existe la columna, se borran las notificacion en la Fila
                '    Row("ERRORES") = String.Empty
                '    Row.ClearErrors()
                '    'rowDT.RowError = String.Empty
                'End If
                'Quita el error en la celda
                If DT.Columns.Contains(campo) Then
                    Row.SetColumnError(campo, String.Empty)
                End If
            End If
            Row.AcceptChanges()

        Catch ex As Exception
            If BoOK = False Then
                RaiseMensaje("Error al agregar inconsistencias de validacion sobre la columna 'ERRORES' o el Campo:" + campo + " | Error: " + Data + vbCrLf + "Detalle: " + ex.Message, 0, MsgBoxStyle.Exclamation)
            Else
                RaiseMensaje("Error al borrar datos de validacion en Campo:" + campo, 0, MsgBoxStyle.Exclamation)
            End If
        End Try
    End Sub

End Class
