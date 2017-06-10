using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core;
using FashionAde.Core.Accounts;
using FashionAde.Core.Clothing;
using FashionAde.Core.DataInterfaces;
using FashionAde.Data.NHibernateMaps;
using FashionAde.Data.Repository;
using FashionAde.Services;
using NUnit.Framework;
using SharpArch.Data.NHibernate;
using SharpArch.Testing.NHibernate;

namespace FashionAde.TestsUsingDevDatabase.FashionAde.Data
{
    public class OutfitEngineServiceTest
    {
        [Test]
        public void TestPerCall()
        {
            for (int i = 1; i < 50; i++)
            {
                var test = new OutfitEngineService.OutfitEngineServiceClient();
                test.CreateOutfits(i);
                test.InnerChannel.Close();
            }
        }
    }
}
