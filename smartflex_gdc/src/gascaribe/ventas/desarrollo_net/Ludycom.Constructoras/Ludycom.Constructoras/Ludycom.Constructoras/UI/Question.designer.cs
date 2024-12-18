namespace Ludycom.Constructoras.UI
{
    partial class Question
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
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            this.btnopc3 = new OpenSystems.Windows.Controls.OpenButton();
            this.panel1 = new System.Windows.Forms.Panel();
            this.btnopc2 = new OpenSystems.Windows.Controls.OpenButton();
            this.btnopc1 = new OpenSystems.Windows.Controls.OpenButton();
            this.lblMessage = new Infragistics.Win.Misc.UltraLabel();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnopc3
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnopc3.Appearance = appearance1;
            this.btnopc3.Location = new System.Drawing.Point(252, 1);
            this.btnopc3.Name = "btnopc3";
            this.btnopc3.Size = new System.Drawing.Size(80, 25);
            this.btnopc3.TabIndex = 2;
            this.btnopc3.Click += new System.EventHandler(this.btnopc3_Click);
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(122)))), ((int)(((byte)(150)))), ((int)(((byte)(223)))));
            this.panel1.Controls.Add(this.btnopc3);
            this.panel1.Controls.Add(this.btnopc2);
            this.panel1.Controls.Add(this.btnopc1);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panel1.Location = new System.Drawing.Point(0, 78);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(338, 28);
            this.panel1.TabIndex = 3;
            // 
            // btnopc2
            // 
            this.btnopc2.Appearance = appearance1;
            this.btnopc2.Location = new System.Drawing.Point(169, 1);
            this.btnopc2.Name = "btnopc2";
            this.btnopc2.Size = new System.Drawing.Size(80, 25);
            this.btnopc2.TabIndex = 1;
            this.btnopc2.Click += new System.EventHandler(this.btnopc2_Click);
            // 
            // btnopc1
            // 
            this.btnopc1.Appearance = appearance1;
            this.btnopc1.Location = new System.Drawing.Point(86, 1);
            this.btnopc1.Name = "btnopc1";
            this.btnopc1.Size = new System.Drawing.Size(80, 25);
            this.btnopc1.TabIndex = 0;
            this.btnopc1.Click += new System.EventHandler(this.btnopc1_Click);
            // 
            // lblMessage
            // 
            this.lblMessage.Location = new System.Drawing.Point(0, 0);
            this.lblMessage.Name = "lblMessage";
            this.lblMessage.Size = new System.Drawing.Size(322, 73);
            this.lblMessage.TabIndex = 4;
            // 
            // Question
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(338, 106);
            this.ControlBox = false;
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.lblMessage);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(354, 144);
            this.MinimizeBox = false;
            this.Name = "Question";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Question";
            this.panel1.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private OpenSystems.Windows.Controls.OpenButton btnopc3;
        private System.Windows.Forms.Panel panel1;
        private OpenSystems.Windows.Controls.OpenButton btnopc2;
        private OpenSystems.Windows.Controls.OpenButton btnopc1;
        private Infragistics.Win.Misc.UltraLabel lblMessage;
    }
}