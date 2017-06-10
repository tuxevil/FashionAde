using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Accounts;
using FashionAde.Core.Clothing;

namespace FashionAde.Core.Services
{
    public interface IGarmentUploaderService
    {
        RegisteredUser user { get; set; }
        string Description { get; set;  }
        string fileName { get; set; }
        byte[] fileContent { get; set; }
        IPhotoProcessorService photoProcessor { get; set; }

        UserPicture UploadPicture();
    }
}
