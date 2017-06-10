using System.Web.Mvc;
using FashionAde.Core;
using FashionAde.Core.Clothing;
using FashionAde.Core.FlavorSelection;
using System.IO;

namespace FashionAde.Web.Controllers.MVCInteraction
{
    public static class Resources
    {
        public static string GetRootPath()
        {
            return "/res";
        }

        public static string GetPath(string type, string imageUri)
        {
            return GetRootPath() + "/" + type + "/" + imageUri;
        }

        public static string GetFashionFlavorThumbnailPath(FashionFlavor fashionFlavor)
        {
            string fileName = Path.GetFileNameWithoutExtension(fashionFlavor.Image);
            string ext = Path.GetExtension(fashionFlavor.Image);
            return GetRootPath() + "/FashionFlavors/" + fileName + "_small" + ext;
        }

        public static string GetFashionFlavorPath(FashionFlavor fashionFlavor)
        {
            return GetRootPath() + "/FashionFlavors/" + fashionFlavor.Image;
        }

        public static string GetEventTypePath(EventType eventType)
        {
            return GetRootPath() + "/EventTypes/" + eventType.Image;
        }

        public static string GetSilouhettePath(Silouhette silouhette)
        {
            return GetRootPath() + "/Silouhettes/" + silouhette.ImageUri;            
        }

        public static string GetGarmentPath(Garment garment)
        {
            return GetRootPath() + "/Garments/" + garment.ImageUri;
        }

        public static string GetPatternPath(Pattern pattern)
        {
            return GetRootPath() + "/Patterns/" + pattern.ImageUri;
        }

        public static string GetStylePhotographPath(StylePhotograph stylePhotograph)
        {
            return GetRootPath() + "/StylePhotographs/" + stylePhotograph.ImageUri;
        }

        public static string GetBrandSetPath(BrandSet brandSet)
        {
            return GetRootPath() + "/BrandSets/" + brandSet.ImageUri;
        }

        public static string GetWordingPath(Wording wording)
        {
            return GetRootPath() + "/Wordings/" + wording.ImageUri;
        }

        public static string GetFashionResultPath(Wording wording)
        {
            return GetRootPath() + "/Wordings/" + wording.ImageUri;
        }
    }
}


