﻿namespace SINCECOMP.SUBSIDYS.UI
{
    partial class LDGDB
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LDGDB));
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            this.openHeaderTitles1 = new OpenSystems.Windows.Controls.OpenHeaderTitles();
            this.fbdDirectory = new System.Windows.Forms.FolderBrowserDialog();
            this.ultraGroupBox1 = new Infragistics.Win.Misc.UltraGroupBox();
            this.btnImport = new OpenSystems.Windows.Controls.OpenButton();
            this.tbProcess = new OpenSystems.Windows.Controls.OpenButton();
            this.lblArchiveubication = new Infragistics.Win.Misc.UltraLabel();
            this.tbArchiveubication = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.openTitle1 = new OpenSystems.Windows.Controls.OpenTitle();
            this.panel1 = new System.Windows.Forms.Panel();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).BeginInit();
            this.ultraGroupBox1.SuspendLayout();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // openHeaderTitles1
            // 
            this.openHeaderTitles1.BackColor = System.Drawing.Color.White;
            this.openHeaderTitles1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openHeaderTitles1.HeaderProtectedFields = ((System.Collections.Generic.Dictionary<string, string>)(resources.GetObject("openHeaderTitles1.HeaderProtectedFields")));
            this.openHeaderTitles1.HeaderSubtitle1 = "Generación de duplicados de facturas de ventas";
            this.openHeaderTitles1.HeaderTitle = "Generación de duplicados de facturas de ventas";
            this.openHeaderTitles1.Location = new System.Drawing.Point(0, 0);
            this.openHeaderTitles1.MaxWidth = -1;
            this.openHeaderTitles1.Name = "openHeaderTitles1";
            this.openHeaderTitles1.ParsedHeaderSubtitle2 = "";
            this.openHeaderTitles1.RowInformationHeader = null;
            this.openHeaderTitles1.Size = new System.Drawing.Size(462, 53);
            this.openHeaderTitles1.TabIndex = 39;
            // 
            // ultraGroupBox1
            // 
            this.ultraGroupBox1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(122)))), ((int)(((byte)(150)))), ((int)(((byte)(223)))));
            this.ultraGroupBox1.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None;
            this.ultraGroupBox1.Controls.Add(this.btnImport);
            this.ultraGroupBox1.Controls.Add(this.tbProcess);
            this.ultraGroupBox1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.ultraGroupBox1.Location = new System.Drawing.Point(0, 138);
            this.ultraGroupBox1.Name = "ultraGroupBox1";
            this.ultraGroupBox1.Size = new System.Drawing.Size(462, 28);
            this.ultraGroupBox1.SupportThemes = false;
            this.ultraGroupBox1.TabIndex = 51;
            // 
            // btnImport
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnImport.Appearance = appearance1;
            this.btnImport.Location = new System.Drawing.Point(282, 1);
            this.btnImport.Name = "btnImport";
            this.btnImport.Size = new System.Drawing.Size(80, 25);
            this.btnImport.TabIndex = 56;
            this.btnImport.Text = "Importar";
            this.btnImport.Click += new System.EventHandler(this.btnImport_Click);
            // 
            // tbProcess
            // 
            this.tbProcess.Appearance = appearance1;
            this.tbProcess.Location = new System.Drawing.Point(363, 1);
            this.tbProcess.Name = "tbProcess";
            this.tbProcess.Size = new System.Drawing.Size(80, 25);
            this.tbProcess.TabIndex = 55;
            this.tbProcess.Text = "Procesar";
            this.tbProcess.Click += new System.EventHandler(this.tbProcess_Click);
            // 
            // lblArchiveubication
            // 
            appearance2.TextHAlign = Infragistics.Win.HAlign.Right;
            this.lblArchiveubication.Appearance = appearance2;
            this.lblArchiveubication.Location = new System.Drawing.Point(20, 6);
            this.lblArchiveubication.Name = "lblArchiveubication";
            this.lblArchiveubication.Size = new System.Drawing.Size(129, 23);
            this.lblArchiveubication.TabIndex = 54;
            this.lblArchiveubication.Text = "Ruta de archivos";
            // 
            // tbArchiveubication
            // 
            this.tbArchiveubication.Caption = "";
            this.tbArchiveubication.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbArchiveubication.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbArchiveubication.ReadOnly = true;
            this.tbArchiveubication.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbArchiveubication.Length = null;
            this.tbArchiveubication.TextBoxValue = "";
            this.tbArchiveubication.Location = new System.Drawing.Point(155, 6);
            this.tbArchiveubication.Name = "tbArchiveubication";
            this.tbArchiveubication.Size = new System.Drawing.Size(279, 20);
            this.tbArchiveubication.TabIndex = 53;
            // 
            // openTitle1
            // 
            this.openTitle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.openTitle1.Caption = "   Datos";
            this.openTitle1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openTitle1.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.openTitle1.Location = new System.Drawing.Point(0, 53);
            this.openTitle1.Name = "openTitle1";
            this.openTitle1.Size = new System.Drawing.Size(462, 39);
            this.openTitle1.TabIndex = 56;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.lblArchiveubication);
            this.panel1.Controls.Add(this.tbArchiveubication);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel1.Location = new System.Drawing.Point(0, 92);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(462, 34);
            this.panel1.TabIndex = 58;
            // 
            // LDGDB
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(462, 166);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.openTitle1);
            this.Controls.Add(this.ultraGroupBox1);
            this.Controls.Add(this.openHeaderTitles1);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(470, 200);
            this.MinimumSize = new System.Drawing.Size(470, 200);
            this.Name = "LDGDB";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Generación de duplicados de facturas de ventas (LDGDB)";
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).EndInit();
            this.ultraGroupBox1.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private OpenSystems.Windows.Controls.OpenHeaderTitles openHeaderTitles1;
        private System.Windows.Forms.FolderBrowserDialog fbdDirectory;
        private Infragistics.Win.Misc.UltraGroupBox ultraGroupBox1;
        private OpenSystems.Windows.Controls.OpenButton btnImport;
        private OpenSystems.Windows.Controls.OpenButton tbProcess;
        private Infragistics.Win.Misc.UltraLabel lblArchiveubication;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbArchiveubication;
        private OpenSystems.Windows.Controls.OpenTitle openTitle1;
        private System.Windows.Forms.Panel panel1;
    }
}