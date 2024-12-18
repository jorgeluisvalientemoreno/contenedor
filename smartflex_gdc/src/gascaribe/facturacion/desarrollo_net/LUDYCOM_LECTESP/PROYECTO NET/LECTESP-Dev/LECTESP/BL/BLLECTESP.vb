Imports System.Reflection
Imports LUDYCOM.LECTESP.ENTITIES
Imports LUDYCOM.LECTESP.DAL
Imports System.Globalization
Imports System.Xml
Imports System.IO


Namespace BL

    Public Class BLLECTESP

#Region "Declaraciones"

        Dim DAL As New DALLECTESP
        'Dim EstadoConexion As New ConnectionState

#End Region

        'Sub New()
        '    Me.EstadoConexion = DAL.EstadoConexion
        'End Sub

#Region "GRIDS"

#Region "Funciones que devuelven cursores"

        ' <summary>
        ' Se cargan los datos de los Grid, ComboBox
        ' </summary>
        ' <returns>bindingSource</returns>
        Public Function BL_GetListado(ByVal Tipo As String) As BindingSource
            BL_GetListado = New BindingSource
            Try
                BL_GetListado = DAL.GetListado(Tipo)
            Catch ex As Exception
                App.MsgObsDefault += vbCrLf + ex.Message.ToString
            End Try
            Return BL_GetListado
        End Function

        ' <summary>
        ' Se cargan los datos de los Grid, ComboBox
        ' </summary>
        ' <returns>bindingSource</returns>
        Public Function BL_GetPefaCiclo(ByVal nuCiclo As Integer) As BindingSource
            BL_GetPefaCiclo = New BindingSource
            Try
                BL_GetPefaCiclo = DAL.getPefaByCiclo(nuCiclo)
            Catch ex As Exception
                App.MsgObsDefault += vbCrLf + ex.Message.ToString
            End Try
            Return BL_GetPefaCiclo
        End Function


        ' <summary>
        ' Se cargan los datos que cargaron a los Grid, ComboBox
        ' </summary>
        ' <returns>bindingSource</returns>
        Public Function FiltrarCombo(ByVal tipo As String, ByVal value As String) As BindingSource
            FiltrarCombo = New BindingSource
            Try
                If General.EstadoConexion = ConnectionState.Open Then
                    FiltrarCombo = DAL.FiltrarCombo(tipo, value)
                End If
            Catch ex As Exception
                App.MsgObsDefault += vbCrLf + ex.Message.ToString
            End Try

            Return FiltrarCombo
        End Function

        ' <summary>
        ' Obtiene la lista de ciclos parametrizados en LDC_CM_LECTESP_CICLOS
        ' </summary>
        ' <returns>bindingSource</returns>
        Public Function BL_getCiclos() As DataSet
            Dim dsCiclos As New DataSet

            dsCiclos = DAL.getCiclos()

            Return dsCiclos
        End Function

        ' <summary>
        ' Obtiene la lista de ciclos parametrizados en LDC_CM_LECTESP_CICLOS
        ' </summary>
        ' <returns>bindingSource</returns>
        Public Function BL_getPefaCiclos(ByVal sbCiclo As String) As DataSet
            Dim dsPefa As New DataSet
            Dim nuCiclo As New Integer
            If (sbCiclo <> "") Then
                nuCiclo = CInt(sbCiclo)
                dsPefa = DAL.getPefaCiclos(nuCiclo)
            End If
            Return dsPefa
        End Function

#End Region

#Region "Reflection Columnas con Class Critica"

        '<Summary>
        'Borra las columnas del Grid y las crea automaticamente con las propiedades de la Clase Critica
        '<Returns>Nada</Returns>
        Public Sub CrearColumnasGrid(ByRef Grid As DataGridView)
            With Grid
                .Columns.Clear()
                For Each propiedad As PropertyInfo In NewCritica.GetType.GetProperties
                    'MsgBox(propiedad.PropertyType.ToString)
                    If propiedad.PropertyType.Name = "Boolean" Then
                        Dim Col As New DataGridViewCheckBoxColumn
                        Col.Name = propiedad.Name
                        Col.ValueType = propiedad.PropertyType
                        Grid.Columns.Add(Col)

                        ''20160806 - Columna adicional (Seleccionar registros)
                        'Col = New DataGridViewCheckBoxColumn
                        'Col.Name = "Item"
                        'Col.ValueType = propiedad.PropertyType
                        'Grid.Columns.Add(Col)
                    Else
                        If propiedad.Name.Contains("PresionFinal") Then
                            'CA 200-856
                            ''---------------------------------------------------------------------------------------
                            'e.	Duplicar columna Cliente y colocarla antes del campo PresionFinal
                            Dim objCol As New DataGridViewTextBoxColumn
                            objCol = .Columns("Suscriptor").Clone()
                            objCol.Name = "Cliente"
                            .Columns.Add(objCol)
                            '---------------------------------------------------------------------------------------
                        End If
                        Dim Col As New DataGridViewTextBoxColumn
                        Col.Name = propiedad.Name
                        Col.ValueType = propiedad.PropertyType
                        Grid.Columns.Add(Col)
                        If Col.Name.Contains("Presion") Then
                            Grid.Columns(Col.Name).DefaultCellStyle.Format = "G"
                        End If

                        If Col.Name.Contains("Correccion") Then
                            Grid.Columns(Col.Name).DefaultCellStyle.Format = "G"
                        End If

                    End If
                Next
                
            End With
        End Sub

#End Region

#Region "EXCEL"

        ''' <summary>
        ''' Arma el nombre del archivo y se la anexa al directorio especificado por el usuario. 
        ''' Llama a la funcion que genera el archivo.
        ''' </summary>
        ''' <param name="Grid">Fuente de Datos</param>
        ''' <param name="RutaArchivo">Ruta donde se guardarà el archivo exportado</param>
        ''' <returns>True/False como resultado de la operacion</returns>
        Public Function ExportarGridAExcel(ByVal Grid As DataGridView, ByRef RutaArchivo As String) As Boolean
            Dim BoOK As Boolean = True

            Dim NombreArchivo As String = String.Empty, osbMensajeError As String = String.Empty

            'Se crea el Nombre del archivo de Excel y se agrega a la ruta
            With Date.Now
                NombreArchivo = String.Format("LectEspCrit_{0}{1}{2}_{3}{4}.xlsx", .Year.ToString, .Month.ToString("00"), .Day.ToString("00"), .Hour.ToString("00"), .Minute.ToString("00"))
                RutaArchivo += "\" + NombreArchivo
            End With

            'Se invoca el proceso de Exportacion
            BoOK = DAL.ExportarGridAExcel(Grid, RutaArchivo, osbMensajeError)
            If BoOK = False Then
                Throw New ApplicationException(osbMensajeError)
            End If

            Return BoOK

        End Function

#End Region

#Region "Actualizar Variables de Medicion"

        '<Summary>
        'Extrae los datos de la filas no esta procesadas y que el usuario ha seleccionado.
        '<Returns>True/False dependiendo si hay datos o no</Returns>
        Public Function ExtraerFilasCompletasGrid(ByRef Grid1 As DataGridView)
            Dim Resultado As Boolean = True 'Se inicializa True, si alguna operacion finaliza mal se devuelve false en la funcion.
            Dim MyCol As New DataGridViewTextBoxColumn

            'Inicializo la tabla para registrar solo los datos a actualizar
            App.InicializarTablaActualizarCritica()

            'Recorro cada fila del Grid
            For Each Row As DataGridViewRow In Grid1.Rows

                If CheckContenidoMinimoFila(Row) = True Then
                    'Agrego los registros a la tabla local (DataTableActualizarCritica) para actualizar LDC_CM_LECTESP_CRIT 
                    With Grid1.Rows(Row.Index)
                        'Valido si la fila esta seleccionada
                        Dim MarcadoParaProcesar As Boolean = .Cells("Procesado").Value
                        If MarcadoParaProcesar = True Then
                            'Valido que la fila no haya sido procesada previamente
                            Dim Estado As Boolean = .Cells("Estado").Value
                            If Estado = False Then
                                Dim PresionFinal As Double = Convert.ToDouble(.Cells("PresionFinal").Value)
                                App.DataTableActualizarCritica.Rows.Add({.Cells("Critica_id").Value, .Cells("Producto").Value, .Cells("LecturaFinal").Value, PresionFinal})
                            End If
                        End If
                    End With
                End If
            Next

            'Valido si en la tabla hay registros para procesar
            If App.DataTableActualizarCritica.Rows.Count >= 1 Then
                Resultado = True
            Else
                Resultado = False
            End If

            Return Resultado
        End Function

        
        ''' <summary>
        '''Carga las criticas en la grilla. Si el parametro CargardesdeBDD es true se consultan los datos nuevamente en el servidor si no se usa la informacion
        '''cargada en una Datatable Local y lo que se haria es un Refresh
        ''' </summary>
        ''' <param name="Grid"></param>
        ''' <param name="filter">El filtro es cargado por los ComboBox</param>
        ''' <param name="CargardesdeBDD">Indica si se deben buscar datos en la Base de Datos o en el Datatable Local</param>
        Public Function BL_CargarCriticas(ByRef Grid As DataGridView, Optional ByVal filter As String = "", Optional ByVal CargardesdeBDD As Boolean = False)
            Dim BoTraerLecturaAnterior As Boolean = False
            Dim BoTraerPresionAnterior As Boolean = False

            Try
                ListCriticas = New List(Of Critica)

                'Se deja de usar la tabla local y se carga la info desde la BDD
                If CargardesdeBDD = True Or App.DataTableCritica.Rows.Count = 0 Then
                    App.FlagCargarCriticasdesdeBDD = True

                End If

                'Establezco le BindingSource los Criticas
                BS = BL_GetListado("Criticas")

                'Desactivo el Flag de la carga desde BDD para seguir usando Datos desconectados
                App.FlagCargarCriticasdesdeBDD = False

                'Valido que hayan datos para procesar
                If App.DataTableCritica.Rows.Count > 0 Then
                    Dim DT As DataTable = App.DataTableCritica 'BS.DataSource
                    Dim FilterDT As New DataTable

                    '-------- Inicio Filtrado de Datos -----------
                    'Le aplico los filtros si se pasaron en los parametros

                    'Clono el Datatable Principal al Filtrado (Solo el Esquema) -Clear Rows
                    FilterDT.Load(DT.CreateDataReader)
                    FilterDT.Rows.Clear()
                    'Hago el filtro con el Dataview
                    Dim Dview As DataView = DT.DefaultView
                    Dview.RowFilter = Filtro.FiltroFinal
                    'Importo solo las filas filtradas
                    For i = 0 To Dview.Count - 1
                        FilterDT.ImportRow(Dview.Item(i).Row)
                    Next
                    '----------Fin Filtros ------------------------

                    '----------Borrado Rows del Grid --------------
                    App.FlagBorradoCellsGrid = True
                    If Grid.DataSource Is Nothing Then
                        Grid.Rows.Clear()
                    End If

                    App.FlagBorradoCellsGrid = False
                    '----------Fin Borrado Rows del Grid --------------

                    'OJO: Proxima Modificacion --> Asignar Datatable al Grid (Mas Rapido)
                    'Grid.DataSource = FilterDT

                    'Return 0

                    'Recorro cada fila del Grid
                    For Each Row As DataRow In FilterDT.Rows
                        With Grid
                            'Se instancia la Critica por cada fila del DataTable
                            NewCritica = New Critica
                            'Dim GridRow As New DataGridViewRow

                            Grid.Rows.Add()
                            With Grid.Rows(App.IndexFilaNueva)
                                Dim nfi As NumberFormatInfo = New CultureInfo("en-US", False).NumberFormat
                                nfi.NumberDecimalDigits = 2

                                'Se adicionan los datos a la clase critica
                                NewCritica.Critica_id = Row.Item("critica_id")

                                NewCritica.Producto = Row.Item("sesunuse")
                                NewCritica.Suscriptor = Row.Item("nombre")
                                NewCritica.Direccion = Row.Item("address_parsed")
                                NewCritica.CicloConsumo = Row.Item("sesucico")
                                NewCritica.PeriodoFacturacion = Row.Item("pefacodi")
                                NewCritica.PeriodoConsumo = Row.Item("pecscons")
                                NewCritica.ConsumoPromedio = Row.Item("consprom")
                                NewCritica.ConsumoAñoAnterior = Row.Item("conspromdc")
                                NewCritica.LecturaAnterior = Row.Item("leemlean")
                                NewCritica.LecturaActual = Row.Item("leemleac")
                                NewCritica.VolumenSinCorregir = Row.Item("volncorr")
                                NewCritica.PresionMesAnterior = Row.Item("presmesant")
                                NewCritica.FactorCorrMesAnt = Row.Item("facorrmant")
                                NewCritica.VolumenCorregEstimado = Row.Item("volcorrest")

                                'CA 200-1105
                                NewCritica.Ano = Row.Item("ano")
                                NewCritica.Mes = Row.Item("mes")
                                NewCritica.Dpto = Row.Item("dpto")
                                NewCritica.Estado_corte = Row.Item("estado_corte")
                                NewCritica.Estado_financiero = Row.Item("Estado_financiero")
                                'Fin CA 200-1105


                                If Not IsDBNull(Row.Item("lepresa")) Then
                                    NewCritica.LecturaPresion1 = Convert.ToDouble(Row.Item("lepresa")).ToString("N2", nfi)
                                Else
                                    NewCritica.LecturaPresion1 = String.Empty
                                End If
                                If Not IsDBNull(Row.Item("funca")) Then
                                    NewCritica.Funcionando1 = Row.Item("funca")
                                Else
                                    NewCritica.Funcionando1 = String.Empty
                                End If
                                If Not IsDBNull(Row.Item("lepresb")) Then
                                    NewCritica.LecturaPresion2 = Convert.ToDouble(Row.Item("lepresb")).ToString("N2", nfi)
                                Else
                                    NewCritica.LecturaPresion2 = String.Empty
                                End If
                                If Not IsDBNull(Row.Item("funcb")) Then
                                    NewCritica.Funcionando2 = Row.Item("funcb")
                                Else
                                    NewCritica.Funcionando2 = String.Empty
                                End If
                                If Not IsDBNull(Row.Item("lepresc")) Then
                                    NewCritica.LecturaPresion3 = Convert.ToDouble(Row.Item("lepresc")).ToString("N2", nfi)
                                Else
                                    NewCritica.LecturaPresion3 = String.Empty
                                End If
                                If Not IsDBNull(Row.Item("funcc")) Then
                                    NewCritica.Funcionando3 = Row.Item("funcc")
                                Else
                                    NewCritica.Funcionando3 = String.Empty
                                End If
                                If Not IsDBNull(Row.Item("presfin")) Then
                                    NewCritica.PresionFinal = Row.Item("presfin")
                                Else
                                    NewCritica.PresionFinal = Nothing
                                End If
                                If Not IsDBNull(Row.Item("lectfin")) Then
                                    NewCritica.LecturaFinal = Row.Item("lectfin")
                                Else
                                    NewCritica.LecturaFinal = String.Empty
                                End If
                                If Row.Item("proc") = "N" Then
                                    NewCritica.Estado = 0
                                Else
                                    NewCritica.Estado = 1
                                End If

                                'CA 200-856 - Nuevas Columnas
                                '---------------------------------------------------
                                If FilterDT.Columns.Contains("sort_id") Then
                                    If Not IsDBNull(Row.Item("sort_id")) Then
                                        NewCritica.Sort_ID = Row.Item("sort_id")
                                    Else
                                        NewCritica.Sort_ID = 999999999
                                    End If
                                End If

                                If FilterDT.Columns.Contains("caupresa") Then
                                    If Not IsDBNull(Row.Item("caupresa")) Then
                                        NewCritica.Causal1 = Row.Item("caupresa")
                                    End If
                                Else
                                    NewCritica.Causal1 = String.Empty
                                End If

                                If FilterDT.Columns.Contains("caupresb") Then
                                    If Not IsDBNull(Row.Item("caupresb")) Then
                                        NewCritica.Causal2 = Row.Item("caupresb")
                                    End If
                                Else
                                    NewCritica.Causal2 = String.Empty
                                End If

                                If FilterDT.Columns.Contains("caupresc") Then
                                    If Not IsDBNull(Row.Item("caupresc")) Then
                                        NewCritica.Causal3 = Row.Item("caupresc")
                                    End If
                                Else
                                    NewCritica.Causal3 = String.Empty
                                End If
                                '---------------------------------------------------

                                'CA 200-1105
                                If Not IsDBNull(Row.Item("volFacturado")) And Row.Item("volFacturado") > 0 Then
                                    NewCritica.VolFacturado = Row.Item("volFacturado")
                                End If
                                If Not IsDBNull(Row.Item("fecha_legal")) Then
                                    NewCritica.Fecha_legal = Row.Item("fecha_legal")
                                    Row.Item("proc") = "S"
                                    NewCritica.Estado = 1
                                Else
                                    NewCritica.Fecha_legal = String.Empty
                                End If

                                If Not IsDBNull(Row.Item("Usuario_lega")) Then
                                    NewCritica.Usuario_lega = Row.Item("Usuario_lega").ToString
                                Else
                                    NewCritica.Usuario_lega = String.Empty
                                End If

                                If Not IsDBNull(Row.Item("Impexcel")) Then
                                    NewCritica.Impexcel = Row.Item("Impexcel").ToString
                                Else
                                    NewCritica.Impexcel = String.Empty
                                End If

                                If Not IsDBNull(Row.Item("Terminal")) Then
                                    NewCritica.Terminal = Row.Item("Terminal").ToString
                                Else
                                    NewCritica.Terminal = String.Empty
                                End If

                                'CA 200-1983
                                If Not IsDBNull(Row.Item("Ufech_lect")) Then
                                    NewCritica.Ufech_lect = Row.Item("Ufech_lect")
                                Else
                                    NewCritica.Ufech_lect = String.Empty
                                End If
                                'Fin CA 200-1983



                                '
                                'Fin CA 200-1105


                                '*** [Se asignan los datos a las celdas del Grid]***
                                .Cells("Critica_id").Value = NewCritica.Critica_id
                                .Cells("Producto").Value = NewCritica.Producto
                                .Cells("Suscriptor").Value = NewCritica.Suscriptor
                                .Cells("Direccion").Value = NewCritica.Direccion
                                .Cells("CicloConsumo").Value = NewCritica.CicloConsumo
                                .Cells("PeriodoFacturacion").Value = NewCritica.PeriodoFacturacion
                                .Cells("PeriodoConsumo").Value = NewCritica.PeriodoConsumo
                                .Cells("ConsumoPromedio").Value = NewCritica.ConsumoPromedio
                                .Cells("ConsumoAñoAnterior").Value = NewCritica.ConsumoAñoAnterior
                                .Cells("LecturaAnterior").Value = NewCritica.LecturaAnterior
                                .Cells("LecturaActual").Value = NewCritica.LecturaActual
                                .Cells("VolumenSinCorregir").Value = NewCritica.VolumenSinCorregir
                                .Cells("PresionMesAnterior").Value = NewCritica.PresionMesAnterior
                                .Cells("FactorCorrMesAnt").Value = NewCritica.FactorCorrMesAnt
                                .Cells("VolumenCorregEstimado").Value = NewCritica.VolumenCorregEstimado
                                .Cells("LecturaPresion1").Value = NewCritica.LecturaPresion1 '.ToString
                                .Cells("Funcionando1").Value = NewCritica.Funcionando1
                                .Cells("LecturaPresion2").Value = NewCritica.LecturaPresion2 '.ToString
                                .Cells("Funcionando2").Value = NewCritica.Funcionando2
                                .Cells("LecturaPresion3").Value = NewCritica.LecturaPresion3 '.ToString
                                .Cells("Funcionando3").Value = NewCritica.Funcionando3
                                .Cells("PresionFinal").Value = Math.Round(Convert.ToDouble(NewCritica.PresionFinal), 2)
                                .Cells("LecturaFinal").Value = NewCritica.LecturaFinal
                                .Cells("Estado").Value = NewCritica.Estado
                                .Cells("Cliente").Value = NewCritica.Suscriptor

                                'CA 200-856 - Nuevas Columnas
                                '---------------------------------------------------
                                If FilterDT.Columns.Contains("sort_id") Then
                                    If NewCritica.Sort_ID = 999999999 Then
                                        .Cells("sort_id").Value = String.Empty
                                    Else
                                        .Cells("sort_id").Value = NewCritica.Sort_ID
                                    End If
                                End If

                                If FilterDT.Columns.Contains("caupresa") Then
                                    .Cells("Causal1").Value = NewCritica.Causal1
                                End If

                                If FilterDT.Columns.Contains("caupresb") Then
                                    .Cells("Causal2").Value = NewCritica.Causal2
                                End If

                                If FilterDT.Columns.Contains("caupresc") Then
                                    .Cells("Causal3").Value = NewCritica.Causal3
                                End If
                                '---------------------------------------------------
                                'CA 200-1105
                                .Cells("dpto").Value = NewCritica.Dpto
                                .Cells("ano").Value = NewCritica.Ano
                                .Cells("mes").Value = NewCritica.Mes
                                .Cells("estado_corte").Value = NewCritica.Estado_corte
                                .Cells("estado_financiero").Value = NewCritica.Estado_financiero
                                .Cells("volFacturado").Value = NewCritica.VolFacturado
                                .Cells("fecha_legal").Value = NewCritica.Fecha_legal
                                .Cells("Usuario_lega").Value = NewCritica.Usuario_lega
                                .Cells("Impexcel").Value = NewCritica.Impexcel
                                .Cells("Terminal").Value = NewCritica.Terminal

                                'CA 200-1983
                                .Cells("Ufech_lect").Value = NewCritica.Ufech_lect

                                'CA 200-856 Nueva Regla: Cuando haya por lo menos una causal de No Lectura, en la Presion Final colocar 
                                'la Presion del Mes Anterior (Solo si la Critica no se )
                                '---------------------------------------------------
                                If String.IsNullOrEmpty(NewCritica.Fecha_legal) Then
                                    If FilterDT.Columns.Contains("caupresa") Or FilterDT.Columns.Contains("caupresb") Or FilterDT.Columns.Contains("caupresc") Then
                                        If Not (String.IsNullOrEmpty(NewCritica.Causal1) And String.IsNullOrEmpty(NewCritica.Causal2) And _
                                            String.IsNullOrEmpty(NewCritica.Causal3)) Then
                                            BoTraerPresionAnterior = True
                                            NewCritica.PresionFinal = Math.Round(NewCritica.PresionMesAnterior, 2)
                                            Row.Item("presfin") = NewCritica.PresionFinal
                                            .Cells("PresionFinal").Value = NewCritica.PresionFinal
                                        End If
                                    End If
                                End If
                                '---------------------------------------------------

                                'CA 200-1105 Nueva Regla: Cuando la Lectura sea 0-Cero, en la Columna Lectura Final colocar 
                                'la Lectura del Mes Anterior
                                '---------------------------------------------------

                                If FilterDT.Columns.Contains("LECTFIN") Then
                                    If String.IsNullOrEmpty(NewCritica.LecturaActual) Or NewCritica.LecturaActual <= 0 Then
                                        BoTraerLecturaAnterior = True
                                        NewCritica.LecturaFinal = Math.Round(NewCritica.LecturaAnterior, 2)
                                        Row.Item("lectfin") = NewCritica.LecturaFinal
                                        .Cells("LecturaFinal").Value = NewCritica.LecturaFinal
                                    End If
                                End If
                                '---------------------------------------------------
                                FilterDT.AcceptChanges()

                                'Se agrega la critica
                                ListCriticas.Add(NewCritica)

                            End With
                        End With
                    Next

                    Grid.Refresh()
                    'MsgBox(Grid.Rows.Count.ToString)
                    'Se convierte la lista de Criticas en un Objeto de Datos Dinamico
                    BS.DataSource = ListCriticas
                    BS = New BindingSource(ListCriticas, Nothing)
                Else
                    BS.DataSource = Nothing
                End If

            Catch ex As Exception
                RaiseMensaje("Error al cargar las lecturas para critica." + vbCrLf + "Detalle: " + ex.Message.ToString, 1000, MsgBoxStyle.Critical)
            End Try
            Return BS
        End Function

        ''' <summary>
        '''Carga las criticas Historicas en la grilla. Si el parametro CargardesdeBDD es true se consultan los datos nuevamente en el servidor sino se usa la informacion
        '''cargada en una Datatable Local haciendo un Refresh
        ''' </summary>
        ''' <param name="Grid"></param>
        ''' <param name="filter">El filtro es cargado por los ComboBox</param>
        ''' <param name="CargardesdeBDD">Indica si se deben buscar datos en la Base de Datos o en el Datatable Local</param>
        Public Function BL_CargarCriticaHistorica(ByRef Grid As DataGridView, Optional ByVal filter As String = "", Optional ByVal CargardesdeBDD As Boolean = False)
            Dim BoTraerLecturaAnterior As Boolean = False
            Dim BoTraerPresionAnterior As Boolean = False

            Try
                ListCriticaHistorica = New List(Of Critica)

                'Se deja de usar la tabla local y se carga la info desde la BDD
                If CargardesdeBDD = True Then
                    App.FlagCargarCriticasdesdeBDD = True
                End If

                'Establezco le BindingSource los Criticas
                BS = BL_GetListado("CriticaHistorica")

                'Desactivo el Flag de la carga desde BDD para seguir usando Datos desconectados
                App.FlagCargarCriticasdesdeBDD = False

                'Valido que hayan datos para procesar
                If App.DataTableCriticaHistorica.Rows.Count > 0 Then
                    Dim DT As DataTable = App.DataTableCriticaHistorica 'BS.DataSource
                    Dim FilterDT As New DataTable

                    '-------- Inicio Filtrado de Datos -----------
                    'Le aplico los filtros si se pasaron en los parametros

                    'Clono el Datatable Principal al Filtrado (Solo el Esquema) -Clear Rows
                    FilterDT.Load(DT.CreateDataReader)
                    FilterDT.Rows.Clear()
                    'Hago el filtro con el Dataview
                    Dim Dview As DataView = DT.DefaultView
                    Dview.RowFilter = FiltroCritHistorica.FiltroFinal
                    'Importo solo las filas filtradas
                    For i = 0 To Dview.Count - 1
                        FilterDT.ImportRow(Dview.Item(i).Row)
                    Next
                    '----------Fin Filtros ------------------------

                    '----------Borrado Rows del Grid --------------
                    App.FlagBorradoCellsGrid = True
                    If Not Grid.DataSource Is Nothing Then
                        Grid.DataSource = Nothing
                    End If
                    Grid.Rows.Clear()

                    App.FlagBorradoCellsGrid = False
                    '----------Fin Borrado Rows del Grid --------------

                    Grid.DataSource = Dview

                    Grid.Refresh()

                    Return BS

                Else
                    BS.DataSource = Nothing
                End If


            Catch ex As Exception
                RaiseMensaje("Error al cargar el Histórico de Criticas." + vbCrLf + "Detalle: " + ex.Message.ToString, 1000, MsgBoxStyle.Critical)
            End Try
            Return BS
        End Function

        Public Function GeneraCritica(ByRef osberror As String) As Boolean
            osberror = String.Empty
            Dim Resultado As Boolean = True

            Try
                If General.EstadoConexion = ConnectionState.Open Then
                    Resultado = DAL.GeneraCritica(osberror)
                Else
                    Throw New ApplicationException("Error de Conexion")
                End If
            Catch ex As Exception
                osberror += ex.Message
                osberror = "*** Inicio Generacion de Criticas | " + Date.Now + " ***" + vbCrLf + vbCrLf + osberror + vbCrLf + vbCrLf + "*** Fin Generacion de Criticas | " + Date.Now + " ***"
            End Try
            If Resultado = False Then
                osberror = "*** Inicio Generacion de Criticas | " + Date.Now + " ***" + vbCrLf + osberror + vbCrLf + "*** Fin Generacion de Criticas | " + Date.Now + " ***"
            End If
            Return Resultado
        End Function

        Public Function ProcesarCritica(ByRef Log As String) As Boolean
            Dim osbError As String = String.Empty
            Log = "Inicia Proceso de Critica/Legalizacion Ordenes" + " | Fecha: " + Date.Now.ToString + vbCrLf
            Dim Resultado As Boolean = True 'True>> Ejecutado Correctamente. False>> Error

            'Recorro los datos a procesar del DataTable de Critica Final
            For Each row As DataRow In App.DataTableActualizarCritica.Rows
                '***** Proceso la Critica (Legalizacion de la Orden) *****
                osbError = String.Empty
                'Importante: Orden de los parametros
                Resultado = DAL.ProcesarCritica(inucriticaid:=row("Critica_id"), inupresionfinal:=row("PresionFinal"), inulecturafinal:=row("LecturaFinal"), osberror:=osbError)

                'Resultado: True>> Ejecutado Correctamente. False>> Error
                If Resultado = True Then 'True>> Ejecutado Correctamente. False>> Error

                    'Actualizar la Presion en CM_VAVAFACO
                    'Resultado = DAL.ActualizarPresionFaco(inuproducto:=row("Producto"), inupresionact:=row("PresionFinal"), osberror:=osbError)

                    'Resultado: True>> Ejecutado Correctamente. False>> Error
                    'If Resultado = False Then
                    '    'Quita el Detalle del Error
                    '    If osbError.Contains("| DetalleError:") Then
                    '        osbError = QuitarDetalleError(osbError, "DetalleError:")
                    '    End If
                    '    osbError = "ActualizarVariablesProducto: " + row("Producto") + vbCrLf + osbError + vbCrLf
                    '    'Lleno el Log Principal para mostrar en la Forma
                    '    Log += osbError + vbCrLf
                    '    'Se restablece la variable de Error del Proceso en cada iteraccion
                    '    osbError = String.Empty
                    'End If
                Else
                    'Quita el Detalle del Error
                    If osbError.Contains("DetalleError:") Then
                        osbError = QuitarDetalleError(osbError, "DetalleError:")
                    End If
                    osbError = "ProcesarCritica - Producto: " + row("Producto") + ":" + vbCrLf + osbError + vbCrLf
                    'Lleno el Log Principal para mostrar en la Forma
                    Log += osbError + vbCrLf
                    'Se restablece la variable de Error del Proceso en cada iteraccion
                    osbError = String.Empty
                End If
            Next
            If Log <> "" Then
                Log += "Fin Proceso de Critica/Legalizacion Ordenes" + " | Fecha: " + Date.Now.ToString + vbCrLf
            End If

            Return Resultado
        End Function

        Public Function QuitarDetalleError(ByVal text As String, ByVal separador As String) As String
            Dim TextoError As String = text
            Dim PosicionInicio As Integer = TextoError.IndexOf(separador)
            Dim CantCaracteres As Integer = TextoError.Length - PosicionInicio
            Try
                TextoError = TextoError.Remove(PosicionInicio, CantCaracteres)
                'TextoError = TextoError.Replace(vbCrLf, "")
                TextoError = Replace(Replace(TextoError, Chr(10), ""), Chr(13), "")
            Catch ex As Exception
                TextoError = text
            End Try

            Return TextoError
        End Function

#End Region


#Region "Filas"

        Dim configXml As New XmlDocument
        Dim PathFileConfig As String, Path As String, MyUri As Uri, cadena As String
        Dim List As Object 'New SortedDictionary(Of Integer, Integer)

        Public Function ActOrdenamiento() As Boolean
            Dim BoOK As Boolean = True, onuerrorcode As Int64, osberror As String = String.Empty
            Try
                If cadena.Length = 0 Then
                    Throw New ApplicationException("El parametro de la funcion que actualiza el orden de los registros esta vacio." + vbCrLf + "Verificar que hayan registros en el Grid o que la conexion este activa.")
                End If
                Call DAL.ActOrdenamiento(cadena, onuerrorcode, osberror)
                If onuerrorcode = 0 And String.IsNullOrEmpty(osberror) Then
                    RaiseMensaje("Ordenamiento configurado correctamente!" + vbCrLf + "Los cambios se veran reflejados la proxima vez que inicie la forma.", 0, MsgBoxStyle.Information)
                Else
                    BoOK = False
                    Throw New ApplicationException("Errores al actualizar el Ordenamiento de los registros en la BDD" + vbCrLf + osberror)
                End If

            Catch ex As Exception
                RaiseMensaje(ex.Message, onuerrorcode, MsgBoxStyle.Exclamation)
            End Try
            Return BoOK
        End Function

        Public Sub GuardarOrdenFilas(ByVal Grid As DataGridView)
            'List = New SortedDictionary(Of Integer, Integer)
            cadena = String.Empty

            'PathFileConfig = Assembly.GetExecutingAssembly().Location
            PathFileConfig = Environment.CurrentDirectory
            PathFileConfig += "\LUDYCOM.LECTESP.dll.config"
            configXml = New XmlDocument
            'Creo la estructura basica del XML
            Me.CrearEstructuraConfig()

            Dim DT As New DataTable
            DT.Columns.Add("KEY")
            DT.Columns.Add("VALUE")

            For Each Row As DataGridViewRow In Grid.Rows
                'Se agregan productos sin duplicados
                Dim DTRows() As DataRow = DT.Select("VALUE=" + Row.Cells("Producto").Value.ToString)
                If DTRows.Length = 0 Then
                    If Not (IsDBNull(Row.Cells("sort_id").Value) Or Row.Cells("sort_id").Value Is Nothing) Then
                        DT.Rows.Add(Row.Cells("sort_id").Value, Row.Cells("Producto").Value)
                    End If
                End If
            Next

            'Obtengo las filas ordenadas
            Dim Rows As DataRow() = DT.Select("KEY>='0'", "KEY ASC")
            For Each Row As DataRow In Rows
                'Se arma la cadena para actualizar la Tabla de Criticas
                cadena += Row(1).ToString + "|"

                'Se agrega el item al XML
                Call EstablecerConfig("configuration/grid", Row(0).ToString, Row(1).ToString)
            Next

            'List = New SortedDictionary(Of Integer, Integer)

            'For Each Row As DataGridViewRow In Grid.Rows
            '    'Se agregan productos sin duplicados
            '    If Not List.ContainsValue(Row.Cells("Producto").Value) Then
            '        If IsDBNull(Row.Cells("sort_id").Value) Or Row.Cells("sort_id").Value Is Nothing Then
            '            List.Add(999999999, Row.Cells("Producto").Value)
            '        Else
            '            List.Add(Row.Cells("sort_id").Value, Row.Cells("Producto").Value)
            '        End If
            '    End If
            'Next

            'For Each kvp As KeyValuePair(Of Integer, Integer) In List

            '    'Se arma la cadena para actualizar la Tabla de Criticas
            '    cadena += kvp.Value.ToString + "|"

            '    'Se agrega el item al XML
            '    Call EstablecerConfig("configuration/grid", kvp.Key.ToString, kvp.Value.ToString)
            'Next

            'EstablecerConfig("configuration/grid", "1", "producto1")
            'EstablecerConfig("configuration/grid", "2", "Producto2")

            'Se formatea el archivo
            Dim XML As String = Me.PrettyXML(configXml.OuterXml)

            'Se crea/sobreescribe el archivo
            File.WriteAllText(PathFileConfig, XML)
        End Sub

        Private Sub EstablecerConfig(ByVal seccion As String, ByVal clave As String, ByVal valor As String)
            Dim BoOK As Boolean = True
            Dim n As XmlNode, n1 As XmlNode

            Try
                n = configXml.SelectSingleNode(seccion) '& "/add[@key=""" & clave & """]")
                While n Is Nothing
                    Call CrearEstructuraConfig()
                    n = configXml.SelectSingleNode(seccion) '& "/add[@key=""" & clave & """]")
                    If Not n Is Nothing Then
                        Exit While
                    End If
                End While

                n1 = configXml.CreateElement("item")
                'XMLAttrib = configXml.CreateAttribute("RowID")
                'XMLAttrib.Value = clave
                n1.Attributes.Append(configXml.CreateAttribute("RowID")).Value = clave
                n1.InnerText = valor
                'configXml.AppendChild(n1)
                'configXml.AppendChild(n1)
                n.AppendChild(n1)

            Catch ex As Exception

            End Try
        End Sub

        Public Sub CrearEstructuraConfig()

            Try
                'IO.File.Delete(PathFileConfig)
                configXml.CreateXmlDeclaration("1.0", String.Empty, "yes")
                Dim XMLNode As XmlElement = configXml.CreateElement("configuration")

                XMLNode.AppendChild(configXml.CreateElement("grid"))
                XMLNode.FirstChild.InnerText = String.Empty
                configXml.AppendChild(XMLNode.CloneNode(True))

            Catch ex As Exception

            End Try

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
            Xml = Xml.Replace("<?xml version=""1.0"" encoding=""utf-16""?>" + vbCrLf, String.Empty)

            Return Xml
        End Function

        Public Sub ResetRow(ByRef Grid As DataGridView, ByVal Row As DataGridViewRow) 'No utilizado.
            Dim RowIndex As Integer = Row.Index
            Dim ComboValorPrevio As String = Row.Cells(0).Value
            Dim MyRow As New DataGridViewRow
            MyRow = Row.Clone()
            Grid.Rows.Remove(Row)
            Grid.Rows.Insert(RowIndex, MyRow)
            Grid.Rows(RowIndex).Cells(0).Value = ComboValorPrevio
            Grid.Rows(RowIndex).Cells(0).Selected = True
        End Sub

        Public Function CheckContenidoMinimoFila(ByVal Row As DataGridViewRow, Optional ByRef ChkColValorEsNumerico As Boolean = False) As Boolean
            'Valida que el usuario haya completado todos los datos requeridos.
            Dim Resultado As Boolean = False
            With Row

                If IsNumeric(.Cells("Critica_id").Value) And IsNumeric(.Cells("Producto").Value) And IsNumeric(.Cells("LecturaFinal").Value) And IsNumeric(.Cells("PresionFinal").Value) Then
                    ChkColValorEsNumerico = True
                    Resultado = True
                Else
                    Resultado = False
                End If

            End With
            Return Resultado
        End Function
#End Region

#End Region

    End Class

End Namespace