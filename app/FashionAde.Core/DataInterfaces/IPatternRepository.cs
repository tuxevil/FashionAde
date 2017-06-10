﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Clothing;
using FashionAde.Core.ThirdParties;
using SharpArch.Core.PersistenceSupport;

namespace FashionAde.Core.DataInterfaces
{
    public interface IPatternRepository : IRepository<Pattern>
    {
        Pattern GetSolid();
        IList<PatternKeywordsByPartner> GetKeywordsByPartner(Partner partner);
        Pattern GetByDescription(string description);
    }
}
