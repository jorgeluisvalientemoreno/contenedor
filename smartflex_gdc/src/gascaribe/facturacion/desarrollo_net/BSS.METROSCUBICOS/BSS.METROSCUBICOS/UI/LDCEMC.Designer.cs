namespace BSS.METROSCUBICOS.UI
{
    partial class LDCEMC
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("Prometcub", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn1 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("selection");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn2 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("accion");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn3 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("observacion");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn4 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("periodo");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn5 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("anno");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn6 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("mes");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn7 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ciclo");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn8 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("contrato");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn9 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("producto");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn10 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("concepto");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn11 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("volliq");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn12 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("valliq");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn13 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("categoría");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn14 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("subcategoria");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn15 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("estado_producto");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn16 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("codigociclo");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn17 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("proceso");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn18 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("procesoCod");
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
            this.PBusqueda = new System.Windows.Forms.Panel();
            this.ulBusqueda = new Infragistics.Win.Misc.UltraLabel();
            this.RbGenCargos = new System.Windows.Forms.RadioButton();
            this.RbRevCargos = new System.Windows.Forms.RadioButton();
            this.bsPrometcub = new System.Windows.Forms.BindingSource(this.components);
            this.PBoton = new System.Windows.Forms.Panel();
            this.PbProcesar = new System.Windows.Forms.ProgressBar();
            this.BtnLimpiar = new System.Windows.Forms.Button();
            this.BtnCancelar = new System.Windows.Forms.Button();
            this.BtnProcesar = new System.Windows.Forms.Button();
            this.BtnBuscar = new System.Windows.Forms.Button();
            this.UgMetrosCubicos = new OpenSystems.Windows.Controls.OpenGrid();
            this.PBusqueda.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.bsPrometcub)).BeginInit();
            this.PBoton.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.UgMetrosCubicos)).BeginInit();
            this.SuspendLayout();
            // 
            // PBusqueda
            // 
            this.PBusqueda.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.PBusqueda.Controls.Add(this.ulBusqueda);
            this.PBusqueda.Controls.Add(this.RbGenCargos);
            this.PBusqueda.Controls.Add(this.RbRevCargos);
            this.PBusqueda.Dock = System.Windows.Forms.DockStyle.Top;
            this.PBusqueda.Location = new System.Drawing.Point(0, 0);
            this.PBusqueda.Name = "PBusqueda";
            this.PBusqueda.Size = new System.Drawing.Size(914, 29);
            this.PBusqueda.TabIndex = 5;
            // 
            // ulBusqueda
            // 
            appearance1.TextHAlign = Infragistics.Win.HAlign.Right;
            this.ulBusqueda.Appearance = appearance1;
            this.ulBusqueda.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ulBusqueda.Location = new System.Drawing.Point(7, 6);
            this.ulBusqueda.Name = "ulBusqueda";
            this.ulBusqueda.Size = new System.Drawing.Size(63, 17);
            this.ulBusqueda.TabIndex = 48;
            this.ulBusqueda.Text = "Busqueda:";
            // 
            // RbGenCargos
            // 
            this.RbGenCargos.AutoSize = true;
            this.RbGenCargos.Location = new System.Drawing.Point(241, 6);
            this.RbGenCargos.Name = "RbGenCargos";
            this.RbGenCargos.Size = new System.Drawing.Size(117, 17);
            this.RbGenCargos.TabIndex = 1;
            this.RbGenCargos.TabStop = true;
            this.RbGenCargos.Text = "Generar Cargos";
            this.RbGenCargos.UseVisualStyleBackColor = true;
            // 
            // RbRevCargos
            // 
            this.RbRevCargos.AutoSize = true;
            this.RbRevCargos.Location = new System.Drawing.Point(99, 6);
            this.RbRevCargos.Name = "RbRevCargos";
            this.RbRevCargos.Size = new System.Drawing.Size(122, 17);
            this.RbRevCargos.TabIndex = 0;
            this.RbRevCargos.TabStop = true;
            this.RbRevCargos.Text = "Reversar Cargos";
            this.RbRevCargos.UseVisualStyleBackColor = true;
            // 
            // bsPrometcub
            // 
            this.bsPrometcub.DataSource = typeof(BSS.METROSCUBICOS.Entities.Prometcub);
            // 
            // PBoton
            // 
            this.PBoton.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.PBoton.Controls.Add(this.PbProcesar);
            this.PBoton.Controls.Add(this.BtnLimpiar);
            this.PBoton.Controls.Add(this.BtnCancelar);
            this.PBoton.Controls.Add(this.BtnProcesar);
            this.PBoton.Controls.Add(this.BtnBuscar);
            this.PBoton.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.PBoton.Location = new System.Drawing.Point(0, 285);
            this.PBoton.Name = "PBoton";
            this.PBoton.Size = new System.Drawing.Size(914, 37);
            this.PBoton.TabIndex = 7;
            // 
            // PbProcesar
            // 
            this.PbProcesar.Location = new System.Drawing.Point(10, 7);
            this.PbProcesar.Name = "PbProcesar";
            this.PbProcesar.Size = new System.Drawing.Size(570, 23);
            this.PbProcesar.TabIndex = 7;
            // 
            // BtnLimpiar
            // 
            this.BtnLimpiar.Location = new System.Drawing.Point(750, 7);
            this.BtnLimpiar.Name = "BtnLimpiar";
            this.BtnLimpiar.Size = new System.Drawing.Size(75, 23);
            this.BtnLimpiar.TabIndex = 5;
            this.BtnLimpiar.Text = "&Limpiar";
            this.BtnLimpiar.UseVisualStyleBackColor = true;
            this.BtnLimpiar.Click += new System.EventHandler(this.BtnLimpiar_Click);
            // 
            // BtnCancelar
            // 
            this.BtnCancelar.Location = new System.Drawing.Point(828, 7);
            this.BtnCancelar.Name = "BtnCancelar";
            this.BtnCancelar.Size = new System.Drawing.Size(75, 23);
            this.BtnCancelar.TabIndex = 6;
            this.BtnCancelar.Text = "&Cancelar";
            this.BtnCancelar.UseVisualStyleBackColor = true;
            this.BtnCancelar.Click += new System.EventHandler(this.BtnCancelar_Click);
            // 
            // BtnProcesar
            // 
            this.BtnProcesar.Enabled = false;
            this.BtnProcesar.Location = new System.Drawing.Point(669, 7);
            this.BtnProcesar.Name = "BtnProcesar";
            this.BtnProcesar.Size = new System.Drawing.Size(75, 23);
            this.BtnProcesar.TabIndex = 4;
            this.BtnProcesar.Text = "&Procesar";
            this.BtnProcesar.UseVisualStyleBackColor = true;
            this.BtnProcesar.Click += new System.EventHandler(this.BtnProcesar_Click);
            // 
            // BtnBuscar
            // 
            this.BtnBuscar.Location = new System.Drawing.Point(588, 7);
            this.BtnBuscar.Name = "BtnBuscar";
            this.BtnBuscar.Size = new System.Drawing.Size(75, 23);
            this.BtnBuscar.TabIndex = 3;
            this.BtnBuscar.Text = "&Buscar";
            this.BtnBuscar.UseVisualStyleBackColor = true;
            this.BtnBuscar.Click += new System.EventHandler(this.BtnBuscar_Click);
            // 
            // UgMetrosCubicos
            // 
            this.UgMetrosCubicos.DataSource = this.bsPrometcub;
            appearance2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            appearance2.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            appearance2.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.UgMetrosCubicos.DisplayLayout.Appearance = appearance2;
            this.UgMetrosCubicos.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ExtendLastColumn;
            ultraGridColumn1.Header.Tag = System.Windows.Forms.CheckState.Unchecked;
            ultraGridColumn1.Header.VisiblePosition = 0;
            ultraGridColumn2.Header.VisiblePosition = 1;
            ultraGridColumn3.Header.VisiblePosition = 2;
            ultraGridColumn4.Header.VisiblePosition = 3;
            ultraGridColumn5.Header.VisiblePosition = 4;
            ultraGridColumn6.Header.VisiblePosition = 5;
            ultraGridColumn7.Header.VisiblePosition = 6;
            ultraGridColumn8.Header.VisiblePosition = 7;
            ultraGridColumn9.Header.VisiblePosition = 8;
            ultraGridColumn10.Header.VisiblePosition = 9;
            ultraGridColumn11.Header.VisiblePosition = 10;
            ultraGridColumn12.Header.VisiblePosition = 11;
            ultraGridColumn13.Header.VisiblePosition = 12;
            ultraGridColumn14.Header.VisiblePosition = 13;
            ultraGridColumn15.Header.VisiblePosition = 14;
            ultraGridColumn16.Header.VisiblePosition = 15;
            ultraGridColumn17.Header.VisiblePosition = 16;
            ultraGridColumn18.Header.VisiblePosition = 17;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn1,
            ultraGridColumn2,
            ultraGridColumn3,
            ultraGridColumn4,
            ultraGridColumn5,
            ultraGridColumn6,
            ultraGridColumn7,
            ultraGridColumn8,
            ultraGridColumn9,
            ultraGridColumn10,
            ultraGridColumn11,
            ultraGridColumn12,
            ultraGridColumn13,
            ultraGridColumn14,
            ultraGridColumn15,
            ultraGridColumn16,
            ultraGridColumn17,
            ultraGridColumn18});
            this.UgMetrosCubicos.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            this.UgMetrosCubicos.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.UgMetrosCubicos.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance3.BackColor = System.Drawing.SystemColors.Control;
            appearance3.BackColor2 = System.Drawing.SystemColors.Control;
            appearance3.BorderColor = System.Drawing.SystemColors.Window;
            this.UgMetrosCubicos.DisplayLayout.GroupByBox.Appearance = appearance3;
            appearance4.BackColor = System.Drawing.SystemColors.Control;
            appearance4.BackColor2 = System.Drawing.SystemColors.Control;
            appearance4.ForeColor = System.Drawing.Color.WhiteSmoke;
            this.UgMetrosCubicos.DisplayLayout.GroupByBox.BandLabelAppearance = appearance4;
            this.UgMetrosCubicos.DisplayLayout.GroupByBox.Prompt = "Arrastre una columna aquí para agrupar";
            appearance5.BackColor = System.Drawing.SystemColors.Control;
            appearance5.BackColor2 = System.Drawing.SystemColors.Control;
            appearance5.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance5.FontData.SizeInPoints = 8F;
            appearance5.ForeColor = System.Drawing.Color.Black;
            this.UgMetrosCubicos.DisplayLayout.GroupByBox.PromptAppearance = appearance5;
            this.UgMetrosCubicos.DisplayLayout.MaxColScrollRegions = 1;
            this.UgMetrosCubicos.DisplayLayout.MaxRowScrollRegions = 1;
            appearance6.BackColor = System.Drawing.SystemColors.Window;
            appearance6.ForeColor = System.Drawing.SystemColors.ControlText;
            this.UgMetrosCubicos.DisplayLayout.Override.ActiveCellAppearance = appearance6;
            appearance7.BackColor = System.Drawing.SystemColors.Highlight;
            appearance7.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.UgMetrosCubicos.DisplayLayout.Override.ActiveRowAppearance = appearance7;
            this.UgMetrosCubicos.DisplayLayout.Override.AllowRowFiltering = Infragistics.Win.DefaultableBoolean.True;
            this.UgMetrosCubicos.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.UgMetrosCubicos.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance8.BackColor = System.Drawing.SystemColors.Window;
            this.UgMetrosCubicos.DisplayLayout.Override.CardAreaAppearance = appearance8;
            appearance9.BorderColor = System.Drawing.Color.Silver;
            appearance9.FontData.BoldAsString = "False";
            appearance9.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.UgMetrosCubicos.DisplayLayout.Override.CellAppearance = appearance9;
            this.UgMetrosCubicos.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.UgMetrosCubicos.DisplayLayout.Override.CellPadding = 0;
            appearance10.BackColor = System.Drawing.SystemColors.Control;
            appearance10.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance10.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance10.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance10.BorderColor = System.Drawing.SystemColors.Window;
            this.UgMetrosCubicos.DisplayLayout.Override.GroupByRowAppearance = appearance10;
            appearance11.TextHAlign = Infragistics.Win.HAlign.Left;
            this.UgMetrosCubicos.DisplayLayout.Override.HeaderAppearance = appearance11;
            this.UgMetrosCubicos.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.UgMetrosCubicos.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.Standard;
            appearance12.BackColor = System.Drawing.SystemColors.Window;
            appearance12.BorderColor = System.Drawing.Color.Silver;
            this.UgMetrosCubicos.DisplayLayout.Override.RowAppearance = appearance12;
            this.UgMetrosCubicos.DisplayLayout.Override.RowFilterAction = Infragistics.Win.UltraWinGrid.RowFilterAction.AppearancesOnly;
            this.UgMetrosCubicos.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            this.UgMetrosCubicos.DisplayLayout.Override.RowSelectorStyle = Infragistics.Win.HeaderStyle.Standard;
            appearance13.BackColor = System.Drawing.SystemColors.ControlLight;
            this.UgMetrosCubicos.DisplayLayout.Override.TemplateAddRowAppearance = appearance13;
            this.UgMetrosCubicos.DisplayLayout.RowConnectorColor = System.Drawing.Color.Empty;
            this.UgMetrosCubicos.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.UgMetrosCubicos.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.UgMetrosCubicos.DisplayLayout.UseFixedHeaders = true;
            this.UgMetrosCubicos.DisplayLayout.ViewStyle = Infragistics.Win.UltraWinGrid.ViewStyle.SingleBand;
            this.UgMetrosCubicos.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.UgMetrosCubicos.Dock = System.Windows.Forms.DockStyle.Fill;
            this.UgMetrosCubicos.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.UgMetrosCubicos.Location = new System.Drawing.Point(0, 29);
            this.UgMetrosCubicos.Name = "UgMetrosCubicos";
            this.UgMetrosCubicos.Size = new System.Drawing.Size(914, 256);
            this.UgMetrosCubicos.TabIndex = 36;
            this.UgMetrosCubicos.Text = "openGrid1";
            this.UgMetrosCubicos.Error += new Infragistics.Win.UltraWinGrid.ErrorEventHandler(this.UgMetrosCubicos_Error);
            // 
            // LDCEMC
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(914, 322);
            this.Controls.Add(this.UgMetrosCubicos);
            this.Controls.Add(this.PBoton);
            this.Controls.Add(this.PBusqueda);
            this.Name = "LDCEMC";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "LDCEMC";
            this.Load += new System.EventHandler(this.LDCEMC_Load);
            this.PBusqueda.ResumeLayout(false);
            this.PBusqueda.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.bsPrometcub)).EndInit();
            this.PBoton.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.UgMetrosCubicos)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel PBusqueda;
        private System.Windows.Forms.Panel PBoton;
        private Infragistics.Win.Misc.UltraLabel ulBusqueda;
        private System.Windows.Forms.RadioButton RbGenCargos;
        private System.Windows.Forms.RadioButton RbRevCargos;
        private System.Windows.Forms.Button BtnCancelar;
        private System.Windows.Forms.Button BtnProcesar;
        private System.Windows.Forms.Button BtnBuscar;
        private System.Windows.Forms.BindingSource bsPrometcub;
        private System.Windows.Forms.Button BtnLimpiar;
        private System.Windows.Forms.ProgressBar PbProcesar;
        private OpenSystems.Windows.Controls.OpenGrid UgMetrosCubicos;
    }
}