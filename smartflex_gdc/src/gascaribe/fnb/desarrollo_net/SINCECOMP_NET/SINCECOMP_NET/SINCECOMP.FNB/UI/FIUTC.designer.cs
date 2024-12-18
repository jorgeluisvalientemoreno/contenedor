namespace SINCECOMP.FNB.UI
{
    partial class FIUTC
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

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido del método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FIUTC));
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("TransferQuota", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn1 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TransferId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn2 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("SubscriptionId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn3 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("SubscriberName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn4 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("AvalibleQuota");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn5 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TransferQuotaValue");
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
            Infragistics.Win.Appearance appearance13 = new Infragistics.Win.Appearance();
            this.openHeaderTitles1 = new OpenSystems.Windows.Controls.OpenHeaderTitles();
            this.ostbRequestObservation = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.ultraGroupBox1 = new Infragistics.Win.Misc.UltraGroupBox();
            this.openButton1 = new OpenSystems.Windows.Controls.OpenButton();
            this.ugTransfer = new Infragistics.Win.UltraWinGrid.UltraGrid();
            this.transferQuotaBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.bindingNavigatorMoveFirstItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorMovePreviousItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorSeparator = new System.Windows.Forms.ToolStripSeparator();
            this.bindingNavigatorPositionItem = new System.Windows.Forms.ToolStripTextBox();
            this.bindingNavigatorCountItem = new System.Windows.Forms.ToolStripLabel();
            this.bindingNavigatorSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.bindingNavigatorMoveNextItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorMoveLastItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.bindingNavigatorAddNewItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorDeleteItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigator1 = new System.Windows.Forms.BindingNavigator(this.components);
            this.ostPendTransfer = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.ostbTransfer = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.ostbForTransfer = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).BeginInit();
            this.ultraGroupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugTransfer)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.transferQuotaBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bindingNavigator1)).BeginInit();
            this.bindingNavigator1.SuspendLayout();
            this.SuspendLayout();
            // 
            // openHeaderTitles1
            // 
            this.openHeaderTitles1.BackColor = System.Drawing.Color.White;
            this.openHeaderTitles1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openHeaderTitles1.HeaderProtectedFields = ((System.Collections.Generic.Dictionary<string, string>)(resources.GetObject("openHeaderTitles1.HeaderProtectedFields")));
            this.openHeaderTitles1.HeaderTitle = "Solicitud de Unión/Traslado de Cupos";
            this.openHeaderTitles1.Location = new System.Drawing.Point(0, 0);
            this.openHeaderTitles1.MaxWidth = -1;
            this.openHeaderTitles1.Name = "openHeaderTitles1";
            this.openHeaderTitles1.ParsedHeaderSubtitle2 = "";
            this.openHeaderTitles1.RowInformationHeader = null;
            this.openHeaderTitles1.Size = new System.Drawing.Size(930, 52);
            this.openHeaderTitles1.TabIndex = 0;
            // 
            // ostbRequestObservation
            // 
            this.ostbRequestObservation.Caption = "Observación";
            this.ostbRequestObservation.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ostbRequestObservation.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.ostbRequestObservation.Multiline = true;
            this.ostbRequestObservation.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.ostbRequestObservation.Length = null;
            this.ostbRequestObservation.TextBoxValue = "";
            this.ostbRequestObservation.Location = new System.Drawing.Point(429, 253);
            this.ostbRequestObservation.Name = "ostbRequestObservation";
            this.ostbRequestObservation.Size = new System.Drawing.Size(483, 72);
            this.ostbRequestObservation.TabIndex = 4;
            // 
            // ultraGroupBox1
            // 
            this.ultraGroupBox1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(122)))), ((int)(((byte)(150)))), ((int)(((byte)(223)))));
            this.ultraGroupBox1.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None;
            this.ultraGroupBox1.Controls.Add(this.openButton1);
            this.ultraGroupBox1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.ultraGroupBox1.Location = new System.Drawing.Point(0, 330);
            this.ultraGroupBox1.Name = "ultraGroupBox1";
            this.ultraGroupBox1.Size = new System.Drawing.Size(930, 28);
            this.ultraGroupBox1.SupportThemes = false;
            this.ultraGroupBox1.TabIndex = 6;
            // 
            // openButton1
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.openButton1.Appearance = appearance1;
            this.openButton1.Dock = System.Windows.Forms.DockStyle.Right;
            this.openButton1.Location = new System.Drawing.Point(849, 2);
            this.openButton1.Name = "openButton1";
            this.openButton1.Size = new System.Drawing.Size(80, 25);
            this.openButton1.TabIndex = 0;
            this.openButton1.Text = "&Aceptar";
            this.openButton1.Click += new System.EventHandler(this.openButton1_Click);
            // 
            // ugTransfer
            // 
            this.ugTransfer.DataSource = this.transferQuotaBindingSource;
            appearance2.BackColor = System.Drawing.Color.Transparent;
            appearance2.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.ugTransfer.DisplayLayout.Appearance = appearance2;
            ultraGridColumn1.Header.VisiblePosition = 0;
            ultraGridColumn1.Width = 137;
            ultraGridColumn2.Header.VisiblePosition = 1;
            ultraGridColumn2.Nullable = Infragistics.Win.UltraWinGrid.Nullable.Disallow;
            ultraGridColumn3.Header.VisiblePosition = 2;
            ultraGridColumn3.Width = 223;
            ultraGridColumn4.Header.VisiblePosition = 3;
            ultraGridColumn4.Width = 179;
            ultraGridColumn5.Header.VisiblePosition = 4;
            ultraGridColumn5.Width = 305;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn1,
            ultraGridColumn2,
            ultraGridColumn3,
            ultraGridColumn4,
            ultraGridColumn5});
            this.ugTransfer.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            this.ugTransfer.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.ugTransfer.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance3.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance3.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance3.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance3.BorderColor = System.Drawing.SystemColors.Window;
            this.ugTransfer.DisplayLayout.GroupByBox.Appearance = appearance3;
            appearance4.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugTransfer.DisplayLayout.GroupByBox.BandLabelAppearance = appearance4;
            this.ugTransfer.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.ugTransfer.DisplayLayout.GroupByBox.Hidden = true;
            appearance5.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance5.BackColor2 = System.Drawing.SystemColors.Control;
            appearance5.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance5.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugTransfer.DisplayLayout.GroupByBox.PromptAppearance = appearance5;
            this.ugTransfer.DisplayLayout.MaxColScrollRegions = 1;
            this.ugTransfer.DisplayLayout.MaxRowScrollRegions = 1;
            appearance6.BackColor = System.Drawing.SystemColors.Window;
            appearance6.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ugTransfer.DisplayLayout.Override.ActiveCellAppearance = appearance6;
            appearance7.BackColor = System.Drawing.SystemColors.Highlight;
            appearance7.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ugTransfer.DisplayLayout.Override.ActiveRowAppearance = appearance7;
            this.ugTransfer.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ugTransfer.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance8.BackColor = System.Drawing.SystemColors.Window;
            this.ugTransfer.DisplayLayout.Override.CardAreaAppearance = appearance8;
            appearance9.BorderColor = System.Drawing.Color.Silver;
            appearance9.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ugTransfer.DisplayLayout.Override.CellAppearance = appearance9;
            this.ugTransfer.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ugTransfer.DisplayLayout.Override.CellPadding = 0;
            appearance10.BackColor = System.Drawing.SystemColors.Control;
            appearance10.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance10.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance10.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance10.BorderColor = System.Drawing.SystemColors.Window;
            this.ugTransfer.DisplayLayout.Override.GroupByRowAppearance = appearance10;
            appearance11.TextHAlign = Infragistics.Win.HAlign.Left;
            this.ugTransfer.DisplayLayout.Override.HeaderAppearance = appearance11;
            this.ugTransfer.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ugTransfer.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            appearance12.BackColor = System.Drawing.SystemColors.Window;
            appearance12.BorderColor = System.Drawing.Color.Silver;
            this.ugTransfer.DisplayLayout.Override.RowAppearance = appearance12;
            this.ugTransfer.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance13.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ugTransfer.DisplayLayout.Override.TemplateAddRowAppearance = appearance13;
            this.ugTransfer.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugTransfer.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugTransfer.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ugTransfer.Dock = System.Windows.Forms.DockStyle.Top;
            this.ugTransfer.Location = new System.Drawing.Point(0, 77);
            this.ugTransfer.Name = "ugTransfer";
            this.ugTransfer.Size = new System.Drawing.Size(930, 152);
            this.ugTransfer.TabIndex = 29;
            this.ugTransfer.Text = "ultraGrid1";
            this.ugTransfer.AfterCellUpdate += new Infragistics.Win.UltraWinGrid.CellEventHandler(this.ugTransfer_AfterCellUpdate);
            this.ugTransfer.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugTransfer_InitializeLayout_1);
            this.ugTransfer.AfterRowsDeleted += new System.EventHandler(this.ugTransfer_AfterRowsDeleted);
            this.ugTransfer.BeforeRowsDeleted += new Infragistics.Win.UltraWinGrid.BeforeRowsDeletedEventHandler(this.ugTransfer_BeforeRowsDeleted);
            this.ugTransfer.Error += new Infragistics.Win.UltraWinGrid.ErrorEventHandler(this.ugTransfer_Error);
            this.ugTransfer.Validated += new System.EventHandler(this.ugTransfer_Validated);
            // 
            // transferQuotaBindingSource
            // 
            this.transferQuotaBindingSource.AllowNew = true;
            this.transferQuotaBindingSource.DataSource = typeof(SINCECOMP.FNB.Entities.TransferQuota);
            this.transferQuotaBindingSource.ListChanged += new System.ComponentModel.ListChangedEventHandler(this.transferQuotaBindingSource_ListChanged);
            // 
            // bindingNavigatorMoveFirstItem
            // 
            this.bindingNavigatorMoveFirstItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorMoveFirstItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMoveFirstItem.Image")));
            this.bindingNavigatorMoveFirstItem.Name = "bindingNavigatorMoveFirstItem";
            this.bindingNavigatorMoveFirstItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorMoveFirstItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorMoveFirstItem.Text = "Mover primero";
            // 
            // bindingNavigatorMovePreviousItem
            // 
            this.bindingNavigatorMovePreviousItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorMovePreviousItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMovePreviousItem.Image")));
            this.bindingNavigatorMovePreviousItem.Name = "bindingNavigatorMovePreviousItem";
            this.bindingNavigatorMovePreviousItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorMovePreviousItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorMovePreviousItem.Text = "Mover anterior";
            // 
            // bindingNavigatorSeparator
            // 
            this.bindingNavigatorSeparator.Name = "bindingNavigatorSeparator";
            this.bindingNavigatorSeparator.Size = new System.Drawing.Size(6, 25);
            // 
            // bindingNavigatorPositionItem
            // 
            this.bindingNavigatorPositionItem.AccessibleName = "Posición";
            this.bindingNavigatorPositionItem.AutoSize = false;
            this.bindingNavigatorPositionItem.Name = "bindingNavigatorPositionItem";
            this.bindingNavigatorPositionItem.Size = new System.Drawing.Size(50, 21);
            this.bindingNavigatorPositionItem.Text = "0";
            this.bindingNavigatorPositionItem.ToolTipText = "Posición actual";
            // 
            // bindingNavigatorCountItem
            // 
            this.bindingNavigatorCountItem.Name = "bindingNavigatorCountItem";
            this.bindingNavigatorCountItem.Size = new System.Drawing.Size(35, 22);
            this.bindingNavigatorCountItem.Text = "of {0}";
            this.bindingNavigatorCountItem.ToolTipText = "Número total de elementos";
            // 
            // bindingNavigatorSeparator1
            // 
            this.bindingNavigatorSeparator1.Name = "bindingNavigatorSeparator1";
            this.bindingNavigatorSeparator1.Size = new System.Drawing.Size(6, 25);
            // 
            // bindingNavigatorMoveNextItem
            // 
            this.bindingNavigatorMoveNextItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorMoveNextItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMoveNextItem.Image")));
            this.bindingNavigatorMoveNextItem.Name = "bindingNavigatorMoveNextItem";
            this.bindingNavigatorMoveNextItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorMoveNextItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorMoveNextItem.Text = "Mover siguiente";
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
            // bindingNavigatorSeparator2
            // 
            this.bindingNavigatorSeparator2.Name = "bindingNavigatorSeparator2";
            this.bindingNavigatorSeparator2.Size = new System.Drawing.Size(6, 25);
            // 
            // bindingNavigatorAddNewItem
            // 
            this.bindingNavigatorAddNewItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorAddNewItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorAddNewItem.Image")));
            this.bindingNavigatorAddNewItem.Name = "bindingNavigatorAddNewItem";
            this.bindingNavigatorAddNewItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorAddNewItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorAddNewItem.Text = "Agregar nuevo";
            this.bindingNavigatorAddNewItem.Click += new System.EventHandler(this.bindingNavigatorAddNewItem_Click);
            // 
            // bindingNavigatorDeleteItem
            // 
            this.bindingNavigatorDeleteItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorDeleteItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorDeleteItem.Image")));
            this.bindingNavigatorDeleteItem.Name = "bindingNavigatorDeleteItem";
            this.bindingNavigatorDeleteItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorDeleteItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorDeleteItem.Text = "Eliminar";
            // 
            // bindingNavigator1
            // 
            this.bindingNavigator1.AddNewItem = null;
            this.bindingNavigator1.BindingSource = this.transferQuotaBindingSource;
            this.bindingNavigator1.CountItem = this.bindingNavigatorCountItem;
            this.bindingNavigator1.DeleteItem = this.bindingNavigatorDeleteItem;
            this.bindingNavigator1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.bindingNavigatorMoveFirstItem,
            this.bindingNavigatorMovePreviousItem,
            this.bindingNavigatorSeparator,
            this.bindingNavigatorPositionItem,
            this.bindingNavigatorCountItem,
            this.bindingNavigatorSeparator1,
            this.bindingNavigatorMoveNextItem,
            this.bindingNavigatorMoveLastItem,
            this.bindingNavigatorSeparator2,
            this.bindingNavigatorAddNewItem,
            this.bindingNavigatorDeleteItem});
            this.bindingNavigator1.Location = new System.Drawing.Point(0, 52);
            this.bindingNavigator1.MoveFirstItem = this.bindingNavigatorMoveFirstItem;
            this.bindingNavigator1.MoveLastItem = this.bindingNavigatorMoveLastItem;
            this.bindingNavigator1.MoveNextItem = this.bindingNavigatorMoveNextItem;
            this.bindingNavigator1.MovePreviousItem = this.bindingNavigatorMovePreviousItem;
            this.bindingNavigator1.Name = "bindingNavigator1";
            this.bindingNavigator1.PositionItem = this.bindingNavigatorPositionItem;
            this.bindingNavigator1.Size = new System.Drawing.Size(930, 25);
            this.bindingNavigator1.TabIndex = 31;
            this.bindingNavigator1.Text = "bindingNavigator1";
            // 
            // ostPendTransfer
            // 
            this.ostPendTransfer.TypeBox = OpenSystems.Windows.Controls.TypesBox.Currency;
            this.ostPendTransfer.Caption = "Pendiente de Traslado";
            this.ostPendTransfer.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ostPendTransfer.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.ostPendTransfer.ReadOnly = true;
            this.ostPendTransfer.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Double;
            this.ostPendTransfer.NumberComposition = new OpenSystems.Windows.Controls.Number(15, 2);
            this.ostPendTransfer.Length = null;
            this.ostPendTransfer.TextBoxObjectValue = 0;
            this.ostPendTransfer.TextBoxValue = "0";
            this.ostPendTransfer.Location = new System.Drawing.Point(166, 253);
            this.ostPendTransfer.Name = "ostPendTransfer";
            this.ostPendTransfer.Size = new System.Drawing.Size(143, 20);
            this.ostPendTransfer.TabIndex = 33;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(16, 253);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(0, 13);
            this.label1.TabIndex = 35;
            // 
            // ostbTransfer
            // 
            this.ostbTransfer.TypeBox = OpenSystems.Windows.Controls.TypesBox.Currency;
            this.ostbTransfer.Caption = "Total a Trasladar";
            this.ostbTransfer.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ostbTransfer.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.ostbTransfer.ReadOnly = true;
            this.ostbTransfer.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Double;
            this.ostbTransfer.NumberComposition = new OpenSystems.Windows.Controls.Number(15, 2);
            this.ostbTransfer.Length = null;
            this.ostbTransfer.TextBoxObjectValue = 0;
            this.ostbTransfer.TextBoxValue = "0";
            this.ostbTransfer.Location = new System.Drawing.Point(166, 305);
            this.ostbTransfer.Name = "ostbTransfer";
            this.ostbTransfer.Size = new System.Drawing.Size(143, 20);
            this.ostbTransfer.TabIndex = 38;
            // 
            // ostbForTransfer
            // 
            this.ostbForTransfer.TypeBox = OpenSystems.Windows.Controls.TypesBox.Currency;
            this.ostbForTransfer.Caption = "Por Trasladar";
            this.ostbForTransfer.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ostbForTransfer.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.ostbForTransfer.ReadOnly = true;
            this.ostbForTransfer.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Double;
            this.ostbForTransfer.NumberComposition = new OpenSystems.Windows.Controls.Number(15, 2);
            this.ostbForTransfer.Length = null;
            this.ostbForTransfer.TextBoxObjectValue = 0;
            this.ostbForTransfer.TextBoxValue = "0";
            this.ostbForTransfer.Location = new System.Drawing.Point(166, 279);
            this.ostbForTransfer.Name = "ostbForTransfer";
            this.ostbForTransfer.Size = new System.Drawing.Size(143, 20);
            this.ostbForTransfer.TabIndex = 43;
            // 
            // FIUTC
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(930, 358);
            this.Controls.Add(this.ostbForTransfer);
            this.Controls.Add(this.ostbTransfer);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.ostPendTransfer);
            this.Controls.Add(this.ugTransfer);
            this.Controls.Add(this.bindingNavigator1);
            this.Controls.Add(this.ultraGroupBox1);
            this.Controls.Add(this.ostbRequestObservation);
            this.Controls.Add(this.openHeaderTitles1);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(946, 396);
            this.MinimumSize = new System.Drawing.Size(946, 396);
            this.Name = "FIUTC";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Solicitud de Unión/Traslado de Cupos (FIUTC)";
            this.Load += new System.EventHandler(this.FIUTC_Load);
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).EndInit();
            this.ultraGroupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.ugTransfer)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.transferQuotaBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bindingNavigator1)).EndInit();
            this.bindingNavigator1.ResumeLayout(false);
            this.bindingNavigator1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }        

        #endregion

        private OpenSystems.Windows.Controls.OpenHeaderTitles openHeaderTitles1;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox ostbRequestObservation;
        private Infragistics.Win.Misc.UltraGroupBox ultraGroupBox1;
        private OpenSystems.Windows.Controls.OpenButton openButton1;
        private Infragistics.Win.UltraWinGrid.UltraGrid ugTransfer;
        private System.Windows.Forms.BindingSource transferQuotaBindingSource;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMoveFirstItem;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMovePreviousItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator;
        private System.Windows.Forms.ToolStripTextBox bindingNavigatorPositionItem;
        private System.Windows.Forms.ToolStripLabel bindingNavigatorCountItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator1;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMoveNextItem;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMoveLastItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator2;
        private System.Windows.Forms.ToolStripButton bindingNavigatorAddNewItem;
        private System.Windows.Forms.ToolStripButton bindingNavigatorDeleteItem;
        public System.Windows.Forms.BindingNavigator bindingNavigator1;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox ostPendTransfer;
        private System.Windows.Forms.Label label1;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox ostbTransfer;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox ostbForTransfer;
    }
}