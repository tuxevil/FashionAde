﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.OutfitEngine;
using SharpArch.Data.NHibernate;
using NHibernate;

namespace FashionAde.Data.Repository
{
    public class PreGarmentRepository : Repository<PreGarment>, IPreGarmentRepository 
    {
    }
}
