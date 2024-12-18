namespace LODPDT.UI
{
    partial class frm_texto
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
            this.btn_boton = new System.Windows.Forms.Button();
            this.txt_texto = new System.Windows.Forms.TextBox();
            this.btn_cancelar = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btn_boton
            // 
            this.btn_boton.Location = new System.Drawing.Point(191, 194);
            this.btn_boton.Name = "btn_boton";
            this.btn_boton.Size = new System.Drawing.Size(75, 23);
            this.btn_boton.TabIndex = 2;
            this.btn_boton.Text = "button1";
            this.btn_boton.UseVisualStyleBackColor = true;
            this.btn_boton.Click += new System.EventHandler(this.btn_boton_Click);
            // 
            // txt_texto
            // 
            this.txt_texto.Location = new System.Drawing.Point(12, 12);
            this.txt_texto.Multiline = true;
            this.txt_texto.Name = "txt_texto";
            this.txt_texto.Size = new System.Drawing.Size(514, 176);
            this.txt_texto.TabIndex = 3;
            // 
            // btn_cancelar
            // 
            this.btn_cancelar.Location = new System.Drawing.Point(272, 194);
            this.btn_cancelar.Name = "btn_cancelar";
            this.btn_cancelar.Size = new System.Drawing.Size(75, 23);
            this.btn_cancelar.TabIndex = 4;
            this.btn_cancelar.Text = "Cancelar";
            this.btn_cancelar.UseVisualStyleBackColor = true;
            this.btn_cancelar.Click += new System.EventHandler(this.btn_cancelar_Click);
            // 
            // FRMTEXTO
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(538, 228);
            this.ControlBox = false;
            this.Controls.Add(this.btn_cancelar);
            this.Controls.Add(this.txt_texto);
            this.Controls.Add(this.btn_boton);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frm_texto";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "texto";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.frm_texto_FormClosed);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btn_boton;
        private System.Windows.Forms.TextBox txt_texto;
        private System.Windows.Forms.Button btn_cancelar;

    }
}