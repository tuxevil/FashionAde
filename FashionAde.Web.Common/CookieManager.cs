using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.IO.Compression;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;

namespace FashionAde.Web.Common
{
    public static class CookieManager
    {
        public static bool Set(string cookieName, object cookieValue)
        {

            bool retval = true;

            try
            {
                BinaryFormatter bf = new BinaryFormatter();

                MemoryStream ms = new MemoryStream();

                bf.Serialize(ms, cookieValue);

                byte[] inbyt = ms.ToArray();

                System.IO.MemoryStream objStream = new MemoryStream();

                System.IO.Compression.DeflateStream objZS = new System.IO.Compression.DeflateStream(objStream, System.IO.Compression.CompressionMode.Compress);

                objZS.Write(inbyt, 0, inbyt.Length);

                objZS.Flush();

                objZS.Close();

                byte[] b = objStream.ToArray();

                string sCookieVal = Convert.ToBase64String(b);

                HttpCookie cook = new HttpCookie(cookieName);

                cook.Value = sCookieVal;

                cook.Expires = DateTime.Today.AddDays(30);

                HttpContext.Current.Response.Cookies.Add(cook);
            }

            catch
            {

                retval = false;

                throw;

            }

            return retval;

        }

        public static object Get(string cookieName)
        {

            object retval = null;

            try
            {
                if (string.IsNullOrEmpty(HttpContext.Current.Request.Cookies[cookieName].Value))
                    return null;

                byte[] bytCook = Convert.FromBase64String(HttpContext.Current.Request.Cookies[cookieName].Value);


                MemoryStream inMs = new MemoryStream(bytCook);

                inMs.Seek(0, 0);

                DeflateStream zipStream = new DeflateStream(inMs,
                                  CompressionMode.Decompress, true);

                byte[] outByt = ReadFullStream(zipStream);

                zipStream.Flush();

                zipStream.Close();

                MemoryStream outMs = new MemoryStream(outByt);

                outMs.Seek(0, 0);

                BinaryFormatter bf = new BinaryFormatter();

                retval = (object)bf.Deserialize(outMs, null);

            }

            catch (Exception ex)
            {

                throw ex;

            }

            return retval;

        }

        public static bool Has(string cookieName)
        {
            return (IsEnabled() && HttpContext.Current.Request.Cookies[cookieName] != null);
        }

        public static bool IsEnabled()
        {
            return (HttpContext.Current.Request.Browser.Cookies);
        }

        public static bool Delete(string cookieName)
        {

            bool retval = true;

            try
            {

                HttpContext.Current.Response.Cookies[cookieName].Expires =

                        DateTime.Now.AddDays(-365);

            }

            catch
            {

                retval = false;

            }

            return retval;

        }

        private static byte[] ReadFullStream(Stream stream)
        {

            byte[] buffer = new byte[32768];

            using (MemoryStream ms = new MemoryStream())
            {

                while (true)
                {

                    int read = stream.Read(buffer, 0, buffer.Length);

                    if (read <= 0)

                        return ms.ToArray();

                    ms.Write(buffer, 0, read);

                }

            }

        }
    }
}
