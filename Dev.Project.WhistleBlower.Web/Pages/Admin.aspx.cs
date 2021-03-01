using Dev.Project.WhistleBlower.Web.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Dev.Project.WhistleBlower.Web.Pages
{
    public partial class Admin : System.Web.UI.Page
    {
        private static Random random = new Random();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnEncrypt_Click(object sender, EventArgs e)
        {
            var strEncryptred = Cipher.Encrypt(txtTobeEncrypt.Text, "");
            txtEncryptedValue.Text = strEncryptred;
        }

        protected void btnDecrypt_Click(object sender, EventArgs e)
        {
            var strDecrypted = Cipher.Decrypt(txtTobeDecrypt.Text, "");
            txtDecryptedValue.Text = strDecrypted;

        }
        public static string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            return new string(Enumerable.Repeat(chars, length)
                              .Select(s => s[random.Next(s.Length)]).ToArray());
        }

        protected void btnGenarteRandom_Click(object sender, EventArgs e)
        {
            string rText = RandomString(int.Parse(txtRandomNumber.Text)) + random.Next(100, 999);
            txtRandomString.Text = rText;
        }
    }
}