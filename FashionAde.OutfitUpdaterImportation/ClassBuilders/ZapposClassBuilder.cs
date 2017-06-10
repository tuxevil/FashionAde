using FileHelpers.RunTime;
using FileHelpers;
using System.Configuration;
using System.IO;
using System;
using System.Globalization;

namespace FashionAde.OutfitUpdaterImportation
{
    public delegate void FeedLineReadEventHandler(object sender, FeedLineReadEventArgs e);

    public class FeedLineReadEventArgs : EventArgs
    {
        public FeedLineReadEventArgs(ImportLine data) 
        {
            this.Data = data;
        }

        public ImportLine Data { get; protected set; }
    }

    public abstract class FeedImporter : IFeedImporter
    {
        public event FeedLineReadEventHandler FeedLineRead;

        public abstract string Separator { get; }
        public abstract string FileName { get; }
        public abstract string PartnerCode { get; }

        public virtual bool HaveHeader
        {
            get { return true; }
        }

        public virtual bool HaveFooter
        {
            get { return false; }
        }

        public abstract void ProcessFeed();

        protected virtual void OnLineFeedRead(FeedLineReadEventArgs e)
        {
            if (FeedLineRead != null)
                FeedLineRead(this, e);
        }

        protected void LineRead(ImportLine data) 
        {
            if (data != null)
                OnLineFeedRead(new FeedLineReadEventArgs(data));
        }
    }

    public abstract class DelimitedFileImporter : FeedImporter
    {
        private static string ImportPath = ConfigurationManager.AppSettings["OUImportation_Path"];

        public override void ProcessFeed()
        {
            DelimitedClassBuilder cb = new DelimitedClassBuilder("TmpOutfitUpdater", Separator);

            if (HaveHeader)
                cb.IgnoreFirstLines = 1;
            if (HaveFooter)
                cb.IgnoreLastLines = 1;

            AddFields(cb);

            cb.IgnoreEmptyLines = true;

            FileHelperAsyncEngine engine = new FileHelperAsyncEngine(cb.CreateRecordClass());
            engine.BeginReadFile(Path.Combine(ImportPath, this.FileName));

            while (engine.ReadNext() != null)
                LineRead(ConvertDataToLine(engine.LastRecord));
        }

        protected abstract void AddFields(DelimitedClassBuilder classBuilder);

        protected  ImportLine ConvertDataToLine(object data)
        {
            try
            {
                IFormatProvider formatProvider = new CultureInfo("en-US");

                ImportLine line = new ImportLine();
                line.ProgramName = GetValue("ProgramName", data).ToString();
                line.Name = GetValue("Name", data).ToString();
                line.Description = GetValue("Description", data).ToString();
                line.Keywords = GetValue("Keywords", data).ToString();
                line.Sku = GetValue("Sku", data).ToString();
                if (GetValue("Sku2", data) != null)
                    line.Sku += "-" + GetValue("Sku2", data);
                if (!string.IsNullOrEmpty(GetValue("Price", data).ToString()))
                    line.Price = Convert.ToDecimal(GetValue("Price", data).ToString(), formatProvider);
                line.BuyUrl = GetValue("BuyUrl", data).ToString();
                line.ImageUrl = GetValue("ImageUrl", data).ToString();
                if (GetValue("Gender", data) != null)
                    line.Gender = GetValue("Gender", data).ToString();
                else line.Gender = string.Empty;

                return line;
            }
            catch
            {
                return null;
            }
        }

        private object GetValue(string property, object o)
        {
            return o.GetType().GetField(property) == null ? null : o.GetType().GetField(property).GetValue(o);
        }

    }

    public abstract class DelimitedFileTabImporter : DelimitedFileImporter 
    {
        public override string Separator
        {
            get { return "\t"; }
        }
    }

    public abstract class DelimitedFilePipeImporter : DelimitedFileImporter
    {
        public override string Separator
        {
            get { return "|"; }
        }
    }

    public class ZapposImporter : DelimitedFileTabImporter
    {
        public override string FileName
        {
            get { return "Zappos_com-Product_Catalog_1.txt"; }
        }

        public override string  PartnerCode
        {
            get { return "ZP"; }
        }

        protected override void AddFields(DelimitedClassBuilder cb)
        {
            cb.AddField("ProgramName", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("ProgramUrl", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("CatalogName", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("LastUpdated", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Name", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Keywords", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Description", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Sku", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Manufacturer", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("ManufacturerId", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Upc", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Isbn", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Currency", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("SalePrice", typeof(string));
            cb.LastField.FieldNullValue = null;
            cb.LastField.FieldOptional = true;
            cb.AddField("Price", typeof(string));
            cb.LastField.FieldNullValue = null;
            cb.LastField.FieldOptional = true;
            cb.AddField("RetailPrice", typeof(string));
            cb.LastField.FieldNullValue = null;
            cb.LastField.FieldOptional = true;
            cb.AddField("FromPrice", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("BuyUrl", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("ImpressionUrl", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("ImageUrl", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Gender", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("ThirdPartyId", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("ThirdPartyCategory", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Author", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Artist", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Title", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Publisher", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Label", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Format", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Special", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Gift", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("PromotionalText", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("StartDate", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("EndDate", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("OffLine", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("OnLine", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("InStock", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Condition", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Warranty", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("StandardShippingCost", typeof(string));
            cb.LastField.FieldOptional = true;
        }
    }
}
