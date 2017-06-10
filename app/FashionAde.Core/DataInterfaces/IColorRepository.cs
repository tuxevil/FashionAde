﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Clothing;
using SharpArch.Core.PersistenceSupport;

namespace FashionAde.Core.DataInterfaces
{
    public interface IColorRepository : IRepository<Color>
    {
        Color GetByDescription(string description);
    }
}
