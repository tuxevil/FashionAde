using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FileHelpers.RunTime;

namespace FashionAde.OutfitUpdaterImportation
{
    public interface IFeedImporter
    {
        string Separator { get; }
        bool HaveHeader { get; }
        bool HaveFooter { get; }
        string FileName { get; }
        string PartnerCode { get; }

        void ProcessFeed();

        event FeedLineReadEventHandler FeedLineRead;
    }
}
