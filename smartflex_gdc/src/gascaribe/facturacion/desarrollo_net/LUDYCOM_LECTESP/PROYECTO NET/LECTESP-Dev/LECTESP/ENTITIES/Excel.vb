Imports Excel = Microsoft.Office.Interop.Excel
Imports System.Globalization

Namespace ENTITIES
    Public Class HojasExcel
        Property Nombre As String
        Property ColumnaInicio As Integer
        Property ColumnaFin As Integer
        Property ColumnaFinNombre As String
        Property FilaInicio As Integer
        Property FilaFin As Integer
        Property FilaEncabezado As New Integer
        Public Columnas As New SortedDictionary(Of Integer, String)

        '-- Flags --
        Property FlagColErroresOnTop As Boolean = False
        Property FlagUsarDescripciones As Boolean = False


        Sub New()
            Me.FilaEncabezado = 3
            Me.FilaInicio = 4
            Me.FilaFin = 65000
            Me.ColumnaInicio = 1
            Me.ColumnaFin = 7
        End Sub

        Sub New(ByVal Nombre As String, ByVal ColumnaFinal As Integer, Optional ByVal FilaFinal As Integer = 65000)
            Me.Nombre = Nombre
            Me.FilaEncabezado = 3
            Me.ColumnaInicio = 1
            Me.ColumnaFin = ColumnaFinal
            Me.FilaInicio = 4
            Me.FilaFin = FilaFinal
        End Sub

        ''' <summary>
        ''' Renombra las columnas del Datatable segun los encabezados importados de la plantilla 
        ''' o las crea automaticamente con las propiedades de la Clase pasada por Parametro
        ''' </summary>
        ''' <param name="DT">Datatable al que se le adicionaran las propiedades de la clase como columnas </param>
        ''' <param name="Clase"></param>
        Public Sub ColumnasDataTables(ByRef DT As DataTable, ByVal Clase As Object)

            Dim DtTemp As New DataTable

            Dim currentCulture = System.Globalization.CultureInfo.InstalledUICulture
            Dim numberFormat As System.Globalization.NumberFormatInfo = currentCulture.NumberFormat.Clone()
            numberFormat.NumberDecimalSeparator = "."
            numberFormat.CurrencyDecimalSeparator = "."

            Dim BoBorrarFilasEncabezados As Boolean = False

            Try
                With DT
                    'DT.Columns.Clear()
                    DtTemp.Columns.Clear()
                    If DT.Columns.Count > 0 Then
                        'Renombrar Columnas 
                        For i As Integer = 0 To DT.Columns.Count - 1
                            If DT.Columns(i).ColumnName.Contains("ID") Then 'La Primera columna debe ser un ID
                                DtTemp.Columns.Add("ID", GetType(Integer))
                                Continue For
                            End If

                            'If App.FlagPlantillaTieneEncabezados = False Then
                            '    Plantilla.FilaEncabezado = 1
                            '    BoBorrarFilasEncabezados = False
                            'End If

                            'Se renombran las columnas del DataTable con los encabezados de la plantilla
                            Dim col As String = DT.Rows(Plantilla.FilaEncabezado - 1).Item(i).ToString.Trim(" ") '>> [se quitan espacios]
                            col = col.Replace("Ñ", "N")

                            'Valida si la columna ya tiene el nombre asignado
                            If Not DT.Columns.Contains(col) Then
                                'asigna el nuevo nombre de la columna en el datatable desde la plantilla
                                DT.Columns.Item(i).ColumnName = col

                                'Se crean las columnas de la tabla temporal con los tipos de datos correctos
                                If col.Contains("PRESION") Then
                                    DtTemp.Columns.Add(col, GetType(Double))
                                Else
                                    DtTemp.Columns.Add(col, GetType(Integer))
                                End If

                                If Plantilla.FlagUsarDescripciones Then
                                    'Si el Flag esta activo, se toma la descripcion del Header desde la plantilla
                                    DT.Columns.Item(i).Caption = DT.Rows(Plantilla.FilaEncabezado - 1).Item(i).ToString.Trim(" ") '>> [se quitan espacios]
                                End If
                                BoBorrarFilasEncabezados = True
                            Else
                                Throw New ApplicationException("Columnas repetidas en la plantilla")
                            End If
                            'End If
                        Next

                        If Plantilla.FlagColErroresOnTop Then
                            If Not DT.Columns.Contains("ERRORES") Then
                                DT.Columns.Add("ERRORES")
                                DT.Columns("ERRORES").AllowDBNull = True
                            End If
                        End If

                        If BoBorrarFilasEncabezados = True Then
                            'Se borran las filas de encabezado de la Plantilla
                            For i As Integer = 0 To Plantilla.FilaEncabezado - 1
                                DT.Rows(i).Delete()
                            Next
                            DT.AcceptChanges()
                        End If

                        DtTemp.Rows.Clear()
                        'Copio los datos del DT con las columnas con los tipos de datos correctos (Necesario para BulkInsert)
                        For i As Integer = 0 To DT.Rows.Count - 1
                            DtTemp.Rows.Add()
                            For j As Integer = 0 To DT.Columns.Count - 1
                                If DT.Columns(j).ColumnName = DtTemp.Columns(j).ColumnName Then
                                    'Si las columnas son iguales, copia datos
                                    If DT.Columns(j).ColumnName.Contains("PRESION") Then

                                        Try
                                            Dim d As Double = Format(CType(DT.Rows(i)(j), Double), "0.00")
                                            DtTemp.Rows(i)(j) = d
                                            DtTemp.Rows(i)(j) = Double.Parse(DT.Rows(i)(j).ToString.Replace(",", "."), CultureInfo.InvariantCulture)
                                        Catch ex As Exception

                                        End Try
                                    Else
                                        DtTemp.Rows(i)(j) = CInt(DT.Rows(i)(j))
                                    End If
                                End If
                            Next
                        Next

                        'Hago el filtro con el Dataview
                        Dim Dview As DataView = DtTemp.DefaultView
                        DT.Reset()
                        DT.Clear()
                        DtTemp.AcceptChanges()
                        DT = DtTemp.Copy
                        'DT.Load(DtTemp.CreateDataReader)
                        'Importo solo las filas filtradas
                        'For i = 0 To Dview.Count - 1
                        '    DT.ImportRow(Dview.Item(i).Row)
                        'Next
                    End If

                End With

            Catch ex As Exception
                Throw New ApplicationException("Plantilla no tiene el formato correcto de Encabezados. Verificar.")
            End Try
        End Sub

    End Class

    Public Class ExcelApp
        Public xlApp As New Excel.Application
        Public Libro As New Excel.Workbook
        Public Hoja As New Excel.Worksheet

        Sub New()
            If xlApp Is Nothing Then
                MessageBox.Show("Verificar si Excel esta instalado correctamente!!")
                Return
            End If

        End Sub

        Sub Guardar(ByVal Ruta As String)
            Libro.SaveAs(Ruta)
        End Sub

        Sub cerrar()
            Libro.Close()
        End Sub

        Sub Quitar()
            If Libro.Saved = True Then
                Libro.Close()
            Else

            End If
            xlApp.Quit()
            EliminarInstancia(xlApp)
            EliminarInstancia(Libro)
            EliminarInstancia(Hoja)
        End Sub

        Private Sub EliminarInstancia(ByVal obj As Object)
            Try
                System.Runtime.InteropServices.Marshal.ReleaseComObject(obj)
                obj = Nothing
            Catch ex As Exception
                obj = Nothing
            Finally
                GC.Collect()
            End Try
        End Sub

        Private TipoPlantilla_ As String
        Public Property TipoPlantilla() As String
            Get
                Return TipoPlantilla_
            End Get
            Set(ByVal value As String)
                TipoPlantilla_ = value
            End Set
        End Property

    End Class

End Namespace