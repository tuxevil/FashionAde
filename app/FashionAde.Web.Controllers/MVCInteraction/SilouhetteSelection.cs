using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Clothing;

namespace FashionAde.Web.Controllers.MVCInteraction
{
    public class SilouhetteSelection
    {
        private IList<Pattern> patterns;
        private IList<Fabric> fabrics;
        private int fabricId;

        public IList<Pattern> Patterns
        {
            get { return patterns; }
            set { patterns = value; }
        }

        public IList<Fabric> Fabrics
        {
            get { return fabrics; }
            set { fabrics = value; }
        }

        public int FabricId
        {
            get { return fabricId; }
            set { fabricId = value; }
        }

        public SilouhetteSelection() {}

        public SilouhetteSelection(IList<Pattern> patterns, IList<Fabric> fabrics)
        {
            this.patterns = patterns;
            this.fabrics = fabrics;
        }
    }
}
