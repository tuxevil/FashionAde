using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Clothing;
using FashionAde.Web.Controllers.MVCInteraction;
using NUnit.Framework;

namespace Tests.FashionAde.Core
{
    [TestFixture]
    public class CurrentSeason
    {
        [Test]
        public void CanFoundCorrectSeason()
        {
            DateTime currDate = new DateTime(2010, 1, 1);
            Assert.IsTrue(Season.Winter == SeasonHelper.GetCurrentSeason(currDate));

            currDate = new DateTime(2010, 4, 1);
            Assert.IsTrue(Season.Spring == SeasonHelper.GetCurrentSeason(currDate));

            currDate = new DateTime(2010, 9, 21);
            Assert.IsTrue(Season.Fall == SeasonHelper.GetCurrentSeason(currDate));

            currDate = new DateTime(2010, 8, 24);
            Assert.IsTrue(Season.Summer == SeasonHelper.GetCurrentSeason(currDate));
        }
    }
}
