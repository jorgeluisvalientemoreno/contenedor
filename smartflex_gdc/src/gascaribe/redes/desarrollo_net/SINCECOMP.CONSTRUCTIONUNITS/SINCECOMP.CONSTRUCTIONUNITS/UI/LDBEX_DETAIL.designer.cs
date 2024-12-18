namespace SINCECOMP.CONSTRUCTIONUNITS.UI
{
    partial class LDBEX_DETAIL
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
            this.panel1 = new System.Windows.Forms.Panel();
            this.btnBack = new OpenSystems.Windows.Controls.OpenButton();
            this.opPpal = new System.Windows.Forms.Panel();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(122)))), ((int)(((byte)(150)))), ((int)(((byte)(223)))));
            this.panel1.Controls.Add(this.btnBack);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panel1.Location = new System.Drawing.Point(0, 447);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(891, 28);
            this.panel1.TabIndex = 85;
            // 
            // btnBack
            // 
            this.btnBack.Location = new System.Drawing.Point(788, 1);
            this.btnBack.Name = "btnBack";
            this.btnBack.Size = new System.Drawing.Size(80, 25);
            this.btnBack.TabIndex = 71;
            this.btnBack.Text = "Regresar";
            this.btnBack.Click += new System.EventHandler(this.btnBack_Click);
            // 
            // opPpal
            // 
            this.opPpal.Dock = System.Windows.Forms.DockStyle.Fill;
            this.opPpal.Location = new System.Drawing.Point(0, 0);
            this.opPpal.Name = "opPpal";
            this.opPpal.Size = new System.Drawing.Size(891, 447);
            this.opPpal.TabIndex = 86;
            // 
            // LDBEX_DETAIL
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(891, 475);
            this.Controls.Add(this.opPpal);
            this.Controls.Add(this.panel1);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "LDBEX_DETAIL";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "LDBEX_DETAIL";
            this.Load += new System.EventHandler(this.LDBEX_DETAIL_Load);
            this.panel1.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private OpenSystems.Windows.Controls.OpenButton btnBack;
        private System.Windows.Forms.Panel opPpal;
    }
}