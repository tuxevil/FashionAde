using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SharpArch.Core.DomainModel;

namespace FashionAde.Core.Clothing
{
    public class PreSilouhette : Entity
    {
        public virtual LayerCode Layer { get; set; }
        public virtual StructureType StructureType { get; set; }
        public virtual ShapeType ShapeType { get; set; }

        private IList<FashionFlavor> flavors = new List<FashionFlavor>();

        public virtual IList<FashionFlavor> Flavors 
        {
            get { return flavors; }
            set { flavors = value; }
        }
    }
}
