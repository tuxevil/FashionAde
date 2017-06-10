﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Accounts;
using SharpArch.Core.PersistenceSupport;

namespace FashionAde.Core.DataInterfaces
{
    public interface ISecurityQuestionRepository : IRepository<SecurityQuestion>
    {
        SecurityQuestion GetByDescription(string description);
    }
}
