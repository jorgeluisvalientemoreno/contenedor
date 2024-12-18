namespace SINCECOMP.FNB.UI
{
    partial class LDIBO
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
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LDIBO));
            this.openTitle1 = new OpenSystems.Windows.Controls.OpenTitle();
            this.opPanel = new System.Windows.Forms.Panel();
            this.btnCancel = new OpenSystems.Windows.Controls.OpenButton();
            this.btnGenerar = new OpenSystems.Windows.Controls.OpenButton();
            this.openHeaderTitles1 = new OpenSystems.Windows.Controls.OpenHeaderTitles();
            this.panel1 = new System.Windows.Forms.Panel();
            this.tbnumberSecuence = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.opPanel.SuspendLayout();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // openTitle1
            // 
            this.openTitle1.BackColor = System.Drawing.Color.Transparent;
            this.openTitle1.Caption = "   Datos";
            this.openTitle1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openTitle1.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.openTitle1.Location = new System.Drawing.Point(0, 52);
            this.openTitle1.Name = "openTitle1";
            this.openTitle1.Size = new System.Drawing.Size(402, 54);
            this.openTitle1.TabIndex = 5;
            this.openTitle1.TabStop = false;
            // 
            // opPanel
            // 
            this.opPanel.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(122)))), ((int)(((byte)(150)))), ((int)(((byte)(223)))));
            this.opPanel.Controls.Add(this.btnCancel);
            this.opPanel.Controls.Add(this.btnGenerar);
            this.opPanel.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.opPanel.Location = new System.Drawing.Point(0, 157);
            this.opPanel.Name = "opPanel";
            this.opPanel.Size = new System.Drawing.Size(402, 28);
            this.opPanel.TabIndex = 4;
            // 
            // btnCancel
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnCancel.Appearance = appearance1;
            this.btnCancel.Location = new System.Drawing.Point(319, 2);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(80, 25);
            this.btnCancel.TabIndex = 1;
            this.btnCancel.Text = "&Cancelar";
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnGenerar
            // 
            this.btnGenerar.Appearance = appearance1;
            this.btnGenerar.Location = new System.Drawing.Point(236, 2);
            this.btnGenerar.Name = "btnGenerar";
            this.btnGenerar.Size = new System.Drawing.Size(80, 25);
            this.btnGenerar.TabIndex = 0;
            this.btnGenerar.Text = "&Generar";
            this.btnGenerar.Click += new System.EventHandler(this.btnGenerar_Click);
            // 
            // openHeaderTitles1
            // 
            this.openHeaderTitles1.BackColor = System.Drawing.Color.White;
            this.openHeaderTitles1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openHeaderTitles1.HeaderProtectedFields = ((System.Collections.Generic.Dictionary<string, string>)(resources.GetObject("openHeaderTitles1.HeaderProtectedFields")));
            this.openHeaderTitles1.HeaderSubtitle1 = "Reimpresión de Facturas Grandes Superficies";
            this.openHeaderTitles1.HeaderTitle = "Reimpresión de Facturas Grandes Superficies";
            this.openHeaderTitles1.Location = new System.Drawing.Point(0, 0);
            this.openHeaderTitles1.MaxWidth = -1;
            this.openHeaderTitles1.Name = "openHeaderTitles1";
            this.openHeaderTitles1.ParsedHeaderSubtitle2 = "";
            this.openHeaderTitles1.RowInformationHeader = null;
            this.openHeaderTitles1.Size = new System.Drawing.Size(402, 52);
            this.openHeaderTitles1.TabIndex = 3;
            this.openHeaderTitles1.TabStop = false;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.tbnumberSecuence);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(0, 106);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(402, 51);
            this.panel1.TabIndex = 6;
            // 
            // tbnumberSecuence
            // 
            this.tbnumberSecuence.TypeBox = OpenSystems.Windows.Controls.TypesBox.Numeric;
            this.tbnumberSecuence.Caption = "Consecutivo de Venta";
            this.tbnumberSecuence.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbnumberSecuence.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbnumberSecuence.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbnumberSecuence.Length = null;
            this.tbnumberSecuence.TextBoxValue = null;
            this.tbnumberSecuence.Location = new System.Drawing.Point(206, 26);
            this.tbnumberSecuence.Name = "tbnumberSecuence";
            this.tbnumberSecuence.Size = new System.Drawing.Size(143, 20);
            this.tbnumberSecuence.TabIndex = 1;
            // 
            // LDIBO
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(402, 185);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.openTitle1);
            this.Controls.Add(this.opPanel);
            this.Controls.Add(this.openHeaderTitles1);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(418, 223);
            this.MinimumSize = new System.Drawing.Size(418, 223);
            this.Name = "LDIBO";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Reimpresión de Facturas Grandes Superficies (LDIBO)";
            this.opPanel.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private OpenSystems.Windows.Controls.OpenTitle openTitle1;
        private System.Windows.Forms.Panel opPanel;
        private OpenSystems.Windows.Controls.OpenButton btnCancel;
        private OpenSystems.Windows.Controls.OpenButton btnGenerar;
        private OpenSystems.Windows.Controls.OpenHeaderTitles openHeaderTitles1;
        private System.Windows.Forms.Panel panel1;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbnumberSecuence;
    }
}