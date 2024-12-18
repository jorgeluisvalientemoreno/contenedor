Imports System.Collections.Generic
Imports System.Reflection
Imports LUDYCOM.ENTITIES
Imports Excel = Microsoft.Office.Interop.Excel
Imports System.Data
Imports System.Xml



Module General

    Public TipoConexion As String
    Public EstadoConexion As ConnectionState
    Public BDD As String
    Public ModoDesarrollo As Boolean = False
    '-------------------Contenedores-----------------------
    'Paginador de datos Default
    Public BS As New BindingSource

    'Public Excel As ENTITIES.ExcelApp

    'Instanciar Clases
    Public MiSegmentacion As New SegmentacionComercial
    Public LstSegmentacionComercial As New List(Of SegmentacionComercial)

    Public SegCaracter As New SegmentacionComercial.Caracteristicas
    Public SegCarDemog As New SegmentacionComercial.Caracteristicas.Demograficas
    Public SegCarGeo As New SegmentacionComercial.Caracteristicas.GeoPoliticas
    Public SegCarCom As New SegmentacionComercial.Caracteristicas.Comerciales
    Public SegCarFinan As New SegmentacionComercial.Caracteristicas.Financieras
    Public SegComProm As New SegmentacionComercial.Promociones
    Public SegComPlanCom As New SegmentacionComercial.PlanComercial
    Public SegComPlanFinan As New SegmentacionComercial.PlanFinanciacion
    '---------------------List-------------------------
    Public LstTablaPuente As New List(Of General.TablaPuente)

    '------------------------------------------------------
    Public Plantilla As New List(Of HojasExcel)
    Public RutaPlantilla As String

    'Parametros Generales
    Public App As New SegmentacionComercial.Datos 'Datos utilizados frecuentemente en la aplicacion
    Public Validacion As New SegmentacionComercial.Validacion

    ' -- Validaciones --
    Public BooValidacionHabilitada As Boolean = False
    Public BoProcesarHabilitado As Boolean = False

    ' -- Depuracion --
    Public FiltrarDatosPlantilla As Boolean = True

    '-- Consecutivos --
    Public DTConsecutivos As New DataTable("CC_CONSECUTIVOS")

#Region "Reflection Columnas >>> Class"

    Sub SetColumnasExcel(ByRef clase As Object)
        Dim nuContColumnas As Integer
        Dim boDefineHojasExcel As Boolean = True
        Try
            clase.hojaexcel.Columnas.Clear()
        Catch ex As Exception
            'informa si la clase no es tipo Segmentacion Comercial y no tiene definida la variable HojaExcel
            boDefineHojasExcel = False
        End Try
        Try
            With clase.hojaexcel
                For Each propiedad As PropertyInfo In clase.GetType.GetProperties
                    'Se instancia la columna con los datos de la clase
                    Dim Col As New DataColumn(propiedad.Name.ToUpper, propiedad.PropertyType)
                    If Not .Columnas.ContainsValue(Col.ColumnName) Then
                        nuContColumnas += 1
                        If boDefineHojasExcel Then
                            'Se agrega el item
                            .columnas.add(nuContColumnas, Col.ColumnName)
                        End If
                    End If
                Next
            End With
        Catch ex As Exception
            Throw New ApplicationException("Error al definir los campos de Columna desde la clase. [SetColumnasExcel]")
        End Try
    End Sub

    ''' <summary>
    ''' Renombra las columnas del Datatable segun los encabezados importados de la plantilla 
    ''' o las crea automaticamente con las propiedades de la Clase pasada por Parametro
    ''' </summary>
    ''' <param name="DT">Datatable al que se le adicionaran las propiedades de la clase como columnas </param>
    ''' <param name="Clase"></param>
    Public Sub ColumnasDataTables(ByRef DT As DataTable, ByVal Clase As Object)

        Dim BooBorrarFilasEncabezados As Boolean = False
        Try
            With DT
                'DT.Columns.Clear()
                If DT.Columns.Count > 0 Then
                    'Renombrar Columnas 
                    For i As Integer = 0 To DT.Columns.Count - 1

                        'If DT.Rows(1).Item(0).ToString.Contains("_ID") Then 'La Primera columna debe ser el ID de la Segmentacion

                        'Se renombran las columnas del DataTable con los encabezados de la plantilla
                        Dim col As String = DT.Rows(1).Item(i).ToString.Trim(" ")

                        If Not DT.Columns.Contains(col) Then
                            
                            DT.Columns.Item(i).ColumnName = DT.Rows(1).Item(i).ToString.Trim(" ") '>> [se quitan espacios]

                            If App.FlagUsarDescripcionesPlantilla Then
                                DT.Columns.Item(i).Caption = DT.Rows(2).Item(i).ToString.Trim(" ") '>> [se quitan espacios]
                            End If
                            'MsgBox(DT.Rows(1).Item(i))
                            BooBorrarFilasEncabezados = True
                        Else
                            Throw New ApplicationException("Columnas repetidas en la plantilla")
                        End If
                        'End If
                    Next
                    If App.FlagColErroresOnTop Then
                        If Not DT.Columns.Contains("ERRORES") Then
                            DT.Columns.Add("ERRORES")
                            DT.Columns("ERRORES").AllowDBNull = True
                        End If
                    End If

                    If BooBorrarFilasEncabezados = True Then
                        'Se borran las filas de encabezado de la Plantilla
                        DT.Rows(0).Delete()
                        DT.Rows(1).Delete()
                        DT.Rows(2).Delete()
                        DT.Rows(3).Delete()
                        DT.AcceptChanges()
                    End If
                End If

            End With

        Catch ex As Exception
            Throw New ApplicationException("Plantilla no tiene el formato correcto de Encabezados. Favor verificar.")
        End Try
    End Sub

    Public Sub DatosDinamicos(ByRef Clase As Object, ByVal Header As String, ByVal Valor As Object)
        'Obtengo el tipo de la Clase pasada por parametro
        Dim ClaseTipo As Type = Clase.GetType()

        'Obtengo los datos de la propiedad requerida
        Dim ClaseCampos As PropertyInfo = ClaseTipo.GetProperty(Header)

        'Se asigna el valor a la Propiedad de la Clase
        If ClaseCampos.PropertyType.Name = "Int64" Then
            ClaseCampos.SetValue(Clase, Convert.ToInt64(Valor), Nothing)
        ElseIf ClaseCampos.PropertyType.Name = "String" Then
            ClaseCampos.SetValue(Clase, Convert.ToString(Valor), Nothing)
        End If

        'MsgBox(pinfo.GetValue(Clase, Nothing))
    End Sub

    Public Function ListToDataTable(Of T)(ByVal list As IList(Of T)) As DataTable
        Dim table As New DataTable()
        Dim Propiedades() As PropertyInfo = GetType(T).GetProperties
        For Each P As PropertyInfo In Propiedades
            table.Columns.Add(P.Name, P.PropertyType)
        Next
        For Each item As T In list
            Dim row As DataRow = table.NewRow()
            For Each P As PropertyInfo In Propiedades
                row(P.Name) = P.GetValue(item, Nothing)
            Next
            table.Rows.Add(row)
        Next
        Return table
    End Function

    Public Sub releaseObject(ByVal obj As Object)
        Try
            System.Runtime.InteropServices.Marshal.ReleaseComObject(obj)
            obj = Nothing
        Catch ex As Exception
            obj = Nothing
        Finally
            GC.Collect()
        End Try
    End Sub

    Sub CerrarExcel()

        'Try
        '    If Not IsNothing(xlWorkSheet) Then
        '        'xlWorkSheet.Close()
        '        releaseObject(xlWorkSheet)
        '    End If
        'Catch ex As Exception
        '    'Evitar el error para poder instanciar un nuevo proceso
        'Finally
        '    GC.Collect()
        'End Try
        'Try
        '    If Not IsNothing(xlWorkBook) Then
        '        xlWorkBook.Close()
        '        releaseObject(xlWorkBook)
        '    End If
        'Catch ex As Exception
        '    'Evitar el error para poder instanciar un nuevo proceso
        'Finally
        '    GC.Collect()
        'End Try
        'Try
        '    If Not IsNothing(xlApp) Then
        '        xlApp.Quit()
        '        releaseObject(xlApp)
        '    End If

        'Catch ex As Exception
        '    'Evitar el error para poder instanciar un nuevo proceso
        'Finally
        '    GC.Collect()
        'End Try
    End Sub

#End Region


    'https://www.tutorialspoint.com/vb.net/vb.net_xml_processing.htm
    'http://www.codeproject.com/Articles/4826/XML-File-Parsing-in-VB-NET
    'https://msdn.microsoft.com/es-co/library/cc189056(v=vs.95).aspx

    Class TablaPuente
        Property commercial_segm_id As Int64
        Property name As String
        Property active As String
        Property com_seg_fea_val_id As Int64
        Property subs_type_id As Int64
        Property subs_scoring As Int64
        Property subs_vinculated As Int64
        Property subs_gender_id As String
        Property subs_age As Int64
        Property subs_civil_state As Int64
        Property subs_schl_degree_id As Int64
        Property subs_wage_level_id As Int64
        Property geog_geogph_loc_id As Int64
        Property geog_segment_id As Int64
        Property geog_initial_number As Int64
        Property geog_final_number As Int64
        Property geog_address_id As Int64
        Property geog_category_id As Int64
        Property geog_subcategory_id As Int64
        Property prod_cutting_state As Int64
        Property finan_finan_count As Int64
        Property finan_acc_balance As Int64
        Property finan_finan_state As String
        Property finan_last_fin_plan As Int64
        Property hash_value As String
        Property prod_commercial_plan As Int64
        Property promotion_id As Int64
        Property com_seg_prom_id As Int64
        Property offer_class As Int64
        Property com_seg_plan_id As Int64
        Property commercial_plan_id As Int64
        Property offer_class_plan As Int64
        Property financing_plan_id As Int64
        Property com_seg_finan_id As Int64
        Property priority As Int64
        Property offer_class_finan As Int64
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

    Public Sub RaiseError(ByVal MSG As String, ByVal Number As Integer, ByVal tipo As MsgBoxStyle)
        MsgBox(MSG, tipo, Application.ProductName)
    End Sub

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
                RaiseError("Error al agregar inconsistencias de validacion sobre la columna 'ERRORES' o el Campo:" + campo + " | Error: " + Data + vbCrLf + "Detalle: " + ex.Message, 0, MsgBoxStyle.Exclamation)
            Else
                RaiseError("Error al borrar datos de validacion en Campo:" + campo, 0, MsgBoxStyle.Exclamation)
            End If
        End Try
    End Sub

End Module