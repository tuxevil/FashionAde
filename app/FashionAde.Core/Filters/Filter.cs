using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SharpArch.Core.DomainModel;
using FashionAde.Core.Accounts;

namespace FashionAde.Core.Filters
{
    /// <summary>
    /// Indicates a filter created by the user.
    /// </summary>
    public class Filter : Entity
    {
        public virtual string Name { get; set; }
        public virtual RegisteredUser User { get; set; }
        public virtual bool IsDeleted { get; set; }

        private IList<FilterSelection> _selections = new List<FilterSelection>();
        public virtual IList<FilterSelection> Selections
        {
            get { return _selections; }
            set { _selections = value; }
        }

        public virtual void ClearSelections()
        {
            Selections.Clear();
        }

        public virtual void MarkAsDeleted()
        {
            IsDeleted = true;
        }

        public virtual void AddSelection(string group, string key)
        {
            FilterSelection fs = new FilterSelection { Group = group, Key = key };
            if (!Selections.Contains(fs))
                Selections.Add(fs);
        }

        public virtual void RemoveSelection(string group, string key)
        {
            FilterSelection fs = new FilterSelection { Group = group, Key = key };
            if (Selections.Contains(fs))
                Selections.Remove(fs);
        }
    }
}
