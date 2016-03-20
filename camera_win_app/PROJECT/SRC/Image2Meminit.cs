using System;
using System.Drawing;
using System.IO;
using System.Text;
using System.Windows.Forms;

namespace camera_win_app
{
    public partial class Image2Meminit
        : Form
    {
        private string fileName;

        private byte[] sourcePixels;

        private bool isImageLoaded;

        public Image2Meminit()
        {
            InitializeComponent();
        }

        private void Camera_Load(object sender, EventArgs e)
        {

        }

        private void btnSelectImage_Click(object sender, EventArgs e)
        {
            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                fileName = System.IO.Path.GetFileNameWithoutExtension(openFileDialog.FileName);

                Image img = Image.FromFile(openFileDialog.FileName);

                Bitmap bmp = new Bitmap(img);

                // Lock the bitmap's bits.  
                Rectangle rect = new Rectangle(0, 0, bmp.Width, bmp.Height);
                System.Drawing.Imaging.BitmapData bmpData =
                    bmp.LockBits(rect, System.Drawing.Imaging.ImageLockMode.ReadWrite, bmp.PixelFormat);

                // Get the address of the first line.
                IntPtr ptr = bmpData.Scan0;

                // Declare an array to hold the bytes of the bitmap.
                int bytes = Math.Abs(bmpData.Stride) * bmp.Height;
                sourcePixels = new byte[bytes];

                // Copy the RGB values into the array.
                System.Runtime.InteropServices.Marshal.Copy(ptr, sourcePixels, 0, bytes);

                picboxImage.Image = img;

                isImageLoaded = true;
            }
        }

        private void btnConvert_Click(object sender, EventArgs e)
        {
            if (isImageLoaded == true)
            {
                // convert RGB byte array to string
                StringBuilder sbFileContents = new StringBuilder(sourcePixels.Length * 2);

                for (uint i = 0U; i < sourcePixels.Length; i += 4U)
                {
                    sbFileContents.AppendFormat("{0:x2}{1:x2}{2:x2}", sourcePixels[i], sourcePixels[i + 1U], sourcePixels[i + 2U]);
                    sbFileContents.AppendLine();
                }

                // pick folder
                if (folderBrowserDialog.ShowDialog() == DialogResult.OK)
                {
                    // open output file
                    StringBuilder sbFilePath = new StringBuilder(256);
                    sbFilePath.Append(folderBrowserDialog.SelectedPath);
                    sbFilePath.Append("\\");
                    sbFilePath.Append(fileName);
                    sbFilePath.Append("_rgb24.meminit");

                    StreamWriter streamWriter = new StreamWriter(sbFilePath.ToString(), false);

                    streamWriter.Write(sbFileContents.ToString());

                    streamWriter.Close();
                }
            }
        }
    }
}
