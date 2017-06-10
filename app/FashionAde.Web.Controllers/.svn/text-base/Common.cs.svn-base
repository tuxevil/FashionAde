using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.Mvc;

namespace FashionAde.Web.Controllers
{
    public class Common
    {
        public static List<SelectListItem> Paging(int totalCount, int currentPage, int pageSize, int pageCount)
        {
            if (totalCount == 0)
                return new List<SelectListItem>();

            if (currentPage == -1)
                if (totalCount % pageSize > 0)
                    currentPage = (totalCount / pageSize) + 1;
                else
                    currentPage = (totalCount / pageSize);

            List<SelectListItem> pages = new List<SelectListItem>();
            SelectListItem page;
            int indexselected = 0;
            int j = 1;
            for (int i = 1; i < totalCount; i += pageSize)
            {
                page = new SelectListItem();
                page.Value = j.ToString();
                page.Selected = j == currentPage;
                if (i + (pageSize - 1) < totalCount)
                    page.Text = i + " - " + (i + (pageSize - 1));
                else
                    page.Text = i + " - " + totalCount;
                pages.Add(page);

                if (page.Selected)
                    indexselected = j;
                j++;
            }
            int k = 0;
            for (int i = indexselected - 5; k < pageSize; i++)
            {
                if (i >= 0 && i + pageSize <= pages.Count)
                {
                    k = i;
                    break;
                }
                else if (i >= 0)
                {
                    k = pages.Count - pageSize;
                }
                else
                    break;
            }
            if (pages.Count > pageCount)
                return pages.GetRange(k, pageCount);
            return pages.GetRange(k, pages.Count);
        }

        static byte[] bytes = ASCIIEncoding.ASCII.GetBytes("ZeroCool");
        public static string Encrypt(string originalString)
        {
            if (String.IsNullOrEmpty(originalString))
            {
                throw new ArgumentNullException
                       ("The string which needs to be encrypted can not be null.");
            }
            DESCryptoServiceProvider cryptoProvider = new DESCryptoServiceProvider();
            MemoryStream memoryStream = new MemoryStream();
            CryptoStream cryptoStream = new CryptoStream(memoryStream,
                cryptoProvider.CreateEncryptor(bytes, bytes), CryptoStreamMode.Write);
            StreamWriter writer = new StreamWriter(cryptoStream);
            writer.Write(originalString);
            writer.Flush();
            cryptoStream.FlushFinalBlock();
            writer.Flush();
            return Convert.ToBase64String(memoryStream.GetBuffer(), 0, (int)memoryStream.Length);
        }

        public static string Decrypt(string cryptedString)
        {
            if (String.IsNullOrEmpty(cryptedString))
            {
                throw new ArgumentNullException
                   ("The string which needs to be decrypted can not be null.");
            }
            DESCryptoServiceProvider cryptoProvider = new DESCryptoServiceProvider();
            MemoryStream memoryStream = new MemoryStream
                    (Convert.FromBase64String(cryptedString));
            CryptoStream cryptoStream = new CryptoStream(memoryStream,
                cryptoProvider.CreateDecryptor(bytes, bytes), CryptoStreamMode.Read);
            StreamReader reader = new StreamReader(cryptoStream);
            return reader.ReadToEnd();
        }
    }
}
