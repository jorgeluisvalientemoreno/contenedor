namespace SINCECOMP.FNB.UI
{
    partial class LDRAV
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LDRAV));
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            this.openTitle1 = new OpenSystems.Windows.Controls.OpenTitle();
            this.openHeaderTitles1 = new OpenSystems.Windows.Controls.OpenHeaderTitles();
            this.ultraGroupBox1 = new Infragistics.Win.Misc.UltraGroupBox();
            this.btnProcess = new OpenSystems.Windows.Controls.OpenButton();
            this.btnCancel = new OpenSystems.Windows.Controls.OpenButton();
            this.ultraLabel1 = new Infragistics.Win.Misc.UltraLabel();
            this.tbNumberSecuence = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.oSTBSolVenta = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).BeginInit();
            this.ultraGroupBox1.SuspendLayout();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // openTitle1
            // 
            this.openTitle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.openTitle1.Caption = "   Datos";
            this.openTitle1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openTitle1.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.openTitle1.Location = new System.Drawing.Point(0, 50);
            this.openTitle1.Name = "openTitle1";
            this.openTitle1.Size = new System.Drawing.Size(611, 46);
            this.openTitle1.TabIndex = 33;
            this.openTitle1.TabStop = false;
            // 
            // openHeaderTitles1
            // 
            this.openHeaderTitles1.BackColor = System.Drawing.Color.White;
            this.openHeaderTitles1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openHeaderTitles1.HeaderProtectedFields = ((System.Collections.Generic.Dictionary<string, string>)(resources.GetObject("openHeaderTitles1.HeaderProtectedFields")));
            this.openHeaderTitles1.HeaderSubtitle1 = "Reimpresión Archivo de Venta";
            this.openHeaderTitles1.HeaderTitle = "Reimpresión Archivo de Venta";
            this.openHeaderTitles1.Location = new System.Drawing.Point(0, 0);
            this.openHeaderTitles1.MaxWidth = -1;
            this.openHeaderTitles1.Name = "openHeaderTitles1";
            this.openHeaderTitles1.ParsedHeaderSubtitle2 = "";
            this.openHeaderTitles1.RowInformationHeader = null;
            this.openHeaderTitles1.Size = new System.Drawing.Size(611, 50);
            this.openHeaderTitles1.TabIndex = 32;
            this.openHeaderTitles1.TabStop = false;
            // 
            // ultraGroupBox1
            // 
            this.ultraGroupBox1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(122)))), ((int)(((byte)(150)))), ((int)(((byte)(223)))));
            this.ultraGroupBox1.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None;
            this.ultraGroupBox1.Controls.Add(this.btnProcess);
            this.ultraGroupBox1.Controls.Add(this.btnCancel);
            this.ultraGroupBox1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.ultraGroupBox1.Location = new System.Drawing.Point(0, 173);
            this.ultraGroupBox1.Name = "ultraGroupBox1";
            this.ultraGroupBox1.Size = new System.Drawing.Size(611, 28);
            this.ultraGroupBox1.SupportThemes = false;
            this.ultraGroupBox1.TabIndex = 55;
            // 
            // btnProcess
            // 
            appearance2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance2.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnProcess.Appearance = appearance2;
            this.btnProcess.Location = new System.Drawing.Point(424, 2);
            this.btnProcess.Name = "btnProcess";
            this.btnProcess.Size = new System.Drawing.Size(80, 25);
            this.btnProcess.TabIndex = 1;
            this.btnProcess.Text = "&Procesar";
            this.btnProcess.Click += new System.EventHandler(this.btnProcess_Click);
            // 
            // btnCancel
            // 
            //this.btnCancel.Appearance = appearance1;
            this.btnCancel.Location = new System.Drawing.Point(510, 2);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(80, 25);
            this.btnCancel.TabIndex = 0;
            this.btnCancel.Text = "&Cancelar";
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // ultraLabel1
            // 
            this.ultraLabel1.Location = new System.Drawing.Point(100, 31);
            this.ultraLabel1.Name = "ultraLabel1";
            this.ultraLabel1.Size = new System.Drawing.Size(162, 23);
            this.ultraLabel1.TabIndex = 56;
            this.ultraLabel1.Text = "Consecutivo de Venta";
            // 
            // tbNumberSecuence
            // 
            this.tbNumberSecuence.TypeBox = OpenSystems.Windows.Controls.TypesBox.Numeric;
            this.tbNumberSecuence.Caption = "";
            this.tbNumberSecuence.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbNumberSecuence.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbNumberSecuence.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbNumberSecuence.Length = null;
            this.tbNumberSecuence.TextBoxValue = null;
            this.tbNumberSecuence.Location = new System.Drawing.Point(262, 31);
            this.tbNumberSecuence.Name = "tbNumberSecuence";
            this.tbNumberSecuence.Size = new System.Drawing.Size(242, 20);
            this.tbNumberSecuence.TabIndex = 57;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.oSTBSolVenta);
            this.panel1.Controls.Add(this.ultraLabel1);
            this.panel1.Controls.Add(this.tbNumberSecuence);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(0, 96);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(611, 77);
            this.panel1.TabIndex = 59;
            // 
            // oSTBSolVenta
            // 
            this.oSTBSolVenta.TypeBox = OpenSystems.Windows.Controls.TypesBox.Numeric;
            this.oSTBSolVenta.Caption = "Solicitud Venta       ";
            this.oSTBSolVenta.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.oSTBSolVenta.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.oSTBSolVenta.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.oSTBSolVenta.Length = null;
            this.oSTBSolVenta.TextBoxValue = null;
            this.oSTBSolVenta.Location = new System.Drawing.Point(262, 6);
            this.oSTBSolVenta.Name = "oSTBSolVenta";
            this.oSTBSolVenta.Size = new System.Drawing.Size(242, 20);
            this.oSTBSolVenta.TabIndex = 61;
            this.oSTBSolVenta.Validating += new System.ComponentModel.CancelEventHandler(this.oSTBSolVenta_Validating);
            // 
            // LDRAV
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(611, 201);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.ultraGroupBox1);
            this.Controls.Add(this.openTitle1);
            this.Controls.Add(this.openHeaderTitles1);
            this.MaximizeBox = false;
            this.Name = "LDRAV";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Reimpresión Archivo de Venta (LDRAV)";
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).EndInit();
            this.ultraGroupBox1.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private OpenSystems.Windows.Controls.OpenTitle openTitle1;
        private OpenSystems.Windows.Controls.OpenHeaderTitles openHeaderTitles1;
        private Infragistics.Win.Misc.UltraGroupBox ultraGroupBox1;
        private OpenSystems.Windows.Controls.OpenButton btnProcess;
        private OpenSystems.Windows.Controls.OpenButton btnCancel;
        private Infragistics.Win.Misc.UltraLabel ultraLabel1;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbNumberSecuence;
        private System.Windows.Forms.Panel panel1;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox oSTBSolVenta;
    }
}