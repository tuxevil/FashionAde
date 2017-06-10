using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FashionAde.Core.Views
{
    public class OutfitUpdaterView
    {
        public OutfitUpdaterView()
        {
        }

        public OutfitUpdaterView(int id, string name, string buyUrl, string imageUrl)
        {
            Id = id;
            Name = name;
            BuyUrl = buyUrl;
            ImageUrl = imageUrl;
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string BuyUrl { get; set; }
        public string ImageUrl { get; set; }
    }
}
