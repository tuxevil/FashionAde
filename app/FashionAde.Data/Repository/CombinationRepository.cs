using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.MVCInteraction;
using NHibernate;
using NHibernate.Criterion;
using SharpArch.Core.PersistenceSupport;
using SharpArch.Data.NHibernate;
using FashionAde.Core.OutfitCombination;

namespace FashionAde.Data.Repository
{
    public class CombinationRepository : Repository<Combination>, ICombinationRepository
    {
        
    }
}
