using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FileHelpers.RunTime;

namespace FashionAde.OutfitUpdaterImportation
{
    public class SaksImporter : DelimitedFilePipeImporter
    {
        public override string FileName
        {
            get { return "13816_2389515_mp.txt"; }
        }

        public override string PartnerCode
        {
            get { return "SFA"; }
        }

        protected override void AddFields(DelimitedClassBuilder cb)
        {
            cb.AddField("Sku", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Name", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("ExternalCode", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Gender", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Artist", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("BuyUrl", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("ImageUrl", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Empty1", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Description", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("ProgramName", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.LastField.FieldNullValue = "SaksFifthAvenue";
            cb.AddField("Keywords", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Amount", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("RetailPrice", typeof(string));
            cb.LastField.FieldNullValue = null;
            cb.LastField.FieldOptional = true;
            cb.AddField("Price", typeof(string));
            cb.LastField.FieldNullValue = null;
            cb.LastField.FieldOptional = true;
            cb.AddField("Empty3", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Empty4", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Manufacturer", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Empty5", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Empty6", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("UnknowCode1", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Manufacturer2", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Empty7", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Empty8", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("UnknowCode2", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Empty9", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Currency", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("Empty10", typeof(string));
            cb.LastField.FieldOptional = true;
            cb.AddField("ImpressionUrl", typeof(string));
            cb.LastField.FieldOptional = true;
        }
    }
}
