namespace SINCECOMP.FNB.Controls
{
    partial class ctrlLDAPR
    {
        /// <summary> 
        /// Variable del diseñador requerida.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Limpiar los recursos que se estén utilizando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben eliminar; false en caso contrario, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de componentes

        /// <summary> 
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido del método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("PropLDAPR", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn1 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("PropertyId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn2 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Description");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn3 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CheckSave");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn4 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CheckModify");
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance4 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance5 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance6 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance7 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance8 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance9 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance10 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance11 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance12 = new Infragistics.Win.Appearance();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ctrlLDAPR));
            Infragistics.Win.Appearance appearance13 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance14 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance15 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance16 = new Infragistics.Win.Appearance();
            Infragistics.Win.UltraWinTabControl.UltraTab ultraTab1 = new Infragistics.Win.UltraWinTabControl.UltraTab();
            this.ultraTabPageControl3 = new Infragistics.Win.UltraWinTabControl.UltraTabPageControl();
            this.dgProperty = new Infragistics.Win.UltraWinGrid.UltraGrid();
            this.propLDAPRBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.openHeaderTitles1 = new OpenSystems.Windows.Controls.OpenHeaderTitles();
            this.bnNavigator = new System.Windows.Forms.BindingNavigator(this.components);
            this.toolStripLabel1 = new System.Windows.Forms.ToolStripLabel();
            this.toolStripButton3 = new System.Windows.Forms.ToolStripButton();
            this.toolStripButton4 = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.bindingNavigatorPositionItem = new System.Windows.Forms.ToolStripTextBox();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripButton5 = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorMoveLastItem = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
            this.bindingNavigatorAddItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorDeleteItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorSaveItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorSeparator3 = new System.Windows.Forms.ToolStripSeparator();
            this.bindingNavigatorFilterItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorSeparator4 = new System.Windows.Forms.ToolStripSeparator();
            this.bindingNavigatorHelp = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorPrintItem = new System.Windows.Forms.ToolStripButton();
            this.excel = new System.Windows.Forms.ToolStripSplitButton();
            this.importar = new System.Windows.Forms.ToolStripMenuItem();
            this.exportar = new System.Windows.Forms.ToolStripMenuItem();
            this.utcPriceList = new Infragistics.Win.UltraWinTabControl.UltraTabControl();
            this.ultraTabSharedControlsPage2 = new Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage();
            this.ultraTabPageControl3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgProperty)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.propLDAPRBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bnNavigator)).BeginInit();
            this.bnNavigator.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.utcPriceList)).BeginInit();
            this.utcPriceList.SuspendLayout();
            this.SuspendLayout();
            // 
            // ultraTabPageControl3
            // 
            this.ultraTabPageControl3.Controls.Add(this.dgProperty);
            this.ultraTabPageControl3.Location = new System.Drawing.Point(2, 21);
            this.ultraTabPageControl3.Name = "ultraTabPageControl3";
            this.ultraTabPageControl3.Size = new System.Drawing.Size(746, 318);
            // 
            // dgProperty
            // 
            this.dgProperty.DataSource = this.propLDAPRBindingSource;
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            appearance1.BorderColor = System.Drawing.Color.White;
            this.dgProperty.DisplayLayout.Appearance = appearance1;
            this.dgProperty.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ExtendLastColumn;
            ultraGridColumn1.Header.VisiblePosition = 0;
            ultraGridColumn2.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            ultraGridColumn2.Header.VisiblePosition = 1;
            ultraGridColumn3.Header.VisiblePosition = 2;
            ultraGridColumn4.Header.VisiblePosition = 3;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn1,
            ultraGridColumn2,
            ultraGridColumn3,
            ultraGridColumn4});
            this.dgProperty.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            this.dgProperty.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.dgProperty.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance2.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance2.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance2.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance2.BorderColor = System.Drawing.SystemColors.Window;
            this.dgProperty.DisplayLayout.GroupByBox.Appearance = appearance2;
            appearance3.ForeColor = System.Drawing.SystemColors.GrayText;
            this.dgProperty.DisplayLayout.GroupByBox.BandLabelAppearance = appearance3;
            this.dgProperty.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.dgProperty.DisplayLayout.GroupByBox.Hidden = true;
            appearance4.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance4.BackColor2 = System.Drawing.SystemColors.Control;
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance4.ForeColor = System.Drawing.SystemColors.GrayText;
            this.dgProperty.DisplayLayout.GroupByBox.PromptAppearance = appearance4;
            this.dgProperty.DisplayLayout.MaxColScrollRegions = 1;
            this.dgProperty.DisplayLayout.MaxRowScrollRegions = 1;
            appearance5.BackColor = System.Drawing.SystemColors.Window;
            appearance5.ForeColor = System.Drawing.SystemColors.ControlText;
            this.dgProperty.DisplayLayout.Override.ActiveCellAppearance = appearance5;
            appearance6.BackColor = System.Drawing.SystemColors.Highlight;
            appearance6.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.dgProperty.DisplayLayout.Override.ActiveRowAppearance = appearance6;
            this.dgProperty.DisplayLayout.Override.AllowRowFiltering = Infragistics.Win.DefaultableBoolean.True;
            this.dgProperty.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.dgProperty.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance7.BackColor = System.Drawing.SystemColors.Window;
            this.dgProperty.DisplayLayout.Override.CardAreaAppearance = appearance7;
            appearance8.BorderColor = System.Drawing.Color.Silver;
            appearance8.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.dgProperty.DisplayLayout.Override.CellAppearance = appearance8;
            this.dgProperty.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.dgProperty.DisplayLayout.Override.CellPadding = 0;
            appearance9.BackColor = System.Drawing.SystemColors.Control;
            appearance9.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance9.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance9.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance9.BorderColor = System.Drawing.SystemColors.Window;
            this.dgProperty.DisplayLayout.Override.GroupByRowAppearance = appearance9;
            appearance10.TextHAlign = Infragistics.Win.HAlign.Left;
            this.dgProperty.DisplayLayout.Override.HeaderAppearance = appearance10;
            this.dgProperty.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.dgProperty.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            appearance11.BackColor = System.Drawing.SystemColors.Window;
            appearance11.BorderColor = System.Drawing.Color.Silver;
            this.dgProperty.DisplayLayout.Override.RowAppearance = appearance11;
            this.dgProperty.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance12.BackColor = System.Drawing.SystemColors.ControlLight;
            this.dgProperty.DisplayLayout.Override.TemplateAddRowAppearance = appearance12;
            this.dgProperty.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.dgProperty.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.dgProperty.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.dgProperty.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgProperty.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dgProperty.Location = new System.Drawing.Point(0, 0);
            this.dgProperty.Name = "dgProperty";
            this.dgProperty.Size = new System.Drawing.Size(746, 318);
            this.dgProperty.TabIndex = 0;
            this.dgProperty.Text = "ultraGrid1";
            this.dgProperty.BeforeRowFilterChanged += new Infragistics.Win.UltraWinGrid.BeforeRowFilterChangedEventHandler(this.dgProperty_BeforeRowFilterChanged);
            this.dgProperty.Error += new Infragistics.Win.UltraWinGrid.ErrorEventHandler(this.dgProperty_Error);
            this.dgProperty.BeforeSortChange += new Infragistics.Win.UltraWinGrid.BeforeSortChangeEventHandler(this.dgProperty_BeforeSortChange);
            this.dgProperty.CellChange += new Infragistics.Win.UltraWinGrid.CellEventHandler(this.dgProperty_CellChange);
            // 
            // propLDAPRBindingSource
            // 
            this.propLDAPRBindingSource.DataSource = typeof(SINCECOMP.FNB.Entities.PropLDAPR);
            // 
            // openHeaderTitles1
            // 
            this.openHeaderTitles1.BackColor = System.Drawing.Color.White;
            this.openHeaderTitles1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openHeaderTitles1.HeaderProtectedFields = ((System.Collections.Generic.Dictionary<string, string>)(resources.GetObject("openHeaderTitles1.HeaderProtectedFields")));
            this.openHeaderTitles1.HeaderSubtitle1 = "Administración de Propiedades del artículo";
            this.openHeaderTitles1.HeaderTitle = "Administración de Propiedades del artículo";
            this.openHeaderTitles1.Location = new System.Drawing.Point(0, 0);
            this.openHeaderTitles1.MaxWidth = -1;
            this.openHeaderTitles1.Name = "openHeaderTitles1";
            this.openHeaderTitles1.ParsedHeaderSubtitle2 = "";
            this.openHeaderTitles1.RowInformationHeader = null;
            this.openHeaderTitles1.Size = new System.Drawing.Size(750, 54);
            this.openHeaderTitles1.TabIndex = 8;
            // 
            // bnNavigator
            // 
            this.bnNavigator.AddNewItem = null;
            this.bnNavigator.CountItem = this.toolStripLabel1;
            this.bnNavigator.DeleteItem = null;
            this.bnNavigator.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripButton3,
            this.toolStripButton4,
            this.toolStripSeparator1,
            this.bindingNavigatorPositionItem,
            this.toolStripLabel1,
            this.toolStripSeparator2,
            this.toolStripButton5,
            this.bindingNavigatorMoveLastItem,
            this.toolStripSeparator3,
            this.bindingNavigatorAddItem,
            this.bindingNavigatorDeleteItem,
            this.bindingNavigatorSaveItem,
            this.bindingNavigatorSeparator3,
            this.bindingNavigatorFilterItem,
            this.bindingNavigatorSeparator4,
            this.bindingNavigatorHelp,
            this.bindingNavigatorPrintItem,
            this.excel});
            this.bnNavigator.Location = new System.Drawing.Point(0, 54);
            this.bnNavigator.MoveFirstItem = this.toolStripButton3;
            this.bnNavigator.MoveLastItem = this.bindingNavigatorMoveLastItem;
            this.bnNavigator.MoveNextItem = this.toolStripButton5;
            this.bnNavigator.MovePreviousItem = this.toolStripButton4;
            this.bnNavigator.Name = "bnNavigator";
            this.bnNavigator.PositionItem = this.bindingNavigatorPositionItem;
            this.bnNavigator.Size = new System.Drawing.Size(750, 25);
            this.bnNavigator.TabIndex = 20;
            this.bnNavigator.Text = "bindingNavigator2";
            // 
            // toolStripLabel1
            // 
            this.toolStripLabel1.Name = "toolStripLabel1";
            this.toolStripLabel1.Size = new System.Drawing.Size(38, 22);
            this.toolStripLabel1.Text = "de {0}";
            this.toolStripLabel1.ToolTipText = "Número total de elementos";
            // 
            // toolStripButton3
            // 
            this.toolStripButton3.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripButton3.Image = ((System.Drawing.Image)(resources.GetObject("toolStripButton3.Image")));
            this.toolStripButton3.Name = "toolStripButton3";
            this.toolStripButton3.RightToLeftAutoMirrorImage = true;
            this.toolStripButton3.Size = new System.Drawing.Size(23, 22);
            this.toolStripButton3.Text = "Mover primero";
            // 
            // toolStripButton4
            // 
            this.toolStripButton4.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripButton4.Image = ((System.Drawing.Image)(resources.GetObject("toolStripButton4.Image")));
            this.toolStripButton4.Name = "toolStripButton4";
            this.toolStripButton4.RightToLeftAutoMirrorImage = true;
            this.toolStripButton4.Size = new System.Drawing.Size(23, 22);
            this.toolStripButton4.Text = "Mover anterior";
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(6, 25);
            // 
            // bindingNavigatorPositionItem
            // 
            this.bindingNavigatorPositionItem.AccessibleName = "Posición";
            this.bindingNavigatorPositionItem.AutoSize = false;
            this.bindingNavigatorPositionItem.Name = "bindingNavigatorPositionItem";
            this.bindingNavigatorPositionItem.ReadOnly = true;
            this.bindingNavigatorPositionItem.Size = new System.Drawing.Size(50, 23);
            this.bindingNavigatorPositionItem.Text = "0";
            this.bindingNavigatorPositionItem.ToolTipText = "Posición actual";
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(6, 25);
            // 
            // toolStripButton5
            // 
            this.toolStripButton5.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripButton5.Image = ((System.Drawing.Image)(resources.GetObject("toolStripButton5.Image")));
            this.toolStripButton5.Name = "toolStripButton5";
            this.toolStripButton5.RightToLeftAutoMirrorImage = true;
            this.toolStripButton5.Size = new System.Drawing.Size(23, 22);
            this.toolStripButton5.Text = "Mover siguiente";
            // 
            // bindingNavigatorMoveLastItem
            // 
            this.bindingNavigatorMoveLastItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorMoveLastItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMoveLastItem.Image")));
            this.bindingNavigatorMoveLastItem.Name = "bindingNavigatorMoveLastItem";
            this.bindingNavigatorMoveLastItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorMoveLastItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorMoveLastItem.Text = "Mover último";
            // 
            // toolStripSeparator3
            // 
            this.toolStripSeparator3.Name = "toolStripSeparator3";
            this.toolStripSeparator3.Size = new System.Drawing.Size(6, 25);
            // 
            // bindingNavigatorAddItem
            // 
            this.bindingNavigatorAddItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorAddItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorAddItem.Image")));
            this.bindingNavigatorAddItem.Name = "bindingNavigatorAddItem";
            this.bindingNavigatorAddItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorAddItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorAddItem.Text = "Agregar nuevo";
            this.bindingNavigatorAddItem.Click += new System.EventHandler(this.bindingNavigatorAddItem_Click);
            // 
            // bindingNavigatorDeleteItem
            // 
            this.bindingNavigatorDeleteItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorDeleteItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorDeleteItem.Image")));
            this.bindingNavigatorDeleteItem.Name = "bindingNavigatorDeleteItem";
            this.bindingNavigatorDeleteItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorDeleteItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorDeleteItem.Text = "Eliminar";
            this.bindingNavigatorDeleteItem.Click += new System.EventHandler(this.bindingNavigatorDeleteItem_Click);
            // 
            // bindingNavigatorSaveItem
            // 
            this.bindingNavigatorSaveItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorSaveItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorSaveItem.Image")));
            this.bindingNavigatorSaveItem.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.bindingNavigatorSaveItem.Name = "bindingNavigatorSaveItem";
            this.bindingNavigatorSaveItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorSaveItem.Text = "Salvar";
            this.bindingNavigatorSaveItem.Click += new System.EventHandler(this.bindingNavigatorSaveItem_Click);
            // 
            // bindingNavigatorSeparator3
            // 
            this.bindingNavigatorSeparator3.Name = "bindingNavigatorSeparator3";
            this.bindingNavigatorSeparator3.Size = new System.Drawing.Size(6, 25);
            this.bindingNavigatorSeparator3.Visible = false;
            // 
            // bindingNavigatorFilterItem
            // 
            this.bindingNavigatorFilterItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorFilterItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorFilterItem.Image")));
            this.bindingNavigatorFilterItem.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.bindingNavigatorFilterItem.Name = "bindingNavigatorFilterItem";
            this.bindingNavigatorFilterItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorFilterItem.Text = "Filtrar";
            this.bindingNavigatorFilterItem.Visible = false;
            // 
            // bindingNavigatorSeparator4
            // 
            this.bindingNavigatorSeparator4.Name = "bindingNavigatorSeparator4";
            this.bindingNavigatorSeparator4.Size = new System.Drawing.Size(6, 25);
            this.bindingNavigatorSeparator4.Visible = false;
            // 
            // bindingNavigatorHelp
            // 
            this.bindingNavigatorHelp.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorHelp.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorHelp.Image")));
            this.bindingNavigatorHelp.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.bindingNavigatorHelp.Name = "bindingNavigatorHelp";
            this.bindingNavigatorHelp.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorHelp.Text = "Ayuda";
            this.bindingNavigatorHelp.Visible = false;
            // 
            // bindingNavigatorPrintItem
            // 
            this.bindingNavigatorPrintItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorPrintItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorPrintItem.Image")));
            this.bindingNavigatorPrintItem.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.bindingNavigatorPrintItem.Name = "bindingNavigatorPrintItem";
            this.bindingNavigatorPrintItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorPrintItem.Text = "Imprimir";
            this.bindingNavigatorPrintItem.Click += new System.EventHandler(this.bindingNavigatorPrintItem_Click);
            // 
            // excel
            // 
            this.excel.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.excel.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.importar,
            this.exportar});
            this.excel.Image = ((System.Drawing.Image)(resources.GetObject("excel.Image")));
            this.excel.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.excel.Name = "excel";
            this.excel.Size = new System.Drawing.Size(32, 22);
            this.excel.Text = "toolStripSplitButton1";
            this.excel.ToolTipText = "Excel";
            // 
            // importar
            // 
            this.importar.Enabled = false;
            this.importar.Name = "importar";
            this.importar.Size = new System.Drawing.Size(237, 22);
            this.importar.Text = "Importar desde libro de Excel...";
            this.importar.Click += new System.EventHandler(this.importar_Click);
            // 
            // exportar
            // 
            this.exportar.Name = "exportar";
            this.exportar.Size = new System.Drawing.Size(237, 22);
            this.exportar.Text = "Exportar a libro de Excel...";
            this.exportar.Click += new System.EventHandler(this.exportar_Click);
            // 
            // utcPriceList
            // 
            appearance13.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(128)))), ((int)(((byte)(0)))));
            appearance13.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(247)))), ((int)(((byte)(166)))), ((int)(((byte)(99)))));
            appearance13.BackGradientStyle = Infragistics.Win.GradientStyle.BackwardDiagonal;
            appearance13.BorderColor3DBase = System.Drawing.Color.Blue;
            this.utcPriceList.ActiveTabAppearance = appearance13;
            appearance14.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(233)))), ((int)(((byte)(230)))), ((int)(((byte)(255)))));
            appearance14.BackColor2 = System.Drawing.Color.White;
            appearance14.BackGradientStyle = Infragistics.Win.GradientStyle.BackwardDiagonal;
            appearance14.BorderColor3DBase = System.Drawing.Color.Blue;
            this.utcPriceList.Appearance = appearance14;
            appearance15.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            appearance15.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            appearance15.BorderColor = System.Drawing.Color.Blue;
            this.utcPriceList.ClientAreaAppearance = appearance15;
            this.utcPriceList.Controls.Add(this.ultraTabSharedControlsPage2);
            this.utcPriceList.Controls.Add(this.ultraTabPageControl3);
            this.utcPriceList.Dock = System.Windows.Forms.DockStyle.Fill;
            this.utcPriceList.Location = new System.Drawing.Point(0, 79);
            this.utcPriceList.Name = "utcPriceList";
            appearance16.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(252)))), ((int)(((byte)(139)))), ((int)(((byte)(29)))));
            appearance16.BackGradientStyle = Infragistics.Win.GradientStyle.BackwardDiagonal;
            this.utcPriceList.SelectedTabAppearance = appearance16;
            this.utcPriceList.SharedControlsPage = this.ultraTabSharedControlsPage2;
            this.utcPriceList.Size = new System.Drawing.Size(750, 341);
            this.utcPriceList.Style = Infragistics.Win.UltraWinTabControl.UltraTabControlStyle.PropertyPage2003;
            this.utcPriceList.TabIndex = 21;
            ultraTab1.TabPage = this.ultraTabPageControl3;
            ultraTab1.Text = "Propiedades del artículo";
            this.utcPriceList.Tabs.AddRange(new Infragistics.Win.UltraWinTabControl.UltraTab[] {
            ultraTab1});
            this.utcPriceList.ViewStyle = Infragistics.Win.UltraWinTabControl.ViewStyle.Office2003;
            // 
            // ultraTabSharedControlsPage2
            // 
            this.ultraTabSharedControlsPage2.Location = new System.Drawing.Point(-10000, -10000);
            this.ultraTabSharedControlsPage2.Name = "ultraTabSharedControlsPage2";
            this.ultraTabSharedControlsPage2.Size = new System.Drawing.Size(746, 318);
            // 
            // ctrlLDAPR
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.Controls.Add(this.utcPriceList);
            this.Controls.Add(this.bnNavigator);
            this.Controls.Add(this.openHeaderTitles1);
            this.Name = "ctrlLDAPR";
            this.Size = new System.Drawing.Size(750, 420);
            this.ultraTabPageControl3.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgProperty)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.propLDAPRBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bnNavigator)).EndInit();
            this.bnNavigator.ResumeLayout(false);
            this.bnNavigator.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.utcPriceList)).EndInit();
            this.utcPriceList.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private OpenSystems.Windows.Controls.OpenHeaderTitles openHeaderTitles1;
        private System.Windows.Forms.BindingNavigator bnNavigator;
        private System.Windows.Forms.ToolStripButton bindingNavigatorAddItem;
        private System.Windows.Forms.ToolStripLabel toolStripLabel1;
        private System.Windows.Forms.ToolStripButton bindingNavigatorDeleteItem;
        private System.Windows.Forms.ToolStripButton toolStripButton3;
        private System.Windows.Forms.ToolStripButton toolStripButton4;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripTextBox bindingNavigatorPositionItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripButton toolStripButton5;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMoveLastItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
        private System.Windows.Forms.ToolStripButton bindingNavigatorSaveItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator3;
        private System.Windows.Forms.ToolStripButton bindingNavigatorFilterItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator4;
        private System.Windows.Forms.ToolStripButton bindingNavigatorHelp;
        private Infragistics.Win.UltraWinTabControl.UltraTabControl utcPriceList;
        private Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage ultraTabSharedControlsPage2;
        private Infragistics.Win.UltraWinTabControl.UltraTabPageControl ultraTabPageControl3;
        private Infragistics.Win.UltraWinGrid.UltraGrid dgProperty;
        private System.Windows.Forms.BindingSource propLDAPRBindingSource;
        private System.Windows.Forms.ToolStripButton bindingNavigatorPrintItem;
        private System.Windows.Forms.ToolStripSplitButton excel;
        private System.Windows.Forms.ToolStripMenuItem importar;
        private System.Windows.Forms.ToolStripMenuItem exportar;
    }
}
