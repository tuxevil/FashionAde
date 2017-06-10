using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace FashionAde.Utils
{
    public class StringHelper
    {
        public static readonly RegexOptions Options = RegexOptions.IgnorePatternWhitespace | RegexOptions.Singleline;

        public static string RemoveExtraSpaces(string text)
        {
            Regex regex = new Regex(@"\s{2,}", Options);
            text = regex.Replace(text.Trim(), " ");
            regex = new Regex(@"\s(\!|\.|\?|\;|\,|\:)");
            text = regex.Replace(text, "$1");
            return text;

        }

        public static bool IsNumber(string text)
        {
            Array chars = text.ToCharArray();
            foreach (char c in chars)
                if (!char.IsNumber(c))
                    return false;

            return true;
        }

        public static bool IsDateTime(string date)
        {
            try
            {
                Convert.ToDateTime(date);
                return true;
            }
            catch (Exception)
            {
                try
                {
                    IFormatProvider formatProvider = new CultureInfo("en-US");
                    Convert.ToDateTime(date, formatProvider);
                    return true;
                }
                catch (Exception)
                {
                    return false;
                }
            }
        }
    }
}
